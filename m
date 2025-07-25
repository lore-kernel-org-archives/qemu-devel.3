Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E55C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 06:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufCAW-0005JM-0w; Fri, 25 Jul 2025 02:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufC63-0008Kt-2o
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 02:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufC5x-0003cl-OM
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 02:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753425591;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aw18Ri+vRPMoJlw3PDD35p9YtRVqu7F/ClYIxAYbxuo=;
 b=jLt4ah3UJfEL7O3lPMXglHITtNvcXVSBoN04/1nLN0SBI+Fv43Z39pLHbuYf1yLMTv/LGf
 yLa/i3nEoTNSC52Qe8hZgQL5m/vbH56enyJg1IkYHo5hnjaljc4cZmscY7AqnC7OITGVXb
 f4q0wqtxwLlq7O7zeN2hzEWe4AFK33o=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-iBNuXjfoNt-ovjCafunR4g-1; Fri, 25 Jul 2025 02:39:49 -0400
X-MC-Unique: iBNuXjfoNt-ovjCafunR4g-1
X-Mimecast-MFC-AGG-ID: iBNuXjfoNt-ovjCafunR4g_1753425588
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b38ec062983so1262034a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 23:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753425588; x=1754030388;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aw18Ri+vRPMoJlw3PDD35p9YtRVqu7F/ClYIxAYbxuo=;
 b=Qv0rPJKoibYKyXOI4Y22mz5NxwrUIApy2FmGqkqqNzl2QNk+l5y/gHqfWhpd1XxYT6
 gY9gSXQq1HmYTWi/27CgCUvXb/dRDQNG/bu36XMZBumtU0c1PL1njBxSQiJsjqqmOHlI
 15e+Fbzth3czVj6kvC1qTZDfXl0GIbV8/PNOcH/7X2sTbPfxPr+pned0yFR7JLqx2MmG
 6DBJTTwkGYsVAFF5MNj+g1XEdvYuzNrlJvoZleWMHR320pDH+KCl2SJr+WrAUHWSlV6A
 2fZjGoIuflAlrSm2Z9qvvnXnGmwvUqU2ETPm4EZUNoZDfzltjvodA5p2QIy3CcCEOcF+
 rqIA==
X-Gm-Message-State: AOJu0YyknMnS65G2pYqTif4YrcS5Mk8PKlEXPc+vNpccuprnABQau8wF
 2UJOhZoGsi6YIT3qNr1DWZNyOOG5/ERfTp+A/4M+3ijXWtlrov5CItou348aeCj+WVLE+yYY2Cm
 sqVeBqJjw5TWFcXUkZTbkxsoCJB64HYQnlqbG1XlS3WeiBaIYy0ph42zw
X-Gm-Gg: ASbGncvhlBAwnkKjeIYBnsH9Va2r1YcS6hD12mrXxMQc1Jxei/dzqVj9iYr8iCRb93j
 kQJUsrLzZV1+WGmrBrnJCUU2nA+SZFlkIjvHNDUvb6zTc5Rn5V0huddDtV5kl5wC9G7og666Rlu
 qQDdqG37kn/D4+OWkm1ObsdeFyjnyTAnBZ8SAMeeDuxcxO7KFu9ivLpN+2N4L1VYQ8RtyLSIdCS
 jUQIJhmQLs2Z/msUri9pFOazz+0bCXVxpoJX9DnKa7LYETeUSn9VjUWwtErG+H1MvFdbj375Tpf
 l6aJyXZgevlco/DHuxqjIt5rzFt/KwYFlSRmGQiK87oaKi5LLtCc
X-Received: by 2002:a05:6a20:12ca:b0:220:842f:2760 with SMTP id
 adf61e73a8af0-23d6ffd1231mr1308439637.4.1753425587778; 
 Thu, 24 Jul 2025 23:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExRJaEPRx7+8V2ZeoA8Mlbv3FlMpzjOHvN/T9ZLOiv/zgcXLgouNZprOq5bMWHkLXSmkh5og==
X-Received: by 2002:a05:6a20:12ca:b0:220:842f:2760 with SMTP id
 adf61e73a8af0-23d6ffd1231mr1308391637.4.1753425587290; 
 Thu, 24 Jul 2025 23:39:47 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.73])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761ae158001sm3107551b3a.31.2025.07.24.23.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 23:39:46 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:09:35 +0530
From: Arun Menon <armenon@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v6 23/24] migration: Add error-parameterized function
 variants in VMSD struct
Message-ID: <aIMmp1G6l4BtKmq3@armenon-kvm.bengluru.csb>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-23-fef740e15e17@redhat.com>
 <aH5BgAVc2x_tjsHJ@redhat.com>
 <aH5Gj61ZmtZ0NzEv@armenon-kvm.bengluru.csb>
 <aH5JR-58iMk0ArSl@redhat.com>
 <aH5YUmz5pAdxznAI@armenon-kvm.bengluru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aH5YUmz5pAdxznAI@armenon-kvm.bengluru.csb>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Daniel,

On Mon, Jul 21, 2025 at 08:40:10PM +0530, Arun Menon wrote:
> On Mon, Jul 21, 2025 at 03:05:59PM +0100, Daniel P. Berrangé wrote:
> > On Mon, Jul 21, 2025 at 07:24:23PM +0530, Arun Menon wrote:
> > > Hi,
> > > Thank you for the review.
> > > 
> > > On Mon, Jul 21, 2025 at 02:32:48PM +0100, Daniel P. Berrangé wrote:
> > > > On Mon, Jul 21, 2025 at 04:59:28PM +0530, Arun Menon wrote:
> > > > > - We need to have good error reporting in the callbacks in
> > > > >   VMStateDescription struct. Specifically pre_save, post_save,
> > > > >   pre_load and post_load callbacks.
> > > > > - It is not possible to change these functions everywhere in one
> > > > >   patch, therefore, we introduce a duplicate set of callbacks
> > > > >   with Error object passed to them.
> > > > > - So, in this commit, we implement 'errp' variants of these callbacks,
> > > > >   introducing an explicit Error object parameter.
> > > > > - This is a functional step towards transitioning the entire codebase
> > > > >   to the new error-parameterized functions.
> > > > > - Deliberately called in mutual exclusion from their counterparts,
> > > > >   to prevent conflicts during the transition.
> > > > > - New impls should preferentally use 'errp' variants of
> > > > >   these methods, and existing impls incrementally converted.
> > > > >   The variants without 'errp' are intended to be removed
> > > > >   once all usage is converted.
> > > > > 
> > > > > Signed-off-by: Arun Menon <armenon@redhat.com>
> > > > > ---
> > > > >  include/migration/vmstate.h | 11 +++++++++++
> > > > >  migration/vmstate.c         | 47 +++++++++++++++++++++++++++++++++++++++------
> > > > >  2 files changed, 52 insertions(+), 6 deletions(-)
> > > > > 
> > > > 
> > > > > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > > > > index 288b57e1ed778cce21247b64d5e97dfef41ad586..d96908d12ccffaef421e5d399a48e26cada2cb77 100644
> > > > > --- a/migration/vmstate.c
> > > > > +++ b/migration/vmstate.c
> > > > 
> > > > > @@ -524,7 +548,12 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> > > > >                  if (ret) {
> > > > >                      error_setg(errp, "Save of field %s/%s failed",
> > > > >                                  vmsd->name, field->name);
> > > > > -                    if (vmsd->post_save) {
> > > > > +                    if (vmsd->post_save_errp) {
> > > > > +                        ret = vmsd->post_save_errp(opaque, &local_err);
> > > > > +                        if (ret < 0) {
> > > > > +                            error_propagate(errp, local_err);
> > > > > +                        }
> > > > 
> > > > This is still broken. 'errp' is already set a few lines earlier, so you
> > > > can't propagate a new error over the top
> > > 
> > > I was wondering that we should preserve the first error that was encountered.
> > > So even if local_err was set, and in case errp already has an error, then it will
> > > be a no-op and local_err will be freed.
> > 
> > We know that 'local_err' is definitely set when 'post_save_errp' is called,
> > because there's a call to 'error_setg' right above it.
> 
> mmm, error_setg() above that sets errp, local_err is set only of post_save_errp() has
> errors. Do we want both the erros to be propagated? or is it okay to propagate the first
> error that was encountered.

I see your point. If we set errp, then there is no point in writing error_propagate()
because that will never allow local_err to be propagated because the first param is set.

I am intending to catch both the errors,
a. from vmstate_save_state_v() or explicitly set by us using error_setg(), in errp
b. from calling post_save_errp() , in local_err
and then, if we have both a and b, then we propagate  b.
and if we only have a, then a will be propagated.

I think this will be consistent with the original logic of setting the error using 
error_setg() and calling vmsd->post_save() only in the failure path. Please correct me
if I am wrong.

> > 
> > 
> > 
> > > > > +                    } else if (vmsd->post_save) {
> > > > >                          vmsd->post_save(opaque);
> > > > >                      }
> > 
> > ... pre-existing mistake not checking return value of
> > post_save.
> > 
> > > > >                      return ret;
> > > > > @@ -552,7 +581,13 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> > > > >  
> > > > >      ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
> > > > >  
> > > > > -    if (vmsd->post_save) {
> > > > > +    if (vmsd->post_save_errp) {
> > > > > +        int ps_ret = vmsd->post_save_errp(opaque, &local_err);
> > > > > +        if (!ret && ps_ret) {
> > > > > +            ret = ps_ret;
> > > > > +            error_propagate(errp, local_err);
> > > > > +        }
> > > > 
> > > > Again, propagating over the top of an existing error
> > > 
> > > Sorry, correct me if I am wrong.
> > > Since we have 'if (!ret && ps_ret)' ,
> > > if vmstate_subsection_save() fails, the above condition will not hold true.
> > > Only if the first function call vmstate_subsection_save() is successful and the second one
> > > post_save_errp() fails then we try to propagate, again hoping to preserve the first error.
> > 
> > Opps, yes, you're right - I missed the 'ps_ret' check. That means this
> > code is a memory leak when 'ret' is non-zero, as nothing frees 'local_err'
> > in that case.
> 
> Yes, maybe I can null check local_err and error_free() it.
> 
> > 
> > > 
> > > > 
> > > > > +    } else if (vmsd->post_save) {
> > > > >          int ps_ret = vmsd->post_save(opaque);
> > > > >          if (!ret && ps_ret) {
> > > > >              ret = ps_ret;
> > > > > 
> > > > > -- 
> > > > > 2.50.0
> > > > > 
> > > > > 
> > > > 
> > > > With regards,
> > > > Daniel
> > > > -- 
> > > > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> > > > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> > > > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> > > > 
> > > 
> > > Regards,
> > > Arun Menon
> > > 
> > 
> > With regards,
> > Daniel
> > -- 
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> > 
> Regards,
> Arun

Regards,
Arun



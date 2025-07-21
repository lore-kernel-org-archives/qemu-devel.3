Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A04FC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 15:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udsBV-0006x8-BP; Mon, 21 Jul 2025 11:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uds9u-0005C6-6l
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uds9r-0003s4-Or
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753110625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQPhtSh6LHNziGZZ3Dn6/mJrFkjjoiO27wusXTLcZmg=;
 b=VHBsp+KgpLZy0N7At0X3aZbgBkyHPrhEUcfKz5WhEutBrxSlA+3bZRts1Aa5D8ur2rTGQj
 KHhSYabRd+UhaN5Ze3EeqWRMPVQbovZeDPKSsqdl+ARMkxDME2sjefZNn4dYvHUA7OaCeD
 +hwUxeOgey1fl7qfiRjTjE1Iy9DBa8I=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-cE7c7ytfP-ir_fDHtq93iQ-1; Mon, 21 Jul 2025 11:10:23 -0400
X-MC-Unique: cE7c7ytfP-ir_fDHtq93iQ-1
X-Mimecast-MFC-AGG-ID: cE7c7ytfP-ir_fDHtq93iQ_1753110623
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b3f2e05fb78so2534213a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 08:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753110623; x=1753715423;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zQPhtSh6LHNziGZZ3Dn6/mJrFkjjoiO27wusXTLcZmg=;
 b=UhCu/qP2JVXHMPeV7Pd0e9g8W6Dy5AMs9SIfJwbWIZQB3byb4I0pgZxrl78JPbaoNl
 4OscK+6HA/wJLtVK0r0mAJAJ6Zl9yH52G5/9TxnBfWbnebiPKZbl532M9o5Ewytfvnhd
 FWTPIQn9Lejqci0H+yRQpmuvRVyZQUK/ZxycH0hzDV9qeb9hLnPVsvhZnLu18HiV9Svw
 5qiYVcPM3PGkzd3jVkI6EQfpVB6mq0rnKqEbj6HB+WSxZBZcxX1Vih46VnSjwhQP4jSF
 25c6Ww8EkvNgkVvgbkk8+vm+/tBM13UFigSPTqHHNQzPMjb+OUJVtMWMkiqA4yb8iEXs
 reSw==
X-Gm-Message-State: AOJu0YyeqsNMzrZzaj32u0LSziMnrJPP10m9eX2Ul3gaCPTF0IecBnf0
 o5zoAUSaoAQXVP0ZgZt0ICXQZd8KfoNP4WQ4HLwGy+tMjxdv6NJkyMbzd4Dx+vk6vrcVJwlzLK2
 SfI45+66ic1qO8GtmC+A9amN2Z+Neb2MK5TpM3JGk1H3AmohY06BbrNwT
X-Gm-Gg: ASbGncuEMTPzF2tZpV2WKq5xZ+OFfPHMMz1iZTOijE5zc3sBSlmcoxtKlcz6IzcFAc2
 udPXtErkOF0V+AsZFxhwBzQAU5NwnX0bVmi3KVyT5vqVsGj2Ij8PIuE9BzvMhbuaDGbFsH0r4Mk
 nv+IGvtTuqBKphRr1sN+Kg6nL0o21Sob6fnkhE3bB2EDioDIPQ6Smxt1uCJaNIwHPE6ttXrRkzq
 vnffyI28VCmGOH9DOorhNJcW8351CvYIbKS4Ae8shw2inVCu9NISoA9GF65aE4wm0AyCoTB348D
 DPMRvXjEd8cvCDL4vMhVGbAL4KEStWcYy6VKczfuqzKJ+/q9Pbgb
X-Received: by 2002:a05:6a21:e584:b0:1f5:95a7:8159 with SMTP id
 adf61e73a8af0-2381143f76cmr34470934637.10.1753110622671; 
 Mon, 21 Jul 2025 08:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwLhefVEPHLrLi8xCB3B2P2KQyUPlaUBmnYm42hloDRTsEkGdO0blnFWy/x5l59Iyj92+DVw==
X-Received: by 2002:a05:6a21:e584:b0:1f5:95a7:8159 with SMTP id
 adf61e73a8af0-2381143f76cmr34470854637.10.1753110622170; 
 Mon, 21 Jul 2025 08:10:22 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759c84e3a99sm5524160b3a.4.2025.07.21.08.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 08:10:21 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:40:10 +0530
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
Message-ID: <aH5YUmz5pAdxznAI@armenon-kvm.bengluru.csb>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-23-fef740e15e17@redhat.com>
 <aH5BgAVc2x_tjsHJ@redhat.com>
 <aH5Gj61ZmtZ0NzEv@armenon-kvm.bengluru.csb>
 <aH5JR-58iMk0ArSl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aH5JR-58iMk0ArSl@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 21, 2025 at 03:05:59PM +0100, Daniel P. Berrangé wrote:
> On Mon, Jul 21, 2025 at 07:24:23PM +0530, Arun Menon wrote:
> > Hi,
> > Thank you for the review.
> > 
> > On Mon, Jul 21, 2025 at 02:32:48PM +0100, Daniel P. Berrangé wrote:
> > > On Mon, Jul 21, 2025 at 04:59:28PM +0530, Arun Menon wrote:
> > > > - We need to have good error reporting in the callbacks in
> > > >   VMStateDescription struct. Specifically pre_save, post_save,
> > > >   pre_load and post_load callbacks.
> > > > - It is not possible to change these functions everywhere in one
> > > >   patch, therefore, we introduce a duplicate set of callbacks
> > > >   with Error object passed to them.
> > > > - So, in this commit, we implement 'errp' variants of these callbacks,
> > > >   introducing an explicit Error object parameter.
> > > > - This is a functional step towards transitioning the entire codebase
> > > >   to the new error-parameterized functions.
> > > > - Deliberately called in mutual exclusion from their counterparts,
> > > >   to prevent conflicts during the transition.
> > > > - New impls should preferentally use 'errp' variants of
> > > >   these methods, and existing impls incrementally converted.
> > > >   The variants without 'errp' are intended to be removed
> > > >   once all usage is converted.
> > > > 
> > > > Signed-off-by: Arun Menon <armenon@redhat.com>
> > > > ---
> > > >  include/migration/vmstate.h | 11 +++++++++++
> > > >  migration/vmstate.c         | 47 +++++++++++++++++++++++++++++++++++++++------
> > > >  2 files changed, 52 insertions(+), 6 deletions(-)
> > > > 
> > > 
> > > > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > > > index 288b57e1ed778cce21247b64d5e97dfef41ad586..d96908d12ccffaef421e5d399a48e26cada2cb77 100644
> > > > --- a/migration/vmstate.c
> > > > +++ b/migration/vmstate.c
> > > 
> > > > @@ -524,7 +548,12 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> > > >                  if (ret) {
> > > >                      error_setg(errp, "Save of field %s/%s failed",
> > > >                                  vmsd->name, field->name);
> > > > -                    if (vmsd->post_save) {
> > > > +                    if (vmsd->post_save_errp) {
> > > > +                        ret = vmsd->post_save_errp(opaque, &local_err);
> > > > +                        if (ret < 0) {
> > > > +                            error_propagate(errp, local_err);
> > > > +                        }
> > > 
> > > This is still broken. 'errp' is already set a few lines earlier, so you
> > > can't propagate a new error over the top
> > 
> > I was wondering that we should preserve the first error that was encountered.
> > So even if local_err was set, and in case errp already has an error, then it will
> > be a no-op and local_err will be freed.
> 
> We know that 'local_err' is definitely set when 'post_save_errp' is called,
> because there's a call to 'error_setg' right above it.

mmm, error_setg() above that sets errp, local_err is set only of post_save_errp() has
errors. Do we want both the erros to be propagated? or is it okay to propagate the first
error that was encountered.
> 
> 
> 
> > > > +                    } else if (vmsd->post_save) {
> > > >                          vmsd->post_save(opaque);
> > > >                      }
> 
> ... pre-existing mistake not checking return value of
> post_save.
> 
> > > >                      return ret;
> > > > @@ -552,7 +581,13 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> > > >  
> > > >      ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
> > > >  
> > > > -    if (vmsd->post_save) {
> > > > +    if (vmsd->post_save_errp) {
> > > > +        int ps_ret = vmsd->post_save_errp(opaque, &local_err);
> > > > +        if (!ret && ps_ret) {
> > > > +            ret = ps_ret;
> > > > +            error_propagate(errp, local_err);
> > > > +        }
> > > 
> > > Again, propagating over the top of an existing error
> > 
> > Sorry, correct me if I am wrong.
> > Since we have 'if (!ret && ps_ret)' ,
> > if vmstate_subsection_save() fails, the above condition will not hold true.
> > Only if the first function call vmstate_subsection_save() is successful and the second one
> > post_save_errp() fails then we try to propagate, again hoping to preserve the first error.
> 
> Opps, yes, you're right - I missed the 'ps_ret' check. That means this
> code is a memory leak when 'ret' is non-zero, as nothing frees 'local_err'
> in that case.

Yes, maybe I can null check local_err and error_free() it.

> 
> > 
> > > 
> > > > +    } else if (vmsd->post_save) {
> > > >          int ps_ret = vmsd->post_save(opaque);
> > > >          if (!ret && ps_ret) {
> > > >              ret = ps_ret;
> > > > 
> > > > -- 
> > > > 2.50.0
> > > > 
> > > > 
> > > 
> > > With regards,
> > > Daniel
> > > -- 
> > > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> > > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> > > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> > > 
> > 
> > Regards,
> > Arun Menon
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
Regards,
Arun



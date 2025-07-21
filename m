Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459C3C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqze-0008IO-5E; Mon, 21 Jul 2025 09:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udqyg-0000GV-0K
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udqyX-00027p-G8
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753106078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8o5Bm3wWMLp4H77dsj8AY3lkHEuc+o8Esh6grh2GqUI=;
 b=RpFWfO1YOpOYJ4fFZqsW0qMOqgaxKhVHXcWTpwhA8kgWQ9wsSobHFeGDB/+6crwu3SEAFN
 YyQB60FyY9dFLGabx38QrDgGApBlPyZWUTIi8NjgmDHc1AeBUUL1KDNnIqs/LjtpKFN4IR
 bYDYOKbB3bgARrjfLOBouxVpsRWDYKg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-anw3piySOWu3FIGLhRVfKw-1; Mon, 21 Jul 2025 09:54:36 -0400
X-MC-Unique: anw3piySOWu3FIGLhRVfKw-1
X-Mimecast-MFC-AGG-ID: anw3piySOWu3FIGLhRVfKw_1753106076
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-754f57d3259so6315667b3a.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753106076; x=1753710876;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8o5Bm3wWMLp4H77dsj8AY3lkHEuc+o8Esh6grh2GqUI=;
 b=qB+Qa4Yk0uEy2Wtm8aOV7BxCdHzUiGIuQjTrbpHzBp76ZerXMli2WGfTaLDTcCp5eB
 c8luB0KF7ORqQUvA0XMWZFMcf0sFrJGQZU7N80ydesiDHKGoL/afcOhRjgm3CY2R34IZ
 ndgcC70K2PVxvPeWrWfB1yK4lS1bcxMcBQannVywJktiVyWMX1JvSgiLiTLYZYDGrw4S
 X2IPHlSsZvKHswHYXnZU9x7p/2xUHNWAzZl1aGxMk4nWgSz75DMtZ3fQ3DJXbKTfZ/Qu
 UDTJEsTao1AninszXJeTif1gPPHR3dAC1snDVe0AnYLf9XWVHXntZvK3CZs0KPzyMMoA
 OsIw==
X-Gm-Message-State: AOJu0YzxedijjoBu9AD9+Sdw+/mWBAsTAXQJgdXse+NfjDiJRGzqxzVS
 LyDKqbvx1dZtCLh/st8TUcog4fikk21Gt6c/J50w0eugfI4ohbuqkPAc2bHmU1prv7gCiBsJLDV
 vc09KZTivdixl/BM5Hl8la4YT4nAHWIbphPgSAHUxnUwrXTTzFSXrNLmv
X-Gm-Gg: ASbGncvJkdKWr7+soYB1XnOlJqSSpBLo+s2fm330zMyR9RcdFVEdjloa2DKL+1nrs4v
 P++ZRBcxlJwRr7qrsbkGrgYuj3LoGSxJIHxi3xaYL/PMapB8VqA70CZd1eOEywsN3zCbjERAAyG
 TKu5Px3oOa5hvLhHYacYI5Lax9VaX1lvGYwRXawmg/WoMAky+UAq423chhxyy4DmxNxqX1je5p9
 QFbgIMNiVvYeAkfYBHNwNZkbA+HPDO89BnpJHw68h7Fom2upX9lgUxAWoiyQQPqmwgXUFVxqGc5
 l8IAj6clpIFkKfjfRp1K94tghcxjmKEW5DfYpE1WhJ7iUxkK/Ei/
X-Received: by 2002:a05:6a00:3d08:b0:742:b3a6:db09 with SMTP id
 d2e1a72fcca58-7584af48137mr21613745b3a.16.1753106075623; 
 Mon, 21 Jul 2025 06:54:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETMPAIXWZQcdx8Aljg7MSX6/QruTDN09wW9yWXmtmwAcXATVc2COTQET+a4unf1gkS5VF3qQ==
X-Received: by 2002:a05:6a00:3d08:b0:742:b3a6:db09 with SMTP id
 d2e1a72fcca58-7584af48137mr21613700b3a.16.1753106075113; 
 Mon, 21 Jul 2025 06:54:35 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cb157b49sm5868279b3a.96.2025.07.21.06.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:54:34 -0700 (PDT)
Date: Mon, 21 Jul 2025 19:24:23 +0530
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
Message-ID: <aH5Gj61ZmtZ0NzEv@armenon-kvm.bengluru.csb>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-23-fef740e15e17@redhat.com>
 <aH5BgAVc2x_tjsHJ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aH5BgAVc2x_tjsHJ@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
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

Hi,
Thank you for the review.

On Mon, Jul 21, 2025 at 02:32:48PM +0100, Daniel P. Berrangé wrote:
> On Mon, Jul 21, 2025 at 04:59:28PM +0530, Arun Menon wrote:
> > - We need to have good error reporting in the callbacks in
> >   VMStateDescription struct. Specifically pre_save, post_save,
> >   pre_load and post_load callbacks.
> > - It is not possible to change these functions everywhere in one
> >   patch, therefore, we introduce a duplicate set of callbacks
> >   with Error object passed to them.
> > - So, in this commit, we implement 'errp' variants of these callbacks,
> >   introducing an explicit Error object parameter.
> > - This is a functional step towards transitioning the entire codebase
> >   to the new error-parameterized functions.
> > - Deliberately called in mutual exclusion from their counterparts,
> >   to prevent conflicts during the transition.
> > - New impls should preferentally use 'errp' variants of
> >   these methods, and existing impls incrementally converted.
> >   The variants without 'errp' are intended to be removed
> >   once all usage is converted.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  include/migration/vmstate.h | 11 +++++++++++
> >  migration/vmstate.c         | 47 +++++++++++++++++++++++++++++++++++++++------
> >  2 files changed, 52 insertions(+), 6 deletions(-)
> > 
> 
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index 288b57e1ed778cce21247b64d5e97dfef41ad586..d96908d12ccffaef421e5d399a48e26cada2cb77 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> 
> > @@ -524,7 +548,12 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> >                  if (ret) {
> >                      error_setg(errp, "Save of field %s/%s failed",
> >                                  vmsd->name, field->name);
> > -                    if (vmsd->post_save) {
> > +                    if (vmsd->post_save_errp) {
> > +                        ret = vmsd->post_save_errp(opaque, &local_err);
> > +                        if (ret < 0) {
> > +                            error_propagate(errp, local_err);
> > +                        }
> 
> This is still broken. 'errp' is already set a few lines earlier, so you
> can't propagate a new error over the top

I was wondering that we should preserve the first error that was encountered.
So even if local_err was set, and in case errp already has an error, then it will
be a no-op and local_err will be freed.
> 
> > +                    } else if (vmsd->post_save) {
> >                          vmsd->post_save(opaque);
> >                      }
> >                      return ret;
> > @@ -552,7 +581,13 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> >  
> >      ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
> >  
> > -    if (vmsd->post_save) {
> > +    if (vmsd->post_save_errp) {
> > +        int ps_ret = vmsd->post_save_errp(opaque, &local_err);
> > +        if (!ret && ps_ret) {
> > +            ret = ps_ret;
> > +            error_propagate(errp, local_err);
> > +        }
> 
> Again, propagating over the top of an existing error

Sorry, correct me if I am wrong.
Since we have 'if (!ret && ps_ret)' ,
if vmstate_subsection_save() fails, the above condition will not hold true.
Only if the first function call vmstate_subsection_save() is successful and the second one
post_save_errp() fails then we try to propagate, again hoping to preserve the first error. 

> 
> > +    } else if (vmsd->post_save) {
> >          int ps_ret = vmsd->post_save(opaque);
> >          if (!ret && ps_ret) {
> >              ret = ps_ret;
> > 
> > -- 
> > 2.50.0
> > 
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
Arun Menon



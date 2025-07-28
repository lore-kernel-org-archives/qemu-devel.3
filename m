Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FEAC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 12:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugLxR-0006zb-NH; Mon, 28 Jul 2025 07:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ugLVY-00088i-J7
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ugLVW-0007zp-4u
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753700099;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ooD0Q+PvZhfTt0wfhHf7BQ2MslKmtu7wNKIIDzMdhhc=;
 b=SQDYKYmFaEyoZuGs2YKuOlA2+uOWm6zVvdrFeo66XEFkQXkBek90zdwIOyTJivx7PXO2M3
 Fmvd8PGV3YLxo14lzPJ48mxsDuZiQQj3lC2+vufgl77xSC5wiHXswHlDrMs4xvbB4vyZX0
 eE2Jvd+0ouE2hSvsZflaI6uSu4JbuGE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-bwPQ5S69PcOHqqkqsc3i3Q-1; Mon, 28 Jul 2025 06:54:58 -0400
X-MC-Unique: bwPQ5S69PcOHqqkqsc3i3Q-1
X-Mimecast-MFC-AGG-ID: bwPQ5S69PcOHqqkqsc3i3Q_1753700097
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-235e1d66fa6so44981515ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 03:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753700097; x=1754304897;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ooD0Q+PvZhfTt0wfhHf7BQ2MslKmtu7wNKIIDzMdhhc=;
 b=CeFD7qvHj/FZFQy5vxP4qMFGl3gQbXbBdShPzPUNkTFcGXqrKDhoOMEshRhP6kUW0o
 ZP1X4Yi9dmtGcFTgjIPxGDO3vefDqj1abkUg5s4ZEEw+onbi+jtcC7jn9KhPnrYQRMbo
 a1i0PnndVTEDI88b9xwJlpW0slg9PEoe3kAsnl1Tyfkyt8FZMnsu3ecpkwnrIk7H5eRO
 TX2/+6wjRWcaCga/o35NMfr8wz0f+YK6T2Nni4owwumW/yo5d5P6Pu+vOrv+Zkpdm48U
 4ABq9YFJHk0kGhoZjEjrZhvBjJp3lutq2cew8nN+1sZ/SRcv77OeWorZ8F8pFPHfDhBd
 8aXg==
X-Gm-Message-State: AOJu0YxqQY32z6c8fKYSAgKrDw2oYhYNXvrZ9oHmd+FLEzUB7zqdwHUT
 IGPRMoCMSaNEzDQi0gZIUUZRDQ6oaGfjKjaVx6CtJqcxUSCUx0KSxoCWKlVQ6UZ3Jykbd6WOoOp
 CxrLfqQpnYxJeyDHZCPmOg1qXvZPkP1xIpP2oHMli7kemz0hjYH9zVu47
X-Gm-Gg: ASbGncuDAocHOovP2ykdnNlm+Gcmbx7otMsg0Hz0+TCVoFB/SLK+wgzFlXgccT+0W/q
 VxRXlCDlDS9tnzRCld0WbHI5EbGUeMJVd1hXHi2QWa1ONwiVWGMwJPU5rXw2zXoQSaEl9gCRDnU
 +1jvh6Byhpb5fS7zObWXOlZRE9TSeMtaHc6vw8LlltsOVP7XwEVJNNjKGrIjLZ1DYKVhuGx+idD
 QDpf8eBKJHcm2EvVKmqzU+zLZGCBW6tDNRGZ4Nc9NmWf0803AjZVe9+4p9zNRyycAOFEECamahN
 wIxsUd96/PX3ra+Oi62hJ2BABNRE1ZhzGBerAqUmq6yN+Rk+w+SF
X-Received: by 2002:a17:902:e881:b0:240:50ef:2ed8 with SMTP id
 d9443c01a7336-24050ef2fd4mr7959875ad.21.1753700097224; 
 Mon, 28 Jul 2025 03:54:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG63hY21yazJ0JSvC2ZCMgNSwO6Y/qfnWM0g4EZoPdq2uXpkLfAEhCr7/LVyKbPI5ShPcpvIw==
X-Received: by 2002:a17:902:e881:b0:240:50ef:2ed8 with SMTP id
 d9443c01a7336-24050ef2fd4mr7959215ad.21.1753700096560; 
 Mon, 28 Jul 2025 03:54:56 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.191])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23ffa4bc557sm32645445ad.116.2025.07.28.03.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 03:54:56 -0700 (PDT)
Date: Mon, 28 Jul 2025 16:24:43 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v7 23/24] migration: Add error-parameterized function
 variants in VMSD struct
Message-ID: <aIdW8xBboyQZZYnf@armenon-kvm.bengluru.csb>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-23-d52704443975@redhat.com>
 <848e0e7e-2ad5-4d94-99eb-8314540ea0de@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <848e0e7e-2ad5-4d94-99eb-8314540ea0de@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Akihiko,

Thanks for the review.

On Sat, Jul 26, 2025 at 09:48:12PM +0900, Akihiko Odaki wrote:
> On 2025/07/25 21:19, Arun Menon wrote:
> > - We need to have good error reporting in the callbacks in
> >    VMStateDescription struct. Specifically pre_save, post_save,
> >    pre_load and post_load callbacks.
> > - It is not possible to change these functions everywhere in one
> >    patch, therefore, we introduce a duplicate set of callbacks
> >    with Error object passed to them.
> > - So, in this commit, we implement 'errp' variants of these callbacks,
> >    introducing an explicit Error object parameter.
> > - This is a functional step towards transitioning the entire codebase
> >    to the new error-parameterized functions.
> > - Deliberately called in mutual exclusion from their counterparts,
> >    to prevent conflicts during the transition.
> > - New impls should preferentally use 'errp' variants of
> >    these methods, and existing impls incrementally converted.
> >    The variants without 'errp' are intended to be removed
> >    once all usage is converted.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   include/migration/vmstate.h | 11 ++++++++
> >   migration/vmstate.c         | 62 +++++++++++++++++++++++++++++++++++++++------
> >   2 files changed, 65 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 056781b1c21e737583f081594d9f88b32adfd674..53fa72c1bbde399be02c88fc8745fdbb79bfd7c8 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -200,15 +200,26 @@ struct VMStateDescription {
> >        * exclusive. For this reason, also early_setup VMSDs are migrated in a
> >        * QEMU_VM_SECTION_FULL section, while save_setup() data is migrated in
> >        * a QEMU_VM_SECTION_START section.
> > +     *
> > +     * There are duplicate impls of the post/pre save/load hooks.
> > +     * New impls should preferentally use 'errp' variants of these
> > +     * methods and existing impls incrementally converted.
> > +     * The variants without 'errp' are intended to be removed
> > +     * once all usage is converted.
> >        */
> > +
> >       bool early_setup;
> >       int version_id;
> >       int minimum_version_id;
> >       MigrationPriority priority;
> >       int (*pre_load)(void *opaque);
> > +    int (*pre_load_errp)(void *opaque, Error **errp);
> >       int (*post_load)(void *opaque, int version_id);
> > +    int (*post_load_errp)(void *opaque, int version_id, Error **errp);
> >       int (*pre_save)(void *opaque);
> > +    int (*pre_save_errp)(void *opaque, Error **errp);
> >       int (*post_save)(void *opaque);
> > +    int (*post_save_errp)(void *opaque, Error **errp);
> >       bool (*needed)(void *opaque);
> >       bool (*dev_unplug_pending)(void *opaque);
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index bb5e9bf38d6ee7619ceb3e9da29209581c3c12eb..e427ef49b2b1991b0a3cdb14d641c197e00014b0 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -152,7 +152,16 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >           trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
> >           return -EINVAL;
> >       }
> > -    if (vmsd->pre_load) {
> > +    if (vmsd->pre_load_errp) {
> > +        ret = vmsd->pre_load_errp(opaque, errp);
> > +        if (ret) {
> > +            error_prepend(errp, "VM pre load failed for: '%s', "
> > +                          "version_id: '%d', minimum version_id: '%d', "
> > +                          "ret: %d: ", vmsd->name, vmsd->version_id,
> > +                          vmsd->minimum_version_id, ret);
> > +            return ret;
> > +        }
> > +    } else if (vmsd->pre_load) {
> >           ret = vmsd->pre_load(opaque);
> >           if (ret) {
> >               error_setg(errp, "VM pre load failed for: '%s', "
> > @@ -236,7 +245,14 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >           qemu_file_set_error(f, ret);
> >           return ret;
> >       }
> > -    if (vmsd->post_load) {
> > +    if (vmsd->post_load_errp) {
> > +        ret = vmsd->post_load_errp(opaque, version_id, errp);
> > +        if (ret < 0) {
> > +            error_prepend(errp, "VM Post load failed for: %s, version_id: %d, "
> > +                          "minimum_version: %d, ret: %d: ", vmsd->name,
> > +                          vmsd->version_id, vmsd->minimum_version_id, ret);
> > +        }
> > +    } else if (vmsd->post_load) {
> >           ret = vmsd->post_load(opaque, version_id);
> >           if (ret < 0) {
> >               error_setg(errp,
> > @@ -412,11 +428,19 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> >                            void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
> >   {
> >       int ret = 0;
> > +    Error *local_err = NULL;
> >       const VMStateField *field = vmsd->fields;
> >       trace_vmstate_save_state_top(vmsd->name);
> > -    if (vmsd->pre_save) {
> > +    if (vmsd->pre_save_errp) {
> > +        ret = vmsd->pre_save_errp(opaque, errp);
> > +        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> > +        if (ret) {
> > +            error_prepend(errp, "pre-save failed: %s: ", vmsd->name);
> > +            return ret;
> > +        }
> > +    } else if (vmsd->pre_save) {
> >           ret = vmsd->pre_save(opaque);
> >           trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> >           if (ret) {
> > @@ -524,10 +548,22 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> >                   }
> >                   if (ret) {
> > -                    error_setg(errp, "Save of field %s/%s failed",
> > -                                vmsd->name, field->name);
> > -                    if (vmsd->post_save) {
> > -                        vmsd->post_save(opaque);
> > +                    if (*errp == NULL) {
> 
> include/qapi/error.h says:
> >  * - You may pass NULL to not receive the error, &error_abort to abort
> >  *   on error, &error_fatal to exit(1) on error, or a pointer to a
> >  *   variable containing NULL to receive the error.
> 
> >  * - The function may pass @errp to functions it calls to pass on
> >  *   their errors to its caller.  If it dereferences @errp to check
> >  *   for errors, it must use ERRP_GUARD().

Yes, we can add an ERRP_GUARD() before the null check (*errp == NULL), iff we
need a check, more on that below.
> 
> I also think this change is irrelevant with the addition of the new 'errp'
> variants; it fixes an assertion failure when vmstate_save_state_v() failed
> and set errp. It is not a new problem caused by the 'errp' variants.
> 
You are right.

vmstate_save_state() function, inturn calls vmstate_save_state_v() with NULL errp.
So that can be ignored for now, as the errors will not be set in errp at all.
Calling error_setg() exclusively later, will not cause any trouble.

On the other hand,
vmstate_save_state_v() will set errp.
And I thought re-setting it here, using error_setg() will crash QEMU.
commit 848a0503422d043d541130d5e3e2f7bc147cdef9 introduced error_setg()
in place of error_report() 

However, on review, I do think nothing has changed indeed as far as
this patchset is concerned. I do wonder though, how resetting this
does not crash QEMU. Maybe I am missing something.

> If that's true, this change should have its own explanation in the patch
> message, and also be split into another patch as "a commit message that
> mentions 'Also, ...' is often a good candidate for splitting into multiple
> patches." (docs/devel/submitting-a-patch.rst)
> 
> > +                        error_setg(errp, "Save of field %s/%s failed",
> > +                                   vmsd->name, field->name);
> > +                    }
> > +                    if (vmsd->post_save_errp) {
> > +                        int ps_ret = vmsd->post_save_errp(opaque, &local_err);
> > +                        if (ps_ret < 0) {
> 
> The error checks else this and next ps_ret checks only care if it's zero or
> not, but this checks for the sign, leading to inconsistency.

Yes, I shall keep it consistent, a non-zero value means failure. No need of sign check.
> 
> > +                            error_free_or_abort(errp);
> > +                            error_propagate(errp, local_err);
> > +                            ret = ps_ret;
> > +                        }
> > +                    } else if (vmsd->post_save) {
> > +                        int ps_ret = vmsd->post_save(opaque);
> > +                        if (ps_ret < 0) {
> > +                            ret = ps_ret;
> > +                        }
> >                       }
> >                       return ret;
> >                   }
> > @@ -554,7 +590,17 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> >       ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
> > -    if (vmsd->post_save) {
> > +    if (vmsd->post_save_errp) {
> > +        int ps_ret = vmsd->post_save_errp(opaque, &local_err);
> > +        if (!ret && ps_ret) {
> > +            ret = ps_ret;
> > +            error_propagate(errp, local_err);
> > +        } else if (ret && ps_ret) {
> > +            error_free_or_abort(errp);
> > +            error_propagate(errp, local_err);
> > +            ret = ps_ret;
> > +        }
> 
> Simpler:
> 
> if (ps_ret) {
>     if (ret) {
>       error_free_or_abort(errp);
>     }
>     ret = ps_ret;
>     error_propagate(errp, local_err);
> }
> 
Will do.
> > +    } else if (vmsd->post_save) {
> >           int ps_ret = vmsd->post_save(opaque);
> >           if (!ret && ps_ret) {
> >               ret = ps_ret;
> 
> When there is a preceding error, this code still returns it and dismisses
> the post_save() error although the other part of this function is changed to
> propagate the error of post-save unconditionally. Please keep them
> consistent.

I do feel that in the new implementation (post_save_errp), we should be dismissing
the preceeding error and propagating the new error from post_save(). 
Because, that way, it makes sense to run the post_save_errp() part even after encountering
an error in the preceeding section (vmstate_subsection_save).

Not sure if I should change the old impl post_save to match post_save_errp,
Or should I match the new impl with the old one.
> 
> > 
> 


Regards,
Arun



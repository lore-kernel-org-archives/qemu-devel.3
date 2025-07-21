Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D6EC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqar-0001tU-N1; Mon, 21 Jul 2025 09:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udqaV-0001AP-UA
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udqaS-0005l9-NV
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753104585;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QsubmAraLDXUmpWBhBcD/QEzJQUuw7w765c5grJH+SU=;
 b=dXT+4wX02R1Ddvxxu9vmmdFS9oLtY1ZSZ5iWvI80VJg6RlK91ymDpJX9QqdV4sXyrpOYEd
 KIsI495Jh5AR+MHGCFpKDCs9eEMxNeSH+cACQfBo/y40HluJ1kqvYrEullq1yRjxkOs4/S
 ZqbT9i7Y+25iOk2kcJy5Pa+GCOVTWkU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-AvLfv6biMcWs46Sr7ULRgg-1; Mon,
 21 Jul 2025 09:29:42 -0400
X-MC-Unique: AvLfv6biMcWs46Sr7ULRgg-1
X-Mimecast-MFC-AGG-ID: AvLfv6biMcWs46Sr7ULRgg_1753104580
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE2071956048; Mon, 21 Jul 2025 13:29:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.213])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED8E51800D82; Mon, 21 Jul 2025 13:29:28 +0000 (UTC)
Date: Mon, 21 Jul 2025 14:29:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v6 23/24] migration: Add error-parameterized function
 variants in VMSD struct
Message-ID: <aH5AtUcjI3HYXdBe@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-23-fef740e15e17@redhat.com>
 <3e9aa703-2805-4ac4-9f10-f4ba71c10c8a@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e9aa703-2805-4ac4-9f10-f4ba71c10c8a@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 21, 2025 at 10:14:30PM +0900, Akihiko Odaki wrote:
> On 2025/07/21 20:29, Arun Menon wrote:
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
> >   include/migration/vmstate.h | 11 +++++++++++
> >   migration/vmstate.c         | 47 +++++++++++++++++++++++++++++++++++++++------
> >   2 files changed, 52 insertions(+), 6 deletions(-)
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
> 
> I think the new functions should have void as return value instead.
> 
> As I discussed before, I think having an integer return value is a source of
> confusion:
> https://lore.kernel.org/qemu-devel/0447e269-c242-4cd7-b68e-d0c7211784a7@rsg.ci.i.u-tokyo.ac.jp/
> 
> In the previous discussion, I suggested using bool, but void fits better in
> this particular case.
> 
> include/qapi/error.h says:
> > Whenever practical, also return a value that indicates success /
> > failure.  This can make the error checking more concise, and can avoid
> > useless error object creation and destruction.  Note that we still
> > have many functions returning void.
> 
> There will be more implementations of these function pointers than their
> callers, so it makes more sense to let return void and make implementations
> more concise while making the callers less so. There is also DeviceRealize,
> an example of function pointer type that takes errp but returns void.

No, please do NOT make these functions void. As that text you quote
says, we want functions to return a value indicating success/failure.
'void' return is a historical practice we don't want to continue
in QEMU.

Given that the existing methods all return 'int', we should remain
consistent with the new functions and return 'int', with -1 for
failure, 0 for success, and not use bool.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBE0C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 19:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucUSH-00081H-JY; Thu, 17 Jul 2025 15:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucS0l-0004c6-LQ
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 13:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucS0i-0001Me-5b
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 13:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752771785;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=d6Nr9MM0QZsyyi8E4M+uuy3qrDJVo4KMeyGwI1RraYg=;
 b=ZOd9BWeeM2AOoBGISezRqGtXCulBS5gpbtphXfdhxlvCNeknZTmcTdFMo0kznVuvJZYx+X
 r8142R0huFcHvVAlp4VYpwErXMwXb+9m2tqrcc4aYGtenCAzs8WhZw4aXOyeXPjng8Wf0b
 OS1kFtOuspFFJDyOYtyjBBuaZ5i+FGw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-359j5dUjPd-2rFUBaugIFg-1; Thu,
 17 Jul 2025 13:03:01 -0400
X-MC-Unique: 359j5dUjPd-2rFUBaugIFg-1
X-Mimecast-MFC-AGG-ID: 359j5dUjPd-2rFUBaugIFg_1752771777
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E3761852981; Thu, 17 Jul 2025 17:02:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.171])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62ABC180170E; Thu, 17 Jul 2025 17:02:12 +0000 (UTC)
Date: Thu, 17 Jul 2025 18:02:09 +0100
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
Subject: Re: [PATCH v5 09/23] migration: push Error **errp into
 ram_postcopy_incoming_init()
Message-ID: <aHkskfsMNVgjoV2y@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
 <20250717-propagate_tpm_error-v5-9-1f406f88ee65@redhat.com>
 <c535b2b0-78d6-4afa-bd6a-d11159d3a952@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c535b2b0-78d6-4afa-bd6a-d11159d3a952@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 17, 2025 at 12:34:21PM +0900, Akihiko Odaki wrote:
> On 2025/07/17 9:37, Arun Menon wrote:
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that ram_postcopy_incoming_init() must report an error
> > in errp, in case of failure.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   migration/postcopy-ram.c | 9 ++++++---
> >   migration/postcopy-ram.h | 2 +-
> >   migration/ram.c          | 6 +++---
> >   migration/ram.h          | 2 +-
> >   migration/savevm.c       | 2 +-
> >   5 files changed, 12 insertions(+), 9 deletions(-)
> > 
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 45af9a361e8eacaad0fb217a5da2c5004416c1da..05617e5fbcad62226a54fe17d9f7d9a316baf1e4 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -681,6 +681,7 @@ out:
> >    */
> >   static int init_range(RAMBlock *rb, void *opaque)
> >   {
> > +    Error **errp = opaque;
> >       const char *block_name = qemu_ram_get_idstr(rb);
> >       void *host_addr = qemu_ram_get_host_addr(rb);
> >       ram_addr_t offset = qemu_ram_get_offset(rb);
> > @@ -701,6 +702,8 @@ static int init_range(RAMBlock *rb, void *opaque)
> >        * (Precopy will just overwrite this data, so doesn't need the discard)
> >        */
> >       if (ram_discard_range(block_name, 0, length)) {
> > +        error_setg(errp, "failed to discard RAM block %s len=%zu",
> > +                   block_name, length);
> >           return -1;
> >       }
> > @@ -749,9 +752,9 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
> >    * postcopy later; must be called prior to any precopy.
> >    * called from arch_init's similarly named ram_postcopy_incoming_init
> >    */
> > -int postcopy_ram_incoming_init(MigrationIncomingState *mis)
> > +int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)
> >   {
> > -    if (foreach_not_ignored_block(init_range, NULL)) {
> > +    if (foreach_not_ignored_block(init_range, errp)) {
> >           return -1;
> >       }
> > @@ -1703,7 +1706,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis, Error **errp)
> >       return false;
> >   }
> > -int postcopy_ram_incoming_init(MigrationIncomingState *mis)
> > +int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)
> >   {
> >       error_report("postcopy_ram_incoming_init: No OS support");
> >       return -1;
> > diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> > index 3852141d7e37ab18bada4b46c137fef0969d0070..ca19433b246893fa5105bcebffb442c58a9a4f48 100644
> > --- a/migration/postcopy-ram.h
> > +++ b/migration/postcopy-ram.h
> > @@ -30,7 +30,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis);
> >    * postcopy later; must be called prior to any precopy.
> >    * called from ram.c's similarly named ram_postcopy_incoming_init
> >    */
> > -int postcopy_ram_incoming_init(MigrationIncomingState *mis);
> > +int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp);
> >   /*
> >    * At the end of a migration where postcopy_ram_incoming_init was called.
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 7208bc114fb5c366740db380ee6956a91b3871a0..8223183132dc0f558f45fbae3f4f832845730bd3 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3708,7 +3708,7 @@ static int ram_load_cleanup(void *opaque)
> >   /**
> >    * ram_postcopy_incoming_init: allocate postcopy data structures
> >    *
> > - * Returns 0 for success and negative if there was one error
> > + * Returns 0 for success and -1 if there was one error
> 
> This is true but not relevant in this patch's goal.
> 
> Besides, I'm not in favor of letting callers make an assumption on integer
> return values (i.e., let callers assume a particular integer value in the
> error conditions). It is subtle to make a mistake to return -errno while the
> documentation says it returns -1.

In general I would consider it bad practice to have an method
with "Error **errp" that also returns an errno. 95% of the time
the errno is just there as further info on the error scenario,
which "errp" obsoletes. Only in the rare cases where the caller
needs to take functional action based on errno values, is it
appropriate to contine returning '-errno'.

IOW, I'd consider this appropriate for the patch as is.

> I think a proper way to avoid bugs due to return values here is to change
> the type to bool, which ensures there are two possible values; that is a
> nice improvement but something that can be done later.

That doesn't guarantee avoidance of bugs, as bool values can be
assigned to & compared against integers.


> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index d1edeaac5f2a5df2f6d94357388be807a938b2ef..8eba151a693b7f2dc58853292c92024288eae81e 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1983,7 +1983,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
> >           return -1;
> >       }
> > -    if (ram_postcopy_incoming_init(mis)) {
> > +    if (ram_postcopy_incoming_init(mis, NULL)) {
> >           return -1;
> >       }

This is a definite anti-pattern though as it treats positive return
values as errors, contrary to the documented API  for both the old
and new code.

So change this to "< 0" while we're here.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



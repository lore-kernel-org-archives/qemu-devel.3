Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8AEC8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWw2T-0000c6-I8; Wed, 02 Jul 2025 07:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWw2Q-0000bB-6f
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWw2C-0000hj-C4
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751457228;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=g9GKh9vfft4dGxVeGsDOrGgR6U/agYIGfMJafLcXkvU=;
 b=VbeHAIQ3nf1iOxezgx4mDujNUaZlWUc/eZEDPJuR73EIkWCpLY4Ha5f0UQzh5pSXHMWtt3
 yL9PwX7HBKJUJbjQj8p/3aiZ1NjwX3qhJMXKhIE1qARMTS4l7EZdBOL+XFXnWjtip44gJ7
 CrlBlpGSBJR775FVztZQPpRxsA8nR8c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-K4ydI6HPMLCrd-leuG_IMA-1; Wed,
 02 Jul 2025 07:53:44 -0400
X-MC-Unique: K4ydI6HPMLCrd-leuG_IMA-1
X-Mimecast-MFC-AGG-ID: K4ydI6HPMLCrd-leuG_IMA_1751457220
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11547180028B; Wed,  2 Jul 2025 11:53:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.116])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E06C1956087; Wed,  2 Jul 2025 11:53:31 +0000 (UTC)
Date: Wed, 2 Jul 2025 12:53:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Arun Menon <armenon@redhat.com>
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
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/3] migration: Introduce a post_load_with_error hook
Message-ID: <aGUdt7iCRQHGC1jR@redhat.com>
References: <20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com>
 <20250702-propagate_tpm_error-v3-2-986d94540528@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702-propagate_tpm_error-v3-2-986d94540528@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 02, 2025 at 05:06:51PM +0530, Arun Menon wrote:
> - Introduces a temporary `post_load_with_error()` hook.
>   This enables a gradual transition of error reporting,
>   eventually replacing `post_load` throughout the codebase.
> - Deliberately called in mutual exclusion from post_load() hook
>   to prevent conflicts during the transition.
> - Briefly discussed here : https://issues.redhat.com/browse/RHEL-82826

While the ticket is public, many of the comments are private
to RH. Generally any relevant info should be direclty included
in the commit message, so we don't rely on downstream vendor
bug trackers which may or may no be public long term.

> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  include/migration/vmstate.h | 1 +
>  migration/vmstate.c         | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 056781b1c21e737583f081594d9f88b32adfd674..1c6e89c3b08a3914cde6dce3be5955978b6b7d0b 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -207,6 +207,7 @@ struct VMStateDescription {
>      MigrationPriority priority;
>      int (*pre_load)(void *opaque);

This is called from the same context as post_load, so deserves
the same change to add an "errp".

>      int (*post_load)(void *opaque, int version_id);
> +    int (*post_load_with_error)(void *opaque, int version_id, Error **errp);

This is a bit overly verbose, 'post_load_errp' is sufficient.

>      int (*pre_save)(void *opaque);
>      int (*post_save)(void *opaque);

I'm inclined to suggest we add 'errp' variants of these too.

IOW, do the general design fix, not the bare minimum for this
specific tpm problem.

Then, we should also add an explanatory comment

 /*
  * New impls should preferentally use 'errp' variants of
  * these methods, and existing impls incrementally converted.
  * The variants without 'errp' are intended to be removed
  * once all usage is converted.
  */

>      bool (*needed)(void *opaque);
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 158dcc3fcddfe70ab268dc5ace6e4573fa1ccbab..0048c4e1e7ee1d6ff3a3349abb0dc1578985a56e 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -236,7 +236,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>          }
>          return ret;
>      }
> -    if (vmsd->post_load) {
> +    if (vmsd->post_load_with_error) {
> +        ret = vmsd->post_load_with_error(opaque, version_id, errp);
> +    } else if (vmsd->post_load) {
>          ret = vmsd->post_load(opaque, version_id);
>      }
>      trace_vmstate_load_state_end(vmsd->name, "end", ret);
> 
> -- 
> 2.49.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



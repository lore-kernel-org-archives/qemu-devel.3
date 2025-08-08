Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF3EC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 10:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukKeC-0002gf-Tm; Fri, 08 Aug 2025 06:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukKeA-0002ck-GO
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 06:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukKe8-0004Qd-Fe
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 06:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754650102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rRkzzxR1VVIbbYj6enXKWSSXJfM5rw+2FQewa+7Zugk=;
 b=iCIndarCdnRoRNQipeUyluVyaOyxBKkvaQ6SPDz34botgfxsUAblBxtyBwZILmjiQA3tpL
 yhrrvgWjrRrx73aNYHGqxh3CQVXTaJbdobihZbneZv/8abkbP/wuqqQJAAnYsSo0erbPC1
 gFBofkXPgg6wKX0qTxhs26WDbQ5qsuA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-YreWYYbANV6ZwYElSvfxcw-1; Fri,
 08 Aug 2025 06:48:19 -0400
X-MC-Unique: YreWYYbANV6ZwYElSvfxcw-1
X-Mimecast-MFC-AGG-ID: YreWYYbANV6ZwYElSvfxcw_1754650098
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C6991955E7F; Fri,  8 Aug 2025 10:48:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B51C63001455; Fri,  8 Aug 2025 10:48:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3633E21E6A27; Fri, 08 Aug 2025 12:48:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 eblake@redhat.com,  armbru@redhat.com,  jasowang@redhat.com,
 mst@redhat.com,  si-wei.liu@oracle.com,  eperezma@redhat.com,
 boris.ostrovsky@oracle.com
Subject: Re: [RFC 1/6] migration: Add virtio-iterative capability
In-Reply-To: <20250722124127.2497406-2-jonah.palmer@oracle.com> (Jonah
 Palmer's message of "Tue, 22 Jul 2025 12:41:22 +0000")
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-2-jonah.palmer@oracle.com>
Date: Fri, 08 Aug 2025 12:48:14 +0200
Message-ID: <874iuihyxd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I apologize for the lateness of my review.

Jonah Palmer <jonah.palmer@oracle.com> writes:

> Adds a new migration capability 'virtio-iterative' that will allow
> virtio devices, where supported, to iteratively migrate configuration
> changes that occur during the migration process.

Why is that desirable?

> This capability is added to the validated capabilities list to ensure
> both the source and destination support it before enabling.

What happens when only one side enables it?

> The capability defaults to off to maintain backward compatibility.
>
> To enable the capability via HMP:
> (qemu) migrate_set_capability virtio-iterative on
>
> To enable the capability via QMP:
> {"execute": "migrate-set-capabilities", "arguments": {
>      "capabilities": [
>         { "capability": "virtio-iterative", "state": true }
>      ]
>   }
> }
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  migration/savevm.c  | 1 +
>  qapi/migration.json | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index bb04a4520d..40a2189866 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -279,6 +279,7 @@ static bool should_validate_capability(int capability)
>      switch (capability) {
>      case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
>      case MIGRATION_CAPABILITY_MAPPED_RAM:
> +    case MIGRATION_CAPABILITY_VIRTIO_ITERATIVE:
>          return true;
>      default:
>          return false;
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 4963f6ca12..8f042c3ba5 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -479,6 +479,11 @@
>  #     each RAM page.  Requires a migration URI that supports seeking,
>  #     such as a file.  (since 9.0)
>  #
> +# @virtio-iterative: Enable iterative migration for virtio devices, if
> +#     the device supports it. When enabled, and where supported, virtio
> +#     devices will track and migrate configuration changes that may
> +#     occur during the migration process. (Since 10.1)

When and why should the user enable this?

What exactly do you mean by "where supported"?

docs/devel/qapi-code-gen.rst:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

> +#
>  # Features:
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> @@ -498,7 +503,7 @@
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> -           'dirty-limit', 'mapped-ram'] }
> +           'dirty-limit', 'mapped-ram', 'virtio-iterative'] }
>  
>  ##
>  # @MigrationCapabilityStatus:



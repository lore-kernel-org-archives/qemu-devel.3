Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801C9C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcodL-00018w-QD; Wed, 21 Feb 2024 10:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcobL-0003wN-81
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:33:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rclJh-000279-4D
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 07:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708516992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X8P1VwozqjwEcL8Vm+hcwxwvLxo43Y7Huj9v/j1Fuco=;
 b=dhIzzDbiWwjvrDaOaKADJpgLvPdk68m2rCgNcURhPRNnhVPTJOSf/O/ZLS1Th/2lbaagb0
 YPVO7Te1uEHh2NddWtBzNGYMV586D5QW9F9nOIby2bqrDYx0l2yIuA/9F4RFO6VAOvf7EZ
 tGr6m/1kWVqgWcp06BWSCh8XlI1T3nc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-pCaS7BgINaSlsJFCmyq-VA-1; Wed, 21 Feb 2024 07:03:07 -0500
X-MC-Unique: pCaS7BgINaSlsJFCmyq-VA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8ECF6106D102;
 Wed, 21 Feb 2024 12:03:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BB7C112132A;
 Wed, 21 Feb 2024 12:03:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5645A21E66D5; Wed, 21 Feb 2024 13:03:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com,  berrange@redhat.com,  eduardo@habkost.net,
 peterx@redhat.com,  farosas@suse.de,  eblake@redhat.com,
 thuth@redhat.com,  lvivier@redhat.com,  qemu-devel@nongnu.org,
 jdenemar@redhat.com
Subject: Re: [PATCH v2 1/7] migration/multifd: Add new migration option
 zero-page-detection.
In-Reply-To: <20240216224002.1476890-2-hao.xiang@bytedance.com> (Hao Xiang's
 message of "Fri, 16 Feb 2024 22:39:56 +0000")
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-2-hao.xiang@bytedance.com>
Date: Wed, 21 Feb 2024 13:03:05 +0100
Message-ID: <87y1bet47a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> This new parameter controls where the zero page checking is running.
> 1. If this parameter is set to 'legacy', zero page checking is
> done in the migration main thread.
> 2. If this parameter is set to 'none', zero page checking is disabled.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 5a565d9b8d..99843a8e95 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -653,6 +653,17 @@
>  { 'enum': 'MigMode',
>    'data': [ 'normal', 'cpr-reboot' ] }
>  
> +##
> +# @ZeroPageDetection:
> +#
> +# @legacy: Perform zero page checking from main migration thread. (since 9.0)
> +#
> +# @none: Do not perform zero page checking.
> +#
> +##

The entire type is since 9.0.  Thus:

   ##
   # @ZeroPageDetection:
   #
   # @legacy: Perform zero page checking from main migration thread.
   #
   # @none: Do not perform zero page checking.
   #
   # Since: 9.0
   ##

> +{ 'enum': 'ZeroPageDetection',
> +  'data': [ 'legacy', 'none' ] }
> +
>  ##
>  # @BitmapMigrationBitmapAliasTransform:
>  #
> @@ -874,6 +885,9 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
>  #        (Since 8.2)
>  #
> +# @zero-page-detection: See description in @ZeroPageDetection.
> +#     Default is 'legacy'. (Since 9.0)

The description feels a bit lazy :)

Suggest

   # @zero-page-detection: Whether and how to detect zero pages.  Default
   #     is 'legacy'.  (since 9.0)

Same for the other two copies.

> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -907,7 +921,8 @@
>             'block-bitmap-mapping',
>             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
>             'vcpu-dirty-limit',
> -           'mode'] }
> +           'mode',
> +           'zero-page-detection'] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1066,6 +1081,10 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
>  #        (Since 8.2)
>  #
> +# @zero-page-detection: See description in @ZeroPageDetection.
> +#     Default is 'legacy'. (Since 9.0)
> +#
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1119,7 +1138,8 @@
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
> -            '*mode': 'MigMode'} }
> +            '*mode': 'MigMode',
> +            '*zero-page-detection': 'ZeroPageDetection'} }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1294,6 +1314,9 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
>  #        (Since 8.2)
>  #
> +# @zero-page-detection: See description in @ZeroPageDetection.
> +#     Default is 'legacy'. (Since 9.0)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1344,7 +1367,8 @@
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
> -            '*mode': 'MigMode'} }
> +            '*mode': 'MigMode',
> +            '*zero-page-detection': 'ZeroPageDetection'} }
>  
>  ##
>  # @query-migrate-parameters:



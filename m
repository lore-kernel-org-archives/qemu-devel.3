Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C77C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoWs-0008C0-GM; Wed, 21 Feb 2024 10:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoOO-0001fU-L8
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:20:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rclLM-0002U1-Ar
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 07:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708517095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tx1O13Gnsie+xPpCJxw92CzPBEojqIPPjBASOTq07Hw=;
 b=dv6xYrvo/Obvv4GkhR9jBj02HvJ4Cv6TXLSKwn/vKRq3O/MEygb5kp2hzxAaxogMM4awbT
 HUf0Dv3gx3OfwiwmqdFKJ3n7pf3xSgsaqsRn9MFQeJZYOdE0pmgoSF9AiZnIrhDILxbygU
 KdhqYkE2L7erRkO1zifQMYVDQ6z8oPs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-04X_3TotNzuNcEnteRLy_Q-1; Wed, 21 Feb 2024 07:04:49 -0500
X-MC-Unique: 04X_3TotNzuNcEnteRLy_Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8EF683B827;
 Wed, 21 Feb 2024 12:04:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85415492BD7;
 Wed, 21 Feb 2024 12:04:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9013B21E66D5; Wed, 21 Feb 2024 13:04:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com,  berrange@redhat.com,  eduardo@habkost.net,
 peterx@redhat.com,  farosas@suse.de,  eblake@redhat.com,
 thuth@redhat.com,  lvivier@redhat.com,  qemu-devel@nongnu.org,
 jdenemar@redhat.com
Subject: Re: [PATCH v2 3/7] migration/multifd: Zero page transmission on the
 multifd thread.
In-Reply-To: <20240216224002.1476890-4-hao.xiang@bytedance.com> (Hao Xiang's
 message of "Fri, 16 Feb 2024 22:39:58 +0000")
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-4-hao.xiang@bytedance.com>
Date: Wed, 21 Feb 2024 13:04:47 +0100
Message-ID: <87ttm2t44g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

> 1. Implements the zero page detection and handling on the multifd
> threads for non-compression, zlib and zstd compression backends.
> 2. Added a new value 'multifd' in ZeroPageDetection enumeration.
> 3. Add proper asserts to ensure pages->normal are used for normal pages
> in all scenarios.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 99843a8e95..e2450b92d4 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -660,9 +660,11 @@
>  #
>  # @none: Do not perform zero page checking.
>  #
> +# @multifd: Perform zero page checking on the multifd sender thread. (since 9.0)

As pointed out in my review of PATCH 3, the entire type is since 9.0.

> +#
>  ##
>  { 'enum': 'ZeroPageDetection',
> -  'data': [ 'legacy', 'none' ] }
> +  'data': [ 'legacy', 'none', 'multifd' ] }
>  
>  ##
>  # @BitmapMigrationBitmapAliasTransform:

I don't like having 'none' (don't detect) between the two ways to
detect.  Put it either first or last.



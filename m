Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23337C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5hb-00077y-MF; Mon, 03 Jun 2024 07:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sE5hT-0006O8-AW
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:18:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sE5hQ-0006Ps-7r
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717413477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HKQqMBDtS6A+Sj4jd/8BRDsnCw8kb3YuMImOtsFJCmg=;
 b=ZZjh/LUgkUSWUVM7+jg+rRPNo6JFVdcMFhotkqtKNTlv22AFYfGjoWR41XbUsqtcoD6WMP
 J4pgJFnFabawj2WuK7aG0mImtsesNFyLhspL3WV6QbzNlY5NdWz1dfEHS9K3E6Dq5TVAX/
 0UB99lXosoyolbY9CQ7iSSPDG6lOa7o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-YKlAeizLMhSeR2dhptFN2A-1; Mon, 03 Jun 2024 07:17:55 -0400
X-MC-Unique: YKlAeizLMhSeR2dhptFN2A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BB9F8058D5;
 Mon,  3 Jun 2024 11:17:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFEA0202696B;
 Mon,  3 Jun 2024 11:17:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1696221E681D; Mon,  3 Jun 2024 13:17:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  armbru@redhat.com,
 eblake@redhat.com,  hreitz@redhat.com,  kwolf@redhat.com,
 vsementsov@yandex-team.ru,  jsnow@redhat.com
Subject: Re: [PATCH v2 2/2] backup: add minimum cluster size to performance
 options
In-Reply-To: <20240528120114.344416-3-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Tue, 28 May 2024 14:01:14 +0200")
References: <20240528120114.344416-1-f.ebner@proxmox.com>
 <20240528120114.344416-3-f.ebner@proxmox.com>
Date: Mon, 03 Jun 2024 13:17:54 +0200
Message-ID: <87cyoytgv1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> In the context of backup fleecing, discarding the source will not work
> when the fleecing image has a larger granularity than the one used for
> block-copy operations (can happen if the backup target has smaller
> cluster size), because cbw_co_pdiscard_snapshot() will align down the
> discard requests and thus effectively ignore then.
>
> To make @discard-source work in such a scenario, allow specifying the
> minimum cluster size used for block-copy operations and thus in
> particular also the granularity for discard requests to the source.
>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 8fc0a4b234..f1219a9dfb 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1551,11 +1551,16 @@
>  #     it should not be less than job cluster size which is calculated
>  #     as maximum of target image cluster size and 64k.  Default 0.
>  #
> +# @min-cluster-size: Minimum size of blocks used by copy-before-write
> +#     and background copy operations.  Has to be a power of 2.  No
> +#     effect if smaller than the maximum of the target's cluster size
> +#     and 64 KiB.  Default 0.  (Since 9.1)
> +#
>  # Since: 6.0
>  ##
>  { 'struct': 'BackupPerf',
> -  'data': { '*use-copy-range': 'bool',
> -            '*max-workers': 'int', '*max-chunk': 'int64' } }
> +  'data': { '*use-copy-range': 'bool', '*max-workers': 'int',
> +            '*max-chunk': 'int64', '*min-cluster-size': 'size' } }
>  
>  ##
>  # @BackupCommon:

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>



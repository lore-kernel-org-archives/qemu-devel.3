Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F736C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txNSC-0005KD-Sv; Wed, 26 Mar 2025 05:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txNS2-00056l-Sf
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txNRz-0005gM-SE
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742982811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o9QhBad7EmFy71J41v+29pd+S8a0/KjcaDPRQ0wTJpA=;
 b=QgGQJDL5rHVGR+geQZ54FH8LLrpbeh7m+wmZP8gjkxNTYR054b0ois89tvocatyw61BYFx
 PjVKUwj1qsRz3MuRiFtNW+A4jX+mgizmOOxtAKfp7hNwd1umKyE4PwR5w6oki1Q+smrgkE
 hZ4gL3N5oSzwmJOpPYgly8ESiSmVKeg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-j6gyZLZ8Oj2lcQH9nvrfVA-1; Wed,
 26 Mar 2025 05:53:27 -0400
X-MC-Unique: j6gyZLZ8Oj2lcQH9nvrfVA-1
X-Mimecast-MFC-AGG-ID: j6gyZLZ8Oj2lcQH9nvrfVA_1742982805
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7150A1956070; Wed, 26 Mar 2025 09:53:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2157E30001A1; Wed, 26 Mar 2025 09:53:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D5C9621E6773; Wed, 26 Mar 2025 10:53:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: zoudongjie via <qemu-devel@nongnu.org>
Cc: zoudongjie <zoudongjie@huawei.com>,  <stefanha@redhat.com>,
 <kwolf@redhat.com>,  <fam@euphon.net>,  <hreitz@redhat.com>,
 <alex.chen@huawei.com>,  <chenjianfei3@huawei.com>,
 <eric.fangyi@huawei.com>,  <luolongmin@huawei.com>,
 <mujinsheng@huawei.com>,  <qemu-block@nongnu.org>,
 <qemu-stable@nongnu.org>,  <renxuming@huawei.com>,
 <suxiaodong1@huawei.com>,  <wangjian161@huawei.com>,
 <wangyan122@huawei.com>,  <yebiaoxiang@huawei.com>,
 <zhuyangyang14@huawei.com>
Subject: Re: [PATCH v3 2/2] qapi/throttle: add timeout parameter for
 qmp_block_set_io_throttle()
In-Reply-To: <20250326092634.1691355-3-zoudongjie@huawei.com> (zoudongjie
 via's message of "Wed, 26 Mar 2025 17:26:34 +0800")
References: <20250326092634.1691355-1-zoudongjie@huawei.com>
 <20250326092634.1691355-3-zoudongjie@huawei.com>
Date: Wed, 26 Mar 2025 10:53:20 +0100
Message-ID: <87bjto9kz3.fsf@pond.sub.org>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

zoudongjie via <qemu-devel@nongnu.org> writes:

> From: Zhu Yangyang <zhuyangyang14@huawei.com>
>
> Calling qmp_block_set_io_throttle() will be blocked for a long time
> when a network disk is configured and the network failure is just about
> to occur.
>
> Therefore, we add a timeout parameter for qmp_block_set_io_throttle to control
> its execution duration.

What's the QMP reply when a block_set_io_throttle command times out?

>
> The default value of timeout is 0, that is infinite wait, consistent with
> previous behavior.
>
> Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b1937780e1..88ef593efd 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2626,6 +2626,9 @@
>  #
>  # @group: throttle group name (Since 2.4)
>  #
> +# @timeout: In seconds. Timeout for block_set_io_throttle,
> +#     0 means no limit. Defaults to 0. (Since 10.0)

Make that 10.1, since it won't make 10.0.

> +#
>  # Features:
>  #
>  # @deprecated: Member @device is deprecated.  Use @id instead.
> @@ -2642,7 +2645,7 @@
>              '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
>              '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
>              '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
> -            '*iops_size': 'int', '*group': 'str' } }
> +            '*iops_size': 'int', '*group': 'str', '*timeout': 'uint32'} }
>  
>  ##
>  # @ThrottleLimits:



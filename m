Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F35C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 10:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEQRq-00017g-Su; Mon, 12 May 2025 06:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEQRn-000163-Dr
 for qemu-devel@nongnu.org; Mon, 12 May 2025 06:31:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEQRk-0005oy-Lr
 for qemu-devel@nongnu.org; Mon, 12 May 2025 06:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747045902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dVLrg0Pevp5dy3bD+oKL+p/ECpX9z6/EfHD2qL6hzNg=;
 b=A4OSD/j0nDgpqN4KUwkG3GCx88dr071VCn1jRgRUuO13bgZImWCmBZGOQGKIfC6ifojtQ9
 UmxpI08lczYjacer6vAQiiS+7nBoZkXAvrnYwtP53DicZNW7Xx2UPJjcqQ5K7H3w9yDYgX
 XYCgUmZU0KKPH4LCYAsL0/Rshs0oPcY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-2yYs-Sf-PFGPvP2J7qLAug-1; Mon,
 12 May 2025 06:31:39 -0400
X-MC-Unique: 2yYs-Sf-PFGPvP2J7qLAug-1
X-Mimecast-MFC-AGG-ID: 2yYs-Sf-PFGPvP2J7qLAug_1747045896
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 169E0180035C; Mon, 12 May 2025 10:31:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE36219560AA; Mon, 12 May 2025 10:31:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2EEB221E66E3; Mon, 12 May 2025 12:31:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: zoudongjie <zoudongjie@huawei.com>,  qemu-devel@nongnu.org,
 stefanha@redhat.com,  kwolf@redhat.com,  fam@euphon.net,
 hreitz@redhat.com,  alex.chen@huawei.com,  chenjianfei3@huawei.com,
 eric.fangyi@huawei.com,  luolongmin@huawei.com,  mujinsheng@huawei.com,
 qemu-block@nongnu.org,  qemu-stable@nongnu.org,  renxuming@huawei.com,
 suxiaodong1@huawei.com,  wangjian161@huawei.com,  wangyan122@huawei.com,
 yebiaoxiang@huawei.com,  zhuyangyang14@huawei.com
Subject: Re: [PATCH v3 0/2] qapi/throttle: Fix qmp_block_set_io_throttle
 blocked for too long
In-Reply-To: <47048276-0ef3-4c90-8969-6e58af644fc4@tls.msk.ru> (Michael
 Tokarev's message of "Mon, 12 May 2025 12:40:38 +0300")
References: <20250326092634.1691355-1-zoudongjie@huawei.com>
 <47048276-0ef3-4c90-8969-6e58af644fc4@tls.msk.ru>
Date: Mon, 12 May 2025 12:31:29 +0200
Message-ID: <87wmamqfwe.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> On 26.03.2025 12:26, zoudongjie via wrote:
>> From: Zhu Yangyang <zhuyangyang14@huawei.com>
>> Calling qmp_block_set_io_throttle() will be blocked for a long time
>> when a network disk is configured and the network failure is just about
>> to occur.
>> This series add a timeout parameter for qmp_block_set_io_throttle to control
>> its execution duration.
>> Changelog
>> v3 ---
>>    Unify AIO_WAIT_WHILE_{TIMEOUT/INTERNAL} by replacing AIO_WAIT_WHILE_INTERNAL() with
>>    AIO_WAIT_WHILE_TIMEOUT(..., 0).
>> v2 ----
>>    1. Support 0 in BDRV_POLL_WHILE_TIMEOUT(), 0 means infinite.
>>    2. Use uint64_t timeout_ns instead of int64 timeout to name variables.
>>    3. Use timer_pending() to check for expiry instead of explicitly checking
>>       against the deadline for BDRV_POLL_WHILE_TIMEOUT().
>>    4. Add documentation for bdrv_drained_begin_timeout(), note that bdrv_drained_end()
>>       must be called when -ETIMEDOUT is returned.
>>    5. Add a timeout parameter to the qmp_block_set_io_throttle() instead of hardcoding
>>       the timeout, and the default value is 0, mean an infinite timeout.
>> v1 patch link:
>> https://lore.kernel.org/qemu-devel/20250308101618.721954-1-zoudongjie@huawei.com/
>> Zhu Yangyang (2):
>>    io/block: Refactoring the bdrv_drained_begin() function and implement
>>      a timeout mechanism.
>>    qapi/throttle: add timeout parameter for qmp_block_set_io_throttle()
>
> Hi!
>
> Is this series still relevant?  It's Cc'ed qemu-stable@, but not yet
> applied to master branch..

I understand Zoudongjie intends to respin.

Issues I pointed out:

* Incorrect Since: tag

* Confusing error message

* What other commands could similarly block?

The last one should be investigated, but that need not block the patch.
A partial fix can be better than no fix.



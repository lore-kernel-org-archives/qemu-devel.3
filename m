Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E0DCF0435
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syMys-0007fE-Bs; Tue, 08 Oct 2024 23:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1syMyo-0007f4-W9
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 23:03:15 -0400
Received: from fly.ash.relay.mailchannels.net ([23.83.222.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1syMyn-0002nW-9A
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 23:03:14 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 679A290526F;
 Wed,  9 Oct 2024 03:03:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a279.dreamhost.com
 (trex-3.trex.outbound.svc.cluster.local [100.101.173.103])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 04556905372;
 Wed,  9 Oct 2024 03:03:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1728442989; a=rsa-sha256;
 cv=none;
 b=vrmbO4+aGyPTOk2YnpgYQ5RkS5KTPWaLeBzhSGYiiPSwbN/yGE6YifIyPhSR0NKCT8eTqA
 CkLEkJdCsPiqmZEHAqk4S4eCOQqYdoqtPwQIrJ3f+KPmR5sCE98IdsI+zAUBLTGPqTlujh
 1eHhL1IXu56f7tnX6fEpBRit04E3Q1cIS9CZd0wqDr4iRpK3bs4/LVCi2302yxj962kjge
 6KcBzmdL9trExmkf56VBv25AzHBHKabkeqHgGtLZajJVfnxaqLuQyAoaAVo2YfdUtR83Zp
 juFv3xmBCTqHnw3ReczJypqmb4bGq9nuD4ch8QzP+EhLLzhrnjU6w36oTACaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1728442989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=zuqFRnQ5g+78gWUtlFavQ9YtvH2+ssaWeobdd16OhFA=;
 b=YWk7Az6c5rwH6ug0pCQEdbtKFetF/recpOoLcUbuVXX0Dq6Lgw9eYQK5qUqIuH/cLGVA0D
 Vj0ogKHqQsXDCffbeg/dkqU94E3DoyTCUxR9ALtCGmGi7+hQ4l9e4FeLrpplLdtZuJO4vP
 FmpowHnYLN1XF5IpklMM3y94aGaufAYK1Gj3erO2tl+JfUYLaOlBaA/IxNnyPNoE9RNRDn
 au70uueJDmuVTiBv479NvSMuQ03rRKrDPZm3e5KkKW1Mn9A6XeEuNC7pm+ojIN5wCnq00k
 X5/I/uuTzNls/cz7eNawnvgLMpRd8XXpitIGNgfn+n6tj3yqJ59vHVLdhociJQ==
ARC-Authentication-Results: i=1; rspamd-54f99b5bc4-82m9t;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cold-Invention: 170c03b82291bff0_1728442989287_1477917783
X-MC-Loop-Signature: 1728442989287:1068372020
X-MC-Ingress-Time: 1728442989287
Received: from pdx1-sub0-mail-a279.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.101.173.103 (trex/7.0.2); Wed, 09 Oct 2024 03:03:09 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a279.dreamhost.com (Postfix) with ESMTPSA id 4XNd4D22Nyz2q; 
 Tue,  8 Oct 2024 20:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1728442988;
 bh=zuqFRnQ5g+78gWUtlFavQ9YtvH2+ssaWeobdd16OhFA=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=btZyemQMhHeJllCxNHLhlK1U98FOZK+AUg1Yr9haUrykf98YaejhHUJ9c0e36MkDw
 cW/+6ApTC7cCLvbTUudT1PS/E4Dd/69BU7/SkEk2vF+webrw063F11a6ByD7KqvD+x
 377HhVhehFi2ofAL+irL+XZcdoPoTlV8TVc2KetMaH5kVpO5dYO3O2JogWv7uwsuhO
 uP7hVyZcnJ7sdwvUG1pgewDah56+qP4F8tuCHeye4Nujaye2alhHepFKQvviwhP5Qa
 qlKYHdjX0bl9NkjzLDxb1DRLv0omUIsHC7VtLuhMGmfh3y9Zf0VfNo2W9mn3plLK3s
 D44Pqnti3Sk0A==
Date: Tue, 8 Oct 2024 20:01:07 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com, 
 linux-cxl@vger.kernel.org, a.manzanares@samsung.com, nmtadam.samsung@gmail.com,
 abhi.n@samsung.com, alok.rathore@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [QEMU PATCH] cxl/cxl-mailbox-utils: Fix size check for
 cmd_firmware_update_get_info
Message-ID: <uuxiowlqgqs7mq2dfxixw4ryx4zfbygyaji7axfcln3nstdfed@nufwcfs2nj2a>
References: <20241008164624.78608-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241008164624.78608-1-nifan.cxl@gmail.com>
User-Agent: NeoMutt/20240425
Received-SPF: pass client-ip=23.83.222.61; envelope-from=dave@stgolabs.net;
 helo=fly.ash.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 08 Oct 2024, nifan.cxl@gmail.com wrote:\n
>From: Fan Ni <fan.ni@samsung.com>
>
>In the function cmd_firmware_update_get_info for handling Get FW info
>command (0x0200h), the vmem, pmem and DC capacity size check were
>incorrect. The size should be aligned to 256MiB, not smaller than
>256MiB.

Can get rid of a level of parenthesis (other cmds as well), otherwise:

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>
>Signed-off-by: Fan Ni <fan.ni@samsung.com>
>---
> hw/cxl/cxl-mailbox-utils.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>index 9258e48f95..c82ad50ac8 100644
>--- a/hw/cxl/cxl-mailbox-utils.c
>+++ b/hw/cxl/cxl-mailbox-utils.c
>@@ -649,9 +649,9 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>     } QEMU_PACKED *fw_info;
>     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
>
>-    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
>-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
>-        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
>+    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
>+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
>+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
>         return CXL_MBOX_INTERNAL_ERROR;
>     }
>
>--
>2.43.0
>


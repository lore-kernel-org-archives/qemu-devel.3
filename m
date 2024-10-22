Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27E6D1715C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 03:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t35XX-0005MT-0e; Mon, 21 Oct 2024 23:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1t35XU-0005M5-Rk
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 23:26:32 -0400
Received: from fly.ash.relay.mailchannels.net ([23.83.222.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1t35XT-0007yP-4W
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 23:26:32 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 0E1F68A4DB0;
 Tue, 22 Oct 2024 03:26:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a259.dreamhost.com
 (trex-1.trex.outbound.svc.cluster.local [100.102.182.244])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 8CEAE8A52EA;
 Tue, 22 Oct 2024 03:26:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729567586; a=rsa-sha256;
 cv=none;
 b=p47+uSZr5OnEYhqfslUIj8u1LSgh0lC0zpSSLhihUqDY3FZShlsCG+kmgnFMwf9VV1EJ7c
 VAgm9hdoRIkyQyEYSx1Uyd0nJbQwl/TNkfzXlwc0oTnjZv2Q2Q74GyBD1aw3Mjv9Q4zuAC
 zfObrmjc+Z7hH8/wRolv6tUXx744M08UafXUIIY9bbgPF+J/nZ5q9od0nRjEYR8zOhWgTo
 n1qwDt07ratVSpCzaGSsYi9qnfJfZwfcli+ztTdh+sVwuHj1OyFphCGz+NEYIC1ARKwRvF
 BhKVc8suxO7j1H/rYdFsAjIqHuGTUtiCESg1/bm+Txl4ITOdp2BMy2pqEKW62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1729567586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=lH0MQXykfOQt1lUch/UPd3kSWdAlSp9z3M7wrBCgsKA=;
 b=4COUlfFMfz8BDmOoNe82lq/nOrSbuIWkxWoEuhaTZPwxNuRLgc3wPoi6r2aj4xb2ZhWfCs
 3exm1cHkMqE2HaRuAkBe69sGaHUXjCZ5+ZzLbc1sC4T44YXYN2pVUtaksxp/w0+ubBtQ1Y
 MKCDM2pMX6wHcJRcvQpY1f8QjbbblvbwSWRH02wqCJCenJPSuHftuJaIlTLPquIHpgdID2
 vtpberV7tMGRUwG9fCngSzefEqd4P+bo8hQGghVzBWKGlCUO1xGtM/c9GSDERIRHlwAaNb
 aKmsLkpRYYz59HjHqWaNZAw9uFwBQPTEYeCCCV4UkxtJpnDZT7luBzgvnehCjg==
ARC-Authentication-Results: i=1; rspamd-6bcbdd57f8-cgzfq;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Invention: 1b5f166378ae4e5c_1729567586868_4284065658
X-MC-Loop-Signature: 1729567586868:1895697523
X-MC-Ingress-Time: 1729567586868
Received: from pdx1-sub0-mail-a259.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.102.182.244 (trex/7.0.2); Tue, 22 Oct 2024 03:26:26 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a259.dreamhost.com (Postfix) with ESMTPSA id 4XXcz550lmz1p; 
 Mon, 21 Oct 2024 20:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1729567586;
 bh=lH0MQXykfOQt1lUch/UPd3kSWdAlSp9z3M7wrBCgsKA=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=opkHkLsC0YFqllBezWtlCa0SToTjzP3LCiG1MxP+fZE3lfG+LKIGHzTOp4Miu1ypL
 +7FJ1mfRHGUyIZEs1zW+hbDyo/2gDcKRYo1YPqI/1XE7IgX6YuGeCABaZBUhPvgZSJ
 wdGs0cSmp40qPANv3OHYKvbCKmxucfjx0ZfcEtiVQqzLxotxIQQUni6K9BSm2ZSeuU
 bmCuaAISNkmE6FDeOYUqf6udJlGJXs3AIQNkCV5kMfEtzColHfWzcQKffv6yaVaGoF
 89eeyAg0lg39YessKltYEB2W8t6VTJmPSpdPV1bdewbi4Ou1FtZ/6pSnuh338fwMq2
 d3rZqCt4GJKWQ==
Date: Mon, 21 Oct 2024 20:23:46 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: ajay.opensrc@micron.com, fan.ni@samsung.com, john@jagalactic.com, 
 emirakhur@micron.com, ajayjoshi@micron.com, sthanneeru@micron.com, 
 ravis.opensrc@micron.com, arramesh@micron.com, tmmulgund@micron.com, 
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/cxl: Support aborting background commands
Message-ID: <jdipjanthgt6atlksngodxjevfb5d43d5rshtxqxxwruszqa3e@vctljs77lg4e>
References: <20240813221255.179200-1-dave@stgolabs.net>
 <20240827163357.0000228e@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240827163357.0000228e@Huawei.com>
User-Agent: NeoMutt/20240425
Received-SPF: pass client-ip=23.83.222.61; envelope-from=dave@stgolabs.net;
 helo=fly.ash.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 27 Aug 2024, Jonathan Cameron wrote:\n
>No comments inline and LGTM. I'll queue it on my tree and push
>that out on gitlab sometime soonish.

I don't see this picked up, which is a good thing atm. While testing
the kernel side, I noticed the following is needed, will send a v2
with it folded in.

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 1a9779ed8201..0d429b59aafc 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -94,14 +94,15 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
	     cxl_dstate->mbox_reg_state64[offset / size] = bg_status_reg;
	 }
	 if (offset == A_CXL_DEV_MAILBOX_STS) {
+            int bgop;
	     uint64_t status_reg = cxl_dstate->mbox_reg_state64[offset / size];

	     qemu_mutex_lock(&cci->bg.lock);
-            if (cci->bg.complete_pct == 100 || cci->bg.aborted) {
-                status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, BG_OP,
-                                        0);
-                cxl_dstate->mbox_reg_state64[offset / size] = status_reg;
-            }
+            bgop = !(cci->bg.complete_pct == 100 || cci->bg.aborted);
+
+            status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, BG_OP,
+                                    bgop);
+            cxl_dstate->mbox_reg_state64[offset / size] = status_reg;
	     qemu_mutex_unlock(&cci->bg.lock);
	 }
	 return cxl_dstate->mbox_reg_state64[offset / size];
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d5b084388288..760a8571fda6 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2731,9 +2731,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
      [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
	 cmd_firmware_update_get_info, 0, 0 },
      [FIRMWARE_UPDATE][TRANSFER] = { "FIRMWARE_UPDATE_TRANSFER",
-        cmd_firmware_update_transfer, ~0, CXL_MBOX_BACKGROUND_OPERATION },
+        cmd_firmware_update_transfer, ~0,
+        CXL_MBOX_BACKGROUND_OPERATION | CXL_MBOX_BACKGROUND_OPERATION_ABORT },
      [FIRMWARE_UPDATE][ACTIVATE] = { "FIRMWARE_UPDATE_ACTIVATE",
-        cmd_firmware_update_activate, 2, CXL_MBOX_BACKGROUND_OPERATION },
+        cmd_firmware_update_activate, 2,
+        CXL_MBOX_BACKGROUND_OPERATION | CXL_MBOX_BACKGROUND_OPERATION_ABORT },
      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
      [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
			  8, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },

Thanks,
Davidlohr


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CC1C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 03:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulJJD-0004zF-8h; Sun, 10 Aug 2025 23:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ulJIz-0004wk-7R
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 23:34:38 -0400
Received: from fly.ash.relay.mailchannels.net ([23.83.222.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ulJIw-0004A2-GY
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 23:34:36 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id CFA2541D5E;
 Mon, 11 Aug 2025 03:34:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a236.dreamhost.com
 (trex-blue-7.trex.outbound.svc.cluster.local [100.96.43.79])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 7ABAF437A7;
 Mon, 11 Aug 2025 03:34:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754883268; a=rsa-sha256;
 cv=none;
 b=Nb2ilMRgRC2Re0fbJVGj1rtly8hG2b8mTINNToaQ/xX4H7+a3MIfTvq6doo+2wgvFq37ib
 oP9yV7ECKVoB/mbAwuZG8tO7v27llvmCR9ak3itjhYeNA31DyyPKbwtxqviDQ9FkzRIskH
 fJzp8WFziY4roTIYu3L3qvPHSRQkfnp3W+jrtTnz2jAeyu65Grs/jY3J4NslcBGQ/vBgxu
 VGDYc3Oossh8LxBhRODGo6ml2xJpMK8MZhtrfdyU11A9XdZyBc27vSSr9S8KYV43FRQt19
 +m/PrJsrSczERMZOd4nuFYG3Yo8QUZZM7Tkt2Zn8OyzRA5ArZvqeO2p3iU6zDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1754883268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=F0QSnTgOLesF0aCE7qfgqoYpipQeSin3zJuG38HwYM8=;
 b=w7mGWLeKWrwBQiFNa6skAwShcNJrMOTlvazIkQkJYpGOW41Smogab70021W/gQsdgt6mtH
 8ZoHaFFXYE5MA74mRaWjnomHn4AMXuu10zrGgt1SopYB5QtHZR2dG/PrnrJYrXn/2uLWXs
 T42JjOmuzOUbIebcAsd674HCGrotBCa4RA9Hf9Gvy8B7SKfKucFywcV7XvXoYzWEcPzX4j
 Ik10fGWGpOTY1QkGdLyQK04i8S0Pwi+wyELMUxQbemnm1g1327rW6zyuGj3aJamWZDnMOC
 pa/HoY0KFmNiLzFyrxxtsyL7NXNoBJOBctGDaUimdf2+vh8mnXUKLJftr35rsg==
ARC-Authentication-Results: i=1; rspamd-64567b6586-nb9n5;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reaction-Harbor: 3ba9798a7bf89247_1754883268761_600204874
X-MC-Loop-Signature: 1754883268761:3584875587
X-MC-Ingress-Time: 1754883268761
Received: from pdx1-sub0-mail-a236.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.96.43.79 (trex/7.1.3); Mon, 11 Aug 2025 03:34:28 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com
 [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a236.dreamhost.com (Postfix) with ESMTPSA id 4c0gH76dDNz6v; 
 Sun, 10 Aug 2025 20:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1754883268;
 bh=F0QSnTgOLesF0aCE7qfgqoYpipQeSin3zJuG38HwYM8=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=FZyVd+XCoFqlGgKVRgH6E8JBMBt9OZklwkkmE8/Ug3xNLp7PDT8vxYdpFMO6jxvHH
 HaiPpMOgcRTBx2OK+2Ni+pNvlwShrgvOJLWmhrsi6ovVRQsj5hWVOA882AjI+zm4em
 8PUnNy7VOmuApiXTtTxK3xvk2FsVdr6EyVHuW8eifsaExY6wOlIQ2SmZqo/qgEV0B9
 bfbIZggWO6PBH7HUmPtzf/zJ/LwP0Ra9oHQVbwhXZmRVfXRQtAvJEAfKFXab5f5yuc
 mL1AbxUD3ViMp5/Q/yC1i3UO+EHNTUKrN7PkC+pwbK4t7MSSKOdKiZ7zRGDZ4fBk96
 3XVJ6HP5rO+mA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, alucerop@amd.com, a.manzanares@samsung.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 3/4] hw/cxl: Allow BI by default in Window restrictions
Date: Sun, 10 Aug 2025 20:34:04 -0700
Message-Id: <20250811033405.332295-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811033405.332295-1-dave@stgolabs.net>
References: <20250811033405.332295-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.222.61; envelope-from=dave@stgolabs.net;
 helo=fly.ash.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Update the CFMW restrictions to also permit Back-Invalidate
flows by default, which is aligned with the no-restrictions
policy.

While at it, document the 'restrictions=' option.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-host.c | 2 +-
 qapi/machine.json | 3 ++-
 qemu-options.hx   | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index def2cf75be61..0d17ea3e4c26 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -64,7 +64,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
     if (object->has_restrictions) {
         fw->restrictions = object->restrictions;
     } else {
-        fw->restrictions = 0xf; /* No restrictions */
+        fw->restrictions = 0x2f; /* No restrictions */
     }
 
     fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
diff --git a/qapi/machine.json b/qapi/machine.json
index ac258578e4ab..ea8ba71305b0 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -589,7 +589,8 @@
 #     BIT(2) - Volatile
 #     BIT(3) - Persistent
 #     BIT(4) - Fixed Device Config
-#     Default is 0xF
+#     BIT(5) - BI
+#     Default is 0x2F
 #
 # @targets: Target root bridge IDs from -device ...,id=<ID> for each
 #     root bridge.
diff --git a/qemu-options.hx b/qemu-options.hx
index 1f862b19a676..2da65fad3c9f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -142,7 +142,7 @@ SRST
             -machine memory-backend=pc.ram
             -m 512M
 
-    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]``
+    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity,restrictions=restrictions]``
         Define a CXL Fixed Memory Window (CFMW).
 
         Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
@@ -168,6 +168,8 @@ SRST
         interleave. Default 256 (bytes). Only 256, 512, 1k, 2k,
         4k, 8k and 16k granularities supported.
 
+        ``restrictions=restrictions`` bitmask with the restrictions of the CFMW.
+
         Example:
 
         ::
-- 
2.39.5



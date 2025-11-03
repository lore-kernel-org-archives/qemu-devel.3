Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F6DCCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 19:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG0cN-0001eu-4h; Mon, 03 Nov 2025 14:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1vG0cK-0001ed-2K
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:53:28 -0500
Received: from barb.birch.relay.mailchannels.net ([23.83.209.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1vG0cG-0006qq-0X
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:53:27 -0500
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id C7B41221B91;
 Mon, 03 Nov 2025 19:53:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a475.dreamhost.com
 (100-121-54-118.trex-nlb.outbound.svc.cluster.local [100.121.54.118])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 6334A2218BF;
 Mon, 03 Nov 2025 19:53:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762199596; a=rsa-sha256;
 cv=none;
 b=c/dqitvCk3ndXKPxAnpXa0s34AgsKzXjcJOYjw8ZeHNlIaQ6ngWx0kY/ZD+oc0a9x1TSMB
 inUbc5l31p3GIzJiWSlaAcRZkaLeeMIGXnDr1CUdFPvNfn2qsi7cUTNGSXXh4ww+JtOcb0
 Msrt/HvMBRFD6eXMvvAftSVYVfcvHTVevPNaejRo8O2JKG4WtA0RPLmXPTnq0YnilYI+3Z
 31E6q3mGJa6CQktZj/hwWImktmxkr8rVgHYZDY9Mmy6qm3sncRRr7RaW3bKFbFj7ZYAMo6
 DDrS3dQwx0YL9QdNZvn5GcYdsoYVtnURPy/kdvbTZEwR5axA2gpOzCbdEqjQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1762199596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=FQjOHbqw+x8RahPoFoPvAvgK6wUPO7kC0iLp5em58NI=;
 b=v5QkKaJ67xap64ybu0azPhRylgg3m0WhVyz+pFpNJwgmUar89cyIGcoAV8L/zcnaYRagPK
 sLqMnBOrxqSrjFwQ1UtRLVLm98qEEmaqXxAoUMlLf9AGsK/pPGRUrrabvPKlS09I74ptpD
 5vbwkJK556CM1HYIs1DqP1pXXfaerAU2QeQlo/NQb6IGQQkSVU7Hq2C4Ug1kADdaykLbWX
 g3kdoydyIlpr3GpMO6pXvxFQvEBg2pnlxIQgIehEcrCCMkVavJBFkM4LJ7zwHmPVik/rxw
 JTNOzBGJPoaKDdAxvQ6V+qcv1+JvD1pF+RoPk0iQ9qAP/DEBUDfXnSnC6Gic6A==
ARC-Authentication-Results: i=1; rspamd-768b565cdb-ldg28;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eight-Hook: 0eed352250061745_1762199596680_3080243867
X-MC-Loop-Signature: 1762199596680:1412102824
X-MC-Ingress-Time: 1762199596679
Received: from pdx1-sub0-mail-a475.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.121.54.118 (trex/7.1.3); Mon, 03 Nov 2025 19:53:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1762199596;
 bh=FQjOHbqw+x8RahPoFoPvAvgK6wUPO7kC0iLp5em58NI=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=cVMeNXVSmlhiLCOz+Tuaut1IR4i4AvWPhv3cVeQ+c1i1IH5uazbaTXtocNlmrspsU
 4whXlm2yC4bqCw0BXbYaX9HMTv1i8gfiwu8XLNkqYGDchWVjlGmx7Xqp+BSYZHpo1o
 pfooj9Xz04iPwQUqWAn3ecJ6daYNLHvKi74A6ilhe/hLVw9lm41A+To0GjR2jASays
 dQFwax57TBxhsrTv0Hm2xTvCxhALwRlhMn/V7HK3DVmk7A+vKJQqHS1JbV3r5F+Pyw
 esSaBx9vGw1hCPxHjg6gdl81NJa8wL0sd57neyzAuONxLa8OJv+7S90nCmWVHFaDRx
 nEB0w3Hq8vldw==
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a475.dreamhost.com (Postfix) with ESMTPSA id 4d0j1k6Gm8z1wdm;
 Mon,  3 Nov 2025 11:53:14 -0800 (PST)
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, alucerop@amd.com, a.manzanares@samsung.com,
 dongjoo.seo1@samsung.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 armbru@redhat.com, linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 dave@stgolabs.net
Subject: [PATCH 3/5] hw/cxl: Allow BI by default in Window restrictions
Date: Mon,  3 Nov 2025 11:52:07 -0800
Message-Id: <20251103195209.1319917-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251103195209.1319917-1-dave@stgolabs.net>
References: <20251103195209.1319917-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.209.10; envelope-from=dave@stgolabs.net;
 helo=barb.birch.relay.mailchannels.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-host.c | 2 +-
 qapi/machine.json | 3 ++-
 qemu-options.hx   | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index e420b25176a6..ed0c76a31980 100644
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
index 225690d2986a..85e31432b038 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -555,7 +555,8 @@
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
index 075f4be2e3e6..0f27209aafa2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -147,7 +147,7 @@ SRST
             -machine memory-backend=pc.ram
             -m 512M
 
-    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]``
+    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity,restrictions=restrictions]``
         Define a CXL Fixed Memory Window (CFMW).
 
         Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
@@ -173,6 +173,8 @@ SRST
         interleave. Default 256 (bytes). Only 256, 512, 1k, 2k,
         4k, 8k and 16k granularities supported.
 
+        ``restrictions=restrictions`` bitmask with the restrictions of the CFMW.
+
         Example:
 
         ::
-- 
2.39.5



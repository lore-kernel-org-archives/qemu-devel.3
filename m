Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74591CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 03:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3QxA-00028w-BV; Mon, 29 Sep 2025 23:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1v3Qwz-00025A-JT
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:22:49 -0400
Received: from shrimp.cherry.relay.mailchannels.net ([23.83.223.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1v3Qwq-000282-Me
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:22:49 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 726CE70129B;
 Tue, 30 Sep 2025 03:22:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com
 (trex-blue-2.trex.outbound.svc.cluster.local [100.113.90.84])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id EEE22701406;
 Tue, 30 Sep 2025 03:22:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759202555; a=rsa-sha256;
 cv=none;
 b=0Ul5Ruien2kSpKHn2jCm384i6BCIWmvavKMUhRKq+5ZxFnkDd2Km8JiTuY5fK8MoFM/RB9
 EWd84ZkT47NWNXcqO/FQ1wkx0Wh2SNl1pgaamuGFiGky80EaHjsl8SnOZHQBvQ7S27qHqp
 QLDHbhjAdffAxgi1s4tbCYz7pkzCJwue8uFLGIyxn7qkp0eTWrUSZBTrHmBWYCJwEYwD/t
 HQVwQdWNlV8RASiZ78OFQBolFhL/AB+BzhWZHj9v8kM4X+EDuWl9+yRZJ/WMA/kUJEShcH
 jTqs0fj84BvWIA4aIzMMrkKDzQNHkn84baBH3lVsL+iPO0aBaSZUN2KVor2tGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1759202555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=F0QSnTgOLesF0aCE7qfgqoYpipQeSin3zJuG38HwYM8=;
 b=TMqHu2Ri93H+5dQ2YjY9H2rEJ4m13lqhjNrImCNK1XMH+G99Q8kgtHxniYfeK1kW5ipicy
 4TsrybgTLLFqae19+TlvBAPMmN+ew0C03lCGVOAbPX5slZyxyufT5SVEenBWY4dmZV/PhB
 qlQBP62Fir2LEMY4hgqfJ2hom5nhxBWJj7/oFxHsqRUIzYx24si+3TDqmPMRULuP8z1py4
 gOfMRqw+awSPz4BXbrEEYmOENOMd4gFc+Vk+Rmh9ufn2Ug7yBc1Gvo1QNqZwW8WPBcQDX/
 4KuQsl93eU93zI+UIr/0YlEtkuFN8bJmOVystBjbFGMMhGE8FttVhvs9pK9O8Q==
ARC-Authentication-Results: i=1; rspamd-9695c5dfc-p4zkv;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Versed: 68da6c04334e97d8_1759202555264_1212884388
X-MC-Loop-Signature: 1759202555264:581522535
X-MC-Ingress-Time: 1759202555264
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.113.90.84 (trex/7.1.3); Tue, 30 Sep 2025 03:22:35 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com
 [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4cbNfL1tjLzGS; 
 Mon, 29 Sep 2025 20:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1759202554;
 bh=F0QSnTgOLesF0aCE7qfgqoYpipQeSin3zJuG38HwYM8=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=jKCs+249ODl+OMJQ8q0UIwgAzyfaHcCKnW0NhJZ19uBk6xN7QHcAsk6fZuqm5tFBN
 DhanNshHxb+G9x/kVmLMkWZu/ljcMtAJleRivE2BLw1sSlsgVudjzBzoAI04xQncF8
 0f+9uHeYdsg1+HyQw6u5BSISHL6Q1lEmJg1VjdY0jGAGthPUM2Vu4I5Q+p5Zmq8n9e
 yuC/M+3NB7tEfLExEGL4OVpYolEUqGiDYbnGEZq0NmIdfk2iVpv7K4UBRRl4TOd3DV
 aoJOdBmciA0db2YIbot3ST66PofmsUvhGf2MCdOLY2tNno54qDBSr4PKysxmUwf3p3
 hD7yMUduI3Q5Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, lucerop@amd.com, a.manzanares@samsung.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, dave@stgolabs.net
Subject: [PATCH 3/5] hw/cxl: Allow BI by default in Window restrictions
Date: Mon, 29 Sep 2025 20:21:51 -0700
Message-Id: <20250930032153.1127773-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930032153.1127773-1-dave@stgolabs.net>
References: <20250930032153.1127773-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.164; envelope-from=dave@stgolabs.net;
 helo=shrimp.cherry.relay.mailchannels.net
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



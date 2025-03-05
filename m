Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96613C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxf-0003La-PK; Tue, 04 Mar 2025 20:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxe-00039H-4K
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:14 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxc-0008Sz-7y
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:13 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22382657540so72562105ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139651; x=1741744451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMRtoXKWoktOFhEsg4DGrJQquTSdWQNK2JOTRNo+Qz8=;
 b=jTkZRdGfX1CHd4XBy2M90CJ8mermDpN0SDjyFwgkrG864WeMgZXYyBMgHlTAp+mYtT
 MgyscxoYekIZGPkcBzsyBcf9/BfeZ77SO97coECeBteLe8naHiU+PfDhGn5iDY1CYLYp
 gfGv59+BbLZJNp8HYE11Tyhm8ALaxT02R3TpKoeKvW+uOFsDaTyjY0+OZoNcrGfwSyQD
 ct/VlNGigoywLYKvZrb/jLjape5Hkx4pbT1ODFaXZdLt8c6DDgB2tZE1XSQgkevQSMeh
 Bn1jaIxd1XdwXdtBCLytWuG0ji2x7RYQxm1v9BnGFy6cCbVTK/Tv4snS7eiWZY8GxnuV
 15Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139651; x=1741744451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jMRtoXKWoktOFhEsg4DGrJQquTSdWQNK2JOTRNo+Qz8=;
 b=qCyTgTKmbST0N3YDcsPDOiHcZ29I0ltUCTbY9ndxhf/61U9FYGDYGZm1z6ezdeUEOK
 z3X9mxEc2x+IV3F9rXUIH1nXWHpXGlUmPZwuJkWPwuy3Z0a8R0UCHwN7nyprOm8ZgmPT
 rqvRgfhxQUrYJiXIlNcV/0/vIUfgMDAjoEZrVB3pge61XRev57B3gv8ucQmnDf6ZV8gA
 Q/DwdMSxl5dBlx+l9gVd6uWRikOseh0Oro4n1JGZSBYKMeOaCBGsWqyWVNEELuNg3jlG
 h/x83K6xybPTShFyuW9UeE06y9o2BVrlsvnu4nd8r0+8ExvxOLpQSKK7H8AGgUlkT1/c
 XdRQ==
X-Gm-Message-State: AOJu0YwpkRZ81fk7fKXSEt8dENchafjtUzDFOyZuu++GF2C5QAv7SHpO
 QYDmEVKgFXCfJd5HDh/SA7/lhroFkAO73ul6ySr5IaNztHgpq67rxo0389r0abA=
X-Gm-Gg: ASbGncvZ9RnDCIAEa5OmcVuc5nfX1DF8g4th4QsLbPCapNyp2fTwrZqKOOL06SLGpmj
 3v1R3Eubw5wdVis066EsqjleElkNovZtHzyJwWgMUzhuxIedjft6sJlDCEYYWzQOCBevzL+C8G9
 DRGG+ubRkHkGyHhezKLEzqQommX7ayvpB6f4GSfj+iH0PkWZv7O7Fx7NDhBJGVJXnQkbcGacH+k
 COUeyTVpbPRrApiDT1v7uQn8uu0FLvpFGA1l59Pn+wFf44TIBaYh3oHi/Gcd/EdLgh8lt7bbnAA
 RLE/yIzfVhg0a9zlP6JwVDmgtTepNVBoLArPhCqdhZcjk9H0eOOpCWv4uHiwIAx9bZgNoVvFwx9
 E5SkWGztlHe4+eF+00+glRCq4c7aCGrBua9dWd95obrdv0AASXuU=
X-Google-Smtp-Source: AGHT+IHS3lj2ZerRCD8neS4bfVFrQw5uLSudKrBRG7KRrPZ10NEQkZ02fQK8LRpbFNCYoQ155YgHcQ==
X-Received: by 2002:a17:902:ea0b:b0:223:65dc:4580 with SMTP id
 d9443c01a7336-223f1d3feeemr16398925ad.52.1741139650702; 
 Tue, 04 Mar 2025 17:54:10 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:09 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rodrigo Dias Correa <r@drigo.nl>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/59] goldfish_rtc: Fix tick_offset migration
Date: Wed,  5 Mar 2025 11:52:27 +1000
Message-ID: <20250305015307.1463560-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Rodrigo Dias Correa <r@drigo.nl>

Instead of migrating the raw tick_offset, goldfish_rtc migrates a
recalculated value based on QEMU_CLOCK_VIRTUAL. As QEMU_CLOCK_VIRTUAL
stands still across a save-and-restore cycle, the guest RTC becomes out
of sync with the host RTC when the VM is restored.

As described in the bug description, it looks like this calculation was
copied from pl031 RTC, which had its tick_offset migration fixed by
Commit 032cfe6a79c8 ("pl031: Correctly migrate state when using -rtc
clock=host").

Migrate the tick_offset directly, adding it as a version-dependent field
to VMState. Keep the old behavior when migrating from previous versions.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2033
Signed-off-by: Rodrigo Dias Correa <r@drigo.nl>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250114212150.228241-1-r@drigo.nl>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/rtc/goldfish_rtc.c | 43 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index fa1d9051f4..0f1b53e0e4 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -178,38 +178,21 @@ static void goldfish_rtc_write(void *opaque, hwaddr offset,
     trace_goldfish_rtc_write(offset, value);
 }
 
-static int goldfish_rtc_pre_save(void *opaque)
-{
-    uint64_t delta;
-    GoldfishRTCState *s = opaque;
-
-    /*
-     * We want to migrate this offset, which sounds straightforward.
-     * Unfortunately, we cannot directly pass tick_offset because
-     * rtc_clock on destination Host might not be same source Host.
-     *
-     * To tackle, this we pass tick_offset relative to vm_clock from
-     * source Host and make it relative to rtc_clock at destination Host.
-     */
-    delta = qemu_clock_get_ns(rtc_clock) -
-            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    s->tick_offset_vmstate = s->tick_offset + delta;
-
-    return 0;
-}
-
 static int goldfish_rtc_post_load(void *opaque, int version_id)
 {
-    uint64_t delta;
     GoldfishRTCState *s = opaque;
 
-    /*
-     * We extract tick_offset from tick_offset_vmstate by doing
-     * reverse math compared to pre_save() function.
-     */
-    delta = qemu_clock_get_ns(rtc_clock) -
-            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    s->tick_offset = s->tick_offset_vmstate - delta;
+    if (version_id < 3) {
+        /*
+         * Previous versions didn't migrate tick_offset directly. Instead, they
+         * migrated tick_offset_vmstate, which is a recalculation based on
+         * QEMU_CLOCK_VIRTUAL. We use tick_offset_vmstate when migrating from
+         * older versions.
+         */
+        uint64_t delta = qemu_clock_get_ns(rtc_clock) -
+                 qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        s->tick_offset = s->tick_offset_vmstate - delta;
+    }
 
     goldfish_rtc_set_alarm(s);
 
@@ -239,8 +222,7 @@ static const MemoryRegionOps goldfish_rtc_ops[2] = {
 
 static const VMStateDescription goldfish_rtc_vmstate = {
     .name = TYPE_GOLDFISH_RTC,
-    .version_id = 2,
-    .pre_save = goldfish_rtc_pre_save,
+    .version_id = 3,
     .post_load = goldfish_rtc_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(tick_offset_vmstate, GoldfishRTCState),
@@ -249,6 +231,7 @@ static const VMStateDescription goldfish_rtc_vmstate = {
         VMSTATE_UINT32(irq_pending, GoldfishRTCState),
         VMSTATE_UINT32(irq_enabled, GoldfishRTCState),
         VMSTATE_UINT32(time_high, GoldfishRTCState),
+        VMSTATE_UINT64_V(tick_offset, GoldfishRTCState, 3),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.48.1



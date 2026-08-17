Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72034C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4KT-0006aO-41; Mon, 17 Aug 2026 16:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KI-0006Wz-H8
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KE-0006fw-HR
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:57 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49987fb18c0so20346505e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786999973; x=1787604773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lVttNXKS42d+wwl+Slu+idpuvTC5n4P/eF4nwzzHM7E=;
 b=iZt6tHwABdPxowQcEwJkSUSpHNkw5ocBKWwBFsp/PKbGYVA4CTxrqQ5bvFcvPBWwh5
 CVKPlM4MA3nemh1IPuackndz5msEHWCl81gFclv3aJXLbDQnP0irpWz13FT11Gc8vmdq
 2Yj7tdEwD2qNXmW2b5M1p7n57JnAFzvEZ6RIXX9CMm3VOSORdZ3rVk59w3cooPriNmpx
 q/GWnkewDWf4y+Re6WBJQP8ncPrJUUuIczsdLO0dY8mPF2QbfUMw3Dq+senjwTdN8pg3
 rkDA0YFg6MT3Q+Lw/cB0hcGuMTLfBTntbgP/cnxQmzkZmCyMbNxmOqTFzaU/KhMvv3So
 RPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999973; x=1787604773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lVttNXKS42d+wwl+Slu+idpuvTC5n4P/eF4nwzzHM7E=;
 b=aNFa5fbCR3H+PhI91PsSdSHmex+SmPIIK2+HY+PACeIoYUD0NtCdoBK/lVxnGv79a3
 t8Zm4TVgRoKCbDoKmvuz67HTjhTc+xN/hhUx/HBSG0LJbMrc5LRQ9EP++QjijcP5CpZC
 JAsCuLsebkKFNqDioYSw0pXSS3benUEt9HJcCx00svmxZziCSC8Q9eCpf8V8OW7cQtFR
 GHNm8m2fF6/zAelKgGxg33WRjZrKKig/M5lInMIfzpJpi7eI3ZQyG/SXJPt0uWTVUiMV
 iu7eKJoR0gi7/Kq/HWBTlB3AB7/wYSXO7+PanADGSaCO6M4M4huKRWeJFvQVLUW+mXed
 PNqw==
X-Gm-Message-State: AOJu0YwbiUfuM61loA2qyM7xh3QbqIFszj+5t2gO78X7YBa1TBO5FEla
 /5HUhr6kPopyBLnuvj6gqhfcieYO43Um5KuWLpEhtYYyJCtSjIQOzqLZZtLYvctzbLlHLoYlYwd
 aNeKQ
X-Gm-Gg: AR+sD13arxwa2AWxXEobVSXMb2zd50PnXpZ0MWVm1FlDsiGZM04RHMlLva2GvON6cCo
 oeaZ7S/LgW4j1a7eM9rpDoDwzT2gXP0EMwsoIJmXFKeHwFhiPBLKkCNdyht4yua+8vArJY2uLBo
 +A3PEbePo8hnsXV810m+GkP4dYNWSkA+J9UFIz+upumO7EXupEHvZk2NRlZOsBg9yp1Y7EywocO
 fMmkESNcF05P0P5N3fu8UNuUhDg+zBni9NeU7CZrrXctMp2LnTJF5zVic4MGqR927GQg/X/OpbU
 JCkNA01rWhOfPCxUkF+XH+QnqWhMZ+M/dO8gS9bdlgoagvJG8icSR+w/VDzvrDWhp3hVv/qmBMo
 BsVe+yPUZaEDEUGbROLDxQslqj9j3VdAUr4lgM7bab6LbYgsHkcaWGjXuxSLBh/d3Oj7kBdvzdx
 BEIq8aIE+Cchrn7ZoUoQmrI6Y0fwESPWqVO+XmWLP8JIL+Iht72w==
X-Received: by 2002:a05:600c:3b2a:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-4999fb4f219mr46730245e9.15.1786999973071; 
 Mon, 17 Aug 2026 13:52:53 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm202573365e9.6.2026.08.17.13.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:52:52 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 06/15] hw/ide: keep the IDENTIFY DEVICE current geometry in
 sync
Date: Mon, 17 Aug 2026 22:52:33 +0200
Message-ID: <20260817205242.1199851-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817205242.1199851-1-den@openvz.org>
References: <20260817205242.1199851-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=den@openvz.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Denis V. Lunev <den@openvz.org>

Bit 0 of IDENTIFY DEVICE word 53 says that words 54 to 58 describe the CHS
translation in effect, and ATA-5 8.16.8 has INITIALIZE DEVICE PARAMETERS
set words 55 and 56 to the heads and sectors per track it was given. The
data is built once and then cached, so those words kept describing
whatever was in effect when a guest first asked for IDENTIFY DEVICE: the
device reported one geometry while addressing the medium with another, and
nothing reported an error. The revert SET FEATURES 0xCC asks for on the
next reset left the same disagreement.

Do not drop the cached data on a change, as parts of it are guest state
rather than a description of the drive: SET FEATURES records the write
cache setting in word 85, which ide_drive_post_load() reads back after
migration. Update the affected words in place instead, the way
ide_identify_size() does for the capacity words, and share the code with
the two places that build the data.

An ATAPI device has no translation but does take SET FEATURES 0xCC, so
leave its IDENTIFY PACKET DEVICE data alone, where those words differ.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index befbab9486..9959437a63 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -110,6 +110,18 @@ static void put_le16(uint16_t *p, unsigned int v)
     *p = cpu_to_le16(v);
 }
 
+static void ide_identify_chs(IDEState *s)
+{
+    uint16_t *p = (uint16_t *)s->identify_data;
+    unsigned int cur_sec = s->cylinders * s->heads * s->sectors;
+
+    put_le16(p + 54, s->cylinders);
+    put_le16(p + 55, s->heads);
+    put_le16(p + 56, s->sectors);
+    put_le16(p + 57, cur_sec);
+    put_le16(p + 58, cur_sec >> 16);
+}
+
 static void ide_identify_size(IDEState *s)
 {
     uint16_t *p = (uint16_t *)s->identify_data;
@@ -128,7 +140,6 @@ static void ide_identify_size(IDEState *s)
 static void ide_identify(IDEState *s)
 {
     uint16_t *p;
-    unsigned int oldsize;
     IDEDevice *dev = s->unit ? s->bus->slave : s->bus->master;
 
     p = (uint16_t *)s->identify_data;
@@ -158,12 +169,7 @@ static void ide_identify(IDEState *s)
     put_le16(p + 51, 0x200); /* PIO transfer cycle */
     put_le16(p + 52, 0x200); /* DMA transfer cycle */
     put_le16(p + 53, 1 | (1 << 1) | (1 << 2)); /* words 54-58,64-70,88 are valid */
-    put_le16(p + 54, s->cylinders);
-    put_le16(p + 55, s->heads);
-    put_le16(p + 56, s->sectors);
-    oldsize = s->cylinders * s->heads * s->sectors;
-    put_le16(p + 57, oldsize);
-    put_le16(p + 58, oldsize >> 16);
+    ide_identify_chs(s);
     if (s->mult_sectors)
         put_le16(p + 59, 0x100 | s->mult_sectors);
     /* *(p + 60) := nb_sectors       -- see ide_identify_size */
@@ -321,7 +327,6 @@ static void ide_cfata_identify_size(IDEState *s)
 static void ide_cfata_identify(IDEState *s)
 {
     uint16_t *p;
-    uint32_t cur_sec;
 
     p = (uint16_t *)s->identify_data;
     if (s->identify_set) {
@@ -329,8 +334,6 @@ static void ide_cfata_identify(IDEState *s)
     }
     memset(p, 0, sizeof(s->identify_data));
 
-    cur_sec = s->cylinders * s->heads * s->sectors;
-
     put_le16(p + 0, 0x848a);                    /* CF Storage Card signature */
     put_le16(p + 1, s->cylinders);              /* Default cylinders */
     put_le16(p + 3, s->drive_heads);            /* Default heads */
@@ -350,11 +353,7 @@ static void ide_cfata_identify(IDEState *s)
     put_le16(p + 51, 0x0002);                   /* PIO cycle timing mode */
     put_le16(p + 52, 0x0001);                   /* DMA cycle timing mode */
     put_le16(p + 53, 0x0003);                   /* Translation params valid */
-    put_le16(p + 54, s->cylinders);             /* Current cylinders */
-    put_le16(p + 55, s->heads);                 /* Current heads */
-    put_le16(p + 56, s->sectors);               /* Current sectors */
-    put_le16(p + 57, cur_sec);                  /* Current capacity */
-    put_le16(p + 58, cur_sec >> 16);            /* Current capacity */
+    ide_identify_chs(s);                        /* Current C/H/S and capacity */
     if (s->mult_sectors)                        /* Multiple sector setting */
         put_le16(p + 59, 0x100 | s->mult_sectors);
     /* *(p + 60) := nb_sectors       -- see ide_cfata_identify_size */
@@ -1361,6 +1360,10 @@ static void ide_reset(IDEState *s)
         s->reset_reverts = false;
         s->heads         = s->drive_heads;
         s->sectors       = s->drive_sectors;
+        /* An ATAPI device takes SET FEATURES 0xCC but has no translation */
+        if (s->identify_set && s->drive_kind != IDE_CD) {
+            ide_identify_chs(s);
+        }
     }
     if (s->drive_kind == IDE_CFATA)
         s->mult_sectors = 0;
@@ -1669,6 +1672,9 @@ static bool cmd_specify(IDEState *s, uint8_t cmd)
 
     s->heads = (s->select & (ATA_DEV_HS)) + 1;
     s->sectors = s->nsector;
+    if (s->identify_set) {
+        ide_identify_chs(s);
+    }
     ide_bus_set_irq(s->bus);
 
     return true;
-- 
2.53.0



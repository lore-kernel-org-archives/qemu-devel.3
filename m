Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6742C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzhu-0006uW-Dx; Thu, 20 Aug 2026 06:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhq-0006sH-Li
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:06 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzho-0008NI-Rz
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:06 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4956869750eso13229845e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220543; x=1787825343; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GiST71Yts4LfFL9lI6doSLjjmUxdiZhCirIUAPAqYHk=;
 b=c1TlBH+mgED15qwF47cia/aBcxGutdGGKMylyaOZ1AGKNOsJiRLxiJynb1NkO25p+k
 DkkecFrAZG+peTlfQ0yxjXoqsTdDVSOBF7CHgbQaKgIOEK2sO7h8sxFscZ/CT+x/XZy5
 KTlJsNG5I5s7o9yHf0CwlsQOUIqRHNKSX2Rldn/8DOEqkT9psEyP9PSrYxMSoflHvKiA
 +bZ4UHyf73v1V1MZmqewX+Gf1DLWACrKJ9XsaZhRNjaj7Zo6x6eR3Wle+//lfbzC4q8d
 1w62skBEXpZTuCamEdd5wJ3SswVYFhnYJr+W61Kz5Gev0L3X3XinkMyl/7CfNGkHwUTM
 rP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220543; x=1787825343;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GiST71Yts4LfFL9lI6doSLjjmUxdiZhCirIUAPAqYHk=;
 b=BtdeE6C18fvbfH3zWmkIZVhWN81qZymp5tWHWxNN//ZDSfSSvapKW8nwcNFwRDoPxW
 Sc4UzC7OcxTqPNxp4PicgEOLEwJuMo8KAGSdBuuFQlQ7p0vwbeHsxqnT4PtBCUh+4L/f
 /6Qn4HNnVkQ4JCa4l79NNuAQxbv5SYYU/zF9M3fLoy34w5RUsKZLo66O4dh594DB6Boo
 A8sGTk8oC1PH+KVWEFZqhMGnZbo0KzQG4Ow+n2/PZGMyGjFH8CN7GzAjJ3Blv/BRbhwT
 AharrtHySl/Lr97BjeFBmuWH66yinnJxVgUdSsDfeVxI0KVXC7UGd1VPnojlQbBmrjsM
 38og==
X-Gm-Message-State: AOJu0YwOH6JYAKOMNZbh7pudRerswu8qOg3qq2CMpFQSMzOmCBln6GIP
 YNZbWKvsdaVldi/Js03c1Sm3eKxbC7QZhruaV+sJ7jC6G63a4OOGZ4UmoZbBnEwl8HQs9JaojQJ
 43eoo
X-Gm-Gg: AR+sD13wj3ARYk8gKvGPmH/tbWgVI4DWG45PvRcxxNohqJ7wLy18+RX6BZ4+T57PuF/
 pyAAlcaAmg8NM9hddIjhXPmBHpnvu9L15VnEeBcoswpLbwqXEDLOS5Hng1FlGtjp3FZVyqeu6PJ
 cy3j0KX0GmNXim6O5KPQXHhKGfUdZOGTx9G6H2Fh4YXO0FuBl4SkRHbPpxH5djWxRiMiuwbK7Vw
 1g7jOd3PPcF9CbewTOUo4Be75oWRq2OgcOTAu0GSYW6qf58JLWVZrFeeeDgEXpi57j0JufO7AsW
 NsATSgX2SO/F5e26VnV8Mo92jsx6KsQ5rhDEap6C5QmixcTFfNrLIU4Yi8RTwqeR0GK3R+B/l1S
 uVYb5MuDpXgVpOHJpMpjtpkF0FOxN48XvAa7NRiLa52o0wxEMGj4xRZGN8giwysOvMQClppj/+f
 dKssdhfEXgvCH8D+k8kre1zlkNtkKv0LBqslpRwua3fN+qTtPjKV+NPAGCGxTbo/skK1Fs
X-Received: by 2002:a05:600c:1387:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-499aa1a47cfmr160947685e9.7.1787220543396; 
 Thu, 20 Aug 2026 03:09:03 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:09:03 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 09/17] hw/ide: restore the power-on device state before
 loading
Date: Thu, 20 Aug 2026 12:08:36 +0200
Message-ID: <20260820100844.411717-10-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
References: <20260820100844.411717-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=den@openvz.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Loading a snapshot reuses the IDEState of the machine it is loaded into:
load_snapshot() resets the machine and then feeds the stream into the
existing devices. The reset does not help, as ide_reset() restores the
logical CHS translation only when the guest asked for power-on defaults to
be reverted with SET FEATURES 0xCC.

A guest that replaced the translation with INITIALIZE DEVICE PARAMETERS
therefore keeps it across the load of a snapshot taken before it did,
while the restored guest expects the geometry of that moment. Every CHS
access then lands on a sector other than the one asked for, with no error
reported. s->reset_reverts survives a load the same way.

Add a pre_load restoring the defaults, which
docs/devel/migration/main.rst recommends for state a stream need not
carry, and which the following subsections rely on. The
RESET_TYPE_SNAPSHOT_LOAD marking that reset would be another way to
recognise the case, but no IDE controller can see it while they all use
device_class_set_legacy_reset().

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 048655b2d0..28219f5ef8 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2863,6 +2863,18 @@ static int transfer_end_table_idx(EndTransferFunc *fn)
     return -1;
 }
 
+static int ide_drive_pre_load(void *opaque)
+{
+    IDEState *s = opaque;
+
+    /* The subsections below are sent only where the guest replaced these */
+    s->heads = s->drive_heads;
+    s->sectors = s->drive_sectors;
+    s->reset_reverts = false;
+
+    return 0;
+}
+
 static int ide_drive_post_load(void *opaque, int version_id)
 {
     IDEState *s = opaque;
@@ -2986,6 +2998,7 @@ const VMStateDescription vmstate_ide_drive = {
     .name = "ide_drive",
     .version_id = 3,
     .minimum_version_id = 0,
+    .pre_load = ide_drive_pre_load,
     .post_load = ide_drive_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32(mult_sectors, IDEState),
-- 
2.53.0



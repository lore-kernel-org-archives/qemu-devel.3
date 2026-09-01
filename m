Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EE1C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1OMz-0000w7-EK; Tue, 01 Sep 2026 09:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OMv-0000vW-0S
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:41 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OMs-00076n-BW
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:40 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c25366c9b42so102254766b.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268656; x=1788873456; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ygClSMwDjEFyP3afUj3IeO5rZvDHlKl8+PhkVw27Jz8=;
 b=kXlmQ8U4gmWnjTBK8umJk/ujrd7wNL3T7FuMJ/VOtAAOlDyqzZo4K+lKCt51avelr/
 VLnR00aMFFtTH9RrdyMiAf3dL2wplhwUXZeD4AR19hxxsYuaV1Adtu4lyteJ4jla/2Wu
 SuKY7ekK59uyxgdhSKgW0O6cj2XAx/KwGvJzHS0n2/Gib+bVNnC9XV3rDyI5IujtMWYN
 T3h2WQQgRPyYlhIZOLcV+jYaBmh2mJ7VxDOVb12C42WPrs8OazEqtw3n4BQASwUnPo5o
 LghHwxOWfC14+OGNBUwpNpmPF9OnM+dG2MlxCHK1Ov565xWTCZ7cLaNydbcV01i9mdxx
 2UlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268656; x=1788873456;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ygClSMwDjEFyP3afUj3IeO5rZvDHlKl8+PhkVw27Jz8=;
 b=LDpk2TtIiF0SmXgsoCEbczxpP443i+/hnBsKnsXziJUgO0CPIZorGPu8D9KhXkBusM
 dFgpsO66NfmsTpeiV8ya3CxDCReGURHMOr+2rWXrekGzB9m0JPzbyqAVMI3z/0q4tG8c
 8+i4YFSX/PNEbz+cJX/ac0JmiZnzgpIgSgyJ2VtjClxRioTOUzgZ5iso8iUTRpDRJrNl
 e/s70PNpgxInSoOHJ3zN9vtrflWmU5OBfSvMfgTQU3G7cZiYfpMksDEbldB8bnLKvZkl
 UKBq2F0TBGkHeVP5/oGdz1ZK4l22/7qAcpzoiNQsbv/cMLRSMHrGIbOZRYkxsN/qJV8j
 zydQ==
X-Gm-Message-State: AFuF++mfpzFcAWNCFJyW0xksXwzjaTg8UQwRodM77FlwuwkWXnZ3ezNy
 lbX2EMqC1L7+6rVz8StlLH0yRPh/4StNKcngzMwZWcfEGlq+qeZWWdLZEBW7S+7+xZjhzrv9oXo
 ytQKS9gA=
X-Gm-Gg: AR+sD104Z2RHsjNkEVrJ0Gba1hjv6YDNpMVacQyQXucY/F1bgj2aYqAPJh+qlR919Rd
 68Hj0drRFIyGEsA6OvLHN4sQOViW68uaQFHPBBlsyDnutTB/DHsd05mtHj3SxZFUCVY96caRFpk
 b/XwqLGpad3bV2fHS3RvOflIUCxPsXZKI5mLf1h+x2Z7KbtOLLf9l3srr5pc7Ps4EkIIq7P7JKT
 xdSmo3uTWxkN4fssrrJ+tBBcNcELtmMH4kEh/+ucNWFOFINEB6B2zkfj6YCdli3337GsTJqsshm
 8ELOexDKsUOoNdYj1dSlPo+BOA9LNA49vnd5J5qVvlNjSoqCVYBMckJHYvZ4049RS9HvHEwwURG
 t75ZpoIYa1XlSO7b4CNf+oEy69Kc7nT2A/QB0cp9KYgrG9QYl2PHDdlOBYNHmKS/1vBv2sMAjqD
 pB1UuNbG9Esj1uG1qdZw+BzuM8fMFNHYypbDNo3QSYgjSIFy1FJW3Rw9IWDztp5DbmH0ZbgLzoK
 UTfU1sDNzQLXydgWXpB5JNEm0RYGZb8VLOXC+/HQtoqIZcM6ruOPZWaRlwSDf9uAA4xbCk=
X-Received: by 2002:a17:906:730e:b0:c25:254:292e with SMTP id
 a640c23a62f3a-c25567a9274mr2115403966b.0.1788268655129; 
 Tue, 01 Sep 2026 06:17:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/58] hw/char/pl011: support backend hotswap
Date: Tue,  1 Sep 2026 14:16:35 +0100
Message-ID: <20260901131732.2263947-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Currently, when Incus issues "chardev-change" QMP command to change
chardev backend from ringbuf to socket it receives an error (with aarch64 VM):
"Chardev user does not support chardev hotswap" [1], [2]

Let's fix this by properly implementing BackendChangeHandler for pl011.

Please, note that we have to "replay" CHR_IOCTL_SERIAL_SET_BREAK, because
if BRK bit was set before backend change (i.e. (s->lcr & LCR_BRK) is true),
then after change we need to send break to a new backend too.

Link: https://discuss.linuxcontainers.org/t/unable-to-connect-to-vm-console-on-arm-architecture/23096/3 [1]
Link: https://github.com/lxc/distrobuilder/issues/892 [2]
Reported-by: Stéphane Graber <stgraber@stgraber.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Message-id: 20260821104832.151452-1-alexander@mihalicyn.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/pl011.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index cb12c3e224f..5ad9e7358d5 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -425,6 +425,11 @@ static void pl011_loopback_break(PL011State *s, int brk_enable)
     }
 }
 
+static inline void pl011_set_break(PL011State *s, int brk_enable)
+{
+    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK, &brk_enable);
+}
+
 static void pl011_write(void *opaque, hwaddr offset,
                         uint64_t value, unsigned size)
 {
@@ -462,9 +467,8 @@ static void pl011_write(void *opaque, hwaddr offset,
             pl011_reset_tx_fifo(s);
         }
         if ((s->lcr ^ value) & LCR_BRK) {
-            int break_enable = value & LCR_BRK;
-            qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
-                              &break_enable);
+            bool break_enable = value & LCR_BRK;
+            pl011_set_break(s, break_enable);
             pl011_loopback_break(s, break_enable);
         }
         s->lcr = value;
@@ -660,12 +664,29 @@ static void pl011_init(Object *obj)
     s->id = pl011_id_arm;
 }
 
+static int pl011_be_change(void *opaque);
+
+static inline void pl011_set_handlers(PL011State *s)
+{
+    qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive,
+                             pl011_event, pl011_be_change, s, NULL, true);
+}
+
+static int pl011_be_change(void *opaque)
+{
+    PL011State *s = opaque;
+
+    pl011_set_handlers(s);
+    pl011_set_break(s, s->lcr & LCR_BRK);
+
+    return 0;
+}
+
 static void pl011_realize(DeviceState *dev, Error **errp)
 {
     PL011State *s = PL011(dev);
 
-    qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive,
-                             pl011_event, NULL, s, NULL, true);
+    pl011_set_handlers(s);
 }
 
 static void pl011_reset(DeviceState *dev)
-- 
2.43.0



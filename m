Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA27CA0FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 17:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqxoF-0007ez-JN; Tue, 26 Aug 2025 13:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqxoC-0007eA-05
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 13:50:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqxo8-0007JR-LV
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 13:50:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b629c8035so13892545e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756230602; x=1756835402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1HfxVQSdyJU0XBGoJ8Qiv44nVAIeSbVvsYi/MkYoFA=;
 b=w7/uw8zzcIjWR9YCuCdBcHeLaypW0FkZ+ehLdgIrwHFq41N851u17goEz1o1zO0KyF
 uNf6qaMhYKCnCjbSqotE+6lU7Mgpk8GyGzLFBjzMqlyLmbNkRmeIkxOiely6VxUEnKcA
 M6YqytsX1DXNszip5L0kkXBho6ZVnJCTEktEGZczKH31NqNxeOm3uknQb2jnx6mIVBuq
 qi+5yFWS44/kadpAoh0w+fLt3x2ePyTVZnD9/QzuRtTUnoYhmwBC78htYAIT8bUgG5jM
 HqKVp/+jlEQBQhtRqrSNTIuKwKK/pCcGRHr6NxTd21hTbt5hvleCquXq/+XngsfWxwye
 pzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756230602; x=1756835402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1HfxVQSdyJU0XBGoJ8Qiv44nVAIeSbVvsYi/MkYoFA=;
 b=bO6Qopu2g0ioSz90SxcNcFFIXg3Lj0Roi34j5l0vQViTY1th+8PXJsTocb1g0k4Sxq
 4WeQkcd7aoYq+srt4JzTfCkSwFGhDa+zUEsu09UoheTkLNH4AU8NlzHagQzvibZYq42C
 /xIjYisIWtcun0rgzHwJ0RBNTRMgFkpJuZpKHM0ZQwz8ODf6XebLv6AA+1/6asQcS5pk
 kP0dm2NvPek8KGPeF9p5ijWzYFNdjTonF39k+5mbPaoSYMzwPXAPJzMZJQ4dtdSeOinN
 +UevKkH5M3pG8vWN412+cDNDOeZJUO88qWfKfSEl9d+R44ntWjfN0rN+idMg+Z1tbbwv
 Hzww==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+RIo2mtTz4FwUuRcAMApWz2D1meE1JWPBAN0MMa4jZmLOxLk16mSaarvyPUiARrQrYBAISY+LjR/L@nongnu.org
X-Gm-Message-State: AOJu0YwwBAWwYhC2TGoxRVN1axUQ499+3H0z9f3KMo/TJkWmRyZtQ6Li
 ZAaBJxs1XEZtE6iV1Dyk6S+d3Euf9YqqHMSdgjIRZ/N4p94jyTlWmeSYSRT0IIvjLw4=
X-Gm-Gg: ASbGncsoMoxfUD3dqMYqyWQ9G4KcvhR0/+/zRsAUsvf6BYb7+7VZUo19L3OXH8JH4Q6
 3RaLg/U0Pubeg2B+/W4VZ+zX0c25bsJfQGtF/rDDPtb2cuTerH7evP/XxKJPNYOnfY9QYF9hrak
 fXgTaA1sUgeO3GE0OAPeI8rsBfK1ImJJi8H2YovKGZ15j00Gexc54Qc+BW83OUzwVL7HL2nDBNE
 oMG5yrtH8fZ/nHUYFuD3QrUu0lOmZxRe77TqBzZbvNKeHbVkoKIs1g2oIq/Nss8Fin606++y3My
 jPTxeF04Q8GG1U1kSKbS+yTx3So5BYlMPDexQyj0oJ1iiR1HAK2ylRmu1YOTafw+AQOHka25O2S
 BpzYAKIjOKDpexAIOZlKWWcpQ0OpgKFYTu/IHRrERV+XpclE0Xw==
X-Google-Smtp-Source: AGHT+IGAeP4yyb8pKmZ9PabKABgqh7hvmUCViyJAXfxrBhuvTANVF9HkEBHxvZFcZQcOuscu2+QQBQ==
X-Received: by 2002:a05:600c:45c8:b0:45b:627a:60c7 with SMTP id
 5b1f17b1804b1-45b627a62e6mr70324575e9.6.1756230601829; 
 Tue, 26 Aug 2025 10:50:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6c5356a7sm2593435e9.15.2025.08.26.10.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 10:50:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH 2/2] hw/display/xlnx_dp: Don't leak dpcd and edid objects
Date: Tue, 26 Aug 2025 18:49:56 +0100
Message-ID: <20250826174956.3010274-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826174956.3010274-1-peter.maydell@linaro.org>
References: <20250826174956.3010274-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

In the xnlx_dp_init() function we create the s->dpcd and
s->edid objects with qdev_new(); then in xlnx_dp_realize()
we realize the dpcd with qdev_realize() and the edid with
qdev_realize_and_unref().

This is inconsistent, and both ways result in a memory
leak for the instance_init -> deinit lifecycle tested
by device-introspect-test:

Indirect leak of 1968 byte(s) in 1 object(s) allocated from:
    #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c5
3fecd904ba5fc1f521d7da080a0e4103b)
    #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x5aded7b9211c in object_new_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:767:15
    #3 0x5aded7b92240 in object_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:789:12
    #4 0x5aded7b773e4 in qdev_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/qdev.c:149:19
    #5 0x5aded54458be in xlnx_dp_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/display/xlnx_dp.c:1272:20

Direct leak of 344 byte(s) in 1 object(s) allocated from:
    #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c53fecd904ba5fc1f521d7da080a0e4103b)
    #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x5aded7b9211c in object_new_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:767:15
    #3 0x5aded7b92240 in object_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:789:12
    #4 0x5aded7b773e4 in qdev_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/qdev.c:149:19
    #5 0x5aded5445a56 in xlnx_dp_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/display/xlnx_dp.c:1275:22

Instead, explicitly object_unref() after we have added the objects as
child properties of the device.  This means they will automatically
be freed when this device is deinited.  When we do this,
qdev_realize() is the correct way to realize them in
xlnx_dp_realize().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/xlnx_dp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 7c980ee6423..ef73e1815fc 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1267,14 +1267,18 @@ static void xlnx_dp_init(Object *obj)
     s->aux_bus = aux_bus_init(DEVICE(obj), "aux");
 
     /*
-     * Initialize DPCD and EDID..
+     * Initialize DPCD and EDID. Once we have added the objects as
+     * child properties of this device, we can drop the reference we
+     * hold to them, leaving the child-property as the only reference.
      */
     s->dpcd = DPCD(qdev_new("dpcd"));
     object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd));
+    object_unref(s->dpcd);
 
     s->edid = I2CDDC(qdev_new("i2c-ddc"));
     i2c_slave_set_address(I2C_SLAVE(s->edid), 0x50);
     object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid));
+    object_unref(s->edid);
 
     fifo8_create(&s->rx_fifo, 16);
     fifo8_create(&s->tx_fifo, 16);
@@ -1311,8 +1315,8 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
     qdev_realize(DEVICE(s->dpcd), BUS(s->aux_bus), &error_fatal);
     aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
 
-    qdev_realize_and_unref(DEVICE(s->edid), BUS(aux_get_i2c_bus(s->aux_bus)),
-                           &error_fatal);
+    qdev_realize(DEVICE(s->edid), BUS(aux_get_i2c_bus(s->aux_bus)),
+                 &error_fatal);
 
     s->console = graphic_console_init(dev, 0, &xlnx_dp_gfx_ops, s);
     surface = qemu_console_surface(s->console);
-- 
2.43.0



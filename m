Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB203C678DA
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyXB-0006ZS-Sj; Tue, 10 Jun 2025 08:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyWy-0006XP-9y
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:56:44 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyWw-0002Xj-CO
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:56:44 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4f71831abso5101855f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560200; x=1750165000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCAoRynAhXP/FtzNeSWR7cVQ7ENbVKgTaL7aafDN9GY=;
 b=grHIlSlp8Hiqfs7X+wMH1usT8PVDnyJQeU7lcgsuI5JD2Kunod/kZIxZPtbxi4F32x
 MpawQeGoytbxko7b5QnjG+OnF7KWDhMTP2NOy7hxAbRbytpnxObod+2v7aRCtl2O6Xsv
 M6Gng9sa8tp+QmHKDWL/5wbkvtH0ax3d0lfp4Bp53IOVreex+XC/SiO3+fN73uV6KRo8
 QeaPfEGUfsPaTCf1gufDj5Et0nqVHMoRNZqO+Bgn4VgCIkh/2mbuq+92x0H2Hr7lUn0S
 xcFb1fPcdU9xhMlOf3mKskxtJCUnssJSoweEW+pFrqHJPZAZNOdGVUx7kWW9XEp25Cp1
 s5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560200; x=1750165000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zCAoRynAhXP/FtzNeSWR7cVQ7ENbVKgTaL7aafDN9GY=;
 b=fee6iKpdKAdpSnEj0f1EoIt9aRPaE7uk8qjMBSRHI4DSyhzzv1s99uf9OTQVLGNHOB
 TMu+egZhzrQi9JufFsQ6n9ASE3Ug8Ty6pOBQsZyD3aGU/yvL9GTajuEn50QUc9QY6LKP
 Xk3XU+hpTcPh70zntznUKbKSlJp28y4IC5/s8QnbJmXHHVHPiy1OD/rhuNNmLvFWMITT
 LPczpVwen7+Tawnp773nFumiw55Gj53UoKcDxJsHRiBAlIZvBbuyaX64tYhx3JsBXk4c
 AelZyMX6MyrVZ2SqyJ/KHeDbt1I5Pn1yqvLo+YOMZHgJwBhgcWN1o+y6mduqH4dLGC2p
 E9Ng==
X-Gm-Message-State: AOJu0YwjeP3cDzLTwyYLyVT0+iyNJ920AI8JD9E1KtzahVS7Ua0mkyXj
 i0o7AxqdqUod7A5MacOmUBVk49tx2rdC193WOqEZFwTRosyp5OXeW5hYbmR/K4BTuVp5dsnsLZv
 6hFH9cBo=
X-Gm-Gg: ASbGncs48MxEML2bVpkHfY4P2uBDjjTQtYzFTUZ6miCNZRmOIA5Ldoatf9V+eu1w8pk
 0hdLlCl4JdYAPuhnLJECADFh3llN/U/8+10We+/PLO5fydUQKuKgOxRJ1ssQ7dLpWcIJrvk5M38
 8LufUsAv1oECIh/vNsf1NJZ2vRBF495im/fEvedmwSt4EBJiuR+mcXHCbpwbDpkYoHIH5iWJVY7
 9Ab4E9y3gmaHp7y+Z6+qi+1ZhOkbjRX6Cc7FcR/WL7SKxEiGPmqm9xnJg0ApvqA3pCPKdl30TIs
 Wo1VMMRX1NvtsKv5NV2k4zbxzMAN9d9DFW+rP+PTvLMSkuqqhQ3PpOgfL8NIB0DCpUfNN7bx4nC
 254WTVevtjpDEUS8MKEPZL8779i0EL09qigc+a31Dyg==
X-Google-Smtp-Source: AGHT+IG4zciNstSC4oLvNF/eFKXYhm46Sou4+bCOE0BUs2XtgP5epq+W9koDgf+fRhbLebA6TOq+YA==
X-Received: by 2002:a05:6000:22c4:b0:3a5:2f23:3789 with SMTP id
 ffacd0b85a97d-3a53188d5cfmr13084855f8f.15.1749560199910; 
 Tue, 10 Jun 2025 05:56:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323c0819sm12047494f8f.45.2025.06.10.05.56.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:56:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/24] hw/char/sh_serial: Delete fifo_timeout_timer in
 DeviceUnrealize
Date: Tue, 10 Jun 2025 14:56:10 +0200
Message-ID: <20250610125633.24411-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

fifo_timeout_timer is created in the DeviceRealize handler,
not in the instance_init one. For parity, delete it in
DeviceUnrealize, rather than instance_finalize.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20250124175053.74461-2-philmd@linaro.org>
---
 hw/char/sh_serial.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 6abd80386fb..cdaeac7b709 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -434,9 +434,9 @@ static void sh_serial_realize(DeviceState *d, Error **errp)
     s->etu = NANOSECONDS_PER_SECOND / 9600;
 }
 
-static void sh_serial_finalize(Object *obj)
+static void sh_serial_unrealize(DeviceState *dev)
 {
-    SHSerialState *s = SH_SERIAL(obj);
+    SHSerialState *s = SH_SERIAL(dev);
 
     timer_del(&s->fifo_timeout_timer);
 }
@@ -445,6 +445,10 @@ static void sh_serial_init(Object *obj)
 {
 }
 
+static void sh_serial_finalize(Object *obj)
+{
+}
+
 static const Property sh_serial_properties[] = {
     DEFINE_PROP_CHR("chardev", SHSerialState, chr),
     DEFINE_PROP_UINT8("features", SHSerialState, feat, 0),
@@ -456,6 +460,7 @@ static void sh_serial_class_init(ObjectClass *oc, const void *data)
 
     device_class_set_props(dc, sh_serial_properties);
     dc->realize = sh_serial_realize;
+    dc->unrealize = sh_serial_unrealize;
     device_class_set_legacy_reset(dc, sh_serial_reset);
     /* Reason: part of SuperH CPU/SoC, needs to be wired up */
     dc->user_creatable = false;
-- 
2.49.0



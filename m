Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF04C636C5
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuImm-0003d3-E7; Sun, 22 Feb 2026 18:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIml-0003ch-9i
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:22:47 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuImj-00014N-RH
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:22:47 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so42017025e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771802563; x=1772407363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=087qSz/jCIwXUcdBzZK1XLhNzn/+YyGzCz66jF2oWFw=;
 b=K4/H9N+m5GkjKDF4M7lkTNCjcriEIT+wn5q9mqGjpQ2UQF5AvsdlLoLuRc5QOJgS8O
 zv1Guwvkoz+zpNSQSXXMGeLWKB3d56l9+cq06KanM5UqVmpT7j4pwNs8i9Ir1u+rWtIB
 euZdCfIym+delZMzgpVPYe/av3zKUR+coCPJlEyTMyDxD/D6J5UygEc70BX9MqZFkL5C
 cO32cVty2Ozx5TpcrBqL1Fh0LiMqrUfbOmer0VX5XK+lMgVvcucfVMAxzgQxbYtD4FRS
 iFMoADhzfX2bKdm1d3cha3Tp1qbXXa/z4PShGQyE7qTcyuwX/5z0b40tS9hX3TJgDrCp
 3+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771802563; x=1772407363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=087qSz/jCIwXUcdBzZK1XLhNzn/+YyGzCz66jF2oWFw=;
 b=eXT8EAB6GlchxnkbClJhyLTjZP/R+MK/rujg/jcL7JsFwTBze5y2IvmDUVHO9M30+K
 A1JTlKlmZb6LoQtV7MNmS2vWar0Lzy79TVRRDeaJsBzl+JzyZE9tej7OOXFdoh7sRB7j
 /x+6tsPqSapKM6PnaaHOnqsXY+nrjs0O6oHnd7mbhN/oSztGCDRaQodcAMOLaZ22yGsh
 S1hIdZB+jwlzsKDwsY2gN4/aSOdnAV0pc5xqwwfT9DKHW7nTm/u6CYvLfod5ltoYg+A+
 +7Dz2P9wu0cJJcQboRRNEWo9S5HrgVSEeWoQ6m4pCktJ3B8l6k3kNGndafO5hNz6LwgF
 2GUQ==
X-Gm-Message-State: AOJu0Ywr+DFUpV1F+aM7sjd6DawJSFQSGIMw1GQTkMYpUujKIkE0ZowV
 0OBCLZ54c5b1QD/QCMUEvGFQVtWYusxq2HqAVHyJ9l/5axZslMlt+mlp12xyKuCZR/HGwemva+O
 yG0VGug0=
X-Gm-Gg: AZuq6aLrdgUMhR4aHAxZxJdGuiIAcah6b4uT88htmqtkNbqObxpOoxPddsFoEyv/+kO
 sdAn+h3cDmAtBle6QKtMVnEZqxs7uGua7PP27E8zmOFHMMcVWd4v+DALU+h0kDpx3PabFmN7Cfk
 riDjYjZDy6JGyefq5t5xezWq4Oi1eH3wHA8Bu4rtlLpQxAnrJcXcrH2KRaAnQnaP62R0axcIlmj
 0DAT8orupty9kPob7PgAm4mqUXA+1jMk+lex5GR9QsEcKAOETgclMnNU7wuDSZFWvSCCmPsnKQq
 GxehnJbAQvsUtAA48elbIigmJSwZnMSz1ljmM59B8rNIuYqXSss/TwZCFSNMyItZA48D4Wl+vSh
 xSmo0KgfOkuRP30rwf0i2SIKiaZMRp2sXcp/NLUn8SpZ0bnxelTuPmh0sQm8OOiRgZTfNlyW70h
 9CFsF0EkATzLblqVCcksJbBhrahtP1VeAOaIK+Tj/RL/ZOrmlCe5sil2iCCxi45168EkwJGQgg
X-Received: by 2002:a05:600c:3484:b0:480:4b59:932e with SMTP id
 5b1f17b1804b1-483a95b58b7mr112601755e9.11.1771802563435; 
 Sun, 22 Feb 2026 15:22:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31efe02sm244100265e9.10.2026.02.22.15.22.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:22:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/21] hw/m68k: Set graphic display dimensions generically
Date: Mon, 23 Feb 2026 00:22:19 +0100
Message-ID: <20260222232222.7183-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222232222.7183-1-philmd@linaro.org>
References: <20260222232222.7183-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

If a dimension is not set, have the machine init code
(q800_machine_init) set the default values.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20260216213121.47122-6-philmd@linaro.org>
---
 hw/m68k/q800.c          | 6 +++---
 system/globals-target.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ba32da2fa45..ded531394e6 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -560,9 +560,9 @@ static void q800_machine_init(MachineState *machine)
                             TYPE_NUBUS_MACFB);
     dev = DEVICE(&m->macfb);
     qdev_prop_set_uint32(dev, "slot", 9);
-    qdev_prop_set_uint32(dev, "width", graphic_width);
-    qdev_prop_set_uint32(dev, "height", graphic_height);
-    qdev_prop_set_uint8(dev, "depth", graphic_depth);
+    qdev_prop_set_uint32(dev, "width", graphic_width ?: 800);
+    qdev_prop_set_uint32(dev, "height", graphic_height ?: 600);
+    qdev_prop_set_uint8(dev, "depth", graphic_depth ?: 8);
     qdev_realize(dev, BUS(nubus), &error_fatal);
 
     macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
diff --git a/system/globals-target.c b/system/globals-target.c
index 989720591e7..e3f7d846ac0 100644
--- a/system/globals-target.c
+++ b/system/globals-target.c
@@ -14,9 +14,9 @@ int graphic_width = 1024;
 int graphic_height = 768;
 int graphic_depth = 8;
 #elif defined(TARGET_M68K)
-int graphic_width = 800;
-int graphic_height = 600;
-int graphic_depth = 8;
+int graphic_width;
+int graphic_height;
+int graphic_depth;
 #else
 int graphic_width = 800;
 int graphic_height = 600;
-- 
2.52.0



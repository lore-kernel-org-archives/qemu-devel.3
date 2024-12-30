Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975C4E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 15:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSHeM-0002fn-7A; Mon, 30 Dec 2024 10:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHeJ-0002fC-Hv
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:25:43 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHeI-0001m0-53
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:25:43 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385e2880606so6878032f8f.3
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 07:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735572340; x=1736177140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7UfBZMFotuOZuG+02/D0eezoHBGpYOKCSHoS+es9Cw=;
 b=d0VLbsNebUrocGqM6HxbmUTq9Nw4E4/sAq21fWjnb2mri4ID92FoFzVVORvrEPa3Zc
 OW7y2swogwIf3qMOC1oiwFVaNibLEpCRQ9iPWAAKetagrQcCfcWHwEZkKrJy7W17Tbdz
 LIef2HFDMxBJsU5UGGA7JP1oSBVhn9WeEGYmlwgLpWkzg8aq0RXT3DpAmtpeEcwHBZVF
 miXy9qsb5OdsA6xa0wL36JNrQYzLboPom2/uUkYPocIzJKr7Te2BxViJtPMAnORdGK/g
 YCePAk5ujLwey/lyU/Sg+NAIVqr2+ZpXRkKqME4Vp3+P+NONXJMe1aya7c47LnXzN0H2
 0mRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735572340; x=1736177140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7UfBZMFotuOZuG+02/D0eezoHBGpYOKCSHoS+es9Cw=;
 b=I1iu35wOGIc+rpyc/iGCEerAX7BtrRGd3V551AxUCtr6HzKY5e19UurKDmUQK9UmQk
 zxWm20NH0O6Oar/Wifiy1+5wilpzG7SuE8zOCks3yzFMEUIAaf9RkhkqP0EAVWKq238n
 KxE+LgG4uMj+0Bk8B62RgymxZdd+ZJuyUIpUFPwoOIKT4OBbQdBYpGnnyd8lnav9Gsdy
 27tnBfC+1FQk0pY4NRKdj3FLYlL7c/3oCWozG3OK2LR2NVpMusISX6S74hrN54FFDGQo
 uho4jSM3Ek/QuLyWMKZlTiyRdmV4fcgG8gCPyoIxi8mbd6jUjBcnBGPTcgw54I9kFdra
 BuAQ==
X-Gm-Message-State: AOJu0YyCBKU1N4tzrvgHcxJ3GPkTN0aoh+Mr7nZuAaLyRSTf1E9GTj7I
 ghXDsmi9RugARoWKFEKr3m/P3lxQpz0vx68eUFmYCjHFLF/lCKM5b/V8lE+xjOpzMykonFQmoGp
 X
X-Gm-Gg: ASbGnctgLerZM25GxMbeRv+xlRjLHXgudy/FYttf6NPbVjvYNmFWvzdMgvVR1qN9A6b
 4eFUQFLhcWD8c1YyWWDQ92Q0ZoSN75HIDHYtoz1U8DhCg0j1InKF/o44NIxBZIlrpAbxyiCHu5z
 S98l/mgbBEmObDX/bpXbGg5VejNY3CzefS5tUQnIiR5UlduqpNVJMEWvq0N4qNN1/ae1/uQlVF2
 jrfwVSyAgylyCpGU0q5671Ia4k1oqT+qKMV5s1tD+v7rF1LwjsX6xN4MLk/6yd3hh04tYoA1xGK
 K4iC2y1Yp8bxpbRplWstSw1HWenVjLA=
X-Google-Smtp-Source: AGHT+IF2UaBPzUY67I2A2kJnHlE8ymWd5wTeemDomaGzNJpgbJHBtgowIXFzo+t87pU0CUTceCDo+Q==
X-Received: by 2002:a05:6000:1a89:b0:382:3959:f429 with SMTP id
 ffacd0b85a97d-38a221e242emr36140179f8f.5.1735572340209; 
 Mon, 30 Dec 2024 07:25:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219578sm362694145e9.20.2024.12.30.07.25.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Dec 2024 07:25:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/5] target/hppa: Set PC on vCPU reset
Date: Mon, 30 Dec 2024 16:25:18 +0100
Message-ID: <20241230152519.86291-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230152519.86291-1-philmd@linaro.org>
References: <20241230152519.86291-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Helge Deller <deller@gmx.de>

On reset:

  "The CPU begins fetching instructions from address 0xf0000004.
   This address is in PDC space."

Switch vCPUs to 32-bit mode (PSW_W bit is not set) and start
execution at address 0xf0000004.

Signed-off-by: Helge Deller <deller@gmx.de>
Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index dbd46842841..7278b7ca6b5 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -205,6 +205,7 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
     }
     cs->exception_index = -1;
     cs->halted = 0;
+    cpu_set_pc(cs, 0xf0000004);
 
     memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
 
-- 
2.47.1



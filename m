Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBE8C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDSJ-0007cm-CN; Thu, 06 Mar 2025 10:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSH-0007ap-22
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:13 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSF-0006FL-JS
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:12 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390e88caa4dso500673f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276090; x=1741880890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nZgvu424mm38yBUBld8avtZKLtMG0rtQm4gPKkeUkoo=;
 b=GyyIQ6zhFxC8AkFnNYeBbskaCMSdrQZ9shnuI8Zwd09rsvloGX/6+Mu30y/tHJnOwl
 eRb6dwdmW5qhsykX76bLsy+szlzGdljDPgnSzDtFn5QKEAvvM3Hp56KcxLoGSkNY4Hnd
 tRy3egHeTNyWYAZcmkPAR15HQ5yQWeK436F6hwNf3/HLalXCOyfp73IP8tkRQ1p7dN3Z
 3pzS3tcYAs+9FEfZXXr+l+4ssyT0puF9inzh7LmEfF5z+kxCBIG64Yucu7AeTZQSmpYS
 N6sv7mbl8XM4tp2JrhVwQzuY/jJwqH/RDPVq+sqYd0bRsLrjdhtis+ReEdFphaCJakFU
 3k2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276090; x=1741880890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZgvu424mm38yBUBld8avtZKLtMG0rtQm4gPKkeUkoo=;
 b=OmJq8IVjgSs24bpC+ggfI62qxt54Q/5V83ytIaRl4FYgi/HJNjQ29bdbvwe5CnM8Xm
 IBE2St5eElBE0PGHLw1BMtLB8g8CPuyjoZlVezUSxJ4/hlywScA5NUETUeXQfHiBaAwk
 hrdOq7V25NUnBc1wY7bFwNbMoq1f9E2Q2PcLAATlLqTGB7urUAMa/MjDRWSaUg2ZTo5/
 W3NJB7s60lJEJvjfy1KUYuBop1qrwarZ8Ue+69+HeqtuywtZ6IEIOKlEU04/0DjrDSGz
 rs/Orcd3oCe9u70SztfHFQC5VVCfAokr0gX6pLbY459MxpTVAV/VxjY2fyTc9ookR66x
 fCvw==
X-Gm-Message-State: AOJu0Yw012Ft0vKak0DRFbT6z+1/qXy98wTMM1tM2dFc16uv77gquuWw
 83DKM5u2iCPFPshZMY8UVVFy0quJzTyhPWYPMLQsbth2RwpEjeABc8254+mXUESm+QqEPce7rwa
 jHIQ=
X-Gm-Gg: ASbGncs+SdHZ7j4BesW7+qrKJpAo5yz/efRT/9WMH+3oUlx926NsrIgoeeh3Jyjs8Zc
 s1r75x6SeCU7sXPmGlaHG1/hK9m4FvSBYiidaLtZYI9CCcJl47X6qNxATP7OooAC9EhiaDOHZkZ
 z3biuXm/89zVg///9dp2Owfn5ElAo+/ApnFbFDzTgbNODU2z+KPMgEMAFMQhZkk1WneYA9yc9iV
 t7tXTI02Xpwt1LB6HUirLxFt1pBOlGPdxaa6ZAo2c8a3linnLh6oeJI50SMM02cX3brwbNI+mzN
 sdGK35lWII5JwJbpoONHeoTeukLXQTz3556jr6VE+yuL1pG1ogUAQMad4qEPOqOO2agO1H7b3Xt
 i82/6GxqIe8VHC6a1pxY=
X-Google-Smtp-Source: AGHT+IGCFrD1Hyn++CnlZauzLkf8AL9dXp3VP5oMErW2YvOsaOJ8g5pBGngFmX5XxH++nYtMxqnCaQ==
X-Received: by 2002:a5d:6489:0:b0:38d:d701:419c with SMTP id
 ffacd0b85a97d-3911f7b8adbmr6397848f8f.41.1741276089942; 
 Thu, 06 Mar 2025 07:48:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba66esm2442919f8f.18.2025.03.06.07.48.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:48:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/54] accel/tcg: Remove pointless initialization of
 cflags_next_tb
Date: Thu,  6 Mar 2025 16:46:49 +0100
Message-ID: <20250306154737.70886-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

cflags_next_tb is always re-initialized in the CPU Reset()
handler in cpu_common_reset_hold(), no need to initialize
it in cpu_common_initfn().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-13-philmd@linaro.org>
---
 hw/core/cpu-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 71425cb7422..d5cd227fe6d 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -249,7 +249,6 @@ static void cpu_common_initfn(Object *obj)
     /* user-mode doesn't have configurable SMP topology */
     /* the default value is changed by qemu_init_vcpu() for system-mode */
     cpu->nr_threads = 1;
-    cpu->cflags_next_tb = -1;
 
     /* allocate storage for thread info, initialise condition variables */
     cpu->thread = g_new0(QemuThread, 1);
-- 
2.47.1



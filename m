Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57615CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCSJ-0004Xl-Gy; Mon, 30 Sep 2024 05:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCSD-0003pg-8B
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:12:31 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCSB-0004gP-Fe
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:12:28 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37cc810ce73so2354718f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 02:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727687545; x=1728292345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xp7nwUCJaW/bkSknjoRe7vWWzJDVDixFzfBIDbsBbN4=;
 b=GGPZEOA8hogiznbFQswVoWayJ0t63tZGAlYPlzg2/GXS592aabz/XDD0I81nvVnkQl
 SenxeqWuE9pr0ZNGThrzk4jhD6ey98SiWHjkL+/Cb2JlZtnAAJm4GkyaVKLef2XIlrqG
 PChan2LQlk49P15lqMXICglWzSPHAiy73bbPk9xr1eQwOMpLXE/O1XsewvgVuE4qrGNm
 ib5xEXYPxv6BkwScYd/yWc7Z+kMWyryKzYZOEROg0RhVZzeicMZabdvn+zVHeKXmrp/T
 PopUfxVkIHdu1/YI8mdVcuhRgvCBqGWISonFeydNYK1C9Hbr5QOsz9aI6oh3pn2VHi2f
 W7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727687545; x=1728292345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xp7nwUCJaW/bkSknjoRe7vWWzJDVDixFzfBIDbsBbN4=;
 b=WIYFlCSosXP6+bIUwgSZmNtNDV9j4oPzb/ShQlAlbwgl8YGJN1p2HyYI5dySF5MByi
 xJJakBJXMqGeUgJJh5cw1yoNG71m1/HUmtz6bFjN+56+BbZMHNTNpMXcHMd34MIPOGBH
 CAdtiz9F3e8b6IEJWDZY/BCjC0rqN0cRaEBUvRXtCVlZCNR6ZmwCZ30NdWnb3fGjp9qV
 Y6V3s3WlkupAkT/U2ID720GC39uNqPEGsrbbwZ7PELtw65OvBFRonB+3hiKBrF9qZiRX
 9X9yEkuTR6KvwEx4o2JT2Mlox+o8bLiZsSnShQUXGpq/MiLrjELNgLNGaDmbz1vZvWdz
 lOLw==
X-Gm-Message-State: AOJu0Yyka8oqBQQLz4XIUPhkyhiK3pus+n16QQb/9t1vZzz7Mv8vaaIm
 Bo4wVt8vfOFIn8sDIVrcGJhRw4P1VVsbIbiTR6c8ymC5BWK3ruX8/BqiPYnqM+PWyJE7Pl9fPd3
 c
X-Google-Smtp-Source: AGHT+IHvRdEPeY44ajJFKE6t3GBs8/tEavMd+4IYJeqCp6TUbQmrdfNCKixTO0T4rV7ABAE5is0PIg==
X-Received: by 2002:a05:6000:d82:b0:37c:ca11:78c1 with SMTP id
 ffacd0b85a97d-37cd5ab7440mr5385294f8f.27.1727687545557; 
 Mon, 30 Sep 2024 02:12:25 -0700 (PDT)
Received: from localhost.localdomain (183.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd574282esm8469346f8f.104.2024.09.30.02.12.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 02:12:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 11/12] target/mips: Remove target-specific code in
 mips_cpu_reset_hold()
Date: Mon, 30 Sep 2024 11:11:00 +0200
Message-ID: <20240930091101.40591-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930091101.40591-1-philmd@linaro.org>
References: <20240930091101.40591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Since all code creating vCPUs now set the 'cpu-big-endian' property,
we can remove the target-specific #ifdef'ry in mips_cpu_reset_hold():
the CP0C0_BE bit is set using the property cpu->is_big_endian value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 02e2e72f2d..9724e71a5e 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -202,9 +202,6 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     env->CP0_PRid = env->cpu_model->CP0_PRid;
     env->CP0_Config0 = deposit32(env->cpu_model->CP0_Config0,
                                  CP0C0_BE, 1, cpu->is_big_endian);
-#if TARGET_BIG_ENDIAN
-    env->CP0_Config0 |= (1 << CP0C0_BE);
-#endif
     env->CP0_Config1 = env->cpu_model->CP0_Config1;
     env->CP0_Config2 = env->cpu_model->CP0_Config2;
     env->CP0_Config3 = env->cpu_model->CP0_Config3;
-- 
2.45.2



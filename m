Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A0CCFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 12:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOxo7-0002AD-An; Fri, 28 Nov 2025 07:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vOxnz-0001rj-9J
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:42:31 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vOxnv-00036O-M9
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:42:30 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-55b09f54e98so659251e0c.1
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 04:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764333746; x=1764938546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ux7V/vcnfKVnQVQzXuR5cKKTLtK6T4UuaelCSQB/P7E=;
 b=si3MJAc/yCGXyhXydOp7QVjyOFg+wl71mMH5NW7+PF+VaPD0FGwZVgxYLXjuzqMT7p
 1Y0/UvIH813YHUiyEVTTs+soidgSIcssgA9eYpIcplB3ELh6O/f2IhHbscIu+gO68MHm
 M5FJIcF1lGK4+4RXTqDsSwO2z5Ct/2vUsxAfBqnuz0V8/n5k6KXO45bpuioDNsJSEPpW
 lMWYOUjANFRg214cIVS/FgJVdpdDQx8ZNa8hoTrybslK9q+fgkvfX58nQLOLCX5naHfG
 657gMFMK4pwLIDIJr8lgAGD5Vc/KbCwnO71UbaG6XceyBIoLuMvgLd9QOZRsF2vc+kfz
 HSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764333746; x=1764938546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ux7V/vcnfKVnQVQzXuR5cKKTLtK6T4UuaelCSQB/P7E=;
 b=p+X/O2qk4WmaMlKuDZhy5K0nfY6Ynpuvyfam5ObNnSGjQz7GT5cv7HqsvwcmnFv1Mn
 0Kr15V9UlSeIUUDxidLsxMxBMzBRC04NcF8L7XmQNPTrLoLC3MPAj1+MQLzUpM4f0B/2
 6O4n1fMiqV89p4kVw7ObZqO00qLLh2IyNhA5hFdTOL97MKWDN2FB3d+G7+G/frPsHiQb
 2KviGN7W3u4FqEWDNW0namBkDGnxmMwvT6L/ey+5VqiQ3DG3Xbpep4S2btGL2npGzyw3
 rSJZcnXnPlP9jMCxWR4OLGSfe8Px0iC0z2PUfOWaJYW7pec8/A4UbK2QuZWRnLCRNZbX
 JaDw==
X-Gm-Message-State: AOJu0YzwRRi9TygoGQoaEXmIjDmbDQPfkLlAI5t6EaStJwfL+Q4aEly0
 t++JQByv4kSt1weyjLxnF6EDdyiBKDAOhkmY3NbiDFMzTHbRycp9k5z1M5GmWuiZPWZeTSva0vc
 4+Jyg
X-Gm-Gg: ASbGnctQ64SD+Uu3i51DeyMD08gnRkVig7zoD2qJ+50Z+Mqt+32JPaTZuvMxI1cnCod
 cR20j2ijpF58nBkzAU6vhil2fxb4M8c81Hz6IiL2y7OcF/b2GPD0M16yrUEvIoVn8yAFAfHSG14
 uC9npI+wZTpfbLVkpwk0aY+gc7q6NRLqndxFkYyJ89xP+tBiQCws9uHcgGKUMl06H/AaMeeE3RW
 CX2Dn2msZ5jd5FpjX7WS/IVcqCyRjHhqGQquHuCBjxy+d43v4XywerHC0pI8zHso2w4l4lbOolo
 D5CkVOCnZOZ32SElnCZdMEK2J/tboPwDTwhT2D2+cpzFbYnuBt8rV74VA5dcss8m1BNWHKNWQwb
 efpTZcWHSlkwBstswH+NzL3ZFr4ZmTEmsq/G3M2iHsnJB+5aisHXPjHnjtjVqyHIdOMAj0TBUD2
 L7weuNZC4Tyff+MYI=
X-Google-Smtp-Source: AGHT+IHlzQ57t4dcBZK6NHRL2f5576mqrLpy4QrKB9k4lPeKHAYQOHUVFPBq4iB8CQgiCSiBYcMoXA==
X-Received: by 2002:a05:6122:6602:b0:559:ed61:4693 with SMTP id
 71dfb90a1353d-55b8eff01fcmr10420434e0c.10.1764333746328; 
 Fri, 28 Nov 2025 04:42:26 -0800 (PST)
Received: from gromero0.. ([177.139.2.175]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-55cf4e1d56asm1776930e0c.4.2025.11.28.04.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 04:42:25 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v1 2/6] target/arm: Initialize AS 0 first
Date: Fri, 28 Nov 2025 12:41:06 +0000
Message-Id: <20251128124110.1272336-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128124110.1272336-1-gustavo.romero@linaro.org>
References: <20251128124110.1272336-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa2a.google.com
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

Move the initialization of AS of index 0 (ARMASIdx_NS) so it happens
before the initialization of the other address spaces. This is purely a
code organization change with no effect on behavior.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 39292fb9bc..1640b20b4d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2158,6 +2158,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cs->num_ases = 1 + has_secure;
     }
 
+    cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
+
     if (has_secure) {
         if (!cpu->secure_memory) {
             cpu->secure_memory = cs->memory;
@@ -2175,8 +2177,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
-
     /* No core_count specified, default to smp_cpus. */
     if (cpu->core_count == -1) {
         cpu->core_count = smp_cpus;
-- 
2.34.1



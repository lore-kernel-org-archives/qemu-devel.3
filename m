Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BABE7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8cp-0004NJ-A2; Sun, 12 Jan 2025 19:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8cn-0004Lh-R7
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:14 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8cm-0000iW-70
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:13 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so43478785e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729290; x=1737334090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=raovzkxW4bgEPUiYxpxT8OAVJQxeHZnj+ixMLAGuiZ0=;
 b=rxsyiU/po8uTdjQex4VKnIwkudK5EOLKx2uEXIB+ew4nuwDvcKDu95TmWeDZzFzJtV
 cXSgKxmBXzmu05VZBLja0bY9qudPScJmc+hsO32qZ+FpBIaoIu1mTTk5YybItdFtC0LQ
 eG/H++0xN3UAnLo9mgfN1528FjeJNi3dT98AEAS/RR1y+UT13OQXJFgLLMh5dDOw+D8m
 RqkIaNvyJd4AUNCg66EMELYw1KH9c/KF9YEVT/hsToMkVjOdr0rSSsLFFYBpUoG9Xrmh
 XhWLI50iB0X87ygXRjFHd8ppTEYV8WntudNMpnDtllqEcl0tuFW68qJ0XrsMqTkyh43W
 jPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729290; x=1737334090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=raovzkxW4bgEPUiYxpxT8OAVJQxeHZnj+ixMLAGuiZ0=;
 b=iK5IJewXmLAar0gyc6bsYjm/8pAr+HOYKziJB7obzA/egMpx/qaYChu6BVkqLYZEbt
 +SZNCRAp9peL+QqTz8bPTGAaL0GlgqrgGQ/UFxxCEjr2bPK8Or+KKIXI4X+IKmle+O9d
 fUpiHu079jDHa+Ic8WZj49iwdSIQllrhxO7KAsflkJJoU4nPQ4MkuYydWBS5mC2K5Pdt
 skNSgbU7OiePFqFtdCuBCTYS63iv0Ma/0u3dFsxF560hGdoMUZVMn3Pq02Fx97PPXS7x
 h/wUWUnAwi53wAsnDfCq/9lBN4rKzzcs/ZvZAzeWAUiVjwGI70miG6Jr+s8lx/bgcshw
 95Tw==
X-Gm-Message-State: AOJu0Yz+qAtrNRwQTlQgRSheDIpWByDY4gyDp52CjOtbVo8vmdvY2o3v
 PyvkQ4cKmpvpdhqXVC8XUAupOcyUZTeRYul67nL1kvt0clASY/2FS2K4g0btXHuo1CUktsvjSO2
 CWMM=
X-Gm-Gg: ASbGnctLNUGbK0koy3bBJ6oRr7DgMsqwm8MPhMbrLq+9CDUc21AxuwZnTsTGF2aVYYv
 kMLOtioUVQHuTVhVnaYQkbtx3OVU3YCaxSpWA/RLiJOjqmhadrVdhUrycAIN2J7lsOBPi3yeHut
 7uFXv4BVcZOheVZbFnh+skcZfiAMfQhFqXLLBO6J5J2VSNdMmGz3yX5VdclKhEvYJvqOwO9iTMF
 j4qY/Fs1wFr4IISG3oneZEbqbQGDhHh4FYDMl+9lD3TafKfRChA7jaKWyOmO5skFO24JBaOLXiE
 hbky7c4Go2SJnUqYvfZBixgn8C8ZY/4=
X-Google-Smtp-Source: AGHT+IGAHS0RS1B0M9mTM8or7KgP/M6FJjngZw/5aY7XVlvDmqXkMZ8+QrarnEhqxM12kk5NlXmy5w==
X-Received: by 2002:a05:600c:354e:b0:434:f9c4:a850 with SMTP id
 5b1f17b1804b1-436e269c42dmr190960755e9.10.1736729290279; 
 Sun, 12 Jan 2025 16:48:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e8bea5sm160712395e9.31.2025.01.12.16.48.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:48:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 03/23] hw/mips/boston: Replace bl_gen_write_ulong() ->
 bl_gen_write_u64()
Date: Mon, 13 Jan 2025 01:47:28 +0100
Message-ID: <20250113004748.41658-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

"exec/hwaddr.h" defines:

  typedef uint64_t hwaddr;

  typedef struct MemMapEntry {
      hwaddr base;
      hwaddr size;
  } MemMapEntry;

Since MemMapEntry::base is always of type uint64_t,
we can directly use bl_gen_write_u64().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/boston.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 67044af962a..63dc654192a 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -329,20 +329,20 @@ static void gen_firmware(void *p, hwaddr kernel_entry, hwaddr fdt_addr)
 
     /* Move CM GCRs */
     regaddr = cpu_mips_phys_to_kseg1(NULL, GCR_BASE_ADDR + GCR_BASE_OFS),
-    bl_gen_write_ulong(&p, regaddr,
-                       boston_memmap[BOSTON_CM].base);
+    bl_gen_write_u64(&p, regaddr,
+                     boston_memmap[BOSTON_CM].base);
 
     /* Move & enable GIC GCRs */
     regaddr = cpu_mips_phys_to_kseg1(NULL, boston_memmap[BOSTON_CM].base
                                            + GCR_GIC_BASE_OFS),
-    bl_gen_write_ulong(&p, regaddr,
-                       boston_memmap[BOSTON_GIC].base | GCR_GIC_BASE_GICEN_MSK);
+    bl_gen_write_u64(&p, regaddr,
+                     boston_memmap[BOSTON_GIC].base | GCR_GIC_BASE_GICEN_MSK);
 
     /* Move & enable CPC GCRs */
     regaddr = cpu_mips_phys_to_kseg1(NULL, boston_memmap[BOSTON_CM].base
                                            + GCR_CPC_BASE_OFS),
-    bl_gen_write_ulong(&p, regaddr,
-                       boston_memmap[BOSTON_CPC].base | GCR_CPC_BASE_CPCEN_MSK);
+    bl_gen_write_u64(&p, regaddr,
+                     boston_memmap[BOSTON_CPC].base | GCR_CPC_BASE_CPCEN_MSK);
 
     /*
      * Setup argument registers to follow the UHI boot protocol:
-- 
2.47.1



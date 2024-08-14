Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13628C531DD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 13:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seEEG-0006dH-Dj; Wed, 14 Aug 2024 09:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seEEE-0006cV-IH
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:39:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seEED-0004Pz-0m
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:39:54 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4281ca54fd3so49416265e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723642790; x=1724247590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IzGby2LfOJ0PSTr7E7Scgqvd+RTVUALDNaU5gvfZclk=;
 b=GtunYBGEiiyutsKssbQyMEOfYVAkyc7rc14UmmxdApvT7WwlDooeuYs8E3soKK+T1L
 6uk4NdQTuJkKQO9APFrFmegO8KcvWfz2UVPSwpMtO78BKSzbCSTojMztzOs7u0LNP/ZZ
 0xwbKWa5SAKxc3/AEsAABky7Wdl1kXU8C0/JOp6ZG+Czimv3KM53tQt1jRFgX2Vv19Yb
 gLidHj4nuDGge/xDz4/4brEjTeVVl7cnaA7SD2fMal69RsXMwjrUSYa0UI8TGogMVUdM
 9EXavST58zb+22myN+LjOUmZYGryKlDu6xGsHbk3awJOcSPXGmstqtl/IAy9SU8rs1B0
 oY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723642790; x=1724247590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IzGby2LfOJ0PSTr7E7Scgqvd+RTVUALDNaU5gvfZclk=;
 b=KZDLzAh/M6aFnMoKxTvlP6DmD+iYDO2S5XUrO+CqXCmPsZL1iliUpbQZ+DlC86wmIR
 ss9lcPG/cxe//GqT3fl1MG3qajbd6TJIWHBuid3gJeI3dwgqnNNnIHfiMLlfnUQBgYQi
 04GIGNi6UTdPRj+G5IAjIZ4EDAnjFocQ5k3WfA5PhLTwylSAXscVDp6c7Mou5R/6DTX1
 RsvfZbrThzNMDTqMD4emjuJn5gb405vMGR6PVLZK17Q3e7rLzShE+T5bBgabJrQlrDka
 5Ff0ntvyHOOYNqw2/OHwplzj6Dq5XrvSkvBJJTrmRAV4Ldi1xaJXF97MYECP4oxFXsOo
 fFsw==
X-Gm-Message-State: AOJu0YyeYGJ7SY044lQ6x2Qq0vfVZv9EjZBlbyjuypSvMC4EFS26lwz+
 NyDc0JCiZo1E9pa2ccuE8W10mNUjB+0I8XGhjXWaUgtV507iD5LW3rzpvl8VsGDT4UNPJwm77FH
 mfOA=
X-Google-Smtp-Source: AGHT+IECNJAuWIyAvPQ6Fg6noo3XvXNdo0VYHynBZeINMsbEvo/pCg/PfgGfa8qvvT88ft5k9v5Z6Q==
X-Received: by 2002:a05:600c:a42:b0:426:5f06:5462 with SMTP id
 5b1f17b1804b1-429dd268f31mr19589125e9.37.1723642790057; 
 Wed, 14 Aug 2024 06:39:50 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded4e3f4sm20354515e9.37.2024.08.14.06.39.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Aug 2024 06:39:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 YunQiang Su <syq@debian.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 1/4] linux-user/mips: Do not try to use removed R5900
 CPU
Date: Wed, 14 Aug 2024 15:39:25 +0200
Message-ID: <20240814133928.6746-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240814133928.6746-1-philmd@linaro.org>
References: <20240814133928.6746-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

R5900 emulation was removed in commit 823f2897bd.
Remove it from ELF parsing in order to avoid:

  $ qemu-mipsn32 ./test5900
  qemu-mipsn32: unable to find CPU model 'R5900'

This reverts commit 4d9e5a0eb7df6e98ac6cf5e16029f35dd05b9537.

Fixes: 823f2897bd ("target/mips: Disable R5900 support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/mips/target_elf.h   | 3 ---
 linux-user/mips64/target_elf.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index b965e86b2b..71a32315a8 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -12,9 +12,6 @@ static inline const char *cpu_get_model(uint32_t eflags)
     if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_32R6) {
         return "mips32r6-generic";
     }
-    if ((eflags & EF_MIPS_MACH) == EF_MIPS_MACH_5900) {
-        return "R5900";
-    }
     if (eflags & EF_MIPS_NAN2008) {
         return "P5600";
     }
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 5f2f2df29f..ec55d8542a 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -12,9 +12,6 @@ static inline const char *cpu_get_model(uint32_t eflags)
     if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_64R6) {
         return "I6400";
     }
-    if ((eflags & EF_MIPS_MACH) == EF_MIPS_MACH_5900) {
-        return "R5900";
-    }
     return "5KEf";
 }
 #endif
-- 
2.45.2



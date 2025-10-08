Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CD5CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NyU-00020p-5W; Wed, 08 Oct 2025 02:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NyO-00020Z-Nc
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:48:28 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NyM-0005Xb-UD
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:48:28 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so5228186f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759906105; x=1760510905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5gDcFnOxp7kWdYGhN5BfEl0/mb5oVLdE9DRkGyv2lAk=;
 b=G4T8JLZqXlcVee48W5ro5sa41wO0zJMnkh9J+UdF7XYGb/WSWfupnvHZVmN68+lwAA
 ziVyIxQ8pq98i0l2UCDNhQaXGPEvWWj7eT1j67puBbtkHXy3k7h4+DL3tTyRofMvqtwV
 Jj9d2sTzDYZ9Xceb6eTuChHjXK8XZ8pZgn2suWqL546chy9V/6Q1t5CLxDMiBcbIiams
 mmoochzHB42Uel2x7an/GMniGBShZ76cex6dUKGhCqLUyCGvCDKYI2W70ypgMRoa1L8k
 SXE14RKu8lhRpy/NS5Ggw+1AKLMqoHyt5M11DYfjdvvbaQkbmCGJKZcIKxFoHpGZqsmd
 wV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759906105; x=1760510905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5gDcFnOxp7kWdYGhN5BfEl0/mb5oVLdE9DRkGyv2lAk=;
 b=IlcX9XagudsUkfLlMYZh/xJ/TKL9ACxQHJy75zeIOeFAFapCNpsfCsTVXgxmrkltTR
 eLjcJ0faRCqAhLcb8iZNhM88SFzSVzjvYYa+FSxWM8jdyPSrvcEBSV/dmqz+EQHNggJT
 yqiLt21bUsVdgbBcd7gfGCNxpdOCkw0+/qKD63DljoJsP7ijdqI6Q+ry0vgX2yCOT3yd
 YKkYDyDbp3/PXfEsYP2FS1yQcW/W7JVUYU5NkfLXtmIkm+rRb21ZkM7jFw0X1YfLe0wx
 mWJjoA7hXC5t4aNqenXhZpZKYPIC7Xd1q+GTNF+YuApmvi4UMcT6c6BA1RZfObXdbIxe
 WcWQ==
X-Gm-Message-State: AOJu0YzGl60w0Tu7Ll0JjLqHjWwd/s+7HNQnmpldOlj67bjp7rqnFsAF
 X2b8snC18erXthdroLzY3oy99c0Zi5aLsOgmqK7nnyx+xqsQEYS67yhSe/hU8kHKwzECeVy3Uhh
 PtLF61jqCAg==
X-Gm-Gg: ASbGncvTZdUatiO/nGfaWDJV8TRfwGns6d2tS85Kj1R3rKRom3W0/BWyOT7+kh+i7uw
 v1nZmgFtdFvnrtZJcNqRRl+BoVYtMq2Jk7mqJ6GHEa96M/cLjCLo0EIMLK7+bLGVuqQQEaIR9sP
 ++jzW3w/1Sw+wfw7YxrAKk17YPYGFVTvWoOw+ECE8K6wbFY8c5YKAnyoh3/nFdZiShyUeY54e5I
 +2rktp6YMwADsfw+vlbFBm9KE3ZOC1RwOeMp6c0fGq9jMWTpNAjQv7PM5VBYbjbf22qJV906HYp
 eMpKzN4TcetD/NWtanVxHWX1KlQLTHdkCV/tvyWJPL2CzCiicAYIGBj20WELxX5rbixAxPrOVPb
 NMX/PPk4EMsC3oke1xR7Zv8ZlJg0fC3bUfKRRo9se4VOF/atwAUMgUzZuIK2aUC8mlrgD9ZTHns
 eMpno2jI8VkSVHSj7Go0xFv2Gk
X-Google-Smtp-Source: AGHT+IF0jgxXoo/FWMhl5sWm9+kO5Ie7Xzzj7PE5S2L2ygdgTZ/hjYXhVuN4RLJqHZH/sO24p0GACQ==
X-Received: by 2002:a05:6000:2501:b0:3ee:1125:5250 with SMTP id
 ffacd0b85a97d-42666ab97e2mr970049f8f.24.1759906104856; 
 Tue, 07 Oct 2025 23:48:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9bf94ddsm23744515e9.2.2025.10.07.23.48.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 23:48:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/6] target/sh4: Remove target_ulong use in cpu_sh4_is_cached()
Date: Wed,  8 Oct 2025 08:48:09 +0200
Message-ID: <20251008064814.90520-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008064814.90520-1-philmd@linaro.org>
References: <20251008064814.90520-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Since commit 852d481faf7 ("SH: Improve movca.l/ocbi emulation")
helper_movcal() pass a uint32_t type to cpu_sh4_is_cached().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/cpu.h    | 2 +-
 target/sh4/helper.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index db27a693f12..41f634fe162 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -277,7 +277,7 @@ void cpu_sh4_write_mmaped_utlb_data(CPUSH4State *s, hwaddr addr,
                                     uint32_t mem_value);
 #endif
 
-int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr);
+int cpu_sh4_is_cached(CPUSH4State * env, uint32_t addr);
 
 void cpu_load_tlb(CPUSH4State * env);
 
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 1744ef0e6d8..42e324589e8 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -47,7 +47,7 @@
 
 #if defined(CONFIG_USER_ONLY)
 
-int cpu_sh4_is_cached(CPUSH4State *env, target_ulong addr)
+int cpu_sh4_is_cached(CPUSH4State *env, uint32_t addr)
 {
     /* For user mode, only U0 area is cacheable. */
     return !(addr & 0x80000000);
@@ -735,7 +735,7 @@ void cpu_sh4_write_mmaped_utlb_data(CPUSH4State *s, hwaddr addr,
     }
 }
 
-int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr)
+int cpu_sh4_is_cached(CPUSH4State * env, uint32_t addr)
 {
     int n;
     int use_asid = !(env->mmucr & MMUCR_SV) || !(env->sr & (1u << SR_MD));
-- 
2.51.0



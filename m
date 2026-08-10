Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A79C5AE49
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 05:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtJ1q-0004lS-1j; Mon, 10 Aug 2026 01:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wtJ0A-00041J-2P
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 01:56:49 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wtJ08-0007nZ-2v
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 01:56:45 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38e347638adso1580724a91.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 22:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1786341402; x=1786946202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tPIURf+XgJJwDAzNhZhXjH+ngHkuRuYkdSdDxolD9uw=;
 b=kMvY7ctI8K6WVlXyLURIdJGVmZjedPmEEtQQs4WGJo4A2dldIa5fVb9zmhP6EUCXRv
 rMOI3Iy39HbaEF33Tj44yC0ghmo+tk3LVmTpzQqiN5ThLaxrjiOx+QvRE7syTyXW9yF2
 11+QBgztmKRtK7UUz+8pAq1N6YzNp8/30+uuf/OSmzvl9n1rXN9e5RHwxu9q4knJWOJa
 ZjOyk7CzlnhsP/XmfhB4yBY6VnObbdCpf/FaUOuuzNUjPjG1JnmWqLiOJFdR7r1rEAJN
 DRQUh3Pot1MDKBXtkADWV/ShTe1pG29VdJntgzKuZXF5lZYjobDv4aFfAzu3X0e69Xvf
 GYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786341402; x=1786946202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tPIURf+XgJJwDAzNhZhXjH+ngHkuRuYkdSdDxolD9uw=;
 b=PlfwfUc3XiZzD0Y76N2gmIZ6T5MsX/aszJ0Fy31N1wjUrwjEYndQYCuTfkCDLkzZih
 9MRdWnI8RihpszByWf7sDxXQIqiooOOIHw7nMuFcA+inkV2IlQUXCOmSVovkVZOILOKJ
 traq9MmThjoAh7cN9/mL/3LBlAyA15Ue71QGa5v8+73f2tqSoxY6nBmOQxTPCEK43XHk
 6AttoUzNXNp1ct61ggMhW/8f45ojy/jEqZI1VLt9ffIUMdjyM6zt2SJ0YILefLrfoucL
 vh/gkfnjR2qWqf6FUBGwupFC1y2P4buDRFFehkaXdYlPo7vlgWy02XO6KvzESZaHyd4g
 1t0w==
X-Gm-Message-State: AOJu0YyKqd+WPNnuGn7VkRbxJayuA5SzEoB6B33XUGt8SPooo1loDXXH
 WCCneI+hyM2NuneOGCZ3hJuf4vOMyisFJXc8tqzFA/v1jHj76qt6Yuqb36ApXWkWpox8IaPbp81
 ydbLxSgCf2B6PrQ6+IFIWYGZKBoe/cqh8ZWH6w4CcVTv7XY2VwFvd4wKm8akCyQJhApOh0827Vv
 F3qBqufw7HZIrVAsKnOwH3HYAcFeT92x4u0ZqIf5NdeomwA1Lg
X-Gm-Gg: AR+sD11yQjsOS97LfeqBTjX71SZQatlA11mcTn3tRz7RlO6cbIGQUvE/TexvjzNeUdy
 bXaWx62MPwnBjBgyJknf5iwPLWbfdSAmVKSsmxVn8XtWnqQvXEsTAVSbDtQmwm1tpyqu4AwAr42
 BxEGIMJPVSqe4ILoBlcPGKXcPsX89XXaG+xo1C49l00SuEswbSe3NosOpYjLHA1aRiPWUJ+eBtN
 lttupZZZFLuBU5knzOb7JkC36asi4D78/eWhxHPqqfL45uK5GYCiZslkpE1omEtwx1fk+zpD2UU
 xVD0u58dE+kKuc/alvdsvh0PYhbnkW1SF8NBF4AOOD+t/lqktOpnFRiWAdWdWTOyKRvgluRBh5U
 HjC49TXUnqoTxpcNC8rDnqzG/++ZSuMf0tk5XXvs/4IdDgBBR46CZ9672qizJs5jP1yqBo6YEko
 9lHoyP9/fpdaFqRzAgkqc+FJLKP6UKogRmg+C+WclO+f2pw/1AUdlQ9bKGW0y12Bj7wYtxZPIDK
 4Y8RfUCJseZFn0=
X-Received: by 2002:a17:90b:5845:b0:381:a766:efcc with SMTP id
 98e67ed59e1d1-392824a9a40mr18245499a91.14.1786341402337; 
 Sun, 09 Aug 2026 22:56:42 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm39172122eec.1.2026.08.09.22.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 22:56:41 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v8 6/7] target/riscv: Expose Zicclsm as a CPU property and
 update RVA22U64 profile
Date: Mon, 10 Aug 2026 13:56:17 +0800
Message-ID: <20260810055618.1175500-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810055618.1175500-1-frank.chang@sifive.com>
References: <20260810055618.1175500-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102c.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Update Zicclsm ISA string and expose it as a CPU property to allow user
to turn on/off Zicclsm extension.

In addition, Zicclsm extension is mandatory for the RVA22U64 profile.
Previously, Zicclsm was enabled automatically when has_priv_1_11 was true.
Now that Zicclsm has been converted to an explicit CPU option, it must be
explicitly added to the RVA22U64 profile's extension list to ensure the
profile remains compliant with the specification.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7ee89f6fc4b..19b93f9c979 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -164,7 +164,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
     ISA_INTERNAL_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_INTERNAL_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_INTERNAL_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_zicclsm),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
@@ -2237,6 +2237,7 @@ static RISCVCPUProfile RVA22U64 = {
         CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
         CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
         CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
+        CPU_CFG_OFFSET(ext_zicclsm),
 
         /* mandatory named features for this profile */
         CPU_CFG_OFFSET(ext_zic64b),
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB64CCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEzs-0004Of-6k; Tue, 21 Oct 2025 12:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEzq-0004Nc-Nq
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:14:02 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEzn-0001dS-H6
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:14:02 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-782a77b5ec7so5370626b3a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761063238; x=1761668038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TCE8SvaITfs8coL27qj39ul3rERe6+OoO3JJ8MTgYA=;
 b=Mf0SpKW+NgKLKFwOUrqxSp81iM7H0HyZ7DJILfjfZJtr6Sy/Ux/EXFy7pXKhPgHYuZ
 U1B1NiSmXAOR+o1hIUFT3E9a7A1YKgG9JrvHLVixp9usYB7AaKEtg8JAUqkNZy8zI+Cw
 r0W8ksnB0FDOviDTZD6cnQ1JpfcUT8hPxoxYFddvrBsQhw47m8dvmSgfbK5M83eflVpT
 N04IkrZdXkYE5lqIiSiXuqf6Vz+QZPnzJ/RFt5pSAKAp/qQTqWrUNQ4jQRXhehqTHfvh
 Ll1ooyxHTb++jZb2XReNaGHRnf2serfvP0nu1DlC+BtuQy1HW3pg9ICWFVvmNRdN/BiN
 h9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761063238; x=1761668038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2TCE8SvaITfs8coL27qj39ul3rERe6+OoO3JJ8MTgYA=;
 b=Cai0VAKMvToH71PyYUcxof3ViF/gKWJ7St+bL5pntUG0p9c4blV7c6kBzuo4cEbYJW
 Ocz3XS5Gj6KCOQhs+H63a4yc+naVaSKGSHbJeL4RBNTF0FYT6PLaw01R1hBR0iKZFFex
 j6Lcr7yjIk+IiCAl7uoa7z51LsZAaBxme+titFp+SM4mlS9z60uU0b9XYE69XTaFhbLI
 Qq7/tzTccvSlWMXAK6S8oP9VaGD+OEAxoZ0ZuA+91jN3X34jjRzdH0LL66L6LTWSfaaI
 zs62HYgM/xhwSwyJGs2my/alEArhAIqaZGX/tMRhX22J5zSs1s5z7go+cien8iAYv6rc
 nLfg==
X-Gm-Message-State: AOJu0YzMOM8HBrtEImlswt6AhfzHN7fBHiVBOiX7w1pkr8gRDeBTcm4c
 IbxM+w8/r08ARzJa0hCMU1JYXE8lnMRz937lenOM5nW/7klzBtns1KuPTGMEzwrfKtTxgkQjgUy
 76s2sm7Wu1sa/prLLoBli5y+bAKSZwMZ9T4ZbKtjl2tzlkxHn83IEmP2knx9uuNf/JWwyh2gooI
 i5Cgi6HDfA26yZthY/Oq6HwY+t12WYppDyC7X1Gw==
X-Gm-Gg: ASbGncsh49T9UF/mO9/glsKGVJIQxRVzUtKi8lN11SfkkAqySxetiJj405MJWhhhUEn
 YbhUE9L8ATiamBTz+/Q//OAQlGKB44RWkrdrVvtH7zhmFXS0gzTuakooz/yAQTEC+upC+KLy1iU
 f6gK2usN4dMae06VVEczSH/S1rD+8jFUqyDLTBDbV4Mih5gUN3qhLPX1e2L6bmAPCLGH73ZiCim
 /mu3yucUv6i6J3Zpha+xu6EOt+6dmaTGxMNlWlCbBx/iqTNo6QLh15k1ER/t2kW6x2S8/5YPhKR
 5Wb0PzxAhg4ikav9iCp+WBi3clRoung0wJf7H6Vb/DWy8nR1EXaxQW46IINfSx6aSNGxOjWGfT5
 l7g/vcNHHzcM7YBYfZqKqmA+vj9d4NNywppabLteAd+JvrZnJ5G1l8lkypLPsPp8gx6QVlBPi3j
 f+FjtaVjuFmwLW91fuvuSl3UauBhxz1YaI
X-Google-Smtp-Source: AGHT+IEA5R+f82XyVar/ubEBqZZMWM8CYNx9jQMOmBq14yxF9TVlfPiAIb0+PERnaH4eGAVT1rGM+g==
X-Received: by 2002:a05:6a20:7351:b0:334:912f:acda with SMTP id
 adf61e73a8af0-334a8525d01mr23518065637.23.1761063237325; 
 Tue, 21 Oct 2025 09:13:57 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a23010f7c7sm11731157b3a.54.2025.10.21.09.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:13:56 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 12/18] target/riscv: Expose CPU options of WorldGuard
Date: Wed, 22 Oct 2025 00:13:18 +0800
Message-ID: <20251021161325.585278-5-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021155548.584543-1-jim.shu@sifive.com>
References: <20251021155548.584543-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42e.google.com
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

Expose WG CPU extensions (Smwg, Sswg, Smwgd) and WG CPU configs
(mwid, mwidlist).

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 32a9f8a6a4..b8704e7e88 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1380,6 +1380,11 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
 
+    /* RISC-V WorldGuard v0.4 */
+    MULTI_EXT_CFG_BOOL("x-smwg", ext_smwg, false),
+    MULTI_EXT_CFG_BOOL("x-smwgd", ext_smwgd, false),
+    MULTI_EXT_CFG_BOOL("x-sswg", ext_sswg, false),
+
     { },
 };
 
@@ -2648,6 +2653,9 @@ static const Property riscv_cpu_properties[] = {
      * it with -x and default to 'false'.
      */
     DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
+
+    DEFINE_PROP_UINT32("x-mwid", RISCVCPU, cfg.mwid, UINT32_MAX),
+    DEFINE_PROP_UINT32("x-mwidlist", RISCVCPU, cfg.mwidlist, UINT32_MAX),
 };
 
 static const gchar *riscv_gdb_arch_name(CPUState *cs)
-- 
2.43.0



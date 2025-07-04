Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B651CC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeMo-0003m0-BH; Fri, 04 Jul 2025 07:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLx-0002Gw-9Y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:13 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLv-0003Dk-Iw
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:13 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-235ea292956so8658915ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627590; x=1752232390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqWQWEbZK5lXCGuAyvlGEuyQ0XlOT+jS4umfC5xFEl8=;
 b=VzDlO64O/PVlVkqFVH1w2rOejZqc7vjhn33RyNBgmKqX8msXocTowqJ9BOd3fdIRPH
 LT7KRg1WClRKsz68sfclWFYSsyVw2nHCVnBfp6Z2jIs7zj5cNIJN7kU+GdULNl/rQzTL
 v3JpDaGS/rDMVizoK95oIuu7iIsyPHjWI3GFOJzJw111iQWDT+qjrp4K+lqSdJvA6Gdr
 iLCmHMvB0vZBVxM0/i14g+9A5Jik7CzJwrrc0TEhcybatHLa/N+1+4OH64X2N2p5blnc
 8W56XKFhb3cvmO5raHxFSXNagY5TZsICD5CYorDn6LgPlsdkWjZaE80sinKaexE1/GTL
 5VXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627590; x=1752232390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QqWQWEbZK5lXCGuAyvlGEuyQ0XlOT+jS4umfC5xFEl8=;
 b=iHUVOd+n7AILe7CmUBPLrbpD0dQ+s9rukWVUgaKlXXvYrM4qn5gW/fXXuocuyTLCzG
 +lprIC6cuV0vRvNlrZVYFArnSb144Q9MYsz2C7cTf8i/W55l+Da2vUxDR6a/22RYDlJl
 Azw7a3k+fcgb0WKi/5qizRFZ8P8cbg+INb0UaqjDflZSBSLBo/ZbAW5CgkzyymmabzFA
 b6G+jLHungTJK2A80kdYSILna0DCEkwv0jBzjfDGQMf6ZYLpJiNRvMty6Vm3sZMqQfZ1
 aw9D2uwyHgOeHGDJHl1TnT57Y4aaYeNGTAwD6FuvWRc4KOfNDNDF84UdeqifWqTKpElQ
 cMkQ==
X-Gm-Message-State: AOJu0Ywr5eanG7NNAoBk9ywLR2Wr7dBRLBBDMQ8v2gFueljQwy+fX3HK
 IdX8c088e/AHwhLQfDCUmsK1AFiots1ITi7xu3ug3TSnQ4Y1/NDgGTLTjFnfNA==
X-Gm-Gg: ASbGncuVrw6l1FO59daKaLeZ1Sy9r6pSuFJF1QMSS4jFiaHNvwQZX5rpMQIwwwz0srP
 DevMa3/2TY4gNTiq3sdKf1GUR3oXqxaLR0UQ9q2bNd2ZfFTDuBehqTN6RExVNvTZnOS1P/hlVOe
 /VqvC4601O1hd34xPcA4LrRRi4xbPvSzE7n/15X+a63v9vhi3qwkgciL384MJH4dilyk+QtCD6S
 /KpaC1MfEmQwcDG9/lZhV4yJvKY02eJlR1geAQ4AohZeTRbLJb7MT+dlpc3H+2iMoHak3MsAGxd
 4KxyoERmoB6moIo8EPIuoV28p0L7O33IyMJAzQ9tWTFoOHb0KSaNoCq9DcgIy1rPUS7oymyuUMC
 aZPmxrkh6g560Cftr/p1peK9vjxhWqlmZmEhlkyJcl5Wwx/lEVK2Z/f+sNZqavwVnHoo=
X-Google-Smtp-Source: AGHT+IGowoUlWTjDdaszaB4+AC6dZ3HqXK+72eiQjT4Jhg3ult4abxcQNo/ey4IjCgpTpLt7AXGXsg==
X-Received: by 2002:a17:902:ce89:b0:234:d7b2:2ab9 with SMTP id
 d9443c01a7336-23c87472898mr28785735ad.12.1751627589663; 
 Fri, 04 Jul 2025 04:13:09 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:09 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/40] target/riscv/cpu.c: do better with 'named features' doc
Date: Fri,  4 Jul 2025 21:11:40 +1000
Message-ID: <20250704111207.591994-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Most of the named features are added directly in isa_edata_arr[], some
of them are also added in riscv_cpu_named_features(). There is a reason
for that, and the existing docs can do better explaining it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250529202315.1684198-4-dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250604174329.1147549-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 626b0b8b26..bf14256a61 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1377,13 +1377,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
  * 'Named features' is the name we give to extensions that we
  * don't want to expose to users. They are either immutable
  * (always enabled/disable) or they'll vary depending on
- * the resulting CPU state. They have riscv,isa strings
- * and priv_ver like regular extensions.
+ * the resulting CPU state.
+ *
+ * Some of them are always enabled depending on priv version
+ * of the CPU and are declared directly in isa_edata_arr[].
+ * The ones listed here have special checks during finalize()
+ * time and require their own flags like regular extensions.
+ * See riscv_cpu_update_named_features() for more info.
  */
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
     MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
     MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
+
+    /*
+     * 'ziccrse' has its own flag because the KVM driver
+     * wants to enable/disable it on its own accord.
+     */
     MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
 
     { },
-- 
2.50.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC8DC021B7
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 15:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlV6c-0006Cn-KW; Fri, 21 Feb 2025 10:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlV6V-0006Ap-EM
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:38:16 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlV6T-0001VZ-SG
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:38:15 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-220ec47991aso31365445ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 07:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740152291; x=1740757091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QngJEFJJKovZ/uA+suocSOP5z1bgaO/ljahDSblVzIU=;
 b=OKM+rdro2i8BVKm/FLaqmNemtivi5OtgyJURk3XFaJABlWd0IhkdqIlWnUFCz7SMpU
 TUV4YauNuJT0ITpIqq4VW1S/Oj0w1NkfAdxmS8h6DsypGGfr7qeBl6t9/vYcd4jAthFj
 s0qjs8nd+08SPvVBcgByQrjEzffv6kQ+e1nPX697jvyCzAHIUGzldO1JzLfu4nXomNcf
 vtZbklFxo9l+Kfm2PNxkIFjkKqGlUHRyd0fWhTa74fIdDhCnqWOCnJJ8U8k4FWmPYCKS
 hM7lfyTa7s5ZvOjDFh4eSYqENg72H626MxeNlh800QJlRNgEjXKBw8R3YRsjXrtIZwdy
 Pfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740152291; x=1740757091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QngJEFJJKovZ/uA+suocSOP5z1bgaO/ljahDSblVzIU=;
 b=sTsA0ivc+6tapP8JXgQqVSByDPSF0vkholw3MRHCGq0K2YliEOS5ofUvBLKTIRU/bh
 lc6UG6g5kZPWTa0Zlp2jMcK3DVLRIGFaA79IhLWvDIQUgpxEPntzHACcAY4hYbNf8WSI
 EduZa3Cb2lAgFLnwU1kNswKp1JzzpFxaMK03460ZbNNinSX9GEIXpAK7cRhrtml30vhx
 gKQ5IZufX12ueZL8bOGYLd1taHBf5enwfviTCnMZqN0F5oF32RczmVLfaWr544PNl7g/
 KxkbRimOIZSnsxe+8ubABbJbooJuLz4fHB5l9ioWzsVN1P4tKNdSCS5Kg9Nn8xM3wuXV
 EDpQ==
X-Gm-Message-State: AOJu0YzpYycj7o1uyPKeiLZehe5/dFgraAr4/cK1e03sbDW8ies+QESr
 6LLsVYlENQVvVwKgeXGaP2pu6WGZu+hGjslxwOgP83FK0/Vk4XcBCzw1qHj34ULopt+Zr/UB9gf
 q
X-Gm-Gg: ASbGncvXipOeNruiHbFuuZMK2TOFDFFzn5OAHYsZYlxHpZKcv/EW5yjKKj44rglp24b
 ACSRoHhqXDEpr+T/RF+ZJbcWEuVXu048dlbPy1xmRbHB0ovGvKNfIqVxENN4D01b4ji7RRmoMi9
 gkMDSSd+Gmc53hNm4Ooo3CrUTLPGdbvXgTtmA1YEGjOHa/RbYEJ6iNxtzLOCE5thmG1uSKKzzoK
 I62aQZo4rzXNb691lpKMZD3mEYVoqtey+Ibw4/vdAWpVXpnjgAARUJOi2hReNIM8O71xMwr4Xe0
 8cjJWpMd72z9b0e2VkR7wN07sKhKF0Em69MeFPzynVQF1ea03nVQ8w==
X-Google-Smtp-Source: AGHT+IEsWdh9Qt3H9k7Zwi5qDQ51Evp2NLNYjURELtu5Y7u7O4gX8uyMxcTOcC7c9m0v8fFFl7v75g==
X-Received: by 2002:a17:90a:d643:b0:2ee:8031:cdbc with SMTP id
 98e67ed59e1d1-2fce7af3f27mr5281023a91.23.1740152291573; 
 Fri, 21 Feb 2025 07:38:11 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.11.154.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb04bedbsm1538081a91.18.2025.02.21.07.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 07:38:11 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 2/3] target/riscv/cpu.c: create flag for ziccrse
Date: Fri, 21 Feb 2025 12:37:57 -0300
Message-ID: <20250221153758.652078-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221153758.652078-1-dbarboza@ventanamicro.com>
References: <20250221153758.652078-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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

At this moment ziccrse is a TCG always enabled named feature for
priv_ver > 1.11 that has no exclusive flag. In the next patch we'll make
the KVM driver turn ziccrse off if the extension isn't available in the
host, and we'll need an ext_ziccrse flag in the CPU state for that.

Create an exclusive flag for it like we do with other named features.
As with any named features we already have, it won't be exposed to
users.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c         | 3 ++-
 target/riscv/cpu_cfg.h     | 3 +++
 target/riscv/tcg/tcg-cpu.c | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 522d6584e4..fc4632ce36 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -105,7 +105,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
@@ -1749,6 +1749,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
     MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
     MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
+    MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
 
     { },
 };
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 3f3c1118c0..8a843482cc 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -166,6 +166,9 @@ struct RISCVCPUConfig {
     bool has_priv_1_12;
     bool has_priv_1_11;
 
+    /* Always enabled for TCG if has_priv_1_11 */
+    bool ext_ziccrse;
+
     /* Vendor-specific custom extensions */
     bool ext_xtheadba;
     bool ext_xtheadbb;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ea8d77d06a..c93612b1da 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -360,6 +360,8 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
 
     cpu->cfg.ext_sha = riscv_has_ext(&cpu->env, RVH) &&
                        cpu->cfg.ext_ssstateen;
+
+    cpu->cfg.ext_ziccrse = cpu->cfg.has_priv_1_11;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.48.1



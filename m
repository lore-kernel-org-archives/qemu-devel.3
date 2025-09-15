Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10443CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy4lt-0007WQ-6v; Mon, 15 Sep 2025 04:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4lp-0007W5-Of
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:09 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4lc-0002Os-HX
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:08 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-251fc032d1fso42035815ad.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 01:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1757925650; x=1758530450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gULplgMLCLslKgcVIvWoNyxi8gkKVOmzAYNJTIpxIg=;
 b=ZR2xikcOz8rB3q1wp6IYcOxjbS4P1GTK+Uv2F/vdmgILqxexi9YKg8A4WCQC/q68L6
 ek7jS5RD8CLJH8ZxtAp+qXgqRIZIBEBeAw9m/MbdO6vL3sv1/Hp0vP3BVY+GrEVxnQGX
 10uo74FzfX+xWf2zg4OBWKyQGjuyuC/bF+ENdbFDFmL6Tzc6AxjXR986Y35YiJLsAL+x
 W41pNy8nKE4s28cK249//hRvCX8WPThx6IDW1Uuloxc19SMR6EiOiiF0s7c3aVGME9kw
 QMU4rF6I6yWXnAz0el3kfDFbkdmeb840gL6OHm9QlsZaul7n+Qac6G4i8Duvmk9Z7VSX
 dxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757925650; x=1758530450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7gULplgMLCLslKgcVIvWoNyxi8gkKVOmzAYNJTIpxIg=;
 b=NYg66zjiXBI187ieHFVDoRZGj+7DCyWKFQTJXSANYP6rVFA1fWiZu+7Qr7pNS1Olxy
 Sg9MYr4Hvbisk3qfsZArjJ1tXKd7KgNOcmkKo88SCFBBFZLUloNUK4As6jF37FXZL+wj
 exmVkIBl0WFJe3p7hhd4rSAzyh+eMh587J5lrIc+XOUjhMFWrFenRmJfoP78O1OXGezc
 S8A1LD2t5PHUp7QC8v8MddqLypB6DpcI949G0GzB9NqQUgWQO2VS+Z5ypcJHBBhLn8Bp
 W8tDq2GZ01fG7VGWrxHlaCVIXEl1SDUkPtppMbT/Z7ck7CSn4f1tkCihB4Q/Fm9mGw7n
 JsiA==
X-Gm-Message-State: AOJu0YxutQu/rgShReiQMSTCLBRV6k4E8hPheT2CLohk0O+gyf7jleM3
 YClFHqwsHd7epXaWjsSbJ6/eUP0ENvuswTOJXOI7x2zq1Y9SEWcpPfVosHu/8AilDrkzOLTRoJj
 fVbwpk4lIZxzPobioDOvPXzo3Ul0FlaS/64jV6/OHjqyyYnVisKHMMiGmL/B7av+T2B4asaSNcZ
 EqzMgpQQ22Ex5WpW+Aot3jRF6KqHyHFSLAWPbvWeRv7Q==
X-Gm-Gg: ASbGncuSZaJr2p0t/B4pF3gWVZZIQLHDMdeRn9+x4C7CMWeImvrIxjMQP3ZJ+w8EFZn
 4OcwN9Q0gKV0ZLKex35uMSR2UyLTvC/fIHgyR7HHDW/wnUE5Kj8zxIDUTmznZCOkmtHciBp/x32
 857IvWQj/pDOCOFJ9HffW/GNFWma4uCDQ9d8tlCcjx5Ij+QpKOrSwutNAlq52o+iT1Q2Wx543MQ
 Ok+DEdEfGNkEZB5p6dBNCCMFF8Jfq/inMveoNQm8Ypn3vzMNCnDpZrPYvujoZFtFPibC0HVMblu
 glYZq2OyxKD7xwlEwGo8bR4n54dkNt/ohkAKbV8jWPrYpgiqcMSXNQuZSCcuqlHQtY5ay+eTEak
 fpMZTYBWbo6OJdKMHrtvvNxsfZAPnubWWr/sTNPMw5nw+pkFzTuc/uqEoavIL/i34678FC/Svza
 jY/w==
X-Google-Smtp-Source: AGHT+IGZO4l1hS8dha8ovnzDslNRABpQ9aoOETpEBmS09+P+ewAOiOeE29rYFU6k4Obd4m+DfSzUPA==
X-Received: by 2002:a17:902:dac8:b0:267:6649:ec17 with SMTP id
 d9443c01a7336-2676649f0bamr21805315ad.23.1757925650075; 
 Mon, 15 Sep 2025 01:40:50 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-26295996ff6sm55852045ad.64.2025.09.15.01.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 01:40:49 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 1/8] target/riscv: Add cfg properities for Zvfbfa
 extensions
Date: Mon, 15 Sep 2025 16:40:29 +0800
Message-ID: <20250915084037.1816893-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915084037.1816893-1-max.chou@sifive.com>
References: <20250915084037.1816893-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The Zvfbfa extension adds more complete BF16 vector compute support
and requires the Zve32f and Zfbfmin extensions.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d055ddf4623..fc0614dadba 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -169,6 +169,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
     ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
     ISA_EXT_DATA_ENTRY(zve64x, PRIV_VERSION_1_10_0, ext_zve64x),
+    ISA_EXT_DATA_ENTRY(zvfbfa, PRIV_VERSION_1_13_0, ext_zvfbfa),
     ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index e2d116f0dfb..f69be188e4a 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -96,6 +96,7 @@ BOOL_FIELD(ext_zvks)
 BOOL_FIELD(ext_zvksc)
 BOOL_FIELD(ext_zvksg)
 BOOL_FIELD(ext_zmmul)
+BOOL_FIELD(ext_zvfbfa)
 BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 78fb2791847..07b2b137934 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -704,6 +704,14 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfbfa) {
+        if (!cpu->cfg.ext_zve32f || !cpu->cfg.ext_zfbfmin) {
+            error_setg(errp, "Zvfbfa extension requires Zve32f extension "
+                             "and Zfbfmin extension");
+            return;
+        }
+    }
+
     if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
         error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
         return;
-- 
2.43.0



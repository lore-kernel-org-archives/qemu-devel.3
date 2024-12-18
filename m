Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2235E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuL2-00027W-NR; Wed, 18 Dec 2024 08:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKh-0001TK-QI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:25 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKf-0005hv-9Q
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:23 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3eb7e725aa0so2988096b6e.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529400; x=1735134200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxSMPB70buoVfSmQQZxKUhg3EBcEeRKpWGkuRu9RGT4=;
 b=R0e5zsjHAM0RWujYxxS1aptx4L7Eg7vlAk26homr5EU43I7uzhTjbTdgmN13smZW8N
 KRMZJVpwf0BNnTPPQ1rtNgDR5T5glTs0lhmWXkHf5Rtt6xM2y7KL5jbCY4/wEDkqh77T
 WRzF+YAmMySY9amRLfWGUo5SfAMY3qHZBwU0uBX7FZNxwqpSEhQEJZWt7fmGmnqpHnBt
 aC1Ne+Ew1pZNmpql0BoJ9SUJdB7NKjE2F7EdbjQCzusfnzD8eg3JI03YGH3Fk/drZP79
 oCOj4NaUxsVDtIF63K0RLwQ7ijFgxO78Yh19z1g6x4znF0TRdCH6nKgJsN7kKuNmBUA7
 Odrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529400; x=1735134200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OxSMPB70buoVfSmQQZxKUhg3EBcEeRKpWGkuRu9RGT4=;
 b=ZVgvVMb5CUr5OXYYzQXBgvhyXHX42cGI24zVKRLgKeDrmnEL119W4BI7CUs00l8Icq
 XxIR7b7vKPU5KAaPtDy/6c05HVte96XuyNgt92bScOP5ZDRTuGjferaEGH8CnwRk6uNp
 nSr7YQtDY0pMZORDnhbbMH7tKmWL+DCvd+h+0jdlILdLeEN731un8il9XzmeKWK781Rf
 f7eE5vf2AvDXbEGVKi5TiQnF7KaqPZ0xd8smdgaAigkWHx2vrF6yf78XVYRMgjCT4NT2
 X50afdf7tNUDW5HxGvcNSJ/Rdz4aHamIjtUcvXhMkjpO2kLOnyeeO/zG32BbXroUNK3D
 4G5Q==
X-Gm-Message-State: AOJu0YwOAUp1G2WHNilOiwHQ5AJL4KQg1XrdITUPBaBjj9LlxzFMJ//e
 B+XGocRmaYOIk4ojiTAMaZ/mTpYBmd2NA8fIgJ8v9Zr5+0SiodC2ZrKh5CKpCM+VneNk0v4y6uu
 Id4buCiNt
X-Gm-Gg: ASbGncvDK0wwE0ixnFu4EaymRkrppdD7lLp7s+MU1xF4ahlr1SLnTfmlsyxx+yAFp/4
 EiOaq8ShHAtYFVreo7M19eKd7qgBB8sh8C9JzfwcaxnQODzuvF7zJn4oMPrIaI9PWCJUXEiDZ3j
 TrH+zRi+kYJ0Q5kBa2kC8LCL61qfAcfWkDSl3S8dLj6KVAKile+i1nHwXL6PeQeGxDgaGVIzVrk
 gA3mlRKYhHo9j847NcosTMwGxivWkUAUNiBo5k6yi+LUbOGZa19xkKMYlpirMVv
X-Google-Smtp-Source: AGHT+IFLmoO8dajMIUuuHLNGN3/y6Jw+BcOC/s5dZTx7YyN11O68NBaiKI9vivKUfmr+sMJYvBRBew==
X-Received: by 2002:a05:6808:2dcb:b0:3e7:df63:15bc with SMTP id
 5614622812f47-3eccbf54608mr1786724b6e.12.1734529399954; 
 Wed, 18 Dec 2024 05:43:19 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 19/24] target/riscv: Do not abuse DEFINE_PROP_END_OF_LIST
Date: Wed, 18 Dec 2024 07:42:46 -0600
Message-ID: <20241218134251.4724-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

These are not arrays of Property and had no business
using DEFINE_PROP_END_OF_LIST.  Use plain { } instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4329015076..7aa041f57a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -213,7 +213,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaCondOps),
 
-    DEFINE_PROP_END_OF_LIST(),
+    { },
 };
 
 bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset)
@@ -1575,7 +1575,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zvksc", ext_zvksc, false),
     MULTI_EXT_CFG_BOOL("zvksg", ext_zvksg, false),
 
-    DEFINE_PROP_END_OF_LIST(),
+    { },
 };
 
 const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
@@ -1592,12 +1592,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
 
-    DEFINE_PROP_END_OF_LIST(),
+    { },
 };
 
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
-    DEFINE_PROP_END_OF_LIST(),
+    { },
 };
 
 /*
@@ -1610,7 +1610,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
 
-    DEFINE_PROP_END_OF_LIST(),
+    { },
 };
 
 /* Deprecated entries marked for future removal */
@@ -1627,7 +1627,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[] = {
     MULTI_EXT_CFG_BOOL("Zve64f", ext_zve64f, false),
     MULTI_EXT_CFG_BOOL("Zve64d", ext_zve64d, false),
 
-    DEFINE_PROP_END_OF_LIST(),
+    { },
 };
 
 static void cpu_set_prop_err(RISCVCPU *cpu, const char *propname,
-- 
2.43.0



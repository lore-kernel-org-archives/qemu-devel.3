Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6884E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBy8-0004cA-EL; Thu, 19 Dec 2024 03:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBy6-0004bF-Q8
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBy5-00059v-23
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpJlOEJ961c7veV4jeI0mdyngDxo3kPLK4mRT/QxfVE=;
 b=VRjsEOohnkdb3LdmAKWDdO79vrDKw7+Q1Hw9Fg85jzN3em0UzmtdVgcrtdMQmis4F6pz1h
 uA2GRAmbBHuYlT6Uk3QpNVX42AxFnlJqiAom7ZCCO/uzdYt0yp9kQyj7uYhQUSs0wizAYj
 N8CBPbIebL3lExPeqGG+zDwfImoGcos=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-96CbZZuENKy4hcjJNTPdTw-1; Thu, 19 Dec 2024 03:33:11 -0500
X-MC-Unique: 96CbZZuENKy4hcjJNTPdTw-1
X-Mimecast-MFC-AGG-ID: 96CbZZuENKy4hcjJNTPdTw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361ecebc5bso2933605e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597189; x=1735201989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rpJlOEJ961c7veV4jeI0mdyngDxo3kPLK4mRT/QxfVE=;
 b=alt6BuSYbGHLaWOuA2YhxUQN8STAxEjandOkdAcrZbw4yjm5JRSq54Ed4cBDzOqZIz
 MFfUa9AfHmcWBtRO+s0Hs0ibT9uPU4wC0aoy5lpR2ZH/hKFCG825ZZCNTOJsoAqCOaQx
 75hC28QaGOhRMOjzXIqJGeecNdSI03GVnhLZbx18pfwZooWEoY3JLHPgSmI0jx7b40/9
 2SWzgfMZ5Dm5g+8iczvuBKgB13TMlCTLbozSZXARLy6EK3zNbIvPmPBt6VULXOxJGVb4
 L9Fy26GDd6k1iVxDJXSquHLt65s/7hMb4gH6HJBwubpOPQ9jSO6x8elnOgYJst7jRhgS
 EEiw==
X-Gm-Message-State: AOJu0YwXDy1WrKMtdw2iVJUY9PnE7Oid4mavRZWo19zzjWKoH+bTv7gS
 CJAQJJrl6LBqsD/Zss/xyzMDJOH+yIbjktYPuaYxmv5EBSkmMWk1aF7Kn+taKSeiqsziTD5mFwl
 QjSRvLxTeESi20s6NC97y0gCkpieFiCzS7UN4S8ZlNP2gEM4n+MSNDH71fOfW1Lim2iJotrsAv6
 ny+dTlxh+1nKdM1cerGzfuQux97ktGOtif/XWH
X-Gm-Gg: ASbGncuumBvClhIjg9EZSVaZAtu79GEC2HhyxMk0T284Dv5Fz9CENZp0lcPO+EwkPR6
 jktFrc80NJ2XXy11n4ulM2R1DgpKFPxuaO+8Y2HSRyE4GUNByaE1NlijButbHicvCDwj1hBhqSm
 McZ81/goOs+y4CujQwNh8mCzL1x/3qhmY0mkU0A3TbOYMBiBJCm0ABGDyZ6/nhN6jJzVxFdOA+4
 xCY9gBCUQP2tQwNlgkHq4E7fqsYhfdhXSjuHdYGXRWRBXVuKZpUNflc+7Es
X-Received: by 2002:a05:600c:5107:b0:434:ff9d:a370 with SMTP id
 5b1f17b1804b1-4365c7415f9mr22208645e9.0.1734597189154; 
 Thu, 19 Dec 2024 00:33:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0ft6AoK4qyt2SBK+6eKmzZNwLB9YgQsLbUYr6S07T6byM2bmBH/OaV/q8xYBdLj04E3VOEw==
X-Received: by 2002:a05:600c:5107:b0:434:ff9d:a370 with SMTP id
 5b1f17b1804b1-4365c7415f9mr22208245e9.0.1734597188680; 
 Thu, 19 Dec 2024 00:33:08 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea40csm11186705e9.1.2024.12.19.00.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/41] target/riscv: Do not abuse DEFINE_PROP_END_OF_LIST
Date: Thu, 19 Dec 2024 09:32:06 +0100
Message-ID: <20241219083228.363430-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

These are not arrays of Property and had no business
using DEFINE_PROP_END_OF_LIST.  Use plain { } instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-20-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4329015076d..a5aa3a8670a 100644
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
@@ -2699,7 +2699,6 @@ static const Property riscv_cpu_properties[] = {
      * it with -x and default to 'false'.
      */
     DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 #if defined(TARGET_RISCV64)
-- 
2.47.1



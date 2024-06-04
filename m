Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98109C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENuP-0001yP-Qk; Tue, 04 Jun 2024 02:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuO-0001y4-Qu
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuN-0007Fp-9V
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/55UBJHPP0pMfaMY7gMW8buEJYTanSZ8PJmFCw0e2U=;
 b=EbIKPb54VRRAT5L7tyBZSU5vDVt2AWgqZUqynM9987SABsBSyqBbJcfn8ULFH7LNK9gluv
 9TOwsMu7QQ59x2mH/uPaqd1RG9+TcFa5OvtzLjaD5Trqjt2Xlc5EnrbZHN6iG/DiSYZLiC
 hrDYWEN3ggnIxSa8uUMse/Wi4QfkvHM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-KLy0m_I2MnCRgUiIsNYkUw-1; Tue, 04 Jun 2024 02:44:28 -0400
X-MC-Unique: KLy0m_I2MnCRgUiIsNYkUw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52b98d73cf9so1313982e87.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483466; x=1718088266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/55UBJHPP0pMfaMY7gMW8buEJYTanSZ8PJmFCw0e2U=;
 b=VFKEXIIA63ix56rALgYUTSYQS0V8DYJ1vtmyN18TLQhS7t9dXkMklLm5P7nCiD/Hr5
 VWcNO3qnt843nlIlpDHe5qckgFHmfVGTMRbs6/pwsq5sht24eORgEfNEjkN29rb6GmkO
 VCV3vFqNiNbLMX8/uuIqwveTsY50sMxl/2u2w9GEOVA2MfQb+Z5bS9QFiwtb3oCSX22l
 S8dT1U+RhmEb8EWMf6HkaqkqGEoghmsDrA/oZkMi45Izrqg4B5q00wfGuORN8PZ8OqqA
 lK3aWpH4ZhhM2AMdMT9aSFzgn9XavCzhiIukW/8qdlkB1Kh+qTbIpLLsbwrlf3+dRt5Q
 WxbQ==
X-Gm-Message-State: AOJu0Yyx7jQQ1zGOuTrAyXlks8uM0S7X+jDOf/lk/vTTBAvDgBqQyfGm
 PTrwsPg3EI9ocWEHVIzby29R+8OurOYl7H77EBgrSdLX0+nCVPSIOkDzi9M6D4y6NUgqpuol4Aq
 nEzyeQcSZ5hriIRLB3tRFLCn/9RInAkfZ5aUboIVl6nWtaXqQcUeQGisYajgUDBioiMkrOeR2bB
 1cwHheif/M7dfjY3swmMiWo9+ujnQLQGsDDxg7
X-Received: by 2002:a19:4354:0:b0:529:b6c3:be9e with SMTP id
 2adb3069b0e04-52b895217c9mr9184857e87.9.1717483466532; 
 Mon, 03 Jun 2024 23:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRDasS5jYE+hqoRdKRlitDs5LYgGcsTzuc7JC8xJ7IkT1+pRVWkPjM894yZ1los0NCQKnVdg==
X-Received: by 2002:a19:4354:0:b0:529:b6c3:be9e with SMTP id
 2adb3069b0e04-52b895217c9mr9184842e87.9.1717483466099; 
 Mon, 03 Jun 2024 23:44:26 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68ae9bf7e2sm462040966b.213.2024.06.03.23.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/45] host/i386: assume presence of CMOV
Date: Tue,  4 Jun 2024 08:43:28 +0200
Message-ID: <20240604064409.957105-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

QEMU now requires an x86-64-v2 host, which always has CMOV.
Use it freely in TCG generated code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 host/include/i386/host/cpuinfo.h |  1 -
 util/cpuinfo-i386.c              |  1 -
 tcg/i386/tcg-target.c.inc        | 15 +--------------
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 9386c749881..81771733eaa 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -9,7 +9,6 @@
 /* Digested version of <cpuid.h> */
 
 #define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
-#define CPUINFO_CMOV            (1u << 1)
 #define CPUINFO_MOVBE           (1u << 2)
 #define CPUINFO_LZCNT           (1u << 3)
 #define CPUINFO_POPCNT          (1u << 4)
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 18ab747a6d2..90f92a42dc8 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -34,7 +34,6 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     if (max >= 1) {
         __cpuid(1, a, b, c, d);
 
-        info |= (d & bit_CMOV ? CPUINFO_CMOV : 0);
         info |= (d & bit_SSE2 ? CPUINFO_SSE2 : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 59235b4f387..9a54ef7f8db 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -157,12 +157,6 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define SOFTMMU_RESERVE_REGS \
     (tcg_use_softmmu ? (1 << TCG_REG_L0) | (1 << TCG_REG_L1) : 0)
 
-/* For 64-bit, we always know that CMOV is available.  */
-#if TCG_TARGET_REG_BITS == 64
-# define have_cmov      true
-#else
-# define have_cmov      (cpuinfo & CPUINFO_CMOV)
-#endif
 #define have_bmi2       (cpuinfo & CPUINFO_BMI2)
 #define have_lzcnt      (cpuinfo & CPUINFO_LZCNT)
 
@@ -1815,14 +1809,7 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
 static void tcg_out_cmov(TCGContext *s, int jcc, int rexw,
                          TCGReg dest, TCGReg v1)
 {
-    if (have_cmov) {
-        tcg_out_modrm(s, OPC_CMOVCC | jcc | rexw, dest, v1);
-    } else {
-        TCGLabel *over = gen_new_label();
-        tcg_out_jxx(s, jcc ^ 1, over, 1);
-        tcg_out_mov(s, TCG_TYPE_I32, dest, v1);
-        tcg_out_label(s, over);
-    }
+    tcg_out_modrm(s, OPC_CMOVCC | jcc | rexw, dest, v1);
 }
 
 static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
-- 
2.45.1



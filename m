Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67766C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu42-0001c4-OA; Sat, 22 Jun 2024 02:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3F-0000Mb-Uh
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3E-0006U0-Ce
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719036999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GlW/705FWiMprOSUKjNiwJlL+EDmg1xNJ9taeoREqJs=;
 b=IzXFjZfhu9dkbwmXp7Di6S/LzHUkidghFmzSnQAREtCdLCjyvscrDiNXjOdoT7wQMt1CYb
 Kvuzz/ohmw1m5QoRkd+z0Mqx1/U4PXADUwlTjIxcPRL+nuaRPx1uWfiIDau3U25wCOi+eZ
 HEpvZVaJRYcb6u5RPpoiVXJ4p9N2HIM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-h0SgzrNpM5es-2my7kra-A-1; Sat, 22 Jun 2024 02:16:37 -0400
X-MC-Unique: h0SgzrNpM5es-2my7kra-A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6f0fee1f49so127881266b.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719036996; x=1719641796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GlW/705FWiMprOSUKjNiwJlL+EDmg1xNJ9taeoREqJs=;
 b=ppsDze2nPOhTfyuxUh+T1fD/k7hhRESuzNvpv+htgSCdo5VtG8rZOuB2Nuypc0gU72
 1X8RCLclEum8vf32yTnTwxRlDBL/7Y7etjzrBHcbHcrBlnO/mDFaLpeXwhNEf2tVl0/l
 gDv+ZAlFHo2itURQLIUVhIJlooYQv1b02DGPFPzCM3oNln3zc4LmwVpJa5/aDb45FKhY
 HhQUiJjBeoKDNOKCmtdj36bavL+/Iza3jmmvlJyVUa3md+tBokE585o3bLHxe4Fd3oPY
 6GoY0k5SZKmHfMmvhP7uevzKAohzZkYruzWGGYJ/UQ4PyaqxUoT00+GyIwY4c75NiKPX
 yCvw==
X-Gm-Message-State: AOJu0YxCRxXXMitVrhepyLT1jXLaKfF8BJK3awZ49CB3HJQv3IxIsBt3
 kQg+GhZSs8Gl0ta9rD7txYe64nyEu2/1yXgHWOBeWodmXqahIuIThnEI+aNqQMlyZ/+FQNFFa4R
 xVAp4no2OxtgEBrKXCy/GdyxonPFsZHLv4UKBnn9Q2UeTSguO2jp26Ny/P+a4rxpIzXc7ZSgrPc
 saKy3lKNCnlcmB19xXpbtKYUC7QhNFRBpFgq1T
X-Received: by 2002:a17:907:a64a:b0:a6f:ae81:172 with SMTP id
 a640c23a62f3a-a6fae810724mr680068866b.65.1719036995888; 
 Fri, 21 Jun 2024 23:16:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe/4fRq3weQ4uM6uwpu0Zp0ZoObqNzisXou7n33vCrCBbVEHX5m4lDXP5qhXISKpKhHbWLaQ==
X-Received: by 2002:a17:907:a64a:b0:a6f:ae81:172 with SMTP id
 a640c23a62f3a-a6fae810724mr680067766b.65.1719036995518; 
 Fri, 21 Jun 2024 23:16:35 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fe4eeb106sm37935166b.167.2024.06.21.23.16.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/23] Revert "host/i386: assume presence of SSE2"
Date: Sat, 22 Jun 2024 08:15:49 +0200
Message-ID: <20240622061558.530543-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This reverts commit b18236897ca15c3db1506d8edb9a191dfe51429c.
The x86-64 instruction set can now be tuned down to x86-64 v1
or i386 Pentium Pro.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 host/include/i386/host/cpuinfo.h | 1 +
 util/bufferiszero.c              | 4 ++--
 util/cpuinfo-i386.c              | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 72f6fad61e5..81771733eaa 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -14,6 +14,7 @@
 #define CPUINFO_POPCNT          (1u << 4)
 #define CPUINFO_BMI1            (1u << 5)
 #define CPUINFO_BMI2            (1u << 6)
+#define CPUINFO_SSE2            (1u << 7)
 #define CPUINFO_AVX1            (1u << 9)
 #define CPUINFO_AVX2            (1u << 10)
 #define CPUINFO_AVX512F         (1u << 11)
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 11c080e02cf..74864f7b782 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -188,14 +188,14 @@ static biz_accel_fn const accel_table[] = {
 
 static unsigned best_accel(void)
 {
-#ifdef CONFIG_AVX2_OPT
     unsigned info = cpuinfo_init();
 
+#ifdef CONFIG_AVX2_OPT
     if (info & CPUINFO_AVX2) {
         return 2;
     }
 #endif
-    return 1;
+    return info & CPUINFO_SSE2 ? 1 : 0;
 }
 
 #elif defined(__aarch64__) && defined(__ARM_NEON)
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index ca74ef04f54..90f92a42dc8 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -34,6 +34,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     if (max >= 1) {
         __cpuid(1, a, b, c, d);
 
+        info |= (d & bit_SSE2 ? CPUINFO_SSE2 : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
-- 
2.45.2



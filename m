Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96415C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCyMA-0000rm-06; Fri, 31 May 2024 05:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCyM7-0000rP-8s
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:15:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCyM5-0006Wa-KN
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717146921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h4dxy80BqAWrXewK++xL3LyI1uNJCiqpJS29BSHBn6E=;
 b=SgPYiV1poSawAIPBH+GoBYF+gWmkLBP9wq6ELRfUyfmmF4dA6+QBLy+dfpLsCMC+l0XZFs
 I5sf/Meu7S8/eX2VO5SnonL7UHONeIFxqbdf2cdTITHaA7wGWi6Vh4Qjngmfs53hr+9O2q
 hsqS4ljNsxnXXiRJrT2co2gZKq8G+WU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-Aecg4W78PjaI-4419lq_KA-1; Fri, 31 May 2024 05:15:17 -0400
X-MC-Unique: Aecg4W78PjaI-4419lq_KA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52b799b71b5so1196383e87.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717146915; x=1717751715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h4dxy80BqAWrXewK++xL3LyI1uNJCiqpJS29BSHBn6E=;
 b=SdnWCPPGgwig050Xdcz2B876i89rhd56P5xngpBDRbdBginTHDMws+/TC4SfxbRhH7
 IFd89zqF7z6GHpJlszJu0NCy+pElTTEW9CQZJUzQccwKJiVxWY6K/U3gsHzBPW6vgoT9
 04Io50WSx6YYY1lwDYNcE7hYor93MeBLV6vFNllPvS7zhExJcYu4oMFzWtNp2Rlp51aI
 mAVDxAnt4Ew/WCcGo3PYzC1w14tgId6BfO8o54Ya7pA+HjdoETqFTw8CZvllPYh44GeF
 p4Gu0IcoL9yZR7AHxrw17oZYsAAGpTo3r1/TTdk0qX3TlGoAFeJQZQeAImxYWAwp5uft
 tGsQ==
X-Gm-Message-State: AOJu0YwsmqpGVdLphU0BL/LI4EG+H46dIWCd+BCkTYnWi3uUvlxkWa7H
 xbkg22oZ+qT4YH3NZPKiQHifAVumJ51ExxKOmk49MA1gUCbkHDVEIm2TYY4RJJUXhBc11FYfyVp
 yNDu9DqBHlXCDFaZMICP/uyYkJVbk2Wc56T2B3+Mz4b7QzyuSt1EfM3XiuSHl8qoqCPXB+1D81J
 BoIqPxElBhdaVgvfwZrqFqKMoDD0eXb79Sfa7O
X-Received: by 2002:a05:6512:74d:b0:51f:2908:df48 with SMTP id
 2adb3069b0e04-52b89570f5dmr684490e87.18.1717146915152; 
 Fri, 31 May 2024 02:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG32g53H0REfdLNPT2JVx+vN+ZZ2QJuEVDA7iYUsLJDwPNU3YAYXuQ3mvhejFQR9IVSzMLAeA==
X-Received: by 2002:a05:6512:74d:b0:51f:2908:df48 with SMTP id
 2adb3069b0e04-52b89570f5dmr684473e87.18.1717146914642; 
 Fri, 31 May 2024 02:15:14 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67ea67b6c6sm65028166b.103.2024.05.31.02.15.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 02:15:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] host/i386: assume presence of POPCNT
Date: Fri, 31 May 2024 11:14:57 +0200
Message-ID: <20240531091457.42200-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531091457.42200-1-pbonzini@redhat.com>
References: <20240531091457.42200-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

QEMU now requires an x86-64-v2 host, which has the POPCNT instruction.
Use it freely in TCG-generated code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 host/include/i386/host/cpuinfo.h | 1 -
 tcg/i386/tcg-target.h            | 5 ++---
 util/cpuinfo-i386.c              | 1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 72f6fad61e5..c1e94d75ce1 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -11,7 +11,6 @@
 #define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
 #define CPUINFO_MOVBE           (1u << 2)
 #define CPUINFO_LZCNT           (1u << 3)
-#define CPUINFO_POPCNT          (1u << 4)
 #define CPUINFO_BMI1            (1u << 5)
 #define CPUINFO_BMI2            (1u << 6)
 #define CPUINFO_AVX1            (1u << 9)
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 2f67a97e059..ecc69827287 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -111,7 +111,6 @@ typedef enum {
 #endif
 
 #define have_bmi1         (cpuinfo & CPUINFO_BMI1)
-#define have_popcnt       (cpuinfo & CPUINFO_POPCNT)
 #define have_avx1         (cpuinfo & CPUINFO_AVX1)
 #define have_avx2         (cpuinfo & CPUINFO_AVX2)
 #define have_movbe        (cpuinfo & CPUINFO_MOVBE)
@@ -143,7 +142,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
-#define TCG_TARGET_HAS_ctpop_i32        have_popcnt
+#define TCG_TARGET_HAS_ctpop_i32        1
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
@@ -178,7 +177,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
-#define TCG_TARGET_HAS_ctpop_i64        have_popcnt
+#define TCG_TARGET_HAS_ctpop_i64        1
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index b413075b9f2..883dfa4dd95 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -35,7 +35,6 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         __cpuid(1, a, b, c, d);
 
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
-        info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
 
         /* NOTE: our AES support requires SSSE3 (PSHUFB) as well. */
-- 
2.45.1



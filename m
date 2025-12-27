Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07CDE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQul-0002PW-RW; Sat, 27 Dec 2025 04:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuT-0002Fm-Ha
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuQ-0006tA-Gs
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTeoXBXn1B2oSI1CWXAONsVZ5J/6RHjxwZByIoSgDCA=;
 b=f1epY7y0/cvm3xFhlZKYj+kFWY6zciFcViWkhw+UpDEoT9RB0LCdHrgcDXm2kIAbrz9HLM
 urR71k74fhhc5T46MwJjqWz48EmlFASR25B9NP3nA//t9oL/Aqm3UOUjg05RatXARdAop+
 I0OdedwUExMh+loIaW7TPsoh50vXdec=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-ONYCdVLONReu9D0ptkRK0g-1; Sat, 27 Dec 2025 04:48:23 -0500
X-MC-Unique: ONYCdVLONReu9D0ptkRK0g-1
X-Mimecast-MFC-AGG-ID: ONYCdVLONReu9D0ptkRK0g_1766828902
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so78144875e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828901; x=1767433701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTeoXBXn1B2oSI1CWXAONsVZ5J/6RHjxwZByIoSgDCA=;
 b=fxezDw39/fydvfvOp6tuRDrW1epxTJLuVjbesfQTfZn5dc3gSoDmBymqBdanP0w6sv
 Fd3ZkP3WiMtVsyF9VGXqUG0V7yymxqDD2N6991Dpt4e9PvGBFDAXH0PXtBEmmof8zViz
 XucnNzF23w4PFvKnWNU42HAOkl1zf/7t3v7WypAR21VJDIL/4T48Mewezpm5Ucl+zyFW
 ykMgp4rnH7ql6yy6W1o5+MdDU1XiaMP8iwYlsYngmXapRmLyeAdukLrrcsTa0HUJGhBJ
 9YFeVoaiVvib40ICd8Wabpmr7IL/a0iK7S8ZKc7zdL+WsY5ylaMXJ8cOq4oNBOzP1fi5
 MfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828901; x=1767433701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WTeoXBXn1B2oSI1CWXAONsVZ5J/6RHjxwZByIoSgDCA=;
 b=v9yA/yx76LYw5SrYmUd+s8extAcrg/0VqVvcLhtiOby3EL3ZfIJnsyEfaXmlFjbMIw
 jpIQFr1ChtGaAPMNwHa3h7LH5ACUndRCKGcYYoDHe/FKV2/eMHR7W+II/G0lp+OIm78p
 meaoaL/XBbrivsClkuhY1p/l6Bvxks3S+aZjbVo8oqX/u94hafAFvLNJ1fp3PHxqghrx
 XD5mYlTRfc/I6bbpsZEbzGODvpqOIdDHTYl1RKFqV6+P6/czVOYQBmXoORJVacCiCsO9
 QPDxIrLk7FOIJAO6nYONyUhzMFXZJUMLP0MnJ9xEOW5QbtoIHqEfzUZp1IVKvEEBpx+v
 adyg==
X-Gm-Message-State: AOJu0YxFpcU+Qw9FPDtUNg3NSYi1gBLurKIBzt5GqoijAz3e0SoZjibv
 JI2RHI9GwmPTkMMQPncdy7Lqi0YMwCa7IwOyIeheslV0W1PzHqEOO64oT9aiuOoIBAF9L1F2Dzp
 qvpzR2HMmJ6zFrqEba5KCQd1LCClLrZ2b5TfG0y/QwAwOLV4+oJx00tiLYDYMXVI6sCFEnoPAUD
 3ogcWVtfS0O4ugEqdR2HnW0TXmHoyh5KlEbRMOrnzP
X-Gm-Gg: AY/fxX6SCLV9qXLu5S+HaCEDaqtiQFmnfUQ0FVAbeIboib07Z+cQoXf9dtRX4uPATlg
 Zm1rHqi/dE3KZk9TCJ12hCuOvGODL6kn0vdXyjxnGSH4j6v6GgdlgzN+uFgNjSXBeugvZghXx1s
 cNe7fDJ4MkhhoD1Hre4Wm7ymripamLQC+K5GNpAPsy8DdM3uUMmzzcW9AyPvdAB6W3s4mP67hOQ
 kIOCSreh+Gk0ZG0pUOi3/W/1dqXuo9WicFSeT1DFUBB1xdFf/qNnP0aVF1TqkFY468/sEyrQbii
 T737HYaFqzC8Ba6PoW5Tv4umTv3PkUZ6Uag/A5ln+9l0YwnwfPqNQy05+7rIb4xifjChsoRVdwf
 S5sgn2Yg6k2DGLj+hCQ08eldXORSX07D+6RKr+EZ9we7/mrSWD42grjHOWs9RXZupVUiAtayMZK
 GiEyn6rtC/55YdjLk=
X-Received: by 2002:a05:600c:3b8f:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-47d19593d0dmr358821435e9.32.1766828901352; 
 Sat, 27 Dec 2025 01:48:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKZdXGqXZnciz1/2yMkVCMRq0EAQV1ZYIdi0KpOwKuLxiXRfIB5P/hE1XkkNgFIWn6fmaJXQ==
X-Received: by 2002:a05:600c:3b8f:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-47d19593d0dmr358821195e9.32.1766828900932; 
 Sat, 27 Dec 2025 01:48:20 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273f147sm498023555e9.7.2025.12.27.01.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 084/153] i386/cpu: Add CET support in CR4
Date: Sat, 27 Dec 2025 10:46:49 +0100
Message-ID: <20251227094759.35658-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

CR4.CET bit (bit 23) is as master enable for CET.
Check and adjust CR4.CET bit based on CET CPUIDs.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-13-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h    |  9 +++++++--
 target/i386/helper.c | 12 ++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index bc3296a3c6f..a1ff2ceb0c3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -257,6 +257,7 @@ typedef enum X86Seg {
 #define CR4_SMEP_MASK   (1U << 20)
 #define CR4_SMAP_MASK   (1U << 21)
 #define CR4_PKE_MASK   (1U << 22)
+#define CR4_CET_MASK   (1U << 23)
 #define CR4_PKS_MASK   (1U << 24)
 #define CR4_LAM_SUP_MASK (1U << 28)
 
@@ -273,8 +274,8 @@ typedef enum X86Seg {
                 | CR4_OSFXSR_MASK | CR4_OSXMMEXCPT_MASK | CR4_UMIP_MASK \
                 | CR4_LA57_MASK \
                 | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
-                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK \
-                | CR4_LAM_SUP_MASK | CR4_FRED_MASK))
+                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_CET_MASK \
+                | CR4_PKS_MASK | CR4_LAM_SUP_MASK | CR4_FRED_MASK))
 
 #define DR6_BD          (1 << 13)
 #define DR6_BS          (1 << 14)
@@ -2948,6 +2949,10 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
     if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED)) {
         reserved_bits |= CR4_FRED_MASK;
     }
+    if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) &&
+        !(env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT)) {
+        reserved_bits |= CR4_CET_MASK;
+    }
     return reserved_bits;
 }
 
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 72b2e195a31..3f179c6c11f 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -232,6 +232,18 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
         new_cr4 &= ~CR4_LAM_SUP_MASK;
     }
 
+    /*
+     * In fact, "CR4.CET can be set only if CR0.WP is set, and it must be
+     * clear before CR0.WP can be cleared". However, here we only check
+     * CR4.CET based on the supported CPUID CET bit, without checking the
+     * dependency on CR4.WP - the latter need to be determined by the
+     * underlying accelerators.
+     */
+    if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) &&
+        !(env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT)) {
+        new_cr4 &= ~CR4_CET_MASK;
+    }
+
     env->cr[4] = new_cr4;
     env->hflags = hflags;
 
-- 
2.52.0



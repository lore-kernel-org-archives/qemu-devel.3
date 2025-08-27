Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAC1CA0FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4hP-00010U-SG; Tue, 26 Aug 2025 21:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hJ-0000k8-N6
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:34 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hA-00006Q-9J
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:33 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e4f2e4c40so5593291b3a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257082; x=1756861882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zz0hmw1zkEGR7aCPTEKOMC5u8UDV58D53zKh3dJcGq0=;
 b=J0d7o7CWAha3SHBPPegnPdwIjDooiulPSkcjxCIZvEJl9vSa6PLVYGSWzd6n4VUCsI
 oUIGA4bEymLZZqs+ahjPny/wdpiSYFEUlA0nk/BvIt819ZWHIzsq+2OfZvBFcQ9U44q5
 5/zZxTbPkurlNH4nNIUmbnrJbmw66shAlqDNh9QsneyoKu74fiZWeHue06qsSrzwX6CK
 1l03v+/Go8iRSaPVmgI/kEf0mLhAUa9nSSuEDjEovLvPJQelgTTb9jd0Ihk1WUcizBZR
 43vpveQ/9+DaandZRh2FTYr2YzKjokgvWHkGS2roHzlcQ7RQCGW4YdfEjDV1ZeDGaIGJ
 AG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257082; x=1756861882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zz0hmw1zkEGR7aCPTEKOMC5u8UDV58D53zKh3dJcGq0=;
 b=Otw3MyLed7HR9bSK8DVAROa2K2UYYef0AAl/0yKKv2kyQ9gCjA4wrDEV2nLEsIuplH
 PfSHXlFMv8nMYOOKogVTt4l0QUqNWcY5nYsP7pkq5lLtYw3AYsf67CWmnBsp5JsmFDeB
 AoaAVaid1bgjTXw058mtgicXCTGJUgK4TRafClKvN/QASsGEe6bHAf0nE78PXnH8YvVN
 vQGrKeKbiss8LLHpANZBRjlwGZ60/04v/PwjzBw1Rg9tV8R5KAX+wFxD5ohd2Ks0NUTk
 wmV7OoVH9Wos6Z6OhXU4arJMh2KKH4McKTNOPcYqH6b+ccLMMY8GOqJJ7uifce57eaUl
 nzVg==
X-Gm-Message-State: AOJu0YyZ5/hpbs2mT5bRQXSL873j7RsrH97KXeTN61Gsr3ZOHUgwQ+pR
 zd0uf2zQqNDOitAUzRmlR6vi8OZ2uWwqHI4fIvwPbQW8SgQZqA/zQ58ZflX0hcBoFD8LvCf3S/t
 yhgc3Iq0=
X-Gm-Gg: ASbGnctfs4/ahbyXW2CpdeVXKYmv8hGWoINFoKT4yABEABdirfKl6pvUajuI0AxQZZ7
 KVPBYGLK6DHb8W0otTzSqH3lkReYf3dYrdWzNpenCiGbDJhgZtUcXc17sOF/NfauobfJldCPMiD
 +qglDJXJhNJ/If+eTu2U9RhBlZy4ZJoRPOWt7HMiwdh9N1olgcTOK1pRjQGQKzgyrpouXlYnqYE
 11GGOoht9+dsd0DnFHzhFIpedfRMtf80rOaG0pBVmleITmHBSbjKDgQe/3AsGxwfXZ0dZkEh68d
 rKQlrSDrkSvTlqhtdpI3lx3RCSYPVwx9PrLLYmVmDDjPzbT3JWNCUz8ImFYnWUmFrY3Y2BT+Fpf
 PfNVhGI+qgrXc2bu3kwkbFog0xaihJdi0lGox
X-Google-Smtp-Source: AGHT+IFIAzgJHlHTSKwMVmY4Gp1Q4zava46tZeWpZ4+0M+pLKnxAF/mST+jg/eCTurrR08kf/Fa5mQ==
X-Received: by 2002:a05:6a00:13a9:b0:771:e114:35be with SMTP id
 d2e1a72fcca58-771e1143863mr13740244b3a.13.1756257082012; 
 Tue, 26 Aug 2025 18:11:22 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:11:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 43/61] target/arm: Add read_raw_cp_reg128, write_raw_cp_reg128
Date: Wed, 27 Aug 2025 11:04:34 +1000
Message-ID: <20250827010453.4059782-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Add the functions and update raw_accessors_invalid to match.
Add assertions for !ARM_CP_128BIT in read_raw_cp_reg and
write_raw_cp_reg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h |  1 +
 target/arm/helper.c | 43 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 0d8c45b60c..bd26a4a260 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1097,6 +1097,7 @@ static inline bool cp_access_ok(int current_el,
 
 /* Raw read of a coprocessor register (as needed for migration, etc) */
 uint64_t read_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri);
+Int128 read_raw_cp_reg128(CPUARMState *env, const ARMCPRegInfo *ri);
 
 /*
  * Return true if the cp register encoding is in the "feature ID space" as
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7568b78c49..3efc14da3a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -115,6 +115,7 @@ static void *raw_ptr(CPUARMState *env, const ARMCPRegInfo *ri)
 
 uint64_t read_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri)
 {
+    assert(!(ri->type & ARM_CP_128BIT));
     /* Raw read of a coprocessor register (as needed for migration, etc). */
     if (ri->type & ARM_CP_CONST) {
         return ri->resetvalue;
@@ -130,6 +131,7 @@ uint64_t read_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri)
 static void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t v)
 {
+    assert(!(ri->type & ARM_CP_128BIT));
     /*
      * Raw write of a coprocessor register (as needed for migration, etc).
      * Note that constant registers are treated as write-ignored; the
@@ -147,6 +149,32 @@ static void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+Int128 read_raw_cp_reg128(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    assert(ri->type & ARM_CP_128BIT);
+    if (ri->raw_read128fn) {
+        return ri->raw_read128fn(env, ri);
+    } else if (ri->read128fn) {
+        return ri->read128fn(env, ri);
+    } else {
+        return raw_read128(env, ri);
+    }
+}
+
+__attribute__((unused))
+static void write_raw_cp_reg128(CPUARMState *env, const ARMCPRegInfo *ri,
+                                Int128 v)
+{
+    assert(ri->type & ARM_CP_128BIT);
+    if (ri->raw_write128fn) {
+        ri->raw_write128fn(env, ri, v);
+    } else if (ri->write128fn) {
+        ri->write128fn(env, ri, v);
+    } else {
+        raw_write128(env, ri, v);
+    }
+}
+
 static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
 {
    /*
@@ -161,12 +189,19 @@ static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
     * The tests here line up with the conditions in read/write_raw_cp_reg()
     * and assertions in raw_read()/raw_write().
     */
-    if ((ri->type & ARM_CP_CONST) ||
-        ri->fieldoffset ||
-        ((ri->raw_writefn || ri->writefn) && (ri->raw_readfn || ri->readfn))) {
+    if (ri->type & ARM_CP_CONST) {
+        return ri->type & ARM_CP_128BIT;
+    }
+    if (ri->fieldoffset) {
         return false;
     }
-    return true;
+    if (ri->type & ARM_CP_128BIT) {
+        return !((ri->raw_write128fn || ri->write128fn) &&
+                 (ri->raw_read128fn || ri->read128fn));
+    } else {
+        return !((ri->raw_writefn || ri->writefn) &&
+                 (ri->raw_readfn || ri->readfn));
+    }
 }
 
 bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
-- 
2.43.0



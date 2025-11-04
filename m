Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3CBCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 20:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGNzh-0005V3-J0; Tue, 04 Nov 2025 15:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vGNzg-0005Ue-Cu
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 15:51:08 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vGNze-0000pH-IQ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 15:51:08 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8b144ec3aa8so121749885a.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 12:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762289465; x=1762894265; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HwpoKRNQubiQXOMEiN9Sz+GbWi7OVAAuwKAREllNUqU=;
 b=L8FRl9/TUs5v9BJJpi6/+kdMlBYW0VrokYQOMbrjN7RXgjSGjRFaBI0ow8iyMkfZ98
 cdjwg8A8QLK8l6PYTRjygw4RZD6CDTTXwl/CNr56BLCAiJ8cgsT1j3gJC791Wu18qBlg
 NdA8OLHNvLTNry7IibCRGctTwp3nJRR0PuAfsF4x4knbnN63V6DA55IN0S6t+VZxtUOy
 gKU/A1ojclL1eY56ot7g5IhYyQ/QsZ6+k4Jb0rmyqNn+/yFuwlx92peoNDw4I6SOkydo
 EL89AmBPFWT1Jfxf57jaJyqMVrxhL3NIR+IHq0WbKsTpaYPOiMKq0T2N943rRAuI6YU1
 N4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762289465; x=1762894265;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HwpoKRNQubiQXOMEiN9Sz+GbWi7OVAAuwKAREllNUqU=;
 b=JoZKxenFCufRcrdzHcZ6iq/tiQfWPk9I8xTf5A4nuGO/sZF15aOv38Oj7IagcJJTwR
 AZodq+e5CYH3TdhXoi0ldHf6m2aYiOxH8YbANHwDa3MpwExZ2Hg5f2xoNMIWjIe2k87P
 WeMf5/KYPOwR/tHFfIcq1M/Mam7jM8OP8o9WiL3p4RdDoFTjTnIwgxAvL+98W6T7iok0
 5jVF6l6Sp7KMARcLs1Fxq488i1WonOGopImR+UvKNx7N9cyuhsVjhbDeVocOQirBlg8b
 uoo4iLf8LpN6U59wcLU7qfOhalAQfZy+daIiw6kQP1nyXj6m00Md6jX0FDzy9Wnd1dQ9
 cL2w==
X-Gm-Message-State: AOJu0YyWd0s05MQUdHgvrZhYLk6gnZ3oMST0C9jd2TXqbdFG6uS8FIky
 jWftnWWweFp9hRTmbJdVfNmOJMl7NMl+TtbdezVlH05XIQtR+drLSrIY
X-Gm-Gg: ASbGncvbs6mxNb9OJrGkU2/gpFK7fp07HxoBkCosd1A5U+GewjseM1B7pFj+/CLGpBV
 bmLBFQ9ZSB7myScVjR6Yw+sMQC7q1Cjfb014wOVmieRtdNXESV3cua0ZYAypceqjEIiX0Hb/d8w
 JCzEBkr4W1bkNLj3fcE59UjS0x5iP/kteSSd0qsMy+IdIivQwSCBLewPaRaEhxOqzUcD34PNF2b
 m1crOHTznOVMJ8d+JqetQFsvSU+3WI08b5NBHIUkjYiXNI7Zyy9mre+aWoki5evNaO/gDDQ8z9V
 pt6jHahhX+0tNOOXGOk+v4SdJYlroY4FST2wVpRPzWT+jbH24rVlxf99ssD9ER1SZ1a1pzFC78R
 Yk5nyppl39QxKabVg+mBvvOK3Bm+GuJw8G/4Fvq0A2xTd7MDblcwqZyOOG5vmhrFp0CdNC968uO
 jpzV1UDF2aaGgFC99K8P+xPuDl
X-Google-Smtp-Source: AGHT+IHn+L3zCfByUl/Niw82n/+LOrjv4axpM5Dow0VFCtnqR8C/XGM5sCaXxwCLvjEFo5Io/JsNLA==
X-Received: by 2002:a05:620a:4483:b0:8b1:83b:e5a6 with SMTP id
 af79cd13be357-8b220af1abamr131051185a.75.1762289464499; 
 Tue, 04 Nov 2025 12:51:04 -0800 (PST)
Received: from [10.50.205.198] ([185.213.193.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f8478b9csm263788085a.52.2025.11.04.12.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 12:51:04 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Tue, 04 Nov 2025 15:50:00 -0500
Subject: [PATCH] target/arm: add support for FEAT_MTE_TAGGED_FAR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251104-feat-mte-tagged-far-v1-1-cdfd7db40397@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPdmCmkC/x3MQQqAIBBA0avIrBtQK5CuEi2GHG0WWahEEN09a
 fkW/z9QOAsXmNQDmS8pcqQG0ylYN0qRUXwzWG1HY/SAganiXhkrxcgeA2Vcne+1JecceWjlmTn
 I/V/n5X0/koOOuGUAAAA=
X-Change-ID: 20251104-feat-mte-tagged-far-c8d302a888ad
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762289463; l=3805;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=AmAGdnlPNeY/wfLgYtaHqGABhjeGNyiiTYow65UsP1E=;
 b=dO9yd/A9m+bfodyCw8TDAnw2vCJ4XrQM7sM+qr+6wYfycD+bkLtM7tuZYw6Ns3MFz7yF04NKk
 tX9c1ENtssTD+2Dynrw3kYpAX9iwtJiZqrgAm/GB7vPlMdoanYYOXWx
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qk1-x72c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

FEAT_MTE_TAGGED_FAR is a feature required for MTE4. The feature
guarantees that the full address (including tag bits) is reported after
a SEGV_MTESERR, and advertises itself in the ID_AA64PFR2_EL1 system
register. QEMU was already reporting the full address, so this commit
simply advertises the feature by setting that register, and unsets the
register if MTE is disabled.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
This patch is the first step toward implementing ARM's Enhanced Memory
Tagging Extension (MTE4). MTE4 guarantees the presence of several
subfeatures: FEAT_MTE_CANONICAL_TAGS, FEAT_MTE_TAGGED_FAR,
FEAT_MTE_STORE_ONLY, FEAT_MTE_NO_ADDRESS_TAGS, and FEAT_MTE_PERM,
none of which are currently implemented in QEMU.

According to the ARM ARM, the presence of any of these features (except
FEAT_MTE_PERM) implies the presence of all the others. For simplicity
and ease of review, I plan to introduce them one at a time. This first
patch focuses on FEAT_MTE_TAGGED_FAR.

FEAT_MTE_TAGGED_FAR guarantees that the full fault address (including
tag bits) is reported after a SEGV_MTESERR, and exposes itself in the
ID_AA64PFR2_EL1 register. QEMU already reports the full address in this
case, so this change only advertises the feature by setting the
appropriate field in ID_AA64PFR2_EL1. The field is cleared when MTE
support is disabled or rolled back to instruction-only.

Testing:
- Verified in system mode that the MTEFAR field in ID_AA64PFR2_EL1
is set to 1 when running with mte=on and cleared with mte=off.
- Verified in user mode test that SEGV_MTESERR faults report the full
tagged address as expected.

I didn’t include these checks as formal tests since the functionality is
simple, but I can add them in follow-up versions if reviewers prefer.

Follow-up patches will implement the remaining MTE4 subfeatures listed
above.

Thanks,
Gabriel Brookman
---
 target/arm/cpu.c       | 4 +++-
 target/arm/tcg/cpu64.c | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 39292fb9bc..804e70b235 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2020,6 +2020,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          */
         if (tcg_enabled() && cpu->tag_memory == NULL) {
             FIELD_DP64_IDREG(isar, ID_AA64PFR1, MTE, 1);
+            FIELD_DP64_IDREG(isar, ID_AA64PFR2, MTEFAR, 0);
         }
 
         /*
@@ -2027,7 +2028,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * enabled on the guest (i.e mte=off), clear guest's MTE bits."
          */
         if (kvm_enabled() && !cpu->kvm_mte) {
-                FIELD_DP64_IDREG(isar, ID_AA64PFR1, MTE, 0);
+            FIELD_DP64_IDREG(isar, ID_AA64PFR1, MTE, 0);
+            FIELD_DP64_IDREG(isar, ID_AA64PFR2, MTEFAR, 0);
         }
 #endif
     }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 6871956382..27f0b43256 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1283,6 +1283,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
+    t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 1);    /* FEAT_MTE_TAGGED_FAR */
+    SET_IDREG(isar, ID_AA64PFR2, t);
+
     t = GET_IDREG(isar, ID_AA64MMFR0);
     t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */

---
base-commit: e9c692eabbbb7f395347605a6ef33a32d398ea25
change-id: 20251104-feat-mte-tagged-far-c8d302a888ad

Best regards,
-- 
Gabriel Brookman <brookmangabriel@gmail.com>



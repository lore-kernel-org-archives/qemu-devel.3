Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9376C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8l5-0002Wg-0H; Fri, 25 Sep 2026 12:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA8kz-0002UZ-Ra
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:26:41 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA8ky-0001EK-Dx
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:26:41 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc791f087e3so289701a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790353599; x=1790958399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lPu8wyqwYW7FFX+FsO6U4yGuHiLwgc+qIwPK1MjE+CQ=;
 b=lThZ1zOAfVmY6K9kgDaU4tQwoqTrmFB8pACIsL0xut23+f/AoidQZvAJvRzca4xwuL
 itOq8TK34vTLTa24PPWVWbLdayiX+fONV61j7MtIrZ8phf2+npzZjxhSFCOBAKO/oPiJ
 RYa0CTLOhxfIoK8xGwNlVtb1TDRpzYhaGgiZKpmYv+7+fKfjyikVjbCx2lK+rxxuqZ8m
 r8iCXhYszleKuv8KmJLyO3ym0MGuSheCl09LPbNJ44Rh5iCdheEQU3CWA/OIDAck0QUw
 Jb8CgK/4zLjmo66jMoya93TV2Dt+GwzOSis1K6J4vb7TCKHjd6G0IPLb7To5jbd8vrlC
 HD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790353599; x=1790958399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lPu8wyqwYW7FFX+FsO6U4yGuHiLwgc+qIwPK1MjE+CQ=;
 b=nKzajJjtByeEYo8hrRZMYdgaQQFqqVE88QYetQiPsVxaDMdPOgkR9k67t8zJNEK9mS
 djqfZUzQFIWeyECmd9dmnspZkSWSVWkvA/o9Tmeb0NGrYbfVpvuYQIBJ9/CSSgW0f3eX
 XW7qMeNXXfr8ertboA2bJ1NA7FPHMZ/QDRlhSBON071FWSgkB9aRVT07DFJq/397QotJ
 yRZ1W/q4dP+dUBN+UwMzrMQp0o3iOX1jvsQ7zoWPxdGQcc9tHej5+uG3CRVqutqNNLlC
 B3cTel9JRJJMGEDhGPgodU+tMKJeS3UR9gjm3ZFdQGG0lgTOf7y8qrJsDy+TjDuowqYo
 au8Q==
X-Gm-Message-State: AFuF++kye7rReGe/0w9BMfu4nDXT9gSiY9Qj8QRmqV2XVGJ7whvrXmy4
 PJkog6nEdFFJHFFSdRTj51276GimadyipdUIa5kCyowgcc6P0quQChrU6vz6PbaXUWZ/jFRZtRM
 OSYKB
X-Gm-Gg: AYBFou0pI5SOEDhTGj5ED3DALw1imKGe5jKCLieuTVkEKAAgxfLiSj8C5hyjBcdcMEA
 tcIkEghPPQ2UW6X4/vqcxNBn1My6KdAPAS7tHi+U7Vx6hmBm43j+PDKEe3IMB41jhAQQnf0+IEn
 w0An1xoeTBqwhp+ReocjV1X6bUmnyW143qwDdhBRwYZ2H06P4AtQeC8KxYDD9fvuKv+YExMp9BM
 p1mV7pms9kkuN9IhEC2ub4k2limZTxqPq1mUltf/anzQ1ZzbofHOImuslQX+6myllPAcDjoQjes
 f7OOi8r5afXdnAVXSSn4ruHGkiChHXQEKjZBVs9cXh9VUcf7uHugGK+byEYOmVqgEGoTmf+xAR8
 NLg9uJKK7/Hx4+nrvDY4n6KpZKtdmK29bX6iDw1ePwuxRshNrdX+WIApeuvDPvek3hyXNZnIU4B
 Hkiq+X6Rqz7iZn+B+N4CBn1Hke5YevWth5yeH/0oZQdy2qbLdfDJxVh+yXahNIkCVQVsqmjGQYT
 1tl7J88D3UU+S5/cT7Lgu0MSXZHhMM5O3UClB3lFQ==
X-Received: by 2002:a17:90b:4c11:b0:39e:35a0:9c0f with SMTP id
 98e67ed59e1d1-3a0986eb49cmr5782434a91.14.1790353597926; 
 Fri, 25 Sep 2026 09:26:37 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0976cacbesm11464809a91.13.2026.09.25.09.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 09:26:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 5/5] target/arm: Enable FEAT_IDTE3 for -cpu max
Date: Fri, 25 Sep 2026 09:26:32 -0700
Message-ID: <20260925162632.404001-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925162632.404001-1-richard.henderson@linaro.org>
References: <20260925162632.404001-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 34b63f9867f..bbdb5d8244d 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -105,6 +105,7 @@ the following architecture extensions:
 - FEAT_HPMN0 (Setting of MDCR_EL2.HPMN to zero)
 - FEAT_I8MM (AArch64 Int8 matrix multiplication instructions)
 - FEAT_IDST (ID space trap handling)
+- FEAT_IDTE3 (Trapping ID register accesses to EL3)
 - FEAT_IESB (Implicit error synchronization event)
 - FEAT_IVIPT (The IVIPT Extension)
 - FEAT_JSCVT (JavaScript conversion instructions)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index affd87a3ae5..321f78a74af 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1460,6 +1460,10 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* v9.2: FEAT_FPMR */
     SET_IDREG(isar, ID_AA64PFR2, t);
 
+    t = GET_IDREG(isar, ID_AA64MMFR2);
+    t = FIELD_DP64(t, ID_AA64MMFR2, IDS, 2);      /* v9.0: FEAT_IDTE3 */
+    SET_IDREG(isar, ID_AA64MMFR2, t);
+
     t = GET_IDREG(isar, ID_AA64MMFR3);
     t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);      /* v9.2: FEAT_MEC */
     SET_IDREG(isar, ID_AA64MMFR3, t);
-- 
2.53.0



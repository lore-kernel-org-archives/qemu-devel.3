Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDD9C531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn6F3-0003mr-1H; Thu, 23 Jul 2026 23:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Ez-0003kR-Cx
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:06:25 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Ex-00085V-TR
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:06:25 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so1387960a91.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 20:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784862382; x=1785467182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vZ3wJDJYBL3Ih5BppqGHeGHu7Wqrcj0x1UTiHapnNLU=;
 b=CIZoLbS+7WnxJkQ5tEOLmRvCDEbceyn1YyuG+OGlH79ZaGeWlKMo+aO7diXvQFJr+W
 g7ALZ/EpfIgrBo2hr59NFYCs9YAoIWu1cmr6syCRcPE8mVHNkq8pIlpdGy+2kgqp5oAJ
 vZPXXm2sbjXjVg2qrQpja/noqii/MdcjOdc9jPTPacBPAWvt1Tn043BpXUMuKiFzfLME
 uoCfNkndrV6DvGfC2uG+agK0LarXcKiAerNnnKvJ3HnYLBNSgvXjTsH/PX1jTNzePlQp
 AF0S9Bhq/9MGGOgdI9vjsiJTUsWIhye2YnvNzcbn/uRKd1WTB18hHKu8Z0io3xJ695BE
 g0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784862382; x=1785467182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vZ3wJDJYBL3Ih5BppqGHeGHu7Wqrcj0x1UTiHapnNLU=;
 b=Q1/goeZsH3bxPvO/7xZrA7Xvqe3/yU6LCnVMxlZiit1+mCTp/kFneIDl1ljm6l1Zi2
 M4QgBXwlJTAnMm+Lm2Pn1YFhhCforfq+eajPsbOhbLXgmO+XYSrQjuBfAvsVQT0qcbCb
 8tunmOxGOkKoeNq1uFZD05iacYKN9eG4/CGuz+yfX9BW3MstrZRw82Vxp2IupUKp3K0Z
 dJsyQXiay3C42KPS2xUpxPdM+1npOxnAMISGs1/LusLlxBr1lboGGS+uugQVFso619Vk
 oVNZUndfQP7oL2+q9BwNxxpGbSFqhV3CGctdmHZqnClIpKZH9gsZyN9p9dJRVd5WmYgO
 GIEA==
X-Gm-Message-State: AOJu0YztLFgmYw08N1jlTJoXxBd1AEL9NZpdDH/DeUzepmDQBXQwIusc
 o0VbHfFi+Bpcb7DEOspP2vJMtPxYRUdXRIwBvvTt6gbYQ4f95U8Eta4Tn86XGtKulOYpnxJj0YT
 xckEi
X-Gm-Gg: AR+sD10NOtvt8vgbBX+TZcf5T1Z/xhYI4HqLugqgh7dhlNjyug75MGHFTHzAAal5lmb
 Npvfnmj7cJs75s9Zt7z4T3iITrASFz7A5D+EAzrIMrJKbpR8W4nJ8AAXlcZwizR7XGMm7iw8YTm
 PR2TfQLwEBy8Dw+K7HKeDkUt1YWYieQ72rjaRFuq8NmBd/s2Aj2Hfqgsnm4u/yNDTPNrwBY6qZd
 yQC6vmxglitcXEO7GJy4H8zzEL1Yl8zwB6VuDVLHYaRRnlHwIRgLiLUx5uZS9EbuzHEpHPtxQOJ
 nYFXXMuF7/XcPi4HZm6VAB0xkic3DWclhBPbxOdwUe8zJeoxprMVcbQKST1H3+f8e3y+D2YR/rD
 2r4vVJTPY8pP65RQYCoqHA4lzL0unJq1xgDIVVDHlGw2tmgkxSbEZXOuc8P/2SbMiXsB8c1sxZ5
 pmVxWCFAR7He/g2A3JVa+ZrrRCWGOeYehvdg==
X-Received: by 2002:a17:90b:4ad1:b0:38e:11ba:992e with SMTP id
 98e67ed59e1d1-38ec663d91emr5507518a91.35.1784862382578; 
 Thu, 23 Jul 2026 20:06:22 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f03ad0e0csm750777a91.7.2026.07.23.20.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 20:06:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 6/6] target/arm: Enable FEAT_FGWTE3 for -cpu max
Date: Thu, 23 Jul 2026 20:06:16 -0700
Message-ID: <20260724030616.76180-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724030616.76180-1-richard.henderson@linaro.org>
References: <20260724030616.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8a3ebf6321..a0d8d0bac8 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1362,6 +1362,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = GET_IDREG(isar, ID_AA64MMFR4);
     t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* FEAT_ASID2 */
+    t = FIELD_DP64(t, ID_AA64MMFR4, FGWTE3, 1);   /* FEAT_FGWTE3 */
     SET_IDREG(isar, ID_AA64MMFR4, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 9930974a50..9528afbb18 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -78,6 +78,7 @@ the following architecture extensions:
 - FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
 - FEAT_FCMA (Floating-point complex number instructions)
 - FEAT_FGT (Fine-Grained Traps)
+- FEAT_FGWTE3 (Fine-Grained Write Trap EL3)
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
-- 
2.43.0



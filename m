Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01A2CA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4hH-0000Zu-FR; Tue, 26 Aug 2025 21:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hC-0000Lr-ER
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:27 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4h1-0008V7-G1
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:24 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7718408baf7so3195370b3a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257072; x=1756861872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWXxySCaWO9RB9p0qC7RXW2uKnf/vMpCtWd3L9+6QNU=;
 b=VzYiffNBM6Bd1kJHNOrnWuXi650dX8UfhLr5trDIJ1DtDBIQjlSWOU1Tw9xzxVXAJE
 j+fD2bytxiqspX1DDdJ86xQrH4X++KDs/vVHqf5kUyDb4xTHjzo9DDfrZQMTO6JprajL
 x8x44rZUXqMcGz+l54q0M+rHTRRvriWwgkXYihJBr8jlO71abhC3jVpTPwMAilBJ25AA
 OzzFsfxVBWwxT0RY3PXdEylS+y0dTwC/xmPfGdu8nBFFPSmyJ76uEsErNLLKffapjspw
 K1w5oNcKXO4SvlZ8ZML7i3hgEnHyAmwPiI16M4k99HWtNX8RAZXKiUoXj588wn4UXxa1
 vtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257072; x=1756861872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWXxySCaWO9RB9p0qC7RXW2uKnf/vMpCtWd3L9+6QNU=;
 b=TxLY6l3ekpibUvFHU3xokvTZwPw1ALeVQ8jy/HWzgvV7RSSun0sXZPBKhVIXSWQsJu
 UnigZ5O23HJCMlyxVSH3nl6pUqshVCb9itlIfLkixK668mRJaHzVt6H9g61Jq1sVJYq3
 N7mK45sOPr083IBemkrYg1YKG97IDK+ks4HH+JL35qmLy5e2hv5IuAuXLflm4f6xnXhH
 TD4qepgXN5JGjCaUs1uYeFwzONNwl8HpfmMUGq4i8wHTfQE6wPxkv0Fih5ild3XkUU3y
 LbdsjU1hLyXTMHmPz8LRukUL5QWydZ/U7/6kdyKE2aara1eo4+8BHO0z/4dcJTGS5tAd
 F5Tw==
X-Gm-Message-State: AOJu0Yxud7ZCV+MYIFU6I2QyRZ+/2sDS6gTQNjQ+WSVdtLbIu07nIeRj
 eFGB+8KnX4V/vzKTZBrk5k5b490a9TEWQLVrF9I+4BYAJHzpHNeDzPxUVZXMSyymoEMH4mMrlcx
 iSOyvw44=
X-Gm-Gg: ASbGncsJGz5E7qXXp6PG/nO6v9itkL6KoUlLx0P4BNpOgJeUpP4kXmbuN+hYHdrQ2H1
 u4A39Ohh4LaK8VuVYY+qG07JRcL7ca+6rR6Qp7fuL5kGAfeoi4SalAGBfDOoxlwKGrjb9fya6Dk
 gc4AmMhMtJXKGyP+Hor0Wf/gRbiEpLXZPwDiGzS7L71PeZvgXMDrOyDEMNufqbVoTcRxpqqUEQx
 xrN2//ZkLrwBID6VWepVpj4HBkt4Az9hNqbyuAkjO8WF0y9a9FZiaR9Vcb/n9WB6gFvJWpyP68t
 zmaUB6um1UB8v1670GuCbl56PW9/UfcukTcD7/xMvlS3dliSeJzMRojBXUdfUbSbTdwtq1LEFiJ
 uBtVBlmeKTonwlnmpmoqggZ1Lng==
X-Google-Smtp-Source: AGHT+IHQAmWka4Z+TG8sCOr9qVs6iCryeuT9nZUqKusycp7HdUuh6pWWx9EJIsukT22hOukl7Qis7A==
X-Received: by 2002:a05:6a00:759a:b0:771:fdd9:efa0 with SMTP id
 d2e1a72fcca58-771fdd9fa11mr3668764b3a.15.1756257072293; 
 Tue, 26 Aug 2025 18:11:12 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:11:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 40/61] target/arm: Assert ARM_CP_128BIT only with
 ARM_CP_STATE_AA64
Date: Wed, 27 Aug 2025 11:04:31 +1000
Message-ID: <20250827010453.4059782-45-richard.henderson@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 64a987d143..3b765408f2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7353,6 +7353,11 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
     assert(r->state == ARM_CP_STATE_AA32 || !(r->type & ARM_CP_64BIT));
     /* AArch32 64-bit registers have only CRm and Opc1 fields. */
     assert(!(r->type & ARM_CP_64BIT) || !(r->opc2 || r->crn));
+    /*
+     * Only AArch64 regs are 128-bit.  There is usually an AArch32 64-bit
+     * alias, but must be defined separately due to encoding conflicts above.
+     */
+    assert(r->state == ARM_CP_STATE_AA64 || !(r->type & ARM_CP_128BIT));
     /* op0 only exists in the AArch64 encodings */
     assert(r->state != ARM_CP_STATE_AA32 || r->opc0 == 0);
 
-- 
2.43.0



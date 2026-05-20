Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CE7CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlcx-00054a-Gc; Wed, 20 May 2026 14:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlc5-0003xt-95
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:25:49 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlc3-0001zQ-11
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:25:48 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2bd2051167eso23711235ad.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301545; x=1779906345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xM35gHOjOqj4uCcYch+AkhQTaXi12XhXc0hhEraB8uM=;
 b=d1V8G92j/yFV4C4e6dZmPZYLoRNKePc8Tbp5KTm6KMUVVSYALVyTOt2cbubCrg1cco
 6Z/jk/SDSIa93x9l6TQf0XQ5oB4UUp6v1MXIDgCVn+r8i8S8rbMIucIcp5eONWFbrhjw
 HK5v8iea+GbtYLoQpt3rsx/7yV8XrAyMDlNiBTr2xmLi1BULfDE1IXMyst65L6HJLZ/m
 4WITgFmPxF9EU6c/ER14/Jzs2m27NjpVHSFW7j/D0V5LBPNyQI+DorNxnzDO6u3A7EPh
 MjViyN8R3u0mevarWAUo8K9LPcYhQ53JRaf9gi3ZioaThlDDEsPGhH8kTJXAm0lkSRbw
 nn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301545; x=1779906345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xM35gHOjOqj4uCcYch+AkhQTaXi12XhXc0hhEraB8uM=;
 b=CnqMbM26PqH6GNIslemkbmtwhLB8n9Sh0N9ypyD27Eh9PhD//U6ge3E2ly3XIOEj8A
 tyzNJ84bPsA/NG/+Xkg9YnbmHuwjDRvZ2gcCmfxyKbkkdEegYCy9AciOqg5OsPwW2Okd
 kPIRe48Y/Q2HTPVtebtEPoGYWkvlPatyT0jN7Xd+InY6rYQogklCKk1pn+zR/eiDK+nB
 odLtJjmbO7IvNLRxopIti01oLG1ZoBA+rmttgSsE4V4rXpJ7kXGHbgqAmwPefz7LkmJW
 ea1wr0+H4xswp/h4H+hNK/7t91LtmK9fHYJJchIdPwG/pXfPpYTeb0OcJo2t1xaohTdM
 nBDg==
X-Gm-Message-State: AOJu0Yz25Kb23iCdZCzSyAo8k8Ef2JE0PN7lltiH4zx/uwMTe+najGXV
 AejdeiwNmmjS2cmnoSbN7/cH4TlikMsoPsc2GKhnoeyM5tdwm4MADSAH+oZLJZ4GYkvtBQb9Rdq
 Lvm/l+0I=
X-Gm-Gg: Acq92OHQn0ByUFW/Sv11jgS51TUIxue/Wt4SOLy7DSU2nn0gri/ASnYO2aHViw280gw
 jIBuF6w676xUUArRkfeOBqWe4TO+TRQDma24oN/4NhmNW7TQ4af9pj9FNl2RY6Z92sny3CaRhgf
 ecIS8Y7kIa9HFIgeR9bBFUdUHGZUtpvzKO0YsxY8pA25n116rov5DCjQeseIruNdaxm8/pvkH4l
 F89XEinsb+Z8dVqzOKSkUdqBFzWzwa263/D53Lm99TVZthZI0YHtjlYbpUBZ3O2c81CIvokiE2u
 Wk84hccfuhg4KaUyg62u17/7W1HevqhfZa9cmBpDJEvaEWpmx37elGBNKKwkLUC4N8/CcLi+NRE
 EMdi9/TR6+nHtX4iq3l5F7LnPGFN/FLH/R9hlOA2PWZTD1P4EgFZFU23wRFSFslmjnZylrKiiRo
 5MYF0qX9YMlKrKJIrLIGBrnYTbTaD3
X-Received: by 2002:a17:903:46c6:b0:2bc:c089:ff10 with SMTP id
 d9443c01a7336-2bd7e9a55e9mr256548265ad.34.1779301545361; 
 Wed, 20 May 2026 11:25:45 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:25:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 42/64] target/arm: Update ID_AA64SMFR0_EL1 fields to ARM M.b
Date: Wed, 20 May 2026 11:21:51 -0700
Message-ID: <20260520182213.872945-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 6d5994450f..811f2a7291 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -397,17 +397,28 @@ FIELD(ID_AA64ZFR0, F16MM, 48, 4)
 FIELD(ID_AA64ZFR0, F32MM, 52, 4)
 FIELD(ID_AA64ZFR0, F64MM, 56, 4)
 
+FIELD(ID_AA64SMFR0, SMOP4, 0, 1)
+FIELD(ID_AA64SMFR0, STMOP, 16, 1)
+FIELD(ID_AA64SMFR0, SFEXPA, 23, 1)
+FIELD(ID_AA64SMFR0, AES, 24, 1)
+FIELD(ID_AA64SMFR0, SBITPERM, 25, 1)
+FIELD(ID_AA64SMFR0, SF8DP2, 28, 1)
+FIELD(ID_AA64SMFR0, SF8DP4, 29, 1)
+FIELD(ID_AA64SMFR0, SF8FMA, 30, 1)
 FIELD(ID_AA64SMFR0, F32F32, 32, 1)
 FIELD(ID_AA64SMFR0, BI32I32, 33, 1)
 FIELD(ID_AA64SMFR0, B16F32, 34, 1)
 FIELD(ID_AA64SMFR0, F16F32, 35, 1)
 FIELD(ID_AA64SMFR0, I8I32, 36, 4)
+FIELD(ID_AA64SMFR0, F8F32, 40, 1)
+FIELD(ID_AA64SMFR0, F8F16, 41, 1)
 FIELD(ID_AA64SMFR0, F16F16, 42, 1)
 FIELD(ID_AA64SMFR0, B16B16, 43, 1)
 FIELD(ID_AA64SMFR0, I16I32, 44, 4)
 FIELD(ID_AA64SMFR0, F64F64, 48, 1)
 FIELD(ID_AA64SMFR0, I16I64, 52, 4)
 FIELD(ID_AA64SMFR0, SMEVER, 56, 4)
+FIELD(ID_AA64SMFR0, LUTv2, 60, 1)
 FIELD(ID_AA64SMFR0, FA64, 63, 1)
 
 FIELD(ID_AA64FPFR0, F8E5M2, 0, 1)
-- 
2.43.0



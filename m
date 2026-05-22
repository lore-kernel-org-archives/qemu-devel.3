Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E6BCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXy3-0007l7-3s; Fri, 22 May 2026 18:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxe-0007fX-90
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:18 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxc-0007lf-6Y
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:17 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-36a35e4eefeso1935203a91.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487395; x=1780092195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vt3sSjY1I9K5JlXMwxo57mQwm/lZo1Hult3fBAaDzUE=;
 b=YyYGq2SkU9u6RbUsvM+ObAWUJWncyqLJME5J484trp1nnc/OTiyQqwv+nPRtd9FcKq
 esUBGuSrs5ccHXh7FtaIoUgqsi+hCpyWdZ56+CJr7SE4F3j8AgvVHKqXQ8Zv+iMiI57N
 Quku55EPQVYJ/j44SoYtr1K8AzPOVku6vZiI2RicCbl1svp1/oPoGjJ3Sau7xs+qmE0Y
 eC1WR/Xvkzzf9GlsA1wifebIGGgOWlby8QDrP9yL90YI2l2cKjD1PVeR7fQUAAX15DyK
 xblzH57RUA6bzlaEmdJPSr7ZjDnSUQIhklIkrDxa/wyE8jiVQ90670MmD1OrZh+xgrJC
 oBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487395; x=1780092195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vt3sSjY1I9K5JlXMwxo57mQwm/lZo1Hult3fBAaDzUE=;
 b=ozaWsBuX6gDbbX6YkmGK8EkxPvVdMuufafrxZa7776Y/Yev6aXFCncXH+eaTCd2Av7
 t3MjT4OvOub3w+Ycchx5zZThD5Zxv+i9Uk5pHW3tUk3dzZ2WUAo6axl2yR3RLWeRSbeN
 K0bIcMyMfeDUBAfA9VePL6p9Pmbck3wxfJ2MrkRa988QjugGpvSCVRDnuYVE50B+O4Kn
 XXVrQCuwGcqB5Jqnt7aI88h8c/zMguXuve0ij5xDAbeNKA+19j5bGSsGTNvedntq2d1a
 mrUrWRM6y3EYoW/byLJID/Fs0bWrXCfNIPt0aqq+5d7g9SzAWPCr6yeURF82VhUUZ3Jh
 y/Yg==
X-Gm-Message-State: AOJu0YxUHo3ItJ2MgaA7pfdESsV09ujw8w0ZjB9sPlPWQOtx/099hyHw
 Z7NjjVHf/KGzTkQGRuoHHPoW06rANAtdbYxUIiEr+e/hf2hhzV6Zz36NYjeAkvF29p85ZPLJr1Y
 nUAry
X-Gm-Gg: Acq92OH9kj/wL3M+JkONFU4vPoUoQLSU36kDbe3wFAkFuJWN66gGgOmKIdBD0mTty7R
 EEHo3iuShPmamMflC0wqPK2qKltg5U2fyFty8mzA5EYxbiEOak05H+CKPF1JIIQmFnKvemQczvo
 xgBmAnCY1Ym2sKgUzT4W/F1RQ+QMDJ9/yfEYtRh7N0uoBoUQfzFkOYd7K76JFz5IckWM4/uAWER
 Q5xtDgD1fYJOTnRcqfeqjOU9lsbO1uGIj5HYthTEbeZimdDqLs0yqfYxyfrUQPckRD9QA4XEouv
 gR/GDWfeFRPIxaOgCFE3j/rMvxd+BdbhaAMW+NDnbsujtX4e9jiUDnifVehPZLF0uLchJ1HuIXA
 g96kuC+51ZzWb5Ry+5scJ8TZGue3xBfT5ibO2Gx7j9HLskMvj/aQMQ503CzuOjkeCIml2ZsMXzO
 bXWAtbGDLn81SZeHUml+QWj1FycAywXNnIjL550fY=
X-Received: by 2002:a17:90b:5687:b0:36a:31c2:d402 with SMTP id
 98e67ed59e1d1-36a67471bf6mr5657973a91.10.1779487394750; 
 Fri, 22 May 2026 15:03:14 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 07/64] target/arm: Update HCRX bits for Arm ARM M.a.a
Date: Fri, 22 May 2026 15:02:09 -0700
Message-ID: <20260522220306.235200-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 00830b1724..27ff94565e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -258,6 +258,9 @@ FIELD(VSTCR, SA, 30, 1)
 #define HCRX_TCR2EN   (1ULL << 14)
 #define HCRX_SCTLR2EN (1ULL << 15)
 #define HCRX_GCSEN    (1ULL << 22)
+#define HCRX_ENFPM    (1ULL << 23)
+#define HCRX_PACMEN   (1ULL << 24)
+#define HCRX_SRMASKEN (1ULL << 26)
 
 #define HPFAR_NS      (1ULL << 63)
 
-- 
2.43.0



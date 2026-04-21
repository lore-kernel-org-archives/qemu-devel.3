Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666D6EA71A4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3SY-0000Li-Ku; Tue, 21 Apr 2026 01:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RS-00081H-Og
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:41 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RP-0006TR-9h
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:32 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2addb31945aso24955035ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748470; x=1777353270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGh/j5N9mcyZy1AmwrVJTGg59tA16h2SHgyGHktIv1c=;
 b=y1adviKkcwKtNooZIvMu1+WM32f8BK3moMKECglwQVeSCMG7fJdi6QX52pBX0Rz1TU
 8zFUQ2lJxdxm+4lJbsyxwGxtcv7E+EBkDFfgIsWw2ATnsERRFJhwkkt5vwN0n2iutCnz
 MoI2rwTgvfM/QssbV8UPMrXmHjKIUDTdWNvxTF8fUrWAIYbQXlgfZ35Ox8dLlRsRtCVZ
 tT346/7A9ydBwK/5HqOa/1SnOYJ8KmuGkwyvWQRKCIqO315aAURlR+F+5L4TkIO6gACZ
 nJ8j/JQw6bJO8bPu32gdCA7lkLvmyzy3YMIXuTNLpUqp+nyZaxy4od99u9ePGWUfCIUO
 9UGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748470; x=1777353270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QGh/j5N9mcyZy1AmwrVJTGg59tA16h2SHgyGHktIv1c=;
 b=HyKJioM2fJ2NLd/e3QPJldmnoDEuC0TcbzFRTSNiXmD7GmNh23cMPa4GRmK2gH3y1Q
 qQM6YoUH9836vU3Sq2xICBYT/mY7voenTX7G1P4iWp995Ueadlo5d8IOKZ8KipD9Z9N0
 IEdUdtDoEonKcJg8SXc5HWMR+1XY34Yzz6wII7TiYp3dc2lZMk6CkpZHOrpNzkffVtGD
 qAbkckVz9l6NNLTSqx0udtM8pDBZYzxBc+FVXf8AYfxJivCdXtpJ979pQi9TVe8O/sjf
 0dcfOh6hNEyCMh6uyVTdf1y19TqBcQhAIVIX8FTlMvf09WOCHIpYT0PoxBcq+agXnUO1
 6GLg==
X-Gm-Message-State: AOJu0YwSKLWkALz0C6TvtF8SY7TUU9WgZNwRUVQPhb9sxStjkcaIL5Vr
 VmALEFanECvz2WjEfOol5YwKWt5nFfsoM0KtRuIzP4mGDpGvJervUJoBmrrfsUI8gHcIGqUPK2j
 zWFI4o9c=
X-Gm-Gg: AeBDieucVYUbWqBz/nUsGIbZRoTDPE6mqsXIstYpDinp4p4A9dfctPW57wFEtPqAS3D
 /WaobB42H0W4hZ97fwCAvZBMrVaWwxDHgHqkiBUkxBwddikirNMcizks8aTGdeFYG1xKxbaRgx+
 TQ6nAdqAlsRa/CNpAjjUYSx9JND1rX8uAypdxA8kW6UMcgvJufTfcG2e1noYz78LWudZpPIRl0R
 ImhXlgo7bS4rqO4g9w7DeHsKnVJG1/oYaHc8meawccStEHLKkwmfOpq/LTw9+FZP6cVGSU6SxCN
 HqzzqOqV0UPAQZBYyBwtOKS1iYrFd+vUxoxh35X5CWSL46hd37WNE6ZzIYbfFnygEiXwXz9mHkl
 IW4jwxFUjE+3EU3zJnsSXWVgGXdaXGn9CdpP4fClzEgyRmjNmtq3qNtnxa2nDkNJttlgfrkTmON
 kZQAQJr8m1kP2p23wJ7qqpw9VnK4tPrOQGFSmc5gjy
X-Received: by 2002:a17:903:120d:b0:2b2:489a:f46a with SMTP id
 d9443c01a7336-2b5f9fbc5a1mr187056175ad.36.1776748469869; 
 Mon, 20 Apr 2026 22:14:29 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 16/37] target/arm: Add isar_feature_aa64_f8cvt
Date: Tue, 21 Apr 2026 15:13:25 +1000
Message-ID: <20260421051346.41106-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index df070afdbf..87d16b57dd 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1550,6 +1550,11 @@ static inline bool isar_feature_aa64_sme2p1(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMEVER) >= 2;
 }
 
+static inline bool isar_feature_aa64_f8cvt(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8CVT);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
-- 
2.43.0



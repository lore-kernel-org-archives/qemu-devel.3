Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AA5FF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuA-00040C-Ln; Fri, 01 May 2026 06:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIktw-0003w4-Kt
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:16 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIktu-0008IZ-V1
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so10168065e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630513; x=1778235313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xl4HhnyBXMIn8KYzROgjNlZ37AqhnUlhFOr63vQnvhM=;
 b=ex2WuxsvGWEbFkEDizvuTZgCD6wi6L/RzWE/PAeNwMIPTBO6vOxMigy0xASy6R8uh2
 +CrfGGO4lddKZTZI4hpitTa+YclG0wfSW43BdKmlKIfqdi9IOM/LS7k6huGwt1f4qayE
 mp/Gh9v8TizcLc2ixlzaQ4wK7B9wwLbBYhmAZr94u75V5s6RJ6s1xalYZ3c4oAjyNYWg
 PEqTriZNxg4QBPHCdkonxUFtOF00+P1xxS7Y+1sTNrcrqNh5zM8FAJZeiphO6+BaCkpA
 QzV+d0LShcZVeLMJamAc8rpjpNEn7eaWZ0XoQniF7oPKQXTJSKm/ydQsI2P327XBJYKv
 E72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630513; x=1778235313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xl4HhnyBXMIn8KYzROgjNlZ37AqhnUlhFOr63vQnvhM=;
 b=SO+iUbYBZkV3JNxMJL12spsMm4e7uScQdZHNEnptu3FdhgmA3lZixbUA34y4tvlcu6
 tc3T727rqIh4c4W+zBm9RcmTXAIW768RFN3rDwNVfFTNhXApFf09gbYy4fFS4Y16OdQf
 XSDjzTviNzWGJs2rYGjNU7URKOps/ielTGciYnYJLyvPcNLX7hywTh2/rVAeHEWWT5nJ
 dzrmQx47AbZIGSqqvlN5wRNx7UG2GNpmgKgRD3+7zyoNxjwM8/C4Ar3YiP3nfto9eYr1
 xnzdesFdHqNwfH262ynj9s4YFWBYLONUALiHWgws9Ex8LUO7HTAm92hknntueBrF3Sk2
 Py2A==
X-Gm-Message-State: AOJu0YxE/86h7aYyKJu89pLP91c+GscwnPLBBknqe6fmMWyf3XSJgqL7
 oSkbk4I0F1ljN6+e4Gi/uK4nI85ORUFsQIcF+PcTbAdKUEjuMSA3xqx7642t5RPxKRbxTlMskAc
 TDoCy
X-Gm-Gg: AeBDievS0rRl55SyzOygV9n8FAZFy/MRDqjSXcV1BbO4v+q0NBqmIjrmIDFV0ldZ7WD
 wvbHtx/oR1Ynj0GVU1zPBB+SaVtX9jW5vIdpRmuLoTbGU2gNhK120b3OM4HuydJ5arSH6ViVRKM
 z7ZDvoaPTI0Uw31+eU8FeZdOe5DeM61SXREl6yz172wY8YpeNtvUELbaR9h024RH67/vJSQ/k9I
 d6oy9t0hBFp+S0HS2hPLBMTfLqz5B2b9w1uUcpHOCmju6KBwZS54tnyUSfX+gW5hv09V6LZzvcc
 UUQlw4MpALjorvzwiRCHohObghOQEcrAFldBDCrPMgLUtSg7OLhsiEhUTxXNt6atIZty/ESmo/H
 ewEcpR9Qc/qqV9jBW+G+fa+2xmyUF6QIUeR9yLAcgH+49UmAzi7xMemqdJQMcL4qsEQBVNG+f4W
 SYiV2vNGzZmdjuD8QKVM9JT2TFoyTVn1e9hy4rQI6ck9q/phqpV3ZevBDwVt76n4CvN0GIEM/G/
 NovRH0yMSM8ni+Pg4L4fMA14Ra7XRiSxSLkT+N0LQ==
X-Received: by 2002:a05:600c:1f8e:b0:488:a824:fe04 with SMTP id
 5b1f17b1804b1-48a8447f466mr101081045e9.26.1777630513445; 
 Fri, 01 May 2026 03:15:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/28] target/arm/cpu-features.c: New fields in AA64MMFR4
Date: Fri,  1 May 2026 11:14:43 +0100
Message-ID: <20260501101505.3485916-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

Added RMEGDI for FEAT_RME_GDI and other new fields.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20260421-jmac-feat_rme_gdi-v3-1-ecd20c77eae1@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 6e5212ff6c..88fe3ed287 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -346,8 +346,16 @@ FIELD(ID_AA64MMFR3, SDERR, 52, 4)
 FIELD(ID_AA64MMFR3, ADERR, 56, 4)
 FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
 
+FIELD(ID_AA64MMFR4, POPS, 0, 4)
+FIELD(ID_AA64MMFR4, EIESB, 4, 4)
 FIELD(ID_AA64MMFR4, ASID2, 8, 4)
+FIELD(ID_AA64MMFR4, HACDBS, 12, 4)
+FIELD(ID_AA64MMFR4, FGWTE3, 16, 4)
+FIELD(ID_AA64MMFR4, NV_FRAC, 20, 4)
 FIELD(ID_AA64MMFR4, E2H0, 24, 4)
+FIELD(ID_AA64MMFR4, RMEGDI, 28, 4)
+FIELD(ID_AA64MMFR4, E3DSE, 36, 4)
+FIELD(ID_AA64MMFR4, SRMASK, 44, 4)
 
 FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
-- 
2.43.0



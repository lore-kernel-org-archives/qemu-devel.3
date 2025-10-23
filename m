Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8992CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwjb-0004mn-9J; Thu, 23 Oct 2025 10:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjZ-0004m1-Fb
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:09 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjX-0005ZC-Bm
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:08 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so709091f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231366; x=1761836166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D/n5Wp8YRV/gi/aKQBN6YUMRxTi78RRfNPiFT0L5SNQ=;
 b=KzikC3mJ5dY+NUdLXXWea7EiK8bAgjv1TngJjop86X8hm3DJ7klTaJIOULYBA3w4a0
 h52967/IjOVzpIsxacjf+mhJxLVBeOXCeH3k+O2FmapF5YKM7K8w7cDKxxRnDXbiUjSc
 qVOw1pmWdactJgOT0c2GQqCbzl1TBiUkxduI+NJHVRsH1vxOSFlZm/jsAwbUmTVo7Jfd
 tK0EaBrOdfA5hzfsIwz+DgAh+o1Yv2NxNtFDymdhMJfewfh9GKfFV0A7W3d3ElBharK3
 zLdTk/2bklWemACEGyUPC9Hcwb/v5z2BhvdUJJ5ZBf1FmhDiyDzhQDqa9IWjsZflCNZh
 Z/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231366; x=1761836166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/n5Wp8YRV/gi/aKQBN6YUMRxTi78RRfNPiFT0L5SNQ=;
 b=opv7wqXSaC1QEUyVunmmRwWR5pRD+70xF57qOJg+Hiwu8ML4/71lHv0iKHJ37dsbJ7
 eHiKPV/POoVln/+3N/JhZvi1T+sI7Zmw2k0aul4JMMkA+W2E4BNDPLMh3U5GojSkdBY2
 I41dVe/ln7khRdavVKj5W0mKY2SiYAdyUTQc9A5nQcQyrQSOahFxz1HobE7uPRM+Wnl+
 SFhVnFcTOMOpRR1PR3Nk/SRmOlMdVric/I5aOe6/S2WhLOwK7gP77j2aiwBr+HmI62yg
 TmC+FpnTbtLwIFSPs8XywUDLCEMIV5v1+j74deqYkzwLqLse6tDVPDHMGIdXOUf/8nOu
 IhDw==
X-Gm-Message-State: AOJu0YzIf78+I+RGdq4s7/2OF85zcp8GBADjEzkAq9slUyoRbIY0twoZ
 DUtlHau0US54VYqMjF9zeQzqstuplXuWNJONuUB/RKV0h4n4XbsJUkr4TuXsAMWzOEGbpJuWW2R
 a5VaS
X-Gm-Gg: ASbGnct9Kww2cyedpRxlmPrPrZgQp6nu9Lu3Mrylfzm9xvdUq8ZPMW5DpWPS6rWCN2t
 6MN8DMR03ttp14xpTboLXvN7HQOTJf/FyKp1yGXRit9475rn9tcUMt+PTQkzW9frR/63qI9wYHd
 TtXzBW8rsPAaSx9ffb5/oFOJclJzSiGnnjIgYWECwzzFsB5tv/ZFHZEReoAqhrddTmOPGUJt9IA
 PalPEzm0skcmGIV4geHh61XvI6towxf7xCpGzAYlxnHBIFzdfTuBmm16KH+RQfpeN/smZs6LxDl
 qiWWMppxAHMrnZDYXqudD4kghplpdxJNy9prZuMm7ixjzPyRaasqh9q6SnPPih0ZVBgfnr55ivS
 cyUFcnv1Fyun29RS+sxU8J0nPZsfrldLonR+Xsk9QWyP6iZnwXefeZqPjL6pgKeiHEGe4pNG91P
 18M22OIQ==
X-Google-Smtp-Source: AGHT+IEU1RYis1TatpeKIs/IhtGAo6rGSC4zU0y/XnrXwCWCnitu0HZmqBMCffj5cw0yVR4cSgOrng==
X-Received: by 2002:a05:6000:25c8:b0:428:3d75:b0e8 with SMTP id
 ffacd0b85a97d-4283d75c950mr14901692f8f.62.1761231365682; 
 Thu, 23 Oct 2025 07:56:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.56.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:56:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/16] target/arm: Enable FEAT_AIE for -cpu max
Date: Thu, 23 Oct 2025 15:55:47 +0100
Message-ID: <20251023145554.2062752-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251014195017.421681-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index bf81da124a0..31a5878a8fa 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -21,6 +21,7 @@ the following architecture extensions:
 - FEAT_AdvSIMD (Advanced SIMD Extension)
 - FEAT_AES (AESD and AESE instructions)
 - FEAT_AFP (Alternate floating-point behavior)
+- FEAT_AIE (Memory Attribute Index Enhancement)
 - FEAT_Armv9_Crypto (Armv9 Cryptographic Extension)
 - FEAT_ASID16 (16 bit ASID)
 - FEAT_ATS1A (Address Translation operations that ignore stage 1 permissions)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 1bffe66e81c..6871956382f 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1331,6 +1331,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
     t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* FEAT_S1PIE */
     t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* FEAT_S2PIE */
+    t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* FEAT_AIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
-- 
2.43.0



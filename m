Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AE2CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPO0E-0000ZJ-5T; Tue, 19 May 2026 13:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPO03-0000Vo-HB
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:13:01 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPO01-0007Lh-W2
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:12:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so29477625e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779210776; x=1779815576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mDGkTt4tPBj5+q7fES2uiVCIWmZVHm7K0SHYNVP93xw=;
 b=lcpi1/SjydnjmgScjLew4+qiwUaR0OG9ysAl54rHPsogaIXQ+at2COHrupDt2Fr5Df
 1a4wvrQDwpx/J+8fbkcR/6FPGrjwjUQf0nClmNfC1oeM1UaRKvFD1DT2DSuHfwYkB5HI
 jUIzh9OBFmOsMHLEB6ADAP9zjcdCywpgJTS4/niPeTf0Mnx7bzeb6jyx8/cL1bqVYcdt
 kgAoTX/7TjbZL6jfRlrUoE2iggM8LKPX0MESIlA3a2gviu/tpIzg2vwNfG7ut8iS2TRE
 Uqpj0PR2IzVRswzE/v/qSWB4R+6J7fsv7LAP4pfUrLBB0yMiDwblqp90jREs/NvsnEPv
 /zrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779210776; x=1779815576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mDGkTt4tPBj5+q7fES2uiVCIWmZVHm7K0SHYNVP93xw=;
 b=Fyay8s+zLu402mi17T9uli6nCB6juCjc63bA+MOAQqbcSSra8OEP59jNIQQHXf+rgs
 Zfilc/azdp00+b5AGNGKM06fVr6ho84mBuSl6TV1KfFTj04tKUS89R4kWkJa/i57UAxg
 lYP5ozrPPC3cPoOCPfyZRw07WfVrNXat8A2P9VQDVgMIl1e7joc6n7sq2k5GTtS7znkZ
 EsWP2xdfC0l2K3JG4rZ1hduwgSqOnXPdZCGFOx5X9sFC6OlFb1nbCN11Amt0E3K6DgvE
 RwfvPH4hJP+iqO2L7sltkyIoRxrhrGP0Q79Dyk/vpAczuWK2NvEgfEgzPIA3+m8vVPZH
 4G7w==
X-Gm-Message-State: AOJu0YyrDs2cNrcVeP4qV62eWaKasiMtcBh/yXucBJ3HxbGrYvaYpLWK
 vTzBm68pAtj/IRZb4TvPWjRqXsfLzu8sISZLV2JIrFWf2wHaIBb9GLlBpmpa9sj2xLDry7TzzmF
 fKpLTOu0=
X-Gm-Gg: Acq92OGMB4LgmE84LZ+TtSQP4anNDDbYDnd5fjGjttAPYHaPknjOgrCc58jx40vfhyq
 kJU+jjVWIb5L6+SN4TXjLrf1/ZCG5UZrnnQ/mNbbFiiTpxlR60Tkx58W7fjUn7PBe1w+eYlmGRH
 t7Tq/SoTppZVuEIRMlZCfVLloXtVtCRKcaJs5HY8w0uxJuWAkwWlPwn/VMWEcsCxs9DEUUVAfEo
 8yw2ufhCwrPv8yN7h3KliW//itP00cLjwUIe0y9tL7WuUieFyP+WWXC/jSvGln4q2NhmEdxFOVd
 MfesevtCuX8yhUJepT/1blh5fQPr5ccPyhNRa7IuiTKBf7lfRhQxBqdKFLu3I+spJmFR/M2W+w3
 KkruWBiwiBbpS1TMPDLGME6tJ/9RtiLeno2abVXc9zKVE5QPS1koWb6JkcGnGepVR8wyEAkxAYC
 s1+LyYlTCQ+4uTmw/JUiq3BtdvwUEMQjai47PsaJiwavXs/BPDEiwIx+u/2ogKo5NzMTnrZ4+m
X-Received: by 2002:a05:600c:609a:b0:490:b07:5fd1 with SMTP id
 5b1f17b1804b1-4900b076103mr158721515e9.11.1779210776466; 
 Tue, 19 May 2026 10:12:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a5653sm47225173f8f.35.2026.05.19.10.12.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 10:12:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
Subject: [PATCH v2 2/4] MAINTAINERS: Fix tcg/s390x/ path
Date: Tue, 19 May 2026 19:12:38 +0200
Message-ID: <20260519171240.97420-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519171240.97420-1-philmd@linaro.org>
References: <20260519171240.97420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

This folder was renamed in commit 3704993f545 ("tcg/s390x: Rename
from tcg/s390").

Reported-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7749fe7f9bc..92b875ddfc1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4180,7 +4180,7 @@ F: disas/riscv*.[ch]
 S390 TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
 S: Maintained
-F: tcg/s390/
+F: tcg/s390x/
 L: qemu-s390x@nongnu.org
 
 SPARC TCG target
-- 
2.53.0



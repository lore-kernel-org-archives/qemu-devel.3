Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE78F9EDC5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX4i-0005yk-88; Wed, 22 Apr 2026 08:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4d-0005vF-29
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:52:59 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4b-0005SN-CC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:52:58 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso3302194f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862376; x=1777467176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRTiu65oEEP/NVXKQGmyzqv/GBntii32+7VLEeXU9Tc=;
 b=gyHW7rG8C8QZflsWVCFeA3+wYVi8bdRtLVlwYvpaVSNM9QxnjT0YtLfGS90U4EftSm
 cWpCVQTQzjLqNDK9b3oME4iVnUXy+J6AwbFLR4OfS5Zvs38L3XkDUXt+MY2leN91334t
 iVNsCGO5E5nH3f2KaMEBXzDeoPRr++BonY0ZFpsMC9i9017rkJQFPiExljNf9cQhDjer
 t+JQ4C99uFatvSLR4rMYfuPbiA8z0tEbRf92PWDSf4/MjBCkEhKVoKy0YwkS3RLFG5Bc
 Oef939WYPJAuHZmuo8nqAq4J1vHnEvRk28hATIlc86U6MzOIrjMzOTbOsf7KomH2Paq9
 iPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862376; x=1777467176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XRTiu65oEEP/NVXKQGmyzqv/GBntii32+7VLEeXU9Tc=;
 b=Al+NreeoQxRelI1TfOh/giR/hUZHMurxDfKH3U/k6+LAQWUfpAaF6CeAgi2HufcUXL
 JH/RaITnEafj0pw5sZeVNcZSuxTM8m+D5jv9EHHpWpvobVqjyc8cnmRgush5H6iFiNHN
 dwAIILanms6EImJKLJ8XX9ft+VOxemexS0FKZbEAjN9jAhm4ei9INqgZPDjRl7dJvEed
 QvEql0UiOlcViZ6TxL0hjQfOSqVk37H62m6UhIuhXXTnoBaCRTsfvLrxukQM+JFrE/YD
 fwndhWI/PULY9kMOFsmo/KPOhg2OLV6oHjk8imMVPLlv8swKhyo/XjOdxCpldtsiFacP
 QptA==
X-Gm-Message-State: AOJu0YxW1G8p4aSolIC6GOwjhNliSGcJT0xh0sATYIItff7RQq4DtSRi
 vRUXjQGA0Pto6y52U6qJyefMDVMi889nqSqw2xL4DRQe9mxOPVHxyORFYXcrXgPzI9Q=
X-Gm-Gg: AeBDieu/RP1z3aLbLPD7uc8DBGKEJa81c/tIX08o6mV0LaD+nSYgIw4pAspwb4bGMyS
 34cjFlyLqpfW1GH5oJlad5UzBVPxrwt1c/qmL4I48HWwh57CCWMTKw8PxE2AGd9LTs4NUADcdfY
 56Vu4ov4MbayBaMDC3XY0sEeoMfauewwP9/oe7t7D5+vhhlQJXFOFtq8kGzxxwSMXeooN/5+HA1
 F0nkWl0lDkm3crdxo8jAV0ZAX7eKkk+A/TUTu4bhWrxHJDDfutkx7GSAEV5ipRDQ6gmfbbXdfpd
 nVGjglE/T6p+f6f3UFNNbkGaWX/IYIArN86jzB1jI0Q8o9pGQT2ACNfZJ3ZhtH1dzQWLF4joDXo
 zQOcuH5ff3nJOnyQG7VT6DzypkzhEPcIrh/NZV3y5O3/Apkpy873Cyu94CVx/IQrqrnEooufAWY
 RyMclPLEy9ep/ov33H09j6bF/Zarj+NbQxgw==
X-Received: by 2002:a05:6000:2207:b0:43d:6a02:b7ad with SMTP id
 ffacd0b85a97d-43fe3da668bmr32520165f8f.4.1776862375765; 
 Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1365sm48295853f8f.7.2026.04.22.05.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:52:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 46D9A60338;
 Wed, 22 Apr 2026 13:52:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 04/32] target/arm: migrate eret trap syndromes to
 registerfields
Date: Wed, 22 Apr 2026 13:52:21 +0100
Message-ID: <20260422125250.1303100-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

For simplicity keep the OP as a two bit field rather than the two
interlinked fields in the docs (ERET/ERETA).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 72051443d59..63c8e66ea91 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -367,12 +367,21 @@ static inline uint32_t syn_sve_access_trap(void)
 }
 
 /*
+ * ISS encoding for an exception from an ERET, ERETAA or ERETAB
+ * instructions.
+ *
  * eret_op is bits [1:0] of the ERET instruction, so:
  * 0 for ERET, 2 for ERETAA, 3 for ERETAB.
  */
+FIELD(ERET_ISS, OP, 0, 2)
+
 static inline uint32_t syn_erettrap(int eret_op)
 {
-    return (EC_ERETTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL | eret_op;
+    uint32_t res = syn_set_ec(0, EC_ERETTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, ERET_ISS, OP, eret_op);
+
+    return res;
 }
 
 static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
-- 
2.47.3



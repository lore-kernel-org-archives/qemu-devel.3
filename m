Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FABCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqU-0007PL-5W; Fri, 10 Oct 2025 09:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CqP-0007JV-GK
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:37 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpT-00040x-EQ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:36 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3fc36b99e92so2278228f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101595; x=1760706395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LJaU/5dMmUmO+f7wS8v13TQuHhb03VPHkGjmwHQjFwo=;
 b=zCDxmDiPv23NoElvzelmRGkGuzIp2eMfxPnTf+JGdFTLrd6xkkEDgZTDoOlHnNZf5w
 VHYqi+NjdmumZm/k/HUVHSUK3FSe1HXnzp9zjO5RXlpd1uzCHTSUSM1QauT9rHE2JPfk
 IVMVxPJgop4BdsAEBVcLT5eRu77Omo6+FaXQFkQwmcNLJgJ5JNhPbXb3EhbEb+rjJNxc
 0AbtY2ngw+SDsBbzkRSs57Pqle7jg6ZsqcYnGKtJAx+l4A0ksOzS0xcu3MngCL3ahht7
 bFwJFr/p4bb+hQS+x0NmnDiP9ZlPbVBGRiiX/Yx0RGpOxFWIMquwJvETkqYnt5CLeW0L
 Pa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101595; x=1760706395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJaU/5dMmUmO+f7wS8v13TQuHhb03VPHkGjmwHQjFwo=;
 b=Xe5V7YJj37AZEVOpZQetiEpGFuJuzjG8iSoq/LSKxDPIDgeaguII/xY5zgCMDkngKQ
 uDfqE1ruiq97gD+hjfmvNOEVZettfEm/gcbMvwBfkmGWGGXjwHQEs3xIQE1g+n+V+Owl
 GX14QN6y1G5sOWTGruoDTuM7sZIGdRecdvF+XOT5f1sb8sua0x4/pjUyStrUS2VkiDWn
 m8FbIF0RP+xJGiJCGAP5z8JHvaPRDHPZsxFecLe47mwcdRYPMM3ImGVESnqexICIskom
 7vxg0UINPScGWIv4LQlDxrM8mmwUHUrCXZNTuXHxAF1kJCusf/J5NG0ZEsUTUCNoOtyM
 hOkQ==
X-Gm-Message-State: AOJu0Yy8XaXqNuVkTxunnThllvQCcm6l82zMxd861LUYBKVBKWZkoxdT
 gdsDAM53J5ELnmx9fswSTb557EzARA7oy8lshnyOvuL3FsUjY2j4gFUeUon81KxdNS3cpBZvWYI
 ZG+g1
X-Gm-Gg: ASbGncsl6NaUrVHMW1FF4Nt3ED6iWodcSyHLYfThuh9bXDvWY7Qd/OMv3Y/KDtKk4Jl
 nQefRUcBw7YWkNuiQItdybyWd24NV0VFlFaoCN8HHfvX9J/NdsLBpyrE5EGZhoSLTaljknxq3/U
 gvXtXFo5FOWInvHsVXW/7UkzQ38R8jhqv63ETn3kvpC6R3nUj8bXqepFzZtuiRkVO7jNUw8CQn9
 dTn3RRoD2ozRz6ZgcmZXfaFHA2/B5YZ+yyf+bGOg6AjNSfFLXq8v9GGPPl+mszNdtfw0TNdJds+
 hCI/qeP4jS7FVV79jNr0UNq7cQUVpj4X7INM82A0WJE+aeJTnsXegh17awg1DwMeyms7OifGV0f
 P9JpGr0WeXH/scnMP8w68LAfgmDCEwY8VWTox+ROUcidatSiPvcw=
X-Google-Smtp-Source: AGHT+IGMgFvnxFucIM/RSTLG/KP1L7jOILKOFXeEuT0M4RkJMPF2sqfCLmzGKBQiFjAl+BGSBLzi0g==
X-Received: by 2002:a5d:5f96:0:b0:3ec:42f9:952b with SMTP id
 ffacd0b85a97d-42666a9e191mr8301895f8f.4.1760101595327; 
 Fri, 10 Oct 2025 06:06:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 59/76] target/arm: Load gcs record for RET with PAuth
Date: Fri, 10 Oct 2025 14:05:10 +0100
Message-ID: <20251010130527.3921602-60-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-60-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index dfd5b178317..918d5ed1120 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1898,7 +1898,12 @@ static bool trans_RETA(DisasContext *s, arg_reta *a)
     }
 
     dst = auth_branch_target(s, cpu_reg(s, 30), cpu_X[31], !a->m);
-    gen_a64_set_pc(s, dst);
+    if (s->gcs_en) {
+        GCSInstructionType it = a->m ? GCS_IT_RET_PauthB : GCS_IT_RET_PauthA;
+        gen_load_check_gcs_record(s, dst, it, 30);
+    } else {
+        gen_a64_set_pc(s, dst);
+    }
     s->base.is_jmp = DISAS_JUMP;
     return true;
 }
-- 
2.43.0



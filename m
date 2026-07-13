Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4915C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIek-0000bd-EV; Mon, 13 Jul 2026 11:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeO-0008US-Si
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:33:04 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeK-00019U-7G
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493f431e317so602305e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956769; x=1784561569; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AXZ0eN7Zo0Hlbw2MrFqxIJVvcQpJCtShcmKJD0GREgw=;
 b=V4Yzs4UfWeaokjlGgRGEd+75VheTGEtcFweXK6GTFSPXx7eWjuPN2+QQ0H33BxVp1M
 4r2OB/tpzv/iob5tDIBnR2ZGBofylG9tFs224v2Wx+Gp27WgY6LwzwTkebHfl7cCnTP7
 L+u484qCmJzewUiou7YAYuYJvEcMzlEsVKMQMfvxo9lIOrz+eCZ+BSVYV8RsoZNQDwgp
 oHg2MbZxMoaUyURK+TpZ4aRpY7/Gu/IMiR35JQyFBgw3wDOP8R1DpFPoXqEyQcD93tQP
 TAtoniSYSC4PC8TmiQ9XLlndKMg9rFFTTBXz/RDRnQJQlWoW7fCQHIVb+gSyWMxta8Lx
 fuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956769; x=1784561569;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AXZ0eN7Zo0Hlbw2MrFqxIJVvcQpJCtShcmKJD0GREgw=;
 b=qKAJTYbWccBNjkTQIwiPcLG5NsPUrtievwIzRXe6eRwBC/65qi7SBj5BnUdLkMhkz8
 wb7msh/pygfIqlXUlJ+mHExiDrBYdmuANjkTfSIxOPCS4aBap2anwLRkWntADoZjzv8s
 SLrziSz1Jp0aNjl6DlgLMp0M2M/4NtIzrrlSSb6W3cC8iQpJACUMKTc5L/i4fzAqi8+A
 zAr1b69pkY+cbFKhNO+++IWCz9NgJDVfg8K9SWij5r1qcFlANFBAaLsw7HY/e+wF/vNe
 j3zniNFO8nVZpIl6rU/BUA/AnRPDCHynylJU0WlI+lU7FlHCav3dJSek0OhcYjTC/Jp0
 H/XA==
X-Gm-Message-State: AOJu0YzApZfL5vBHB0FN9WAOuJSr9ALIQpjagskHec8MD+pYlo3njO3d
 4378NoOaRv0cf+jwe8/yQ3GdPASbsfgExt9Vc68m0kjq9ndrqUAzbh6Zz8sJbOUC1cQCREmb5OG
 qrJOCqVVfyg==
X-Gm-Gg: AfdE7clMOfEIMS2gx7u+cPt1a4RJkjE8W5OLPlyHiQwto1/JQI37OGDaZr4MKn8R+h+
 w0Fi64TH+XLB1Q6HvlJVefaaJVBYL/ee60gP0RoBY5rbXPrLd+9fXRSRLRhNKiJpGgaLifSlR66
 +LIhLyYoGtZN6qteUO0aJRWj/U36CqkSlpRri32KZ75dydD/3gQB3G0x5afh02dJSiv1Oc+gi35
 sVe3daC8sekY2BcS7hpVrc3V2sFYe+GWAwG17KLRD/xpBbmI0EaaNBcfUenDdsB+tB6E2JBu7ob
 vwAeVjiqP6VVgrJzQYxzwPURCRed9xxB9VvGS3sb6JQW24LtDOBmkSZXo06bXDlpZPCywln+Q3R
 yNpfB3dT0qm5XAGEoTS7r5whsik9wRoElVEo3OrYn3UStsMNsvPU/nDYrcLr0Rmi/8I3CDuBeL8
 KHZoxObCaQwUOV8WRbHhyDO+w3bqPyo+K1SRxwBpqbTKI3H8llftLJJiwQzxDXaSbWMce571dr0
 q1LUVw=
X-Received: by 2002:a05:600c:16ca:b0:493:c1bc:79bd with SMTP id
 5b1f17b1804b1-493f88180f9mr61437695e9.20.1783956769085; 
 Mon, 13 Jul 2026 08:32:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/26] docs/system: add FEAT_S2TGran[4|16|64]K features
Date: Mon, 13 Jul 2026 16:32:22 +0100
Message-ID: <20260713153233.3391818-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

We already have the logic to handle these granule sizes in our stage 2
page table walk code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260708145841.3032079-8-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index b4b65694ff5..903a5f90880 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -162,6 +162,9 @@ the following architecture extensions:
 - FEAT_S1PIE (Stage 1 permission indirections)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_S2PIE (Stage 2 permission indirections)
+- FEAT_S2TGran16K (Support for 16KB memory translation granule size at stage 2)
+- FEAT_S2TGran4K (Support for 4KB memory translation granule size at stage 2)
+- FEAT_S2TGran64K (Support for 64KB memory translation granule size at stage 2)
 - FEAT_SB (Speculation Barrier)
 - FEAT_SCTLR2 (Extension to SCTLR_ELx)
 - FEAT_Secure (Support for Secure state)
-- 
2.43.0



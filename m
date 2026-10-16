Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1290CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeRV-000855-F1; Fri, 16 Oct 2026 05:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xHeRT-00084C-I8
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:41:35 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xHeRR-00071w-DS
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:41:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a02667ccebso46040715e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 02:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792143692; x=1792748492; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JaV6zcQXKCHcnVPOydiraqRohmCcTct76VZifDwNpIQ=;
 b=o+gXNizY+2cLeAV7s/EeDaGKb4jHDOodVDTfOyG/isVh78KyJCG6MDZsjxjBlMCvgj
 +lQWi2ZVaAUz2+tJ4aPm5yPXyDUAqLofbi2B+TbAt5IdHd9mZHqGFS8hQFUY4d4JU57Q
 GPX9cHKzHdor+cmzvZQ6oJGHuzdBUIhapSLZ3kSSuUANl6lKsgqFOSlDLwqy6q+Jazqp
 JIa6fJt9tMp0DllNz9/G7ZnMwW+ljrPVdJwFrdS+2+8CHdtGhjkQO90HZAwvwoDKhbZI
 U6fTdFpo9loXgaNkl5LsqppxAjjWPwXmoaa8SEdgPT7HdnBAuBjqXK7WSkuia+IIbHut
 +7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792143692; x=1792748492;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JaV6zcQXKCHcnVPOydiraqRohmCcTct76VZifDwNpIQ=;
 b=etcI9dMrAGyQs7xH+DWvWGzI2JKIGgw/pN/ZeZkoyRHarBHRHRlJXBXsWD9slmrpEg
 lie91PSLzp4Pjo4o2r099nPHhUdC3tCr5ISpqizdx7paC5VdtbjSvG2Qwj2B8gLXZFP5
 46w2IwLE0Yd/nW5O4iPT/Gyl7x6a8cbnJuX4FBIReq08r+8hDBBUpupMfLG+cX2Og04H
 LQZ86/pPzhIFRkirIX0LYoQAc6tLkNAMAsUb18p4wAlTyBo2fhpX7xMkYpJNn/zuQKDc
 ENyFOvdCx1sVoVvMd4yfjbaSZy1LfhOwyaYd1tskyb08gHvzx8qr9XSTmyJIhx9GcY27
 LGXQ==
X-Gm-Message-State: AFq9FYJukhnl5AGu++WX4SPDDldEPIy3jVPS410LwPXSRPS0Go8xHc2I
 1jmCf/+Ynuf55yEnyoPKUQTtxp8j+CHasuOmFPVf1l5e25ra2azhh/EumqsFDL07wM0vVLxaDL3
 hCqriG1w=
X-Gm-Gg: AYBFou2enOZ5N/DxQ2zlKbrccu/I97avgV3vflUSO4eSLkVELOD8MDlTrEwL0iKVPLb
 4wvjyQAnyIEhXT4jBUTZA4JxB82pAFiv/R+5DOq52rQt2IbW5W4V0999wQcOraqUWOaZyqplK53
 yM45B/HHv6l9rfZIE5m0ZL6KN4h0/gFiNxtw1oAng3h5HTZHp7bMrbrlajSVnErbEeFEAzM+oGj
 amz3/jC+zvvkLKGao3q927725d+WE4GmMWE/tn9/U2s13hBcN1Grs5LedhN4MzPD55fzAxSeogi
 oahOETFJTXgRzvg5FtyY0DT8ISJeuMnplCrI8CbMJkIfjLoB6iTmHbiSfLFkqpvMtxg1JPhN4Oo
 KexIZFrzCvDvj8U9QsBvOhrBDmWnxcNiTn+IKExqhdG0rGOLkBUUA3GdT9aTmkMVA1cNwUrdqnX
 SP4ef0Sbtze8VTATl3gpvyrf6T8d5GjEIQoxB5l1i4MoTjnFywkEFn3ZrzQkVXED8ZIdJ96mv9K
 fEI4sWeI18T
X-Received: by 2002:a05:600c:19ca:b0:4a1:7e76:d02f with SMTP id
 5b1f17b1804b1-4a18e4ac650mr436698005e9.14.1792143691853; 
 Fri, 16 Oct 2026 02:41:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:8f73:128f:8f43:e3ec])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cf05009csm28649385e9.10.2026.10.16.02.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:41:31 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Fri, 16 Oct 2026 10:40:52 +0100
Subject: [PATCH 2/2] hw/arm/sbsa-ref.c: Increase SMMU space for Root registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-jmac-smmu-root-registers-v1-2-e78e8879d347@linaro.org>
References: <20261016-jmac-smmu-root-registers-v1-0-e78e8879d347@linaro.org>
In-Reply-To: <20261016-jmac-smmu-root-registers-v1-0-e78e8879d347@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.17-dev-6be7c
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x336.google.com
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

In our implementation, SMMU Root registers are directly after the
non-optional SMMU registers. Realms registers will be added above the
root registers later.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/arm/sbsa-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 158b461eb4..0747f5ca9f 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -129,7 +129,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
     [SBSA_SECURE_UART] =        { 0x60030000, 0x00001000 },
     [SBSA_SECURE_UART_MM] =     { 0x60040000, 0x00001000 },
-    [SBSA_SMMU] =               { 0x60050000, 0x00020000 },
+    [SBSA_SMMU] =               { 0x60050000, 0x00040000 },
     /* Space here reserved for more SMMUs */
     [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
     [SBSA_XHCI] =               { 0x60110000, 0x00010000 },

-- 
2.43.0



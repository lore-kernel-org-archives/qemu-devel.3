Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4C6C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzKr-0001lo-Sp; Tue, 25 Feb 2025 13:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJZ-000072-4r
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:57 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJU-0002Ib-My
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4399d14334aso52069895e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506744; x=1741111544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+KRNDOAM2UifPdugrP+Z6GvcaB2Pzjsk9KwzwCOMbUs=;
 b=H6PDuuaIUiSCBtAck2wHjDmqeGVlLNUMdKgpckZrgWThsVBc/2l7ORZwdQe2JzMpA2
 70Fyix/PiMY9/21hdiSCil34419IRZs5m6bN1qKGRMSg95I7qWBr9dLfTQvcAwfbs2GC
 D4E8e1ew63mLph1SJdW/30innSNtO1ZFdMduNLsCgLgIeLcHA7KuSj7DdZAavbb5l0D8
 7ZchDu1UseRN2rUW71WjwnzGlROi4AtIkxrzPhZZ2lVA/Vyfp1q1BEfD9AcUwO+R1j1n
 5SDGTc+8dz8HuWDUS/3X4XAZEpHdlmOxY7C7wqfGo0LZozDzGgMqjZI9/PhieKfCiNiY
 5xZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506744; x=1741111544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KRNDOAM2UifPdugrP+Z6GvcaB2Pzjsk9KwzwCOMbUs=;
 b=m4P9PZ7FTkxCouoqwXvlHGNijVECiLdpn2cR0B7Ob2VAXeOHF24JDqbuTdXSla1Yb6
 +0XY2EIVPfw0PSDMxa3NV1j70hQv+Gzl0LXnKDg16Ipu9A3fGl6XTonRYOzTZWxu5+2x
 zCKC9OP3kSDwTTF5Ns5xd3cmFglfRVc3DxTNKi5eBGRXCpQScYLWhDTYsvribXxvgIXK
 8diLX9CHq2Jzx1x8rfrrBEo1x0z8OkjcHSB1UWGltlvGj+pHBIH4EBgdiaEAlrXwTpnl
 SSJbklir1+c2ZdarXJWqCu3mEsx/RnGYhuS8gWmOB9BK0dewAFmTEFP+Ncw3VeA3pRDM
 uLIA==
X-Gm-Message-State: AOJu0YwTmY586ILTL4PLSGEl0FbxnnqddUbF+1UxI2cX0r+a0fuEY5fd
 q3KjjU77Vu/zdhCT5bdJmowOmZJFIkqwyjzCCgfDt9ivj7du1MYiOwWjuO8lxz8OdicjhMZif3R
 f
X-Gm-Gg: ASbGncsaptdtOuuemdAlXpAo4OZAbJemGRtG2tsaIWX8C7UI5eiZ7EtrVW3sJloejF8
 m9P/pYzXNEiOfCO829Z05BTFGVB0TMyNVGD7If83xU1LZ/bXqVDmay+9NWDMnOJKnNFgDnnz3FJ
 CwZlCv29cdrabT1oG/WVzS3ooRlDBCeNJmKyj+aKRHEm3of8J1SeeRw9gYwWOmRv3jcmvKvVf0m
 4byvzxa+oQ63FQwmnknKm4YiYsihyJTbr1IDgNszH+BZFyHka+vdL0DvlWEv0+24+gqjCEGkugz
 /9oIRURQu5G1bFdB0d/tprI+sBHnFc53
X-Google-Smtp-Source: AGHT+IGdmdXrgeGYXMkBCW78WohPgyiRGjzS5hP+hTVBL62RYzs+W+9BkNscBN338bmPksKL12+EIA==
X-Received: by 2002:a05:600c:3588:b0:439:6304:e28a with SMTP id
 5b1f17b1804b1-43ab8f6fe56mr5771505e9.0.1740506742211; 
 Tue, 25 Feb 2025 10:05:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/43] target/arm/hvf: Disable SME feature
Date: Tue, 25 Feb 2025 18:04:51 +0000
Message-ID: <20250225180510.1318207-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Joelle van Dyne <j@getutm.app>

macOS 15.2's Hypervisor.framework exposes SME feature on M4 Macs.
However, QEMU's hvf accelerator code does not properly support it
yet, causing QEMU to fail to start when hvf accelerator is used on
these systems, with the error message:

  qemu-aarch64-softmmu: cannot disable sme4224
  All SME vector lengths are disabled.
  With SME enabled, at least one vector length must be enabled.

Ideally we would have SME support on these hosts; however, until that
point, we must suppress the SME feature in the ID registers, so that
users can at least run non-SME guests.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2665
Signed-off-by: Joelle van Dyne <j@getutm.app>
Message-id: 20250224165735.36792-1-j@getutm.app
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: expanded commit message, comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0afd96018e0..872a25be869 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -899,6 +899,18 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar.id_aa64mmfr0);
 
+    /*
+     * Disable SME, which is not properly handled by QEMU hvf yet.
+     * To allow this through we would need to:
+     * - make sure that the SME state is correctly handled in the
+     *   get_registers/put_registers functions
+     * - get the SME-specific CPU properties to work with accelerators
+     *   other than TCG
+     * - fix any assumptions we made that SME implies SVE (since
+     *   on the M4 there is SME but not SVE)
+     */
+    host_isar.id_aa64pfr1 &= ~R_ID_AA64PFR1_SME_MASK;
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.43.0



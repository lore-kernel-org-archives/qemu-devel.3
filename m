Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FED7C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTjl-0003W1-OW; Wed, 08 Jul 2026 10:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTji-0003O7-6e
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTjd-0002zJ-Js
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493c5220cb7so6193995e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783522728; x=1784127528; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5+grSbIIumxlH8jhvJyMtUcl5Okg6RaG2PcNOeusT/A=;
 b=BmSKjCA/78oBg+rcUrtdRzEY1j42ikfQU2H4we8gTnL4l5CIBoGuNcYLYetUUoaMAr
 45L1OiycwRvhI80QB2pvU59ZkljJvqvlr6kY+qSPgjmxzDj7UkXpi9T1nJJJecWBQWEw
 6JhG8rjsChfLFyFY3Uf9MHtJ25dpsPR2eV+t8mLpXeidCpdOdej5oeL5UajQyFvjSsKk
 o4fJLUBU1SAbCDBU6vdHlbEZUlQemhqA1m6dmYru7mFGfhmeTOKTSz8gFfpBiLg/Wp1+
 QiMGsBZ2kh84JqbHKI3d5oRzKVVM58fulffCwcp+jKD7ZU8L/SooNZo5+FEo0Wcpz89U
 vPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522728; x=1784127528;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5+grSbIIumxlH8jhvJyMtUcl5Okg6RaG2PcNOeusT/A=;
 b=sFCX76MZ7LnMaLPZ1KOF0njwWtIEQ8+QKwT4VMRE7OCB+JB/NlnyxC5SWaTBOdibYa
 fWL4LrojWhdZ3+L36UjJ9xQlXYsyfct7+OWB3U/jphV0JinBDlxqDx6f75qqshQfJbDY
 ILBZi1SG4ZXgY0yKhAOZoIfU2RYaROgAv3dWCVSDL9TRCm0jUXU2h0yr64kEbxlz+fJ9
 xnsuwZ7ZgNv4/8JiL5po3r79HNXKjlPhiLsA1HpghahDXLrsQtmo6N9bqpakf9q0IsLm
 yBGreD9AIIPDYJywWRmaACgn8hBMMEzln58zVLGW2zpLhB3tXw9dBrgQhWNoyHrIpEbH
 KiQg==
X-Gm-Message-State: AOJu0YwFdV0Iv8eVW5PKcOfbH+risekY+cTK0sTrb0anKViUbiuIQkFF
 oSXIsOFVq9x/hBLUevoN+V4r4qnzbV4MT9zc/FjP3Z6GvtoIo/mq5sin7+duubdq1YE=
X-Gm-Gg: AfdE7ckd9Znya4as2QVwnFeuAeNrOthKNspmbwEmwWiJr58iq4CeQOTZQTx+467LR3d
 3n9EA9zlUwLQrxzxE3s4p0FUX1kDZn2wkq6AiJe9WqYL0ecIv8Br+x12EJtTGrMYzUTc1MjcPMN
 KfuqIiu7G/ESBwigStTznmh4SVUUJ+au6MJnukvNT8rKF9x/XYteo3ouN4hMmNepgpa1t6NXGf9
 5PQIAkBjzcMb8SXCTcYfInbw8sJ+4XbVFEbfnma2Js5y7mahhasmVwlVS/tTbtA9bq3zqK9zOc2
 JKAXHGOzC3cW9YcqUSo5M//UZyxi/b8NV75pkIt3rbFc/WMGtcDzhlIFpH/VFY3iq6OYCdoyxj2
 S6jF12ZhtZKbCncaOe59o8G/VWO5nY4W/sXVS4innIoXdUCWCD/Wa1GPNrs/GvfFVdHLAuqHCKM
 U9Os2GZbbLN+YNvgwSJQCT0fo=
X-Received: by 2002:a05:600c:6206:b0:493:a573:179b with SMTP id
 5b1f17b1804b1-493e68d145dmr31328665e9.30.1783522728096; 
 Wed, 08 Jul 2026 07:58:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e10af550sm145923025e9.1.2026.07.08.07.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:58:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E9D3600F1;
 Wed, 08 Jul 2026 15:58:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 6/8] docs/system: fix sorting of FEAT_S2[PIE|FWB]
Date: Wed,  8 Jul 2026 15:58:39 +0100
Message-ID: <20260708145841.3032079-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708145841.3032079-1-alex.bennee@linaro.org>
References: <20260708145841.3032079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/arm/emulation.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 7806982e0d6..b4b65694ff5 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -160,8 +160,8 @@ the following architecture extensions:
 - FEAT_RNG_TRAP (Trapping support for RNDR/RNDRRS)
 - FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
 - FEAT_S1PIE (Stage 1 permission indirections)
-- FEAT_S2PIE (Stage 2 permission indirections)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
+- FEAT_S2PIE (Stage 2 permission indirections)
 - FEAT_SB (Speculation Barrier)
 - FEAT_SCTLR2 (Extension to SCTLR_ELx)
 - FEAT_Secure (Support for Secure state)
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A862D3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nsO-0001Fh-4S; Tue, 29 Oct 2024 11:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns9-0000oB-Cq
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns2-0007iL-Fu
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4315eeb2601so72835755e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214656; x=1730819456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bt3TVOiuCfVWs2EI3zsc1F1KzgFJR+PP7ljtiyNrGF0=;
 b=tm0v3vnwxLPzCHpQ8F0XjeQzJByxatB1ACHdTyqqmxvjnDLFUtm3q64wNhZFHi8u8Z
 O8C12vL3GF8NwQ3QG0YNBUrs5h5vWLCVLt4eWv2D3TppdXJPKiPdZJpcvOKNY2p6zkAy
 IeGdb4m/XnxYVpgfHZLgsy/N99Ikzjhl0qspH5XLOXVw0+ZwokSPZtycrBnx8ycxfrIk
 dhk1ONt/LXm8wXYgeUcHeawUgS/ldkDZXUykqNmdNTsnE5zOaZcrd/bAzHqbVowCQ7VU
 QZ01nXB927nT078AVOKqcXRRJkjysRMv1vnskFiT/LW4ID1Bm2YzKP9Ywnm7eIc1cjsd
 rLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214656; x=1730819456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bt3TVOiuCfVWs2EI3zsc1F1KzgFJR+PP7ljtiyNrGF0=;
 b=Vxw+NUY0Xwmqbxri+RH1+D65cDfKN+ZnDhNSatEDtP+4chU2Hddf9DldnuPNPyAoKO
 bacTo+SgRJc1iNDAdOx2/it7AyAfM1FfC7IvmfGiOqVMcuIeZ0h/n9CJWuXvJ3dmtd1c
 VoAEek9PmSRdGCFl/wRPSZaaUDY6baXHLTYsubLz0WGbLBGRaxNf2bQY00udpHOPVH7S
 +kQ2f3uFrP/IfzETTCV+2gUpFxZPkteL30oQwWF3AJP6wwdERo4aQ6FYv2jhbG30yugF
 wukJIyjlKABWALWeP9KHAGB5et3nIkx5j/Bl09vL9ffnTg78dCQ2u0AS3zNm1MLLl9IZ
 Htfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ3f/KJM0ZwbD/zRAbOK5jiB3/474ZPuSasF+/IS1C+zg5EbDN+1UgiQXSUoQmW9YSP9WipJGxrZoN@nongnu.org
X-Gm-Message-State: AOJu0YxS4DrAMuXLha6We1Ag9yHYPyeQLc7vK5GQmiBoXY5DhYHmC4At
 GVxOregi0eTsXsIlxgEXZv/0Ls5bU0Z8liF78Rc6cL0W966MB6UASC04n//X8OY=
X-Google-Smtp-Source: AGHT+IEW6KI17re5HjnQTetRJjmCLsYBkUgIKtYgrK3oWAL2aTMYFApNI3PTObuzQ/2TjncHcEuiEg==
X-Received: by 2002:a05:600c:1910:b0:431:5c3d:1700 with SMTP id
 5b1f17b1804b1-4319acadd83mr137689655e9.21.1730214656161; 
 Tue, 29 Oct 2024 08:10:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 12/18] docs/system/arm: Add placeholder doc for exynos4 boards
Date: Tue, 29 Oct 2024 15:10:42 +0000
Message-Id: <20241029151048.1047247-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Add a placeholder doc for the exynos4 boards nuri and smdkc210.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-id: 20241018141332.942844-5-peter.maydell@linaro.org
---
 MAINTAINERS                | 1 +
 docs/system/arm/exynos.rst | 9 +++++++++
 docs/system/target-arm.rst | 1 +
 3 files changed, 11 insertions(+)
 create mode 100644 docs/system/arm/exynos.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index e74d16bcf1d..2b524d7af54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -716,6 +716,7 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/*/exynos*
 F: include/hw/*/exynos*
+F: docs/system/arm/exynos.rst
 
 Calxeda Highbank
 M: Rob Herring <robh@kernel.org>
diff --git a/docs/system/arm/exynos.rst b/docs/system/arm/exynos.rst
new file mode 100644
index 00000000000..86894bc02b7
--- /dev/null
+++ b/docs/system/arm/exynos.rst
@@ -0,0 +1,9 @@
+Exynos4 boards (``nuri``, ``smdkc210``)
+=======================================
+
+These are machines which use the Samsung Exynos4210 SoC, which has Cortex-A9 CPUs.
+
+``nuri`` models the Samsung NURI board.
+
+``smdkc210`` models the Samsung SMDKC210 board.
+
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 9c01e66ffa9..a7f88c8f317 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -90,6 +90,7 @@ undocumented; you can get a complete list by running
    arm/digic
    arm/cubieboard
    arm/emcraft-sf2
+   arm/exynos
    arm/fby35
    arm/musicpal
    arm/kzm
-- 
2.34.1



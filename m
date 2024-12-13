Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5310E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9af-0001hQ-VJ; Fri, 13 Dec 2024 12:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Y2-0008HY-Sh
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:57 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xy-0001jZ-Jc
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:54 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso13995965e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111227; x=1734716027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PBFuTHZDcPncuwYvvsk4kRJzR/9xPxvQn/qSMVquJ4E=;
 b=dAFIg2uJbAKMMaGaHURNMm0O/wz5nhNk+d4DaabzZAwEj1ZA5M7492iiwxh/8rAx3F
 2hNe989kOV0H8fp0wmwpe1mSqJgF6DuK7Aq48aw7FAEL3Vzyb3e9UiEGBNsUvY5NzMQl
 tf4OpOmMTar32VdLZBVtBIMROkFmpC47vBVFQtVjkkVvNghO3U5GPCplFdUbMjYl8W53
 m9+3cKKPUzHVuCJ7Z8bQr2TbHAwAwhoCtRUlOfrXzcFKM+zQRI/Bp0d8srDOxdmNkcNF
 l2x76JeMk9RdmQ91jSujy+aa2beRVxLM1CjdAd7r3cqlQMTCOxVCC/2XAXNwdlySLvp9
 Sasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111227; x=1734716027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PBFuTHZDcPncuwYvvsk4kRJzR/9xPxvQn/qSMVquJ4E=;
 b=eqAVmLJ3OoJZ95Dv0fjgCTYacFE26yOXpEugMZfzkvqYS0vPloz2DCR75dGs33L3AX
 KHE4e+anyrQ+rvoGJoRknT8WkziVjIMpZtVZ15tw754r/zmGkPpnO5mkMixeExKOi0Cp
 ZyvZjMNqHq/gk9PfXnruyP6Mw4iUcxnesKiEAsUgoybvyzWycg/f9O79QDRa9qm8HURT
 RL3X6VBBW0GCsbZCL9usXohNOwGAaxtGt845/SoMMfgEPaoWvn0+ti5RCQfeUyvqotdi
 SmqFJSjPDkfo45XZi14nGTAWxTKWw3EBwqNL53SPmyAX1OizAWkQgc3gpMIcOxMo73ek
 aT/Q==
X-Gm-Message-State: AOJu0YyNZvNYUq+/1qePbeKg3/Ixyk7h4WsaVEV6Py+3weZDCey0uD9H
 DrM2tn4PmBGVCEIU0vj0jr7VPvJ/gjK15ceyxIfWQn0AIrmmn0vjKjKdMRbLdSHRMScJA9vp9/B
 D
X-Gm-Gg: ASbGncszwDkFBProK5boJJ/g0evtB2vyQzKY+RYD/hBKSMOTY7QFG5UMalK55PQA+8b
 dVtyIDY2r7qendMxDSVU0OXSshCggQEqtXv2/RFGM25Spj8cLg1vPWA3gIyJpvhSOp4iNQYpiyr
 9pcUmSkc/1SSAlC+BcV866oOncJHDxvCJfjxJGdvZ7nO4wuQiCFYSnduzgENWu8WZVufrVFBWM+
 gVMNkIWAy6thmemIUqu/3vSgq2mqNl2kDxlqiu93DNkyeFVM8Ay74QBH1wIAQ==
X-Google-Smtp-Source: AGHT+IGxtjgfHb+q7+0GuvXQfW8FSLGYbhYFradVpp2OlsHzC55phuN709fBHh7PWf16MZT2CeNZ/Q==
X-Received: by 2002:a05:600c:3ba1:b0:434:fddf:5bfd with SMTP id
 5b1f17b1804b1-4362aa1473bmr25634335e9.5.1734111227103; 
 Fri, 13 Dec 2024 09:33:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 71/85] docs/system/arm/orangepi: update links
Date: Fri, 13 Dec 2024 17:32:15 +0000
Message-Id: <20241213173229.3308926-72-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

www.orangepi.org does not support https, it's expected to stick to http.

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20241206192254.3889131-2-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/orangepi.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst
index 9afa54213b0..db87e81fec4 100644
--- a/docs/system/arm/orangepi.rst
+++ b/docs/system/arm/orangepi.rst
@@ -119,7 +119,7 @@ Orange Pi PC images
 Note that the mainline kernel does not have a root filesystem. You may provide it
 with an official Orange Pi PC image from the official website:
 
-  http://www.orangepi.org/downloadresources/
+  http://www.orangepi.org/html/serviceAndSupport/index.html
 
 Another possibility is to run an Armbian image for Orange Pi PC which
 can be downloaded from:
@@ -213,7 +213,7 @@ including the Orange Pi PC. NetBSD 9.0 is known to work best for the Orange Pi P
 board and provides a fully working system with serial console, networking and storage.
 For the Orange Pi PC machine, get the 'evbarm-earmv7hf' based image from:
 
-  https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz
+  https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz
 
 The image requires manually installing U-Boot in the image. Build U-Boot with
 the orangepi_pc_defconfig configuration as described in the previous section.
-- 
2.34.1



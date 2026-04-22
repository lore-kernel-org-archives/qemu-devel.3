Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56DBFA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdoS-0000fZ-2Y; Wed, 22 Apr 2026 16:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdnL-00006P-Gm
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:03:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdnJ-0003qq-K5
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:03:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso77001635e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888209; x=1777493009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qiqyPlTfny9lPo0ZX1rwVyHVuc4xQoU/gcm3Q9eKk2I=;
 b=FZxX0yNuz3X/alFe7ACvjAJSNxNWyluw7O7PJ+lpWun5MfH4iRmvDouDG1RVD9YVzR
 TdAxwT0llCpK4Z8TA3FIFN6+L2/4fvPCl21wWKg2yp8x5K+xHwG7OXV+R/Zizbqofxos
 erk/DG3sQ/xNn3eldXTUg9rhNs6YGisy+IBPXlZWb27PPSTqIYFI0KzNa2CuWIXCoWDj
 bhCcam53ixseHzFm/3qPPacm2S/U9r3rmhmDunU9PZWklA6/0YSusOSIi84IZ3EWnhSE
 Kag6Zm9fdKA1TLMyMFRa8I4JyPMYc/vOX8tHk3si0T2GfEoOgdl8UIIFcbllWeDmlrLT
 KitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888209; x=1777493009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qiqyPlTfny9lPo0ZX1rwVyHVuc4xQoU/gcm3Q9eKk2I=;
 b=B4OgHyYDVn/BnN4L49ybM6bicLjLWgiif/EmxHMAxTmTtyUk2elbwqJqDxj2O2vmSY
 nIozOnmTpftaLWngHbet8SCv/VAMZPBkQbxF2OnP2hTR2r7v+qC92gSRHhdGNPFn7A9Z
 yw1Mdw8ZMohli7jDO/5/dDKGFwUNg5zUhmnhrjAg2rYu0pnhjH1070ZY/GQ/Mz7seotV
 W/edX1a69OJx1fYMUX8jFhvZ0577hfgYrYomHLEscVvS6gDDrgLv4zwUN8sfxCLiRfim
 s2ZDLKCWE1tB5ji27VlOOCvrwn0bUINy0F2F7rnQkcPnH0oD81YWH1UEUERBI0qbQYee
 b6vw==
X-Gm-Message-State: AOJu0YxfDRrYDb5nBMdNjWg+2zTf+rYFiFmAAQN/nbokXazW64r0R3sW
 cp517shaUu/tW5CU9tIWlti+grzufgee6n0ai3LuzX49dzJOukK9i6YkQIUG/snBSwUHVNe1Egk
 7eSBt6uQ=
X-Gm-Gg: AeBDieuTqSYRaMGs14Q8GZToAAneYGb6ly9paZ/wcik5f4DpQ8bJqdVV0m377hCA7XJ
 pduvnmoah4TGmSYIIs2DpMwPeLg84Ii2YG7RSuVzBf44eIIU4yfqvXR3b6/UpxTCiFQAR6cx0qf
 MBfQyGZ2BXhxlr2uhejBld8NqljeAjd1dbrJghOEZPpXiNWE48J1djp2nj6qOR5vUYFf37ZLfRo
 ng5yv754unIOPCCqvXdaGD0OnkJwk3qLTNNC6z+NFeOh04+PfMjYvg5+rm3Fx8ndltTF+utFKlZ
 /zLUolj2zoDys7spwyZTMiAmrs82NAHLG/8RweaTqfH1tIF7xBhW6A7egbBq0Byx9PniIm/u89D
 prWBINy2R6zoYbaBRwdtf5j56bX7jozNRiTvF+AT/NBSi8RMiesFI8/ED41F0NhkLK4ZX63EXog
 ohMs6NVBMxgkROL6abevgcxWAlULVTXj7AQEgp/2N5RDzfUPEretK40sSf+pzPoxGNpqF8s+BFq
 K4CFhC9KSo=
X-Received: by 2002:a05:600c:2d09:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-4890c5778ffmr136824405e9.27.1776888209054; 
 Wed, 22 Apr 2026 13:03:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb75ab25sm144842655e9.11.2026.04.22.13.03.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:03:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/48] MAINTAINERS: Transfer CI maintenance to Pierrick
Date: Wed, 22 Apr 2026 21:57:46 +0200
Message-ID: <20260422195746.88865-49-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Pass the torch to Pierrick who does much better and useful
work in this area: https://github.com/p-b-o/qemu-ci

Remove me from custom runner files since I don't have
contact with OSUOSL or IBM.

Cc: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260422080406.62638-11-philmd@linaro.org>
---
 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05bcb5fc7fb..145011fd142 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4478,7 +4478,7 @@ Build and test automation
 Build and test automation, general continuous integration
 M: Alex Bennée <alex.bennee@linaro.org>
 T: git https://gitlab.com/stsquad/qemu testing/next
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: .github/workflows/lockdown.yml
 F: .gitlab-ci.yml
@@ -4524,13 +4524,11 @@ F: .gitlab-ci.d/windows.yml
 
 Guest Test Compilation Support
 M: Alex Bennée <alex.bennee@linaro.org>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: tests/tcg/Makefile.target
 
 GitLab custom runners (HW sponsored by Linaro, OSUOSL and IBM)
 M: Alex Bennée <alex.bennee@linaro.org>
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
 F: .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
@@ -4565,6 +4563,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 R: Marc-André Lureau <marcandre.lureau@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
+R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: meson.build
 F: meson_options.txt
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BC6CCD19F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9mbf-0004L1-Dj; Fri, 17 Oct 2025 11:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9mbd-0004Jt-FD
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:43:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9mbW-0002hQ-Bi
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:43:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47117e75258so8890295e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 08:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760715766; x=1761320566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QfPQEIKuZQv3UL6IYvQM6c/lQ2qRgXLAwDHW1Znm2Rk=;
 b=Mx9uqNrik8USiyLsbqnAdk01JbSkdFqqKTGi5s6RQIOc1VVU3VfWWkbaUZPjJCquDy
 496BAYT/QbD09TYlPlMdY6ufU4Xrj7pXqgzxKqYo7xVFSHfZ+xB/lFeP/h6f+w7B/5xy
 sq+uWVuiLUWnXkTYPQRPsgg44j9BPhC44yeNdnBDsUKe0GzPYoLs4Ej98m/vvhFCY/NU
 hIlYLiKVcKDNJAzvtfmiPVVzv+ddNFMxKFBDoffSjC9UrIG36iFGMGI5ZTCIzgnQPTKK
 rDtz15FYgwWesvrXLAI3/3lJPxLlQ7PRCobmUJmnahM/1q1OeevvAEinDxfBM0m6rRmy
 54dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760715766; x=1761320566;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QfPQEIKuZQv3UL6IYvQM6c/lQ2qRgXLAwDHW1Znm2Rk=;
 b=BDvzsg0tX/YYFe/s3txPkIOPSxzQQqm4brJVeDlBsj2EkeP7NLARve2N/oB1erwJ7t
 06L1mMGJs+q8AWHOHUU18scObOZF8qH1bVd/1lVkoxX//UIGo0Xg7/yKuaItw08QRH8Y
 NdzpziaCA2nlULYmUpInoLs6HW6mLdGxsFiD1ManLr0gG2k9Vdg61CbvmT80/1xCekxo
 78CgK1dwGNGJG/ME2hu5WlJwsnyiOq3qKBcWbXOwIdWGDT7ibgphK3H+7zRvofTt9Aja
 6fRkH5Eo/X8zMnjkUjcdWwz0H7rWWRWdY36NfJIYY9MhXUj7+XASWLRLWWrw2r4lQbrD
 HPkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCValENdgbm/k5Sdcl/F1KxaSgNKW7c8AoIzbQioTuIH3ovTonV+hxTczxd+dzuXGpg53tQig1gL3AuL@nongnu.org
X-Gm-Message-State: AOJu0YxuraMVgZ2VNJy7xGEpdSjkrt2XoWVo1rRtsiD/ADdqNQjkO/OQ
 Zupl+ReuTh02eD/3ciPNCoL3Na9Q8BNoVwqgaOhNHxEDl/p3YrmwdyeqAtrvMN8TSxYfvLFD1EY
 LXyOk
X-Gm-Gg: ASbGnctxRDi6dM0qX0l5JV8pknfKHoDpgL/rDcnMOncWBYHgS7lyxqAWIeNTbQyJskX
 MtaZ085IYgU9Y+4iqfuzcwxdAzEXgNDh/xXXoyP+hEhriDm7mglkkDs9ZtVlJOcjUl06jeiHYA3
 fnG/5PBYf4mTfkdKYQY+lc+o/J1fhPRR+lTdm2ko5ac7nd4Dy2pk37OkcQOmFRXGy9u29fivY44
 dRWvHsydRdO6Zr0LIBnB16RJXMQ0YudnIBJ18MfHEUOpbCfU2Zq/HJn+NwVlGhDu3DDMR+5IT5I
 HdLVwgq27D8058YPJcYsAHs2z8XGjKWmV+OPQ0l00++qCT87Ja2+voEFxOml/7RUvYo7O7ONo5K
 1XTeBnLPq96K80VTkIBLiz8ls24C/1JVO/T4DcJIJlBU/Xeg9NO3c3am4+9Tqt7W36Xy1cxqmJS
 9LLmwuDdz3HAvE2b3c
X-Google-Smtp-Source: AGHT+IHDd2mcENcS66YRK0QSVLWJrvHxttKuteaRjflMx/bQuzP5QIqrt1wdOMH1V3OvNeLSfL2yxA==
X-Received: by 2002:a05:6000:2486:b0:3e7:4893:f9be with SMTP id
 ffacd0b85a97d-42704d82dfbmr3010770f8f.12.1760715766243; 
 Fri, 17 Oct 2025 08:42:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1284sm40900691f8f.45.2025.10.17.08.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:42:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Claim the Arm XML in gdb-xml
Date: Fri, 17 Oct 2025 16:42:44 +0100
Message-ID: <20251017154244.971608-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Add F: entries to the Arm CPU section to claim the Arm related
XML files in gdb-xml.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I happened to notice while doing the SME2 gdbstub handling
that we didn't have an entry in MAINTAINERS making the
Arm gdb xml files fall under the right section.

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 667acd933c7..3ec14bde6bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -208,6 +208,8 @@ F: hw/cpu/a*mpcore.c
 F: include/hw/cpu/a*mpcore.h
 F: docs/system/target-arm.rst
 F: docs/system/arm/cpu-features.rst
+F: gdb-xml/arm*.xml
+F: gdb-xml/aarch64*.xml
 
 ARM SMMU
 M: Eric Auger <eric.auger@redhat.com>
-- 
2.43.0



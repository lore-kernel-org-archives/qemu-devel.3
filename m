Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C1CC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtqqf-0004p7-UK; Mon, 08 Apr 2024 11:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtqqd-0004ok-DK
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:23:51 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtqqb-0005QJ-Hx
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:23:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41634598125so16167225e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712589827; x=1713194627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=phNSrYesxkyWRk7VmtcEt3Ce0e/wb4i8Epf+f/k3V4M=;
 b=I+7SFUuLRohIFUMsCU9rvT+l9osm2qO0ku95CtI3t2FawA0zkNcs6nuCq7//4B6gq+
 /mURSd0LI/6ab8pcF9qeRedblKmOYs4VXeC1umcSv2iF2SszbfL8au4JoPSsZB/3sps0
 fsSby6PNNsV/LwxV8K2ya+FOs41Z2bZ7UYVaSGa277G7UDjBm1iMXyjwWpnG/0d7+qo8
 pvra9y1wP1rd13NLw/slxQio8dh/PJGlcK6eklHt1LeYPaev4oXAmmPZDJLvgbREl4rn
 SyRVw7fPA1mvdlsjX5k31BRQeWX6V+BSEEfyMXTTDXO/8rUilWH2JjqWeBd9v4v2yffj
 g64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712589827; x=1713194627;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=phNSrYesxkyWRk7VmtcEt3Ce0e/wb4i8Epf+f/k3V4M=;
 b=vx/wY2FLhl1gZcA/orYfMCC1KhI4OO6nDgna6ONjSgiGIFCIWu0zY5pt5oS8Ybof+i
 CkUqk8fJ0EDA2evFRwWtZiApRbqzVlPCmdx4ZmQH5P/J9Zdl+N7JAc8gdpQVaZ/xQlqT
 cQ5rBXy4pxnCfilra+Vbgb5rXdZa6ryB21ife1n+za3Vj+28Vnzb5yA4gaLCCrjJEK/I
 zKZtoUg+o1cNCnjYnQ4qpbjfO80VhUc1Jmtnts3MLmy8Id6WDY7vrgOPXzmbwj40EmRd
 ImqI+a5VD+kt5VcwkVQphAJyGaED/Aui01jB8i4oA34AZe+iyl0fs5/2VTceHA0fAZG3
 ljtA==
X-Gm-Message-State: AOJu0YzAzlHFHrfC7vdkmzmcG4azSHkI/EoEDGv+8DCUYI8DEMqyrMxP
 WfFNtUbGIRaRWX9UvkhdPLvyp3zsbPyHGQWm9iOO0kJAcmlQ5uJdtvvQGi4uiKV5KQ5fbUWvBAq
 8
X-Google-Smtp-Source: AGHT+IEwDCSJiExyxbuozi/pkqW7cI43VolKI5k2kS//crXkYEncZjFhGUGdog81sVxKVld0cV4rBg==
X-Received: by 2002:a05:600c:4f05:b0:416:6d1d:e2 with SMTP id
 l5-20020a05600c4f0500b004166d1d00e2mr2517797wmq.3.1712589827529; 
 Mon, 08 Apr 2024 08:23:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 je6-20020a05600c1f8600b0041496734318sm17298667wmb.24.2024.04.08.08.23.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:23:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] target-arm queue
Date: Mon,  8 Apr 2024 16:23:44 +0100
Message-Id: <20240408152346.3937318-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Two bug fixes for 9.0...

-- PMM

The following changes since commit ce64e6224affb8b4e4b019f76d2950270b391af5:

  Merge tag 'qemu-sparc-20240404' of https://github.com/mcayland/qemu into staging (2024-04-04 15:28:06 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240408

for you to fetch changes up to 19b254e86a900dc5ee332e3ac0baf9c521301abf:

  target/arm: Use correct SecuritySpace for AArch64 AT ops at EL3 (2024-04-08 15:38:53 +0100)

----------------------------------------------------------------
target-arm:
 * Use correct SecuritySpace for AArch64 AT ops at EL3
 * Fix CNTPOFF_EL2 trap to missing EL3

----------------------------------------------------------------
Peter Maydell (1):
      target/arm: Use correct SecuritySpace for AArch64 AT ops at EL3

Pierre-Clément Tosi (1):
      target/arm: Fix CNTPOFF_EL2 trap to missing EL3

 target/arm/helper.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C093C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJOU-0000nc-6P; Wed, 12 Mar 2025 06:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJOI-0000lS-AX
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:32:48 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJOG-00021z-51
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:32:45 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3913cf69784so4585614f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 03:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741775561; x=1742380361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dx6735r0+Y0MpzdLrZZlM/DquZg9mKsAEg2I4Cr9VvU=;
 b=yjG8QZn3HXYSoPDDG5FxPq686CUKWZiWKJgdrf47YpRh6TPfgdBm7/US2wn+N9JsUO
 2Z4pVFkvGwANsalBFwEddsSG8M405Muiq0F4pxavQl+so7CM8JugV7SDKvxAlDIF39Fs
 Ef4gYWtysmRLp0NCnUR/biznLhcU5sOQ2KIb5P/4kt7P5PiCj1wsEU0qH1mGqqldmVsR
 ZdaFZI2uj4JDDkl0BYbqnFEr6lkRLQQ1JLSzt4ZHrvtl3OiLRh07IsVec0FZdfANYzY2
 BLVxPgbYgqteWo3ly9LuUI6wVSR44+WSuKJdKTmoLq/hJGIYuhODNu9JhilUxvHeeaay
 8fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741775561; x=1742380361;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dx6735r0+Y0MpzdLrZZlM/DquZg9mKsAEg2I4Cr9VvU=;
 b=A3S/3uRpNFWIyjJ+wpqUgZARQqk4Rk/xQCFlgtAqje5Y/osBMBEhdqFZ52lMj3Iyq/
 AO0Sol3qHfQTkD2JepJpd1Yd9bXjM+Zy8/EGqoSTiz3fkMbCm2vQwpUH9wsLEZxykVaJ
 tlcLHkwqB6bHerMJabg2n3doG0tboaAQjDMRFYpfEaRSfEZk4ZcWzdbZDvl9C6ZQLXiX
 9JCQyykvjZHinnV6VIcrh2ywYVWAYjde1rlC+toJrPoaV9S57L3yvYNU30DSMzsVD1vT
 223DEkkmYorF8SPKb1qiJNt8Ta8kB7yEa4xmOiGt16HRBrGV3W09mPyYd4tXw8+MwPqw
 bJGw==
X-Gm-Message-State: AOJu0Yw0myVcqsUa+DvmcbX35PtAq2pO4Z/7tXSgPajfLuTCs2Hat49l
 AsuAIipvDn8s8m8l2ZLs02pXKYx/+ObMmp2kLgzuZyJe5d1DyPLzhASuWMcjqrTWROiSHwJvG5U
 b
X-Gm-Gg: ASbGncsuzzWsrxse+Euu9h/QDSmYHcus61MyIZEbYfOvDErjWOTnESJh79eA7oG4tf/
 w//V7WYT1kgMvkYH7hWeUXJlPJEF0NAWtM8qxKvqyWBwgnXdXcJeQlJuSfVTc7Ezp95Hnzc+KUv
 DqNXTcH0/LKrzgsREVLPJZsObp4TLOun43FHxokzgQqdmssXci/aEisuMPcoheE1ZkMtdhnXlj7
 YXWJERQVD+RFE+E+hqtcLNb+PQDdzyjNeIPq0XVQpzNdtsbHRM9F3xVmCf7y/1eFvjjzPGOYlVz
 X2ngpxsH1gdpYQWLhOu+CI25rJlVyCTm2jlW3LaxFAjQAoaIwgbF3n+9dSdQd4siIBin3AXE/8t
 ey0Sbt802Kg8RfQ==
X-Google-Smtp-Source: AGHT+IExyRqByqURg5+Uk9YtRMRwftyfNJ/VFOLca07kmvE//b/49CpDnMPt9PRUA+VHLPwhKc26cA==
X-Received: by 2002:a5d:648f:0:b0:38c:2745:2df3 with SMTP id
 ffacd0b85a97d-39132da24bfmr21401683f8f.37.1741775560935; 
 Wed, 12 Mar 2025 03:32:40 -0700 (PDT)
Received: from localhost.localdomain (99.167.185.81.rev.sfr.net.
 [81.185.167.99]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb79adsm20439498f8f.7.2025.03.12.03.32.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Mar 2025 03:32:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 0/2] target/hexagon: Remove use of MO_TE definition
Date: Wed, 12 Mar 2025 11:32:36 +0100
Message-ID: <20250312103238.99981-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

In order to make QEMU core components endian agnostic,
we need to remove the use of the target-specific MO_TE
definition. For Hexagon it is easy as it is equivalent
of MO_LE, since the target is only little-endian.

Philippe Mathieu-Daudé (2):
  target/hexagon: Explode MO_TExx -> MO_TE | MO_xx
  target/hexagon: Replace MO_TE -> MO_LE

 target/hexagon/macros.h                     | 10 +++++-----
 target/hexagon/genptr.c                     |  8 ++++----
 target/hexagon/idef-parser/parser-helpers.c |  2 +-
 target/hexagon/translate.c                  |  6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.47.1



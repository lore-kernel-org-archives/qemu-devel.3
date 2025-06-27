Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9BEC7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 13:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV90X-00033T-FH; Fri, 27 Jun 2025 09:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uV90U-00031S-GE
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:20:42 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uV90P-0003Es-9L
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:20:42 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b34a71d9208so1570733a12.3
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 06:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1751030434; x=1751635234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VLQ6KyoxykmFFFVS6V2kjxWxXktoWbAOGxAenUnFcF4=;
 b=SiWX+AuI8GnwsJ4K+Wufbr61EX3ALTgw73QNi3Wp2uK9KWYgAoxNSLuG3MrD62tAdF
 VNKE+pZXZaTztJNk8RyvM1s0FQkGoiL4Rt2tTbBAn5gDW4fNd0XQsxi1LqVDd09kzUpc
 hYd1CsuSEaeyRndzUHO51fPKxwjjGscWFoQ4vYf71RBGxgJl80BgI5SdJh7XxcRFRBz+
 379vk8ajo8cLyyIKg0SUlW4sZG0eDI/5NX8JFdvXUvRRp/oVTs7Hc1GOZK7L8gRhEYtQ
 KXouVnZw3saGhbuVTvpW3Osxfd9catsDxnsivQjRtbAciYQ4r0J5mbqFuEPcoGXLuFz+
 CEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751030434; x=1751635234;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VLQ6KyoxykmFFFVS6V2kjxWxXktoWbAOGxAenUnFcF4=;
 b=Zd9dMhNeSd9WW2KQCRSpTSqgTYpVMeEhowzb/y8BWMditUIQkA1fzFCe+OWtiOunlX
 uoALqckQjxAq9xzzAABp+pniA97qmki/IDUWhzCzw9QLWvkHDLEB5PFkBLfTALaWFyWL
 sCQAn+xSisnzmWy9OlM7qPMdZIrbve2lqDAHIByQkvcCvUK0zi/w06W20RSSw3AtPAjX
 FEY8/xjABQkl+NyBjXK71sIU1aE6eMN5D9lGQtCqKgpBYY1hDF+NNB9M5KHBC0W56hbG
 UQX5cx8oCjeRT4badECAClVSdJNufLYqJcELmjLMgHU8fCjey0oQr//xwt1Q9OjG1jeZ
 1Krw==
X-Gm-Message-State: AOJu0YwdAfLC1uPyxGe/IY3Uq01xcgnJGD9ooMpALW9tO/cEIwluRrZ9
 KCbhpVIByh83mb2Yn2FAwOBvqNNY08iSJvrarR9zmJFhxeknZBTVHH/Wr9TElnVbc+s6s2VIhP5
 iC99iutG78Gi0FfzB6V/nTljIZjkY0NVSz5axHsIW/uqjDp+5l9oFC/TSJwIayBWB9lePGgXqSS
 9FkfAFyo75OPhr1gbf6KxHsAMDEyqXt/aukR6WViPrUQ==
X-Gm-Gg: ASbGncvxruBFtt4GdHImsEV1qqoKFPtk9oFqNnr4AWl4u5djUaVj792P7isSYX297AO
 B8JdJwQ7s89Z/DDhiwzxdOGVgZ9OxhCRcRmSd13sidTXq85oW7k5GPnil++2KILHPszldBkGt20
 e5yhEBnY/H1qHRy23zPA3rF9b5gy/fZE+bF4gmrcWle6aQaaSdvbtTHE4uGGDT2BJnB0QT1VRTE
 jAbCsgW8xIYYJLyHQ6nk5hSb3x+15wvMG55zBxI2KgkV6sQm1YEYUb53lOCWgF4IeuyIWuhu6tU
 J29mZPxTyzlGNvCVxq8WwHn65J8YjUgrPx5G+Gsj2tObjBn1QOdXbdxEJ9az+MN+6Owtw2tE5vk
 9E/v28+dbDuplpW0IylvX7DO0DU/6Vec=
X-Google-Smtp-Source: AGHT+IGlkepSLaLCCUAvKEA/XrPATT1hu5+r7vHMziiAAUlSVlD8R5bmaSY6lB4O2RvxCa1RG3oTWw==
X-Received: by 2002:a05:6a20:a108:b0:21f:5598:4c49 with SMTP id
 adf61e73a8af0-220a1251b40mr5902507637.2.1751030434167; 
 Fri, 27 Jun 2025 06:20:34 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af5573e71sm2393162b3a.98.2025.06.27.06.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 06:20:33 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 0/3] Fix some more RVV source overlap issues
Date: Fri, 27 Jun 2025 21:20:19 +0800
Message-ID: <20250627132022.439315-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x535.google.com
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

This patchset is based on the v1 provided by Anoton Blanchard with
following update:

* Add the missing input EEWs checking rule for widen vector reduction
  instruction.

Reference:
* v1: 20250415043207.3512209-1-antonb@tenstorrent.com

Anton Blanchard (3):
  target/riscv: rvv: Apply vext_check_input_eew to vector integer/fp
    compare instructions
  target/riscv: rvv: Apply vext_check_input_eew to vector reduction
    instructions
  target/riscv: vadc and vsbc are vm=0 instructions

 target/riscv/insn32.decode              | 10 +++++-----
 target/riscv/insn_trans/trans_rvv.c.inc | 26 ++++++++++++++-----------
 2 files changed, 20 insertions(+), 16 deletions(-)

-- 
2.43.0



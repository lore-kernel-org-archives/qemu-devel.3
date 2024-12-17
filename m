Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22601E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZG6-0008QL-4S; Tue, 17 Dec 2024 10:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNZG4-0008QC-P5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:13:12 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNZG3-0003Hr-9S
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:13:12 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3862b364538so3154222f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734448388; x=1735053188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nhjwbb2cLaV8+g7K6eWDoGH3jLVsHMMck+CiKHhGFfc=;
 b=LM52cTGC8qksStuY8Sz3CSuxQkOtu76TS2RiLc7Bx+AUT+Te1Cpmy+8ka8Q7AixZlT
 eBPZWehOPk//+GBrQUt8RzzWde17O3ArJElsHaVBXDhgM14QlusbluteYhQwZ7PWK87r
 MlQvQLKMQubkeWBMxpyK6+PrH7zJToQa6lbDgSJ2NKu8tV0Al1pheNeiorZhmbwhRGQ+
 Z77AT0PZhB3sfD9ZloD49urhg2FBeAqppsZEsc+UPpcLqP3ONjQLgNDgi0k6mMniAZmJ
 qgpF9n1lIHbg3xlwPM+sWhn+rhN6s0B8U0X5j3NgfYyIG06S/C/CXj1tmS1aLn9dWaGd
 SEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734448388; x=1735053188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nhjwbb2cLaV8+g7K6eWDoGH3jLVsHMMck+CiKHhGFfc=;
 b=p3EVuawDsnqYiImmS97n9pPB0p4UMUHAAVGb5PDqhoNLTNahC7h5FSY+WrEXoDJ4il
 dNq0JXdw2S0v7Mk1lCVvkZoNClYRjEbtYH+1TW4PNcNrL2F8Sgsf7JPq40ynSR1k4TxE
 tYVe+GCn3QQsHXI079N2Jl5uiObPJo57E8TQtRr2YzVX+DOx+7YecP2evXAgT4VYc9BC
 FRP1s1QJ6tl+saxfBDm9WkQKLjiw21+DbGGKB+TbYffgqZ8+pISGcPnLuf3YS7u6U1Az
 cAxNj7MMxWDYS72PmGXdwVa2T+brdbNKYkg8HInXGH6YXDtC3U+N618FnZKN0JxDe/89
 g4Ng==
X-Gm-Message-State: AOJu0YzgTLKyKxnUohdvPfabC2jeicKTbJY5vPrIDN8cSgchFJhnvl+u
 P3zTjvxwRIUx83OncIZHMVSCmbc4zAxIHHQejHK5VggAJcynNOD8mOHKnKeNb3PCd9ZfifL1z58
 x
X-Gm-Gg: ASbGncvznk2eHBWWSv72VenI3vKqVXY64tisWVbB5/mVWVSBnkfrTfnuh8pMk3FeOQF
 GPYJnhSe0FceGyj9pKJ6QrYRu77rZx0M6LeY2G3m76WAMZE2TgzMQEInPIP/bETOHMX2+5pzYcH
 1LBKpK/Fl8lm/sIy9Ih+A/h1lxhEKozoZzbSgmQf8PiyzYZRd/2kfXDLxTx8CM0xTtevrC3euUe
 /AIbu1nkLAFx1NEv7lcT0/WtTX1N0pNUSdk2ovlle+NWFiRX5tq/+pFBzOrzN0Bwz5+fFMzxSeQ
 +fmg
X-Google-Smtp-Source: AGHT+IGhZvwcrecH/l3tzZxp/9lmRQKKnuH2G+g15sJ2oF8K5YoB0LcEYki3ScgNkajyj1I0/t17Gw==
X-Received: by 2002:adf:e0c6:0:b0:385:fa30:4f87 with SMTP id
 ffacd0b85a97d-388daf909b5mr3090065f8f.0.1734448387783; 
 Tue, 17 Dec 2024 07:13:07 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060582sm11225037f8f.93.2024.12.17.07.13.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Dec 2024 07:13:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Anton Johansson <anjo@rev.ng>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org
Subject: [PATCH 0/3] include: Cleanups around 'exec/cpu-common.h' header
Date: Tue, 17 Dec 2024 16:13:02 +0100
Message-ID: <20241217151305.29196-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Do not include "exec/cpu-common.h" when we don't need it.

(I plan to merge this series myself).

Philippe Mathieu-Daudé (3):
  hw/xen: Remove unnecessary 'exec/cpu-common.h' header
  system/numa: Remove unnecessary 'exec/cpu-common.h' header
  system/accel-ops: Remove unnecessary 'exec/cpu-common.h' header

 include/hw/xen/xen.h       | 2 --
 include/sysemu/accel-ops.h | 2 +-
 include/sysemu/numa.h      | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

-- 
2.45.2



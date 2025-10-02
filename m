Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF74DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4OWi-0006mD-Iz; Thu, 02 Oct 2025 14:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4OWe-0006lb-D7
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:59:37 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4OWN-0004Ry-SS
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:59:36 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-27d3540a43fso12513325ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759431551; x=1760036351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rb+uTkpC4v1xiKTcsQSyCoWatFkegGz4XMRmDBJH9tA=;
 b=sX4MCM4RHwaE2MxzYK7fxuzqGvO4KfnTquwW20yE+sO7ueoVxoaf4/fR5tK39GuN1m
 /q+2QjpMSIRoC9zEsFzu7P6uuwkxleGPtrgNwL7lecSiZWYlNec0dEZzJ9dfNmeF6aWH
 iceMDsHXPzDMpfSouXOX42TZDNBaKT1UWODD1yb4vuH49WfE4LNWiMUbW0+jXDevEf+W
 KV5Xf+NvPuXs9cBxulSiYxzzby3ak6DMnTKhqbhED/p/QkSxu/qpObir3JhNRV0MdCF8
 AYxqCCNkPlC3JjwGLapu53luVWd+e/6w6k90youNFlZxVE3hqLu6g5RUuuKQ37LNa3dV
 x8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759431551; x=1760036351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rb+uTkpC4v1xiKTcsQSyCoWatFkegGz4XMRmDBJH9tA=;
 b=ILJQ6D27O7k4fv/fZ9HdOAwpJGHqqbgKpbirD/HkjN+qWgIHu2iukKPzn6EzJBsVKU
 mmMODJTZ14HWT4q6jbkqPvi9zIHzDVOgBoGV6Y9XX4Xux5SjLNhthUsktruT8+ZA6Nsg
 Qtat1BBJkxTYdW+KZ0CnRYdMps0uiMugezzh5m81Wj08Nu8vgSqrs0C+HCDZE3eMkscD
 XEWLabO6QA/qTLqm7UOAWavwsKRgGqYdU2yUuy+Iuh05WDN2FXqA339FULCHleaWd6Y0
 W4aKn0ybNY2X/Ym8l8hb4dSb0RrtND1X7u2L/e+J64NSLgy2Xm5ko7KHaTw3DDoB2LFg
 bYag==
X-Gm-Message-State: AOJu0YxY7xW2+j8hDjkSaE5aw3pRiENtFdxQSCeuZihLUtxWRiCyovey
 /e7x+I/DWZ5tg+kdLlNr6iIz3Lbh2vAitY1QJDb56M8g9AX/OJowIjBasmT6FMAAxH0+CWpBvIS
 dMdMETjY=
X-Gm-Gg: ASbGncuj4rFAr6J6kUHCAx4hOR3lB+4asQn2JSXL/AEkxWMaK2iC7bSuLobypyX+dWX
 V9pePFX6GGDr4mFYfRmqJrLqSLpFuw7ijOiguloyCkYOwHrvGmLuys4fmCLJ6wVVAtpi9PuS5Mg
 Pk6tzKSy0jfR1ksAdC4jWHAbS3XLiqlFYwcjreARG30O25bbzoIOy41hS02Q0toVs+/NEW6xmDe
 dyVsntFG0uZa1Pkjyg+oj3cT1M5LCMn9ICw5aKPWHMN5NPxrxE39VHmgSkvqBNNPJEPEb9WQcZy
 KXGmqPkaQ8e3rKw6YBOQ+6OPrq2Sen+NpUrQ+XbwM9YyW1oAGA7U0/rPkKx9OjK7/iyRAipJ6OP
 FsXhzUvfASSsO/XoVd1i+2BickXHLpb/IUFBuyinFOSo7bni7NhdN8plB9VsW8tRsm0o=
X-Google-Smtp-Source: AGHT+IFYrZOtZsU2u/Beqmlg7UuuIOj7JSi8x7dNjCRy6pEr+ghlsNk7oEqh2Boe9BgfQoZTy7ay+g==
X-Received: by 2002:a17:903:3c70:b0:269:ae5a:e32b with SMTP id
 d9443c01a7336-28e9a5668e1mr3892505ad.13.1759431551542; 
 Thu, 02 Oct 2025 11:59:11 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d31c8sm28047335ad.95.2025.10.02.11.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 11:59:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
Subject: [PATCH 0/2] FEAT_GCS firmware update for test_rme_*
Date: Thu,  2 Oct 2025 11:59:07 -0700
Message-ID: <20251002185910.584990-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Pierrick,

Here's what I need to run our RME test with FEAT_GCS enabled,
based on your

  https://github.com/pbo-linaro/qemu-linux-stack rme_release

If your can run what's needed to update the functional artifacts,
I can re-spin my FEAT_GCS series with that included.

Thanks,


r~


Richard Henderson (2):
  Update tf-rmm to support FEAT_S1PIE
  Enable firmware support for PIE and GCS

 build_arm_trusted_firmware.sh                 |  1 +
 build_tf_rmm.sh                               | 10 ++---
 ...arm-trusted-firmware-support-PIE-GCS.patch | 30 +++++++++++++
 patches/rmm-support-lower-pmu-versions.patch  | 44 -------------------
 4 files changed, 36 insertions(+), 49 deletions(-)
 create mode 100644 patches/arm-trusted-firmware-support-PIE-GCS.patch
 delete mode 100644 patches/rmm-support-lower-pmu-versions.patch

-- 
2.43.0



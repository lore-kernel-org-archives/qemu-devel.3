Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62415C3ABB0
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 22:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyVk-0000vW-BD; Fri, 02 May 2025 18:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyVh-0000v3-D3
 for qemu-devel@nongnu.org; Fri, 02 May 2025 18:05:33 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyVf-0003oc-Nc
 for qemu-devel@nongnu.org; Fri, 02 May 2025 18:05:33 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e5e8274a74so3874150a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746223527; x=1746828327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IsMUYnogdmL7s+3MaC0hOHrKPErOWAovTUQEl/M2OxY=;
 b=NwmaquY73U+N26+tvn+4WDcTpX9AQLH3YkOAxLO3VlmrLbO8sF1S2RgoVbt4VdoVd3
 f8aEa6FegZNJV6sawXyLgmBSTVo/9N2kX/f1oHXQcV2lulNMrbSpbS7vYGCnWIqregAT
 Pbo5cLtvx5syAKCtxFxVzkQdVZfxd9BrVKVT3J3LwTPdqVtTC06cPs4jQhfx3QOgrLEo
 zwBiLeiLm4ZISq1ur1vDTKUu26ILCf7bDJVc29PSiSGlkpzrYSKpygnwvCoBiarMITer
 Mp+ldPhfnhaCar0XaXEMZ+tkyRgdblZlZlIe+1hleLfE/PZ1z9N4l0z7pXG1b+fofDyc
 xZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746223527; x=1746828327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IsMUYnogdmL7s+3MaC0hOHrKPErOWAovTUQEl/M2OxY=;
 b=RgCoNF6thCyhtncPKaP0EV3mwAhOoNjtkOM1GiH01rIHXvWDw6ownDdHxe82+3/kCa
 ZQosAgoHqasduA7ZOsp/BR9a8Fqg2D3mm18nCWSA+JlvER7sfyw4rbtJSlsEk7nFIIHe
 YSJSOss2f8ScqBB46mE9mzSn6mcmH9coFru8hXhHJ7U7t97HC50Bws84evu8MsmwgwDa
 PCx0W66yZt1jNpEdCdvlkWYgweoEVG2RT3rrsuFIZz88cz5N8+P1NuRptW5Nj+8LpdP+
 3uXoaPz0OuTWoxFrGgeDARn1J24+NGs0VTmPyHq3niWvoVOGsWtzgeHAIweTl2dpznv8
 8MsA==
X-Gm-Message-State: AOJu0YzHLgkiPJKcD2D9Gb8sLrLVbQZu1ZiM2VP1pz+iTJeRSA5equqb
 MBZSzXrV1bXYwrqx2D/svUQlXXCStlX7V4644G6NzD/HfYaaMfcBMpo1eznosdJO0Ds8cRtfGjJ
 r
X-Gm-Gg: ASbGncsQEqibdlpj3qG/3uKtiHveMw766vw/255Arf6Zp9AUdyRzARYHaXDRXu8cXnt
 p5FBRbF081er32idIKyrtCgocSqYIYA4owOfgo73ivjtBSsS4auR8GhlHp00n3e0xbUd64Rr1wD
 VObVc8gs4Omtw77HnUMarSdNzDUtrXrKyhSBOMgsT6/jNtJ9q2uSfOxsYzECCqOTzs9ocjqrOdh
 LiLLf9MYIP+FP/chXiR66omWvpvAsfLsb+4/7tfCXjooLs/yCo9qEsj4GdKdsVNAq1C7pr6r7VV
 xxo8ZfkEUKH7NqdksCjQW1m2W9L94/TTAktnVxDxgZ6O3LnTA8FLMovLIxQRqggcK94EQZ/Nu82
 gAAThQb3d0pZobsqXXmnQH613JQ==
X-Google-Smtp-Source: AGHT+IHrPh1jlMPCajWtQ7bclKNvl4utfQvmg7Xa2OTgjC5MJ3YaDXYHJG3rLdzDP0H9Trt/zQsFIQ==
X-Received: by 2002:a05:6402:35c5:b0:5f8:e07c:7746 with SMTP id
 4fb4d7f45d1cf-5fa77d4e286mr3743187a12.0.1746223527586; 
 Fri, 02 May 2025 15:05:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa7775cb74sm1789030a12.1.2025.05.02.15.05.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 15:05:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] semihosting/uaccess: Compile once
Date: Sat,  3 May 2025 00:05:22 +0200
Message-ID: <20250502220524.81548-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

Replace target_ulong -> vaddr/size_t to compile once.

Philippe Mathieu-Daudé (2):
  semihosting/uaccess: Remove uses of target_ulong type
  semihosting/uaccess: Compile once

 include/semihosting/uaccess.h | 12 ++++++------
 semihosting/uaccess.c         | 10 +++++-----
 semihosting/meson.build       |  4 +---
 3 files changed, 12 insertions(+), 14 deletions(-)

-- 
2.47.1



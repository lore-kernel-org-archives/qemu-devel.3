Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791FCCA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 17:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqxoA-0007dg-JE; Tue, 26 Aug 2025 13:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqxo7-0007dG-L6
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 13:50:09 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqxo5-0007ID-3m
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 13:50:07 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45a1b05ac1eso32316645e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756230598; x=1756835398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZR/RUH7irZ6A1UiT0VeZJ2PP4cGJptOqXwQzMuavR84=;
 b=RBRs9wfpfxdMlQ5tQro2GylQypWIdmij8gnMgyZXIT77FU+GuqyFEdQ15W2BSGXuZW
 lkZoJzKDt1biAd4them2xOtHJiwtBNGq3dR7QUjRqcoe9acqS9555PHIJB6ks/XeSrTb
 5aL4hRG+OKf4SOZANpVe3MDWsm/1vUBMYk5A2MtQ9BeEiv+vak7c30zhOX6RNdCiZq0Y
 kaXpeFpzx0g2riYQ8o+b3rXJGNpaWdiXOJBj2/FrvpyGw3q3LFR9IA0Wwr24DCQyEH5I
 5FpPm/a33W/5WBGtsI+vRAl4mIbNZGQN95REQnR9HNhLHYuF+226mPnFYsMnLXALnboF
 XT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756230598; x=1756835398;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZR/RUH7irZ6A1UiT0VeZJ2PP4cGJptOqXwQzMuavR84=;
 b=SBEq5GdG44mCch+uQqKQOXGT84h0gLokWUckzLSBj1ksV6NBieOZmES+FflUZLt4aO
 jMhbASKIUrEHd6+Y3EPlDDS1Viyc8OkQ7D1ztANU408gHqRCPKkGM+okr0jDsHGOzpEq
 7qZc1jkQYD24nQmSkubPhqoCqHTE+LIr01XKiLL/sDSIZA+mpVFGytwE2Uy4nRp7boW1
 mTIvp5becolJGjRmf5DP4R5UFv8uJskh8PdQTPNMLCHEMKPfNTKqcDqUK36wO26Ije4x
 O7BL3Ff7KbRyyfAARNfrFcaPTy+F2Wmoo457Z3uIRKjhCgns3O0o8XUoP1jebiarArJX
 vDeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxlkLP0zGDRfiUnba9aYpCDtu7HP98MgipSJlhf/vMwS37lEgp4Jal/fsmyUmdy+kV6VOBf97b8njX@nongnu.org
X-Gm-Message-State: AOJu0YwKRGBg5/ARSHqSU9/YVC7cAUu156YwZk8uZYWdmHi3XbxAQMBo
 xKpNHJFaJiplKdJDAObUi28sj1GkQOhPWXc/eCS99M497U7hbbF5W2l7E0DV5owil9w=
X-Gm-Gg: ASbGncsA2j4ZIqcs9kU3RqfFppahm+uPAOZIlueI3YwtDZDgFHVs63X56rfk13trC3I
 Okn7MXZNGuPDeOPOVwe1bbZWTnkHm7/YYFu4YF+d7VbceZMzPXH3Otcj6xQWv+cs3WSfBOktx0D
 qiuDIZJqhPFGCF5pHXo4RYpsAexlB9BR55pTfsqHgcyaIyWneTk/9fwUo7n2XUXOWhXVOJxuoki
 p25scH2hxeyKR/0DMH8Xo0P3AChnDpgzrS381Cs/6yTksA9QtvueR2+sH478ddVNfSUzOgp+g9A
 sVldFRHouvPwu4HpoqnTQSBi4Nx88Eij7ITJb402lOzhPGTRK3Q/Ssrxx8PhZ0alkQ0dVuWvX/H
 NIbW/n9itd2Wy904QnadQV5JKlC4TPMWsUC3JCK8=
X-Google-Smtp-Source: AGHT+IEbP3Rx/b48mBVvzwN1uckzNsWH1kGq3/1OhcH78QB9OacwBFE1ArCegs10pus07ZYVDJQMjA==
X-Received: by 2002:a05:600c:5251:b0:459:df07:6da4 with SMTP id
 5b1f17b1804b1-45b5179cc97mr137309045e9.5.1756230598512; 
 Tue, 26 Aug 2025 10:49:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6c5356a7sm2593435e9.15.2025.08.26.10.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 10:49:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH 0/2] hw: fix some leaks in xlnx devices
Date: Tue, 26 Aug 2025 18:49:54 +0100
Message-ID: <20250826174956.3010274-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

These patches fix some minor leaks in xlnx devices detected
by running 'make check' under ASAN.

thanks
-- PMM

Peter Maydell (2):
  hw/misc/xlnx-versal-cframe-reg: Free FIFO, g_tree on deinit
  hw/display/xlnx_dp: Don't leak dpcd and edid objects

 hw/display/xlnx_dp.c             | 10 +++++++---
 hw/misc/xlnx-versal-cframe-reg.c |  9 +++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.43.0



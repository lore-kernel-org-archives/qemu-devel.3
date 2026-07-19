Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380DEC44512
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 17:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlVdc-0000dT-HJ; Sun, 19 Jul 2026 13:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wlVdZ-0000dB-B1
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 13:49:13 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wlVdX-0003BO-Kt
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 13:49:13 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so103364755ad.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784483349; x=1785088149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jvhwrz3QUtBdJbahnB86ovvH4HEqE5WZvjP++ZS8f1c=;
 b=ELRL1CScQA5YOnLJAVs8AkByw6L7c/6ySWSzhbr2OJDQ7KXOWytZWxKPbU35FjSlVD
 k6LnKmfThErcZJqEjIudukP8vZxKbJ5qh/dmGzx7qSHRev4v3q0CGgbpTP1xrHrH9nW3
 HczD2mJ6ar7omMdYGk6/GTckuRvbz70zuYNrrDFNaRhVkVMdVCp8Im+2TfwImw5GawlS
 qC9OwzRF7H/m6g/gXs/XPY/tzmFJRfkbiHoCHM6dyNQMkMssmFy2NQlMhGi1drFPiRb+
 mxZo7cPxt6sEdv70gKwhH5f6zho8lZBxx9f3FUL7xiDprkpepr6e+bPHLcc8NirR4ytc
 4PJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784483349; x=1785088149;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jvhwrz3QUtBdJbahnB86ovvH4HEqE5WZvjP++ZS8f1c=;
 b=oYZf0VDc7jDYq729DANaaUJ/3GUZta41MqIPx50I9uttTrH1W3iOmGX701MPaUcMwZ
 qTCiJfA9wxIC8XUlvlE2YMxLxpX4gKEnQ8+zMR6ssZXCSvLiv0Tzpo+R7FjJrlU75AX3
 0hVddzm0GfpoAu6OYJvGQZVJNgqkDcf9Ec0JS98av3DMGAMkFubBuVTJBAe/SY8S6SCI
 RFYbeq7YQRdgV2j4jjI/DtPspbx7lFC2u7FM3YuaYqUxkLl/jTioHg07R9Tvv/pNCFNu
 +oAQ0ZB2bV/5QtBlW9/6JfDsiGQmBTjvfhcIjBsfp8DX57eg3swTLpe8Avq/iWWt5bLT
 nEpw==
X-Gm-Message-State: AOJu0Ywe4ce4Dx7cgLIORjHwlmrySW6QOfh0ldQh8x3GFKqyLiWyBV1h
 sZknkNat6L/kLn2oWDmQbNHDjDCadfD4MZg5m20LLpmNJxdZEz3wkxoTRfP3ABX2tzXWssQiqXb
 t4UjO
X-Gm-Gg: AfdE7cnL1HXptaBVn8RYh1RMMtz1IMXtxZo8vZ6GVRxmwYyBtYG1WBAXSkIEULiKUdX
 ZK6NUSqeO3ZlnoEXsXpqEuEpJgvGHHtZljL5+aE5Ux68HfQjc9XAs+8N4YlJjP1XjVRNEi1oCBM
 hn5MKBbwxZeu7NojzzeOC8SNydFoHngfchV8AF+OUeiLjdaYQIP2EWWL7HHHN4KoYlsmLgGyP5A
 B2bS3caGIRY3IWCgJfTV+3lyiSF/LevMI/+QuaUbl2ogQ41z+XYWbXmiBPNc/gvHC2adNszkHBA
 5v3Q377yCfBG0ekZZJUfiJVZCUj+Pwfsvo1WbS0nh45j0EnH9tFYQKCatdIsue3Yqpvc4p2Vok+
 sGaMch7gcvAW0kIN4GnCfgFZ8kJjpVIDcSc5JJzTteABct985lMmHeo29cbwVO1ogMTvQhKBr7Z
 eJyHyAhsP/RE0xw1vyBA==
X-Received: by 2002:a05:6a21:7d06:b0:3c0:e552:f2d with SMTP id
 adf61e73a8af0-3c3ad859f3cmr12101775637.34.1784483349353; 
 Sun, 19 Jul 2026 10:49:09 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a20c158sm30471881eec.29.2026.07.19.10.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 10:49:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH for-11.2 0/6] target/arm: Implement FEAT_SME2p2
Date: Sun, 19 Jul 2026 10:48:59 -0700
Message-ID: <20260719174905.420725-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Based-on: 20260713230244.70174-1-richard.henderson@linaro.org
("[PATCH for-11.2 00/10] target/arm: Implement FEAT_SME_TMOP")

One final pair of insns, FMUL (multiple and single vectors) and
FMUL (multiple vectors), which are not covered by a sub-feature.

Finishing SME2p2 allows us to finally enable SVE2p2 in -cpu max.


r~


Richard Henderson (6):
  target/arm: Split zdn in do_z2z_n1 and do_z2z_n1_fpst
  target/arm: Split zdn in do_z2z_nn and do_z2z_nn_fpst
  target/arm: Fix b16b16 feature test for SME2 BFCLAMP, BFMAX, BFMIN
  target/arm: Split decode of BFloat SME FMAX/FMIN
  target/arm: Implement FMUL (multiple/multiple and single vectors)
  target/arm: Enable FEAT_SVE2p2 and FEAT_SME2p2 for -cpu max

 target/arm/cpu-features.h      |   5 +
 linux-user/aarch64/elfload.c   |   2 +
 target/arm/tcg/cpu64.c         |   5 +-
 target/arm/tcg/translate-sme.c | 180 ++++++++++++++++++---------------
 docs/system/arm/emulation.rst  |   2 +
 target/arm/tcg/sme.decode      | 118 ++++++++++++++++-----
 6 files changed, 201 insertions(+), 111 deletions(-)

-- 
2.43.0



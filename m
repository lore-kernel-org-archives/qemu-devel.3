Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143E7C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucpCQ-0005m9-6d; Fri, 18 Jul 2025 13:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucouu-0004xo-Fu
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:40 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucour-0000pm-7d
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:40 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ab112dea41so1396993f8f.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 10:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752859835; x=1753464635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jvx8i4URe9B1o91t3gt7armpMc3qpa3OmgcI+KegyPM=;
 b=h7ROZCJvXpq98ltNxRqt3hvFubyP0qkvvU2jG1IyJDmyEK6HWOCO6YTcCKeLUO7vCZ
 8MlCKXHlz+36S8R6gcEl8VHGQ2g3XNWWMOPlZEvbmw17hsPj+hLFeFIO1V19TlJJ/GXu
 u8zXqDrV9NBjAZJdDCsnmSDVEUuLrrbhSKgWQNnjrMEOuS94FQCt5hNiXwZ1HofSX64N
 Pd2R1xk19kdgrMhFZ79hz71+qjcPcnE0uY34vNquHNszRzrCbccaHmcpIgEFqpko8Gbm
 o7ZWz9cnPVH2Lbwm3UUS7VjSY79yk/kDHxpYNCqkRCEumQN8ZwnthaRjxUn1g32WwIE4
 Y/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752859835; x=1753464635;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jvx8i4URe9B1o91t3gt7armpMc3qpa3OmgcI+KegyPM=;
 b=oqKvYjzO39uRnIHq/5tBX3bVsSuaaxNuDo91c2kdOZ7JJ5QyuYTX0A5N/AVQl8f9XW
 MR71cotvVV9nsq+f+sreYxO6bpD6cSPYH3l92Sl+EXu+zBzJz8hnN+H5QeXY4EwLMF/Q
 Lqw9qFSKXUPyCqVk5VKxXHBEHkdeOjCVNlSzKd8/Z5h+ZzHFyKrSCGHHUyBq7DBcgQKj
 1aUcMaNLIhM74jKxGsS+JoTfteuYV51tMxm0O2+qy3O7OBuUr6K0FR5KKI10Al1isVwh
 0C641njs6nYZzT4fmGyeuLZLPlmshU6SsnGeww/eRjjlz0ew8V3W8bgOPKHz4EDPAlo0
 i7MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF8Toos04P9heDRDFB7kQvak3e9qOzV50ySLnyGYRfhKwCxvQE220qw5xHF19/g8coYGsAgNA/33TL@nongnu.org
X-Gm-Message-State: AOJu0Yw5Y9zs1EmhG4MDANIumemvvxxWvoZj+JEbZTiYK0u2TFTCdV9L
 nHQQ36sRkiKYV+g7GdfoZ58Vr0bSab6Fbylk2XN/zmFqhxynzV21m1Ysq2cWDEZFymdZi8bGAQI
 32oNd
X-Gm-Gg: ASbGncvIFI1MAbdkfQFEzjs2YvpncaaIIKfgCbDMvWNGUGfgU7XUr+YNPnzZUtZjT1J
 ABpwd8j5++6n1/jtEkfbjAN2XDwOEAiip/7Bn1UkbUnDdTyS1ChWY4rBq0jDtGEL3jS5PHU0U9J
 jP4bo6ajUKLoFTncVuRpgQTQyNHBpghPyIRkOVmsC92hxV3u16yvf4y6zwqhjS2sMNcmqEjaSXo
 FXuKM8cXYj5N5viI75eSp9snsdYGBuarIF1z68GiqPbxNbfTxmhFTBISpysD9VCjKKNKvPMdsCR
 DXuQY5m0M083V+PLRLxfBU/fpSx2ZGOvknLir6+iB3WnwW5KrGc46R7ADhIaS4JIenaiH1/QHwb
 //4GX+IYbG06e9IfMaqMp3RKOFZiH
X-Google-Smtp-Source: AGHT+IF9Bzs+4dM5zZaO8+U/YoTXmgKcN7TA/KmmxGD9ceY+twOMHQsDo/zpw7xZ3uQWbeWF7q08Tg==
X-Received: by 2002:a5d:64e8:0:b0:3a0:7d27:f076 with SMTP id
 ffacd0b85a97d-3b60dd651d2mr9312420f8f.2.1752859834879; 
 Fri, 18 Jul 2025 10:30:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca25443sm2454655f8f.9.2025.07.18.10.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 10:30:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-10.1 00/10] target/arm: Some SVE2p1 fixes
Date: Fri, 18 Jul 2025 18:30:22 +0100
Message-ID: <20250718173032.2498900-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

This patchset fixes some problems with the recently landed SVE2p1
feature. Notably, we missed out several bfloat16 insns entirely...
This patchset adds in the missing insns, and also fixes some
bugs in the FMAXQV etc insns, and an incorrect assertion in LD1Q.

I know this is slightly pushing the boundary of what counts as a
bugfix for 10.1, but it would be much more disruptive to try to unwind
the SVE2p1/SME2p1/SME2 features, and these are fixing the bug that we
UNDEF when we should not :-). I've set the Fixes: tag to point at the
commit where we enabled an accidentally incomplete FEAT_SVE_B16B16.

thanks
-- PMM

Peter Maydell (10):
  target/arm: Add BFADD, BFSUB, BFMUL (unpredicated)
  target/arm: Add BFADD, BFSUB, BFMUL, BFMAXNM, BFMINNM (predicated)
  target/arm: Add BFMIN, BFMAX (predicated)
  target/arm: Add BFMUL (indexed)
  target/arm: Add BFMLA, BFMLS (vectors)
  target/arm: Add BFMLA, BFMLS (indexed)
  target/arm: Correct sense of FPCR.AH test for FMAXQV and FMINQV
  target/arm: Don't nest H() macro calls in SVE DO_REDUCE
  target/arm: Honour FPCR.AH=1 default NaN value in FMAXNMQV, FMINNMQV
  target/arm: Make LD1Q decode and trans fn agree about a->u

 target/arm/tcg/helper-sve.h    |  32 ++++++++++
 target/arm/tcg/helper.h        |   5 ++
 target/arm/tcg/sve.decode      |   5 +-
 target/arm/tcg/sve_helper.c    | 109 +++++++++++++++++++++++++++++----
 target/arm/tcg/translate-sve.c |  97 +++++++++++++++++++++--------
 target/arm/tcg/vec_helper.c    |   4 ++
 6 files changed, 212 insertions(+), 40 deletions(-)

-- 
2.43.0



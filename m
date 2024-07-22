Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06B0C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 17:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVwrZ-0000GI-8w; Mon, 22 Jul 2024 13:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVwrX-00006j-1e
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:30:15 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVwrP-0006Na-QE
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:30:13 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-36868fcb919so2104079f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721669399; x=1722274199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0IYVJwzndaDSJ9XKQ8Yqnodig6ux9hujWPo87DcTHs=;
 b=uM/4phOgdWoLiHV2KvSojmayb7tYpzOvCsVUC46MZm8AeOugvwQuqoUp9O69iPMekZ
 PhBvkevDgKt9th/9OBqgL0e+HFG0KEgb3LdCUgMmo6Mtq+CpUVJn1Qhfl/HV9aWroSZe
 0gI1MOlNGwcRIhbWjNXUt7uzng9i7ScAqzovGE+Mqk4rwdUn/pGmWsyTCOsW6DPK5F1J
 ZAF5WXpeHPUjuLIVCWsvRwqn2bXCrHwz9kN59BrH1CBWm/KPjZDY1DL5W6Dut87wOTB3
 9BUE1WC9wgRFXDe9hoBt+JfleCmVqE6wrENVshZe3+P3oBrlz8Ne1ohjmhPEu5yb6b0G
 chJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721669399; x=1722274199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z0IYVJwzndaDSJ9XKQ8Yqnodig6ux9hujWPo87DcTHs=;
 b=KwxYnVmBxcJgrE4Jwdr5hjvNyohlWEYB4p1YbOCXjZZqUWUOF6IRHIuknANd8fkUY4
 tWQHjTOA1ToAfwQ6LzJjKWV29Ca83nxbtyYQc5TA/GQvxjMPS5N1KvdyuHqBPLbIl5Pt
 9TgVu2J45l8QCfF3FkafC5Ua2De4LCtiplRn1Pr0luhC3rPV7h3KIHFSzaSeGzxv1Lds
 27a2wEaMrCVf5RUjEwEW/1QhMVWFeuqIeycbTFeIeqEYcImKefM1X3UHVomWc+rn+X1U
 F6w6jx7/q9jmLsDke6b2UdXc7Crro/9drMhVMlq3tW3dPsJSd2REgnidTfTWhv+kOSSH
 HGQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB+p4OkehMTO7j0PSR7PEBTFmft/Zpx5hbnd9zJqlFxoZ1MM6SNaTFvJIUqTMhRbyt2Rov0mbQrfi+pIS+hiaFvMb1bjU=
X-Gm-Message-State: AOJu0YzxbsneGWeVDWJ6S32zqC07tiOSRMnwNsO1+tPddP9vhBVVcL5Q
 urOcZP+3dKZL2y510hbCJ0WUr+9ieNvZZQlKz69hBu4/5SF/Owm0+7U6Zhy/jd4=
X-Google-Smtp-Source: AGHT+IEIPKpT8AEH10ZkMZJE9G4zUG0vmvp/Vm28YhfFFZmDFEnD06hXswkyKGch4akA0hTDqJTXPg==
X-Received: by 2002:a5d:6dcd:0:b0:367:98e6:362b with SMTP id
 ffacd0b85a97d-369dee57a0fmr369138f8f.42.1721669399308; 
 Mon, 22 Jul 2024 10:29:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa493sm138035665e9.10.2024.07.22.10.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:29:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 0/4] target/arm: Various minor SME bugfixes
Date: Mon, 22 Jul 2024 18:29:53 +0100
Message-Id: <20240722172957.1041231-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

This patchset fixes a handful of minor bugs in our SME implementation:
one spotted by Coverity, one raised as a Gitlab issue, and a couple
that I just noticed in passing while I was working with the code.

thanks
-- PMM

Peter Maydell (4):
  target/arm: Don't assert for 128-bit tile accesses when SVL is 128
  target/arm: Fix UMOPA/UMOPS of 16-bit values
  target/arm: Avoid shifts by -1 in tszimm_shr() and tszimm_shl()
  target/arm: Ignore SMCR_EL2.LEN and SVCR_EL2.LEN if EL2 is not enabled

 target/arm/helper.c            |  2 +-
 target/arm/tcg/sme_helper.c    |  8 ++++----
 target/arm/tcg/translate-sme.c | 10 +++++++++-
 target/arm/tcg/translate-sve.c | 18 ++++++++++++++++--
 4 files changed, 30 insertions(+), 8 deletions(-)

-- 
2.34.1



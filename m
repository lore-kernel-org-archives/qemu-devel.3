Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0396CE77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRZ1-0006fT-IC; Wed, 24 Dec 2025 11:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRYz-0006ew-A4
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:18:13 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRYx-0002Al-Nd
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:18:13 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-477632b0621so38311395e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593090; x=1767197890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m8mMgVc11pYrsHLl0g2yJzZBjiwVbSsCNzGfkR+dMbM=;
 b=LkY3MzzkCCJ83II4WdQ8qk++PPfPR+/yzfEs0IIn5N9zwX7On5ElM13jv+Ebr3+nnC
 l/Ujgrxuy0DHtwABKcdx1+A/AMV/HQXX83SyYD46vJiuIc80SxhRj6SS8V1Co+q8ZuzS
 c5g0R9GGrz07cv3ABpJcPgxjdTA4It7jv+ijrJrHOibh7WFRAiteu+VV85IRhrxAEdur
 plf3gCYavvKueYkWG4cFiBUwffineX13m5lfgwHMppFXSbidTEUM85RG0xcqRgvKM+U9
 bU5rpkoX0YHLi3F55+cel//BZGmD6Tqd3vyVJjghkmksnRKF7E8xTOK40gmGQehXFdtF
 D5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593090; x=1767197890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8mMgVc11pYrsHLl0g2yJzZBjiwVbSsCNzGfkR+dMbM=;
 b=lbPLS7Ff5DZqeKPnef0rn/QJ2im1edv3G1IVIhPTSCtMOWVMW8wjKCmMqrHT+HE1e1
 2D60ncOYrsOzQZMwNg0wyRPNzc5PxVfBr+SyzyYbJ1VVwkKvwMvzhNaMQ2b9NIGvVzzB
 6aw17Nkn6QMceUtg2oY+EZBVTxiPFUzmVgfij8Pzqgn1Ns7Q9S4OlFYa2JC61lk26ylz
 N/UByutHcQoRo0t5QqK9hg61ehi65pEcpVO3+YkEq7z2z+tHp1mgwmvJt+1qamlseIYE
 qGsEseREM7RkowLadjXsMuy60ABDoDlXodPxrpysSILm2kJnoH6kiC66jCgBVfJyInZR
 2Eow==
X-Gm-Message-State: AOJu0Yy0pAmK4mZY4XJRfLnQK+djD8Cdz9XbTnT07r4oK/AdrTARHY7X
 XC7Xu9Kl83AN8vngeX1ydSIZYJCohW75EGwuA6JjxTXweXT7OmsPCLZV7i9GrUtG1SdcAlx02OP
 0ampgRRs=
X-Gm-Gg: AY/fxX4iRb7eA9TLZtNzNdlBODA0PpI7D1QP1EwEaN3blr1MwXvqlJXqLne+Q1Rzo0u
 wVeU3HEcOChKC9P/akG/iB8lJIdub/tegvAdJg72De7ZhCngJ9cRuUp+IfKN7OLDFVzyvjB6wD3
 Yn6/Def/UQmjTIB+hdpbjkMoc//XK7JDFG1EcxvtfiRHcmIAqxZL92DB8+z1yOEQt4N+CHKBvYA
 dZvs7KD88yap/LKrB1L9+56DUudu6Q4mN6NsWvzMGIR/q+eDhmI1rGZmEYWUsYSyJ3p2RE0B6jJ
 Jckzjxj/DRrxEoyCxnI+BhNVvG4j5JpYasFomeRxSVqisfR1O6rr17ymMiZPGUcCksVBAR/P1Ca
 ek4yLiX7bCYliIzqDPYn+1E3P/mnAhX3NXcJzUln8wgjkYQMnQgEQqEKNHfl0GoVaskk4mOK6Pa
 g9+4risupLgiqIW39mCrdh4CGN3UjseDoXp45QnHZcrgK0wuOW30s2XXo=
X-Google-Smtp-Source: AGHT+IGDpBi7d61BCqBQ2oKQcZ4Q/gc0ivCWQwVMh0M2owjMfjcdqmB5vILSaOVGdKiOK5boaoRnfw==
X-Received: by 2002:a05:600c:1394:b0:47d:3ead:7440 with SMTP id
 5b1f17b1804b1-47d3ed097f8mr23274565e9.32.1766593089803; 
 Wed, 24 Dec 2025 08:18:09 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2723b2bsm351652515e9.3.2025.12.24.08.18.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:18:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jia Liu <proljc@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] target/openrisc: Use explicit big-endian LD/ST API
Date: Wed, 24 Dec 2025 17:18:00 +0100
Message-ID: <20251224161804.90064-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

OpenRISC is big-endian. Use the explicit 'big'
endianness instead of the 'native' one.
Forbid further uses of legacy APIs.

tag: https://gitlab.com/philmd/qemu/-/tags/endian_openrisc-v1
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (4):
  hw/intc: Mark OpenRISC-specific peripheral as big-endian
  target/openrisc: Use explicit big-endian LD/ST API
  target/openrisc: Inline translator_ldl()
  configs/targets: Forbid OpenRISC to use legacy native endianness APIs

 configs/targets/or1k-linux-user.mak | 1 +
 configs/targets/or1k-softmmu.mak    | 1 +
 hw/intc/ompic.c                     | 2 +-
 target/openrisc/gdbstub.c           | 2 +-
 target/openrisc/translate.c         | 3 ++-
 5 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.52.0



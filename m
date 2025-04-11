Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38296C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u363K-0004XF-Hh; Fri, 11 Apr 2025 00:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363J-0004Ww-Hb
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:31:41 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363H-0007Uv-RS
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:31:41 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-af50f56b862so1162620a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 21:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744345898; x=1744950698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XdgmfDnMc5WnKUBrgdWxYmUENuANPmGBScuZHPp2x2Y=;
 b=f1rWb35OBe6XxJTcC8ueNZsMt3IXTA1p/MKdOMurVoVBrVvodjUfa0rtaipb40NdF8
 ALF/HnLnAaePQDJiL8X2p3JApKzYraMzbKU0AhjdBQPCbMQ18KlMiKsL51pSxfnHuQlc
 hXdDMO1qht05Rv3T+HTucM1ip75Scu23UgueU0LeTcjeBldv+9oeUFcbaHgdIMvIZsOO
 f38+JjrNh7YTr6z/keLDH69+vAqZXeX7IMa9isAhDZb0vMsEeYOXghq+IMG9i6vJgemq
 y6t1E+t6NV1QYYL6Cd19dU30vIqawrwF3lI0wVE/YTyTgkY7FpWQyS+jTUwM1O/jRiLd
 crbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744345898; x=1744950698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XdgmfDnMc5WnKUBrgdWxYmUENuANPmGBScuZHPp2x2Y=;
 b=LD7IVjRloVn3NHbFDJwcfLbGAIps2HuqA9knaUowPBC5SRjwIyarfSv3q6Ai0TykyD
 7EE3rCwRuLDiiBAn1JsaQaDa2HkJZ61jndy8pySSpTFrbrRCCh2fS4+JDwiqGcUnvyCM
 VVt4dgFxugXiooHNDPBLhtGNbVqg2AqU8k6ufadpex2INrN6km0+qfwNFC5llqO6+pFX
 1g7C68YExLfdRGAs2SpHWPfKuRsOgd0jFrV60CfbW2Nx6p3P5ngJjnrwuHfM3Ik4thGR
 xZePPpHDWxkhEaywB2gwYE7t95ybgrBhDJC0A3G8p8611bf12ys0f69OjPris8bfi7Hv
 Qbpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHaVb1x1NE9CtTbtyyG69DBw44VpiiPsFXSG2KvHZGbZLZAUD9rVwqqwRgO0tZNBkKAHu05i418y2j@nongnu.org
X-Gm-Message-State: AOJu0Yxjled7DPy022IXGUB/cUnE0B4XQ151z49NC6fIGXBfXbEVuXKn
 xt1je4rYbb2dOu5Rq8NwM1X1UXqLFPrm97H0HTYwrzNFO+sqjgok
X-Gm-Gg: ASbGncts/JKLmFBpRipcevirIJzkgc6cDRreZfpjjKtOXLhIKrCSJ84XAhrt/td8r4r
 +6VGLfO2Bv826c9UFq/EO62+NvKjCemqjS3YAr6ymrneU3r3pqYlBo+UOUcMmX4m2UL8wz+LoXS
 P78fhHNVylYrM+9yKIvm0NufyUnxqOvZMS1GnqMNleNqsupItS/zGE1yyYeffUgYJdzqSrqlyCS
 uuDakOZprg7xjG3bQ0OySw8JVmmaJqsT8PKNLo5MKFAKtGNy19qmbcIGOjTUikVEM/F6VZ8mFgA
 2ETHpPzyPbFB4D8bWkvfEkjgG1pWxEvNDGaiagcPxJWE
X-Google-Smtp-Source: AGHT+IEEVJCsex/9S+r5X1nxq2UQnVpHXNjZVoUd3fJkcdL7/MfZXmSBt14B9id3EEZhCJfHrLWymQ==
X-Received: by 2002:a17:90b:5211:b0:2ff:5714:6a with SMTP id
 98e67ed59e1d1-30823643fd3mr2411375a91.19.1744345897623; 
 Thu, 10 Apr 2025 21:31:37 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b64906sm39361625ad.48.2025.04.10.21.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:31:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 0/8] hw/e1000e|igb: interrupts and qtests fixes
Date: Fri, 11 Apr 2025 14:31:20 +1000
Message-ID: <20250411043128.201289-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Changes since v1:

https://lore.kernel.org/qemu-devel/20250115150112.346497-1-npiggin@gmail.com/

- Made changes as suggested by Odaki san in v1. Renamed some
  functions and changed some comments, added a Fixes: tag.
- Bug fix in "net/e1000e|igb: Fix interrupt throttling logic"
  patch to notify only causes that were not masked.
- Squashed patch 8 into patch 2 and improved changelog and comments,
  retained the 7813 interrupts/sec limit for e1000e mitigation.
- Reordered patches in the series.
- Improved the changelog for "net/e1000e|igb: Fix interrupt throttling
  logic" to be clearer about the problems and fixes.
- In that patch, made the delayed irq timer rearming path a bit clearer.
- Reduced test iterations to avoid increasing qtest time too much
  for e1000e interrupt throttling test.

Thanks,
Nick

Nicholas Piggin (8):
  qtest/e1000e|igb: Clear interrupt-cause and msix pending bits after
    irq
  net/e1000e: Permit disabling interrupt throttling
  hw/net/e1000e|igb: Remove xitr_guest_value logic
  qtest/e1000e|igb: assert irqs are clear before triggering an irq
  net/igb: Fix interrupt throttling interval calculation
  net/igb: Implement EITR Moderation Counter
  net/e1000e|igb: Fix interrupt throttling logic
  qtest/e1000e|igb: Test interrupt throttling in multiple_transfers test

 hw/net/igb_regs.h           |  11 +++-
 tests/qtest/libqos/e1000e.h |   1 +
 hw/net/e1000e_core.c        | 115 ++++++++++++++++++++++++++----------
 hw/net/igb_core.c           | 109 +++++++++++++++++++++++++++-------
 tests/qtest/e1000e-test.c   |  21 ++++++-
 tests/qtest/igb-test.c      |  18 ++++++
 tests/qtest/libqos/e1000e.c |   9 ++-
 7 files changed, 227 insertions(+), 57 deletions(-)

-- 
2.47.1



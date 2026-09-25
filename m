Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FD9C9832A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xADoN-0007lb-P7; Fri, 25 Sep 2026 17:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADo2-0007kl-FG
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:10 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADo0-0007Zp-AX
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:09 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 d2e1a72fcca58-88098dbba5fso192922b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 14:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790373006; x=1790977806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mj1xMXLxQDKvbJjq+/ALlSMV8PZ2RtF+T00fCMTxHUc=;
 b=kqqrzd4Z308EMjSn//sx38TlckAPa79zx80dmmlYV9MFZ4z6azAhvtfVDIC/NwMJFj
 4DZiZG9KqdwOcghRyKFvAbNt1uC7PxT8s+GK+WDFR8Y0dgQf+T7MC2ZbhH9llamQWxWj
 RIVodX0G6aBBt96vfk0EutdTGAYwYdgE6RKHijDWgneigAxMQHw1u4SWQRir4VIDM8Pv
 7Zt0sThw0dguMbskl9kS0Fs7+4pmbHgRxMwtTOcreMlgF+TGcIlxnVUE4f5oJMi3NJ/u
 PzvR6LOqG4tn8locpP6v42nROlLQdRMfxXqSsRTG3mPgKhT+g2Y0kyc9cjCQzklPcgIF
 SK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790373006; x=1790977806;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mj1xMXLxQDKvbJjq+/ALlSMV8PZ2RtF+T00fCMTxHUc=;
 b=rMfhrMzudDNsIs0UE01/UX7PeFvQjFFTNvPHZv3HIlI6q0FLd62rbNofjF4DNs/+d4
 DBn2JxfoazwXSyl2yO4WRKL+ikkDlZI97pg+mxfwfiD+oocb/pU3APsNW1uHfYK5Triy
 WqRouCLZO9DskU39XEaAa9wWGAXr3cJ2P24hEGXH379J6lEPhC8LVmN7EO2SRDLJrMQV
 RnNsGRV8tgglYeBMozMlDlsCcH1ZWnKCqB+69Z4yDt0xjt/36KrIvV9BLmG16RQfA7s+
 Z3lQsFLUKZh55TyqAVMo6dDc6Q3oy2ONW8iiFjWcPQCOm2RiJJAiNXMv8xYjEDx+d4ig
 5sBQ==
X-Gm-Message-State: AFuF++n6ojnfSdOXorqIfUIzKbvZ7wOYKQTHc8v8wNLR4jaojAkFWtQ4
 EZKIrQrliNYQ10buJ9af9l31PsJBFRRsAkDpPDmdYglVl1sAWXX5H/0bVld6b/yejuTPPIqLJ7/
 hOlpF
X-Gm-Gg: AYBFou3hzgMwI7pCfEss8jmD1ZlHZqXx/inb4LcYPMeb1M5ZnZILYqxz2LrGVZobJNS
 qUTlCR20wWej8j46eyzWR8o5o8RvBsnyw7ZUeWJzrhRTvOk3oXcmK9vdVWfIrzmaKE+v74IKwMQ
 ZmRA7X+7a2EmX0TMgqHh984QU3ZkiaQOMzR5ihvJt5U2L1ay3ij4IbTQzFTKJoAaZVy1GNBnAkU
 crQ8ov9PER8O/KkUvFkna7+7lC8e30mFt6de0RQnh4Ee+ZD0cjGBSq/kP60Yv57ECuDCHmn6lat
 FKgR6VHqKqu4GKRX6wzs5zeN5FFHDUdkKN6+6WWBlY8Spui0PLDvSrcA1gZ0E2ylg3OSUXonLDN
 fkf3KtpqOPKPK1INl1Q7DKxii4dAybPlxcpd35tYhZ5evjcwlmEmuTPC1pLgB+2f49T6bDXvsjf
 O7/u9okTJ52wP0o24hFEdMgzUDOlUqHSFuL9jOFoH6YGkhJKRLCVJo/ZEygthq7KP8wPZxTWZ3P
 Y1U+AnNQomfCysJekDHGY8u6Tck4w==
X-Received: by 2002:a05:6a00:4b15:b0:85f:1941:a9eb with SMTP id
 d2e1a72fcca58-87e9e0a7282mr4065384b3a.11.1790373006069; 
 Fri, 25 Sep 2026 14:50:06 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea1940ecsm1725256b3a.13.2026.09.25.14.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 14:50:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 00/14] target/arm: Implement FEAT_UINJ
Date: Fri, 25 Sep 2026 14:49:50 -0700
Message-ID: <20260925215004.456336-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Changes for v2:
  - Reorganize rebuild_hflags_common*.
    Trying to force a tail call for these was perhaps just confusing.
    Inverting the order means that we can handle initialization once
    in a common way, and the lifetime of some of the parameters is
    shortened.
  - Introduce rebuild_hflags_common_aprofile.
    This gives us a common place for the new UINJ test in hflags.
  - Introduce check_il_uinj.
    This gives us a common place for the new UINJ test in translation.


r~


Richard Henderson (14):
  target/arm: Parenthesize tbflags arguments in TBFLAG macros
  target/arm: Reorg rebuild_hflags_common*
  target/arm: Split out rebuild_hflags_common_aprofile
  target/arm: Sort BE_DATA toward the top of rebuild_hflags_a64
  target/arm: Move ID_AA64PFR2 feature tests together
  target/arm: Add isar_feature_aa64_uinj
  target/arm: Drop U from most PSTATE bits
  target/arm: Clear PSTATE.UINJ when taking exceptions
  target/arm: Widen cpsr_{read,write}_for_spsr_elx to uint64_t
  target/arm: Read and write PSTATE.UINJ
  target/arm: Add PSTATE.UINJ to tbflags
  target/arm: Split out check_il
  target/arm: Honor PSTATE.UINJ during translation
  target/arm: Enable FEAT_UINJ for -cpu max-v9

 docs/system/arm/emulation.rst  |   1 +
 target/arm/cpu-features.h      |  26 +++++---
 target/arm/cpu.h               |  62 ++++++++---------
 target/arm/internals.h         |   7 +-
 target/arm/tcg/translate.h     |   3 +
 target/arm/helper.c            |  28 ++++++--
 target/arm/tcg/cpu64.c         |   1 +
 target/arm/tcg/helper-a64.c    |   2 +
 target/arm/tcg/hflags.c        | 118 ++++++++++++++++-----------------
 target/arm/tcg/translate-a64.c |   8 +--
 target/arm/tcg/translate.c     |  33 +++++----
 11 files changed, 165 insertions(+), 124 deletions(-)

-- 
2.53.0



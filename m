Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BAFCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmSg-0003fO-EO; Sun, 17 May 2026 21:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSJ-0003VM-1E
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:39 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSH-0007KK-H8
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:38 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3680540a6efso741750a91.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779066455; x=1779671255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1kofTULHLuBdZI2P1+471lmTkfy6FsWAxmxkqZZKmTo=;
 b=fccP5nAzOcczR10ytjBxzUsVErj3yw6oK4HfJ2MjSJIm9NpozFG/9OFxvgeNwUvZ/k
 gjBQwb7uo7gG+fS/fS6RZU0IDP28GAoZnyEdvdL7oWzE3ArH2Sr6rIT6ZicdFXddDlBG
 eWs12pCZatOcGfUeXIOKXJ5c6M6d6gFguYyR1EnWKYr9TlQshc+swsCTVnBxvW7xWeRZ
 8p6+Q/Zl1DRL21xbneFyinLmDwdn54SI3LiTOJHR9CPXhDPMA9tPwSKL8TwG82p0ArIq
 F0BuERoou2LGVH3UK2boUX8RsAYYS7R4cLKoOQew4QP5THg6ufe3myOJ/4n0tsb8xS9U
 Nmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066455; x=1779671255;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kofTULHLuBdZI2P1+471lmTkfy6FsWAxmxkqZZKmTo=;
 b=ZLknZYMY9LeCvtRx6b14dQowMpll10hesry8aCppjCVqQnX/WhRyjFKLXU3DBzbCMo
 hPqFm5QjjkjSR0vI4Gj/x6Lhv3FLQaKSxZlz1w/i1gTMiW/CAP1+x7I7brJXrG+nkORN
 R4IIeFxqDRtNdjvr14HneCSbIEHv+7DTGflc4+oOZREu8YT4jDZJ6tAbc716pl6Gdtk/
 YJHjavc0eVfeAg1IXDpCHw67qBDTPgrUWC0JVxzWhbTTbuBW25dvLqyYyKArB4lbRQYm
 VBuv6/GhvaYEQcdcn8BArIiWZO3Ww2cj30VljyojeA/j808r4f73/GAdJR292I4V8z+s
 P9Jw==
X-Gm-Message-State: AOJu0YxpfphqWoUKQrq4ujvSia/ometB2+jTvu0xe9/i7Y6re4i0/l97
 7Jrbi9R1z89PCkMrT8H31EDsAU7DKywje2FwAPRJZ56issDR0ZAA4hYmAMM1VTpufu/BiDBq11V
 wBon5
X-Gm-Gg: Acq92OGDTC17DE6bSQebuGxXCEVzDV2ai2lHVccKx9AhuvwS5Z/GFL8T9KK5OVK2UH7
 wBjHWr600X5G5Tore6hiGwLBf6KmZqHk7dEy7TPCdNQaO2Wa0o4ZYFmvbJmOK8opHRklMm9CUMJ
 ELkpdxQ9h9f8XPZFTdceuV23QhIjGHLM2S79LpBoJtIo2i43cnttobVRs+BCr8nGIVPGyHoWax2
 zDKCn/qxUqjo/P4nudpk1FM2VZGxlHR9Qbt1h0IQ78jTAkec/1i/L6kkWw8nu8HE8UGqrQhkikY
 X+I75EgyxLDkqJUz8T+9xtsal3zGAt0v+FRKlcbhdYU6cpeqiWF/ZyOw2gW+fOYJeS8Iw8XtR1V
 wJR2Ba/2qcGHAW6T1dqJEF0ebFBvQ8Gg6l7csBqra8KvEH5kpAwjPqZfHB0ZNFyFOuiVg76cBzx
 ngQsGsuPcuRyyTHrvwk9ZMIIqnV+W1j3XJORggqZo=
X-Received: by 2002:a17:90b:350a:b0:369:bddb:79b0 with SMTP id
 98e67ed59e1d1-369bddb849amr2067745a91.26.1779066455241; 
 Sun, 17 May 2026 18:07:35 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951584654sm9160939a91.7.2026.05.17.18.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 18:07:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: james.hilliard1@gmail.com,
	philmd@linaro.org
Subject: [PATCH v7.5 0/9] target/mips: add missing Octeon multiply insns
Date: Sun, 17 May 2026 18:07:24 -0700
Message-ID: <20260518010733.502237-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Hi James,

Here's a reorg of your multiplier instructions, expanding inline.

The tcg multiply optimization is to fold away the idiom by which a
sequence of v3mulu with 0 and 1 operands is used to read the MPL
and P registers:

	v3mulu	p0, $0, $0
	v3mulu	p1, $0, $0
	v3mulu	p2, $0, $0
	v3mulu	p3, $0, $0
	v3mulu	p4, $0, $0
	v3mulu	p5, $0, $0
	ori	$3, $0, 1
	v3mulu	mpl0, $3, $0
	v3mulu  mpl1, $0, $0
	v3mulu	mpl2, $0, $0
	v3mulu	mpl3, $0, $0
	v3mulu	mpl4, $0, $0
	v3mulu	mpl5, $0, $0


r~


James Hilliard (7):
  target/mips: add Octeon multiplier state
  target/mips: add Octeon MTM instructions
  target/mips: add Octeon MTP instructions
  target/mips: add Octeon VMULU instruction
  target/mips: add Octeon VMM0 instruction
  target/mips: add Octeon V3MULU instruction
  target/mips: add Octeon QMAC instructions

Richard Henderson (2):
  tcg: Introduce tcg_gen_addN_i64
  tcg: Optimize INDEX_op_mul[us]2 for 0 and 1

 include/tcg/tcg-op-common.h        |   1 +
 target/mips/cpu.h                  |  12 ++
 target/mips/tcg/translate.h        |   2 +
 target/mips/system/machine.c       |  33 +++++
 target/mips/tcg/octeon_translate.c | 208 +++++++++++++++++++++++++++++
 target/mips/tcg/translate.c        |  18 +++
 tcg/optimize.c                     |  90 ++++++++-----
 tcg/tcg-op.c                       |  42 ++++++
 target/mips/tcg/octeon.decode      |  20 +++
 9 files changed, 395 insertions(+), 31 deletions(-)

-- 
2.43.0



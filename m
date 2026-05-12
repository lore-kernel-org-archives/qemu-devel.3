Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBCACD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 09:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMjZw-0008IT-3T; Tue, 12 May 2026 05:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMjZu-0008HO-GX
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:39:02 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMjZs-0004nC-VD
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:39:02 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so3916029f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778578738; x=1779183538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=0m+7L8s9bvYXTy0H0lp7ALP+WJost942y/rubT7Rl+w=;
 b=i1Rt62DSbZjVOstMnJMSa31IQSh3LlghL6LF/fByTNpHGMEh2QpSKL4ABHCHIBsUmj
 9N2KyN3ZzOSC/Z2fVHXWZlwh/fr/7OOF5GfAUrgbe4ZvmqcDsYZCsFlGnC1ImNoHirXv
 xoBBzwucs8lxXhmr6BesBKIlVd8Zs7Rg3me9S+sfN0kcoWYFLBhgAsbcOUsxIPO/hC+f
 6wJw6gGYQh8B95Mf/28fp2Sz5oHsg5CQrnX/T7rfCyEyJLZS0vvxtX5WtRSdHn4rcksB
 m82mX+juE20UJC1mp8ag5Apre3AjxSzK+jsh7jdlC+IJKTNpiOlKZteqJN4DlRtn9QHt
 6n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778578738; x=1779183538;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0m+7L8s9bvYXTy0H0lp7ALP+WJost942y/rubT7Rl+w=;
 b=geL+OLc3UBjaZGRkQE1GxJ9BKOvXTeH/sMZHkuTvpTmWpc+LPWEUgFr51/RCMce59L
 5NKZ8SAX/Q4KqwRa1HqVbhC4eXLfAHBkbtZnrFa/PqwOq39b2bFV+BZF+XdncXUHq7t8
 hYfsBcodJ4vL8u/rjwy1IIvt98lpMd7NX1c39ns3yYoEMU5thU4ED2DNYQ/TbUDfDDn5
 n1rQSAxqePyxajGSVCJ01dEwyeP5G2LeBf2HuNv5/MZ2zy778/3I6SowJp8rd/iFvUAf
 RtMSTMH9yIOWIo9gjoktP8EkPCfUrUv8jlUB8Zs24wujaRY0beNfyvKE05Z8g2GNptQp
 +iGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ns63LjMlSTYu5FVsYYvoUzCoZ/GZv9/bkwcnQNKZuBhuihjaEXWaeQ7U+FnvXRTAceEXpgp8FPpL8@nongnu.org
X-Gm-Message-State: AOJu0Yywqxm3iUDHhrbTNzWQWzd0f+4AnXt2G2nNj7TQ7wEm9FuUp1dT
 68G9thB7flj1S0SGenaygzNoRBlybz/VuhzbM1qR+xGBg48h5RHrSq16k9S8fxp3PQ5zFGAPHl7
 OOZJs
X-Gm-Gg: Acq92OFKNLn4Zw6TTnmhXUplCgu51zEwhL5B0IGf1z+CMscuLEHTp7DmW9J7mSNv4sd
 v0gKRhSevXjk8/E2F0Pj08YRgwRXy+aUyyvmcadNkIeJnfh6G/SSyje0amqvkPoauipU2zUPQkt
 p12Q8wiSzwnaTuoxlTL3wP6O7UmJLqStEOfyavF8hX0sWFSlJToTpTBnlaW5w6HilvMZGOblGje
 C5QQ+xJZuFDIaFy+p0kFuF0a8YN8Jcax1g5imJTon0OXjQ4lPz9/aP/1b6SYX/eJ+6DmkX0jP4R
 OAdYJvcXttWGGokxhTvMBoRSa5QO1LJ+r8xQ2TlGjHRn8aAdMbO4ZioY/hbR+pX2SL9sXo285Ao
 Ch4blOAwOffC4uslLVCHzF2ODvxo+Ycooq8W2jLTpA5lhjkJjSbA9yklwMa3/VL7JZmznX+yVfh
 gTUGOQuUdEZ94pTupOh1C+oxOoVTooVWMUMD5HOfGBXtxTGa0S5byQm2vZYb26mwi2gexSCy7/T
 rz39ev2c1SXQPdKgk4MuYwQ5ADJpWTk3KRlFgPHLw==
X-Received: by 2002:a05:6000:220e:b0:441:1fa5:457f with SMTP id
 ffacd0b85a97d-4515cf1273emr48843107f8f.28.1778578738178; 
 Tue, 12 May 2026 02:38:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a6a64sm32805208f8f.6.2026.05.12.02.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 02:38:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/4] target/arm: Fix Coverity issues in GICv5 code
Date: Tue, 12 May 2026 10:38:52 +0100
Message-ID: <20260512093856.3197700-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Coverity found a handful of bugs in the newly-landed GICv5 code;
this patchset provides fixes for them.

thanks
-- PMM

Peter Maydell (4):
  target/arm: GICv5 cpuif: Fix overflow in left shift
  target/arm: GICv5 cpuif: Don't set HPPIV bit in GICv5PendingIrq::intid
  hw/intc/arm_gicv5: Avoid NULL dereference in trace line
  hw/intc/arm_gicv5: Add missing early return in gicv5_set_handling()

 hw/intc/arm_gicv5.c               |  3 ++-
 include/hw/intc/arm_gicv5_types.h |  2 ++
 target/arm/tcg/gicv5-cpuif.c      | 26 ++++++++++++++------------
 3 files changed, 18 insertions(+), 13 deletions(-)

-- 
2.43.0



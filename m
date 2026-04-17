Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61430F8E4AA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 04:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDami-0005yM-74; Fri, 17 Apr 2026 00:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDamg-0005yD-P0
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:26:26 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDame-0006MC-Su
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:26:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b0046078so1941675e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776399982; x=1777004782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o9I50BpcUkWisWtRmnfABncP5j6R0K9dnqUeHz0ArTo=;
 b=O98ZEVnLTCv00bO3kXzZHilSPtbzRsBu++Al21dErgkLP4ky3OGBOwPpyh6YUco6Er
 801uQPIlj4lgijtFwXVxO6aMhqWRC29z+t/m6odb+87WklQtqWf9arZRpAN7uyJj7awg
 TrM829KfU6B4O7c9xFiJg/S+hSlVR3GXyitxlwRY9s9n9kJxkpHf2ZaDBSn574UKq26c
 B8sWYPGGboKJSSPH+WZ1uv7ZJUvPwTCd4ELbv0UCCKzQNPzIWJ4Gn9mrq8SyN6JQmokz
 MDQuoYPb8E1ZILTqCvoe0T8DO5H5FiVIrW5V6YtnMGsZEHut+j/xvLVLQuHvcYI+qPgr
 meLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776399982; x=1777004782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o9I50BpcUkWisWtRmnfABncP5j6R0K9dnqUeHz0ArTo=;
 b=WHXsnSIVfKOJO9fqK6Ac1Iq5P9Dxu0oJwjgZaZLfGc7e0SulvJGjWbXPGG9GI84Jpb
 +QX2adAc0trkOPZgdR9Fl1LOCpnQbmh9AntYoH446veXl+RRFyC1HKxa05S+rZnzuWOE
 WArfHu/x+w563jtcnmcjQZCgik46dK8hSBZ4y+fPwPGiewaZlUYzrmpL/fdeoNUpCn+U
 z63Elf7w2ksdNvZyrIqcM4+Fe6enP3kXJFkioyl8KIwMZ+15BJgb7dRpGpzWjXgLh1Ne
 YxT0mKLOJzSqkuBL/ZQA7vY7BwPfhE/03a1Xw/7l5vRTXu98qYiSPPjxRlTQy9EaCYvw
 S2ig==
X-Gm-Message-State: AOJu0YzpNKckxhyq+rjnci1kZkuJrPBn568ERp1tLifqN3jusGiNVpcr
 EM0qnDuvM2dK6Bi84pe4l8/lYJQIuxBfQAuCVC+V8RQN+KSi8SBhlAszmrxGxpzjOnIzSjepCUB
 9Y36Ox18=
X-Gm-Gg: AeBDietrdt7k+22szoioxKrtduz8xUSNIWwyf0K1fQSbrmzjrv1GDJ9ueiD1eMo9BPQ
 VqgQ0VCyj3Ov8Iozn5IabCWlOxoGAKxg2b0FLp8wcCZuKdt9n2OGHWbaJEC45pRSp5LXU7SY9d5
 LQRtJi0YE/eN7wf47nunDBLJb0p/M5BgSjxyku9d9hEjcbKGeqdaOT+VS+OmlXWvKAEVjKfeG+7
 DlbIwucf3VR8zIixrid3lleXZuHma7WOMagTEONgSH3Hq4wMmqtvPFhfoUyjB2CmrUvtUO5Un4k
 gG5mKfuJNNjhu1MRwcldrQH5l3EzOyyihr0OIDq4j5stlEQBuGOmSCGinhnUAiTj4JLp7yLiycd
 lf1p8nHYut0N6ZORFYBshgCVXzKMMzx96FkMcr7GTntXwO85CPv9/yQJ2+DJzf3IInrMMc5esTa
 YFUPpx0XN2LoH4wLJheHXXKE2wW1l/nM9o5CvaD5vHWz6z6dgY7h82/AR5ZKW9jZjZsIvhRHsFt
 HUuZ+g4xHA=
X-Received: by 2002:a05:600c:4fd1:b0:488:a824:fdff with SMTP id
 5b1f17b1804b1-488fb782a04mr13328055e9.22.1776399981978; 
 Thu, 16 Apr 2026 21:26:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb755938sm9615815e9.3.2026.04.16.21.26.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 21:26:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 0/4] target/mips: Use probe_access_full() in Atomic
 Load/Store helpers
Date: Fri, 17 Apr 2026 06:26:15 +0200
Message-ID: <20260417042620.35329-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Since v5:
- Remove dead code (rth)
- Reword commit desc (rth)
- Inline translator_ld*

Since v4:
- Moved MO_ALIGN change

Following Richard suggestion in [*], use probe_access_full()
and replace legacy cpu_ld*_mmuidx_ra() by cpu_ld*_mmu() in Atomic
Load/Store helpers.

[*] https://lore.kernel.org/qemu-devel/ee4ebd4e-b475-4d76-8fd2-8b04c30b183c@linaro.org/

Philippe Mathieu-Daudé (4):
  target/mips: Pass MemOpIdx argument to Linked Load/Store helpers
  target/mips: Inline cpu_ld/st_mmuidx_ra() calls in Atomic LD/ST
    helpers
  target/mips: Inline translator_ld[uw,l,q]() calls
  target/mips: Remove last MO_TE use

 target/mips/helper.h                      |  4 ++--
 target/mips/tcg/ldst_helper.c             | 27 ++++++++++++++---------
 target/mips/tcg/translate.c               | 19 ++++++++++------
 target/mips/tcg/micromips_translate.c.inc |  2 +-
 target/mips/tcg/mips16e_translate.c.inc   |  8 ++++---
 target/mips/tcg/nanomips_translate.c.inc  |  5 +++--
 6 files changed, 40 insertions(+), 25 deletions(-)

-- 
2.53.0



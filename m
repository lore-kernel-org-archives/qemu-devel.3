Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97ECDF8D753
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDOJ0-0007lK-8z; Thu, 16 Apr 2026 11:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDOIy-0007kt-Ux
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:06:57 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDOIw-0000iK-Sc
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:06:56 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so108067865e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776352013; x=1776956813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jlYjoqfRu20uHFJZyI+43nVRW+T6ijzLFKtt8jiQo58=;
 b=lJJ44gYxM7dS7W98oN3O9wLuxL0VhC1gR2x4rccTWVC6QlgVF+qGvZcmPBuKG/ekD+
 plcuL6Do5uqhM0ZfPCQ+TGDUY1QJcmd1CNGuCA8zhRZ0ft0E3uJo5MRvYppCuI60kWah
 Cy26d/jBXCwgjBV5zyu54DHtK7+KyV5+NChoMp62epKQWJQHK0Vfzcd3w93f+Xaz8/BQ
 59uib/i6QOL4vd4etYB6iQ144/Cky3w3SlTn86mbSagS3/eng00sMIhkhFAWglMd9gOM
 UvGfPhMbwGwRdKvhpK9GO1jMwMPwuhQLtld49wB/zuamUSF4HRvaFaUvyIHfmrPUgu+2
 aqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352013; x=1776956813;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlYjoqfRu20uHFJZyI+43nVRW+T6ijzLFKtt8jiQo58=;
 b=CNMuZNCeMOJvhJx4X84x2qsfk77DG56bkAdSwd43K7HX1wbyA4sxtTOvuju12aA5Lj
 hjQSsA78EoPGU3FK56+tuTI7s9y+qunab5L/sCt23pc+s1nOo7+LgCIy9gAQ7yopgccM
 N3vm+tkS6TAZm0hm9plmyjfeH8QFprjWGsutADturNL2pKqP3/9EnFmsaGVdlXE2SN09
 Ve786zQZgj0I/MHx9DPJ4kE0J83fCJha5kdK25mrPrWXwNt5c09wVYTCE4lWvHsIuvND
 KyFILhs4pSX7gXPVDuylKmIoh4k8W1ULKRshIY6nwG+lIZLez/2oM2lsbtKxoXjXXWSb
 deew==
X-Gm-Message-State: AOJu0YzoVybcalKoWZxWrP1zMT75tQLF0A4AM5ufBD+sdSlVGCJ+NPIs
 mRLCs2e5QJLrZXkhKjQm5Fd4eWLGw2uTXd+HOAb5CiG9v89toTW5TbHnFvxcbKDnrAmwTilrdQW
 +8PFsuxk=
X-Gm-Gg: AeBDietLX1uwaekciVZqS0UWgKqqmCgm9f9x8vBo5kpJfYJAQjGl49OangxwzNDsmSR
 VzNZ1nozdMAR7fcKdBGvYR2pIiVYTAIWLyuKCW/XeLHeDjX+w8Ea6eImeu18xBZIp3veSGf+T6U
 LFXbn5JayG9XhUMXmj/fIjWCE/v3RjSTu7nocmnhJsQnLBoTvDIxIXRWxC9bMaIJPIks+IfPzLf
 WlbTRo2Hje/QiZKm1hb87Di4P3FE1sOX/IZ34o9cRtF3B1xpPYYIpPHX/bCi7qBeCNjsW1myYJb
 pR6nzgxfbx0GXyVvn5Bq2LEqeDsnIQfrRjLmw0k3hMehvLo4Qo30nWPdnOBelILjqsJN86Uz7/I
 MGWTNmy5MvmKB1xU5r4aDFh1Yn2shPURWtR2R1IFC3WUDgo1WSRjyeP76KGW4M9fdBeYEtF6TK0
 JJ4GTEl5d6IHZxGAzxzPisudN3dPXfM5HemFDhOBkzAPiZ5EHoCB+QW1ui5pGQHQmoTfZ30dUK
X-Received: by 2002:a05:600c:3acf:b0:485:35a4:939f with SMTP id
 5b1f17b1804b1-488d68a8275mr328876555e9.28.1776352012828; 
 Thu, 16 Apr 2026 08:06:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e71f5dsm68341095e9.6.2026.04.16.08.06.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 08:06:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 0/2] target/mips: Use probe_access_full() in Atomic
 Load/Store helpers
Date: Thu, 16 Apr 2026 17:06:47 +0200
Message-ID: <20260416150649.23671-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Following Richard suggestion in [*], use probe_access_full()
and replace legacy cpu_ld*_mmuidx_ra() by cpu_ld*_mmu() in Atomic
Load/Store helpers.

[*] https://lore.kernel.org/qemu-devel/ee4ebd4e-b475-4d76-8fd2-8b04c30b183c@linaro.org/

Philippe Mathieu-Daudé (2):
  target/mips: Pass MemOpIdx argument to Linked Load/Store helpers
  target/mips: Use probe_access_full() in Atomic Load/Store helpers

 target/mips/helper.h          |  4 ++--
 target/mips/tcg/ldst_helper.c | 22 +++++++++++++++++-----
 target/mips/tcg/translate.c   |  7 ++++---
 3 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.53.0



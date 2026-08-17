Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E8FC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvwc5-0003cY-DT; Mon, 17 Aug 2026 08:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvwc3-0003aE-Oq
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 08:38:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvwc0-0001DQ-MY
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 08:38:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so35306545e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786970321; x=1787575121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I52uwiyvCbvrhl3pxQjwG0o0BiUPMBUp8SjEJskHeyE=;
 b=kTc8N3hNRnaBdpRa6Q6gumwNPS19tlVoixGYgKDlV3g39ouVdeOLftsKmoh0dWjZTK
 ShX9U7k8ODFwn3/MvEhvg8d37F6SZVqQMr3C0W8pKz5XHBTeNwCeCIrMjtNv6Yps2HPZ
 RP5FIMBCWQkbiBbWeeBILnCoUPhy2G68AqMoWIcWXhVi5s19wb5hOkbWoMmjGiHFN0zX
 W5mjkYT1Cc4tFnraEC+c91fMNssZY5W5ztOR15JyB0HmLmedaIzEg+9xNQKLzWr5UuDH
 Ko4B8E5H6GwKimAciH7HNKqXVfTUNRdr8PInNYBk39/lQTfWZTqCyhpJhFni0CmawYLZ
 OLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786970321; x=1787575121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I52uwiyvCbvrhl3pxQjwG0o0BiUPMBUp8SjEJskHeyE=;
 b=OidplMCCWgNDCQTLdyuLxC4I9LX4FqkgVEf5xt5n0/7zzBbGq0EtLjTZ8dZH8+thRF
 kWqi19Z9HkyKTnUvr5hFU0HPMpD/9Xd3nzUlTCKpVlVP6Ssm/zZrPO3oA+0RD0IRqN9H
 u7vjLtYNEaM5DhzVfY1oUWyxQw71xKOmvM//sWfyJ8XA3XOp2ss0ulqn5YarwbM4GQYV
 DxQgIuWruD9G5EdsXZyqMx65TqQb1cDTJLA0+XZPeQ6xVhe3RwPpTcvrl6T+IfJbmFqb
 CuC/ONUxOrAE45KsBY//6KiLG/VLfRRXUXMMYdIcivPmPlL9yEqQyPkm6QX0KQXjLQhx
 l9pA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSdtZ4Ouk1Bk7mlg2VJ8qdwqObKwIT26mhM1KsK5XgQ0clMggQ3Vw+cud5mz644nxZQkn4nTdlWaRm@nongnu.org
X-Gm-Message-State: AOJu0YwO3HThMJPy4WJp/C3Rzhi/tb2Cg88GeNrsFMHyh9JA3F+O223A
 mQ1Y+c1a+CfE1uKHwYq3EtHxQgy+Z53yRm4ewSTpTXEVugw63oWyPh2LcIuVx4Ror+U=
X-Gm-Gg: AR+sD13UE1nEITEByml4gYZLyvEc9UkM3QcVvrU6O08GlUuORlG1+RbMq2Eue/gsEvj
 bcFM+Erzaf0Lt7Vl4t3it/8uIgpLy0p4ZRVyGBjM3f3oXeUz70t1CIvehBe+yXZNHd6KUM8kFzq
 C7cpmwxfw1cBIkafkyXOnKfbzGpdkPJZfn+bUPq9MLIYsdCjNe7uRSmxZx8rokKnMSWnx9P75sP
 N6LK/EnJpqkrl0pPuYHqxQv1ffhahoV5IfH6joBAS7LG7OMq0n/vz32PsxRHNupohdcWWRTy/uO
 uO1QV/GDwS50FAAvbMd16aN5OA6If9TVWEequN4OnuPvbqd/21MHXm3wogR6GIfVEiZwP7DNqZ5
 rYbjfZqNm++Rrefgm7pC+f+ETR2r9vn6lEVq2p3FJ+1yDr/S0gIXlyDK0amV5NltqacOO0d4M5j
 bX8xFJxwHJlBa+DHcXKXo9mt/WBW/OafCr0HrHAHWMFvoOqtdt4Qye5GTOd1l21TVRIEX/BomJ9
 aVvCjM61EgbOqbt7hG34WtgsJXh8wEtLr7k+nC2S5+pbh74tTlKOBytJA0pWzYjqK9B7A==
X-Received: by 2002:a05:600c:3495:b0:499:873b:471c with SMTP id
 5b1f17b1804b1-4998794fafdmr421865545e9.6.1786970321242; 
 Mon, 17 Aug 2026 05:38:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998780397dsm120415055e9.3.2026.08.17.05.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:38:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 0/8] target/arm: Fix some Neon trapping corner cases
Date: Mon, 17 Aug 2026 13:38:30 +0100
Message-ID: <20260817123838.1578060-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

This is v2 of a patchset which originally did three things (fix a bug
in syndrome info for VFP/Neon trapped insns; support the "trap Neon
insns" trap bits; support trapping VFP D16-D32 accesses). The first
of those is already upstream, so here we have just the patches for
the trap controls.

Changes v1->v2:

 * the first 4 patches of v1 have already been upstreamed
 * patches 1, 2, 3 in this v2 have already been reviewed
 * patch 4: switch to a positive ARM_FEATURE_NEON_TRAPS from
   the previous negative NO_NEON_TRAPS one
 * patch 5: fixed a missing check for EL1 being AArch64, and
   slightly rearranged things and improved the comments. I opted
   not to take the rearrangement suggested by RTH in review on v1
 * patches 6 and 7: refactored to use a vfp_dregs_ok() function
   as suggested by RTH
 * patch 8: new, makes the neon code use a similar neon_dregs_ok()
   purely as a cleanup and to make it match the vfp code

thanks
-- PMM

Peter Maydell (8):
  target/arm: Handle NSACR.NSASEDIS in CPACR accesses
  target/arm: Handle NSACR.NSASEDIS in HCPTR accesses
  target/arm: Update confusing comment in cpacr_write()
  target/arm: Add new feature ARM_FEATURE_NEON_TRAPS
  target/arm: Implement CPACR.ASEDIS and HCPTR.TASE
  target/arm: Pull VFP dregs checks out into a function
  target/arm: Implement CPACR.D32DIS
  target/arm: Pull Neon dregs checks out into a function

 target/arm/cpu-max.c            |   1 +
 target/arm/cpu.h                |  17 +++++
 target/arm/cpu64.c              |   1 +
 target/arm/helper.c             |  91 ++++++++++++++++++++----
 target/arm/tcg/cpu32.c          |  10 +++
 target/arm/tcg/cpu64.c          |  10 +++
 target/arm/tcg/hflags.c         | 102 +++++++++++++++++++++++++++
 target/arm/tcg/translate-neon.c | 118 ++++++++++++++------------------
 target/arm/tcg/translate-vfp.c  |  83 +++++++++++++---------
 target/arm/tcg/translate.c      |   8 +++
 target/arm/tcg/translate.h      |   3 +
 11 files changed, 332 insertions(+), 112 deletions(-)

-- 
2.43.0



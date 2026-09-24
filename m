Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E56C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9klr-0008Tw-WB; Thu, 24 Sep 2026 10:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klW-0008KF-Bz
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:41 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klT-0005E4-Ii
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:37 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85a4329731cso1268821b3a.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790261374; x=1790866174; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WyYCpDYui6CfR9tnTJyEDuLwYZ9JTh88a79RK1VEN6w=;
 b=ql3J0qDHTFKyc4eBPlv+ozTkQX4Ymi1utpNcZkrf2omsBLXS6ZbPgDVWUogen3LD4T
 8Z5+WDzPFUSO4D4H+wfq3/13DvNRY2iDKDKSNWoAPtyu9eyWse387VVIngbzPsHruI2x
 77fa3kZoyZGpa58YFMpHkeTWf8lWoUH0kZBs4igo6Hj+L48XG/Ge4WNNpAlrg1jtGUWh
 SfJ6s6qcOEIg/UksM4QTLoQkxFpmqjdolS5DNHZdUiaX9vNrKjlry6BNRC4DZ1jdoX2L
 9yLrvJ6Oz7dYGm5MAzHlt6gAKwJRocG5eNuVhhQYRXMMK5J8agKBIY2h4Yfd6OhRSgdF
 2/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790261374; x=1790866174;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WyYCpDYui6CfR9tnTJyEDuLwYZ9JTh88a79RK1VEN6w=;
 b=UMuYGOkjI8uh5oh94UPirl89F37HAo+VFACgdfhGhmjqEfKmFaEkHk358Cf8K0SlZW
 8P0OL9fe2rTXiPO5JIBuEXeAuPXzr9eNJotGLKswHDWR66E54ShsDm+cuB8Lh0zwIDjO
 zS8rfMZQnWXmYSBPxX9GDKEeU7QIQyQBn4F8JmN2xdrCX6BdIByuQ0PavNhZJHeTdl8V
 2pspDpyrTj1tWaX6i36cVACokP1R0nrsx/c0GVXcsB6rh4VyN2ugTk3aJ3o0FYh7KpXj
 4VioUNW6ajlttVt/YA6f2pT9aVsV9+Rjp3N6GejTXhTKrM3HhfKVY6S1Ry679h9bCpIe
 Ne2A==
X-Gm-Message-State: AFuF++l85di+zOuaKEcKwf09q61XENqJ9goZvNQapx1Odp6myRCg9ceM
 Ln3sR8B3gnrxEy3uGRywfR9OnkQn6GsMS5Svam6VpwXYDje8+MFdYf7e61CUuwnnqMMchqb/77a
 dxVk+
X-Gm-Gg: AYBFou2E2ILn+pgrVnImQWR+SRk5j7+mNubD1J4NCL4ydDRo+wXrlKNTPGxKTAoFtTe
 9NXWMHT8TWWvCdJlrTVW/CFMxS6RBfT3stQvTMOx1Mpc+MISHy1+YTPbzfjBU78GbpO/LMYOCgA
 UjMTQOdQT1Tlh6Q++rmaGZAGWavfr53OHyRsIRJhMjRhMW9sE1y3KXwhxAOEn251CxU9qfzT8sb
 9AeHZlpTrSvGpvV8dBJOPajWhRF35AGAwLLBRAXt92FtvdQ5cYrmMcXFH2gNQXTn4P0TPG/q0PV
 Cf8DjdQodQgGUm6mH8Bi2Twg0sOHxwRdQhklkIcpwfgyoluxZKTyz2G5uCgSm3TFqWXnYu70pl1
 dd07fY9yiW5rW4w/yEidyaOpp0MM6yuAiPybVVRFA2aZhEP5Cwb+AgRUqTeZnWV8uY8iscem2CN
 m9Lm+BoBrX6eT9euDK7bBfq/m/h6nvE2wlWTDoHY42XGfsjFNUS0M6HU5N9T2OANRG6JM0T4M7M
 mPARD5TM8xrTlW6XuCHT5cmBNbDZw==
X-Received: by 2002:a05:6a00:4c09:b0:878:34b8:231f with SMTP id
 d2e1a72fcca58-87e9b69fa2fmr2219271b3a.39.1790261373274; 
 Thu, 24 Sep 2026 07:49:33 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1dad3978sm3209818b3a.34.2026.09.24.07.49.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 07:49:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] tcg patch queue 20260924
Date: Thu, 24 Sep 2026 07:49:23 -0700
Message-ID: <20260924144931.161335-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
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

The following changes since commit 942229961efea74b153c44c59188eb08375f10f1:

  Merge tag 'pull-tcg-20260923-v2' of https://gitlab.com/rth7680/qemu into staging (2026-09-23 15:14:55 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260924

for you to fetch changes up to b9bf2135a7e4adbc1c7a1a64818ec7e2d3ceca66:

  target/hppa/tcg: Always initialize DisasCond.{a0,a1} (2026-09-24 07:29:58 -0700)

----------------------------------------------------------------
Never pass NULL to tcg expansion functions.

----------------------------------------------------------------
Richard Henderson (8):
      target/i386/tcg: Always initialize CCPrepare.reg
      target/mips/tcg: Fix zero in gen_mxu_d8sum
      target/mips/tcg: Drop zero optimization in gen_mxu_s32mul
      target/mips/tcg: Split out gen_mxu_logic
      target/mips/tcg: Use gen_mxu_logic for gen_mxu_S32MAX_S32MIN
      target/mips/tcg: Use gen_mxu_logic for gen_mxu_S32SLT
      target/mips/tcg: Use gen_mxu_logic for gen_mxu_S32CPS
      target/hppa/tcg: Always initialize DisasCond.{a0,a1}

 target/hppa/translate.c         |  72 +++++------
 target/i386/tcg/translate.c     |   6 +-
 target/mips/tcg/mxu_translate.c | 265 +++++++++-------------------------------
 3 files changed, 98 insertions(+), 245 deletions(-)


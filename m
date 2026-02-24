Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBA9EFB800
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vulDm-0003mH-1g; Tue, 24 Feb 2026 00:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vulDk-0003m0-V0
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 00:44:32 -0500
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vulDi-0002Hq-TC
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 00:44:32 -0500
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-2bdb17511aaso519211eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 21:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771911869; x=1772516669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=eeKWopagpNH1e7lkMDwqj96MPc3/NtTJh1DDK99PM3A=;
 b=DJH08qdYySOm5Hz/qIzp7dKXKLRRLNQP9IAT5U1KfYn+qIXTEWaCYiSyml+2JkWBwE
 NJgD59g3wnHOWkvLdKU2CPYXkd9av1bdrKFugTlD7oK3It7yBONoHVG1S+n8o1VYpvwH
 upMzInt3EO+6ajHCatUNjaNFL8nZzn7mcsW6swGIxVu/yEsWcFh9yx0B5qzsIKVrboeU
 BNb+9VhZjYg2863l1We1BSGOHWv2oQ1pYRi2wCbUXVSl86zaMFXEzitZLKCtz7VsWzSF
 GIZxdU2SbBx0Xez1BJqWuS+y4PTQUwZw2V2TbjtUaDGOUtrsBHWxcIPBFRofLorIAZQO
 NHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771911869; x=1772516669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eeKWopagpNH1e7lkMDwqj96MPc3/NtTJh1DDK99PM3A=;
 b=aW1j1JI0jyS4T5awTYPlGh7keuyTvcLZroxvGY+GX2mT2w+2xL7mu7U4z3BY1KJ+CO
 n50WOYzBk/lQfD3+vWWZZKZZEbh3FYFhr1JQ9way+BaLUMusBK1032jMjAEA/8HU/OgN
 2ORk0jMzB5XioLhCOntTypLx66A5VYZNPdjqq813pJi4X6EMZ4Cj9dndibBtLZA7/lK5
 j7V2P+GV4vuYnp++H3ypubPDyvTPcn8dwlOV2acw5Y+bpFnGlvHOBwA+rbkLrxIUxeGK
 nonm5+sQ6RNbGqAsORw87+thoaqojKjOHhNdh2QlqKtGMChh0PXn4LRCmZQwkpWk4OHT
 eUjw==
X-Gm-Message-State: AOJu0YxKeu69iQ4kLrc926LYOhmMxQnI3J9UfAwbfY+S3KOQ6H0RIUAU
 FyK6MRdchlsuFTw/m8ghipSSMZI2XZbziEZ/IdIwHHrdeOBPfsHz+C/Hpuw+D4ys9lk8hsiRCf2
 gyba6R8o=
X-Gm-Gg: ATEYQzwdrgSDqpl0hUGaV7feem1JbxaHPtfpdGd85YyKnWdUrwrsE2PdGCpY6yLPdXK
 JSVDYFjt9/Wx1CvVhTWAB1RV5Pxqh7IIllQlBXe3uQhqMSilxQaK9JKyiCw+XEXXJa9xjuzqthm
 OQO3ePzbFn79/iXihtvUym5BuqOL/dXxggmbQtEdUNzI8KykEgZ9LWV/AMoQ4lhuhgPoqwuUBqy
 U6lovSlPl1jZGR0U4Sm1Rq0TTY4QbfOkkoMO86YWtdNSR5iyeZLQvgieUmBf5+WTJDfSlsOEw+S
 wx8PdMBaiJ7/g144N18CVjVzO8Jp73NbozrcQIHVXngxDqnm0Tnl+Rcu8rt2gr8TZPr55V86fjK
 tUr92BkY/Ldg8cmG8l8/vCLaeN3UQs999v40Htj7nYmBcMVEmfDStvU5eL59+Fpopme5D6wp4mN
 bM3Aaq74MDBZnQCWbig46FA8Go38GFTFiVd7SDbTiR0s06rDFWOgE8
X-Received: by 2002:a05:693c:809a:b0:2bd:ad1a:f4e2 with SMTP id
 5a478bee46e88-2bdad1b09cemr499851eec.23.1771911869021; 
 Mon, 23 Feb 2026 21:44:29 -0800 (PST)
Received: from stoup.. ([172.56.177.223]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7daa37c7sm5958093eec.12.2026.02.23.21.44.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 21:44:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] fpu patch queue
Date: Tue, 24 Feb 2026 16:44:08 +1100
Message-ID: <20260224054417.32430-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=richard.henderson@linaro.org; helo=mail-dy1-x132c.google.com
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

The following changes since commit afe653676dc6dfd49f0390239ff90b2f0052c2b8:

  Merge tag 'audio-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-02-23 14:03:50 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-fpu-20260224

for you to fetch changes up to b5fee33bbf2764e9540ab5e6b6af4c9493f65677:

  fpu: Add conversion routines for OCP FP4 E2M1 (2026-02-24 16:21:18 +1100)

----------------------------------------------------------------
- Reformat NaN classification to share code
- Fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers
- Add conversion routines for OCP FP8 and FP4 formats

----------------------------------------------------------------
Max Chou (8):
      fpu/softfloat: Refactor IEEE format NaN classification to share code
      fpu/softfloat: Refactor floatx80 format NaN classification to share code
      target/i386: Fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers
      fpu: Add overflow_raises_invalid to FloatFmt
      fpu: Add saturate parameter to parts_uncanon
      fpu: Add conversion routines for OCP FP8 E5M2
      fpu: Add conversion routines for OCP FP8 E4M3
      fpu: Add conversion routines for OCP FP4 E2M1

Richard Henderson (1):
      fpu: Introduce FloatFmtExpMaxKind

 include/fpu/softfloat-types.h  |   7 ++
 include/fpu/softfloat.h        |  18 ++-
 fpu/softfloat.c                | 242 +++++++++++++++++++++++++++++++++++-----
 target/i386/tcg/fpu_helper.c   |  30 ++---
 fpu/softfloat-parts.c.inc      | 152 +++++++++++++++++--------
 fpu/softfloat-specialize.c.inc | 245 +++++++++++++++++------------------------
 6 files changed, 459 insertions(+), 235 deletions(-)


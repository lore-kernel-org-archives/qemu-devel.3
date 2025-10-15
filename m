Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD192CCD19E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 21:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v99D4-0003bc-Mq; Wed, 15 Oct 2025 17:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cx-0003Zo-Uq
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:38:57 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cp-0004z4-B3
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:38:55 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b49c1c130c9so6147a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 14:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760564324; x=1761169124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bdcGU3hi9Z5/EbuaY8U3gbHHOmLLTJarEwS9cmQnv8o=;
 b=pqAKfLd6Pk5kuVqGrvs5XLprPgLsG0kuuSxUcNo6ZOMD7sougU4Hh875PcDsGltpZa
 n+rkh/yBUXGRB5qtWNZIQOoEWem2DXNzzbh4y+4tMI4DGLwO+Q5R/GgH5br+EB86wlWL
 +MOQD32/qYXOaxCYZk7tMBW6RXIWTj96PjBAnmmZyV4qfHOtPEm5Gg7dYJ50hlej3a1R
 aBjdrZOA7q1eVzSye4V6e869yxNFT7XeiyeQbS6FNV7cyh7cp61vEBEw0t71Kt4+jPVt
 HxTWqYeJmRXvpHZFUOXzo3vDwi+/RuDCL5YpO17sV59I6gQyqELH2JtMa7MlepvySFRF
 Xndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760564324; x=1761169124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bdcGU3hi9Z5/EbuaY8U3gbHHOmLLTJarEwS9cmQnv8o=;
 b=ivFv3my0oqV7hsiQyhQYv3y9t+LWZzHpJNlVzJK/Zylr+j/LJtlbds1aA8UPMCJZee
 WlThZ16vXzfMkHrZPRjoq/np+DWJVLHxKma2T8i1P8qnEQQtyFOpKudcxxKld5HEUetg
 gDTLr+/qO7XAxFerfspUVdGaRQJRqsAzse6mdPmqhA2mUXQggO/XwyV7vO9cMoVCsFKQ
 H26kKBD5wyz0EvMrrMx5KAjmomaYRovMJ5v54atDIxLDBQGTlNpA0PTgE606tu8AdFyN
 XW7xQiYDcX3nvgKBVumSbjM3JnVGmDOBWbD0+G+nXvWqCLueMJ7Eh/XkgZ2ZGwHpGguQ
 IE8A==
X-Gm-Message-State: AOJu0YyDCOaMAXWk2Cr4aCRGjvM22cYNaHwXn0xFcvupwZ4BtYOudS+q
 pvTFZYgUewsdGrBggBDzBAp3Nc0L2KLhFanQbcb+ygR+Ch2pviKupYqjwMsiJgFJCQHrV9cPDLI
 yB6Yoah0=
X-Gm-Gg: ASbGnct+HmewFr+HxpUtnjVxhT5RQUU2giYvPAP8aoBgIqQcFErarMUXYNePCL3AGNu
 WCs+BodlsW9hXFUAW3CmxQprW1CM5LZoGWL7wVEva6HdIz470psvmH/ZKhWxFNa1OyA9RxpewbF
 nDB32fvwdB3y3mVJ5R8eUMRw0j1kCJcJAJ9j1J+mioFuUYejXSg7f0BKZqNgo1Ux2RWPEY1Dblv
 6ZdosrsIChXcH2fQujW7sIUqRYvCR1wCEWRtX58OdnDVoT5PhNZOfAAT6QNE7qp9klrLzFkFPTl
 2dvT7MppzRxEnn62464wzFEDNgwILe+omYINdyWtuQmUDlDy2WhUHa/rhChgAja1Mh+AdphT4XR
 c3efIu4zamS07l+Qqz8RsA2WPFoTD/A08+7FW8B1ceoLrX4B9pqFVqLvSbwqLl8pvRM1W1Z+p8p
 XBXkakR9C4bcPcIEhR4VNalsq1RxyFBY0=
X-Google-Smtp-Source: AGHT+IF0yIjg57nYOqdO3Pwx7N7KNFJA98ENzdWhxXyJ09CqAO/5yKlb0vSYveuSqjsCHLRS6mqGjg==
X-Received: by 2002:a17:902:e883:b0:271:fead:9930 with SMTP id
 d9443c01a7336-290272f835amr439845755ad.59.1760564324336; 
 Wed, 15 Oct 2025 14:38:44 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm6247085ad.65.2025.10.15.14.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 14:38:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v2 0/9] tcg: Remove support for 32-bit mips/ppc hosts
Date: Wed, 15 Oct 2025 14:38:34 -0700
Message-ID: <20251015213843.14277-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

While all 32-bit hosts are deprecated, I have been unable to test
either of these hosts for quite some time.  Let's remove them first.

Changes for v2:
 - I'm going to leave Phil's docker changes to Alex, since there was
   some issue with build images vs cross-testing images.
 - There was a error in the v1 ppc configure update, a 'fi' not
   removed with its corresponding 'if'.  There
 - Additional cleanups for both mips and ppc64.

I've tested the result on ppc64le (cfarm120) and ppc64 (cfarm121),
but have only done a cross-build for mips64el.


r~


Philippe Mathieu-Daudé (7):
  gitlab: Stop cross-testing for 32-bit MIPS hosts
  buildsys: Remove support for 32-bit MIPS hosts
  kvm/mips: Remove support for 32-bit hosts
  tcg/mips: Remove support for O32 and N32 ABIs
  tcg/mips: Remove support for 32-bit hosts
  buildsys: Remove support for 32-bit PPC hosts
  tcg/ppc: Remove support for 32-bit hosts

Richard Henderson (2):
  tcg/mips: Remove ALIAS_PADD, ALIAS_PADDI
  tcg/ppc: Remove dead cases from tcg_target_op_def

 include/qemu/timer.h                     |  13 +-
 tcg/mips/tcg-target-has.h                |   2 -
 tcg/mips/tcg-target-reg-bits.h           |   8 +-
 tcg/ppc/tcg-target-has.h                 |   5 +-
 tcg/ppc/tcg-target-reg-bits.h            |   8 +-
 disas/disas-host.c                       |   4 +-
 util/cacheflush.c                        |   4 +-
 .gitlab-ci.d/container-cross.yml         |   6 -
 .gitlab-ci.d/crossbuilds.yml             |  14 -
 common-user/host/mips/safe-syscall.inc.S |  35 --
 configure                                |  26 +-
 docs/about/deprecated.rst                |  13 +-
 docs/about/removed-features.rst          |   6 +
 meson.build                              |   2 -
 tcg/mips/tcg-target.c.inc                | 319 +++---------------
 tcg/ppc/tcg-target.c.inc                 | 391 +++++------------------
 16 files changed, 152 insertions(+), 704 deletions(-)

-- 
2.43.0



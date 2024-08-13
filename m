Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7623C52D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 09:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdoCb-00053x-O5; Tue, 13 Aug 2024 05:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdoCZ-00052f-MZ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:52:27 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdoCX-0001yA-Ua
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:52:27 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7a1be7b5d70so3751111a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 02:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723542744; x=1724147544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HKddCzONxp6Ew5E7TLBEDVzECHDPn4E2wda03pMwp0U=;
 b=GhL0UL69wUXPYddPiigHiDDi0VM9okO52Ms3cg0H/5hidwdvSvyjESTsFFUp5DerVc
 CB9tPAtxRSYWzxWOslCLnMf4W7zvXCLqHng6M41++g9s65FvKW/Ub+1WXAhGRYV+DCID
 NWZWLj64YGPGXbnpJzVXG7zRcijigQfjLlqTAaiMJZ9SmcLGIdDjBH0JI28O8aWYQLyy
 ysVKD1I2DBuUmTmRlnwOuPnQvPsjVm94wXwllA8Z+XjtAmFryomLyaQAPQ5ECSy+Znw0
 AH3iOJS9HNAaZZVDBSCpgcUFOiHjw2dOehSUQ4y+Ae83T7eZgVtNbOkIr4QWnIeOAmmy
 d5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723542744; x=1724147544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HKddCzONxp6Ew5E7TLBEDVzECHDPn4E2wda03pMwp0U=;
 b=iObO938sksQQXAWdxBKSg6sWcNLyBYFLqNtyXJwKb/hf0rwlf/aHfdzHwrCIyGBrFW
 qVgc4UAevDRSsZkmAeBExknMUQsoXZMM8euvTLJR9eykv+bTrOCb9rqlYMCiR9mS7SYX
 AZ1BeRUsl7dAcmS1uMYeHsPjtcfPNfOoXOK7TmfhK7/gsG4CieXXq0wuOY0Z6wwBlFCb
 K5SLRTBkHbbOCGO1bSnx/ilX+4zkcV4ktDRRm+gTzMS9s97pO63suoM3a6dGkmadZhRV
 87jT5aQHLy1y5cggCuOCjncfDgC7EUjvkyrybwyHvgj4T58JS2QJ2xxAPRnAD3Jbp+h5
 pFAw==
X-Gm-Message-State: AOJu0YwcZsqR8GY9Jv7NnTyVAJuiG9OEbRhW7yx+S76KOv7A2CWY234G
 qGdYLW9zlYRRulldFQ3X6j7IZo+tpidL+1JwpHdgzU75/8BFnxL/D3HU8m9aUwkr9Gxaj4NJvyK
 ov3g=
X-Google-Smtp-Source: AGHT+IEOW5IY//lmG/RwuUEZ/CPA5arsE1E7SBUKajbe1+4SPOoW5WQ2gwMVVXwMZ6QghaHu2Yj/3A==
X-Received: by 2002:a17:90a:1b8a:b0:2cb:58e1:abc8 with SMTP id
 98e67ed59e1d1-2d3942cdf1fmr3443920a91.21.1723542743971; 
 Tue, 13 Aug 2024 02:52:23 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1c9ca796fsm10851876a91.30.2024.08.13.02.52.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 02:52:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.2? 0/2] meson: Rationalize sanitizer configuration
Date: Tue, 13 Aug 2024 19:52:14 +1000
Message-ID: <20240813095216.306555-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In the CI that we actually run (x86) we don't want to use ASan,
only UBSan, we jump through --extra-cflags hoops to make that
happen, and we fail to disable function sanitizer during normal
configuration.

In the CI that we don't run, we enable ASan and fail to disable
function sanitizer.  So its a bit lucky that don't run it.

Split the --enable-santizers config option, and move stuff back
to meson.build from .gitlab-ci.d.


r~


Richard Henderson (2):
  meson: Split --enable-sanitizers to --enable-{asan,ubsan}
  meson: Move -fsanitize=undefined into normal configuraton

 tests/qtest/fdc-test.c                        |  2 +-
 .gitlab-ci.d/buildtest.yml                    | 10 +++----
 .../custom-runners/ubuntu-22.04-aarch64.yml   |  2 +-
 .../custom-runners/ubuntu-22.04-s390x.yml     |  2 +-
 docs/devel/fuzzing.rst                        |  4 +--
 meson.build                                   | 26 ++++++++++++++-----
 meson_options.txt                             |  6 +++--
 scripts/meson-buildoptions.sh                 |  9 ++++---
 tests/docker/test-debug                       |  4 +--
 9 files changed, 41 insertions(+), 24 deletions(-)

-- 
2.43.0



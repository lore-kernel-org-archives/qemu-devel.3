Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B40CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 17:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZB9-0005zJ-0G; Tue, 16 Sep 2025 13:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyZB6-0005ym-Sf
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:09:16 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyZB5-0001Ou-63
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:09:16 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b4c1fc383eeso3854567a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758042553; x=1758647353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PHNssKe8hNkq5OW2n5ixjguJvVB6rE41HLGD8y9vUjQ=;
 b=N6XHudwHZ846B4SCnLyFMjAEIVCL+Qm8dxc2hynwbPWhbFewZ7wkEd7I3EwWrsVBfa
 IDpLgp/4JgINi590jLPbufmxWOepJHxkFn9350uc6ImStxjXoml1Ys6tI0XZ57vHCFN9
 36ya/aEM592aZKT9W9mCc5AoCfjZpWbkT3ZNVBV3vUYP+jz5HeAj8x/6yVR5G/odtAJX
 1KLsZ2CXJXckrcwPLYYOMTj4Ge5zC4ajxIOWNC3g/Opny4uzFAL5pDv7UUwIe+UBI0jQ
 Y/Wu5Ze+NhIDzk0oOOgT2+X2R7mzOBnBSBnrUnQBBiE9WNyqX1cvwSP8fxwDnNq2Mi01
 Ol3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758042553; x=1758647353;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PHNssKe8hNkq5OW2n5ixjguJvVB6rE41HLGD8y9vUjQ=;
 b=JTd34xqduHyHHF/oAO+/Q3l/C1rQirICaSJnaFKmXrTo23o74DUHpW0pjQAyKqLP6P
 hCjRwqNDt0AFXPubdD2RIK6OBSoAHduHTNDf0kokNgH2dT75ijTHX3E2zCW2yC+wPXk8
 HD9n69z1J/rn6YnKxvDsRWlZUw0T5qrJ3GBXySqt5/j0nilzpSpl3Ha99dwwfg9xDkQW
 pGBDfW/0TzSe6VmGP4nQvjRcxaLNdX6I86w9xRgOSDtUGmWnJulAg2otaQUN9+oC6FmX
 ghMo/4yN4oAt4sYEZbKx7RN00lqZxyKNMLYHIhFP+5GnBFK/CpFZt0QzNdsJOYMuikMQ
 vRjQ==
X-Gm-Message-State: AOJu0Yw9GXrhg6Zr7ChSyy4qSsnwwuSBqQ5V3FZKEAxw4b1duj+s5H5S
 KcvTBMgXuULuS1jytfSIuRIw0SEpOztnEFnRb+IHYBwQhdY0oBQwdllsUGx86MqP5cfHdgFeyZc
 ddQao
X-Gm-Gg: ASbGncuzHIPFKOGIRonF4h5a6sc4BG0GsIoiWpKZS2uC0PZhL8i0JuMeI/N1KAYDMqx
 hoQrup15t5g1J9dDQkzFhRvqEq+7FJd5OR+eB9hfue/7UKfSwrNYZFKbcgtc4jJnU61WhZS7mul
 WQ9onGyubBcx6u10kkgTLe3tQDI5Sx9tb9jiLuiI0lnPsRltRKqkqj1uYqCtAr6XD7o0ICYohwR
 PsIFiQ2HOWz9qKGvDVmT0RUmn6PeUCDINi4AT7H0NeCsm1QS9uWnKDY56jbv5ZCCQqPOmrHlatw
 fahSE7dGHimIkEl2GbQJFMbJpCN5zxGVAK6PwwwsphfYEPENELgLe5hXPYahs7CJj335XjEJT7R
 cS7bcXNyAExkGqNudILphPCNBybBo
X-Google-Smtp-Source: AGHT+IE2d5jROfU8RRizUHMBWfr7NCsY7GrEW6UVQk3TYRFRnCmhipN0cuq+sHxeFVlM6StsTb0kAg==
X-Received: by 2002:a17:90b:574b:b0:32e:3f93:69dc with SMTP id
 98e67ed59e1d1-32e3f936d2bmr10436135a91.25.1758042553197; 
 Tue, 16 Sep 2025 10:09:13 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32ed275e795sm95531a91.19.2025.09.16.10.09.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 10:09:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] misc patch queue
Date: Tue, 16 Sep 2025 10:09:10 -0700
Message-ID: <20250916170912.706610-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

The following changes since commit 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d:

  Merge tag 'pull-request-2025-09-09' of https://gitlab.com/thuth/qemu into staging (2025-09-11 12:41:01 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-misc-20250916

for you to fetch changes up to a11d1847d5ef8a7db58e6d4e44f36fec708f0981:

  .gitmodules: move u-boot mirrors to qemu-project-mirrors (2025-09-16 09:58:20 -0700)

----------------------------------------------------------------
.gitmodules: move u-boot mirrors to qemu-project-mirrors
tests/functional/x86_64: Accept a few locked pages in test_memlock.py

----------------------------------------------------------------
Alex Bennée (1):
      .gitmodules: move u-boot mirrors to qemu-project-mirrors

Richard Henderson (1):
      tests/functional/x86_64: Accept a few locked pages in test_memlock.py

 .gitmodules                             | 4 ++--
 tests/functional/x86_64/test_memlock.py | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)


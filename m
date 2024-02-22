Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70CFC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 13:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8pN-0000uC-3Z; Thu, 22 Feb 2024 08:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd8pK-0000tb-5V
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:09:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd8pI-00085s-64
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:09:25 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4128cfb6c1aso2281865e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 05:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708607361; x=1709212161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sj5SqmgaoIdnoP+EWMp9G0M1jv1sVcZURPegVsoY//w=;
 b=QDuLO4iVpUpOIRX2K8qOUUF1vek73BbQ8blnXIIj2Rvi9fnIa7nmI835w3pecXLb+R
 kTQnGBD4mOCErrTc8gSm/Px05v44XlRPje7UYaJzYSR/YX0YQjbAwe4M1/mgo3NSoS+3
 Cz4f9ZTlRSDHhfYsuNnsGPbu+xtG3zYKCtlCf7Mt+OpUWs/HU67v8U3ZV2gMLvcf7rF2
 qmPwIqL1TonD7sRBltPDZN+sbvvh4r4L0Sf3POZszon4w7zson+8WhPGty8zsrL6Bem6
 KwSfR5WEasXX/35gzppXAQTzy2AUJ5FHMh0GviYs1Rll7oH5jHBb29VEOiYM+Dy8Iv4y
 1NLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708607361; x=1709212161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sj5SqmgaoIdnoP+EWMp9G0M1jv1sVcZURPegVsoY//w=;
 b=m7ffZ6w/9zz9cvXGUBrNBtLi0nikKvyVqvPAVNgMPJ5Kf+ErvqTTM2Dat0D3aWI1Ck
 +/Z3Up1Kt/2TJ1RS7DQJkNEBK8UPSw/53qqdOqckko2ebC7nRLzU3J8SRJZ39jyJkrHq
 EPSrIrn4qH31YgHE30ytV1eV1Q/+YrV0r73iwqAMdspTVqZ6USYaw/3r8COinuSLXs+y
 CNCsl8cOML5XYHh0dRZXBoTCKBKX+VeaCxXEvjhjrwp0APBnHP621uJb+TgozsMJg8b3
 yfvV3NjVt28XtcfqXezsz/H6YxLxfpxGhSLRb3FNz/tTQeShBXtk0TVz3TfGcPLyPE7z
 jRZw==
X-Gm-Message-State: AOJu0Yz5gjytVcsxIPrIg3A5S8fnCYe63fSwq/6OEz3/LHX5syPF1JEG
 PD93qgweA76UYaa0ByvMiUij/6tUi/fEoXKfV0Hn7pa1WReU3VvgiQ7McSBbV6rRLDxbDrXiEN/
 y
X-Google-Smtp-Source: AGHT+IFc/zwIz6eEAx27j1xrfn6Bos2q6XwXobdOzgLZqME9qHJ6aqnYQl0CgZS5i4Ij/hrnWVxZSQ==
X-Received: by 2002:a05:600c:3b90:b0:412:7b4d:23ac with SMTP id
 n16-20020a05600c3b9000b004127b4d23acmr2312627wms.0.1708607361478; 
 Thu, 22 Feb 2024 05:09:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a05600c155300b00411ff030f06sm22434458wmg.9.2024.02.22.05.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 05:09:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 0/3] Drop 32-bit Windows as a supported platform
Date: Thu, 22 Feb 2024 13:09:17 +0000
Message-Id: <20240222130920.362517-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

This is the not-for-stable part of dropping 32-bit Windows support:
 * document it
 * drop the cross-win32-system job so we don't spend CI
   defending a config we no longer support
 * drop the shared-msys2 yaml template

v2 changes:
 - drop now-unused MINGW_TARGET variable
 - document why we need to set MSYSTEM
 - restore comment text truncated in commit 11961d08fcbddf
 - add missing Signed-off-by line to patch 1 :-)

Based-on: 20240220165602.135695-1-peter.maydell@linaro.org
(".gitlab-ci.d/windows.yml: Drop msys2-32bit job")

I haven't done anything about possible adjustment of
what we cover with Windows compiles; we can do that as a
separate patch afterwards if we want to.

Patches 1 and 2 have been reviewed, so only 3 needs attention.

thanks
-- PMM


Peter Maydell (3):
  docs: Document that 32-bit Windows is unsupported
  .gitlab-ci.d: Drop cross-win32-system job
  .gitlab-ci.d/windows.yml: Remove shared-msys2 abstraction

 docs/about/build-platforms.rst                |   2 +
 docs/about/removed-features.rst               |  15 +++
 .gitlab-ci.d/container-cross.yml              |   5 -
 .gitlab-ci.d/crossbuilds.yml                  |  14 ---
 .gitlab-ci.d/windows.yml                      |  85 +++++++-------
 .../dockerfiles/fedora-win32-cross.docker     | 111 ------------------
 tests/lcitool/refresh                         |   5 -
 7 files changed, 58 insertions(+), 179 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker

-- 
2.34.1



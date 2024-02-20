Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11F2C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 17:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcUAE-0003Ah-TE; Tue, 20 Feb 2024 12:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcUAD-0003A9-9B
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:44:17 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcUAB-0005J5-Od
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:44:17 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41271fb0087so3093305e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 09:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708451054; x=1709055854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qa0LbZabZp8bgi5HynXcV2N3ez2nOXZAr+CoDNN9QKc=;
 b=hL1eRKJHgbAn7EsWsK7Q75igR6pIkVlVi/Gx8EW9rA/6Pmigc4BPB4LRNk2pPN4xgq
 mBNbQUfAxZBw/VMpOzrzkoI6Q0V3wO6/Q8OLdDO07G1/FSdn8KfqZFkBxrCTPjb+IMID
 GGtk2zkz6y06yvexoNupocvORP3SxDQ0BCxgrJGgDYrUfYu6zCGhwsqZZLPiEGrADFyl
 Hf30zAn9NOKpMwGiuFKeOQC36cenUeA0cMpKsiwB4w6on4sJ7FUsihjaN4I16NBdwTDz
 tIM0yfCtV+0AuMWLMtSinGgDwErT00mVsE3+neR/pV8o6Ae0mXzqyYP10IubZouqKOQn
 Dm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708451054; x=1709055854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qa0LbZabZp8bgi5HynXcV2N3ez2nOXZAr+CoDNN9QKc=;
 b=GUD12nwalcDDCyo2gTgnG93puYzKPIRhru9dy4dLlIVXA8C8X+xtfrKA8xrK6ackbw
 3VdJatDb/8aJI3u1QT7Z9B2sVlVlUUPPjDdvufT0V7qgzrvFaxUAXABIxnEetrmvtVfr
 ghmBHjp0rQSIdr3k9ZWBx8IvG1fGbHuz8sufqKUXFLLw0NY1/si1cwugQkYAEdMYS+kK
 rFN8YweYtzFPimLwM4yBDVKZepMa6ocoyTmonuT8kdg7QnBsoWPm0nlj3t2PuxvHIlDx
 h9OpzQlDQEMgmSl3JEj1u7hQLYRyA61JskxymHBBACefkw4jHSLHUsvtjFWYDDTTjNoa
 gPOQ==
X-Gm-Message-State: AOJu0YxTSM6++DZpq/THlGU9IiZ8VGn2FvQYZKqgs97kERVDJsrYsu/r
 Ye+q6SZCZ4nWA/X+0uQ8Btd+U1o99EDZCm/JN+XHInXJk3/2Qu7mpZI04QdyiIxkzrqQDbcmr1C
 g
X-Google-Smtp-Source: AGHT+IGyC3j/8A+cKU9/WmHt7g3ZdsLGxtfdlDldVP4uGjX82Eas3cNon1rDTcM8Mv3ErskQcp8Esg==
X-Received: by 2002:a05:600c:4f83:b0:411:fbfa:959f with SMTP id
 n3-20020a05600c4f8300b00411fbfa959fmr11924617wmq.27.1708451054064; 
 Tue, 20 Feb 2024 09:44:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k5-20020adfe3c5000000b0033b66c2d61esm13988443wrm.48.2024.02.20.09.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 09:44:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH 0/3] Drop 32-bit Windows as a supported platform
Date: Tue, 20 Feb 2024 17:44:09 +0000
Message-Id: <20240220174412.155885-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

I think the only thing remaining after this is to update the
website; I'll put together a merge request for that either
today or on Thursday.

Based-on: 20240220165602.135695-1-peter.maydell@linaro.org
(".gitlab-ci.d/windows.yml: Drop msys2-32bit job")

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
 .gitlab-ci.d/windows.yml                      |  84 +++++++------
 .../dockerfiles/fedora-win32-cross.docker     | 111 ------------------
 tests/lcitool/refresh                         |   5 -
 7 files changed, 57 insertions(+), 179 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker

-- 
2.34.1



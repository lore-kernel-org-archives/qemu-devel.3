Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5B3C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 14:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufJK8-0000Z2-NF; Fri, 25 Jul 2025 10:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufJJu-0000J2-Ej
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:22:47 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufJJs-0006RF-MM
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:22:46 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b49ffbb31bso1539501f8f.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 07:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753453363; x=1754058163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KjZxSUkKuoSlBeOsoilN6PWi4r43CBZwz/micDLTvtU=;
 b=zynIToSjAqxZuwGWOLCft9NVVZetOBR27la4CpterFguOOrmnPJqcSSk0TyhvWC/u3
 eLbHGu2pbvl/EvqZO2AzEjd3sikGPQrhBAbZawxPaavZ39yzZzmcdwSmLfJMPmElCKRS
 LGWCF2g+lCDGRc5CHeev1wPMecs3QJB8sC8YbLq1imPx99mZNuy7KdFO7HjEzSo8IROX
 S14bYvNAlaRta74WW0ZTYtu/WDsrHuzAspzOvn897RqYawGgCRoXFEtLYjW1hLW1KHjr
 NaFLVP+UOxZECaKj9kqreT441Rdt0grBW1YqYftVs4C5WyZ0n31R9NHNf3gFCRTOrDRn
 vprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753453363; x=1754058163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KjZxSUkKuoSlBeOsoilN6PWi4r43CBZwz/micDLTvtU=;
 b=kM8RfDKUtIYnZsys9Gp/Y2m3h+kmo79a1X9hMKTJU1gu23OChTk443AnZNPNR6u4OA
 mvaWkc60McmUnOQqRQigA9PN1dZiI040fNeiDl5flK9ysOc3bV/i7j9fxMJFN+szw4oA
 OCmbNuM14z+BQIVnow5yq/ojimLc9kEpqxNeEWBnwXEhKOdGHtXHB+ySkKWLe/AQFnec
 E54VKY1Nu+Phbfd9opoUIt/sNpDQyjKGL0nsyKfxVWrh3q1LnXXSir2iFpav2h4uM9Ek
 BMyqCh8vY7ehFwUou16AmtZXxrxYOeO4UPalFgkjko18b1VnC9gRAsjH6FDND2P3XGY7
 ShMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3ZWjkpwObj4LGZlILe90+MNLUr/zMLd9nsem5xnFNKHHtJIm6wLlgIcCI2q5OkXuOGrXMItUUHXZQ@nongnu.org
X-Gm-Message-State: AOJu0Yyf0WnuvGyp2kPbrs0xqHw6z1Srckvc65xwYhVmeKVnfsnJHu4o
 hpbwruXX9jO7ltYkLNmbxWlMJvEkIyDh6FOAEAlTAKFsAdInyGOxIRXf2wh1WByyLOE=
X-Gm-Gg: ASbGncs7tAIyM9PGRYMJvUuJaLSlB1cKBkctGruQCq4HQp569Fpfjux/XhCEkTEOyl2
 j5rdskSMcU+dD+jfu5AUKGfdzPKwiImLYtYFf/7id3isAW+Nfp2LXz2faPv4Dpsnx8cVYLdO3iK
 D3/PIdqyjEA0fFOBIYt8YiXzQBNG+RtOGBgQ/JmggOCDKmE+yp0D+5U5hWjpBkX/Bzwl2DxzaXP
 kUJy2bgf6k+qK8lkfPZqp+9MBfBL6onlg223CiUUXEDedLGSv2C0f+TPRMqNrUYn77meacuPeS0
 9ztJdsJ6wpd59AHF+/BDbYQ9P4ssorUgl07OcWZKQnRld3Um6FHSFkjgCIMknxah3A/cDX6CyfM
 41911FPJsj0PFZfcV3VFNrzae+TYB
X-Google-Smtp-Source: AGHT+IHOZE5q9ojvEWMRQEkiX8snqspJCdHw0gr0rEpz5yMSjthAj+lY+DOKQ/YAq8VzGMAbrkd7aQ==
X-Received: by 2002:adf:e3ce:0:b0:3b7:7377:8369 with SMTP id
 ffacd0b85a97d-3b77675fcd5mr1578019f8f.38.1753453362741; 
 Fri, 25 Jul 2025 07:22:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778eb2bccsm67065f8f.7.2025.07.25.07.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 07:22:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH for-10.1 0/3] linux-user/aarch64: Fix SME/SME2 signal frame
 handling
Date: Fri, 25 Jul 2025 15:22:37 +0100
Message-ID: <20250725142240.3760452-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

This patchset fixes some bugs in our SME-related signal frame
handling for linux-user:

 * we need to make the equivalent change to a recent kernel
   bugfix/ABI change: TPIDR2_EL0 should be cleared when delivering
   a signal
 * we forgot the TPIDR2_MAGIC signal frame record (which is necessary
   for SME v1)
 * we forgot the ZT_MAGIC signal frame record when implementing SME2

These bugs generally only surface when guest code attempts to
unwind an exception from inside a signal handler and SME is
involved. Discovered (and the fixes tested) by some new gcc
test cases which implement their part of the bugfix/ABI change
 https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b5ffc8e75a8

thanks
-- PMM


Peter Maydell (3):
  linux-user/aarch64: Clear TPIDR2_EL0 when delivering signals
  linux-user/aarch64: Support TPIDR2_MAGIC signal frame record
  linux-user/aarch64: Support ZT_MAGIC signal frame record

 linux-user/aarch64/signal.c | 142 +++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 2 deletions(-)

-- 
2.43.0



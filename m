Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53EBCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 12:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Iq5-0006A5-Tu; Thu, 02 Oct 2025 08:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v4Iq1-00068i-RI
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 08:55:14 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v4Ipl-0004Qj-SU
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 08:55:13 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e430494ccso5612675e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 05:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759409688; x=1760014488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oxMGzUKJ7WfTpfWuE3+CdDd7dE60jjWx7PfdjuN26/I=;
 b=SlMP8HtlqTK0+0o6Q2pFIa5dXpx1DosdMlB7FGikndemCnt/iE0vOL8pHKUBOxWrg2
 D5pTO5YW1ns+2fQzr+6Vq47qNZ9y1bwWMeM00GTwE4oYs3Pkak1ZsX17NgDFpqjEAVBP
 o5Hm6fDO3hQ4HpQhgs3QE01ig3U/2/rOIEpEYXsENgfxX2TjTwNFMtYlHKtAs2qiQQOj
 5UknRrfaxi8yeAJO2f1JIpe/Q3AwjTVPXyrqJjNJPT8Eu5fVV/C61o0LbKNDFTYXcYFu
 eLJAgkeGqs1RS9LgaHLEVHYBvKe3bp1lUZdcYiSKipmqHNmmIJFm+RNNCaHCZFz4pOKS
 rCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759409688; x=1760014488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oxMGzUKJ7WfTpfWuE3+CdDd7dE60jjWx7PfdjuN26/I=;
 b=v8TU+qEQklSwNO6VwJSiU2JdeeeU1hgdvEnAWBHjL+HSRuIAhhbmZJXIC83rM6Kyz6
 dGHWYqLYspkFP6KtF6DTmE7v5T2bX9HN9hqXTyhlB3z2R2Xcs+buAMDUys49+wqbQRHc
 y+BzDnMxwuWi9RrtY8a3GULqbByvtrDpPtuex8v6kTuiH0IASbcEAqSPeBVNB6Qlr0bq
 KVc6JmjvqVFwFTmgjGGrwH5cJbmsoXSi11OncIx5TOItU0iaBigrhDJRNV0AoZXyZC34
 QXDSEGKP1g5kSeyHcOlwTg/IbNXZMK0/5GcUhz/G1Yc00pSVUdPTx0Xdg1PwSPUtbYfJ
 PLHQ==
X-Gm-Message-State: AOJu0YyC1kLasuBwTIYpycGHYf4QBbb0a4V/X8J3QvoSGJa4QMeuFmOm
 twfZGg+eBFNG42aP+9R/Pna83UGjDUTAdwKi8P+Il4aOCJvoXH+vhiw1Xf+AxBUu/eQiaEG3Gyt
 JRrXp
X-Gm-Gg: ASbGnctAomxY6soQfwlSQVYv3dU19VYtpVx5rikURQFGopGuAQvjnLgamU9aEXTGm0q
 UwF7t+dzThfjZ4mUBIwYczYZGhDrBDNoKixnqbP3febgGMl2wcdrFbSdY49ZKII5nfLYzsiFA2g
 BYTokCuHYrm9Zn4iXb7mw/4pXCh6lVJZKqAQptErp1lI1/3lnOxfjhmxAuN4q6SizXPYfk+a9qV
 D+xjzJQsPXRZdAmx2EP1GWuCnqiW+zkgx2mQAwRua/QzntSKXmMTdctQy3kQEK+hhQH9BCzaVqJ
 AhseSBXne0tp/PwJV6UfcqqeXVCH8Zl+LQYlB4V1mvWbQeREvdVBcweKYpwg1GeS39FWzWw2+ES
 sMnGCTunCmuaGifCe9I9GbuREa0DLgi/i32/RxDaQb3xRlOKLj7XysG0h
X-Google-Smtp-Source: AGHT+IF9lmHT+2erYTnOXSHqTiLpElfPxH3+gwz30hcLeC5jnPTwCgCpPO+vuC7WoKTkwH72IF7M0A==
X-Received: by 2002:a05:600c:620d:b0:46d:996b:828c with SMTP id
 5b1f17b1804b1-46e61218f70mr63789555e9.10.1759409688280; 
 Thu, 02 Oct 2025 05:54:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b8343sm81771525e9.2.2025.10.02.05.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 05:54:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jeff Cody <codyprime@gmail.com>
Subject: [PATCH] MAINTAINERS: Mark VHDX block driver as "Odd Fixes"
Date: Thu,  2 Oct 2025 13:54:46 +0100
Message-ID: <20251002125446.2500179-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In 2018 (in commit 5f5246b6b) Jeff Cody stepped down as block
maintainer, but left himself as maintainer for VHDX and with a status
of "Supported", with the rationale:

    For VHDX, added my personal email address as a maintainer, as I can
    answer questions or send the occassional bug fix.  Leaving it as
    'Supported', instead of 'Odd Fixes', because I think the rest of the
    block layer maintainers and developers will upkeep it as well, if
    needed.

However, today the way we treat subsystems which are only maintained
under the general umbrella of a wider system is usually to mark them
as "Odd Fixes".  The vhdx.c code has had no commits which aren't a
part of more general refactoring changes since 2020, and Jeff himself
hasn't been active on qemu-devel since 2018, so this seems also to be
how we've handled the code in practice.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
(Jeff, I've left your email in under the M: line, but we could remove
it if you'd prefer.)

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 406cef88f0c..a3a1ce5cc61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4043,7 +4043,7 @@ F: block/rbd.c
 VHDX
 M: Jeff Cody <codyprime@gmail.com>
 L: qemu-block@nongnu.org
-S: Supported
+S: Odd Fixes
 F: block/vhdx*
 
 VDI
-- 
2.43.0



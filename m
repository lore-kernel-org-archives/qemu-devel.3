Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93536CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 12:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v11iq-0005iq-1v; Tue, 23 Sep 2025 08:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v11iI-0005CV-Jf
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:01:44 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v11i7-0003Ku-H5
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:01:40 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so3459010f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 05:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758628884; x=1759233684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=54hFyXF1XYUQuxGdWNU3fLqwHsZbQkwurRxxRgOmLPA=;
 b=XFMtInHAEwfqtuG8WwW1E206DhO3AabPrLRaPLPGHc1vj0hG8sNpqCMazhQKiD+irp
 FPDRa9WtSBIL4dKFqIYRW7Sv2rAwVh/uEiUq2NL+PKZ4uqoWF4racxnNaOP0WUV14X48
 8MNwr1UN40dVEOoa5Y/WzS21C93PB5N67Lka+IruKzz/JvvNJXelQes2FbLdGV+C4oP5
 pEKOUvij8TmioPiJCPsxzzJipRpFSAyeAnBHs1OZ/su7Fuoh3CBf//Au17NQBm/7Qyfc
 EY1PF9Qr1BSBFtUQSa8vUcCmf5CuHzNODjFawmeTGwhZT9UOFLa+OM+l2/QPAqGE0b9k
 swlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758628884; x=1759233684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=54hFyXF1XYUQuxGdWNU3fLqwHsZbQkwurRxxRgOmLPA=;
 b=a/3I2D5zpaU1Oh0ED3iTrbTHnKI7se4WvG8daVCNK6xbgzHqmS4Y5LrvtB0gPSBfa2
 30EUEYcfKi76nkSzntXpVrFlcawG0N1f2S6JW+9HNiHxI+XCKoLgenWqF4weZwZRm/F2
 6inLUbwqy7aTx9PJk9PMHdPWrHKqxJ2GyQnkXxz0PJWtkDRZchRuR8+3nNDO+rfl4viO
 E8dRjEC7zK8rU27rRlDlenndKw6AbpvpiCJuyGYNYjx9L39A1+tK6I74h4DqgHI6jsro
 MvPB+8dwmsyhnf2P3icsMQNUy7c6jFePwmKcG5cVT/eNMPN1TgQAaBEdMcshCtJjzyF/
 rikw==
X-Gm-Message-State: AOJu0YzCFhvw0dbybjLtd5WiFeiVns7SSU2nuletY0SCvgkLZHhS8Ea1
 ocr2VzkSJhPWfNRHCvuARKsupkI44BblAIw4SlfVkI0Ju9zCQWdv8uP0OvTiL9PRBTxbr/MMf9c
 iWatA
X-Gm-Gg: ASbGncusR1B9DZNe3fxHV/YN4VN191h2wA5GVwR1OQHAwt8jNuj8KHE1AR3K9j1D8n1
 Pt3613wsuhIXRYykT7zzkUXVgk59kmtawrNA2syt16WOKr/hlavoZ4f3dOsqI5dBgHdb2TaLLjI
 yMF5pMQQ9sVnG9crv7sZLSH1DQ2sp52quYKDH3IH4N4kt42Xz16uMiz4TcLx7lmwySt5BX6HiMx
 iQD+3IxA+6zIhsq7McdcO/3lC1q5FUbg5YZZxJR26F+UuoDHa9E63rt2+pqMOPxH3zyenHlQvPR
 bO3cQBHvot+G7z4+Djb2T56LSqiLz4cxF8Jo8XeNMalw/+6cVavPuRXUVUB4/Dks3MoTHKJGzAK
 ab7mwg8jiU6ytNcELtJ4Uohzwwlar
X-Google-Smtp-Source: AGHT+IFRGkQw3wEEuf9fH6gi570fbfo+WzQWc+Ejc0rHD/1W17Yax/Mb45NlT9Tw2yLlwKoYun8mJg==
X-Received: by 2002:a05:6000:2891:b0:3e9:4fe4:2619 with SMTP id
 ffacd0b85a97d-405c5ccd047mr2271433f8f.25.1758628883618; 
 Tue, 23 Sep 2025 05:01:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07411f4dsm23527878f8f.26.2025.09.23.05.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 05:01:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH] docs/specs/spdm.rst: Fix typo in x86_64 architecture name
Date: Tue, 23 Sep 2025 13:01:18 +0100
Message-ID: <20250923120118.858581-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

The spdm.rst docs call the 64-bit x86 architecture "x64-64".
This is a typo; correct it to our canonical name for the
architecture, "x86_64".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/specs/spdm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/specs/spdm.rst b/docs/specs/spdm.rst
index f7de080ff0b..0e3ad25bc69 100644
--- a/docs/specs/spdm.rst
+++ b/docs/specs/spdm.rst
@@ -102,7 +102,7 @@ Then you can add this to your QEMU command line:
 
 At which point QEMU will try to connect to the SPDM server.
 
-Note that if using x64-64 you will want to use the q35 machine instead
+Note that if using x86_64 you will want to use the q35 machine instead
 of the default. So the entire QEMU command might look like this
 
 .. code-block:: shell
-- 
2.43.0



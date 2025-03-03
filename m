Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B94C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9Xf-0007cn-NV; Mon, 03 Mar 2025 12:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp9Xe-0007cL-86
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:25:22 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp9XY-0003qo-Ls
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:25:21 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so2886089f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741022711; x=1741627511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q2n/7LGVcvZCpAEvUUQtrbIm4hrmksDWp7gM/OU8gmM=;
 b=Uz6sLTtHeurkf7OumAV+9uudGMhGyPNIshdGFsBOnO70phNVqNT2narL2E5CKvwGA5
 K+8d2Q0DlCiEZWyIDab3PGXWVV2wUNjHti6YQIlmIsGG4JpokWvWr+YV0qwJVR6pNRp/
 1tYVwRB753k2BXc10S8JAOMX7uWkvbdJVrar8HiDGSBfS7IjdKZjUYRCSIerpDtSA2HG
 du/pXkaz6JKaZb1iL/5aNBl9n/NXW55LguN1hMBr5zoeu3C6JqAVrHkXPKXLhqEril4h
 bP9Lb5tWC9iz+GNxfVRPXNnwoyz25pfkoMQ2nxnK9CMUzOLY1c26OXho6l4Cud303cAJ
 Af4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741022711; x=1741627511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q2n/7LGVcvZCpAEvUUQtrbIm4hrmksDWp7gM/OU8gmM=;
 b=qz/DcyC+/7pHMaNfXf80lmQ5kdjAJK+Rl04wr5b7OIa7WKBiEivD2SLwoWx38fwQb4
 KnCPUA7NzUwI1WvHJsgmmtHsPA5MYNmw2BD+fm61Yy3Bd3ZzLWWT/q83V5FnQRM4WO3j
 47bnFg3KAfqLnntXn1uH1xl682oKMRzK6dK/Zg1J9ZRa0QQGVoJETxyCd59+NGh2uqYS
 ZHrsjZs0CNT3Rf7VS5IZsNsiHO4WXyqI445bbkdZ8cLfi5DIzgkemKuPar+W66yWC3IH
 VFXj+sVNCeaAk+XbT+dYYU45RjaT9bUh7LmQCn0Aqq5gbLLHs06PJjs/6E/LCFET0XH4
 zyBw==
X-Gm-Message-State: AOJu0YypMtecnN+eyVVC2lxTMyrlRMbcR4P5W2k5a3FV6KD3Ehns57mk
 6LU15IoxQh/sYCqNv/njVaLPbSHrWEwIGdDBOljGAvcRyVe4+T3lToMS03KtM5vuQGW/IOczMhd
 b1Cs=
X-Gm-Gg: ASbGncuIY3WwddQGFzVtizJbU51nsHZLabL53WeGNhvVhwkPSTODVv/IqF0YY+1bDCR
 6GQV/83mHfIqv5Y3Dz62v8j7ZiThmSdpx0K3lcu+6UQ4J8Nw6LIXnP7+N666SaLwjeyoxedeVuC
 UsDAJY5PNOY7gtGKHL4xkbLmRsX9X6280IfuGFHByNUT9UAnkoA2Kjg8WbWaPc3N0Lz7/wWHq3L
 xKouUFtdklMa9HCNHWWYfiNtMvokGm3HqC7tywXJOqQ2pUqX66+OJCEUaH76D+Nr1PGQkJPf8QJ
 wSkUUM8UAcAeTNwVX9e72Wz797r5qEtG3SAFEINhzilD7T2POYx9GRb3IkzWUHg+KLj7U0uUrsq
 QP95INV40xUZEUgzJxP0=
X-Google-Smtp-Source: AGHT+IHkZewJglmUB9dIRC97PAnCeM2OClZUiR6qD+JhuynwX7l+QSCSEkOWPlWd5NI9bZToUYrNVw==
X-Received: by 2002:a05:6000:2aa:b0:391:4f9:a02c with SMTP id
 ffacd0b85a97d-39104f9a4cfmr4856642f8f.19.1741022710700; 
 Mon, 03 Mar 2025 09:25:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a5b96sm15011092f8f.29.2025.03.03.09.25.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Mar 2025 09:25:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] scripts/checkpatch: Fix a typo
Date: Mon,  3 Mar 2025 18:25:08 +0100
Message-ID: <20250303172508.93234-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

When running checkpatch.pl on a commit adding a file without
SPDX tag we get:

  Undefined subroutine &main::WARNING called at ./scripts/checkpatch.pl line 1694.

The WARNING level is reported by the WARN() method. Fix the typo.

Fixes: fa4d79c64da ("scripts: mandate that new files have SPDX-License-Identifier")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Possible candidate to apply on /master as buildfix
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 83b59fb4436..6ae9d7febee 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1691,8 +1691,8 @@ sub process {
 				  "'SPDX-License-Identifer'");
 			} else {
 			    # Other files MAY have SPDX license if appropriate
-			    WARNING("Does new file '$expect_spdx_file' need " .
-				    "'SPDX-License-Identifer'?");
+			    WARN("Does new file '$expect_spdx_file' need " .
+				 "'SPDX-License-Identifer'?");
 			}
 		    }
 		    $expect_spdx = 1;
-- 
2.47.1



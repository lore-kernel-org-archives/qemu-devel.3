Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AB9C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5Ksq-0003Bz-GK; Sat, 12 Sep 2026 06:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5Ksp-0003Br-Nz
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:22:55 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5Kso-0005aB-3o
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:22:55 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so569209a91.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789208572; x=1789813372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T+5eD0HNYqMz1DeaDmdnjOqjztQqntGhgVHGN/XhaFQ=;
 b=dJ4lvZnGba9ct8OdWlmiB2bAWhgFwf4WLZpJjp3RzX82GSAa9bUk5aRPfhThFnbUSR
 c7IDm+ZLE3Z8Mz8ia+xht0/yz4GKvWfWgfpiYog1A2PiBy122Uc9xTo7SIVM8mYTJi3s
 Gl49HT5YrXrsllvbTX3dllpbGE5IZ9fI6/QOhie1QeNWN1vCcre//H/UandRz6TdXopW
 Q5XNqYGyDgXr4uUo7aBY3+/0a4H/v1F62Hr5zVuksBzAajwoRDhqtYtyvXpmH14g7gre
 Kp4LGmfn8y0vXnQJOTBJZy/p8E2Q/Q1GDhu264sTvgoEpM89N9WqVphyuNaWQUmjQVz7
 Q4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789208572; x=1789813372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T+5eD0HNYqMz1DeaDmdnjOqjztQqntGhgVHGN/XhaFQ=;
 b=eTeqshrazC0USQbFT5EZkrDrnPuyR4sDs4j3jzei/egPnxTDf9cw3T9clvQGEbIMXc
 OmOl5nvjoeZxhlvLrjnG71YBGhP4TUCsuQkUBWuc80BGCsf6oBsHZYugqOgaFmeWdVSe
 gOSBLWhzYJuOFconL/25AQ7HJKE6NlQVgvFzNCu5dTH1jodRYsUesOur/500ktyXPNI4
 xyMzrkjuIT200zcEzvsAWkG2U/2Elnr0hQxqse4+3JQ6qy1rIxSK7m1imiL9/ZnBAPjK
 rQWWzmvUKhNiO4vqAw3Yu6OYixbuO8Nkrdf0qpXuiK3xDKDX0lw5UuGRM8KDCRz1MB7l
 Mc4Q==
X-Gm-Message-State: AFuF++n6Wg3SqL8nxuTZQi+f/82oQbpk3CA6xuMHPnzp2RDDtz2kVNah
 YmEBSc4b9Avp5ILb2v2TrBedFdlnpBDAvukQcacz2CyViFm+FxYg7vzswH7aErg0tLF/9WNVGJN
 gPzQvhGU=
X-Gm-Gg: AYBFou0nDXjpq7q4Zjc989ZPKhvm9uWizmedacSPuiQJejKeT/Z1Iqw0QBdLK8/pgaK
 r1QkrWgQ/k5hXP576qfvM6sAJU1s96oatBP9gOhlPSUWl3gDTM9R+3ri/tc/oyNRxvk/c9wrIQa
 V5wqU35CM1ZVLp3Ux603+eYD7/4cciZcMMA8oT5HfxaiYdBqFH9O3uONqY6Gl9O/RXhC8sRZr5P
 2dm73GLb/J0/Xxwa2OZ+Eot2do+J4XEbxf+C6OcuIztdabppI3+hTB2PlVypr8JxKuT9utw1llZ
 rW0e9vF49L/LD1pNWAL0QxO/RSYuVt2BMd3bmeXH/ouPauds+kBOh9zqByyhusuGeluVGhI0W9u
 7KOJw8v98X+OowrET5rGQjitdqByqKJZlrclBM+JjkL1Yp97CilsnfhHLNEmac4mTyK3bA5N3eF
 3nGJDpcH7nzBmsr34o1npd2GIU2deyPIpCSGqq8MywaPhqzyO7tmoxl12G9RF3DwmvyYXMmR8eP
 fqKdhw=
X-Received: by 2002:a17:90b:4fc5:b0:399:149a:3f27 with SMTP id
 98e67ed59e1d1-39d9bd71246mr14946852a91.9.1789208572438; 
 Sat, 12 Sep 2026 03:22:52 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4ed295esm14445074eec.15.2026.09.12.03.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:22:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH] target/sparc: Enable variable page size for user-only
Date: Sat, 12 Sep 2026 00:22:50 -1000
Message-ID: <20260912102250.597582-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Sparc v8 has 4k pages, while Sparc v9 has 8k pages.  Because of this,
userland does not assumed a fixed page size (at least true for glibc
and musl).  Allowing the guest to follow the host page size avoids
a variety of emulation problems.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu-param.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index 7ec4ac84dbb..72aa89bf66a 100644
--- a/target/sparc/cpu-param.h
+++ b/target/sparc/cpu-param.h
@@ -8,7 +8,11 @@
 #define SPARC_CPU_PARAM_H
 
 #ifdef TARGET_SPARC64
-# define TARGET_PAGE_BITS 13 /* 8k */
+# ifdef CONFIG_USER_ONLY
+#  define TARGET_PAGE_BITS_VARY
+# else
+#  define TARGET_PAGE_BITS 13 /* 8k */
+# endif
 # ifdef TARGET_ABI32
 #  define TARGET_VIRT_ADDR_SPACE_BITS 32
 # else
-- 
2.53.0



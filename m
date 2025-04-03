Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7564AC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Sfz-0008EQ-WF; Thu, 03 Apr 2025 18:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sfs-0008Bk-G1
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:04:36 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sfq-0003jY-CM
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:04:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39c1efc4577so824293f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717872; x=1744322672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=doR/P2MXSgLBBH6RNtR26uKFBCyyOQhBDOm0tf03ZUU=;
 b=BN6sBbNrh/+GkiPrvdImg0pQwD648IpUi6c0W3/7TdCeoRXl+o/+NbUAen4QMCUap+
 9rk2Md8itnBCACxjLgYqLKMDSXILK6xydHeuzvs5pOVrW2qyzitIJTbZindwl1j/+IJW
 bQuXbt/u9nu0nrg/wRv5RLjUPQLax/1V9O1/MbwWE4SHDcmB7tyV7cSEbr1TiGralG6H
 11Zkbi2+K0PHk7KvtFscF6T9D50hMJ7AC7aFVW1qiHDByflQoDz5LZ+1X1bRPOT2X7E/
 +qcS6wOcwJVTGxzDSJFtPm5jH2wkbu0fboOmI6xZ0rAaHxrCQW1lTvARCzDqqnjHONp4
 hbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717872; x=1744322672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=doR/P2MXSgLBBH6RNtR26uKFBCyyOQhBDOm0tf03ZUU=;
 b=KZET/4bbGW77AW6eQBAmYJLJ3R09G5OmvwuxCI1yPaQbj3ZxCrWTGYj6R5WfUXCQCI
 JhAae/l3v8WsJ2rEnVhMkzB07tN2oWzcCc4VMZ1o3iBvmN9688FBqzfQ1sD5Xkj1hKHC
 wNmvpX9ZNM23uEslpIdUyO0l8VDkKke72zITRjITQWZIccxdQ+t/ICmoiO2FlUYZLPXK
 EaavgdeG+XD8RHV6ix4tNwHtylhLZ33ygAcO5O6ShQNcKDgVF+VsW3VzSefr5kSe1YoS
 xULzel89f6MDXt/06L+oBmrbHjoMIRq+RyzF5+qyltTpgayFtqnHbXI3f6aTbeVP5J5/
 +7Cw==
X-Gm-Message-State: AOJu0Yz/b/x1tu2Ec46TcJzBNkeW7snAJ3HML9JV/B4MrI0zQ65Li+Vz
 oJ6f/NHf370DVoWtv7RVFCLaiSTNQ7M53FO2XRbp8CohqrPF5XDlPFuC8SPthSp5rWz2I8GWY1w
 1
X-Gm-Gg: ASbGncveg33vML1w+0HngU7kCLgDjAPyB08rJMRyGUVMJMMMlhlavZd6CA3f4SxP9jj
 JhqqPWhKV+P2O8+ePxHEQooK5lfNhJeuKb1r9YZOXYMSJo7HdJPxhuf+WV1ZsxhkWp0xvnoF4vz
 Pd+YUy37lqesHXMgw03gclZWiEKefTZjRLN24DTbjOV78OD43Nzm162axYWA+dhLr2HB95ncUt4
 G10FhNK7z+ow9S86SfJXGzHNApkuJ3CkCkOECTklDWIWGMl8WAS7Tdhr0UOmn4MSN6B9zGQTjSg
 V02YcAmQz7D3prNudAWLG5cfnKn8gHGSTaElG2G4f7gfCo7vRfBCImZKCOEJ+R/oRwgkEhVO5WF
 Yv0ZT8CbbZ2/Qi/JmiJ76Hzn+nAnzAXOSzt4=
X-Google-Smtp-Source: AGHT+IFOkYUpVSPkc2bAR8n2N3fXRVwKd2t82FH1yKd7cmz4w1UTFtbrjNsDvVTncdDWVzBtmnl1hQ==
X-Received: by 2002:a05:6000:248a:b0:391:39fb:59c8 with SMTP id
 ffacd0b85a97d-39cba93245dmr653739f8f.25.1743717872586; 
 Thu, 03 Apr 2025 15:04:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34bbd9csm29067355e9.20.2025.04.03.15.04.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:04:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 02/19] tcg: Include missing 'cpu.h' in
 translate-all.c
Date: Fri,  4 Apr 2025 00:04:02 +0200
Message-ID: <20250403220420.78937-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403220420.78937-1-philmd@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

tb_check_watchpoint() calls cpu_get_tb_cpu_state(),
which is declared in each "cpu.h" header. It is indirectly
included via "tcg/insn-start-words.h". Since we want to
rework "tcg/insn-start-words.h", removing "cpu.h" in the
next commit, add the missing header now, otherwise we'd
get:

  accel/tcg/translate-all.c:598:9: error: call to undeclared function 'cpu_get_tb_cpu_state' [-Wimplicit-function-declaration]
  598 |         cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
      |         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/translate-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ed41fc5d0cc..c5590eb6955 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -69,6 +69,7 @@
 #include "internal-target.h"
 #include "tcg/perf.h"
 #include "tcg/insn-start-words.h"
+#include "cpu.h"
 
 TBContext tb_ctx;
 
-- 
2.47.1



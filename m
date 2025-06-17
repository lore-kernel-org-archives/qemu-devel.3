Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15862C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRZJ1-0002u7-IQ; Tue, 17 Jun 2025 12:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZGC-0000mH-R8
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:10 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZG3-0000eM-Gm
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:02 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450d668c2a1so47398815e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750178037; x=1750782837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1HQznq99qoCK8P8PgCsYfpPefLsvFqz98NOZI1uUSU=;
 b=ox/IQgKB3OQg4OVOn6+163FpfmnWREMGSc0Ls0RiPermpmp154i4M7fAfaA8FCBwsR
 aQAJ7KB9ByXuSHcrX5XPg1pA1IGr9qHeXyBPUHG65xHlBDV3ntdJaPJB62qxaaOjohP6
 1O3YyLwsi5C5ZtYlgoZwKp5+2CvM4k9R6+uoqYkYCybVr8HBmvONvgYswEWmqbh5pCu8
 tsdQd3RsWHWoCC5h3kckV5cLJ83hkoxrsB9KEE3P2KOwBrWklLt92gKUrWP8x3pCraIy
 3sdqOMhEFvlNrrpCol4nRey2LG6Ul7BOyfhnvAgD/7opzwsheSKC3qserT9OLRzEEzPN
 +aYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750178038; x=1750782838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1HQznq99qoCK8P8PgCsYfpPefLsvFqz98NOZI1uUSU=;
 b=BLWRdLADgpK8P5syaIfHC6nzhF8pFjN12NXdKn45X4ZBC0eBHQIvuUuvfvaAzP9yVJ
 6xWkdv9LJcAOYuGsWg9WmEzYi+5o5nY9PEHpUxQWiYI06ubMEZaREFQdRIKQtIo29jOb
 xMWwBy1Ix4EaVwI9Y5VF6h2hyxUg2FnpFIi4mBaRDELUXxnhJjBLfcXk80SkMPYGpumK
 15SWC7EuQNMe7QN9F7JUDdwO6KccMmfhny1A9VKChDXflE3KQr3g92b4A4Twg6hJpunl
 lIgmf7s6noHWeRPnMh+C/DOH/VtAJbS/mR4osjqI+WZQiURsSToUM1tTARhkMUpkIy1d
 XfXg==
X-Gm-Message-State: AOJu0YxVxhlkOeZwMYf44aTwbZ5w6G5zSgfO3o/HmPGqa4XB4TKBubEU
 MxaP3YfTiffM+p9As0J2kaXdkXFmhQpAZSH9Js+0KAn1QUzfPyTE3bhgkhvGlAp07wQ=
X-Gm-Gg: ASbGncvxqO6aN/QZb78tl/uEXP15fml2r90RA8mVMLlqdkbCnZ8vz8X4tttRb4t7z9B
 0tO5xHhpi8EcKglheRJBKL/BEjLWBuJvo99fuo+g+P9+iT501JDbVrgE044CCZADNDo81ixWIhq
 JyuefXWf6FYcBMGPC1OqDqMQi23XyOQE9QJFz2YseYdDBCPmERpbPtxSODZzCVnFTlIWYwkTT49
 5bnziz7WLaiyrSgQa9RgGn5bJa9QhzIZFFwsHvEPJOFtwS9UMJlp6IdaCnZXZxRpb6tDY9C1vqG
 UxxMynGAZ4EcA/ueM8xhBjGPlMTVc2NAgmGKh/LBo7Ag55W4rUaKY07GYoCzse8=
X-Google-Smtp-Source: AGHT+IEuOlzuLgIb55MubMss/sq0ETxsqBxX/tP7MvZTc4WF4bNrfAkV6TatGGs3YrMBZLde9xPYaQ==
X-Received: by 2002:a05:6000:64b:b0:3a5:8977:e0fd with SMTP id
 ffacd0b85a97d-3a58977e508mr2505193f8f.0.1750178037635; 
 Tue, 17 Jun 2025 09:33:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a53f79sm14266546f8f.4.2025.06.17.09.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 09:33:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 91A355F90D;
 Tue, 17 Jun 2025 17:33:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 Mark Burton <mburton@qti.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <graf@amazon.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 07/11] target/arm: clamp value on icc_bpr_write to account
 for RES0 fields
Date: Tue, 17 Jun 2025 17:33:47 +0100
Message-ID: <20250617163351.2640572-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617163351.2640572-1-alex.bennee@linaro.org>
References: <20250617163351.2640572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

If the user writes a large value to the register but with the bottom
bits unset we could end up with something illegal. By clamping ahead
of the check we at least assure we won't assert(bpr > 0) later in the
GIC interface code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 4b4cf09157..165f7e9c2f 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1797,6 +1797,9 @@ static void icc_bpr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     trace_gicv3_icc_bpr_write(ri->crm == 8 ? 0 : 1,
                               gicv3_redist_affid(cs), value);
 
+    /* clamp the value to 2:0, the rest os RES0 */
+    value = deposit64(0, 0, 3, value);
+
     if (grp == GICV3_G1 && gicv3_use_ns_bank(env)) {
         grp = GICV3_G1NS;
     }
@@ -1820,7 +1823,7 @@ static void icc_bpr_write(CPUARMState *env, const ARMCPRegInfo *ri,
         value = minval;
     }
 
-    cs->icc_bpr[grp] = value & 7;
+    cs->icc_bpr[grp] = value;
     gicv3_cpuif_update(cs);
 }
 
-- 
2.47.2



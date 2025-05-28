Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C327C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBvi-0007vF-TA; Wed, 28 May 2025 04:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvb-0007u1-PT
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvY-0005D7-NL
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso33407345e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420057; x=1749024857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zh/urG861ozt+kR4uVLI4zuKmsrdPyReVEilzcFUTzo=;
 b=bQrqDkASf3NL4gF+KnPRkG3kK7ZmfZrctqoREtH1aL9wvzEKEHAPf+KcUXL+Kd8PGQ
 ABG0c9cQLthYwx+i6i2PGZoxKDTfee3sIvNO7kiFDXVfQUobsaCtHoxF5/uq7smbgzN2
 9nwGXLgGQFUhvnncELVd2rjlavcaEV1WfAvhuNGVSZm7kwLCRyx/eUHtjfBlUMBRM0Bz
 3PAnmO3pRfUHxbjOEaQk3sHhTMyMK5RSUx22hwnYhiSRcnLolGNjsb7Tw4BiikTYPUSs
 yeTwMINM6v3qOBrL+l9w5SBgio0RWl9tthrJw9lV0MUQ1lou6FOnBNcPodN4W2FDMEQf
 nn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420057; x=1749024857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zh/urG861ozt+kR4uVLI4zuKmsrdPyReVEilzcFUTzo=;
 b=tUcA44msHVA1Vn3EK1sIfC2O0G+hL1zqGGbtcJwHPbq5oQ5vrJwvZReMbSPFr5dlVP
 LFWwoTrpnTXvunLjOKBD+EKyweozQeG7ZR/DbfjXfUH8kiA2S52mCwLhWTLSsp/fr5de
 K1gQaA0UGNrtt2h3vBXXez7RNQhg6k38SlVJ7+9PHDEXQafSr78MT5SZMnIdXpz8Ohs1
 d9OUx+eNGTgD2qPIb0yqfd65/c7uOaxC861NAIoCuSbzFXRRBGV8gx+jUsoSN9pYhrGN
 y8jyLtP2zv2MjN0NdqJSy2/Fw50HXKnwfd7hqBgaEgc6Ve9cSj79I2dnkkU3HEdtq27E
 fujw==
X-Gm-Message-State: AOJu0YzCGikcRCIn+2LSs/voCm8d+4Mkr9vk6iA25xT0BxwsK2HPWrWt
 V+lAJH/eHcKeDERl5KbYj9A7O4yVcynSEnUTFTo4RAlyEiLymWux5vLeETa4pkiBNjLmkOiZw3V
 dDIHarRpN7A==
X-Gm-Gg: ASbGncumwjerGsBGCNEUGD98S5dxyGFCVAmgT7Ya1vG8nZ6w8WFC7AQqzBarbescoyV
 zNt6JuFz6D1rE9x/ar4odKjLdHoVBWBo8YPiepLH+rDC5jk/rJv5MeBwcyOO/LG2ANsKg0oczmk
 T+6qPyb0a0+/mas/V/zi0ptovvHpTnEl3VIr5s+k0Pp8sBxqWlIUifZgHKk34ev4LHo6kIDEIEe
 Dh+QpAz54VgFf53SfArer6QmlxD0zI91+jY43SCJXt1zl5+DHVMv0U+xu5lPgWN4/7/yo29AbvN
 X638YuKPueRMVSoLELVxtoY8SWbfgSRPz5n1YtmBlcSfgSJQbN6nNhGSkvSDSin5tGo=
X-Google-Smtp-Source: AGHT+IG2E1wS89Ifzu1qiB+DAvK2csEF4Z8QODJH+LVNlX8jj4QsenAmbjskM85XnBZVKvXhbDJ3WQ==
X-Received: by 2002:a05:600c:8189:b0:442:c98e:79ab with SMTP id
 5b1f17b1804b1-44c919e143cmr141928085e9.9.1748420056632; 
 Wed, 28 May 2025 01:14:16 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>
Subject: [PULL 03/28] linux-user: implement pgid field of /proc/self/stat
Date: Wed, 28 May 2025 09:13:45 +0100
Message-ID: <20250528081410.157251-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Andreas Schwab <schwab@suse.de>

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <mvmfrgzcr4m.fsf@suse.de>
---
 linux-user/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 23b901b713..fc37028597 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8235,6 +8235,9 @@ static int open_self_stat(CPUArchState *cpu_env, int fd)
         } else if (i == 3) {
             /* ppid */
             g_string_printf(buf, FMT_pid " ", getppid());
+        } else if (i == 4) {
+            /* pgid */
+            g_string_printf(buf, FMT_pid " ", getpgrp());
         } else if (i == 19) {
             /* num_threads */
             int cpus = 0;
-- 
2.43.0



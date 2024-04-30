Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EF2C19F4F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qf1-0002Kn-Dr; Tue, 30 Apr 2024 12:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qez-0002ET-BL
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qev-0005bx-In
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:53 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41ba1ba5592so29986095e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495726; x=1715100526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hthA/3V7Cmo8odD0drLBUjy1wpShyNiLm+eJGK3MJJQ=;
 b=K0ScF/CFZpiaIeB9JQiGhCpBsnqsDmlyQ5Y8rFRbiMviIBlUBUaptxrCFyB3D8p9Wn
 g44IPtPJjN/8oKsVfgIuYwUI0hQtGY2zNcTxoA7WXGLVhTmdjhRWStNaEE7lmioElK6x
 XxtJ4dJmqlDUjZ1nj8eBxafI1jQ8F2U9HxmlKDTYFRJpWkdcsWl1usego7fyz4Hk48JY
 gbkL2KZYGC6If7yIo4yyI8SsF6ko+PGZ+ymWQgCp8ihtDsG79siajMI+TvoufabbeQNS
 TLfumV6J9JPsx7i/cF6bFhJPOIi1ce322ovn7ngUM6F4oQy5CJks28r7bGHEvhMjA4x9
 fK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495726; x=1715100526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hthA/3V7Cmo8odD0drLBUjy1wpShyNiLm+eJGK3MJJQ=;
 b=P7e7mjgko+oIm0SoRgCA0vBOMv2Ckv3gvvBDjqUblJDb7DoKdns9HZMSd/FkF3AuQr
 VBt3ZZNvqZkfqL097By94IAa8o9erF/7jsK829/xVE/NJAs5YMV9kOV4QxziLtP8QsUl
 kd+maFtM0D3KaPU2103L1qmS9ymEBUpcUjYmjYY7zy/PtY1oLkeAvAvrlA0eBkH4+kS3
 Qe5XD5ru6fdFgTKrI3Ov+29zSCrSN8LdvpmaiJIlxwmlK1RMEh5b4BhAVeFr/TvdJLCw
 8LPm7dnD1q40u0CQ8JuOeu5sA+/baYXNwpL7fjcGveF9eve3nej8SffogFNgO9L+5t1X
 B9BQ==
X-Gm-Message-State: AOJu0YxPUQS5P7bWDdFjGUB/0c6hqmgL1YwnWVEvJahCfZSoEnwOLvgT
 7RaK9Ou+iDTEXRhg9Cj+Xaj1o6/LwfSVdqqkuN/k7UyiNd5xSc5KYpcBU6+yJKNlUBn6vDw0/YQ
 x
X-Google-Smtp-Source: AGHT+IE+DY1II8VorIMZ8PPpjL4tszXrVyXRTnVCypIrFRxJ3zdCVvDEBN6aOptgM8cfdcyudO9SWA==
X-Received: by 2002:a05:600c:4f85:b0:41b:9e4f:d2b2 with SMTP id
 n5-20020a05600c4f8500b0041b9e4fd2b2mr100976wmq.2.1714495725787; 
 Tue, 30 Apr 2024 09:48:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/21] target/arm: Restrict translation disabled alignment
 check to VMSA
Date: Tue, 30 Apr 2024 17:48:24 +0100
Message-Id: <20240430164842.4074734-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

For cpus using PMSA, when the MPU is disabled, the default memory
type is Normal, Non-cachable. This means that it should not
have alignment restrictions enforced.

Cc: qemu-stable@nongnu.org
Fixes: 59754f85ed3 ("target/arm: Do memory type alignment check when translation disabled")
Reported-by: Clément Chigot <chigot@adacore.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Clément Chigot <chigot@adacore.com>
Message-id: 20240422170722.117409-1-richard.henderson@linaro.org
[PMM: trivial comment, commit message tweaks]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/hflags.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 5da1b0fc1d4..f03977b4b00 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -38,8 +38,16 @@ static bool aprofile_require_alignment(CPUARMState *env, int el, uint64_t sctlr)
     }
 
     /*
-     * If translation is disabled, then the default memory type is
-     * Device(-nGnRnE) instead of Normal, which requires that alignment
+     * With PMSA, when the MPU is disabled, all memory types in the
+     * default map are Normal, so don't need aligment enforcing.
+     */
+    if (arm_feature(env, ARM_FEATURE_PMSA)) {
+        return false;
+    }
+
+    /*
+     * With VMSA, if translation is disabled, then the default memory type
+     * is Device(-nGnRnE) instead of Normal, which requires that alignment
      * be enforced.  Since this affects all ram, it is most efficient
      * to handle this during translation.
      */
-- 
2.34.1



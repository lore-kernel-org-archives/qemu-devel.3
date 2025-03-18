Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF7EC35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 04:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuOw8-0001Q9-FS; Tue, 18 Mar 2025 00:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvc-0001F7-98
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:50 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvY-0008UK-H1
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:48 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ff80290debso4298039a91.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 21:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742273501; x=1742878301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ovyvu8DCxOT3MJqFMX/qU9iZeR9dz9+LihTzZn+g4uA=;
 b=Yq8uBL1ERJ/7pLAmla1mjnM3RA3M9xCBXKDRAG54M6W85t3R79Jh2vjeKSoATK9DWT
 /YwMmSR/jraAkkkWMlmmCvXipqgiAjkCnjcW1EBjSlt/Ymue3yHsCW7xjqIkaICnUE1F
 WFbahzb4HpIznavmUy7ewpmBZwxTImlNbey6jI5emHajmhM6YRHo2Lxl2DFIM9k5ek5S
 Zk/knVt1UHZD/unprhKLb8uxb1nBXj5ZKXkm5+uEvS5QtFEJuBQRDrXKgPPPPS51DsZ5
 As25X74r+zYhD9p+5Ngs3z3GGiKncPr9ww2QYmE0zeqXFBoXQ216FKzlPqDvKr7pE53x
 FfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742273501; x=1742878301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ovyvu8DCxOT3MJqFMX/qU9iZeR9dz9+LihTzZn+g4uA=;
 b=UYiYnOW1Yo4EYqXD65AJ9gLHWV4fo0/PoUFPr4095v5RGbdkFxuighO6XEpQ0dq9mW
 4CxKi4XwzEhgktoHX28Zad0ZGhxk0nVD0cp3BN+OY/lVmAL7T2RCtjYUYPqD2KbbExb/
 kJ/xdK87JgGkTJLc74M9W04JYqmBpBNpfXZuqUjf1cZmABf9LIqcpzrNdYRtkr9LJjdU
 KReZOAWlzMxW3XKvxC6sTQSNXTVgvpVz3FNmg9+QrbIK4h/FchPtxhTWpgwj/UAnrOO2
 6kdXB9rtmahHCkn5y6Rgf0owvCI3aQv7rlOoIEZbE5lPjhLTgkSH5oH8jjOvBYZiH42N
 uIUQ==
X-Gm-Message-State: AOJu0YyaDs1e98nZQgToEb1NewiPN9WdBAJSdet7A/0WGGQUbltimWZX
 L7hx3l2PKOQWCsw5hGoFRHZ4tKUUsil48/mrvL7kkDsWz27f3y2FKO9nrXyREEM9uWp4BOTAeAd
 H
X-Gm-Gg: ASbGnctp0l3CuR5FzWbZJU9puf4OX9KEaJI7JFO5TcZ8QCuoqod9rX78A7pFXNjKhq+
 IeeRm3yDDucDSTDuZmZb5Pah9dkeDNUG/A/0Rg9GW8DBam3cmjXz/NtSaLtZr61fPVgxF6Zj85t
 PghKvxD6eESDEocoBoqRLH5eI8tT15QhsATDWOzgJDwCC6pfzYlL1VlXh9A3SOUIdrbP2cyH05E
 f0eMagDSF3qtK4Tft/qs8Kutlvq4l1vVmSgiK9oMb3zz3OOlqejq39l9pR8L2zHLYXSMek4QMJW
 NbnzTm/1qI1ik2OlA2Rr02dKBxR7e1h19MK7FfGNFh3o
X-Google-Smtp-Source: AGHT+IGpoy0HiXaK4W5rGsoIV6EB7nMCBdVrRX+IRN9Qga4zDbHRqASR/8vpI124f9RU9cNmPTSLpw==
X-Received: by 2002:a05:6a21:164a:b0:1f5:72eb:8b62 with SMTP id
 adf61e73a8af0-1f5c118eb0bmr21535312637.20.1742273501600; 
 Mon, 17 Mar 2025 21:51:41 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694b2csm8519195b3a.129.2025.03.17.21.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 21:51:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 09/13] target/arm/cpu: define ARM_MAX_VQ once for aarch32 and
 aarch64
Date: Mon, 17 Mar 2025 21:51:21 -0700
Message-Id: <20250318045125.759259-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

This will affect zregs field for aarch32.
This field is used for MVE and SVE implementations. MVE implementation
is clipping index value to 0 or 1 for zregs[*].d[],
so we should not touch the rest of data in this case anyway.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 27a0d4550f2..00f78d64bd8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -169,11 +169,7 @@ typedef struct ARMGenericTimer {
  * Align the data for use with TCG host vector operations.
  */
 
-#ifdef TARGET_AARCH64
-# define ARM_MAX_VQ    16
-#else
-# define ARM_MAX_VQ    1
-#endif
+#define ARM_MAX_VQ    16
 
 typedef struct ARMVectorReg {
     uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
-- 
2.39.5



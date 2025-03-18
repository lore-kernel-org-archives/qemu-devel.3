Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C5EC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 04:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuOvn-0001KM-09; Tue, 18 Mar 2025 00:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvX-0001EI-F0
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvQ-0008SE-Kb
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:38 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2260c915749so26439885ad.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 21:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742273495; x=1742878295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OAWROUlIn7auIWdaE5em6TVb2NvztQjiLgpJIDrbZCE=;
 b=tC7kvACuBzOb6zdQLhUeb3hNmPw7OzjgLXV8kkqp7imQj1DFAOcIqQwGFWRV7f5+/4
 s0UA2RAbQAXPwBcU99sfd0+Sr67/k0NIfG7QbAHmBAL6HPxE6M7amwppbvP7+ehONxwp
 Q7c4TQ71UIfZU32nnXildIOoCoyCuvQw1pUKC4AYY6xJsFPmhNrP/zON/DR36aoAQK9A
 PZbW3LJjS4VRPfDER+DqD1KXGr5ej6Twe6d33thPqYuVRZiR+mmNo6c7j3KD+pCAWrvE
 GCc8feTPb4v5BYozzb5e0ToATbFYX5rUXtDtp/+g4yxfSXJ2+2kG0DH7H91EcG6UnjHU
 pxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742273495; x=1742878295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OAWROUlIn7auIWdaE5em6TVb2NvztQjiLgpJIDrbZCE=;
 b=ZFwNkHHvJQWK0QZMrAKMnuUCF+MhssGI3y9Dwh/+XIGJg2th0MTiKKbS0bfoLtjiYm
 4g2GeAJ8lcClU8RJ5o3VYDB9uj5cMU2FWw5iGrMwj3pGffeE7RaExxYMK5NYedoX+6PF
 PEk6dCQorjP50DgN3/AAQ1v13ixDh3j5wnwsbO1nvYDvdyz1aIIzUWIHF2Jm0xFTbilr
 1E3FndDmM7Kk4pj0ou3QYpYRychnF++erP/M/cOBZqPOFD0CPFD4MgId3Wbge8ezJZHf
 5mRi3KuJeMqj5M57mBPEXi2cfeiDeIz8rCTR9ObtVjYEGOE0Fdw3NWgMNuUHVMwkcG4x
 qolA==
X-Gm-Message-State: AOJu0YwS+IPO3Rbkd/hUX+UYnUS5dank9a+lUDZ7RZarlHDTAD58uSAS
 diXqo7y1I7bps61ksN3f35whwFRtrjoJAlWKHvvW15XZqnTV93hp4bZbBJolx5GTzu3ro7UkxNR
 2
X-Gm-Gg: ASbGncvf+tmR21Jf742fSP5VwIFNHRZRizYFFL1YBykGX7Afhnfs8zMCM3xiQ5y0Gnw
 7CIES/Ftad+1ycKm5bHbCjcbYSgzUJQfjG/b6Wb8MtWSElOQtty7Gq0KsV7H0ros1rilxY39zJ9
 OMVN0zJmluTlCtAONABpxs4//5RrZt6XZFZDgcNecjpEzd9YcVg0Actw2PLY8jxU/2nSH8bIMv0
 yqH+1yMKn2YEP8PkJLDkMX++6tbNoeO1t4XuJ5/u1ItgKA2uTihGS1okWLPnT/fFjgMC0ufpcxi
 2/J2k3gHje4qUQoX+3y5kmxQK9EH4zAiwsWZaC2Alch2
X-Google-Smtp-Source: AGHT+IEt46y/1QHMt9sgoOzblTQOO/Vh992GC9mrguK0N9zijMCVTkkxREI+0zrgLP1cwHkaSo90Bw==
X-Received: by 2002:a05:6a00:b95:b0:736:3d7c:2368 with SMTP id
 d2e1a72fcca58-73722353269mr17764448b3a.7.1742273495053; 
 Mon, 17 Mar 2025 21:51:35 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694b2csm8519195b3a.129.2025.03.17.21.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 21:51:34 -0700 (PDT)
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
Subject: [PATCH 02/13] exec/cpu-all: restrict compile time assert to target
 specific code
Date: Mon, 17 Mar 2025 21:51:14 -0700
Message-Id: <20250318045125.759259-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

TLB_FLAGS defines are based on TARGET_PAGE_BITS_MIN, which is defined
for every target.

In the next commit, we'll introduce a non-static define for
TARGET_PAGE_BITS_MIN in common code, thus, we can't check this at
compile time, except in target specific code.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 6dd71eb0de9..7c6c47c43ed 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -112,8 +112,10 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
 
 #define TLB_SLOW_FLAGS_MASK  (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED)
 
+#ifdef COMPILING_PER_TARGET
 /* The two sets of flags must not overlap. */
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
+#endif
 
 #endif /* !CONFIG_USER_ONLY */
 
-- 
2.39.5



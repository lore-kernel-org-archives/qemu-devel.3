Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B211CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPSq-00045p-RR; Wed, 27 Aug 2025 19:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSj-0003yY-Lk
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:53 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSc-0004HF-3H
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:53 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-771e987b4e6so322183b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336901; x=1756941701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HyBW6oXpw96252KnNIM84sqTDSbPQVUWR0A1KOUJqIw=;
 b=PvUSDkD7lpXbMMsd1qokRLhdhhplaDdvQ+rxc9RdsETMoWMrg2+tZzwxEuTRycSwCJ
 3NEVJYF5Ce6ZVRHLHpw7Xfgu7VG52XT5LXFBxnX/DpnBJP9wVBRA+NJtPqVUoEIFWL8W
 iFF90jLGoZF8F8veG+3zfR34pRRr6SWoOh0IZsXVrEWA+ctP6HyjkUCaekt5Djfu5L4/
 QYAMsb7VxvIAQ6qgy53C6sWaelfoEOtlfUgMtsQ0I/lCOFdPlYdlltskvHhxGn7agXxb
 0QB598+GBtKUVfmQ23IKGsc2KJ2dnb/MZJT9brwA8V5lBQHE59jGlOpa1huqovjjujHz
 anLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336901; x=1756941701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HyBW6oXpw96252KnNIM84sqTDSbPQVUWR0A1KOUJqIw=;
 b=saMkOaZqd6m1eIzbOgCT8xaul0uJdXwd/Q4eLTE7bh7VBgaFooSmu/P38xN1HiRmUB
 N1LT7t4p7YBebqSm//vnq3Ee3UiNJRfSiuORUOhX7O4rZEZthgCxnwPetWszZoI1oqvN
 jLKsc+L3BSITHyBq9KkiYWi41aB4ojyKpSCEsE9gJhPapjB9EtQE6jjxzCsomEU2CB8m
 A7zpsjpyPiEBzzygyAeNUFbym2wxXrL0XfBiPb4UwAs4Rw4na4Vg9/jQO/kMnNilQA+R
 a8eb6+EOHraDRrpjWKrtq2MVpaLqBORWNzUzMBRFkc4g6vf90sbznd4pd0muRkSsdAlt
 T3sA==
X-Gm-Message-State: AOJu0YzYwM2JPVbcGchshNCrPpT9UZn9J5U+SWRpl8+kjzxCZxZX2oxB
 wszaCwzqVuiqmRrFRKU1g/T5/wJ4tvX95duDoN2pJk7bDaZOWoiengEv+8JZrdrl07Ofdwb8js6
 m4vaE72g=
X-Gm-Gg: ASbGncuEsZYuTrjZsffbZrOVjMkuXkV7xNizzvHs2gWWdCJrkKcv7aj2FbSG5gdUHr6
 1mXbBg3kjQgbHLBPWQMHarmMs1GlpGzQqaWS1GqK+goy/3IU34w54eDfLQCqBg/AG+AlmpDQfK6
 TNNgg8PaJGmk5bAKlhzXhK02vcBlr6I7x34YO8tBNXdww3Bk38kNiKOqJZIK6FGL4/EW1XJWCLu
 D3J/aEOmMPJHBLd7B99r6Vdt5j6qmIE0/r/F/3VtblSFcXVdAABBFhQMxX8kIk/JetAg0f4JzFU
 BuPoV7Cl/AIPS2vFKdmQhPB4ldt5sX1Nn+bmGoSBgdgLiQUAPp+1YzHKxl4pSQMHM4RtFYvxGsR
 E4RJpTELP36EaW21X/2miHLlLzg==
X-Google-Smtp-Source: AGHT+IHoAOxHfqDWnJhBdNUX30IoYubCAQKCve3Zak8Hnsw+95Ko8TP2YPGKV1eusF9V9hys8Yzkzw==
X-Received: by 2002:a05:6a00:9a4:b0:772:a60:6c04 with SMTP id
 d2e1a72fcca58-7720a606d90mr4844730b3a.2.1756336901438; 
 Wed, 27 Aug 2025 16:21:41 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 24/46] linux-user: Move target_cpu_copy_regs decl to qemu.h
Date: Thu, 28 Aug 2025 09:20:01 +1000
Message-ID: <20250827232023.50398-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

The function is not used by bsd-user, so placement
within include/user/cpu_loop.h is not ideal.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/cpu_loop.h | 4 ----
 linux-user/qemu.h       | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/user/cpu_loop.h b/include/user/cpu_loop.h
index ad8a1d711f..346e37ede8 100644
--- a/include/user/cpu_loop.h
+++ b/include/user/cpu_loop.h
@@ -81,8 +81,4 @@ void target_exception_dump(CPUArchState *env, const char *fmt, int code);
 #define EXCP_DUMP(env, fmt, code) \
     target_exception_dump(env, fmt, code)
 
-typedef struct target_pt_regs target_pt_regs;
-
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
-
 #endif
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4d6fad28c6..0c3cfe93a1 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -359,4 +359,7 @@ void *lock_user_string(abi_ulong guest_addr);
 /* Clone cpu state */
 CPUArchState *cpu_copy(CPUArchState *env);
 
+typedef struct target_pt_regs target_pt_regs;
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
+
 #endif /* QEMU_H */
-- 
2.43.0



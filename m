Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6FFC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuy4W-0000Wq-0L; Wed, 19 Mar 2025 14:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4J-0000CD-SI
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:08 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4C-0006NZ-O2
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso35678475e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742408579; x=1743013379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvIsd2CCJGYlL6Tz2JnzQnPO9EyaGwyyQWzqTQSHt28=;
 b=ieddKccu1SGZXg1Xd+vV2zoynMWTlMSTh/Q7/U8GbFATO9eRX4c3wy4amLk7twar6v
 euY9hPnE0Y+M8VJiK+qQmsLJyMf2YuAKitQfAwQ5tS2j0e7Sq8keDa4koCHmmFDyYjab
 bYY9gEvNhP7MlM3/EqlPGw1EpY852jeX4U0rMXsGhSpuJH8ArkKbqESOPnCxRipI8PWh
 4jQ0juurqvH1jcJrMFDaS6hyKLo4t7ZER0dq+LnXqXVhtEn+Fm5ncbsYHiW7toidalC5
 aOza6tBnO1mAnXBzxYQMTeFiipH2fSYV2ZBhoB8vvGMCB1ck1SDMHsvKgerAbr8VhCFA
 ZmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742408579; x=1743013379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvIsd2CCJGYlL6Tz2JnzQnPO9EyaGwyyQWzqTQSHt28=;
 b=j1T1Yv8PzuqPg5vHf0u348ldehGmWjRyiyIC9wUX0mZy0nsuERRUfJOpjN0QTEXdSN
 H+yrleULuAG9IUxrKNYXUBY9s0UYBf3DyroPKiDml4Nlk9tg88+MaYiCdUJjlWiN34M7
 Drsc8QKnF5lm/KqkEoSEBkRLFoU872ZLx+QrwumiwZ3AecfxHhKrU67Dbbil9IjJCOF4
 CycsLgZRlt2HujZnzAZ89Aode7FMuUPxwYhkqobVJpyt4oZIGzr5xzY/KsY8d0gXKVTm
 RzsFLPJxB16GwwnWmzVgUMxyylIEYq9/JyJKdNg/UQABGnT5qmWs+6z0xJ7q3yWYBs2n
 Ts5g==
X-Gm-Message-State: AOJu0YzYeKEUd2PXA8VVNX+S6EZkE/eqWuI7z/ewiVMB6/HxosFjyQlR
 XK+lyVaLoZwostfI94i/6IaEcFZFT+1/2Kon2Us5fpXhXjfU4Iu0vrTWUzP1jgA=
X-Gm-Gg: ASbGnctDkpHcPqzGKXYis4VSib9yK+QOt1W8pq9aO3OFDPBdDxNmmZzjayiE/yPMEAO
 X/Tl8FlLY1UlrpJmyekBZzobGifr2FcgEWsevNf63CPFvTQ6ERRay//ISGYlcOxwiGqg8kgKqyE
 oA5nOuR+L0s+8oh2nBHhNPS91O6q/ggNS5WdFNFd5msSCcp4S4c+MvzmFOqzj3t1MM36Ha3GmPm
 Pi5kzbrHC7ixBXb2uXIyVFHLrSOZqlcWJ0bLXDo/BVOzcdZOyNTNc2J6ZTJ9eXwh1/ULYeqX5Oz
 TGB5b4dpxrfq1nTGnuAxbe8E3+Jrl6mQINpgpfmQDl/f3Mk=
X-Google-Smtp-Source: AGHT+IG0gF8fcXSnhClP9lCb5acJhqy6teT+AjvdBrpNNKvem1uebyFWkMxGRrAHCfem2rNSwbfO0A==
X-Received: by 2002:a05:600c:154a:b0:43d:649:4e50 with SMTP id
 5b1f17b1804b1-43d437a19c6mr34437695e9.13.1742408579030; 
 Wed, 19 Mar 2025 11:22:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f85917sm25733145e9.35.2025.03.19.11.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 11:22:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A6B99602A5;
 Wed, 19 Mar 2025 18:22:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 05/10] target/ppc: expand comment on FP/VMX/VSX access
 functions
Date: Wed, 19 Mar 2025 18:22:50 +0000
Message-Id: <20250319182255.3096731-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319182255.3096731-1-alex.bennee@linaro.org>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Mainly as an aid to myself getting confused too many bswaps deep into
the code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/ppc/cpu.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index efab54a068..1e833ade04 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2906,7 +2906,12 @@ static inline bool lsw_reg_in_range(int start, int nregs, int rx)
            (start + nregs > 32 && (rx >= start || rx < start + nregs - 32));
 }
 
-/* Accessors for FP, VMX and VSX registers */
+/*
+ * Access functions for FP, VMX and VSX registers
+ *
+ * The register is stored as a 128 bit host endian value so we need to
+ * take that into account when accessing smaller parts of it.
+ */
 #if HOST_BIG_ENDIAN
 #define VsrB(i) u8[i]
 #define VsrSB(i) s8[i]
-- 
2.39.5



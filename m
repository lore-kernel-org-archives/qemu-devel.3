Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E97C83F22
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 17:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaHSj-0001ky-ON; Fri, 11 Jul 2025 13:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSi-0001hk-91
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:04 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSg-00030H-DU
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:03 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-40ad1f7c23bso1349109b6e.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752254581; x=1752859381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6Y1zvZ+TyIUNt8VCXescuyiWq5vvXL67wwRHefGUWY=;
 b=xMmj3gPs3nz1+HV28woHf+2JVOOFrpFuA5BaBy3uYzU+zcs48F4oVnD8k0dH450JgO
 zBppeikr7EEt+JQc8Bve++o1nGeRuBZyuZ9rfd0gUzg5GSL/T1boVsNjN2b2qtNMnTrZ
 3d7ENnATRS8TOgrmxVPzE6fhjrUc7fmCbRBvrey1yD91y+B0b5hRkmcsMdBSO4oe4T1q
 rQCti75kBNKMJXlqFJ1XBnQo1EaT0W51WOh/ddJZ/pQ8PTSZ4cLUdHIVKXPdIBE32OgF
 gS2DMOnA7p7YwQfOWeL1qDrqzyyM190NMbEupVo8LW7v+wPPfUYB7ayDYWcCsveoWxlY
 kxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752254581; x=1752859381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6Y1zvZ+TyIUNt8VCXescuyiWq5vvXL67wwRHefGUWY=;
 b=ATAJWDbyT+VzIznQ9JhJxTkdJOD0Fqi7WDt5H9ye4lVs9D8NzpIlpq58AnEF9q6xMS
 S5TjbSZe5zzPholsX+CKtgMwkWAwPGOrM93UXUHtyDn6Y559MllM4jFCEPich39l+iOD
 8yKU9U7DTrXqrnJJo/E5XGJKqeeL2KdBagMVtfQ66O0tvaDEutYtBq7wavz8inGQeZ+k
 hdqykhlM+W2A/A7B5ojLdqjvhsOsVwel+3lZJJmEWb4a17Pmb5qqhGwXReb1XuUlgL9O
 mwjB3W0hczBQpxO8rM3vC6+AOSiNgchSNyz1M03IWc1vkCz7ziOKcZktG0TRVNrfcAOC
 THBA==
X-Gm-Message-State: AOJu0YzoCsvcQr7YfI/C2ZA693epw+vtRNIWC7SEmMKpiNHh7Qo/Psu0
 I8PTKBuFV4jVfrkwHu1f9nkPCc0B981johWqIEElChAMMH4QvV6mCAHoWK/7SLXsDvHlSoyPihR
 jwatBLOk=
X-Gm-Gg: ASbGncvBfWivTgrS5YsbhmUx3KxqoyKwtrogAm/B9wWcDv6q+3UHtDK5SMUl1sOpxHL
 CJ43XbqiQ9AIki1QOI4zuEfTeTWTiZQWwU5OhItE0otQN2iTWLcKJ/YdrWwV2bi83biigQYZFrs
 m3nWhAqrAfpHCob8JVbntHdcrjG4YPiZWD0lcMDwKN+x554TC4xXG1I/pNzir0q6qx2zkjXEW7I
 YvakmrkMoBiODsPzqODPuXGQ65dUjMdtGXUrJ2ky3K+iw9GUHYngHbZfQtryanhDIz1dv/fA8v8
 ho7T3PyLsmLBA0nKs5W2Hqm7f8bKVnhLMw5mLWxBN0NCxxSaKD4+lpDD0CzJLaELK2AztAc+Dzl
 AbFTGRZFAtoIY8vdp3s96g3cVHFXvY7jYIQWps50kw+5pIa8BKqAp0Dv46di2AVwRCQnKzOH4cQ
 tVZlt5sg1iq+vP0+m+hMU=
X-Google-Smtp-Source: AGHT+IHZ+emkZ4nA0Pbm/C8To5NjaC7MULEW7wooV1IUml5bWgeQRAn7w6pUlMKyvKK2z+Nf/IRM5Q==
X-Received: by 2002:a05:6808:6ec6:b0:40a:533c:c9cb with SMTP id
 5614622812f47-41539f929cfmr2618040b6e.38.1752254580946; 
 Fri, 11 Jul 2025 10:23:00 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141c77ada0sm602041b6e.44.2025.07.11.10.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:23:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/9] linux-user: Check for EFAULT failure in nanosleep
Date: Fri, 11 Jul 2025 11:22:48 -0600
Message-ID: <20250711172254.229201-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711172254.229201-1-richard.henderson@linaro.org>
References: <20250711172254.229201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

target_to_host_timespec() returns an error if the memory the guest
passed us isn't actually readable.  We check for this everywhere
except the callsite in the TARGET_NR_nanosleep case, so this mistake
was caught by a Coverity heuristic.

Add the missing error checks to the calls that convert between the
host and target timespec structs.

Coverity: CID 1507104
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250710164355.1296648-1-peter.maydell@linaro.org>
---
 linux-user/syscall.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e1b1476936..38dd563166 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11643,10 +11643,14 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_nanosleep:
         {
             struct timespec req, rem;
-            target_to_host_timespec(&req, arg1);
+            if (target_to_host_timespec(&req, arg1)) {
+                return -TARGET_EFAULT;
+            }
             ret = get_errno(safe_nanosleep(&req, &rem));
             if (is_error(ret) && arg2) {
-                host_to_target_timespec(arg2, &rem);
+                if (host_to_target_timespec(arg2, &rem)) {
+                    return -TARGET_EFAULT;
+                }
             }
         }
         return ret;
-- 
2.43.0



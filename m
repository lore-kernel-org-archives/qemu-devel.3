Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CC2C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0qT-0003U8-HC; Mon, 17 Feb 2025 08:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0qO-0003I3-31
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:07:29 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0qM-0004st-4s
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:07:27 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fa5af6d743so6549454a91.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739797642; x=1740402442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9uCPjDW0dErB0lZ2crkMfUrfBy4bGr0Qf3z7+OEIYI=;
 b=ur/7CNUMxXx/T6FcW++52hSYwKp055Oqi0MrhaRJ7ja3fFIHEdaPO6YRtLrkh6dOgP
 wFoO+PQw5rXIwuusMbICafGmg1aGIyX48YvlmNYCB5uA7OWiKpMOa7ReAh2pLEXe6LlM
 IFCypIVZW8hcj9QKENGxES5PyXT733KypA5banQfhbQN5E86rlYq/BVqDKJjRV3Y/OVG
 +5ujSRnC/8HpPDvy9jJQ7w/Ya2+wJlUsUhuai/N06RM0B2H9/7lmaL4i+lZ286z0fky6
 Mh0iCGeTX/dOQqeG67DoXqL8iV1oQGK0Bn5pOo50XMIKHAKFGa1YBXUVPkcyiT/5/5io
 BsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739797642; x=1740402442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9uCPjDW0dErB0lZ2crkMfUrfBy4bGr0Qf3z7+OEIYI=;
 b=EiWmZ5aRnsBS1YR2BWQisVA5BmX+1TyT2kn3tzmbmfUM1bNbJbAalCdtAw9d9Z5fZs
 RQPKTpSX9M3LNFUTwnz1nwLUhdsQ5KgzJTIg5BdS/AF5ZXFj/Lk9KQgdnZSzPbOsO0PH
 tBDXgw84xCMmtmFnhPmV+bIJI8Nr0ErtHzO8/iVx65OEbIHXDJcCGT/WvQxUnL1qGhci
 K3FIg8GBswmo5TAcrM17s8xJ4GMSi5WhctLEwa2gdBk4RJ1OgoK8yduBEEdX8T7DZlUG
 YpPDDWnLRsJ3heAW92ikhhVF9/H51Jg3xHc8mBe96AzXQPAbf8yiIMw68pOa/AgxwI4O
 dDsw==
X-Gm-Message-State: AOJu0Yy2qp+8EtmCxtrHyeCq8DnA+HvIFz8J8b18pEDH3ZCJYQ3CpDZQ
 py4tv2aX2UkIxpF/NNwHVaema7Jiu9dwUlglgUqVKvwXkQnOoy2BgIO//RGoIUi41w1cGjUbAEy
 E/4o=
X-Gm-Gg: ASbGncuNzodyML9anF03AmQcv01xTFrFShBqaSoFlgXlfeBhrg0Sc78d9G/Dz40Tv8Z
 SBVRAs0YqKgulebP10KDEYvTIosj/L3+6xCc6WO5e1FNeGaJpSFPkBNdnQMTkwPWL6Fp7KLsYUp
 W7p2N5/Gr8Csv2Z5BbGhPYZOL8/y4tMhZvmEkEFVp5OY5wg+8FB6S0bOVet5xvATcqpXlcmLlQ6
 oGMiFrLkmO8ygNIMbqVSvJ8mBGgKIOoVQ4lZJf5spZbZp53LX8zK5ebcvfIWttbbGHS8CjVqbTe
 PyjqD4Re/WdWu/OT6hkTnWaxfdurJtZfAG3MuyGwa7k=
X-Google-Smtp-Source: AGHT+IH6yTdofAF2NC9fr9HQ3FFjmz4Og3BHEARe3y+Z2u7w1PT7IYs9sBG2DTWerJuPremGI/oS/A==
X-Received: by 2002:a17:90a:e7c3:b0:2f4:49d8:e718 with SMTP id
 98e67ed59e1d1-2fc40f1049cmr14477229a91.9.1739797642407; 
 Mon, 17 Feb 2025 05:07:22 -0800 (PST)
Received: from localhost.localdomain ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm24132925ad.182.2025.02.17.05.07.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Feb 2025 05:07:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] accel/tcg: Avoid using lock_user() in
 cpu_memory_rw_debug()
Date: Mon, 17 Feb 2025 14:06:09 +0100
Message-ID: <20250217130610.18313-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250217130610.18313-1-philmd@linaro.org>
References: <20250217130610.18313-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102f.google.com
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

We checked the page flags with page_get_flags(), so
locking the page is superfluous. Remove the lock_user()
calls and directly use g2h() in place.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu-target.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index b5230ce1837..3892ce12229 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -374,7 +374,6 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 {
     int flags;
     vaddr l, page;
-    void * p;
     uint8_t *buf = ptr;
     ssize_t written;
     int ret = -1;
@@ -393,13 +392,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
         }
         if (is_write) {
             if (flags & PAGE_WRITE) {
-                /* XXX: this code should not depend on lock_user */
-                p = lock_user(VERIFY_WRITE, addr, l, 0);
-                if (!p) {
-                    goto out_close;
-                }
-                memcpy(p, buf, l);
-                unlock_user(p, addr, l);
+                memcpy(g2h(cpu, addr), buf, l);
             } else {
                 /* Bypass the host page protection using ptrace. */
                 if (fd == -1) {
@@ -424,13 +417,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                 }
             }
         } else if (flags & PAGE_READ) {
-            /* XXX: this code should not depend on lock_user */
-            p = lock_user(VERIFY_READ, addr, l, 1);
-            if (!p) {
-                goto out_close;
-            }
-            memcpy(buf, p, l);
-            unlock_user(p, addr, 0);
+            memcpy(buf, g2h(cpu, addr), l);
         } else {
             /* Bypass the host page protection using ptrace. */
             if (fd == -1) {
-- 
2.47.1



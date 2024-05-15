Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DAFC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFg-0003zU-Rv; Wed, 15 May 2024 11:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFb-0003wE-QO
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:04 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFX-0003Ag-FA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:03 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e6f51f9de4so16363941fa.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785738; x=1716390538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suH2Sh1RTztpX0Ny0xBmvx/nzFkJoaQwrt5RKBi/xzU=;
 b=d4bOSwh0EVj6QdASzJfxOJg981UcYUQwh+D4RO5C7VyaoMN92D9GK2cMYXD3aWT1Kh
 h/nASHw+Vl1T6lSq4JYfEQUjlqJWY23+boJZ+aMmn5lSrLwxTBp7D4hieFoMpUEdI5KQ
 cuyjxspn/cZVcX7tKoNungDckvRQbuIo56Rc1d/7DImy1Dy/PwcHA/ZDldGdii9QD0k3
 XEcpv7Kg9PUao8ui7UIkEgwmYp4mc/fzao+nge2JbUam5XAm2PfmZFFhNbUmzDKwjc0z
 Q84Wv8rFxHisol1p7eqyT5v8UVDnPaY5NyJf6Cap+Zc5cSxNMEwbfZYA9zyPbAYd3YKJ
 cwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785738; x=1716390538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suH2Sh1RTztpX0Ny0xBmvx/nzFkJoaQwrt5RKBi/xzU=;
 b=L9zSXNZfarZllvcLibsRBNCMpNkq0xyLRkxYDfZqOGmkDj8NP6tXI5zp2nYONXBLA0
 3Z09BFHk1fej+o0RSv7kt6zbZlCZ3R6S1YjxddLOHg6PShkBbHvUvpN3b9Y/OfLQmNRD
 Habfnz8dV4shtmPwOQR72YpvAlt8HnihwlGlVLoq9qQmpCjhTcm8VZfUO5riAkG+qdcZ
 02mQFV6CToImJ+XXGm2g8rVPM80TSCmiPjfYZdY5J0dje74aYQ03suC+h/G1LiPRwmAB
 /ghdRbleVtT9ay+hpPbMVzSZUPEbntTU5AzdCY3WirANanTHC5KA7Ooz8VifngO1cZq+
 eZFw==
X-Gm-Message-State: AOJu0YxJM82NldTRLyxndbuyxtE7jEDM+JgxSs6kywHCWxcSt4Se5vPT
 vpBOHnL8YXjGNl1spdk6gHM/qphS918h081syn3qDkB9VlO6477w9E6gZ1uSAwgsLPmj5Kzn6cP
 xwyE=
X-Google-Smtp-Source: AGHT+IEpc0tT9SMkrFya03nwBS+jUfXbMg81ejsItpvQUvr3uCmjVHpKMFiIiAGfPIMAhxcTZcuB4w==
X-Received: by 2002:a2e:b002:0:b0:2db:a9c9:4c5e with SMTP id
 38308e7fff4ca-2e51fd47edfmr160540711fa.21.1715785737804; 
 Wed, 15 May 2024 08:08:57 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 23/28] target/i386: Honor xfeatures in xrstor_sigcontext
Date: Wed, 15 May 2024 17:08:32 +0200
Message-Id: <20240515150837.259747-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x232.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 95dd01820d..c2826a707d 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -613,6 +613,7 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
     struct target_fpx_sw_bytes *sw = (void *)&fxstate->sw_reserved;
     uint32_t magic1, magic2;
     uint32_t extended_size, xstate_size, min_size, max_size;
+    uint64_t xfeatures;
 
     switch (fpkind) {
     case FPSTATE_XSAVE:
@@ -629,10 +630,25 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
             xstate_size > extended_size) {
             break;
         }
+
+        /*
+         * Restore the features indicated in the frame, masked by
+         * those currently enabled.  Re-check the frame size.
+         * ??? It is not clear where the kernel does this, but it
+         * is not in check_xstate_in_sigframe, and so (probably)
+         * does not fall back to fxrstor.
+         */
+        xfeatures = tswap64(sw->xfeatures) & env->xcr0;
+        min_size = xsave_area_size(xfeatures, false);
+        if (xstate_size < min_size) {
+            return false;
+        }
+
         if (!access_ok(env_cpu(env), VERIFY_READ, fxstate_addr,
                        xstate_size + TARGET_FP_XSTATE_MAGIC2_SIZE)) {
             return false;
         }
+
         /*
          * Check for the presence of second magic word at the end of memory
          * layout. This detects the case where the user just copied the legacy
@@ -645,7 +661,8 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
         if (magic2 != FP_XSTATE_MAGIC2) {
             break;
         }
-        cpu_x86_xrstor(env, fxstate_addr, -1);
+
+        cpu_x86_xrstor(env, fxstate_addr, xfeatures);
         return true;
 
     default:
-- 
2.34.1



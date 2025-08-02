Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B9AC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLO5-0002h2-C4; Sat, 02 Aug 2025 19:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNu-0001fH-7r
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:26 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNs-0001jK-F4
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:25 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6195f7f9ad6so1222470eaf.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176283; x=1754781083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B0GtAHohLLp/KE68af6q8L0Ys4ZhoS/zBNogc+p6taI=;
 b=X7EEI19H9qF6PhFeiZnOX+0fl5Jaq0KemecTu1CuzbdNplwA4xFlxLuHc1SzC5j/G6
 2LM+5YSHO7MSC2aMHnM9oIGuovDEelFWon5ZXypYj/zoS2yWiNDUsfsgtiuhmRNZwMq0
 BfPUf+PxeXSyE+7HX+0SCXewMsSJ4BhfmMP+Bco39PS9gvbOrS4YytThnF7HHmydb7LG
 2qeeoXJnqUwOQtm43J36ubWq4VqdvRcswXjxtiH12Qf5hDJHQhiRpnJi5mBaprA+TUC1
 dFGidLGnTyYDCVPkQxtfZycW19zgbcDfpQOENtar3wlrq7ooX4GX7ye3w4ZMODWbawYC
 f0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176283; x=1754781083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0GtAHohLLp/KE68af6q8L0Ys4ZhoS/zBNogc+p6taI=;
 b=nubCTrrZqEpLjjnlpdhR+FFWIJI8FkKmc6kew/DWbEtC8v8pAMrVqWlmAykS6VHZ6d
 pKPdSNfVZx6bKX6hZ8KP1TMwiKNWq+e+OVd5dbcgRVNhk8m2p1bxuOjTCu7c5nihW25v
 ZXN0iFe7cYIMag7NJqZ8fobtrkURSdHEEDLn4tETLFTKHn2N4fGxPo0JsNTtIl9fJ7zj
 Y+rOEEtFLKPjBMnv0+hm3OLlNxux7ND5BvWwA9KEn7sM0KgvozA5KhMhfJ6fcbgDqb1N
 m60nS2VDeD0s016j+tK2UTxc59fHyiewXpNMSBPNSKGxSfmxxQW1K/q1i9DOnMgS6YSC
 MmLg==
X-Gm-Message-State: AOJu0Yz9EeG6trBUH32PkH88AdZgJcw4u7PDq0WQkaAAPNA/UzicE9/Z
 voZ+pPKGBRaQGR2yDU4jnEjy2perZGPdlpcz9m34EUkpJqPW8ww8nKDGoISAfPB8hteY/yMWj4h
 aWPAe478=
X-Gm-Gg: ASbGncuPZVJ8S7qxGJKMogpiF0dBLwqyD5RYHgkX9nn8MjDJGyFkbbj1f4c/25CpQPy
 S74LQ/2D2948f2nhx3vu4O5N4XgS7jj0ITdTaTXZzSyVG96+l1yOY++LgZRbLCXvexS70Ng/4mB
 X11aIIpJOocqFina+UVIUELhvI7eZoPUc7KKFW8hukH3R34TTTxOmGt+riOdypsjCqAdLR2dRkM
 gbCAYchlX26e2DH1Jis70sZPBNy0yq6/gcQRIuLCVGQ4zoQtfJVT/NVqZSfsGmEtQQhbR36tD1x
 X7yPM7TPJmtTvYgKM2maTULoVk4fn6Mw8CoKFprz08pH2jIuncAe3EsATDjWG1EgSu5Tw+2eDRy
 4o6bf3waPCQ97saBY3nrD1h+k7yGnUSkSvKTTKXnb1c1GFiRbO951f26/46IotC0=
X-Google-Smtp-Source: AGHT+IF42IHGZw/RzRJsM0bjGUJ+Pc+p2KALIQuSpsNGm9UtSCHOtB94Akf6AOGIWh9SV1Pmw4D8lQ==
X-Received: by 2002:a05:6820:2013:b0:619:222e:b697 with SMTP id
 006d021491bc7-6198f27bca6mr2081417eaf.5.1754176283023; 
 Sat, 02 Aug 2025 16:11:23 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 53/95] linux-user: Move elf_core_copy_regs to ppc/elfload.c
Date: Sun,  3 Aug 2025 09:04:17 +1000
Message-ID: <20250802230459.412251-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

Move elf_core_copy_regs to elfload.c.
Move ELF_NREG to target_elf.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/ppc/target_elf.h |  3 +++
 linux-user/elfload.c        | 22 ----------------------
 linux-user/ppc/elfload.c    | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 4203a89d66..dd8a65b1fa 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -11,4 +11,7 @@
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 
+/* See linux kernel: arch/powerpc/include/asm/elf.h.  */
+#define ELF_NREG                48
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 9ac530800e..0bfcbcf78d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -353,28 +353,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
         NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
     } while (0)
 
-/* See linux kernel: arch/powerpc/include/asm/elf.h.  */
-#define ELF_NREG 48
-
-void elf_core_copy_regs(target_ulong *regs, const CPUPPCState *env)
-{
-    int i;
-    target_ulong ccr = 0;
-
-    for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
-        regs[i] = tswapl(env->gpr[i]);
-    }
-
-    regs[32] = tswapl(env->nip);
-    regs[33] = tswapl(env->msr);
-    regs[35] = tswapl(env->ctr);
-    regs[36] = tswapl(env->lr);
-    regs[37] = tswapl(cpu_read_xer(env));
-
-    ccr = ppc_get_cr(env);
-    regs[38] = tswapl(ccr);
-}
-
 #define ELF_EXEC_PAGESIZE       4096
 
 #ifndef TARGET_PPC64
diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
index a214675650..9ebe252b3e 100644
--- a/linux-user/ppc/elfload.c
+++ b/linux-user/ppc/elfload.c
@@ -129,3 +129,22 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
 
     return features;
 }
+
+void elf_core_copy_regs(target_ulong *regs, const CPUPPCState *env)
+{
+    int i;
+    target_ulong ccr = 0;
+
+    for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
+        regs[i] = tswapl(env->gpr[i]);
+    }
+
+    regs[32] = tswapl(env->nip);
+    regs[33] = tswapl(env->msr);
+    regs[35] = tswapl(env->ctr);
+    regs[36] = tswapl(env->lr);
+    regs[37] = tswapl(cpu_read_xer(env));
+
+    ccr = ppc_get_cr(env);
+    regs[38] = tswapl(ccr);
+}
-- 
2.43.0



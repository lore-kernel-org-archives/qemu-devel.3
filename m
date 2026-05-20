Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F199CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgQ-00012x-Mg; Wed, 20 May 2026 00:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgK-00012R-Gy
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:22 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgI-0003lC-5X
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:19 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso4499907a34.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251835; x=1779856635; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7jM1jwUY6doQWw7cNzzrKAiwqt9SLepu9Iq35gPFd94=;
 b=SXtQUzxG6wJtX/CG0AtvEro6EUoqjKDQcid+g1rMkCyK0P7qRqcoFUWhdC0j5dr+Ab
 RZakdeg62c7flP3UDw3/8Q6NCDKhJ8NcdQNsZzBMicT2DrGYbUpE9A5Rqi3aQ5f0fYLO
 oSUtV+kPV7C6T4qRbXndnhrQCp8vM5aJ3lfwCCdrYoIx3Hy/6C4v6qOR+KG8KLiyuKtv
 uA3nIQaj78H0WHWu6igufcAUk72PNgGCOon+PeuPagcgCojuKRdmy3KXBvZiy96swWYI
 FEV06O9wF3KuyiqFqwNOfIPsRVuwks0K2WafjT9lztLo2czEPFPcIKsWNQgQ4pFKRxKp
 X8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251835; x=1779856635;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7jM1jwUY6doQWw7cNzzrKAiwqt9SLepu9Iq35gPFd94=;
 b=q6kZyBm/bWcpiqjMhwv/RCISHPWocoSB9brQfa9y6KM69P0ATY8LckPOzOttQ175q1
 4NGGiJGUf2vxN3kuZf0NjpVgk1qs9C3TWRpGh7uW5yXkPMe/BpUIwOgBOWyJaGr4xvTa
 iY8FPXsP6WMQ/8ShLUUePD2/n/RLbwDs0ida+GCu0lCAN11kcW6prmx5pNF2EsNnFzf5
 Feqt90CG4RoXp/wHBX1B6jEjMwKMMzGWn7XZc/9duqF2wLE/EtLUI82uoL1ZW5TShN0G
 dGx4DvG0+he4x+5lcqjCCwRq2u5/oM3liOUN+jyApqSwCrHF6LlWcGRMBpiveSiAPqnQ
 VSNg==
X-Gm-Message-State: AOJu0Yy/me8Qz+cK1bRJNGBqznXC44RopAQbJ9n13nryY9DUfjxSJ8/Q
 hkSNBI2TxWA1ucBtTHd00TMCr6LLssxq8TAQHB0qciUUyHQpsu7l20lv
X-Gm-Gg: Acq92OESVLTTHElkb9w4pvg429cdOZogV1bOfMylbGBDqtEFVI0wSEH6iMjfVjm8aTW
 93ru+oUXzM/KOgKovubDlQXnqxY4wxrq9s6Fy0aLTYrlF+RWBK/LCf2NYjUyrmjkJRnnTbhJGn/
 H7pl1HSS4f9hhmaNNaimMZyDunePDw+b8G29TAD6gVAOhzdfDqmfvEbRLKCYRqhtKj0EDhqPfo7
 6YRIyN89NX46EIsQ2bLc6Y7p6MsaIAd2jdvw4D0bIu4Ei4KjN4d+/5Z/hLaj2gEBm7PoP2yNYkz
 p2OJuHWAj0DZvtKLLuG5Q+4rYTcipaqcRDeB8RBq65/+jrdTCIWS5iDCbLS8MvFPPyTm2+/7iAM
 lNvvdQas8knRvV+PTO6ln07oMFu5fWmpCpMRMTKYzE65AfOCU73RnEn0lgoY/2ocO7nheq76TOs
 Rc+yq294b1LD81n0OXcu77E4AeJP2SNPr1oq4jL0Kuto6bFLOAc9LpDf4y5l9Hor67Dx05ysdRc
 K3LqnWjaX5YHNDnRCQgMOg0aJ4RctrT9wv/VUpOoSygITnAEsyqoL+cFYzyG5EOJfxPULLx1LsF
 hcs=
X-Received: by 2002:a05:6830:658b:b0:7db:a297:9e62 with SMTP id
 46e09a7af769-7e3f1030402mr16126360a34.8.1779251835551; 
 Tue, 19 May 2026 21:37:15 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:15 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:36:55 -0600
Subject: [PATCH v10 01/45] linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-1-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the target sysmips dispatcher and implement MIPS_FLUSH_CACHE as a
successful no-op for linux-user.

Self-modifying code is handled by QEMU's normal user-mode translation
invalidation machinery, so the target ABI only needs the syscall command
to be accepted.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MIPS_FLUSH_CACHE out of the combined sysmips/MIPS_FIXADE patch.
    (suggested by Richard Henderson)
---
 linux-user/mips/target_syscall.h   |  1 +
 linux-user/mips64/target_syscall.h |  1 +
 linux-user/syscall.c               | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index dfcdf320b7..3f36c1695a 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -10,6 +10,7 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 9135bf5e8b..20ea7c6ab9 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -10,6 +10,7 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d3d9fffb54..73f09bb775 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6630,6 +6630,19 @@ static abi_long do_prctl_syscall_user_dispatch(CPUArchState *env,
     }
 }
 
+#ifdef TARGET_NR_sysmips
+static abi_long do_sysmips(CPUArchState *env, abi_long cmd, abi_long arg1,
+                           abi_long arg2)
+{
+    switch (cmd) {
+    case TARGET_SYSMIPS_FLUSH_CACHE:
+        return 0;
+    default:
+        return -TARGET_EINVAL;
+    }
+}
+#endif
+
 static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
                          abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -12102,6 +12115,10 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_prctl:
         return do_prctl(cpu_env, arg1, arg2, arg3, arg4, arg5);
         break;
+#ifdef TARGET_NR_sysmips
+    case TARGET_NR_sysmips:
+        return do_sysmips(cpu_env, arg1, arg2, arg3);
+#endif
 #ifdef TARGET_NR_arch_prctl
     case TARGET_NR_arch_prctl:
         return do_arch_prctl(cpu_env, arg1, arg2);

-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24854CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNjw-0007Qn-F1; Sat, 30 Aug 2025 11:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wf-0002fz-7s
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:53 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wd-0002di-3h
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:52 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-771ed4a8124so2659562b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506289; x=1757111089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4f8Bk40mBnFtjMnElfv2A+6k42T3Vl2Ap1FLvlfy/s=;
 b=NhiCoejFNjT22znBHfOXlOaikLeY2XB8T2VNQZGzYwHOCMH3sSDeUQiKNSBAcoLQVf
 0EqL1fsFAq6yuAOBjquM7YkVzgJToXjd00z7NLfaC8mxZBHca7+9hXDaj4YiL3SUL3Km
 i4yOuDuhb3xA6qES801XdxMDeUovYt/nwc7LIcj0l3+qw2ONFM59MDVULXKo1VoQoJDX
 MzF35z74s/debI7FU9IVdsHeY2c6K49V3l8GSh1zN4O3PKMjdTxrEMa4NMPgGnMn6CUK
 ZTAzde8JshSzxebWAuTxc+zCWr35liuk7vv2aY+BJrb6fYzvZlPhcwZ6YsXk+1zc2J5q
 uLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506289; x=1757111089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4f8Bk40mBnFtjMnElfv2A+6k42T3Vl2Ap1FLvlfy/s=;
 b=Flbly4BHsCCcVyH7S+LsCrrsx+yiDcqej94T1m8oLVwrRnW5Ghr9QVhH+2PSUYFOdO
 6BP7tK8c38bR86rIr7RTnQGsPNtCRiJc+FuN/aalvL3jlTboCsb3CCfXkha/faFgxZ5A
 3bKyJdGlL/Q8aRDCHK7A/nuEfMU4xOgRJhYxpyNAanvPaBUe5lboDJ3J6f/TjKJxdKB1
 ue5/838M2qDUTowVlqscvpoWR63J+auHf7CJgE/ukSqt3gPml1d6jxdllEg14HGHTUYA
 mWefhvY0OTpjHGS3Z9KjPhM1eVNi2pa/PQ+muj78exuUxVQ9FvdhaaDGF6zUAIpNvv8r
 07HA==
X-Gm-Message-State: AOJu0Yx1PEftxJReJ04obNFtPgjG6pyVDu/ox3jzTLPmA2cRaxZkQLvE
 dWhkCKmVERRguDaKQ8k5h+7HxUFjDvK6FOKRpHEZ2yQh7dM/NvHc32EJ+LWJ77ELZdYwmM36Ovm
 ZMj249S4=
X-Gm-Gg: ASbGncsi+ZC8IA0LjT+zUXXisWYCHFk+vlVRcd8LA3elE2ikEsvB0nyJ0zUd6FwrHqU
 pXKwq/qGVpWmTO+2icDDVU3k8TZVvi0iyC1wuwEGczc7FcY/UjRyjIQJRu352CvlQ0wTtCsFolc
 C19q1t+PttX1mKv7HppSBzboYFHYMQeWK5cJbY21W0oW1kPK24W3Mp96ceq4LQ3mnUPSszxOVyu
 FwLtMEG9xnYNp3a1CSaef2EJtf9w2efgiRoQvtR66M+LLJq+onqeK8skhvp7eA22PKmhp8QhUzz
 IV6VHUBrn7KP06WTutlxnd3PDy1bx934YUEU38XrnfLYEGu56HXzEOrHnLnxD7Yd5QB7dXr389d
 HyNsv7l7hs5JzXV+bBqGGTlHE8x3qpwly14Ip2ZfsHklpDNq01MWxgfo+kCQ9
X-Google-Smtp-Source: AGHT+IEzNeUMTIm0I/7jVEc7kvWy/BnbCGlNwwfn0Xj/Lz7AIaEtVlYqD88PZlvaaXa4jYQRKOiMoA==
X-Received: by 2002:a05:6a00:bd90:b0:771:ead8:dcdb with SMTP id
 d2e1a72fcca58-7723e258689mr233617b3a.8.1756506288982; 
 Fri, 29 Aug 2025 15:24:48 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:24:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/91] linux-user/i386: Convert target_elf_gregset_t to a struct
Date: Sat, 30 Aug 2025 08:23:02 +1000
Message-ID: <20250829222427.289668-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ba205c5a19..e8a7f040ed 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -233,7 +233,9 @@ static bool init_guest_commpage(void)
 #define EXSTACK_DEFAULT true
 
 #define ELF_NREG    17
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 /*
  * Note that ELF_NREG should be 19 as there should be place for
@@ -242,25 +244,25 @@ typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
  *
  * See linux kernel: arch/x86/include/asm/elf.h
  */
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 {
-    (*regs)[0] = tswapreg(env->regs[R_EBX]);
-    (*regs)[1] = tswapreg(env->regs[R_ECX]);
-    (*regs)[2] = tswapreg(env->regs[R_EDX]);
-    (*regs)[3] = tswapreg(env->regs[R_ESI]);
-    (*regs)[4] = tswapreg(env->regs[R_EDI]);
-    (*regs)[5] = tswapreg(env->regs[R_EBP]);
-    (*regs)[6] = tswapreg(env->regs[R_EAX]);
-    (*regs)[7] = tswapreg(env->segs[R_DS].selector & 0xffff);
-    (*regs)[8] = tswapreg(env->segs[R_ES].selector & 0xffff);
-    (*regs)[9] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    (*regs)[10] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    (*regs)[11] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
-    (*regs)[12] = tswapreg(env->eip);
-    (*regs)[13] = tswapreg(env->segs[R_CS].selector & 0xffff);
-    (*regs)[14] = tswapreg(env->eflags);
-    (*regs)[15] = tswapreg(env->regs[R_ESP]);
-    (*regs)[16] = tswapreg(env->segs[R_SS].selector & 0xffff);
+    r->regs[0] = tswapreg(env->regs[R_EBX]);
+    r->regs[1] = tswapreg(env->regs[R_ECX]);
+    r->regs[2] = tswapreg(env->regs[R_EDX]);
+    r->regs[3] = tswapreg(env->regs[R_ESI]);
+    r->regs[4] = tswapreg(env->regs[R_EDI]);
+    r->regs[5] = tswapreg(env->regs[R_EBP]);
+    r->regs[6] = tswapreg(env->regs[R_EAX]);
+    r->regs[7] = tswapreg(env->segs[R_DS].selector & 0xffff);
+    r->regs[8] = tswapreg(env->segs[R_ES].selector & 0xffff);
+    r->regs[9] = tswapreg(env->segs[R_FS].selector & 0xffff);
+    r->regs[10] = tswapreg(env->segs[R_GS].selector & 0xffff);
+    r->regs[11] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
+    r->regs[12] = tswapreg(env->eip);
+    r->regs[13] = tswapreg(env->segs[R_CS].selector & 0xffff);
+    r->regs[14] = tswapreg(env->eflags);
+    r->regs[15] = tswapreg(env->regs[R_ESP]);
+    r->regs[16] = tswapreg(env->segs[R_SS].selector & 0xffff);
 }
 
 /*
-- 
2.43.0



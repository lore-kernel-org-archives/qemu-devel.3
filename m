Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D471FCCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 16:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8Zm-0006Jg-QX; Wed, 29 Oct 2025 11:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Ys-0005nR-3r
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:58:11 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8YU-0003Xk-45
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:58:05 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b6d5b756284so6744966b.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753452; x=1762358252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MId34UX3NzRcmw00YP9pkzNQ2Gj+AkCcJGiYrjRobaM=;
 b=lPEwkp5Q2GDWQuSTUEn19Ahq2L7FOPK2A4rRs1hAMDEdjO8uh2US1u3tLUlVFOS1cA
 qbsE0NlrN/zNdlxls5ahW0BsPHeghMPeEC7Zi/+YsTZF9zV1ZbBV54WSdWN9/wjlB9I8
 q3sOAVqqAWt23dywPjFyIFBxx8XswumAWnda4M6sPvz3gARqMVRpVmipfgBfgU27BRVw
 iZkRgofUXQQidBr3Ue5ZOeWO6ZwBKgyFAd8QcGQv22tdoqGiAYI1tMXLfEIGi8J64A1N
 HFsnm4o1dytzGJXijzv3Ko3bE7OjE42oAHtgrCi3yyJOGapABFrjmPwEwgkSty7FqlLQ
 BzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753452; x=1762358252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MId34UX3NzRcmw00YP9pkzNQ2Gj+AkCcJGiYrjRobaM=;
 b=qDLYShRL6TLNMAbipbVH5DkkZ3HRBGD36O/g2JbIzrMPNgBESB2tt63my31shmg1aX
 hRLfc0LRFlPED865bKTr68N/aEAqA01M6v8Zv+l85FZSp7vDnKJNvc/pYwvlfzQSr3sN
 6oiWs8dYzt2E8yUkEFC81IyQnXOZZcmXYaw3HjzQu7GdWjkqGjlXJIexSUXJ9sQhg8ip
 Xfxj55XOjW18/XjkKrRfGOznlcQG+Yz1sIML8T8FDuIPfEOTK1vOhRLaVoyJ5JY/SWfI
 FVh6aUbewMg6A1/II9HCBTfEmDiPvGqsnbttZzJPFGkP9MZsGpUD1lvRhGir2/7I7i58
 CKSQ==
X-Gm-Message-State: AOJu0YyvfmlOX7UrSyvA6RpD6Y2kjkrT7eXNX+lcqcdDu010Y8Sen6qe
 fCAqvkf6pu47SyptSwQoVGYf+0bjVaX4zmbiVrzG6ELjMXEZ9+HtgwmGBb6jPvNknHY=
X-Gm-Gg: ASbGnctwvYyQne4q6prpjhiJncThcTx2Ruf3Ku0Sakjdt22Fr/4BMUZ/UkQfgA/MeP7
 z8YOitscV9xIER+rwxumNXffkhz2Qm5XF2pzR+9XX4oH9rxfjztvru5CigRLRBM7EiVJP+s1huB
 nuEsYzkPxflOBaMNFUwjtSG/WQsI2nwzUQ7yyIfGc7WKQPB8VRNtS0jwU28Hl1AfhIIVdWya90Z
 pSB6/yaLPZaJ0C98isIdRSBno08/IwKhZo4ZZPjoJt2OKTvoZGlY372z44YQgUVqGwhva8bwDCH
 LXQrrQ/hahQIPcozZeUYYKc2pgZwRy6VBlC8sTTAAq4lVOkjtHpZ4IpAVfzYXajcC+PYqs+tW/A
 jY01gDhwnMD2BZJ6fSdEXHLkVQM6HdSpHEoyGxhAjH1zKdt6OpgnePdc5CiefptAzwokG1fzVvy
 D8
X-Google-Smtp-Source: AGHT+IFas+EgjH+CZpJNYBxdSXKEfyuQA8kpR4su7TZkZHIlGPRW+W9F8QX7Q3YQoOER1ITQ/5ep2A==
X-Received: by 2002:a17:907:c06:b0:b3e:fe8f:764 with SMTP id
 a640c23a62f3a-b703d45726dmr334603166b.32.1761753452044; 
 Wed, 29 Oct 2025 08:57:32 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853f9a0fsm1452040066b.50.2025.10.29.08.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:57:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3B5B260DA5;
 Wed, 29 Oct 2025 15:50:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: [PULL 24/35] target/s390x: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:33 +0000
Message-ID: <20251029155045.257802-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for IBM System/390 targets. We treat "program
interrupts" and service calls as exceptions. We treat external and io
"exceptions" as well as resets as interrupts.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Message-ID: <20251027110344.2289945-25-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 0ae4e266065..c6641280bc6 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -35,6 +35,7 @@
 #include "hw/s390x/s390_flic.h"
 #include "hw/boards.h"
 #endif
+#include "qemu/plugin.h"
 
 G_NORETURN void tcg_s390_program_interrupt(CPUS390XState *env,
                                            uint32_t code, uintptr_t ra)
@@ -502,6 +503,7 @@ void s390_cpu_do_interrupt(CPUState *cs)
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
     bool stopped = false;
+    uint64_t last_pc = cpu->env.psw.addr;
 
     qemu_log_mask(CPU_LOG_INT, "%s: %d at psw=%" PRIx64 ":%" PRIx64 "\n",
                   __func__, cs->exception_index, env->psw.mask, env->psw.addr);
@@ -531,21 +533,27 @@ try_deliver:
     switch (cs->exception_index) {
     case EXCP_PGM:
         do_program_interrupt(env);
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
         break;
     case EXCP_SVC:
         do_svc_interrupt(env);
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
         break;
     case EXCP_EXT:
         do_ext_interrupt(env);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
         break;
     case EXCP_IO:
         do_io_interrupt(env);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
         break;
     case EXCP_MCHK:
         do_mchk_interrupt(env);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
         break;
     case EXCP_RESTART:
         do_restart_interrupt(env);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
         break;
     case EXCP_STOP:
         do_stop_interrupt(env);
-- 
2.47.3



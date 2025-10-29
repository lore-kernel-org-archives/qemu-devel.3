Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E331CCF9F9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8Zp-0006MU-GF; Wed, 29 Oct 2025 11:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Yk-0005Ui-0W
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:58:02 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8YR-0003XM-Tm
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:58:01 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b50206773adso238663366b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753450; x=1762358250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6TnzkMVL6YklkleCxaGQEy3FPm7r0vZ+EhWkgXooxc=;
 b=e9FJeSz5pAZ6Eg2s2zmwQjMqGIOdjLtxZ5Kk1rywdqetHGKOVQjvTWl9O/b3H2Gy+l
 Yrp6Jye4v75ea6aSLyKRJeugiubD8HAOT//q7CMvamQVUD8w+EjFVyrqPhDZw457Hiid
 vId6SF4++4WYUAFgQQogxdofk91VFo4kKMm8R6R6oN6K8ObjUr23FqXIhpqCQNaUULv0
 o02d0kbgvlWkvAOgaAVpJ7E1bAZyRZPX5apWjFedE8ix/7NW+XZ9NF2kH+6+2IITlRma
 5TqYNlx2578egwWVivBXAcIaucTcZHS2p3maSDq+Q28VGl5L/AAr2W683jLpVCYZoYYv
 tAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753450; x=1762358250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6TnzkMVL6YklkleCxaGQEy3FPm7r0vZ+EhWkgXooxc=;
 b=GQTbqsx9ukAZXT/VJrxCN+FIp7fh0YNQ3KY20srKlW+JSKA3T8rqr367Qmutsvn70s
 +B3ftYSNamZ39Q8SJ1mkML5I1R7U9A9K8IwmOB2GjqXY2GSoisNhiSugaEUowMC9GzOL
 woIWrcsa54i1Mkl3vEp9F2I8bAHFZKdl+bNcvkkOe0WltvXPu8MmCpTWoXSgHJ2UO8kK
 z+rmK5i9kQnvvhmOOAt9Z6znACaX/rqzoHB4juLms1Sk3mLDdaoBYMI7BPJXSxVr6VZj
 QGM++zNVSza5Q86rac33zc3aSD7lQjRdgwPY0aG5kdF9LiDX+2xsViJIQ02c1g9plYh5
 LSOg==
X-Gm-Message-State: AOJu0YwSjpk0AI8VC8JUHNl6W8rqpoc94hnhFiDIisMd+bJ1oEHh41Lg
 JN98N1/1cijLeBScN52f/qheXrCl3jfWxmWiAFvwKtilATyfteHts6rSZC3q5Z5eYEI=
X-Gm-Gg: ASbGncvZpi1UsonATScplgYtjBMfXXeXlglcHN/BTtMqi/29joT7le7r+R4GE65iSZv
 3Jfj2x7tTY6R9XxtaM5cQkJkcWlu1IcfzPVW3RByVKdyliMsqRY7oX6HjlBR8sTzljMOxAcfy3p
 KQNE3XlCYKzXxKR0cILsGCKYxZqFUjrtLKUQ1/3iEEX9ebC8oRaGYiuyPyTrPtPfjksp9eFq1Jc
 RiDNUkKffWQDGZkQCaTmcznThLeCWEfU2ZB1YAJyksur+fJTPCRA3UG/gwrBLJT3uJRY9/al/2C
 gBd/KVQWn7Hfz+Me8uC0BodExrAVysPLyqBK9YinYkx2kIds0J2mMLs7ielTVVZXUECYaseP2WQ
 deUUAI4EKlD+HAAAQ5j2iBvtUipiThONH5VuYn+SJaZlkVqO2hz0ZKZaZMHZ4W2ul+lq7FFh0zQ
 eY
X-Google-Smtp-Source: AGHT+IEDe6OTxnw8vElqEb5iO57nd3s38uzJLKhBT1pbpZFFcbK0PeP2Fa6C9Nhr9KZWP8KqK5qQlA==
X-Received: by 2002:a17:907:7f9f:b0:b46:7e8c:c0e3 with SMTP id
 a640c23a62f3a-b70520e181amr9859266b.20.1761753450187; 
 Wed, 29 Oct 2025 08:57:30 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85445e81sm1459774666b.64.2025.10.29.08.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:57:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9E6AC60B4E;
 Wed, 29 Oct 2025 15:50:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PULL 18/35] target/microblaze: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:27 +0000
Message-ID: <20251029155045.257802-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This change places the hook for MicroBlaze targets. This architecture
has one special "exception" for interrupts and no host calls.

Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251027110344.2289945-19-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index cf577a72268..a1857b72172 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -27,6 +27,7 @@
 #include "qemu/host-utils.h"
 #include "exec/log.h"
 #include "exec/helper-proto.h"
+#include "qemu/plugin.h"
 
 
 G_NORETURN
@@ -35,6 +36,7 @@ static void mb_unaligned_access_internal(CPUState *cs, uint64_t addr,
 {
     CPUMBState *env = cpu_env(cs);
     uint32_t esr, iflags;
+    uint64_t last_pc = env->pc;
 
     /* Recover the pc and iflags from the corresponding insn_start.  */
     cpu_restore_state(cs, retaddr);
@@ -54,6 +56,7 @@ static void mb_unaligned_access_internal(CPUState *cs, uint64_t addr,
     env->ear = addr;
     env->esr = esr;
     cs->exception_index = EXCP_HW_EXCP;
+    qemu_plugin_vcpu_exception_cb(cs, last_pc);
     cpu_loop_exit(cs);
 }
 
@@ -152,6 +155,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
     CPUMBState *env = &cpu->env;
     uint32_t t, msr = mb_cpu_read_msr(env);
     bool set_esr;
+    uint64_t last_pc = env->pc;
 
     /* IMM flag cannot propagate across a branch and into the dslot.  */
     assert((env->iflags & (D_FLAG | IMM_FLAG)) != (D_FLAG | IMM_FLAG));
@@ -256,6 +260,12 @@ void mb_cpu_do_interrupt(CPUState *cs)
     env->res_addr = RES_ADDR_NONE;
     env->iflags = 0;
 
+    if (cs->exception_index == EXCP_IRQ) {
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+    } else {
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+    }
+
     if (!set_esr) {
         qemu_log_mask(CPU_LOG_INT,
                       "         to pc=%08x msr=%08x\n", env->pc, msr);
-- 
2.47.3



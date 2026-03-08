Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE02AF55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8Po-0006h8-Te; Sun, 08 Mar 2026 03:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Pn-0006gZ-BP
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:03 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Pl-0001UO-1C
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:03 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so5550973eec.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954340; x=1773559140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9uQNT9o2GLb9giYbEOFloxBJ8zsyJlWtCC5Gm5KoDGg=;
 b=jZMHWmo8nANlGPaXPGJPKOMIOVu7JxNTOeokl9+KJa1Uwth1YV0i9ixIAo880PHuU9
 VZGLhEQaj6ngv+hhNlfczpdecRHvwaIhdA3GJKD8fyJ+XSAQU4HJ2AnFBdDxMhpG/JXF
 XIuKbPinihtX99LYKxht1GiQkH3H4Z2DhVBc1/jv6nzXrrYEorFxEipR+apmKtCsT+EA
 QjY1rWCxOCCKQ3j7cMfm5WqIciXN8QhtZEehjifXodcLjg/bZWiKJYcnbCE1CWy2dVUy
 2Lv8ypEbS0efk0Y5/T7xjVa4KsI9lGnFI+UjxCajQT1fkQIph8yHQbyMVJvcTqrX00iw
 /QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954340; x=1773559140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9uQNT9o2GLb9giYbEOFloxBJ8zsyJlWtCC5Gm5KoDGg=;
 b=L8vlVkvzR1R5G/M8QJw+VT9wbeYNQsFN9F0Am9RO/Rl1u9Dc8TLZqw+9Mg/olOu3Aj
 /uSb0HyvEXBZxZqcjBhSHSNJe8VONtdhwaVnFA9biexVlt83kBw4DSVXcoC3ZMyr3Gtb
 VDpVHAb84PSFksYyKdKeIQlcPMRNG0ucfAphKiLc4XnUBRUZjXwzsQ9OixcHqpN9qKFz
 AUP025rTv32NMcQT6kwXsKIZ369qDEfOkuGx2f7MmVKmh+rROvHR7GXl9cjAhgfU1uDT
 mwsNAX0x0WQyOeFKRgmAP4+OFtpUDZ6a+fQcKxO/VEYNdH1FGmLBURkO43QFVvSbQioj
 lJag==
X-Forwarded-Encrypted: i=1;
 AJvYcCV97NY2DqGDz1TMwaEnFYILyMW/DSuzW/WQmRvykDKvZ6+CZLO9jG16IDqrH/BHU8GRlveU5wFK4AHe@nongnu.org
X-Gm-Message-State: AOJu0Yw3HeQpZIjbzXPO9ILg8fiPQEvqXOEnfGZTaPS8k38ZsAYZQ4Ef
 G2QZQ0IeIwmlZ2HfU/GDHf8YfbTI7DEvYd8KS17K0lY8jg3I0pSgmNkg
X-Gm-Gg: ATEYQzxv6BqAbyDR4hVHvkNLgT/9ksr+IWb1NkyJjoQvS4c1u84nAe/d0TOBMsseHdY
 a1+5HmfpirNhGsI0pNwXUYN0fjlgy3qJKeF6Ny0p0tJ9SnBZyhtT8D7dMF78jExYsG4Bbv58lt6
 nUAd3SBPsXg2hK2IhIiWBK9OBbEGPD41ivd2geq0Sxp0MPwjTCPDwXHdbPlIpEd8r+n5fLo2LS4
 pf1TGpil+hHCOQfPUhqxe7bogh3CDJLeQYc10RzhEkIxZOJlXNz/mUS3uGkT+IUvAa5Qf/Au39+
 7i7FLMcFczBcpSShvm0WCOHqJ3OORK+8/YQtyNH9c9E10p49eCDUhjlSUSLU7zpt3llM2asmxOI
 cXmFpdVWZl2wKQda1VZPxjtBjKue19jfoUdTAvgWUAq6mmdGcA7g01VjdP5DzJ6fdHd7YMn8hmg
 loTij8JIziB75cLA3RfdlDR4SgBsRoMVLBsQ+UAS0BwbaUsSaaHaxQQyQBoVZ0ZmpCsPeBR1oJv
 GZ9qlQ/C+bKzGXfsCfRHMq+bNA=
X-Received: by 2002:a05:7300:e619:b0:2bd:d157:6786 with SMTP id
 5a478bee46e88-2be4e03ab3emr3182506eec.25.1772954339699; 
 Sat, 07 Mar 2026 23:18:59 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:18:59 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 05/28] target/riscv: re-enter the DM ROM after single-step
 completion
Date: Sun,  8 Mar 2026 15:17:08 +0800
Message-ID: <6b320e8671c22dd26ad89df4fb8c90f3995514cb.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When single-step finishes on a hart backed by a Debug Module ROM,
restart execution at the ROM entry instead of forcing the legacy
EXCP_DEBUG stop path.

This lets the park loop observe step completion through the
normal ROM flow and keeps single-step behavior aligned with the
Debug Module run-control model.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/op_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index e7878d7aa4..945688eca8 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -481,6 +481,10 @@ void helper_sdext_step(CPURISCVState *env)
     }
 
     riscv_cpu_enter_debug_mode(env, env->pc, DCSR_CAUSE_STEP);
+    if (env->dm_rom_present) {
+        env->pc = env->dm_halt_addr;
+        cpu_loop_exit(cs);
+    }
     cs->exception_index = EXCP_DEBUG;
     cpu_loop_exit_restore(cs, GETPC());
 #endif
-- 
2.53.0



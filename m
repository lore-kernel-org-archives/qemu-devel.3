Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB9CCA0EFD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 16:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk4nL-0000nA-6b; Fri, 30 Aug 2024 12:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nJ-0000fP-1I
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:17 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nH-0006xA-6u
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:16 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7142e002aceso1753475b3a.2
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725036493; x=1725641293;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfvLnj6XNfSIT8sSl0+fnX4A6Nm3Jxdidu50F7PUqy8=;
 b=iupA4Y/beFGLFxzP6F+ymUDSCcLXQxYAaWjUjpq3CBB+iontTc1tpxPTw8cVz6oS/V
 8pxxEon6vaENcsAjg/V3w27hHujIvybkaSgLwXnNuIw9QJD+hkz5J13HSWtE5ePzHdoR
 MfkyvjQBE3SLwie40Ie6vcL8YKQSaPvHIgTckxhuVNcCD/xhB/4gADy13ljYsU4ZKWyp
 bZCYH8YLGFMj9fPyGTZEfWKEJUdseD3iD34apXsNky8YyPRNmpF+yOsEzPczbgLccnnF
 ogf4XQ77UeCngr/xxfxGtb8KQkf3CN//CflIT7EmHGzQ0269ViK1QA4pzbrvXiN+h2FQ
 tRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725036493; x=1725641293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zfvLnj6XNfSIT8sSl0+fnX4A6Nm3Jxdidu50F7PUqy8=;
 b=UIzi1xFgkksLJ38W95Gasp9wi3JbyrZhlTkXT4LRpd/DSQqlTLXeckM5K9FwwKK1UK
 07nFH30YVLKXb6FoBbBOvFtsxesAWy3aGwlg/u/ahG/goE5mduZDKZAu/YWfKPpmFFfW
 dI6cXEhbUVlwa0SQX8NhOlQIKGsD0LJc5UfJcYFxszW4+EybpwmpaBD58vT91SNFQhhw
 +wnep80Ka0cpQLCoW+EUBzi8mVa3O+BrzQ5UIx36o4OjDhQ4BHDozu9RX2zitR5YTLj7
 IVJau/HvZRDx/5TG9OHeuw8zD/gSuqOeHdd9QudNU/0Ra9LeMvbPEBQp+c3Bi7GtwzkK
 9S3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQydmJUK5DZfROe91HZEMSaw3RTedSB2iWzX6oc1NK4OeSX8DT6NRrFt3mNm6vfsyx6TVHtnWOxr1l@nongnu.org
X-Gm-Message-State: AOJu0YyxhrFnNmyHGKL2lc9k4w/3BXCAEEmbI5K8K9+apNt8MXg9kL5E
 YUtNRh1H49s0D8eNbsrZakwpg+f8i0BheEpm6hnmkvbXVFU18BCwWGSrmCsC+y8=
X-Google-Smtp-Source: AGHT+IGYdJGv+MEqBfxgI0EX9NBDFjNo9SVkJ10xPzAM1rWtOEL6ROAbfDxcBkVuPSVd9IMhyjOB4w==
X-Received: by 2002:a05:6a20:d487:b0:1c4:bbb8:4d02 with SMTP id
 adf61e73a8af0-1cece5d12cemr208328637.37.1725036492682; 
 Fri, 30 Aug 2024 09:48:12 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8445e813dsm6591257a91.17.2024.08.30.09.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 09:48:12 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v13 05/20] target/riscv: additional code information for sw
 check
Date: Fri, 30 Aug 2024 09:47:41 -0700
Message-ID: <20240830164756.1154517-6-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240830164756.1154517-1-debug@rivosinc.com>
References: <20240830164756.1154517-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

sw check exception support was recently added. This patch further augments
sw check exception by providing support for additional code which is
provided in *tval. Adds `sw_check_code` field in cpuarchstate. Whenever
sw check exception is raised *tval gets the value deposited in
`sw_check_code`.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 2 ++
 target/riscv/cpu_helper.c | 3 +++
 target/riscv/csr.c        | 1 +
 3 files changed, 6 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a7c970e70c..a0f14c759e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -224,6 +224,8 @@ struct CPUArchState {
 
     /* elp state for zicfilp extension */
     bool      elp;
+    /* sw check code for sw check exception */
+    target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 5f38969aa6..fffd865cb4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1760,6 +1760,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 cs->watchpoint_hit = NULL;
             }
             break;
+        case RISCV_EXCP_SW_CHECK:
+            tval = env->sw_check_code;
+            break;
         default:
             break;
         }
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5771a14848..a5a969a377 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1179,6 +1179,7 @@ static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
                          (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) | \
+                         (1ULL << (RISCV_EXCP_SW_CHECK)) | \
                          (1ULL << (RISCV_EXCP_INST_GUEST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT)) | \
                          (1ULL << (RISCV_EXCP_VIRT_INSTRUCTION_FAULT)) | \
-- 
2.44.0



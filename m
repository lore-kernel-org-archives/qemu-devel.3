Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE594C636EE
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 17:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjMm9-0007My-9Q; Wed, 28 Aug 2024 13:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMm1-0006u7-U9
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:48:01 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMlt-0004Qh-P0
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:47:57 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7094468d392so5244060a34.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724867272; x=1725472072;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfvLnj6XNfSIT8sSl0+fnX4A6Nm3Jxdidu50F7PUqy8=;
 b=tU5zjrgViauGjC6/TCZkWW8paWshZL3CWb+PuQYxe5rYTSpJ9egvTo2B1iSfPjzljR
 9Ci2OktbhOEA2aOmfNL7Uimgk7s6Kd1yt+ksyF+eSMbL9b3HoB46eyWMprA0gzCKdPvm
 amchZGskC/cyI92oldiR9AemQAgv+eCv2qX3SNEIa0UxLLrkQM3NPM7AEAV8vdx44XcR
 HPq6BIcr9PA1UNzc/95C/+xOD4GHKuXFRWhLA+dqjjI0zkhiRKtGG0o7m42EjkXzu594
 YDhGnaKRlRqQHT/7vOett8mbNh4ihMk5WM3UHX5RU3XtYt7D0vuxgc6/hmc9lkPgOLDi
 /ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724867272; x=1725472072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zfvLnj6XNfSIT8sSl0+fnX4A6Nm3Jxdidu50F7PUqy8=;
 b=v5H1LjfapP8HC3vCLnM1QPlfUWS/P+txl+uLfXlmfyYgbNfPaXdQuO0T2mQaKTMx9+
 59J8sY5pRqIj1RPVD/q+h2XR7xljFMJvbxYTU/UsOuBga5NhdTlSeuAPGomlzD8lOyNJ
 eFkiYM9kbVmpBb42zSSh6qbdC/MstHjtB17HW/lg5lspMTUHG7mT1pCj9KmCbDKgnCaG
 2Tstq6Gb4rJxcB+hzLIw9q6E33iwgcO1faQbwTlly7/lIv3yy9uZemPO/yh9KQU1spXb
 o9cznJGsjJGKljpkbnRFUU9DTVhFOzvBd3z+SaGeubS0duG4ZrVJ7yI8n4zvUZp/3Tk0
 /Qaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt3d0gBVENiMCgWzJooaD1wYNMZdBT/Yt6+KVoRWqgu8vNjKETEsU2WeYHgXdGb/C/Xi257rfLbsxm@nongnu.org
X-Gm-Message-State: AOJu0Yy6Pcs40QwGYSs6qBy7+xR/T3l3VwaJl/lKtU3xH3sScNKgAKPf
 eeyCbG/upfAuLON7HFknM7mMZ6Avm72MNCS5gEdhaf4tJzLq01r9K19oPRqFGzQ=
X-Google-Smtp-Source: AGHT+IEdeSGoPEd5/fCc0wvhpRtYP2f3+ZYoNMRT0F4g3o1b24zmMxJc48nPhpHOqtx4xLaIKBuiDw==
X-Received: by 2002:a05:6358:29b:b0:1ac:65e9:1678 with SMTP id
 e5c5f4694b2df-1b603cb7627mr64537255d.22.1724867272274; 
 Wed, 28 Aug 2024 10:47:52 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9acdcf7dsm9778316a12.50.2024.08.28.10.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 10:47:51 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v11 05/20] target/riscv: additional code information for sw
 check
Date: Wed, 28 Aug 2024 10:47:23 -0700
Message-ID: <20240828174739.714313-6-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240828174739.714313-1-debug@rivosinc.com>
References: <20240828174739.714313-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=debug@rivosinc.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



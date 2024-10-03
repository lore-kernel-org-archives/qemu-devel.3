Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B82CF34BE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swQej-0007Oi-Ut; Thu, 03 Oct 2024 14:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQeD-0007BF-1I
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:33:58 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQeA-0004tN-H7
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:33:55 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20b9b35c7c3so13149885ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727980433; x=1728585233;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKczBHanLSZvcjjGDp0D2cgwbOL2pYUmrFfrlbX195U=;
 b=lCt+5p2UdmjMkRQsHvj58JDocRfLekXS69heqTWhIGNsBjNRKoB9DWGWVMOI545hOe
 yaJ54Tw5VRL5bwY0EhMsmfCIp+eMXo6AqqN5LHIt0emoTgPinoVvQgAryJqRID0g3qo8
 QevD+RW4v+b4fibb1mGcskIrIWWXu68JUn80iyTYxSDdB4swN4eueWjKHdbIVraMflJS
 9WhOwIvGrq4GLxTHsiXKT51Xkn6V/Ln2vaOvZH/JdKQH68TijZiQMzwvHEHDH0A6fKbi
 yMAYjT+eUflB3pQsUBdB1L1Avj/NZQD3KhvZoKnFxd6W74SeCdcoF81l2dPP6JFwEcPu
 bATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727980433; x=1728585233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKczBHanLSZvcjjGDp0D2cgwbOL2pYUmrFfrlbX195U=;
 b=WmICJIOYbq4dwdXViKfe3UrhNTitE0sbQiaRXM6oylKpOQkbILrKJ5k1bliQbawSqI
 xpWsycWUTPEpTFjpkqqX00cv78+csYH7TL9Iqr5vhzbzbHElY0zZ4osKjov68ED0dscL
 6YWFqGSjhUllYYvmxnvUebHJGdeSesuvdTe+6C7XyK1f/DyOdObdaSRR8kMRN06rh4v+
 VzuqVhdNFn73brpKRyhkBfezoPloRFx8qZe9BEDhY4aG1DLX21JW2gZ8HkkFx6SjmtWr
 avh1OZ61fzBS1H5vqgMixLijAzX4j3tq+wj96qbSgAeWXXVIef7J+R+u5Z1F+70I3HOL
 zomQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp3hq2jMHHc5vnEHF9Jpn2UwYiOzahYBQ3SqUt1NV/zjBglSXbVRWA65XIQtTdEaYlj8D65Pw5lnCP@nongnu.org
X-Gm-Message-State: AOJu0YxqYRgfoBAiFHDKFamdY76uNR7GZ2R6YSZV5VWIaBcocK7eD8tC
 ha9pQK9O92jkrS+b/QQpysIgChEmrT2Vk7whew7/ZMU57RGsFee3ju7Zx/xRHIc=
X-Google-Smtp-Source: AGHT+IG0xDFC/7Eh5dDuEKdqF51u8bgkLD8q2F5Xq+gomvVqfHWLlVWKg/ED+HVVw5On5BQfMlPk2w==
X-Received: by 2002:a17:903:1c2:b0:20b:fd3f:b44e with SMTP id
 d9443c01a7336-20bfdf6aeedmr2004255ad.10.1727980433353; 
 Thu, 03 Oct 2024 11:33:53 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beefad16asm11796245ad.193.2024.10.03.11.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 11:33:53 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v15 05/21] target/riscv: additional code information for sw
 check
Date: Thu,  3 Oct 2024 11:33:26 -0700
Message-ID: <20241003183342.679249-6-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241003183342.679249-1-debug@rivosinc.com>
References: <20241003183342.679249-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index 6c5e199e72..dc33604b13 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -232,6 +232,8 @@ struct CPUArchState {
 
     /* elp state for zicfilp extension */
     bool      elp;
+    /* sw check code for sw check exception */
+    target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d7b776c556..8ad24ed2a6 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1766,6 +1766,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
index 57cef9e682..919de7970c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1377,6 +1377,7 @@ static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
                          (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) | \
+                         (1ULL << (RISCV_EXCP_SW_CHECK)) | \
                          (1ULL << (RISCV_EXCP_INST_GUEST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT)) | \
                          (1ULL << (RISCV_EXCP_VIRT_INSTRUCTION_FAULT)) | \
-- 
2.45.0



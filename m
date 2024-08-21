Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E009AC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 21:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgtDp-0005Dx-L9; Wed, 21 Aug 2024 17:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgtDn-00056J-N9
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:50:27 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgtDm-00085D-2H
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:50:27 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20202df1c2fso8608175ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 14:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724277025; x=1724881825;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NjZJpddrUYMLka+s3BuiKelWfoIA0sOQqw+ndLoWex0=;
 b=D3tAQx7p1nzD8z9Qbv7fmMTqaD8+kMX96fiWU1OYLgRyyF17OMXyhmzqvGC7jD8Hqw
 daiDAmYT87UHE4Rg0ZN1uYVEGBniSZ220+I/9cjRu+WQ2cxsO3urcQVgVNe55ZCRYo5G
 Ux3bvWnQtnTLnGMfxGGIxX+s8meGkYYUYmyMxkHeza9YJ17fPu7tyFPAhyozg0vDgZlz
 iKwK9x7TeYvhpSxhTZqqsdqqX/MuP4+HCzV1L9DJhRASsjoc+dOp9oUPKR4snD5i2Ej6
 B00YaWFhX7gqe0NNrls5eyzlouLOF6Yr3PPutAWNfjfZb5P58zajmId3PJ42sDVBA61O
 eL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724277025; x=1724881825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NjZJpddrUYMLka+s3BuiKelWfoIA0sOQqw+ndLoWex0=;
 b=LPe4bMQzpFzNIIjjCMxXMQ+R1gNeDkfLtpHEzqKfnZ5NvQIwmDF1OfahFtrUyRVgyA
 H6/AdJnp8QT5kQOxMfh9hoEiuf9uVDuz6hkf8EWfFDMnxcXiPRXqaGJnFoSxiLqny3dc
 BhBAtZq1il/UlEkYepW29+MKBqVezMkDgFctoMk706CUZSF6x/szPBgm8Vrv2LvnXFQB
 cr6ikLVNtyVMMkB0zkJfkIFirBBMfgu0DvOYspoQfDMhHEoAfxq5i5YcdJcVyFnjEJvS
 Q7SQOB/8DPIuoWaOQFjMSKyeHEHIo7jtiggzlwTzfZDAmC/ldpYCcBl4G1xeL/Fq8/hs
 Iu/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZJeQ26jyByDLMMbHNwtttu9XQI9tX3+IVIH3AGK+aahsQTDkF0JsQRiU2NotgMPKHJXojyv2c4LHV@nongnu.org
X-Gm-Message-State: AOJu0YzqqFLndz2VMy7Hct9RoVxZw3qW1aOwv+3U8QMlITTGkqAEWFLG
 IH2ZQzOoI2l4cDZRCebmHbbzOJ9/rnVH9chDjQssrSYRMnNAk3kQVLXRroD0MjnObj140VIUF04
 J
X-Google-Smtp-Source: AGHT+IGw9aJUomE46Za1+eitEVO8u4mknwXbr7u5DBMrjoywHxLzE8vCV6hVqOSqFemVNgx3VlhX0g==
X-Received: by 2002:a17:903:41cc:b0:202:4480:1d58 with SMTP id
 d9443c01a7336-2037ee2947amr11072225ad.12.1724277024428; 
 Wed, 21 Aug 2024 14:50:24 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203859ef0fdsm586345ad.248.2024.08.21.14.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 14:50:24 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 04/16] target/riscv: additional code information for sw
 check
Date: Wed, 21 Aug 2024 14:50:02 -0700
Message-ID: <20240821215014.3859190-5-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240821215014.3859190-1-debug@rivosinc.com>
References: <20240821215014.3859190-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62f.google.com
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
---
 target/riscv/cpu.h        | 2 ++
 target/riscv/cpu_helper.c | 2 ++
 target/riscv/csr.c        | 1 +
 3 files changed, 5 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7be0fa30f7..11c6513a90 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -224,6 +224,8 @@ struct CPUArchState {
 
     /* elp state for zicfilp extension */
     bool      elp;
+    /* sw check code for sw check exception */
+    target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
     bool ufcfien;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 12484ca7d2..9f08a67a9e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1761,6 +1761,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 cs->watchpoint_hit = NULL;
             }
             break;
+        case RISCV_EXCP_SW_CHECK:
+            tval = env->sw_check_code;
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



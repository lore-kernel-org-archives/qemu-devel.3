Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45CACAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTg-0007L9-2s; Thu, 02 Oct 2025 23:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTc-0007JU-Pq
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:29:00 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTS-0001IZ-Ic
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:29:00 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-782a77b5ec7so1619052b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462120; x=1760066920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/j5ZjJ/h+K0VX8BTh5DpvAOuwcrZHBQw+WvgJDBarMg=;
 b=VflPZC8+JJUUSLtgYgrASMpLPpql4feZVL18Xx3sQoA7TNz3SIZsWjSjA4rJYB6SfF
 sOkFyfOp0ETU7apLqbLeo3fDlm3GdJptAcK8mmRcIFbupxaoOvxsaCdH1xBlKwAjWzNv
 0LEqg19qhBqtZKDu2xf0uTi1/Ys2ZKYQRw7EmH7YYHAWmhzoxhg+TnMZLpN61F1nEvCQ
 TOOEjS+QGqndVvwFaZ21wvG+cA70L7H7zHc6OdjVD4vTDOyZ31mo4l2mEZMtf8nq7Ep6
 flnbcBwBh9ScZ9a8AKGvLZCOD3wD9GdnIYuqzUb8AmukKwxyOa3clwVQV7uGaHPZuxrN
 j0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462120; x=1760066920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/j5ZjJ/h+K0VX8BTh5DpvAOuwcrZHBQw+WvgJDBarMg=;
 b=r1p99YIahNXgL4VbCcupPBVzkSpChv4BSBYdvP/AxwFz21bjRlz7xf9WI5tDjyjIwc
 KZAnQA0Fe6peNXXRcKxb5I63P69zflQayM/Ig0VGtJAYspC0GeAdPAhSsK7DBSqudojg
 gjrEvLtHYFF6+Gxryy/vT4XCmljhf9IRpGx3xNMxAwC5q5JJyhpS4rGfHz3EsFBukN20
 PQ8rB2lpBk1nGty7tMz4cVjnnwicWkzZVtBGUarQ83gBghK413IubPMx8iiuj0sxwKAH
 BhhX9du+Dy2h7nIVmrbeAxhPrPtj9/tRQl2nCg1o62ZrDANxuXIb2Rben4bOTKjObjSk
 hi6w==
X-Gm-Message-State: AOJu0YzW3gF0klJdWahq7Er8W1YXaZAqDputgx+8eHLtijW0nOXIHWrV
 o6Rs9g5EujIVd/G8rNO6NpL1Ta+HWzZVe8D+Zr4sOmB+Hyx9AoqFM3Ep3I1+WA==
X-Gm-Gg: ASbGnctvWbmxuplYuCvSqbol8oDXTTd+JDz7H8QWbGhfjVJbnFtkrXyR9mbrtbmatEO
 Mma2oMTtxE5fxm6ONvWRmq2K/qcU07KdSIFk4mhBm5VuDhWgbRgItDMg3U0MtkbPwaToky2nGWK
 g/h3tXzmXSY+zQM+t7xSeyQJ19E7JTbCHOb7PrxJD/CjdXIH3vufmS897cRz9KWEAqtc0/ePtfo
 Urt2uQ5XcKYy+QzDfkpirX2HWBbR1GuBjsiw5ivIQ9jFUJ9deIRByNaaZ7z2xCCkOkq84wIoobV
 rGYDJ9ywx/Pl2jHwtKSoQhTgSbquIr2cZ9RiLaCqY7QetdZ5XJ0oW/M9IXtcPXynbi7IzO+c0vo
 1VBNKGZ4hb+aeffrckzeKKtl6X9xx677UyEPWsHjqjFHRD72TCji7e9JbdCtliR2EPGmkBEgXAp
 IMjUQ0ZTrGyJ5/zZ86rCF4bRtFnuLnCu4R6UkjyL6A2EHb4/s64/w0
X-Google-Smtp-Source: AGHT+IGlXf4ib8cKw/M7d0yWWgwJWmOhsXJw5U6YMKIhrTwEtMyLsgFgscmIO+ClyvgSnx/uiAo8kQ==
X-Received: by 2002:a05:6a20:2584:b0:2ff:3752:8377 with SMTP id
 adf61e73a8af0-32b6212c522mr2158552637.59.1759462120489; 
 Thu, 02 Oct 2025 20:28:40 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:39 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/26] target/riscv: Fix SSP CSR error handling in VU/VS mode
Date: Fri,  3 Oct 2025 13:27:11 +1000
Message-ID: <20251003032718.1324734-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
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

From: Jim Shu <jim.shu@sifive.com>

In VU/VS mode, accessing $ssp CSR will trigger the virtual instruction
exception instead of illegal instruction exception if SSE is disabled
via xenvcfg CSRs.

This is from RISC-V CFI v1.0 spec ch2.2.4. Shadow Stack Pointer

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250924074818.230010-3-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 3c8989f522..ea36eccb3d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -203,6 +203,8 @@ static RISCVException cfi_ss(CPURISCVState *env, int csrno)
 #if !defined(CONFIG_USER_ONLY)
         if (env->debugger) {
             return RISCV_EXCP_NONE;
+        } else if (env->virt_enabled) {
+            return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
         }
 #endif
         return RISCV_EXCP_ILLEGAL_INST;
-- 
2.51.0



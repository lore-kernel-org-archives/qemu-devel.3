Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9741FC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBy0-00052d-TI; Fri, 01 Mar 2024 18:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxm-0004uF-Mx
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:47 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxl-0004FT-5m
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:46 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dca160163dso26426515ad.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334403; x=1709939203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riDxx/Iexj1qjgzxqR/EG3iYXorkzbFxBXBzbTLKvNo=;
 b=BdO5C0haalHKNv/F7gqAVDaA6VZeSDZh76aRZwYlqJadY1cZ6IVUsxXKZPhe+Nd+sy
 xdUDcDEdGv1JVqGuLjBlnxxzJtXQfa7NColVor0vVIFMxVXaADMl+2FMZWOu8C86yaJ0
 zRXPzk6JOIbIlFtghb13U4lOp6/p47Uaw+VBCSEKrhVQGC3py5kroWDumkrs2SdRcV5E
 CUCXZda7v8zrQzZ6bGkOHwXmnNNAE5CXNSpMX4iXWm65Xot6o8BCx6s1yrXBXyUhozv1
 bnsp59ELatjX3gHrsVqx2ThdYjPofgtqi/Tn0Vye4TJbmPqDBydM+Z2mv0HORuaa1Arq
 QtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334403; x=1709939203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=riDxx/Iexj1qjgzxqR/EG3iYXorkzbFxBXBzbTLKvNo=;
 b=ciVnJpwkwwvXQI1+Y5SF2FaNcDTDBPi0mcHrT9FBDjPITfBlN56Ztw8cssDr9Ftfff
 y5KNhFS6oUBYiqXsX6YHioCC7i3RUCkr+0l1tq7VICd6K2zD2cYFCt/TJ3NOltEXEqNE
 bp1ClOEtckWHoipRAW/YhyiHrHFQ26h16eDNTinfg69f90dBumCgEduYWaElKd3KNUG2
 MtIg8XDjBJiLdZap/y57D/1lAiND0Gv34znFCQS1qIpgMyiaZi8SloSxFZRnBOwUnFZb
 ue6rvbZx6cbnxXAD0BuycUcOOGPX3CmyBdCMKzr0LANj5eMqxEaFjWClBRWDTSIbyyUY
 jKYw==
X-Gm-Message-State: AOJu0YwDZ3W07SCTfYBf9v61SmD2aEByHQp6PSQ59Vvq4HQ6+sGICFem
 lftb9BPrwFPL33lOaFdQLHb8hZH/DD13bCoyeaMn2v46F99eQaAj2mfEEtgc66hCjj6ORmHEtYA
 E
X-Google-Smtp-Source: AGHT+IH5lFGVV7AQ3RAvNX/I4K2YM6bkiLUUD+eJ/5lWsZpRJD1KUMnPXocx0J0CH0slrpfG0sofew==
X-Received: by 2002:a17:903:2985:b0:1db:d586:b2d with SMTP id
 lm5-20020a170903298500b001dbd5860b2dmr3783082plb.18.1709334403273; 
 Fri, 01 Mar 2024 15:06:43 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 16/60] accel/tcg: Set can_do_io at at start of lookup_tb_ptr
 helper
Date: Fri,  1 Mar 2024 13:05:35 -1000
Message-Id: <20240301230619.661008-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

If a page table is in IO memory and lookup_tb_ptr probes
the TLB it can result in a page table walk for the instruction
fetch.  If this hits IO memory and io_prepare falsely assumes
it needs to do a TLB recompile.

Avoid that by setting can_do_io at the start of lookup_tb_ptr.

Link: https://lore.kernel.org/qemu-devel/CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com/#t

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240219173153.12114-2-Jonathan.Cameron@huawei.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 977576ca14..52239a441f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -396,6 +396,14 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     uint64_t cs_base;
     uint32_t flags, cflags;
 
+    /*
+     * By definition we've just finished a TB, so I/O is OK.
+     * Avoid the possibility of calling cpu_io_recompile() if
+     * a page table walk triggered by tb_lookup() calling
+     * probe_access_internal() happens to touch an MMIO device.
+     * The next TB, if we chain to it, will clear the flag again.
+     */
+    cpu->neg.can_do_io = true;
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
 
     cflags = curr_cflags(cpu);
-- 
2.34.1



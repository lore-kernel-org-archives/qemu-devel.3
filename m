Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABEBC25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xca-0002u2-Mt; Mon, 06 May 2024 08:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xcJ-00022Z-Lw
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xc9-00022v-P2
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:51 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41b21ed19f5so12254555e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999119; x=1715603919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLt7aSiKdJSjR9IsbCYiGtAu0ptRlqr/9IF1r+scoR0=;
 b=Nx723U75kLSvie/QkmlkkjVVoOPQUFmsPm41nEbyn1lqj2SjlZdIUNMK5SDVLjmENg
 GWag2BUr7ZYcrbFaAS/Uhdx13VHR3JULs7NDc5MmYLiHkaOP/lb+aBDVi72dTdMo2Yql
 fpZQHFWhFxWkr3qJZFHn4FqJqqlpNcmlQ1upcV9K2V4BAmS2hnrb3YM+Jy/ZN7wYZwo9
 bT1cx7ZvbSxAkPcpvE5L7pnUkVFKjPrnFZMGS89diRpBs65U2M8t4ULc3rkItNRzxC7x
 uAukOs0ew6sr8Va7lTPJYWFLt327+LZ1kHMVx5Z2ZmQ9pwITuOCuTITlw2CqeVenJ28Y
 GT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999119; x=1715603919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLt7aSiKdJSjR9IsbCYiGtAu0ptRlqr/9IF1r+scoR0=;
 b=rIqMBQEDibugAJR1SiNrdDBpbXWsIO54NEPuhlPovpWc3WBtvpwlthF11v+N4oklDc
 LJ0DtY8JxkajTt3w2EAFC1cEhRjRnVEBz4MQpciHdjXYvH0McK3TkMc0zNueRsW2wbYA
 +rlDQLEfgLGez+0nc+Uv7JkS2O79D1B0hSzLuA4B+KPv3fajP58tCDK21ssLzWdY0cZA
 5XkdVzynhZFtctWkX9JTm9qTBSQD0xuniQlf3HE/ZemMkRSxUATGzjibHQCpQCpZLTjb
 KvGV/l5rKSD6d5BkxcLTyO7G3cuCsMfNganWGagwmRbyvMCUb/fz0thmtToFHqBgcGUt
 etmg==
X-Gm-Message-State: AOJu0YwISwC2rMNFCbT9LW3o6F49IIpYEsPZrB6CerojgGg65KLPo6qi
 PablkJNQZZkuP3qMUMvuRrR/q11Or6VI7eu3PVSyNUR9XIxB+bQ4xpI2FfTHDNuDrIBx08Hv5s9
 4
X-Google-Smtp-Source: AGHT+IGSQFEGe2NT87A1x6OPr1eG1WF08b3rU9ZPlntATHxFd1HdmNJht3PbTHL/QE+nS1lM9wYNYA==
X-Received: by 2002:a05:600c:4ed2:b0:41b:f30a:41f1 with SMTP id
 g18-20020a05600c4ed200b0041bf30a41f1mr8222863wmq.7.1714999119594; 
 Mon, 06 May 2024 05:38:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 fl25-20020a05600c0b9900b0041e9c1d6f4esm6712931wmb.48.2024.05.06.05.38.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:38:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/28] accel/tcg: Update CPUNegativeOffsetState::can_do_io
 field documentation
Date: Mon,  6 May 2024 14:37:09 +0200
Message-ID: <20240506123728.65278-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The @can_do_io field got moved from CPUState to
CPUNegativeOffsetState in commit 464dacf609 ("accel/tcg:
Move can_do_io to CPUNegativeOffsetState").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-14-philmd@linaro.org>
---
 include/hw/core/cpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 46b99a7ea5..173349b0bd 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -338,9 +338,10 @@ typedef union IcountDecr {
     } u16;
 } IcountDecr;
 
-/*
- * Elements of CPUState most efficiently accessed from CPUArchState,
- * via small negative offsets.
+/**
+ * CPUNegativeOffsetState: Elements of CPUState most efficiently accessed
+ *                         from CPUArchState, via small negative offsets.
+ * @can_do_io: True if memory-mapped IO is allowed.
  */
 typedef struct CPUNegativeOffsetState {
     CPUTLB tlb;
@@ -400,7 +401,6 @@ struct qemu_work_item;
  * @crash_occurred: Indicates the OS reported a crash (panic) for this CPU
  * @singlestep_enabled: Flags for single-stepping.
  * @icount_extra: Instructions until next timer event.
- * @neg.can_do_io: True if memory-mapped IO is allowed.
  * @cpu_ases: Pointer to array of CPUAddressSpaces (which define the
  *            AddressSpaces this CPU has)
  * @num_ases: number of CPUAddressSpaces in @cpu_ases
-- 
2.41.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAAAC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Coj-00085r-9m; Sun, 28 Apr 2024 18:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CoY-0007r2-TS
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:07 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CoX-0005er-7V
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:06 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56e37503115so3952395a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342563; x=1714947363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMrSi6a9YnmKRxRGwae1/x8KkxNfv7crj6dkQDrCI20=;
 b=pTRk8nm6qeMSzBaTgfaEUxgPkHoySIiAGJ9INtt4Uw7g+QL/PlE5s1AwG3RbRiK30K
 J5uUM8lu2gI8HORSy7+xBRVcVPyhlS62x1xsaUobfjlBq+F54PxrukuDIxj+tPEttql8
 4ZkB5jxPW0AMA3gJeh9TRf0t62FEzFacYbXDXjZU6akrHRqOKSYb7G6G6loOGR6HNBUi
 1VN270hTkyV3nn61c+xAwEwNIQKOTHSYr0pIuiJdbLneyZ2fjaWG4lr9O7JtQx7VorAP
 AH3A+2P9dmGEV1kYjb0ex71JdmVMfJjuyDZoez53hp7RRaFgNmGRypi6cY1UDfMPRcnj
 T6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342563; x=1714947363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wMrSi6a9YnmKRxRGwae1/x8KkxNfv7crj6dkQDrCI20=;
 b=NyXrd1I6IHcZvfZAW8/XnTDXSNyVz8otySLn9r5zalt9bclr0HELCZrePZoOIh/Ngw
 prqPEHnLQBxxuqk+q4M9g02zlXg+uRbDbS0Yu5jiMbm1vf0pfURX3nTe14M3Szo65al/
 xmAZoZ46y1mjYVzZVcQ1q001nuAxCEOan61XjaJi8G/TmIwiZyMRt5b15TojMTOnI/Hs
 3Ht80nk9UpNdFkfCnkIksmxeDr8pWs4GHNL0kSlDdvzoL9I/L0UwFcqnKYfLR+5XX56P
 miLjLZ58lsIaJIAtbK1NZQzn6oWNJ/Dwbi5YDkhcYuMS9wluF1XLqDwVYG/cgQU+g0W4
 782A==
X-Gm-Message-State: AOJu0Yw3fNj/NpACU7dpTeWuLntRfaPQiSsYoxWTRuswbNLVfT0tlSJh
 HKYopoGS7YDLfdJ3AJdNhjycbatYA/HdEdEuOJYDHNr1aPsuL4FrMQ755nnieZ1gtKrxCCngZDw
 7
X-Google-Smtp-Source: AGHT+IEwWGc4kKTcFpy0caUeRzDluw440AX7zuTRSBzyuzAGj62TeC5DmbbM3LKV+4mKic0rO1fFgg==
X-Received: by 2002:a17:906:11d2:b0:a58:e789:8eb7 with SMTP id
 o18-20020a17090611d200b00a58e7898eb7mr2697411eja.74.1714342563336; 
 Sun, 28 Apr 2024 15:16:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 bb6-20020a1709070a0600b00a55b020a821sm9253199ejc.13.2024.04.28.15.16.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:16:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/24] accel/tcg: Update CPUNegativeOffsetState::can_do_io
 field documentation
Date: Mon, 29 Apr 2024 00:14:39 +0200
Message-ID: <20240428221450.26460-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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
---
 include/hw/core/cpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 9b99d8e8fe..beb37342e9 100644
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



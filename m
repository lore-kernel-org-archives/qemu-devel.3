Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FB8C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lH6-0006NU-PQ; Wed, 23 Apr 2025 21:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFS-0002kA-At
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:32 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFP-00079i-V8
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:29 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736a72220edso432243b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457565; x=1746062365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lN8U4pCvani3EVxhH+Cp85aPQAK2No9bOUG5l7LfXn8=;
 b=bHeTss/SfJBByix4nrUnbHqSMbOb1RTIk7Ecfw1H1zoY3sAJgjMVmYF3/Nj/XAZ5NO
 vP2gxpVdCt1h1Mbc5+OVk+5iMTy4bUR/uGhT6OqCadz4KOABswgHf3MVZK/QrIRm35La
 evwkEtMkPdwa7GezG8rLQEwmKUilyIkuWpXKQ6GRnQijSbCXqPCc4oQorb9IL5h8CReX
 SHgbYaN8m/rH2I3K3AmgJ4sB9DLsXoA/Lzd8CIG4t6IISxuPxgcx67yNa18B12Ibw9zi
 RyzZK3gFnurzZeAbdBQrigKhSjL7wUglzH9pcqP7PR1bxdart2GskveMyqotjVdNfpYl
 WRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457565; x=1746062365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lN8U4pCvani3EVxhH+Cp85aPQAK2No9bOUG5l7LfXn8=;
 b=GVTdOF0f4iiLpEC2hiOhPK3zH2CJkq7gxcYJ3kAyp34A6JLAV/72LY0x2PTBh2/ex1
 qTFAZxuZt9Pm01pnay79wRWmm63X6NMquxjqa4rLAjRHgbAUK9Gz82pD33AX69fUWCDZ
 0fqfGzde/sce40f6jwAUW43kiQF0HiLyCqaPROgl5+kaygRyL4lrwqzM3bYGTRDwJEdy
 OFwANJpS1/xsC3jhZobJxXHSca2MGWpLZZ++8NOz2IvCpOwNN+mxcT/TVM+HgyoR5fu1
 72ErNhy36Fs/9wAfq2wVdeu9+4ofYqhU89BIMttugLVjK1NitflEs1DwAlHINzW+ocsb
 ph9w==
X-Gm-Message-State: AOJu0YywIx5btksfm+jpIlpWjI5cX4WQmCTY+0S6MUzuBAO1Sn+nsAwq
 ZP6sCUwSFRTSnL6aOaoIuCoOkxvV58NtbRswe3Sy/7PcJVuo9bl+4Oxvc9vy64rjRZeUBYhUTWE
 s
X-Gm-Gg: ASbGncv39ktSRv15Ce8UqMv3CZ7Uwp8SxcbHGY/Cumz0k3tFdQ3shvSOeYmE2OufqVn
 gOA/jiG2XmVpXMMFkn3XCLKTGEaMCyWV/TxzDYRiXA4n/+bXQdc4+uabktmBpRrt1A5ziHnPpZu
 3oiE999YTH6rPa4sgHHsj/Fy7ACTp83PVknibxWeRCNbj86p00h57pjHOKw9PquAUfjkCm4oB+j
 Ys7ELMK7Cd77+klFP/j+g7EX99H9+fTFYQewKgdtj/kmOHZW90MbJwqZaob7rHIag/1NXP1OhuO
 rUOWccwjURNwzHR6RyWoDLCvOp0Vfpi8cHtmnSPHvyAw1y0vAr+sRSqRAGrjaaGOWw5V1COJ/Uk
 =
X-Google-Smtp-Source: AGHT+IFWZjr2rSRh3faFqc8z/jLEjTjptxTwUWnR16rA+g+PIxWdy97x6nRpAejvfXAQlnGDDmXLCg==
X-Received: by 2002:a05:6a21:181a:b0:1f5:9cb2:28a2 with SMTP id
 adf61e73a8af0-20444ebe192mr921198637.19.1745457565253; 
 Wed, 23 Apr 2025 18:19:25 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/15] accel/tcg: Simplify L1_MAP_ADDR_SPACE_BITS
Date: Wed, 23 Apr 2025 18:19:12 -0700
Message-ID: <20250424011918.599958-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424011918.599958-1-richard.henderson@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Stop taking TARGET_PHYS_ADDR_SPACE_BITS into account.
Simply allow the entire ram_addr_t space.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-maint.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 581d06ebf3..f43f5342a6 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -160,11 +160,7 @@ static PageForEachNext foreach_tb_next(PageForEachNext tb,
 /*
  * In system mode we want L1_MAP to be based on ram offsets.
  */
-#if HOST_LONG_BITS < TARGET_PHYS_ADDR_SPACE_BITS
-# define L1_MAP_ADDR_SPACE_BITS  HOST_LONG_BITS
-#else
-# define L1_MAP_ADDR_SPACE_BITS  TARGET_PHYS_ADDR_SPACE_BITS
-#endif
+#define L1_MAP_ADDR_SPACE_BITS  HOST_LONG_BITS
 
 /* Size of the L2 (and L3, etc) page tables.  */
 #define V_L2_BITS 10
-- 
2.43.0



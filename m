Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E446C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pq-0002yp-PR; Mon, 17 Feb 2025 14:31:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6pA-0001zM-Qc
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:44 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p6-0008R5-CN
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:36 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-221206dbd7eso26589065ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820630; x=1740425430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZoiLt3pf8hgXu53AUbpJI+JmE6qkg40H4RF3hXdm60A=;
 b=r6Qn65mCal8xE383Ihe+VFdEu/bYDCXXiY56rCmWjSqYest3ZGD2irU2NNkfsMgZe2
 uI7YXiOvM014ZMSnB7HWzgJ/RJy3xzqucoc3Nmez2TTOfjCXnsrr2xYPA0YmwZSNOZrq
 pyiK4jif37KRWF16ZXAaeKdWUe22HKKAmBZ3LHrFqUUQvnkzaAjypNTUoCd10Nx2NKQw
 HoNxS1gFRG2MzmWjkyvSMiGl3l4fOqVryNGi4cSeLlJR+uwHAN3rk4vdma3705PA4jHe
 RjRrSzTCkAe7bY2a4JAoSiqtv/1vYW3PnbzJnHlPtgCtX0nkDDjQ6OZD/IOr5hNRC5ES
 On6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820630; x=1740425430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZoiLt3pf8hgXu53AUbpJI+JmE6qkg40H4RF3hXdm60A=;
 b=nwvq4pfXZxE2RPOWvfXTSv1ZGOG27lHujker6iAfogVTX0dyweufsioZen33l1mWsm
 EkGDN6SnlVpshbd2GX9ldUPKFdcEDGHEvB1QhhwjQTMIqXBcHUOzqIo86yN/Ig5KrF6y
 BY3D+p5eLG71/AaN6eAkC5gGReZxKl4VXFmRKJKOj6hFBUQeyvksfwh+5ByKlRKeoRtT
 BtfeObZMx1q6fT2qZ9ch9TKoPSnkeCUAxHFqsSg+SspSYKPrw6bM9U06ApevwUrZOWXe
 rai4n6G3DXRQaMA3MdryjllpYIKLz6jsC4zFsiT5kwtiDy/3J+w5Kr8rXUc4VUWcNn+y
 H1Og==
X-Gm-Message-State: AOJu0YzAH2NF8cEPCOd824y43whf412A4XT5Rg7lb1eGULIyzvLUA+vU
 QHBTHjpsHgwqpBdC4lobXoaO2j/X+Il6go5BcCiuk0SmEvgjl+ViFltLSG8ytYSdIBwLTtflFGx
 w
X-Gm-Gg: ASbGncuOunLNRu2hxIq98PAORaxco5kHEPFBvwwjIIfyfYrSOCuFQtGkPQV1fjSVTPP
 UdgOuYEx/Lw+GBpE+S4moYZO9uRPTC1n9dOmxla7fq0QsOnayIVnFkvVUcuRZUop52lus1XDmOB
 WjcWP5hSFrZGofxuHPu014+iKkSzmGuQ+h9eTRvC4OFCjzsB/WPoG7Ttk/klncFqLVUkbYQhqDX
 CnIC/3LW4zg+pMbHEiyI4GJv7SVxf0YyL+XYlpN35XUJ0VH/uNLaNQM55HxRjDBtvfIt+dh2caa
 sfLVmoJ4enXvvmrCgzSSn5I8Ab+d87QRdQxsBXaQnulP00E=
X-Google-Smtp-Source: AGHT+IHIawPzs9+cqCzHj2zDg7TipA5DNpduJdML6R3d7m9168qKfxZ4toug6a5JfFQZVjm1q5QQEQ==
X-Received: by 2002:a05:6a00:2d9d:b0:730:f1b7:9bc4 with SMTP id
 d2e1a72fcca58-73261779914mr17984780b3a.4.1739820630568; 
 Mon, 17 Feb 2025 11:30:30 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mikael Szreder <git@miszr.win>,
	qemu-stable@nongnu.org
Subject: [PULL v2 24/27] target/sparc: Fix gdbstub incorrectly handling
 registers f32-f62
Date: Mon, 17 Feb 2025 11:30:05 -0800
Message-ID: <20250217193009.2873875-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mikael Szreder <git@miszr.win>

The gdbstub implementation for the Sparc architecture would
incorrectly calculate the the floating point register offset.
This resulted in, for example, registers f32 and f34 to point to
the same value.

The issue was caused by the confusion between even register numbers
and even register indexes. For example, the register index of f32 is 64
and f34 is 65.

Cc: qemu-stable@nongnu.org
Fixes: 30038fd81808 ("target-sparc: Change fpr representation to doubles.")
Signed-off-by: Mikael Szreder <git@miszr.win>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250214070343.11501-1-git@miszr.win>
---
 target/sparc/gdbstub.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index ec0036e9ef..134617fb23 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -79,8 +79,13 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         }
     }
     if (n < 80) {
-        /* f32-f62 (double width, even numbers only) */
-        return gdb_get_reg64(mem_buf, env->fpr[(n - 32) / 2].ll);
+        /* f32-f62 (16 double width registers, even register numbers only)
+         * n == 64: f32 : env->fpr[16]
+         * n == 65: f34 : env->fpr[17]
+         * etc...
+         * n == 79: f62 : env->fpr[31]
+         */
+        return gdb_get_reg64(mem_buf, env->fpr[(n - 64) + 16].ll);
     }
     switch (n) {
     case 80:
@@ -173,8 +178,13 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         }
         return 4;
     } else if (n < 80) {
-        /* f32-f62 (double width, even numbers only) */
-        env->fpr[(n - 32) / 2].ll = tmp;
+        /* f32-f62 (16 double width registers, even register numbers only)
+         * n == 64: f32 : env->fpr[16]
+         * n == 65: f34 : env->fpr[17]
+         * etc...
+         * n == 79: f62 : env->fpr[31]
+         */
+        env->fpr[(n - 64) + 16].ll = tmp;
     } else {
         switch (n) {
         case 80:
-- 
2.43.0



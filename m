Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EB1C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QA5-0005LV-U1; Fri, 18 Sep 2026 00:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA4-0005L6-P6
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:20 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA3-0004A5-4b
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:20 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7ff1e4ffb3aso141857a34.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705517; x=1790310317;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nK+zq+ryjrcPOcXasHwk3XYykW78/KjaOh+VoOvp9B8=;
 b=gBELFTi1+9qdmDIM7OLSVMyi/R29lU2Z6keLF3WU7aM2ycYnyW5jKvBtgxOhTh8ojO
 oD94swTq5jySKIg3lTpxY+VVZaL9d6ALUqo87DSGt0+RxQMfd0fpljcLvVbX0z0ZyCYN
 v7Sw1kidOktZOsFWSjCblq57ZaKONE0juGu+TiC+CXTQPG+1IMma9AYhpJ5+ze4bcugd
 zp5hQCJL82IFqxuwUmuTkxmXC4MQtCdpPSZDoFTkY+935RgIH9YylpRO5Vm81hN/laVm
 yFrusr34OPqCqGgtRXnaBQ4c5M0YIRgHOkhSauLWvp97a6wfG9xIJzadUBZGkpuoBYe/
 nG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705517; x=1790310317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nK+zq+ryjrcPOcXasHwk3XYykW78/KjaOh+VoOvp9B8=;
 b=SRz3NegQKHtj1aEnmwNl/UufFHL8c0rtdmf+PakSZ0iaO+avurLJkGIvDftj9c84mV
 b+Awc0f2K/wXoTqefhzPuvLEHZsXzCHz+ycou/fV+fCnAnC/3qVqnPIhAAE8mzOb1CTM
 x85NykAmE8tZwK5bD467p92Sxa73DUg4ITErCcg/rzoXvWOcB8g92vwdpBoq86X9mjwU
 kAmZXk8HTKY/TV1+09CHLSu7Yu87hRWStTbi6J5Qvk9R9165ojnfEzEFLdurCOSnTEKe
 N7+e23neCUD51lPsPTowwTc53UBs2wy1wEJdKxu+cvuUP4h4XaTnmpOVQZIamdWTsCqo
 US6A==
X-Gm-Message-State: AFuF++l4cxO0Y+c542ZC7wJoKEQFbcxFy4k//S2Vs4hTSa7Pop17qbrc
 yRB06Fd8ftq1bw8ZUQOXoxjGm1o7yWfcARdT+LMAumsKnCmCeE6kUJBbEX/UczYVxNDdGLwXSiM
 /K7ZOMgQ=
X-Gm-Gg: AYBFou0GF9kUNKdLDfAEAVIMkvH4FbtN6NX5BLScSmA+Qzr4o9Q82tAYQc9tT+M/xHQ
 c7W8bO6Me15pLtDZQPwe3/zHwMuGaKJPv40gIj+SaPbuDyp1P7yNFg/W6oT2bQdDbvHcPsHPc3M
 Af/oww4yR2xH9Wffb8tNmROnQTRNM46PFOcOEMD+uyCv6Yf4wOyw1X1Yior2q3B8MmU443gGQ2j
 n+LItMICkVxYjqAmhM3BZ2AVe0V4mhO6HOhEgOURjAZInjjaPsIDDXxRupLx0SQjSjagL3pg3Jn
 XkMjOXfGBc2ykFlt8wDA5dGREMn02EdUiENC74//qwnifqQbITUyxaObby6FFfLA4rnKoGdntEf
 5h0rfGNfvCenP+jQS3wzFNwl+OvXs3cdlnyDl6P+JJgK6qbLpnyYdZTK1vp8iBBChggT4qRlOnB
 x1mRlbjpLJtOewZqtall+TrIaJe2po7uZbAPcbSGJoZDKtWITNHGEA24yXSQ==
X-Received: by 2002:a05:6830:6687:b0:7fa:ac4f:77d with SMTP id
 46e09a7af769-80de2ee7b92mr1610853a34.28.1789705517585; 
 Thu, 17 Sep 2026 21:25:17 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:17 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/41] bsd-user: Remove mmap defines
Date: Thu, 17 Sep 2026 22:23:49 -0600
Message-ID: <20260918042422.38713-9-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These defines are not used, remove them. They aren't in blitz anymore.
A future commit will cleanup several mmap issues, not least the obvious
mismatch in the flags here.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 7e70d6ad57..7646a52744 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -121,20 +121,6 @@ struct target_msgbuf {
 /*
  *  sys/mman.h
  */
-#define TARGET_MADV_DONTNEED            4       /* dont need these pages */
-
-#define TARGET_FREEBSD_MAP_RESERVED0080 0x0080  /* previously misimplemented */
-                                                /* MAP_INHERIT */
-#define TARGET_FREEBSD_MAP_RESERVED0100 0x0100  /* previously unimplemented */
-                                                /* MAP_NOEXTEND */
-#define TARGET_FREEBSD_MAP_STACK        0x0400  /* region grows down, like a */
-                                                /* stack */
-#define TARGET_FREEBSD_MAP_NOSYNC       0x0800  /* page to but do not sync */
-                                                /* underlying file */
-
-#define TARGET_FREEBSD_MAP_FLAGMASK     0x1ff7
-
-/* XXX */
 #define TARGET_BSD_MAP_FLAGMASK         0x3ff7
 
 /*
-- 
2.55.0



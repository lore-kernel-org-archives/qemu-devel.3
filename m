Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D01C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGUo-0006Jc-RK; Fri, 21 Aug 2026 00:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUS-00066E-57
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:24 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUQ-0003Dl-Et
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:23 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso498060a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285061; x=1787889861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l5FefkHt4+mIAwzFGxwVE4fW9WR3b86gApc4aXRCX/Q=;
 b=wSmtlPo7Y553S78PRnPNI9Cg6g/VCrLZK2reD7jzrLfgNFmv9Kc35bPDPi5W7r2xrx
 3wFR1qDcjNrva5ROdQBElUIMCCgomHPZFTizTsxBeaLYAdKGE5sKV3GSrGB27Gah8jM5
 cjw9EPXcXMH8souX+CHGURp1dSTe3vlKQG6onvZOgEF2gOAkRw566Yfxzf9CpAZ7ZXfI
 nYs1uOSSgL630vfVEcwZ6eJ9LluIQY/DQ13PdBGJvzFgSZ1lQbzBRPOOP530oVDUh7CR
 mWqiny4qHh/W7WfaByvD0fMsPBqvLNBInksVFH4RshoYjrYN11FPx5pN26TyMXuzFF/W
 EhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285061; x=1787889861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l5FefkHt4+mIAwzFGxwVE4fW9WR3b86gApc4aXRCX/Q=;
 b=pCw19PtM8okhz2l4hiwCn3ez5R0xJzBgqCfuttHJkouEetzr9v7lmlPrJtkNP3CjmO
 OY5SFfy5D0VlIqeaF0/8CvTbWq0LddP09vqnioyEtwtaBeIK2mrRAyj9RBuZDpaLwABt
 B31Fyn4rpNnjnfmGUbvbailn1dTMxHvIOcw6fjUeMjUWRzgkK01GdARLRaKAfQsBvurY
 WIJgwaeF0t+N0xUBcNXHVqJisMx9p/ItMNQ4Erv67V5mtI0lFMQjkIoXkRHeKAR3YdKr
 QqVaQR8/SN3mClYcQnWi6tovubMb1HgQHKya6cw/l5DN5m13A2zkTBUofV8N4uvq8TiF
 3QuA==
X-Gm-Message-State: AFuF++l37BQZb5rjPUVYQ4L+cj9VHQ/W5aK2hCrRjIi5QzpGDTkEMd4S
 jeQ5snfLdKtonDvzwCNGmfuz/hDKyZL52p0wbW/wbAN1+UzaMta/xaAlbqXmmgmnWlw4o7MKAIs
 pAOCa
X-Gm-Gg: AR+sD113QorCqh1TDeT+gmwkfIQ8IDJ7otMilCm6KfqDbSwemJkLjTh6Vj5ksBAjWeP
 U8oyjoyAvZ9xuFtE9vBp6Uv+9AZXp71QC9Dsdiga3izlOp6jtmLJPOOa8zeTBhwSRpJLCRrNP/+
 pYy5/uHyJZ8twgHNCIS5HStsBg3fprOqAInoNCJ1eqaSOZJIyS0DEQ+Z9ncLz1bbjQqbEITHKrj
 FN4MdT0qGxEDnOLckCdsr9yDMwW4vjWZEucAr0WPZ3oMEWt4nj9wY2Q3qVvqXVUMTVQ/2XqxNkZ
 cQ518vI58FyfsMTILgAOu5VvtzTYUzk0NDmpNAxZldkTP7c8jLFImGwlYPtIQ00RBbkmolevSG+
 gpNt8l/UTu50EZJpq7Dder46NQQiJRsLsfqAouejdjuRpkfuiIuYB1FcZkPmKOswx+rLZeddrEr
 fFypPLexuDsiUfBpZ8zWi6PpXCoiB2kn2AWqIi4HPlyOlxaof6u8AJjyjjEQF/7aXaTaA=
X-Received: by 2002:a17:90a:da8c:b0:381:a766:efcc with SMTP id
 98e67ed59e1d1-395c3865a2emr6346970a91.14.1787285061064; 
 Thu, 20 Aug 2026 21:04:21 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 13/23] target/riscv: Remove unused VDATA,WD
Date: Thu, 20 Aug 2026 21:03:54 -0700
Message-ID: <20260821040404.268123-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/internals.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 5d84e4de96..9e4da39ea0 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -94,7 +94,6 @@ FIELD(VDATA, VTA, 4, 1)
 FIELD(VDATA, VTA_ALL_1S, 5, 1)
 FIELD(VDATA, VMA, 6, 1)
 FIELD(VDATA, NF, 7, 4)
-FIELD(VDATA, WD, 7, 1)
 
 /* float point classify helpers */
 target_ulong fclass_h_bf16(uint64_t frs1);
-- 
2.43.0



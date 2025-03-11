Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1A1C35FF1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 04:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqy0-0005pJ-2Y; Tue, 11 Mar 2025 00:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvg-0003R0-LM
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:23 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqva-0006Xh-A4
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:19 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224019ad9edso113005515ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 21:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741666153; x=1742270953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEAQ9wvxViIwfRRF7MZBxVkXSE0tKicEinIFunB945A=;
 b=jStkEORuEiUx7wAf2U+aA1KCiAkV6cwUHHiOrEnRDmgGKSVJb2UZe1Fg9DPyRsDI/a
 jKDVa79CAjEfLG8XxrD+bQHfeCVeh11s9p5upgfLfagSNBVyKwawk/9o7Zy/CLZ/Xkoh
 vbAQjlHuOJUI+sqLN+whnkzlx0/nYeBDKtwI1TT/twzJpDKqo6vwW4ykI74SAYHdc2K1
 iNlKWfFRLynnOtOmaIBksiDrWrF3kIWVgQH6GOHCrDp6Cbs+8DZp1GIpXytPoqARRcpb
 zK86xkeTlXZJEd8S7gAaXIeGcnSbHd3cgOaPCL6eocpPJF6NxOJJrR/BqqXiq7nkC6ua
 QtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741666153; x=1742270953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LEAQ9wvxViIwfRRF7MZBxVkXSE0tKicEinIFunB945A=;
 b=Y6k8IwuH3pyhLO1O722xJFBco7QS0eAieJoshENzUaR8rsb5uWr4Ks23XRDlg6c/ow
 RgqKXLRKKpOLv1JHhV7rvlyswojEWSoJ7bnKdTRFabiAYlUiGT2VgzjRlWQCZDwnnf6P
 uhUgJt6uSgWrZlpynWwtPeEhEUv5DgZSjA83ziCCBNYH8aa5kakTb7bEFLeqjvQl2EIm
 PMJ3V8NbvOqos7nJdekwCJOr4EdOIUub3yOLwM5h35yNvmIB34aXkDpxYMVZAqWQJfuu
 hqVNmmoNCvpr2jxvttYVpau0D8Ax4JsgKZstGz3MCU2hzCtBwVaytSbDFQG7VfXAGrBy
 IgeA==
X-Gm-Message-State: AOJu0Yy8MXt/9JS4xmY9MPLYcbomL5eHRg8Kk/b6DJ7X1jrSx+guyvnA
 RFrrclEKBwjtop36D2V49kJ41NRX+J1X58ithaCKguaATrIgQLXnEF9CZq11OPEPqH4aAVSVfBn
 KwD0=
X-Gm-Gg: ASbGncu/zrn9zmuDIL6ropdGMR4dJzhPIOFUWp3HAj2zCvIOJ7/r+6N9TK3idsFbqqw
 5ESCsaQoEbZJyUxRuFnIpF+RRC0tVTLR5kzDfU6hLR8QKLNSIbZW9yQPWimQ0O1FV5u56mLut4L
 pvx8ybK1QlmGS/8D7cog1gRfCDBhbZ/Sk+ueWuBPUk0ooC135+UiumlJ6SP8PRnQGpG/8es/Fy0
 CJqBDJ0i65JYHQZuMxXIMX/bkpTbJJGRfPwkpTp/y1jjDGLAozkkgGKgrBmh8BYYJXwhn4GeNMY
 7Zswbrl7xd2tJhXjPulxsFrM8NkwWIE1dw8L5+aPaJ2Y
X-Google-Smtp-Source: AGHT+IEEBIqVh4ZJ8rHFVsra/zLBqrrO/2Z7wqCz/tbRxr6Sh6SkveOkvqyI/KznC/OO1HDpbbusNw==
X-Received: by 2002:a05:6a21:4d17:b0:1f5:6e71:e55 with SMTP id
 adf61e73a8af0-1f56e71100cmr14244196637.6.1741666152825; 
 Mon, 10 Mar 2025 21:09:12 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28c0339cesm7324454a12.46.2025.03.10.21.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 21:09:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 14/16] include/exec/memory: extract devend_big_endian from
 devend_memop
Date: Mon, 10 Mar 2025 21:08:36 -0700
Message-Id: <20250311040838.3937136-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

we'll use it in system/memory.c.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/memory.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 60c0fb6ccd4..57661283684 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3138,16 +3138,22 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
-/* enum device_endian to MemOp.  */
-static inline MemOp devend_memop(enum device_endian end)
+/* returns true if end is big endian. */
+static inline bool devend_big_endian(enum device_endian end)
 {
     QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
                       DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
 
-    bool big_endian = (end == DEVICE_NATIVE_ENDIAN
-                       ? target_words_bigendian()
-                       : end == DEVICE_BIG_ENDIAN);
-    return big_endian ? MO_BE : MO_LE;
+    if (end == DEVICE_NATIVE_ENDIAN) {
+        return target_words_bigendian();
+    }
+    return end == DEVICE_BIG_ENDIAN;
+}
+
+/* enum device_endian to MemOp.  */
+static inline MemOp devend_memop(enum device_endian end)
+{
+    return devend_big_endian(end) ? MO_BE : MO_LE;
 }
 
 /*
-- 
2.39.5



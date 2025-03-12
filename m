Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23207C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMxj-0007lp-0B; Wed, 12 Mar 2025 10:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsMxf-0007kd-UZ
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:21:32 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsMxe-0002bh-0Z
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:21:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3f4so3369772f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741789288; x=1742394088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z/MdsLbZNizpO5MqodWD1nVHf1+tJQovUVOqA9GDZMc=;
 b=U1Cpk9EnXT31kAIvvA2QfWYac2AV5gmcjnZA2QsYaQlsDKvMUJt4nO4rxa9mLgvbRE
 4oVVRsq2URjpgc7LmmHv/issa4hWKO8aiodHEGto6PzpP8nozmiw5iOSIxXnClf9qjGH
 G9/feEFF72DQ3gLlf/t6LXCll3NiXnwIznvpYQML+WMYAs/un7ZRBz3o5zSw2C1Bs0jO
 ljGV2QWZS3YJo5pwYnFd22IOna45XqXinpw4qbnVA2wG3CuxB201SeWIsr0x/NG5h3fX
 oKvVmTt2sHemTRb2cpXHZMqy53xa0via9/1U38yvrpfbXR6EwlKnKMkI9Sl5oX0U/Jzz
 d5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741789288; x=1742394088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z/MdsLbZNizpO5MqodWD1nVHf1+tJQovUVOqA9GDZMc=;
 b=G3t0X1aJ34o1CBYpCQYjVkPsDikDATcjkWPqjIW/dBWdsqI5WhxNWhd8ZZ9GDAO+KW
 Fr1q2cE2L6hGcIntrdfwC+gqzSK1j8nrR+/1Sfclsm8vjkuWM4cJpxrsN/FI+eHg1FXW
 2laSsWJ424MgGaMMOWra4QtvR8XNiJbP8Tm5Jxl30EqgJxdOzX+rvE9607I0Zp+WFtYo
 VZEtxc4jw8LOOm/njhbPa4WcGSeWm91viQiMYDMX3G1xZKvzYD7jtIhF3+kcJY4kZHdW
 WseTLX7vzsACII1PuaBPJiimJStpx2oPG6D9gHEm3t2yWRZ2MpEC7MY1NaiucYp7VNlC
 zJlQ==
X-Gm-Message-State: AOJu0YwtuwgW2wwsSANi40egQb8WWdqYCDGAANM15BMEZYIdtM6qDf5F
 nssUrghkFqEanSXGGGmVkjJigvQPYYW+FO+gC+20t85mb3TKNNSGn9NKWGi7SDepa42KFrpkX+n
 1Mh0=
X-Gm-Gg: ASbGncsRgFJLcTBYRUwGn9tALa5JmMhWVw8KcddKsu23/U79d1BPv3/ZhRR1ufVVRJl
 bThG8kSqVl3A4UKz5TiQO+JUEMt8/zMiYNa8EJGVUgHYBs0ZuHwj97tO586bHZskyQ218hhYRZk
 xGuoKcdNwy4VREG4Cc+Vwiv8Ns74uBu9mNtZ1IKxp4gPPVUN0Ck/6IJJEwtK1Ei1lGVz+u9R1eM
 0sPgz2yWR7ykKpBWCXmDwKX58z9GhDlWZfheeV14CBcBBtvOf111ZO2gdP/VL6XNa8vNjwRtHg3
 7WvFzcqjziSg+FWiUDmtFLSXMthDEWJebRQuebv9fKwZa+naieTJ7n4qRsjer1D/JFFCGoIj4ZC
 LHCecHxgkM6LKq9oE
X-Google-Smtp-Source: AGHT+IHDfMubsZIyM0SjyWYK5SQ9Ne9EhR/jtUCISWm5cts88AJQVtTO7wxUJmKStYvjnkj+ohCK3A==
X-Received: by 2002:a05:6000:18a2:b0:391:4684:dbef with SMTP id
 ffacd0b85a97d-3914684de0bmr9932843f8f.17.1741789287976; 
 Wed, 12 Mar 2025 07:21:27 -0700 (PDT)
Received: from localhost.localdomain (216.165.185.81.rev.sfr.net.
 [81.185.165.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e308dsm21639105f8f.67.2025.03.12.07.21.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Mar 2025 07:21:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2] target/i386: Replace MO_TE* -> MO_LE*
Date: Wed, 12 Mar 2025 15:21:24 +0100
Message-ID: <20250312142124.15138-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

The x86 architecture is only implemented as little-endian.
The MO_TE definition always expands to MO_LE.

Replace:
 - MO_TEUQ -> MO_LEUQ
 - MO_TE   -> MO_LE

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/tcg/emit.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 0fa1664a24f..5eeee569d1f 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1796,7 +1796,7 @@ static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
 static void gen_CMPXCHG16B(DisasContext *s, X86DecodedInsn *decode)
 {
 #ifdef TARGET_X86_64
-    MemOp mop = MO_TE | MO_128 | MO_ALIGN;
+    MemOp mop = MO_LE | MO_128 | MO_ALIGN;
     TCGv_i64 t0, t1;
     TCGv_i128 cmp, val;
 
@@ -1853,10 +1853,10 @@ static void gen_CMPXCHG8B(DisasContext *s, X86DecodedInsn *decode)
 
     /* Only require atomic with LOCK; non-parallel handled in generator. */
     if (s->prefix & PREFIX_LOCK) {
-        tcg_gen_atomic_cmpxchg_i64(old, s->A0, cmp, val, s->mem_index, MO_TEUQ);
+        tcg_gen_atomic_cmpxchg_i64(old, s->A0, cmp, val, s->mem_index, MO_LEUQ);
     } else {
         tcg_gen_nonatomic_cmpxchg_i64(old, s->A0, cmp, val,
-                                      s->mem_index, MO_TEUQ);
+                                      s->mem_index, MO_LEUQ);
     }
 
     /* Set tmp0 to match the required value of Z. */
-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C03BC55174
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 16:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqCgO-0006U0-Uj; Sat, 01 Aug 2026 12:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wqCgM-0006TI-Og
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 12:35:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wqCgL-000708-8R
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 12:35:30 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so2020658b3a.1
 for <qemu-devel@nongnu.org>; Sat, 01 Aug 2026 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785602127; x=1786206927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6jl/iPB3Wi7SsOT6gDvjuoDVlsE5CkYEVKruv5Tv6x4=;
 b=Li5qm3V7bEpAe2N86rJnGH1qGIuf57fGONV8GeiAaLnrVUHHOdf5qUmvj/5xshuJD8
 B+LFpFF2KL4QEQNPCBRSpRTDNeal5zAPEBUvbV2JjfIbtggXvWXVW48vqiC5mAp0U6GK
 fHJPvKbvhuttNzEI1eB55Ma3USBxSC7mq3YV1eocf7hgcYJRvhUMGFXNPcK5KabQn1XI
 vF1FuDQKs7Rnh2CF5O9WiZ4HiRZMvXhm86UEzToB9trwaSWmpZ94RqXkEiVvV0w2PL5W
 BZGsYNfCi0NkJIF/UcjDHdbxd9O1PcaIirKxjT4Z2ZKN+Vma1ALkV2bHg7lBvbIo2teg
 3krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785602127; x=1786206927;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6jl/iPB3Wi7SsOT6gDvjuoDVlsE5CkYEVKruv5Tv6x4=;
 b=aYQm6HVri5GrBWz3VHfJ7H7yjx+6V3gXwRoi7SIARjIsVSiwiU0aKToB4dYVoWjhWu
 E+JQzW8glh5omstYi9Tg7m8g1Bq3Ufm4dGK9Jgtqug9VM20nm6fziy/2U+GjqACYzD2g
 O3UfjQLhs2cA+lL21Jolr9EquVTUlGyA9Au8EImo64HBpEnIvmESYpe+PdMjhraL09S3
 wpHryKV5C9AQaDcHKGBXZ9bSvJRTzQv0KjXOvqEMj9Y9ZTKRxe9smrjMtzWK20ql5kJz
 cgqN/yUKiIkBXxOW957Bac88N5cGlr9ydUY/Z8NpEFSt04C1IkqVxkbn94q1pFy9iJvT
 M2yw==
X-Gm-Message-State: AOJu0Yx02paa5QFs4e1WfkMU0U/ir8xUQUIKtrgaecuVR4Gbex5etG7T
 HMyEeODoktckXw7/nBuEHuVB2jUpusI9OEY4FvRPYdJYfwHr3m+us5w5aAqBFbCN9uNXlwgvgTH
 DFOm8
X-Gm-Gg: AR+sD12PXMygF/78VxYccjNuKYm/QYBXBjXkXSukocB85bYefuDv6tUNToZW5ftPb0N
 0/u8eYmTmuXqrP7Z5EIQ0BlsbUrfvD6LFMAeD16G8r/1pgoh5FS10SrD8FEml9+B64oVp2soXng
 Q3vDvp12tB5UXvUhre3TMWxUDz0KYLW8LL49ZiSQ8i0l746aBIRN/hSDMNumLJgIg6MCahZnloi
 DFsY+j1nzOy1mrx1mESb8dKcMxeW9Sn8IpVNMl44zjs8YvxE01P9YxH7PJBI3c/VoNkjQlm65uH
 NRrc+8an4/v7aEiEwL8vAyGdaRLsdLOXvO2zMXaajx5srO8x7XQckbPS/54FDz+4LtxgvQ1s2WB
 jVcSexhnmwTsT0W3peEOKWVRHoH8qzHz8/J4P0lYufq0HgEgILoNRhmW1zV9b2OYC9sZrTvn0EQ
 zodAtUF/tIwztWEgjVjQDzL7qmJYSK7+H7fvxIto2bjXJ+YHi7tcsc8W6zbrHr5rZab7oV3I47F
 jS4VSp4by4tNL/WZ4hf
X-Received: by 2002:a05:6a00:430b:b0:845:d285:3b6e with SMTP id
 d2e1a72fcca58-84ee48f431bmr3461553b3a.58.1785602127280; 
 Sat, 01 Aug 2026 09:35:27 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ee1b049e5sm1392819b3a.58.2026.08.01.09.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 09:35:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Quante <christian@quante.one>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 1/1] target/i386: Update cc_op for SAHF
Date: Sat,  1 Aug 2026 09:35:24 -0700
Message-ID: <20260801163524.62111-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801163524.62111-1-richard.henderson@linaro.org>
References: <20260801163524.62111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Removing the call to gen_compute_eflags meant we no longer
updated cc_op after computing EFLAGS.

Cc: qemu-stable@nongnu.org
Fixes: da7649c6aeef ("target/i386/tcg: do not compute all flags for SAHF")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3537
Tested-by: Christian Quante <christian@quante.one>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/emit.c.inc | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index e4ef5a8758..473f415766 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3780,10 +3780,13 @@ static void gen_SAHF(DisasContext *s, X86DecodedInsn *decode)
         return gen_illegal_opcode(s);
     }
     tcg_gen_shri_tl(s->T0, cpu_regs[R_EAX], 8);
-    gen_neg_setcc(s, JCC_O << 1, cpu_cc_src);
-    tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
+    gen_neg_setcc(s, JCC_O << 1, s->T1);
+    tcg_gen_andi_tl(s->T1, s->T1, CC_O);
     tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
-    tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);
+    tcg_gen_or_tl(s->T0, s->T0, s->T1);
+
+    decode->cc_src = s->T0;
+    decode->cc_op = CC_OP_EFLAGS;
 }
 
 static void gen_SALC(DisasContext *s, X86DecodedInsn *decode)
-- 
2.43.0



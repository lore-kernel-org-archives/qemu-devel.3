Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13263C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtlG-0006Y5-4L; Wed, 19 Aug 2026 23:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlE-0006Xi-En
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:12 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlD-0004N9-24
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:12 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so1522549a91.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197690; x=1787802490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0l5cwjyhUZo0Z534C5ltswqTKfVTVx+zXnHGvUMI3ho=;
 b=oHqRuFbPzjcS1vV8N8tOXX7hktKhVJ+kuv+oyzH3bllZd234RgIjC1Hvsc+koXwt9i
 346qWEmcM1zE4FTHhD55Xb4MlYctV3kB5R1JsmrxYrASXtQLzgk+xK2us3F8SDl0coAo
 E3FpoALwYzuxMQC/y3mZC8qIS0KNRZbAP0U3OEfLZz5tWtYRIEfKkEdcPUSsfSY7Uwtv
 ifJ1DOeQoITwg0H3h2GJusfB5Fd7hPwBzaOfULpXzFVA5J7EuqjRajZe9TzZlsdbSzRc
 Uw+Kx4xf/ThYh5VWzILeX6V316ZsZ3mb3n99w+fdVDtSYa7IvTpgN2Xv1YDUfET9OID/
 +HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197690; x=1787802490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0l5cwjyhUZo0Z534C5ltswqTKfVTVx+zXnHGvUMI3ho=;
 b=rhgtSucfwOF5WbAKmZI53D7nwaUfIK8CyaodLonBN65sxR2FHZqs7+aUwbenQ+yisS
 udM7FIhilD9UpOza7ADTSxo+jxvZ9qC+ZnijteUE8M7/notscC1fzekmEoAjRe9MbOAy
 UrpLuiEuhnefw8ozDLTB7H5NReHrFz/SDLflNvSKopYhtaPHwm6kRfHk0qNw9RNtoycz
 Jb7RH2H51lPT99tKPvXoTubP1tdTJoYgAYC8eLqffZy5/TUzF+EjPlWJ4iBlo6jt22y3
 HiSvPdkGElDhe2goii30n/tFnblw4gMnb30RcuxjU3Alg32rqJhJnDvfprYSQci5/y/X
 vJMw==
X-Gm-Message-State: AFuF++l+lSTgdtZb2Z61ZUUUv7zp1gS2uNhDybd7uIdk2rtTk5hKrcTb
 ghooltBlnZCyS62IgSYKMNs7yYGyMt5YbW7dvl20DFABUSAks2dSyTj0oL00eQ==
X-Gm-Gg: AR+sD10LUbPmB16bDgWn5I9Jsko5jVY4sfccoDpqpp3iBLFb+goB3IxdDoCzkwUYFPH
 PMUy7SBCSdyguRKc9QbSImmUZSdWGSeX97tAJZ57jbL/0TEErtGlNvmaEDSZMerAEwwBPPc3aPg
 hGuU7qf6Gl+1WkPomNljUywznNXKGiTcs8ak5m7hawMCw3DBK4iE1b4Nf1NAxTlD9Q4nMCnJts+
 P3yefm3Z1sHjmuDFpCQPcKUoGnagu095/csPY3mGNK6NiBXiRuyJEU8qN09e24jjtEVDC9a0PjO
 ylH6b30JGilgGoe59bu2mvu++Rjp6dZcMKQVDCYW4aMkSs9i5sxFB9xFgwJHFcBb8wJ2IINrfOk
 gUyXDBaupXmQka0X3F+He0kL9TNTdh9gsjmO1uTlifYLFbLM7HS9SB4BhGsMDK2SFAIcV6D9xZi
 T3XZJXSJ59tVN+slJOe2/bW9D5lsja2/S1b10O1zzbQlH3JxGZDSxCkUbZNpbyNhrI7FvrYKUFc
 cvv2A==
X-Received: by 2002:a17:90b:5484:b0:380:f389:447b with SMTP id
 98e67ed59e1d1-395810840ccmr18439829a91.11.1787197689762; 
 Wed, 19 Aug 2026 20:48:09 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:09 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 72/93] disas/riscv: Skip post-processing of illegal insns
Date: Thu, 20 Aug 2026 13:44:09 +1000
Message-ID: <20260820034430.1186695-73-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260812223142.349142-37-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index bc86cb866a..75c2fa11e6 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5321,12 +5321,14 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
             }
         }
     }
-    if (!op) {
+
+    if (op) {
+        decode_inst_operands(&dec, isa, op);
+        op = decode_inst_lift_pseudo(&dec, op);
+    } else {
         op = &rvi_opcode_data[rv_op_illegal];
     }
 
-    decode_inst_operands(&dec, isa, op);
-    op = decode_inst_lift_pseudo(&dec, op);
     return format_inst(24, &dec, op);
 }
 
-- 
2.54.0



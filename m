Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4923FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3N-0000cD-Nv; Mon, 19 May 2025 00:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroC-0007Bl-2I
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:00 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroA-0004IC-BP
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:08:59 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30ec226b7d6so1022261a91.2
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627737; x=1748232537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YIo9lWxZ4TjsB8FoVA9uJ0EOvUm7HwUR23Lv43bqgeg=;
 b=nk2Q365ptujq+pd5aBuVR0GvUQ71viSXik2R8zfU0VOxdQuX++yv+/3hIMfxiAmylT
 ST4igzn/se/6u1lpXC33iL/VwnIzXiKSv/eWl70YFX3epXuzZr3ERHJYivXaYp+49FY3
 mfKg9yP+XvM93L8wHGR+HfhZP63VXQl14ab9cF4IJtg3Ty/ELpGHYgnWFO60g/7VptmV
 N+0g/wSZwXi/WEWupADdJyDcrC2ctvAmidCgk/wqLr0XWBUkHcN3pKr4gU3dEfI177gq
 u5gpSckaFMI0CF7DySB8z4p8xKPY4ZbRrVhwC0I5yJhGH0aNPqJmv23s8yS4ZJT2FMSG
 iFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627737; x=1748232537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YIo9lWxZ4TjsB8FoVA9uJ0EOvUm7HwUR23Lv43bqgeg=;
 b=kEIXe5PZXCLn4uaKHZkUp3X9H7IqhOwVAmAwUTSH0hLfRVq/pX9VUaDRR8G0QAZsOv
 CSa3sCwotU8QeGRvOZ+QGFVSHfuizQb31L2YPMNLLzb8q5CTjeovLuYbnazC+8XaWj02
 HYcF1YvI5wvLRs1oZRCFzB+EEyIUdbsmJPbRF/8GUsShhl4pC5jQv6YKfXQ72+XmXyhD
 Mgqf2p1GYJ0cuR5Rd9urwCcPEVsBgL2xLB9w6yzViEem+DUF50OUnoVZUB3/FGvnfUIu
 wdxKjjgHFV5v2juDtlDTuh5Eig4mvUS7RCQ4mIBIL7oMP/D6lSlG69zYH+P5+6T/+wPp
 gpcQ==
X-Gm-Message-State: AOJu0YzNJQ0qLdQeURO9hphvxDtupaAc0f33vMtolqw+RuGWvzwqAGzf
 QFrnjKFUJH2NJqJ7nEXP6dRDmjIZZSXAhtx5yx/vc8oRAel6d0B2vAYBrvIxkg==
X-Gm-Gg: ASbGncsWycUN0u6wP8BnTQhaAtg2Y4WdSNp8PelXUYErV18Pfp4ZUvL9kdY0+KdR9yG
 VDVNucHl+G/K2GuV+usFojFgI2vmZV+HYOxT8VI6TmZXgjgnfV1Du8RLzy7drTrMXu+8cw7Exp+
 KdZJs50EDXG95jiWGHXEifqGRPBfgwow5Pqidmdi1dPsR79xvbAESs0KGeze07tQ+Q6DxhCm7eK
 zyUp4eB+t6gdgzSidGBgtB2YdsgvQ1z6/yySHz0amYnOWcEFao/OfNj0gFE3q7kCEUVuz7DdiFP
 0rE/Al6f0cJF0mSSTwZiv3G6n5MVu4DUn2fGM0DtfLDNa77rAqnWDnypISooRmjk1GVCji2awZT
 E1mauHljhvrBpTrsYR7x6vNrB2wP/+Ya5MFApnZ2wColauj8hEtWADrlq
X-Google-Smtp-Source: AGHT+IHSsE1OVLtR2T99UC8JtjICJVSeyhhuuck58F6eNcjRgU4uB6tEKf6iFOEv8zmbxXFD08wDgw==
X-Received: by 2002:a17:903:2bcb:b0:215:b75f:a1cb with SMTP id
 d9443c01a7336-231d43d99bamr161659835ad.9.1747627736595; 
 Sun, 18 May 2025 21:08:56 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:55 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/56] target/riscv: Pass ra to riscv_csrrw_do128
Date: Mon, 19 May 2025 14:05:31 +1000
Message-ID: <20250519040555.3797167-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250425152311.804338-4-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 22149bd3fc..8af0304a36 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5588,7 +5588,7 @@ RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
 static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
                                         Int128 *ret_value,
                                         Int128 new_value,
-                                        Int128 write_mask)
+                                        Int128 write_mask, uintptr_t ra)
 {
     RISCVException ret;
     Int128 old_value;
@@ -5610,7 +5610,7 @@ static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
             }
         } else if (csr_ops[csrno].write) {
             /* avoids having to write wrappers for all registers */
-            ret = csr_ops[csrno].write(env, csrno, int128_getlo(new_value), 0);
+            ret = csr_ops[csrno].write(env, csrno, int128_getlo(new_value), ra);
             if (ret != RISCV_EXCP_NONE) {
                 return ret;
             }
@@ -5637,7 +5637,7 @@ RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
 
     if (csr_ops[csrno].read128) {
         return riscv_csrrw_do128(env, csrno, ret_value,
-                                 int128_zero(), int128_zero());
+                                 int128_zero(), int128_zero(), 0);
     }
 
     /*
@@ -5667,7 +5667,8 @@ RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
     }
 
     if (csr_ops[csrno].read128) {
-        return riscv_csrrw_do128(env, csrno, ret_value, new_value, write_mask);
+        return riscv_csrrw_do128(env, csrno, ret_value,
+                                 new_value, write_mask, 0);
     }
 
     /*
-- 
2.49.0



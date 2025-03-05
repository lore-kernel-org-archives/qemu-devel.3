Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4498C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdwu-0001N7-TL; Tue, 04 Mar 2025 20:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdwt-0001ME-5W
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:27 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdwq-0008Kv-GL
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:26 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22334203781so6637115ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139603; x=1741744403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cF4A8Jz90TPUKD7OCkZaaprdbgwWpIvnZLmu+i5+8P8=;
 b=Q8Y4sw9I+YIqWrFDnm2LImWTKaonY/lExw9J8lR5hRabLuLibBEZ8Z1bSoboEiECaE
 VQEdVtr2+hZGjVIec+ITrH5UuJAHm3bZzJqx2BCJ0kPCK9cF98t+8x0JoT2cGJCeDlm1
 yJfw3ybmWwRrNXwpg/cf1+Lxq3pR1gcqaTVZqu3sQDUhq2SnCWkaVhoCLru17CzsI5tT
 4x/IOzoDydWnOt2LEIITds+01Iv/09zb/8Aryf+G6KzNubmEW9lU3Keq9VesbeaG0N3c
 7UMqUI77PlN5xpLvb5X6L1BirsmO1NGpvqA9jsw96/D8XaeeaKI/l/uDu39+YcibU3oy
 XFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139603; x=1741744403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cF4A8Jz90TPUKD7OCkZaaprdbgwWpIvnZLmu+i5+8P8=;
 b=I4rqpGJyS7bvfDDHQUgM8KamQh8ODUF1Re8OMnsRyby5Za95uEH15DZBRnYE5gkepe
 m770StKnHhewGXv9WcqergKmbm1KvDTBUvjw13PXfg6KtiKcnbdg0l2GEg5tZW4tOJmi
 F/jHz2ZemXwdknDWIF+PgfUdqP8yTZGVk38sOUDye1AG5lBvOhnVxWbOuYpibVv78nO5
 z2ZkNwuAyoaif7H/Nn/4KF0nHuAVmPpC+EeMblCqJ54slqKRuwOhK/cPo19a1vT/yh+4
 8KuLCfisCiCEBf8lHacitEBj4AbXRNxmmY7HjRS2EzdCDND0R1TvtXbqVe0tmHoZ+cml
 8ZBw==
X-Gm-Message-State: AOJu0YymmC+8ygWMJnmUI/X7gKrxppD6BtxyTB/aTuT5WY6XigyLmE5W
 hjdjJvRuNcuo83fK8VyUel1/euDXT38o/PKa0sFE7i0/6gj7duWyVUqPdOqlwr8=
X-Gm-Gg: ASbGncuHti95XWxjYpgj5BzSI6wX8WMVYU6K1F818U49On+6cSD4JRlBYf1TuSXRKh2
 Mkvwa2oXRaci8vzv8cP8mbUKse+IZBznZ9PeLXLY8uYi/9CnvthCuvHdkG7s9lBKzVSM91gUl/z
 cSgJ8cybxQOeUCspwvlk7hESb//kn0jvhieWBXe90L2IZ+kGSfQNr1p6xtuqWolKKrPR9JWl1TK
 6A+zFzQ18ZeM9GTYbvYWgr1NvpLL9UMc+X5Hv7gPxXxnq5dcstzx1CV3+fTswf7PiUrJc752Ng6
 wKoyjHquH4bMKhY9L8sC6YX8GpyE6zZP5aT6Gv3+4AG/Zji0VWRfZ4VCcPqz+u0cU2YbtkeOqgu
 Qp5XdMUNASd5rW4iAIYlgCVHKn31vgjBnTSqENh4WxFBwB0t2xxY=
X-Google-Smtp-Source: AGHT+IGVO+ELndxDC3hlihg42Zyg8BDVrRqR3hMth6Z+5sIr+tXbwmOI/Ss7zHoHmXwz1y6XoJH3GQ==
X-Received: by 2002:a17:902:e751:b0:21f:6d63:6f4f with SMTP id
 d9443c01a7336-223d91343a5mr87788015ad.2.1741139602683; 
 Tue, 04 Mar 2025 17:53:22 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:22 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/59] target/riscv/csr.c: fix deadcode in rmw_xiregi()
Date: Wed,  5 Mar 2025 11:52:11 +1000
Message-ID: <20250305015307.1463560-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Coverity found a DEADCODE issue in rmw_xiregi() claiming that we can't
reach 'RISCV_EXCP_VIRT_INSTRUCTION_FAULT' at the 'done' label:

 > 2652     done:
 >>>>      CID 1590357:  Control flow issues  (DEADCODE)
 >>>>      Execution cannot reach the expression "RISCV_EXCP_VIRT_INSTRUCTION_FAULT"
     inside this statement: "return (env->virt_enabled &...".
 > 2653         return (env->virt_enabled && virt) ?
 > 2654                 RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;

This happens because 'virt' is being set to 'false' and it will remain
as 'false' in any code path where 'done' will be called. The label can
be safely reduced to:

done:
     return RISCV_EXCP_ILLEGAL_INST;

And that will leave us with the following usage of a 'goto' skipping a
single 'return' to do another single 'return':

     } else {
        goto done;
     }

     return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);

done:
     return RISCV_EXCP_ILLEGAL_INST;

Which we will eliminate it and just do 'return RISCV_EXCP_ILLEGAL_INST'
instead.

Resolves: Coverity CID 1590357
Fixes: 5e33a20827 ("target/riscv: Support generic CSR indirect access")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250121184847.2109128-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0e83c3b045..75f21ccabb 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2621,7 +2621,6 @@ static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
 static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
                       target_ulong new_val, target_ulong wr_mask)
 {
-    bool virt = false;
     int ret = -EINVAL;
     target_ulong isel;
 
@@ -2642,16 +2641,11 @@ static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
     } else if (CSR_VSIREG <= csrno && csrno <= CSR_VSIREG6 &&
                csrno != CSR_VSIREG4 - 1) {
         isel = env->vsiselect;
-        virt = true;
     } else {
-        goto done;
+        return RISCV_EXCP_ILLEGAL_INST;
     }
 
     return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);
-
-done:
-    return (env->virt_enabled && virt) ?
-            RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
 }
 
 static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
-- 
2.48.1



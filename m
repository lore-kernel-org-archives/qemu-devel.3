Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED68C5DF9D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNYV-0001Nl-KA; Mon, 24 Aug 2026 01:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYN-0001Jv-L7
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:04 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYL-0001px-SM
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:03 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so3148828a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550540; x=1788155340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pmOBYgqrw3RiSWM58XHjxeAyd3bF4nHvgyQYSsEFwig=;
 b=elvvM5scIVSL8BslERBm+bYPcJ5+DxId/z1ZuWpRI1U90qSdOuMf2zrhRtFM6Dvpzc
 2qiCqhTu6q41HRjGkda5PGECj+3GRcVPf+vMpPS0ZUoih/23/PkklLYseCU/BPGTz/qD
 we6EpONPqvai+8z4qvTSYfIaWvudOa06XTI5/WVWAt2rUwMexnIo8bjNCvu5yD/gu2+b
 HAdLzPO5SBSLxeDZmVrIIOVZDe8ROOOXkvSRMIc3QyN1XieATxURFbN3GCWlnJcFw6k7
 BBNzm/XV1aK1EmEo3E8etZMm4lf1D/FSuE2akQJFMksVJKX2M4Uk55TTpdmw8cSzUZ2S
 /gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550540; x=1788155340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pmOBYgqrw3RiSWM58XHjxeAyd3bF4nHvgyQYSsEFwig=;
 b=mrLmpbpIf8FSSAKV7L4bWNerkgm44tQKY9mJ9EfZP6q5cduas7SCf127DHbc+79Xmx
 1cpIuYeDKtYbXVWtU0LSH1jxkVzrHBY6iodOTe6xCWkPv29NLb5YNMFJ1FBnvUK7Dwmc
 Ydbqxu5M5Cl2ZBiLP6Y4mEpkL+Wfsm2N2oaUQCxdglncNKrzqJvqgQ3UeUC9iLlqL5YT
 nI+PEiV8ZnjOv9PZjiFkOzST7eiw9GBfvKpTHwhhyKh/fmKYgtlWD3aT3WMfKSMAPLJC
 aXJwY/NuMIhnoh/2PXhIZqxckRgZRie1D58h9pXmyWtMCO+A+Yc3OBQ69zZ7P0zMbNfW
 Hkcw==
X-Gm-Message-State: AFuF++kNc+eewcU0tL2Ul3m5y9juVqTErAwusY453CB8bDNYFDUI5f6u
 ZWw6Aaf7YPp6pJH0OF9Dh01VTqkHa9gKMfZykasf+T3MjpP/wPzw1iUMeOVXOg==
X-Gm-Gg: AR+sD115gxpp9vrE12Tn/Ln3YsJ5wrREXvep8hnhNFmXgWqI+1sIADK7Sx5qqIKFo7b
 Tmlijws1QfoiAYYf0gX33DS2ULkVtN1vs59nlh6sYiFMpMn6VJ90ZCDjM94Jr92lZ/9uSGN2iSV
 xerFpb6MpzXq0ohaMT/zc4fJh6N9bH6MlcOt77ISuYvur5IF2BPJ4enpmU8N2xiH4EqVHgv1d8P
 odaBZXJzUHhZUIMvx6qW+28rxy80gVOqhiV8Reqn1IXX+9mKPrz5yhaS3FP+YDYK/3r6jUVQPLy
 CV26vlI5g+e5aPp5SzCLPcd4w9ULGICbT/wJnQDoov4rSFsH/Ve5dTAI1d3+XR7NFy0Et5lBEVO
 JMPdat2LfuY/DdURaDSkSBAHtycviSPNmp9Hvvnybvbh5i2Gbb6U+R1jV/V6Nlke06LX5fmSArx
 UJgMe5zea+ZiPeyf3k/wfQSHtN5ApNQaESKiooEXxaWhgZKqNT20aRDxBxKCF/JEhxpnLLqxIe1
 4b/iA==
X-Received: by 2002:a17:90a:d605:b0:38e:5964:97a8 with SMTP id
 98e67ed59e1d1-395df5e8fefmr29822405a91.16.1787550540401; 
 Sun, 23 Aug 2026 22:49:00 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:48:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, A-Shehab <ahshehab24@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 13/96] target/riscv: Fix PC sync in trans_sspopchk for CFI
 exception handling
Date: Mon, 24 Aug 2026 15:46:43 +1000
Message-ID: <20260824054806.2790041-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
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

From: Max Chou <max.chou@sifive.com>

Move gen_update_pc call before conditional logic to ensure consistent
PC state regardless of execution path.

Previously, the host instructions generated to update the cpu_pc were
only executed in the failure path when shadow stack validation failed.
This created inconsistent PC synchronization.

This inconsistency caused issues in CF_PCREL mode where subsequent
instructions calculated wrong relative offsets from stale pc_save
values, and could lead to incorrect exception return addresses.

This fix ensures PC is always synchronized before any helper that
might raise an exception, maintaining consistent translator state
across all execution paths.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4118
Signed-off-by: Max Chou <max.chou@sifive.com>
[ahshehab: rebased on current master; file moved to
 target/riscv/tcg/insn_trans/ and the ssp load is now 64-bit wide]
Tested-by: A-Shehab <ahshehab24@gmail.com>
Signed-off-by: A-Shehab <ahshehab24@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260730181852.1622-1-ahshehab24@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
index a813232887..d47a9f9c7d 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
@@ -32,6 +32,7 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     TCGLabel *skip = gen_new_label();
     uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
     TCGv data = tcg_temp_new();
+    gen_update_pc(ctx, 0);
     TCGv_i64 wide_addr = tcg_temp_new_i64();
     tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
     tcg_gen_trunc_i64_tl(addr, wide_addr);
@@ -42,7 +43,6 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
     tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
                     tcg_env, offsetof(CPURISCVState, sw_check_code));
-    gen_update_pc(ctx, 0);
     gen_helper_raise_exception(tcg_env,
                   tcg_constant_i32(RISCV_EXCP_SW_CHECK));
     gen_set_label(skip);
-- 
2.54.0



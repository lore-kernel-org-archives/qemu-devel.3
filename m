Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1A9CA0ECD
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjofQ-0004RM-DV; Thu, 29 Aug 2024 19:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjofK-00045v-Bj
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:58 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjofF-0003CY-8G
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:58 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2d86f713557so4302a91.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724974492; x=1725579292;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6L8R5EzGx+7JXpVfhwTDrr1noPqKjdxDXuzeQGb0BU=;
 b=eIpYs3/v/O0eO3Plz7/pvyX4xhfuPbs/vdzW39ObheJiEZKoixj16TRUK+JJdJKEgH
 KaoKIyzJpHDDlvVFqWq502+l7znCfLNkY3koOe3B/9mKng8l73UxxQA/+UVZZkx2cAFt
 F0kwKSDFDBGbuNRv6ClorN0BlG1nDKEBuljhhPCMQVyz8OkIohkz7jNI/MeHjA2IVlij
 mGGRA22PXpoCqH09AfSdrIJDO7oLAMaJoabCZ7dx6j1eeM8TeA/vHUHQx0bDqx+YcV1y
 gGg9Pai48gX9l3JoZ8F0qpUdK6JOqgiZ6jKL8FbOmkyl8+9uH4F7kX4WslMof58mssdG
 g1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724974492; x=1725579292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h6L8R5EzGx+7JXpVfhwTDrr1noPqKjdxDXuzeQGb0BU=;
 b=pkcK3ShoMWirYWZrtUNVpLGTKozbn9AZGmVvGueu/k0CA7LJknCWZ+sdEt8xYfpscm
 7+54x2XTfMmx+y6tJE9gub3r3CPMJgkRAps1CNCWCjv2xW4fhxdPKMOuZxP6JljkKawy
 mk7hlm7LoU0A1ihU2WEcRWkMr44wrjybZuu5Ia8/SugcazlmKhR/2li/uECpH6nzzmO1
 suqsZztDJ4ibtwjAi/nbz+VygTJvMs93EfWUyM+PeWXChUlxffMrsQChMnWOo7ha/AUE
 jf89eVy5PInU9oPjAnBY9lG6cFsjqMBKpJ9RdD4luc4q9F8kuuRq/jkm3mK93kX8que9
 E9Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkmzKmESFAacPMRsg5XybSUY8vyYTvxPFBd/+7Z91qDEMWVwoummXpl2K+VREv3rZY56Z7+1z+YFFk@nongnu.org
X-Gm-Message-State: AOJu0YyIj3XNVcjvFZIO0LpKnimZVzPTVN05eOv/BElDNxSKnHbqOQzN
 vM+CXcGFNfe3v6qsGymkG1XbuXJt+2mPdEIzYD3UTTLJiShXQrtK9xDrcruSmRo=
X-Google-Smtp-Source: AGHT+IE6rFeL1aZNM1dzW7uGB1zGsmWUVRg1xFaK+jMYjMuWi1ewxjnv1E1vPKyeNDmZ1G9H+UVGZg==
X-Received: by 2002:a17:90a:a410:b0:2d1:ca16:5555 with SMTP id
 98e67ed59e1d1-2d8564b3acemr4319639a91.37.1724974491756; 
 Thu, 29 Aug 2024 16:34:51 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d85b13df55sm2331074a91.27.2024.08.29.16.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 16:34:51 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v12 17/20] target/riscv: compressed encodings for sspush and
 sspopchk
Date: Thu, 29 Aug 2024 16:34:21 -0700
Message-ID: <20240829233425.1005029-18-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240829233425.1005029-1-debug@rivosinc.com>
References: <20240829233425.1005029-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

sspush/sspopchk have compressed encodings carved out of zcmops.
compressed sspush is designated as c.mop.1 while compressed sspopchk
is designated as c.mop.5.

Note that c.sspush x1 exists while c.sspush x5 doesn't. Similarly
c.sspopchk x5 exists while c.sspopchk x1 doesn't.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn16.decode | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index 3953bcf82d..bf893d1c2e 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -140,6 +140,10 @@ sw                110  ... ... .. ... 00 @cs_w
 addi              000 .  .....  ..... 01 @ci
 addi              010 .  .....  ..... 01 @c_li
 {
+  # c.sspush x1 carving out of zcmops
+  sspush          011 0  00001  00000 01 &r2_s rs2=1 rs1=0
+  # c.sspopchk x5 carving out of zcmops
+  sspopchk        011 0  00101  00000 01 &r2 rs1=5 rd=0
   c_mop_n         011 0 0 n:3 1 00000 01
   illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzimm=0
   addi            011 .  00010  ..... 01 @c_addi16sp
-- 
2.44.0



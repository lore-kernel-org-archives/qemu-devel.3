Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14CEC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpe0r-0003pr-Qm; Tue, 04 Mar 2025 20:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzX-0000tB-8v
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:56:12 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzV-0000ZJ-ND
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:56:10 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-223785beedfso79532405ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139768; x=1741744568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoiFdbbJTlFWZLwqC1xUIWOhoGHSOkQ9ZUT/2MtQZn0=;
 b=cy9NDum2PKxtXuATKdp3n6Y8CbObMggu4BHktEIQrKU/Fvjq2Jw3LcP2NZGfeeeAPB
 RedKGKFZKJjiyq7bREQ6XGu9An0BWAo6fxNPOjjTJkgTe7S5zcDcUXdvNj2RjhbFmvL/
 HWjnqafESjByxhv4hhWH9J67nl9Axt7W7Z1OW6pDxdi6/lCrYgWLU53+P8xZxvNrCCGR
 5CS0dZb4HZ8uoGZHHpMb8gpq/Y5nOLPHAOaGrWvi/FF3hWYeJf7ir5cGasstPvhuB64Q
 h6Y2hzkEBYmdtIzrImFdDw+6GazWj7ycYpXXq6kdLpPk64iuolmKG7ZE6wiGw4+MUYoN
 Idww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139768; x=1741744568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QoiFdbbJTlFWZLwqC1xUIWOhoGHSOkQ9ZUT/2MtQZn0=;
 b=sn6Q0BfUdgA4xX2UOoLpNGEwQPj5a853GSJzsNTV07LYja9PSasvO3Zwi+n5em5M5p
 gH5qScy/1nJK8Zr1IH9ptQkIBVG54lmPRVpmYofc3HkXSS3xxJNTmux/FVWRyd+ao//k
 0daztkEo92K4++qCRZdnv1WzPr73cm8kc5qKy/bzI35Srnugb4+TCi/vnX3kS0i8w5Ps
 dHYZdTi5taHQMpiLe0T3RhAU3Ghasl3FZO21e5YMzuq03LzR3cNZ7bVLAxgfd/D2tFvY
 TYinbtJoOtepMw2MH/lbrxKINIb/5JEoRBNL99iGO/NcZWDgW56HjNQjpLYefSdNH3El
 9S7g==
X-Gm-Message-State: AOJu0Yx13RJjjUFi8OHG3mCxswmi+ct5H7/xzuaLmJ8k6jG/Bj5FvY50
 e5S51O9I3Y4FbJq0DbX82lWVbCMzk+r3yEv5WWqvR/hlK14mXYfaojYqPiRsxGs=
X-Gm-Gg: ASbGncsXjJu7kfAUFPLc7id2OPk0PwsUqdXdK+FdWMJKtgFFtkE8F5sZHyMEppMuTno
 2tWRmds8i2EMKvyoIOwMN9U0iWRGW+ajXRy0kNYcWm1+X7d5YqbqBJNgB0ty0k34+GkQH7/eCcK
 ZHmRtJIGUXUOoEwFadmPCJmhprqTxpjKiWQulx/FZEyJ4WR3pJ31KcTPmYdefmLGQaCw1i4vgeB
 ct404iTgA2VatFnWZB++ly8w47w7mXN5ckmESfQvRSQL9SAZFXctOfhbCxMkd4G+rwYwEmw0iaa
 C9Hhdit7abzY9T+pHWp2o3gQ7dwzR00FwLmhgkbd1HEZ5uzHhoupnyWi84AlybKMbyadHQCdaYI
 yOBZkw+8P8I9UXuaCUmejgTsgr2BW5Sco2h3TpL4d+qGc+Std+II=
X-Google-Smtp-Source: AGHT+IFFm/Wer26YIDZDSNWLTXVY1RVZ4XZHLvWeOaMCwQtnQ1BXqpgJEFzMohhjTp1uRLINnOYYtA==
X-Received: by 2002:a17:902:f691:b0:223:653e:eb06 with SMTP id
 d9443c01a7336-223f1ca7c4cmr26259985ad.26.1741139768121; 
 Tue, 04 Mar 2025 17:56:08 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:56:07 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 59/59] target/riscv/kvm: add missing KVM CSRs
Date: Wed,  5 Mar 2025 11:53:07 +1000
Message-ID: <20250305015307.1463560-60-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

We're missing scounteren and senvcfg CSRs, both already present in the
KVM UAPI.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250224123120.1644186-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index ba54eaa0b4..7f3b59cb72 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -624,6 +624,8 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
     env->stval = 0;
     env->mip = 0;
     env->satp = 0;
+    env->scounteren = 0;
+    env->senvcfg = 0;
 }
 
 static int kvm_riscv_get_regs_csr(CPUState *cs)
@@ -639,6 +641,8 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
     KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
     KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
     KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
+    KVM_RISCV_GET_CSR(cs, env, scounteren, env->scounteren);
+    KVM_RISCV_GET_CSR(cs, env, senvcfg, env->senvcfg);
 
     return 0;
 }
@@ -656,6 +660,8 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
     KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
     KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
     KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
+    KVM_RISCV_SET_CSR(cs, env, scounteren, env->scounteren);
+    KVM_RISCV_SET_CSR(cs, env, senvcfg, env->senvcfg);
 
     return 0;
 }
-- 
2.48.1



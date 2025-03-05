Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173CAC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdyb-0006Yj-Ee; Tue, 04 Mar 2025 20:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyO-0005V6-0S
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:00 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyM-00009l-Bk
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:59 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2234e4b079cso115243135ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139697; x=1741744497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1SZhtP1YziV6oMY93SHLjzBNolt0hd4qce4gnNXPEjc=;
 b=Xh5ORFq0dhRKD+Z7ZkjEtWzMeNmbUYSIhOI5JwEFMlop6VdcC/YdztbDeQP4100rCQ
 Clpe4D6gjGH92CvBEiISgyjz5FQj3rae6PZT4AvAI8xU2jhGW4dVOSo2jBqQHbkh+ail
 fKYZ1bi+xAc5s0NESHDDLSGAFMbIynWCzRg4xTls24dWxcQUpOl2ZwyviQZD7SAvepUs
 hLTYJjbzkR9q3xpYQXdF0UgT2FlgI3ZUXos05XgV/OyPV2YGZCKJ8LDXEBaT/DnX0aT+
 qFonbIn/t0ZivRX+PTU7rMvrPxDKc0+XMd8UySIfR5T8L7ldlUdscF3loH4c4dLEbphI
 osuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139697; x=1741744497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1SZhtP1YziV6oMY93SHLjzBNolt0hd4qce4gnNXPEjc=;
 b=uG9q2INDDRZ/EcfXnL8oypL+kaPZYkd4g0HLlIo5wLIxpOCuLrxNjPYVkp8azIAenI
 lKjQUsCG+3sNe9hmQqyfYZ5x9iMCblC91gLtbO+9D4mwegiRegkIjXvmts0m3bUSOWQh
 6AhaLaozU7ZH+J1VXC6VOeXz2AKAkFkBFY++Q3KH2j6EQxDdhdb7p/IpVcgPXY89ZVlk
 IzMH0aq2D05Az/+8M+KD3YGtC2F0TX9aLllzkji30rUEZ9tQT36ZS2iBZyVqXQirkymT
 dwOBfYD4UNfWx0b2j9VdCnCaYsCi/RAY+dHMiH0TvW1kcm52alm4wH7yJqYP3sdHHEfT
 MebQ==
X-Gm-Message-State: AOJu0Yx0LbrI/3dzlgbe2x6Z6keXOuiiw9MpqOq3SPzsUjXdjOuRCSiq
 i7Zqco05kBF/T1GduLILntlO/Ek+fpqwqJUIicC6CqZ01kc6nIWaf4D08CqMETY=
X-Gm-Gg: ASbGncvy/OeLJIvUQsT2WwZiw1/asGJCdxZ/DFYMW79z1tGGr5ny7yERfQF1mpn3tfw
 6XhjzHPMlUhP0Vw5+07kwjbQnTLasmGs//dIqnH50yG6EifNb+6HYQDaQlKr+ef/8HtdMlBy4K5
 mQcJEvskVnhrTRU5et/nWn7liLVwAoIm44EY6w+wzh8Zqayw1XjYhUI7WdftW3NtqaYPP7dHdbK
 Qf4mzwObQqK9PLczETv0RpqkBqlr4YF8ubsyubG6HdewG7cvzaJ687jPMBP2pIw37fmqXH8zZ64
 jIQ/LNJp+7hCV4CTTw2yGFMvzUte5b6sMyYUVO4dKcybN1YREKJhsmdOCEmHX/pYxnabdJfQ8hu
 zias8s9GJixqn0+ziw86qvf7Darmb4y/Zpx0OnIljrmfvexKBk0E=
X-Google-Smtp-Source: AGHT+IHJrMrUM/MXxaJIERX2pWevGA57YbDNrAN3ct7SOqI0kQJ+mn2z4FdOMGJugknoKN5dyjHIVA==
X-Received: by 2002:a17:902:d2c1:b0:223:66bc:f1de with SMTP id
 d9443c01a7336-223f1cdace9mr22614255ad.21.1741139696654; 
 Tue, 04 Mar 2025 17:54:56 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:56 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 35/59] target/riscv: Respect mseccfg.RLB bit for TOR mode PMP
 entry
Date: Wed,  5 Mar 2025 11:52:43 +1000
Message-ID: <20250305015307.1463560-36-alistair.francis@wdc.com>
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

From: Rob Bradford <rbradford@rivosinc.com>

When running in TOR mode (Top of Range) the next PMP entry controls
whether the entry is locked. However simply checking if the PMP_LOCK bit
is set is not sufficient with the Smepmp extension which now provides a
bit (mseccfg.RLB (Rule Lock Bypass)) to disregard the lock bits. In
order to respect this bit use the convenience pmp_is_locked() function
rather than directly checking PMP_LOCK since this function checks
mseccfg.RLB.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250210153713.343626-1-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index a185c246d6..85ab270dad 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -524,7 +524,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
             uint8_t pmp_cfg = env->pmp_state.pmp[addr_index + 1].cfg_reg;
             is_next_cfg_tor = PMP_AMATCH_TOR == pmp_get_a_field(pmp_cfg);
 
-            if (pmp_cfg & PMP_LOCK && is_next_cfg_tor) {
+            if (pmp_is_locked(env, addr_index + 1) && is_next_cfg_tor) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "ignoring pmpaddr write - pmpcfg + 1 locked\n");
                 return;
-- 
2.48.1



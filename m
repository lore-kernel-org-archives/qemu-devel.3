Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE1AC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 01:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugvGe-0001la-W8; Tue, 29 Jul 2025 21:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCl-0003h8-M2
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:02:03 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCj-0004ny-Lr
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:02:03 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-31f314fe0aaso1514631a91.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 18:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753837320; x=1754442120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HABKAT3UkQpkDi28bQ9RXNj8MoECQzmBVWqJiF0ZqcQ=;
 b=X8rnJGKQ7gpn4RTQpfyabhg0ztNZKHm9DpZNjed6P9t4IAL5lA7unC0M2O4jSRdx7y
 Lq6aD/1Izic5H+AZMXPHXL2+/7+DSPqa4EMDJvxs6d4ibWDY/aIeUn/xoGBAb8UHW2j6
 OFtNMBY8aw99fqVqUmHWpKNou+TPhVU63D69rCt3834fRWJWWTon3nDhBVLAfOu20Sdh
 rlWT4kbelld3pmetPIcYtH9Okp6SZj/EjjHHwu3KEv4wtVpoV+MSXcbFfbTwALyfLaMZ
 sPSlqQtNKCZF+egmbROeDbZ4PGRhxaRFSouLUookeXPjXgHos/wBdZYgi26pkai0d7zR
 37Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753837320; x=1754442120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HABKAT3UkQpkDi28bQ9RXNj8MoECQzmBVWqJiF0ZqcQ=;
 b=LPaQZ7OlnYUvSjlL9NN14E6tQObD4h9csAhkUMMejPheyoy3jxac+aTZHDwS0HhFdq
 mUmco8iNK3UAF0ytVrRmUjDjPj3y8uIsZn6RygCDqPzpWBFWN51TM9Dd9hxmEVvO6yXX
 mrt4uR/pPcqiS/9PbBOXaJVyww/N1G+o694mrI0Qp17KYurDWPa8XLFnJXO5TU4Dt/+M
 5Emdx5f/uTw39IsyUihuhG8HtAZb1FtATgBorfRWgIfM6y7BtMa9AGc4LWJTxGwG6IfO
 D+0zk0eTPksw7ZQTuq+eXB9emgqOFivqE6S4FrsjS8nmYJi2FRru9uhkWxXdl7sGSjuV
 dCWA==
X-Gm-Message-State: AOJu0YxpadFjeCUhxATNwiFZLJY9dLFKIJ9SlwwOlJNLcuAcygWfHOBc
 PJHOqi768mL5VR++juCSWxIbRuyb70axUQVKeDoTzIT1MNYSM8lhfvOeMSJv1w==
X-Gm-Gg: ASbGncti2UYnvR0S5I9SjtcUSaa6I4ZX5b5Z7UUeaxaHUZhUTdBzHIj4EFU8UBqmLt5
 fgz9TZps9NpNXDwQ/MIRqG1SJvk5eFS2ib3EQAb47RB4FHLf1RfMQsV1YUlyYzZsFVXKqmLrHlh
 3s2LgctYD2eZJHKLyjY78unSZ5dl4j6ibqvIVfWw+STmfJlx8jMTz92zoExlFE8qlQT6N0ni3D4
 KI7TNj0cC0GjAJYgIEZLIdZsuTzO7NITDcoq1pqjuJysapns03cYknULjv8WrPPVHP490jrB8Qm
 st0WdnljvvP8Nscd8D83JQBugMSenVr8jTwCBcjKd7PfzTaRCPO5nrfMPp3PEz7zeqikyJp8YGq
 dkmKvej8SLwruAQxbHh522+eVxDHNLnSblMeLS8QOzXffeHegzbe7hdY6I2qYCa6LjaD+4yA6ay
 KgRtd+poz4AnV890rV9tRryp20y9/CkcNSu6rlfg==
X-Google-Smtp-Source: AGHT+IGqFd6I92IqpqMUzDt/cG4+sQ0Dv6Wd4esDulAW4OGs4hAbFqqp4Jg060iTi0pPzTZVTJLsFg==
X-Received: by 2002:a17:90b:39c5:b0:311:ea13:2e70 with SMTP id
 98e67ed59e1d1-31f5de3ceb7mr1960249a91.14.1753837319809; 
 Tue, 29 Jul 2025 18:01:59 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63df5adfsm343253a91.25.2025.07.29.18.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 18:01:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Xu Lu <luxu.kernel@bytedance.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Nutty Liu <liujingqi@lanxincomputing.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/11] target/riscv: Fix exception type when VU accesses
 supervisor CSRs
Date: Wed, 30 Jul 2025 11:01:20 +1000
Message-ID: <20250730010122.4193496-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730010122.4193496-1-alistair.francis@wdc.com>
References: <20250730010122.4193496-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1029.google.com
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

From: Xu Lu <luxu.kernel@bytedance.com>

When supervisor CSRs are accessed from VU-mode, a virtual instruction
exception should be raised instead of an illegal instruction.

Fixes: c1fbcecb3a (target/riscv: Fix csr number based privilege checking)
Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
Reviewed-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
Message-ID: <20250708060720.7030-1-luxu.kernel@bytedance.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 8631be97c5..9bebfae3f0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5577,7 +5577,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
 
     csr_priv = get_field(csrno, 0x300);
     if (!env->debugger && (effective_priv < csr_priv)) {
-        if (csr_priv == (PRV_S + 1) && env->virt_enabled) {
+        if (csr_priv <= (PRV_S + 1) && env->virt_enabled) {
             return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
         }
         return RISCV_EXCP_ILLEGAL_INST;
-- 
2.50.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D38C02187
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 13:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY3mx-0005y5-F0; Wed, 15 Jan 2025 08:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY3mv-0005xO-Kh
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:29 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY3ms-0007sR-Tt
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:28 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3eb98ad8caaso2808959b6e.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 05:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736949024; x=1737553824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEOF8Hfu+NnUUzyEQczw68/6HXLCAqPr9fHHglkR6Aw=;
 b=Cowd9JK/aMAyWwNGAGj28b5wjuAPRNbn7ccc/87ydS5h+3WROLnfghTjLhhSfYBb9S
 F6AQ5oOv9Mfj3IFsVzTuag9Az5zx3Ua067rZ+4fyFj3aRMfBY4tGEF837USHIKAlpOWq
 +bX73BwI2C2bAgh89bgDNu4zs0Il+2CBhLcREy64I/tCHopWpEri5V8nPaRcJWpQMtpJ
 jr6IcmrVvKgvMU198I8qIem2IPNTRAknfai3TzzZLhqTMRMNUc9QQdzx9DJ5TNODIhTl
 48tQ6s5c5BwEeZQK/9YMnrbMQe7kFKbwzuzZmZjuM3hQdJL8WZahRIN+Qe0OG9eYyu6n
 py1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736949024; x=1737553824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BEOF8Hfu+NnUUzyEQczw68/6HXLCAqPr9fHHglkR6Aw=;
 b=emfrpmS/qGkf60HWIG24CAJ6QbC9Mfz/uhZjXkTd0akEbe9aKbN0nt75iCDx2g962z
 vsJcCyKeKYixTtoGpM3FrR646/bjPu8HSn66T5ymO/fQaP8NPuEB/qTwGxid0cm/CU3l
 bpEica7kXMOEYdY9F/dVxllyMD9GLa7aug84gTNGhzAYCbsM/qnZdjrDgp8EaZMCP0k0
 h0dyCOJGL4K9Qtz/28RXDe98qAPMGa2tkIiRIxmJa4VsHMoQKtC0ETJfqUNxct+46hJP
 9Z6QHrms0FdXe9q1qZ8cjOpnsjnJPrtNCM3iYCEDsfqAau6QKMHrKPl2QjgSjP2BBQmo
 7PsA==
X-Gm-Message-State: AOJu0YwUFSRspnU3MgU62j/IOK1NXOpkmimIwHeM45g7G1MT8ydSyf1v
 34W+q6rSufAOWDKuhbrtY5hq19o1xGRoGqnQDdEfeFpQ7/Mzyt5yP/S40DD3Nx3HY5MTLF4E/jN
 MOIE=
X-Gm-Gg: ASbGncs9RUZ6ozDFkzWiYxaFTPKEbF976vO0VjLjeHLp2A0lfZ5gjBTm3dSvuBLHcac
 gnraw7TUZ7J8vyIt58iKta0wZqG7owefjvQ3cHXW2lD+HaK+BRVeumBkYUcLiYtbWmWWypUVQsQ
 iw5pJL5RKQapoMvTE2UCsdZk4wHGxQWH/8QiZfkHLR0QatxOxQC/jPfDfOyprNUhHiqr3AfWZRX
 2YFsMrS5RAGrxIZ3T0V9SXGcNXTAMog31jjRjvqRV5d7xztFWS2JMUooSo=
X-Google-Smtp-Source: AGHT+IHGnp4QoqyWzWFIsKooHgPEVd5Z8XHv37n2e5llQsX1WXszVttQpcrzeDXTjV+74n9FzM+5Ug==
X-Received: by 2002:a05:6808:4491:b0:3eb:47f9:a803 with SMTP id
 5614622812f47-3ef2ec23f39mr17833303b6e.18.1736949024697; 
 Wed, 15 Jan 2025 05:50:24 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f0379eff69sm4952177b6e.41.2025.01.15.05.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:50:23 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 4/6] target/riscv: change priv_ver check in
 validate_profile()
Date: Wed, 15 Jan 2025 10:49:55 -0300
Message-ID: <20250115134957.2179085-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115134957.2179085-1-dbarboza@ventanamicro.com>
References: <20250115134957.2179085-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The S profiles do a priv_ver check during validation to see if the
running priv_ver is compatible with it. This check is done by comparing
if the running priv_ver is equal to the priv_ver the profile specifies.

There is an universe where we added RVA23S64 support based on both
RVA23U64 and RVA22S64 and this error is being thrown:

qemu-system-riscv64: warning: Profile rva22s64 requires
    priv spec v1.12.0, but priv ver v1.13.0 was set

We're enabling RVA22S64 (priv_ver 1.12) as a dependency of RVA23S64
(priv_ver 1.13) and complaining to users about what we did ourselves.

There's no drawback in allowing a profile to run in an env that has a
priv_ver newer than it's required by it. So, like Hiro Nakamura saves
the future by changing the past, change the priv_ver check now to allow
profiles to run in a newer priv_ver. This universe will have one less
warning to deal with.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c9e5a3b580..f5338f43cb 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -746,7 +746,7 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
 #endif
 
     if (profile->priv_spec != RISCV_PROFILE_ATTR_UNUSED &&
-        profile->priv_spec != env->priv_ver) {
+        profile->priv_spec > env->priv_ver) {
         profile_impl = false;
 
         if (send_warn) {
-- 
2.47.1



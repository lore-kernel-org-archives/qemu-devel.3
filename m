Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B997ACCF9E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC55X-0005l5-Gf; Thu, 23 Oct 2025 19:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54z-0005CI-DY
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:50 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54x-0007Ur-OM
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:49 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7a265a02477so1099045b3a.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263445; x=1761868245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxB6FODqYUMK6h1Cfe/8gzhtSOYVOup1m3VIbIjv3uI=;
 b=BdrFxDkm2Am1RqHp3TzsJNhiOrbHeUcVLFzz1JO4RX0HXVZSq4zTz00bM5Os+w13hD
 Us0bpBL3l2d2PVkv39Cp+6CvuOug0CaLzhMX/o2tcynkMGNrOkeBvmYrRRad7nIdGh66
 KdwIlrGVf0YObwbwr5JojRolvYpEIlnGVCGV1B6x9LgiyfhU/i4eqqHnlVOb4okNc7/1
 3mknv0eIEWiIIHsyMjK+bgFt0JQnjDK7duYg5c2Qb1XPXsyUwyydv7wAAS2eM4M9KD0u
 ZSo+wfmeZ+qfP8sIbPqKjuVqd5OaKPEn3uwDW+4cUDylvp8RFMLZUP3fOMbQLHBDrEiU
 Q8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263445; x=1761868245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UxB6FODqYUMK6h1Cfe/8gzhtSOYVOup1m3VIbIjv3uI=;
 b=JtAw1dd8xRh/DYvDszJtQETMqUZLGlwxjdp4Qd+RVJIzWlW1dxqJpmmUDpEGkN+FTA
 6vwN35O1pUnLf68tKN5VSLFFlS3GG/D5KUrp86z7YK6+Lio6nC6B9SaVyZYDDJDJXfpF
 fbNZ4UBODctW1HGDsFkaj8f10lGkl4aSiKyGPKfODCtRXc0ruUt4wNqjVLCNt5mCBg/r
 xXtnXsk8/oQhWS6AbYwzHc6Cgl1fi+eqrpKwwC/1TmiY47bVtd9eY3DhBIHV/Gvl4ffD
 WaIx00IfrkG+nCwaUcyCw4/KbZsrfznoGtsHjGF9cOmC9IUwfZ29Mdms0Zm1MmnMX9Ni
 HYVw==
X-Gm-Message-State: AOJu0YyjO+wL3n6qC52Q11mkyD59Jr906uEf+tVBOEBRFhQ4a5d0+iXc
 1X3deDGMwqiOuKjAdzTiBuno+460n3aZUogqrQnhf+PTXTnxgiUnZVHWhcUwmA==
X-Gm-Gg: ASbGncsl+H5pQBJqWtKPdjRIVd4UWTYN7kIQcpjwrdk26EE+y1pdbkJTqfGkdTxW3oe
 +cyXhjxYxtUvySLmbjj+hJgyegGkI8pgAJj6sVBqG1lNG/uduopn/RZg40yi3ZVS8ACLH/UJxrv
 NoELpibCab8/MD8qXdadfGJKVyIP54vSir3axEz000keLWF0Eew7abKh49cyZUU7OhtpNaM7CXd
 KGZmdtBJ5gcSnuHYgL+VzL6obLHqdwPzNoiTYZqtSOEyUD7aZ2i1D7llV+gdVE34cYBDlCwmkyp
 Qqf9DGiQBXENZEjdwa68+sqtfQXwUQ6tLzQogrXXQ/o4jyDcoX+6i6QqgMXtziHP/U5iQujCq8v
 X9detca/yYDLeX9xSmUjinafE49yTMdo9/DBs7TNY5xWfQmWy+mzB8VMmggMUT//fX33EwujJ/4
 U1jzXKJ286/qftd5frdRomhXTJicSiSn6JgeQVtPStoOnRLO7nMj0+GJYegjRrGwW8KDZa2OtWI
 vQ1dIJtZ5m/7FcZANg=
X-Google-Smtp-Source: AGHT+IFIugu7gOm8M3kPbIfqxZXk/x5TXCbzWhaO/QUASkobAVpLRoNfmZxXix7i2vF4ZPZQxMOWMQ==
X-Received: by 2002:a17:902:e5cc:b0:270:4964:ad82 with SMTP id
 d9443c01a7336-2948ba0d9a1mr2221905ad.38.1761263445041; 
 Thu, 23 Oct 2025 16:50:45 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:50:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 20/25] target/riscv/kvm: fix env->priv setting in
 reset_regs_csr()
Date: Fri, 24 Oct 2025 09:49:22 +1000
Message-ID: <20251023234927.1864284-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

This patch was originally made by Gitlab user Bo Gan (@ganboing) 4
months ago in the context of issue [1]. I asked the author to send a
patch to the mailing list ~3 months ago and got no reply. I'm sending
the patch myself because we already missed 10.1 without this fix.

I'll also just post verbatim Bo Gan comment in the commit msg:

"In RISCV Linux with KVM enabled, gdbstub is broken. The
get_physical_address isn't able to page-walk correctly and resolve the
physical page. This is due to that the vcpu is being treated as starting
in M mode even if KVM enabled. However, with KVM, the vcpu is actually
started in S mode. The mmu_idx will give 3 (M), instead of 1 (S),
resulting in Guest PA == VA (wrong)!"

Set env->priv to PRV_S in kvm_riscv_reset_regs_csr() since the VCPU is
always started in S-mode for KVM.

[1] https://gitlab.com/qemu-project/qemu/-/issues/2991

Cc: qemu-stable@nongnu.org
Closes: https://gitlab.com/qemu-project/qemu/-/issues/2991
Originally-by: Bo Gan (@ganboing in Gitlab)
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251022111105.483992-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 0dd0d59d41..000e44b2b7 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -705,6 +705,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
     env->satp = 0;
     env->scounteren = 0;
     env->senvcfg = 0;
+    env->priv = PRV_S;
 }
 
 static int kvm_riscv_get_regs_fp(CPUState *cs)
-- 
2.51.0



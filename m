Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C28CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBn3h-0003hG-GX; Thu, 23 Oct 2025 00:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3e-0003g9-GP
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:36:14 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3c-0001WF-Iq
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:36:14 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-273a0aeed57so20596225ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761194170; x=1761798970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxB6FODqYUMK6h1Cfe/8gzhtSOYVOup1m3VIbIjv3uI=;
 b=J3SWClr106Xh8+k7wo8YKp/J25/5BRuQXcsl30aFVIcS2Xg/JvEbacI4oJXqoL3wlQ
 IaHUi0+vDo2rWVLNfFoK1LwFSWJcy7pUCHqubFptJJK9G1ZxucP5dX4nIgDhZuxHrGR7
 ohQu+3yAD/63/xaH9g7FxkVIRTMVPFluGdzIvJnHgPqs5PS796fCrLdMiJznZu39YO6d
 RuEfAGUvhZQcKt+szNq3EnUM174lQeUvviJ0EMvccMTbX0KLEqsX/MzICrSKRNNALovg
 el3Hy8T1KRm5KHrHM32G4F6snKe0ASLz0w4b8qu2titdH+MLvh9tXsdmNgguv63jPUh+
 +ybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761194170; x=1761798970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UxB6FODqYUMK6h1Cfe/8gzhtSOYVOup1m3VIbIjv3uI=;
 b=GMAx/HHF9a6q4y9zVzsZthbZy4hPhu5XjL2tXvO48tEaZEpCRzA+QJLIccEhUfU2RY
 rj4lM7T8uSY0T/aDqijMTe56btbOlhfJYqFJBIt13A8Bmi3lFZHrzbropbBRuvBg8sp9
 Qe866kKq7KhhiFlj18kGsnm5w+YoqawJ0DqxzgjsKU7Z/RqxInBPx5i0U9TCRTUN5PgS
 PG3brwU6bgVNgYdaMajjQ0Hcr9TqiySBQ2/Ib1K8R+0WTHa7JLELMMOGyWV1L8CpLcR4
 /FTxMSud4t/ztw9beDiWix8gOR4U0qE2RSFkJfrc0rt5xoF5LWHE9V+CYjiL2riXcvO7
 pj1w==
X-Gm-Message-State: AOJu0YwK4gsxTLgWKiqd2q4usqsonWinOvDMHtG/9IKfe213+1LyNAaa
 wSLBXiUqVYWuq7IXZgVCzXMRz7vvnu17Jfc8s7RlqAlxawY7qv3v1Tn/PJZ6EA==
X-Gm-Gg: ASbGncsU8NDRtNO0Ss8PHefYYMO5w2VLLEgM4Obu4D5h0LLkj+QbKXSvpNeKZFAg8k7
 EOxB0kqKuEhAwhrfMDxxp8qAx69fqWpUQMaPbI9v9TtAH98GWPVA7+fjsOF8IO2bSZd4OcZ4foI
 kS8VQi+TD1DcstaeTASWygIiifeRGdsIgAwepaJGxeysNJLcCxrakrGgymJ5CdlQQg5Swmnlu/M
 nYpneWjzFNiIxGSIjkEGur9JGfZm3/c3ZT/6KkEhNa9mNby1F0VnsAv6JqqmMiGAEriMghDt76U
 UBLdSXUJTd+9Y2SbiC+m/seXizKLaiivJhaRu/sz6oYElgIhyk3prdI2uZYd2YoF0C4xZBaPl0r
 p0x7d/os6CV1ZXCm9oIU3VqXN11Qga7ORh4O/sYYqgOf4RQf9dXsmg7eC8H0P78mHGfJ85zyq1n
 pzcRYqEIyLdh1y+az8COXlrOpjEFcS4iQpH/r18t49r8C7eTluJd4su/xRTjQsz3F1IIVpLlb+e
 RYP2eo3
X-Google-Smtp-Source: AGHT+IEM5mXc+MlNatc11qNshciMEouuiKtrGbqzsWMfhrk9NTzIf+H4S7/KPJSzVHywp8254OkFIA==
X-Received: by 2002:a17:903:41cf:b0:267:99be:628e with SMTP id
 d9443c01a7336-2935dff658dmr47255525ad.2.1761194169925; 
 Wed, 22 Oct 2025 21:36:09 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dfc113csm8643015ad.68.2025.10.22.21.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:36:09 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/37] target/riscv/kvm: fix env->priv setting in
 reset_regs_csr()
Date: Thu, 23 Oct 2025 14:35:15 +1000
Message-ID: <20251023043520.1777130-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023043520.1777130-1-alistair.francis@wdc.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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



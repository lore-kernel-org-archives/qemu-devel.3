Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F390C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 07:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbwyX-0005Cp-9N; Sun, 26 Jan 2025 02:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyI-000549-0G
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:18 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyG-0004IY-6H
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:17 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-29f7b5fbc9aso1208323fac.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 23:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1737876135; x=1738480935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eQFjdJhNxka24LT0P5MCvvpngkXU4jPKMvtCsHELutA=;
 b=haHTllrqvGKORcLj3rwMlXrpO2qlY/fvRcWAA4b/6ae/Sn0AD0xmYvTk983HRTzkVz
 K9kq1uq2ZL1JtK1itUDPlt06bj0zQRAxaWM6MHXtR82q9Y9viaT5GbHAYUZakJ1I+kFf
 1fk00hKmubBRaJbJNS38eiMGfn2xcF/ewsqv+FFO5/NJ40itYDdYYXtTZlkNkOZP3Wl9
 rq4N400GGuy5H3URydtSPYVMNQc10yMGLy8GIgPufw0uL8XEzihTLJq7cKU8aKMUIDzq
 NxC2Y6+ELjeJzUbKE5z0J6ckMfoNBxZNmKqNEhTNz9enGv/QR2ntkGMNeWIJEWH/gf4o
 x8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737876135; x=1738480935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eQFjdJhNxka24LT0P5MCvvpngkXU4jPKMvtCsHELutA=;
 b=eXeh38SQnXf7Q3HHFidTZWQ6D7lLiW2RF+iekuRBfULGhvFEZjiPVdNWO0Hyyiy7Mv
 mv5mRf03dTLxh+RapbGwllI23EaZtQhWVSZxHZp1OPvnI/+F+jxRM+0cRe149RZwoEoS
 ghpgVgLLhmuj52ZLN/p9bKjmKSV7DkDhBI8IADmn+kEnJ29oczGVdOxFFzIGUAcBckLT
 8z5Z9RVrBh3KaAGK6QL06nNuKYF5HhpCdqWpulfbBAr67/9KX0nFswKmPUGJZcnvAm7I
 vRb72pWosYjzCZDRIKfOFguhbYQgeSg11LeT8r7VJ6ubc5eZtbTQIz+YtcVOWxd0lNSj
 lPMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRjRfvESI/xJY4gfgLewKsSVCkJXtoRG1smcZQDMRBgjjd8G06glKz4UFulxK73gn52wAMW0FV0MxH@nongnu.org
X-Gm-Message-State: AOJu0YzJpx/dN2pIGM7VPyDpCs7C+aaUexSjYdyVkbYUL9RMNO7frEbc
 hCdefF48uzKup40/MCZ9UIuxtBmiAs73US5sRpZZUUBJ7SzMWnoRDCtE6PYJf74=
X-Gm-Gg: ASbGncuvlBa/8XwR1AOY1qOkparZ1eLc2kKc0Wcw61+C2eWN0sxdKQRdQyAsfnCdAo5
 IGqXVummgqGXOy8s7mWm8q+w1DXPBvxE7TypN7FADrhoTsfwU8i6/WRV8v6gbylF4NCKsbS75hU
 QDiaEVPfPOfiJ0g+r/229ildIAm0JbAfQkZGXokMW+c0OeB1pHY108mdfsY2UrEph3VQ6pHfUQe
 ccZFU2r3BO6u1c6oI0MD3nNR/aQhjKsAebp7JyI7CqAqtKEgPL7yZcn17I5ABvgX7+4j5HoTAgw
 TRENAy6yJ+VXv2V5WV7w/4DCmhW2I/c+CgW7gEk=
X-Google-Smtp-Source: AGHT+IFNxCoxaEc9cmrHKIONIz8BXh3QQdX/HFAolL00O2ACI5iPu46p4s5HLYyJwujoAWJpjuU3Jw==
X-Received: by 2002:a05:6870:2f14:b0:29e:353b:8f25 with SMTP id
 586e51a60fabf-2b1c0a29375mr18010054fac.12.1737876135003; 
 Sat, 25 Jan 2025 23:22:15 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b28f1d887csm1814281fac.29.2025.01.25.23.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 23:22:14 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 06/12] target/riscv: handle vzext.vf2 form mask and source
 overlap
Date: Sun, 26 Jan 2025 07:20:50 +0000
Message-Id: <20250126072056.4004912-7-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126072056.4004912-1-antonb@tenstorrent.com>
References: <20250126072056.4004912-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=antonb@tenstorrent.com; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index a873536eea..0952bcbe2c 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3631,6 +3631,7 @@ static bool int_ext_check(DisasContext *s, arg_rmr *a, uint8_t div)
         require_align(a->rd, s->lmul) &&
         require_align(a->rs2, s->lmul - div) &&
         require_vm(a->vm, a->rd) &&
+        require_vm(a->vm, a->rs2) &&
         require_noover(a->rd, s->lmul, a->rs2, s->lmul - div);
     return ret;
 }
-- 
2.34.1



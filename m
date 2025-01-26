Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FB1C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 07:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbwyS-0005Af-El; Sun, 26 Jan 2025 02:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyK-00055p-H8
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:21 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyI-0004Kt-Vg
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:20 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5f2e31139d9so1614264eaf.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 23:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1737876137; x=1738480937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HyNQzKnLzp13KDqgzk70aFhYnWG09IKJOEEe7paq7Pk=;
 b=EvJy2pqY2u0KvzwcgVAHsR9VEabnuiZc+CZZr+dyBfiLuDWgLrlD8+R0dJjinJaKSP
 umqfvJgY6ALBVtO19vkn4faFDZKMI9nckw8/wmDZpofYmSmEXFqwpsBNeH8nEQBNvbXQ
 1wbePIIjOqNq7Qk1I8gQhvWNjjFoPp9TOnC1kPOhowaUrxDUmoWSx8eR6kACQbCWBUiT
 ko1q745io6fgnfJMUUo6SugK3hec6GFY0d+qDK3J2OmEZ1LKOLLKg50chEX+A9eNMQB8
 AKEl8NGtjqmZjthgRFjlJpocLXTnCOo2Uy3le+I9ILPOiouuM+dbCA3xG1KCUl2Fv55i
 BEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737876137; x=1738480937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HyNQzKnLzp13KDqgzk70aFhYnWG09IKJOEEe7paq7Pk=;
 b=ErjB8QUnxftCcjfOYZbgBoqgyyNWPHqUlBZBR2x+3xvsv4Q+JpjPi4jmofRxgGHmGd
 yHKe7KpseXVcM/21Umm555dSTgKv2602Uew5e/gnOmkScoXFZ5jGxPcw5odfUAsunRQE
 oOlrjIFoaFYWk1rBPjAFho788Ydo5ZFjXolskUteYgfgU/1dPXeVpSxCIjyOtFNihE3d
 RB26JRfydjRXnUWlbfKJrS8UTUEXkOC2D+bwJOVBx5T2Vt4EjrjvAeiJmNcQhLyr+Iiz
 6NaaS3STVQMUDGgCQ07F8Vdx5nW5sE3LEl+30+afZh1Z/TdLMqeG1GuPjVTWnGoWT1t0
 GucQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3jOqWpHIbD6L0n72YQb2Tzn+Sk4DJ0HPpG+4BSJ3TzntNxG1GfDMb7cKRuyQK6vrza5jAzF/v2y2J@nongnu.org
X-Gm-Message-State: AOJu0YzJat+ULlZ2GL1Tw1C1pg+RL9WXO6N4AdUpPwr43GeyC/4DAqgW
 BOBlzcSnG6D67BayEQ4D9Vqwz4qh3e/hWUSB+uqxu9497Ef1WRP+dPK5uEfSePE=
X-Gm-Gg: ASbGncu78XNmhF7aQN88FQgEk4/b5fHgxnOED7lHx4DIzfVbMjVKzDw9y3UHRYXXU1f
 iqpGFj+8DElPfkAwilzDidLZJ+eBtpMLXuUO7xrEtSEDuyBG6fli+aUb35++JxlWmltSdJuha+C
 +9JyA5hD+K3SuPHQX2Ouwv/RcomFZakYeIDnbGvn7rZGM9zw+7Mqgh8SEDW0SygDfUCPyTkgg2e
 ppJrXnckvqhrwQWSupAx1hnckdoh3RkYkOysaCKYXqVyPQ6KIOWmNS++HyqUKOqt4WxDHOk1g/4
 wofB29+wxN4TEaelfPUBu7aXnSAAR/iRI7k9LbE=
X-Google-Smtp-Source: AGHT+IFXUzyh1JDgZxDfRNSaLT91+CjoUHsqbfZzWFYHw+UfcAKCkoy5kRt0elA12T2NmN9zM6mJwQ==
X-Received: by 2002:a05:6870:5488:b0:29e:3921:b1ea with SMTP id
 586e51a60fabf-2b1c0c4c165mr22151281fac.30.1737876137758; 
 Sat, 25 Jan 2025 23:22:17 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b28f1d887csm1814281fac.29.2025.01.25.23.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 23:22:17 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 09/12] target/riscv: handle vwadd.wv form mask and source
 overlap
Date: Sun, 26 Jan 2025 07:20:53 +0000
Message-Id: <20250126072056.4004912-10-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126072056.4004912-1-antonb@tenstorrent.com>
References: <20250126072056.4004912-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=antonb@tenstorrent.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index 45b2868c54..2309d9abd0 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -548,6 +548,7 @@ static bool vext_check_dss(DisasContext *s, int vd, int vs1, int vs2, int vm)
 static bool vext_check_dds(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
     return vext_check_ds(s, vd, vs1, vm) &&
+           require_vm(vm, vs2) &&
            require_align(vs2, s->lmul + 1);
 }
 
-- 
2.34.1



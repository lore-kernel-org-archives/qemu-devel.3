Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF52C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN79r-00038V-UQ; Thu, 05 Jun 2025 05:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uN79q-000365-0s
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:45:10 -0400
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uN79n-0001xz-Vl
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:45:09 -0400
Received: by mail-vk1-xa41.google.com with SMTP id
 71dfb90a1353d-52f05bb975bso291722e0c.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749116706; x=1749721506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4YDDOS7TdXLcClvvUzO/nswmz8VwaC1Nxx5tlJM6zQ=;
 b=UOyE9nn3q8Sv/S4YDtxBNxjdnk3MwXHX7qMYElEWWqggYuAhhRJCDQobqvA7RAhRSO
 8JkQV6rQCPbMoQgeW0/3CVxvg8lZczp6rjNpd2FVrNZZQTWLAhPbfr9OfxujNKaROLmO
 AFh2Nbczn+A55fejtGZXgpU9AMO9EZ87tcbvGT8u/z3kMrC8jDu7MIAiAz0n4zNPl03A
 qv6845ltdplX1mwOjLiLJVeivWdSor6hb6zXdjzj8fAKNSCSUUYIJI/+7ZLIyn/cSoX9
 5Tcot8wENWbiBL+JmIp1WauNYR/9zidyV+KbuzW5bEkSKGaGGMejK8eeu94phIXrjVBW
 vdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749116706; x=1749721506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4YDDOS7TdXLcClvvUzO/nswmz8VwaC1Nxx5tlJM6zQ=;
 b=wlcutGiuI4MAouywpyvhq6RK1iPMjVyDGl/a8FfdW54sjmfrJ64lAjTxjMN2TDEP/0
 vQmbfrOxLBnDrY2Rv9rEpoZNRQp4mBt/KA4EI8I0oPchvZUQtNXoLx4pZImFmag496+8
 BtxSItL9PF1dfmWwaqtLYvirP6s1wr1ntqOzbnUFfPIrAl+CRu8WFy6SCdVOLrlTBjpW
 WxlxUeGxG1OfK+PZyjs51aoM61CsEZ4EL2N9e+Tn4/q946sdNYo7+Lof777iY7pIrkyB
 PDWkYoOBln7YmmkeQ8usmg+/TZu2g9y/wKjmPnhW6Xe9ZQQDke70u84gyjLjcqd+EfO1
 9OCA==
X-Gm-Message-State: AOJu0Yz8dD88G5moGoarIBTCAEly6aA/tZaI6/5FyVdzYir1DL8edAmJ
 +4htZLKIfN1lVq/jgNrlntwiMryV3LO5WyLmn0JIEF+LFcv4j5s5YRFSd6TnLXDvf4vMvtg+QJK
 GhIsHe9b+5Q==
X-Gm-Gg: ASbGnctBCcIsGkyevICHM69K3sRtlpQSRsIOKrTY35lZDbPEwZBC+L8nWJkf/vues/S
 fQWgIHCZH/nXjJ5Cf78KcrVJcjUXpfroVQbqfV4q2Dj3/B1cIzflLTgcpoXqbC7z9YYDquyvNYH
 FEV0jSkN8ZvQAmRjAVOojEtP3VtmS+sJzWRYxTtstkiqGYMrttujOs/tKQT5YQnrmg7I3zrSYKT
 0JrKKbxLO2Vukn2QFWYYIoktzpTX6SVngNVzabS5yikT13yZoFnqVGIOpxrStQIsIW7NHZCtPF7
 NAMSuSw/Ae2LOUWr9SBN3xfoqFVrTgr3OEdTo6XFXMvxBMCEApxPAtqd0QDEemmFwTOADqlqY21
 UmI4t
X-Google-Smtp-Source: AGHT+IHKKVAzemNkaACkiuVHvRRrBWtmS0txicfpGtCLK/YViBuRhXNQ94XklKoBSEfFYWTQKR+Waw==
X-Received: by 2002:a05:6122:658e:b0:530:626b:7d43 with SMTP id
 71dfb90a1353d-530c73159a7mr5884296e0c.2.1749116706089; 
 Thu, 05 Jun 2025 02:45:06 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87e2a2c28d8sm10063093241.15.2025.06.05.02.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 02:45:05 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/1] target/riscv: use qemu_chr_fe_write_all() in
 DBCN_CONSOLE_WRITE_BYTE
Date: Thu,  5 Jun 2025 06:44:56 -0300
Message-ID: <20250605094456.1385105-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605094456.1385105-1-dbarboza@ventanamicro.com>
References: <20250605094456.1385105-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a41;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vk1-xa41.google.com
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

The SBI spec states, for console write byte:

"This is a blocking SBI call and it will only return after writing the
specified byte to the debug console. It will also return, with
SBI_ERR_FAILED, if there are I/O errors."

Being a blocker call will either succeed writing the byte or error out,
it's feasible to use the blocking qemu_chr_fe_write_all() instead of
qemu_chr_fe_write().

Last but not the least, we will duck possible changes in
qemu_chr_fe_write() where ret = 0 will have a 'zero byte written'
semantic [1] - something that we're not ready to deal in this current
state.

[1] https://lore.kernel.org/qemu-devel/CAFEAcA_kEndvNtw4EHySXWwQPoGs029yAzZGGBcV=zGHaj7KUQ@mail.gmail.com/

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/kvm/kvm-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index e1a04be20f..86724e5c44 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1605,7 +1605,7 @@ static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
         break;
     case SBI_EXT_DBCN_CONSOLE_WRITE_BYTE:
         ch = run->riscv_sbi.args[0];
-        ret = qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
+        ret = qemu_chr_fe_write_all(serial_hd(0)->be, &ch, sizeof(ch));
 
         if (ret < 0) {
             error_report("SBI_EXT_DBCN_CONSOLE_WRITE_BYTE: error when "
-- 
2.49.0



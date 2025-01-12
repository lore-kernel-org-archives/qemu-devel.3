Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B05E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 23:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX79e-00040z-Ur; Sun, 12 Jan 2025 18:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX79c-00040C-Ng
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 18:14:00 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX79a-0003Ua-5J
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 18:13:59 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so38517615e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 15:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736723636; x=1737328436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oozABteIxI7XPtrKYuOVLUO0skNZDenueKboWSaAl8I=;
 b=ukIc3+TcwulAP0A0l6UvQ9oaJzsInEzKE9Y8AKIjKCg3Znl6mqF37jSx1xVmE+HCuM
 JZoL9mR51xpbTq3/cLgSSwllVfKM7yP3wNfaSRwNDWGNuM1YZCY2gEn4uIq78x0Ax5y5
 e2PWjE3pM6aOoq+tiogoHlvaXHxEkjEsz8pJcFpa+kmnFDubjIb8CDECZJntddaVsRFA
 BdAapVJnQtEO2d1gPvObGAjjCs2Rjw3IznxHTu/bJiyFTegoV9lVnpKNqxZAtqz/+SXU
 LTeubW43oHcgm2A6gy8I2FzJ2Om/GvqYcQbNPrBNxlMhOUL3W7vWiy/OYYpFhBaOSe+g
 1xCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736723636; x=1737328436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oozABteIxI7XPtrKYuOVLUO0skNZDenueKboWSaAl8I=;
 b=rGJbSP9vEOpVXiylV07mXgiEK9mXcVpmXadZ+Scb2rffVUPEQgPG0kzpILZ/yioOGS
 YZ92o3OWjMDiYXBVlXjiTgd+VcVIaCchGk0Hbm9qtJwpVT+XlZ5l36wvMrBHMPwGIXab
 IWO2Mcem0moPo97uraMu0Ly2KhEmM4Wa0F7RKdxDmz53lKYW9xcnvRKAfLr+hU6LJktT
 qD00RCg5W+2xKauubRDLHaRIU+pvd6KkIAwCOkAxBkE5BHjxx0BrlvTGTaHZjpRWhoqb
 IYm2dQNep10cNmnOdHl48lMyxB7uWEeLJ85f44TiQKP9vXP9OOMDqlqf4m1cbvVpHr4T
 T1uQ==
X-Gm-Message-State: AOJu0Yx45D7Q7OzENes7J7B7lYhyjna7JnayX2L46Du17/GEnxZgV/K7
 UMTIAXuKCS9V3MjKNac1SeM4afX4y9jxkVKWK86KwKQcw+B1dLiM0Ddbwk03X9vkkMCBsK9U7Ak
 yaYs=
X-Gm-Gg: ASbGncvm6B2+h/dZMnReoJkedo0/sRHIIe2jymZ+JlBfWkfmUscz2tfft0brRee8Y2H
 uPgAtyTBwJ8HMSDalauVBIauzhxRXTEV1X/B6ada3ehv+MhBLdFnqCSeVwjHqyb4Q81Gu1IGPil
 IulKaURgL1De6dnNDUMQtNIXT1metNUFa33CmTe3FrLaoharSno6F3VyC1zbzb/GLjzjWoChxDF
 P9skxPQupspujMYoMuAQ0GW5oijfLKrBPWobERZPmEY+6XYVEIrfTzr48Twe10ZITgIfFmkDCPO
 rn0ZnfsTWVSH1ktdD06xPNMnJYg00+U=
X-Google-Smtp-Source: AGHT+IFzPFA105JTqe0SQq49wNvsRlVe4CPnZO8YKRJ1i34Lz5R3AZo2RsmtMbzUD4DuDKIHEoFtLA==
X-Received: by 2002:a05:600c:138a:b0:434:f0df:9fd with SMTP id
 5b1f17b1804b1-436e2679a1cmr55478715e9.2.1736723635924; 
 Sun, 12 Jan 2025 15:13:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fc5csm125555305e9.2.2025.01.12.15.13.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 15:13:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] hw/riscv/virt: Remove unnecessary use of &first_cpu
Date: Mon, 13 Jan 2025 00:13:44 +0100
Message-ID: <20250112231344.34632-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112231344.34632-1-philmd@linaro.org>
References: <20250112231344.34632-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

virt_machine_init() creates the HARTs vCPUs, then later
virt_machine_done() calls create_fdt_sockets(), so the
latter has access to the first vCPU via:

  RISCVVirtState {
    RISCVHartArrayState {
      RISCVCPU *harts;
      ...

    } soc[VIRT_SOCKETS_MAX];
    ...

  } s;

Directly use that instead of the &first_cpu global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9e8876be29b..241389d72f8 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -750,7 +750,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
     qemu_fdt_add_subnode(ms->fdt, "/cpus");
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
                           kvm_enabled() ?
-                          kvm_riscv_get_timebase_frequency(RISCV_CPU(first_cpu)) :
+                          kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
                           RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBF5C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggie-0007D9-Oe; Mon, 06 Jul 2026 06:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiT-00076S-LU
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:24 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiR-0003RD-DD
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493ce08a75bso11700425e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334298; x=1783939098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mMkiwEUG4Wl0/WEutzF4slqN/GL92jnEWOIdJPN4nXk=;
 b=rJZAKyOMruq8OZ0VnSZ2CsHwpuatgTXC6Lmy6LX33XjklxtliCiq4FP4nCKdUf02GZ
 8TmhhxaVPEWlAfJSrB+9ZrMzTld8JumNnZ/0QPR0JwG3HjlrW0a8yqpJ6n3SJZzYfHeV
 yu06D8Qz3pgfpQ4/MrOm0EXVR7CCJZg1a2xEFyqOl5MLX6YuBamnKhu0rUBGmkp8oIrF
 WW2cg0UWSbf6Vzt+YGi9FvxCwtcT46WPTbt/jRw2w8Zm6PbS1B5Hw8w/CWfnRczmw0/k
 XbgIp3Kb5LowwgHgFqRPJPb4EcJPWxLQJPkrjgfyPS4DrTakmAf0fSswAGaStMimpnlh
 ZKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334298; x=1783939098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mMkiwEUG4Wl0/WEutzF4slqN/GL92jnEWOIdJPN4nXk=;
 b=jEVj9da4xguRufDUdf7H+fGmqzkGKJtjLhMPZPthFYVDHyqvFHd5gJBdryN81f+FmQ
 rUkDFnkosal2vVM1JPj5AKuxyiQdFFoeD/qeiAe+GjtVeR4ukfNgSHF/IHbVb/8WnyCN
 fduNo/iOQo9NUkfjzZmAzaTfeQ5xqeAppwh6L0q5Tv8eE8nBVOeQkiGUx3FaGQtzRuHE
 mJxf26KBZtXktr6EfaUtVXWIr2GhmAS6JgiFcaWg63KOMDkWr7Bl6CpwcBa/fxo+awJQ
 K1fwcBkgaxfUG6jT21B9b5XRcCfVjG3nYXHZTn//XOjsqoDOZC2E/yIH+gEHoSW/WyRC
 PS5Q==
X-Gm-Message-State: AOJu0YwExit7WZRseTsJzfe+2E/l+/oOCFknVx8aPr+28xA06kaTN5It
 4sdXTWyvhiRAtFw1fDeHcQ6+RAKZzBMpj+GSLSgJcHo0RHOGgmB0sjcfYwU7ZzIUMzXfRruBnQB
 IUanpvBPvAQ==
X-Gm-Gg: AfdE7cmKaNImATKsbU/RxDbSHJ8qDUI6N6W4JTyPgiHBt+cUWdHUP+7t17AmM30p7u3
 vQz/UBjyT4NRVJe7WgBwF0wMD099Lapb00v9kyGnPgJgAQD64X/LcHREd5ak0wGZ5FRxT8g9yZP
 py6D/OC5Znq95NGAGmdV6sg4wh684eOGDllxla8kwFGy42Jvva20/4sb2KeJCrmHQ543nmXrOI1
 W+zb+8wz/5fBAV1hYxHWu0f22eV3hZIRz80z0Z+kWB4JSE8snKtmDngqNVotLlFe9zBOMkjKTmF
 Q0OpNH3BjByBz5LgxMaKJMzWBbCrHMOX95nE4y/f+zrL/d5URXXOZT16uM6lp1zw9u5RD0G25Yd
 AnP6CHtofNtrpFAPVDsspBwaQLOrUflEVP8v7w03TrjZtATxHwuLBd5ujNEBPv40ASckmO46KJ2
 n5VkEz/MBZjxNi6QPjl2p6w6YhRc7atV6vnsDtPf8eDcCNv2Xl/O5ljihGJOvxW6JJ01mYpVXPR
 6r78DxEsjA7GGUQTR/DrkBGr3uLHQvc
X-Received: by 2002:a05:600c:190c:b0:493:c633:9cf1 with SMTP id
 5b1f17b1804b1-493d3c17832mr92178385e9.3.1783334297674; 
 Mon, 06 Jul 2026 03:38:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/49] hw/nvram/fw_cfg: Document fw_cfg_init_mem_nodma()
Date: Mon,  6 Jul 2026 11:37:25 +0100
Message-ID: <20260706103752.320511-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The last few commits have added doc comments for all the fw_cfg_init*
functions except for fw_cfg_init_mem_nodma().  Fill in the gap by
adding a doc comment for it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Message-id: 20260529174639.451353-6-peter.maydell@linaro.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/nvram/fw_cfg.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index be3fb5f8aa..b75858025f 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -320,6 +320,24 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
  * Returns the device object.
  */
 FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, AddressSpace *dma_as);
+
+/**
+ * fw_cfg_init_mem_nodma:
+ *
+ * @ctl_addr: address of the selector register
+ * @data_addr: address of the data address
+ * @data_width: width of the data register in bytes
+ *
+ * Create a fw_cfg device without DMA support, and map its
+ * registers at the specified addresses.
+ *
+ * Do not use this function in code for a board type that didn't
+ * already support the fw_cfg device. All new board types should
+ * include DMA support and use the standard register layout -- use
+ * fw_cfg_init_mem_dma() instead.
+ *
+ * Returns the device object.
+ */
 FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
                                   unsigned data_width);
 /**
-- 
2.43.0



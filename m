Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CD9E7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSimO-0004Ox-M9; Tue, 31 Dec 2024 15:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimN-0004H6-6z
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:51 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimL-0000uc-Jg
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:50 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so69922665e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676628; x=1736281428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+dgLv0wfL6nmroxZWYAcgcYxnsCqWNeqAXHsqfOxaI=;
 b=jvX29wyKK3tGQOQgtk53IBoo8SPFil2jYdUZBj7cPfMX8avp0aSuB+aL206il0X+2p
 bmbE/bgd+pFWOie6dxRV6cW4/9Wu16RHD81WpoCDaXfi3gDtZNIkRJaXnYdbnTuEJ8Wd
 9AJA90c1NvIu0RC7RXr9BIWQBuTFKFdE9lR+TXCY0h7cEFNgEwLRLxNJi91cBoQ2O0Yn
 C8CnlAiCl4qYfW1q44NRMQEneSrX1f6VL5ayD9DW5jjgKxsNoM6AQJFbrAYQxenmulZa
 0hAuab0BjrbXtH8cDeL6uM0PwSr9p28XkzIy1VlmyfSNwut2okArSABgrx3TiirMwfNE
 TU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676628; x=1736281428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F+dgLv0wfL6nmroxZWYAcgcYxnsCqWNeqAXHsqfOxaI=;
 b=kZ9YehmptE+eVy8O0rxzfWe/eRycB694a4VDhDR29S1BWhQhnCO6xwc/1aA9iqRFCe
 LPPRMVjKcAOVEhE6t5FvtsorCNYpbI4IFv7xnH1QHCEFH0uhO4YDL6v+cBiSGx8P4dkx
 lARX/XPDRFfvnx6AF4/xn+X+KPF/hjQ4gpFyCAcCkbAwIxGBn1DuxzY7qWzSg+Z3tfMW
 48JJZtzZMqD9iXgPhKgmlQRRWdUQh2SLDcdq49CipVZyK2gSSYaIGF2H3GRX//Wk8Poa
 SLLe2KMkBkceys/THxdW7A/i5YW41hdErGWPaK5GFz7Go5t0pS3Y/ie5hWmhfiPGqmmO
 Smng==
X-Gm-Message-State: AOJu0YzydrszRHdw+FqFUPcKZNC5tmnRydwr3SI8d4/VJRMdqOcKIgR1
 ntVsxxzkJ2fZLtyyMFPInz5OYgbPoB/wqNvDB8NROVQLySaKDwlAfr8auw0nAEG7ZkU3cHt4S44
 ewLk=
X-Gm-Gg: ASbGncuE1R1Qo7bTZuUCDdHLywy3jZ+zIc2cp3O+M4E4H7ztLsD+SKUGlgW0ikQMKLk
 0nfExNhF3pLZxZhCjxPmjIIUVftrSw9RTpcWA7GH8RlpSd2Rh0zwWPpMk5cAKqSrvQmYJoBJ3xN
 cbbYNbS3FSJJ7L0hiFX68v+SdGPQeL1F7bAlKQVkKd0sDmb1iBw3ui7Ok8RWLqIH7DFGTXKU4L9
 8g93C3s6Ec/8xknBc+7T86HU2ZIzOeo0GWVX3p6FOhlcTtxd7A4j/xerWnR1Ge2JUigv86D41Xb
 2kpXX26veS+5BwcK7VPMLpWbxvviuMA=
X-Google-Smtp-Source: AGHT+IExsWQH0Ln2GC9kmR6bPdja2j1rS9+RcjfhJ6KeyiN4dV8kaaN0090Fe5UhHWry8Zmwen8+3w==
X-Received: by 2002:a05:600c:4ec9:b0:436:51bb:7a43 with SMTP id
 5b1f17b1804b1-4366854852dmr339650865e9.5.1735676627765; 
 Tue, 31 Dec 2024 12:23:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e375sm34171659f8f.73.2024.12.31.12.23.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:23:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 chenxiang <chenxiang66@hisilicon.com>, Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/29] fw_cfg: Don't set callback_opaque NULL in
 fw_cfg_modify_bytes_read()
Date: Tue, 31 Dec 2024 21:22:15 +0100
Message-ID: <20241231202228.28819-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

On arm/virt platform, Chen Xiang reported a Guest crash while
attempting the below steps,

1. Launch the Guest with nvdimm=on
2. Hot-add a NVDIMM dev
3. Reboot
4. Guest boots fine.
5. Reboot again.
6. Guest boot fails.

QEMU_EFI reports the below error:
ProcessCmdAddPointer: invalid pointer value in "etc/acpi/tables"
OnRootBridgesConnected: InstallAcpiTables: Protocol Error

Debugging shows that on first reboot(after hot adding NVDIMM),
Qemu updates the etc/table-loader len,

qemu_ram_resize()
  fw_cfg_modify_file()
     fw_cfg_modify_bytes_read()

And in fw_cfg_modify_bytes_read() we set the "callback_opaque" for
the key entry to NULL. Because of this, on the second reboot,
virt_acpi_build_update() is called with a NULL "build_state" and
returns without updating the ACPI tables. This seems to be
upsetting the firmware.

To fix this, don't change the callback_opaque in fw_cfg_modify_bytes_read().

Fixes: bdbb5b1706d165 ("fw_cfg: add fw_cfg_machine_reset function")
Reported-by: chenxiang <chenxiang66@hisilicon.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20241203131806.37548-1-shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvram/fw_cfg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index c5537166d97..a757939cfb7 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -729,7 +729,6 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s, uint16_t key,
     ptr = s->entries[arch][key].data;
     s->entries[arch][key].data = data;
     s->entries[arch][key].len = len;
-    s->entries[arch][key].callback_opaque = NULL;
     s->entries[arch][key].allow_write = false;
 
     return ptr;
-- 
2.47.1



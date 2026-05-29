Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4A4CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 17:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT1IS-00037S-5t; Fri, 29 May 2026 13:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wT1IN-00036i-Mc
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:46:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wT1IM-0001fr-6p
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:46:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so75296375e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780076812; x=1780681612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AhGMFct1diYo4gUZrT3/29poPBrHO01q91DGFEApbU=;
 b=m8FU8gCncc/hTdJE23idNz/e9tBEGzCfyO+D4d/eH9cz6s6GqiDiQQiXoxWEfk2Dx4
 ELEmwC16MgriP0ONclNRqkfIO9yr4eyPXONPqZCqxCYd/6quBp/ExMK1RZ95GZ6dc31v
 U8I/JU9sHSpBXrANBBAelt04Qr83E4dTYkb1wTKjxQxU2LcpdDjF7bt7bH3KRyOUwxXu
 D+rvTU7HLTujELynBViEf1XdZgJ6bYM6yWRF6T9qTdoz0WKyI5vHq5yKTJVeeWgbTYk9
 Ek8fEAzSmoNeG7BlL+a2ho9Syp452cUO+HxJVeiuI6I1tuuO3wLF9ZzlBR2vCglNa8zD
 fukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780076812; x=1780681612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3AhGMFct1diYo4gUZrT3/29poPBrHO01q91DGFEApbU=;
 b=m2qB2qr8wrJU/Cf5bbA6e5AZWUZUYlxx4XftcYwY9AFx7pgjbYJe6WCisRV7xhbKlY
 7AR0y/XWqkoqskNbWJpPgltqFSu6WcTPGBBPDjqopSzmmOUTSReMkkfD7CvlJG8J/kBx
 NgNnQAyvBj6/XV6I8ZFtXpQ06ClYqfZJppBSWNRn2fwKUwhPIHuqVcgMJlLBoGg9eRj4
 /UPXWTx0gLJY7pK4RXzdP9CyHmsE3pN0yilZ4VhXUOMvrOTYXHqpRDGEyUWo+GhsSDDd
 sP5y9wSe/pl4KbUlf9DYGOV69vw4AQ+C+1Y5tpcJAuPyQZA351S9diXeRz4DxNYkjpMI
 QOwA==
X-Gm-Message-State: AOJu0YzNjvNEdsFB9WMYlEdr3suHHu4KqLZGPGAHZ7QdChqQbKBCK/Zi
 4GNYcg4JEX6KeOFRZQxdPkj3lU5B3aQh9dm2FcEQqGysdrLucG4n9QVQBS/nb2umx9OvcdGiesH
 UUiuJ
X-Gm-Gg: Acq92OHiv90jyC4Im4q5arrBNMUZR3R3Pw0WXwy9s1773FW9nXrHw3CAdkrkwpyjKIU
 4k1LqRwA3aqL5EgNUrO2ESRTSlFkGfXmS0QTlMIIbQoAFV1nTN4KNqQXot50owOkW5rpDYH4QBq
 8aB5C4GGQxmTCxNqozQXKffoGKsRE6cAtoxgtg9VL/AFKchG/7S0ESgJWqUpLCsL066pKi3l2dz
 U6Lve6FkWu5eZcDUI68g61JBcEhEVoB3kArFAZ1Y2/T3Ep2IT+dijw5PO7mBdnFGgTzeoq/8M+0
 ai+u3i3m4+1hobFTZvZg37OJ2INHFQfGM5ZBeWYzYvcEqoSbptOFA1/T4mOLqZlA2Q2nVCYcXZ4
 iSMn5bc/lGwhKPaeXTHBBq6yjL8iym8CyaKAwHK2BqQ5pxLUlBwmEq+nW8J7h4eXinXtap5JRY7
 jxwG2Pmoa36+y7NZPoBxlAQvBhx6PR/eaLzsaI3O47DQNwCXtepQvNw4p9QnmNCmfJynZm0THI/
 uxS3ta6nZdUCptMtK1PPnFrddzFefzIaemM66DefiI=
X-Received: by 2002:a05:600c:3b26:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-490a2a7005bmr4934495e9.14.1780076811882; 
 Fri, 29 May 2026 10:46:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0aa24bsm18668895e9.9.2026.05.29.10.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:46:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH 5/5] hw/nvram/fw_cfg: Document fw_cfg_init_mem_nodma()
Date: Fri, 29 May 2026 18:46:39 +0100
Message-ID: <20260529174639.451353-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529174639.451353-1-peter.maydell@linaro.org>
References: <20260529174639.451353-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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



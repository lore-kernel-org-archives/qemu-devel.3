Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2297DC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdVb-0004QT-En; Tue, 04 Mar 2025 20:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUI-00021w-8t
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:55 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUG-00079J-M7
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:54 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bcad638efso10144815e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137831; x=1741742631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnAwaBdhJN/kNZhyvNDoVKLIcUFbc7BOsa1ZC7/+qgE=;
 b=ckD8q9cCjeg07PFn5jvflfQRaryZPLVyiyMTnrDScblq4oZfVB7/qjFD54p+fU08Oq
 2FtE90CgjjcNcS3KK05g8kqFV0m3pj5Pth/8iU9exYyZu51TMgOS8oIoy1tyMp2mwKYH
 Vh/CzpeGOabTwusaruXBzUvEQGqayGJ/RMju39w/HXdDNwjxqaO9z3GCYUsxFhgAwH/B
 Arvr3v3/3vDReg5mOzKfYit+3plxYzJiS9Y3is84moqWyGNuET8+CBM2oTkEXIxZGbez
 yffAFcyP91Yxs3jazH1c9gQPalEP1uV630ORxFxQp7aqSRb7jqrTL1oHrYyZ926Rmz6k
 sVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137831; x=1741742631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnAwaBdhJN/kNZhyvNDoVKLIcUFbc7BOsa1ZC7/+qgE=;
 b=aXMwooP8B0sIt51phEjp8bnZnwsZpdHMLzbT+XaBmA9tkzHy0APVqlMwWW9U6PLXlt
 8daVNz7BVz7NaCLqTvW0QEDBvrQCNp3A9RAHTVUi91UpHHfCYNOa6Qsdbr/oi+ep64lo
 ubGa+EJXO3D+fiaxMHS/ku5RFICvr+eisWYpW7pzdUoS0nSIwVcPiUkHlPzei2CtKNKD
 9y09J0FMLVxDXHgytEitlPqnyrHubQ6pUIneoFPR3yXGwilxA50E/bW84sShjXsMVZ+O
 Fn709MBRvzQoNOXuI3jBHexGGyTMBipyeWsr/SnqJk2sis3XS7/aMCOTUonaJG6E3do0
 EkvQ==
X-Gm-Message-State: AOJu0YzqhoMwrdd61TksbE6cl5nu2+WlhzILdHMEtWGGEoXp2AuVz0SJ
 I3Gt5dpDUYnxUIbSG9Qyjm2gYpQRsV73W0j0i4JwTYKhGhXrirlJ4/h4yCdck2RSbKGJPD9QC69
 RioM=
X-Gm-Gg: ASbGncvSp2GAX3XleuOzwew8sEfdjrNKQgxFLppKtySYu6DnKXCBfpbKUDnScdbmaif
 MqfcAaM5PaQIrBJE0SYPIY+7m86oJYRmDAEYBAQXR9F160+ORkLaE5ejCfMkMxQF+S04Lu19QSr
 0DxswN1tFaMvtVGx5S6sDc+nUaEuARpJorwqFw/F+bjFdZBr7rkulMwMCsJLT2tQrORyWOuzp44
 2R2nXdb7KIsiZLffFvzZiMl51tLyy3oRmOqj+ok2a3qn83XgwLbeoREWb2EWbTpKifdchcA9Iud
 +gTNjC8Hh9LO1zr8q/H+zkOsbeYyM2ut3YhidFPJbWhPBQy4Xt1sIm8T2RPaSTpsEZRnuZqkLdu
 QZ+5vyEIlwM0ZkotHowk=
X-Google-Smtp-Source: AGHT+IHQjFcVkrER2JAN0yrKdDyhp69G7z/M3MsPPRTR3N81lST5vwanaLoZdXDVR9aUVwms6Ax5sg==
X-Received: by 2002:a05:6000:156d:b0:391:10c5:d1a9 with SMTP id
 ffacd0b85a97d-3911f76e3a4mr736504f8f.31.1741137830987; 
 Tue, 04 Mar 2025 17:23:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795962sm19846140f8f.13.2025.03.04.17.23.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:23:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/41] hw/char/bcm2835_aux: Really use RX FIFO depth
Date: Wed,  5 Mar 2025 02:21:38 +0100
Message-ID: <20250305012157.96463-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

While we model a 8-elements RX FIFO since the BCM2835 AUX model
was introduced in commit 97398d900ca ("bcm2835_aux: add emulation
of BCM2835 AUX block") we only read 1 char at a time!

Have the IOCanReadHandler handler return how many elements are
available, and use that in the IOReadHandler handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250220092903.3726-6-philmd@linaro.org>
---
 hw/char/bcm2835_aux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 73ad5934067..c6e7eccf7dd 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -221,7 +221,7 @@ static int bcm2835_aux_can_receive(void *opaque)
 {
     BCM2835AuxState *s = opaque;
 
-    return s->read_count < BCM2835_AUX_RX_FIFO_LEN;
+    return BCM2835_AUX_RX_FIFO_LEN - s->read_count;
 }
 
 static void bcm2835_aux_put_fifo(void *opaque, uint8_t value)
@@ -243,7 +243,9 @@ static void bcm2835_aux_put_fifo(void *opaque, uint8_t value)
 
 static void bcm2835_aux_receive(void *opaque, const uint8_t *buf, int size)
 {
-    bcm2835_aux_put_fifo(opaque, *buf);
+    for (int i = 0; i < size; i++) {
+        bcm2835_aux_put_fifo(opaque, buf[i]);
+    }
 }
 
 static const MemoryRegionOps bcm2835_aux_ops = {
-- 
2.47.1



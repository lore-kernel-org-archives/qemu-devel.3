Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38319C282DC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdV3-0003oI-HN; Tue, 04 Mar 2025 20:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdU4-0001L7-TG
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:40 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdU3-00077N-5j
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:40 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43bc638686eso1801335e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137817; x=1741742617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LY4o8wZMDwjmmvlDp+QFAxvztgqIF0167Zll+crzCoA=;
 b=IkcZV7oZFTXWk+kM7I7vnX2hNI+yA3huw0FyyrrTevQ8ZiumVWC+9wQaX/cSXoOByc
 YL/B9bisFooyO+C/REdtfKpLmT4dn2nlh5S4b8AMnqfvtQbmivpgjdhIrZZoAkHlIIX3
 xpK4X3MHODMmNwQpl5TnRUe4mcLlVNFSr7TCu+K39D8jEtFvEY14lV4a8ZP67jG4eF42
 Xv8MXmpLDX30bT4TI9SZpX1xCSaEYsacEWiGMjKgYX6kve2PhudzUegZP8r4/topwg2d
 6MjawXghSl++BmsmGBFeV9A1g/IRDRFnCbNDpCaZ7z880qpGzd5FPcwGp0lUWOUjRfZa
 Pe3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137817; x=1741742617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LY4o8wZMDwjmmvlDp+QFAxvztgqIF0167Zll+crzCoA=;
 b=GlTCl7Rjl379bymYv/ksEM3GsjMlGfwVoJK9iTjr/U8I2Wqbe0aw/KNvhJ/UMsSHfF
 nBpZBBiFymxKAxKvBaEADp/KM5QwkOWflTEHJbXwvq1aYGEgbOFWTcHI6488Z7mxhrph
 kM1ocg0+oUu/7TnZMLzm8K6QW4bv3tjM6UjRu/Xi1Nm33CNH7ouBApUo9gE9JpZ54CAc
 86TvZq+OghUMdb8DGvJQ37WRlrb4Gz+KPONTicY5EzmwIOtT/5momVe1DYnw+oxWyBTV
 Kfi01W2IkIZJvfncPhyFHheUDXfLkWbXsMBzAH0DnYN7RF+8h1Q1oEA/7ixWT1S6bYdT
 Nx5A==
X-Gm-Message-State: AOJu0YwAbS3UabvaPZT+YM5KOFIU/zpl18bFaactiCnTvPp2AhIOmfTv
 50ngCIzl0lpzDkkDnclQPfozE02u6fYDaBQGpg5EaDdrcVanp2sXEgiQgjOu2AHM5DjBAlZ6xek
 PHhM=
X-Gm-Gg: ASbGnctm4cIDC3c878VpHWX1P+wdTTFd52s1sDbwdNrSXXWJvb5FB2UCNJYfXNIm+32
 7QP4wF4OR3aFx4vDiN9x2FEz9PH3UxRJv2MY1psMn9arBSQha5fGi1O51DJwSXqHy7Sb5CFVuNQ
 Dhueg1hLPSBPkCK/C1j3QV8aSiu4kQbxcKlKNGog565CMxtsv7/AEp1TU1kfGbWfrEtjArHHeo5
 pEK/qKIXFpmDuCn+gNBUmk4v3LTPxuPCnLfMDbqBfAKHbqyVeIirnNczJJUSe/aRifJETYynAYR
 bKaq70gAMlrnV1UBIFa36TwsxbtbQfycOIvzac7jgaj+Y4JE0l2NTf6jfZehw1Q7agS20bVz1YV
 cpEM2bBfJlXCktnGDzww=
X-Google-Smtp-Source: AGHT+IGNwDSmTBiLS5JzWxPSHWVAvnh6RqPhuL4XS6c3mv82/VAQJS4rzee4Y0fdrHHe3YPLZinHrA==
X-Received: by 2002:a5d:588a:0:b0:391:865:5a93 with SMTP id
 ffacd0b85a97d-3911ea4130amr856807f8f.22.1741137817331; 
 Tue, 04 Mar 2025 17:23:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485ddedsm18938636f8f.89.2025.03.04.17.23.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:23:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/41] hw/char/pl011: Simplify a bit pl011_can_receive()
Date: Wed,  5 Mar 2025 02:21:35 +0100
Message-ID: <20250305012157.96463-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Introduce 'fifo_depth' and 'fifo_available' local variables
to better express the 'r' variable use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250220092903.3726-3-philmd@linaro.org>
---
 hw/char/pl011.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 12a2d4bc7bd..5bb83c54216 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -486,7 +486,9 @@ static void pl011_write(void *opaque, hwaddr offset,
 static int pl011_can_receive(void *opaque)
 {
     PL011State *s = (PL011State *)opaque;
-    int r;
+    unsigned fifo_depth = pl011_get_fifo_depth(s);
+    unsigned fifo_available = fifo_depth - s->read_count;
+    int r = fifo_available ? 1 : 0;
 
     if (!(s->cr & CR_UARTEN)) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -496,7 +498,6 @@ static int pl011_can_receive(void *opaque)
         qemu_log_mask(LOG_GUEST_ERROR,
                       "PL011 receiving data on disabled RX UART\n");
     }
-    r = s->read_count < pl011_get_fifo_depth(s);
     trace_pl011_can_receive(s->lcr, s->read_count, r);
     return r;
 }
-- 
2.47.1



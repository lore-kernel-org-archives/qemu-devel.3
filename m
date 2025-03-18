Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CD8C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWjo-0002Xk-Sf; Tue, 18 Mar 2025 09:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWiq-0001ts-J1; Tue, 18 Mar 2025 09:11:09 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWio-0003la-Fc; Tue, 18 Mar 2025 09:11:08 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-30bae572157so56630771fa.3; 
 Tue, 18 Mar 2025 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303463; x=1742908263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cc1uZY19mfyr0bTj71wtNtnhiaEWQlAkAZt8nIkpWE=;
 b=jVIBAN+urq1B3opUxjK+RiS0Mw84yZSlhTkeH21Dt8JljuVUGDc8dtpnArGHhDg/xF
 hWQfpueJD1SBN2tdvwAiLZzHKFwEwTg4VV8v2wGWaH2brneLCnEJ5aSxq41s8Bgj11Hv
 DTgkbMG8tE+3pvNdnSHYGKM1PZze6woKeE0obMWGN2lRRkSxulrFcNs7ABOEq812vznE
 rX1QgZqZ3m94zY6KoJZyVNmKeAITfwRhTXNMD0Xq0rXN8bDi6jMF/84lS87NJ0mEvBqx
 j9cBB+JvY+3fI8/AjAR758w3uT6anW01VnB1ZFU1rzcPbhMkU8NN3qdhBqaSy6nnCjko
 bdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303463; x=1742908263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cc1uZY19mfyr0bTj71wtNtnhiaEWQlAkAZt8nIkpWE=;
 b=rP0DLie17Q/nrlaF4Jg8Bod2uNEcnzUFUIt4GUebEaSEArkTiZ+CnzbzsSFnTlsgep
 AvLfQT2QlfFZYnTKGjFKSshfsVyVkSZ/PrPfQBibkJeIE06/4zH/hwXKkQUtac2l0YCb
 GNaggENddXOC+WQmrtnD66X6G4SJmjgtOq3hBtmSSU0Ms0svG6oBxPKU/ZLQC4ACNdnL
 IKLcSzTNbYB8Gn4s9WlOuBm4TFiCghYZWlC9PB4KcKZXT5QyNxkAuga48G4eH9KCKwxV
 VBuNDliakErM9BKL03EzywOIZL5usz3kCwT4bdtiut8ycVPgR8qwpDULI9jgj4VBaW7D
 2fvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDgxnWT26+ppWU0iy0/kAalcuYnKZXnuz++sMPJ/fkKyiXtbRf8db6+ujBypUPrTuFQWFAEUtqtg==@nongnu.org
X-Gm-Message-State: AOJu0Yxy9hjnmL6lVKqTGdxotiANjZQ2u9uGTuybCsNn83/Jo4RadX7a
 WAwoFfFMhaXVo5sPwLk0bDv3KsHI6zwl0orH7IDKJ4nk4DoZc5f8ArAeaCdL
X-Gm-Gg: ASbGnctjCwuFLjPSpwWK7VRljXOLlb6+uy0BdeBoMByYfPWz+hronSfc8Nbj1OxRqvW
 +Ux6MupfcPloOMRkirlhzcJ9ShD3OBrdiAPDOJQelM4lrXFWQfn158eaBw7+4dPPNHSQLSZ47b9
 oATZJfXfMQmRWzIWaJUR8i3/YxghJ1dKH5iCvCveR24QQUx7b4kO9ShW3e0EfX6WFW3nDLGk8zO
 e7FXhpREOjZ5IiZwecmUvtvRqZSUsoKnFzdCQ1vDGx1d+mYm40n2hveJU+iSir6Ikh7lQfQcjVy
 j+EMI9cGRMg3AZ3PcgvvEbX3zegzVg2/wXRmU6WB5mglKRnjEeB+NjgVpJ+0xPGXex0=
X-Google-Smtp-Source: AGHT+IHwT1XLLORMDllqjLTe01RDYTLtyhmLqkNxCh58gk3HHiNRNQAqN7J99vv+LnWYu2+dINHGgw==
X-Received: by 2002:a17:907:97d3:b0:ac3:cff:80f1 with SMTP id
 a640c23a62f3a-ac3303e70e3mr1680550766b.54.1742303442070; 
 Tue, 18 Mar 2025 06:10:42 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:10:39 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>, YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH 08/21] hw/dma/zynq-devcfg: Fix register memory
Date: Tue, 18 Mar 2025 14:07:59 +0100
Message-ID: <20250318130817.119636-9-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318130817.119636-1-corvin.koehne@gmail.com>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=corvin.koehne@gmail.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

Registers are always 32 bit aligned. R_MAX is not the maximum
register address, it is the maximum register number. The memory
size can be determined by 4 * R_MAX.

Currently every register with an offset bigger than 0x40 will be
ignored, because the memory size is set wrong. This effects the
MCTRL register and makes it useless. This commit restores the
correct behaviour.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index c595d090fa..24461677ef 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -400,7 +400,7 @@ static void xlnx_zynq_devcfg_init(Object *obj)
                               s->regs_info, s->regs,
                               &xlnx_zynq_devcfg_reg_ops,
                               XLNX_ZYNQ_DEVCFG_ERR_DEBUG,
-                              XLNX_ZYNQ_DEVCFG_R_MAX);
+                              XLNX_ZYNQ_DEVCFG_R_MAX * 4);
     memory_region_add_subregion(&s->iomem,
                                 A_CTRL,
                                 &reg_array->mem);
-- 
2.49.0



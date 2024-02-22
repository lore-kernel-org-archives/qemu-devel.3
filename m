Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5F5C54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvC-0007Lg-1F; Thu, 22 Feb 2024 15:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFv7-0007FJ-FA
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:53 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFv4-0002fz-7Y
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:52 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc09556599so1893345ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634629; x=1709239429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9UuugcteI3wsnFXZ+gvu7oCS1Hb/WPFzjY9R5VsQ974=;
 b=aiM9tOI62KtGtR2JFQ3MF1GeIN7slAOqzVwX6Rob7pkxFNjB3uWjMfynuv+eUFYMGW
 KjXRqGB2eMBUBESL2/KKREiaOGDZ9AUR3qOFIHP4p9ZfvxpUvP8/xEdbGRFB65rHUhOJ
 fUG19UVzt491J1rPEuEoqLllh93B4GjsAM2RAEmzOZ23nTp0Y1gR2h+QZ5rkCY3nqoPU
 FVM3GKrYwFCwVU0kLIDyxZAqxkqggJBVS537DVk9+7knu44M/Da36eNJumuIgsBY6Lyq
 UHQ7C/+QDlVCkpzJrR6rriPpG6OAoSozrJLq2Iuu/Ze2rQFLq8BvtWFFNkI95qdOySdR
 92xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634629; x=1709239429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9UuugcteI3wsnFXZ+gvu7oCS1Hb/WPFzjY9R5VsQ974=;
 b=CcEe27B4MwqLSl9Dgiqn+qWK+uMAErPwNyGTWdgjsrLHaKZdKpL4bwPKvIvR97yN08
 eOcr6tuE7wEfjxHI2yLhPT7wJX502fMhNwya7bORlV5XWlaCHJZX+Jqj9LuflI/Bx6WJ
 aK9trafHSRBw3sM8kg8xBu9DeYFyDzZUVrxW09GJHOFgNdzemTpSiCvYXJEeTrnjEF0n
 YZ2pGgcZIAtEtVyXonpBakMHdCUlyl5wjcIvPvfKb9BtLGuurSPRgCUM5zTPNzyFSi+z
 0y54QlkmUk3vJZpt6Q2u+hbiaSudR7ZB109pLauK/56LDfEYfon5xXtcsd5P8u08EUaf
 LylA==
X-Gm-Message-State: AOJu0YyfPopOlZ++YsPN+esXzF03xeFz4YCMTMzQ/k7uMHHpcOqqaLW8
 yzHggiVf7RA85PQQr2r52TnZnOWjWcaz7cMWr56rOD5jcxCV2OO6Gg1BP8Lm3DWLRcO4Hn/7Ctt
 X
X-Google-Smtp-Source: AGHT+IHTYa+a/K6CNDzmXH0Z1jnDBthB9dDd+QQD3FLFcEDaoJ6pEUulcrvICEysCwwB6cW3LcU/6g==
X-Received: by 2002:a17:902:ecc7:b0:1dc:15db:bcca with SMTP id
 a7-20020a170902ecc700b001dc15dbbccamr10964375plh.55.1708634629026; 
 Thu, 22 Feb 2024 12:43:49 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 15/39] hw/tpm: Remove HOST_PAGE_ALIGN from tpm_ppi_init
Date: Thu, 22 Feb 2024 10:42:59 -1000
Message-Id: <20240222204323.268539-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

This removes a hidden use of qemu_host_page_size, hoisting
two uses of qemu_real_host_page_size to a local variable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
---
 hw/tpm/tpm_ppi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
index 7f74e26ec6..f27ed6c35e 100644
--- a/hw/tpm/tpm_ppi.c
+++ b/hw/tpm/tpm_ppi.c
@@ -47,8 +47,10 @@ void tpm_ppi_reset(TPMPPI *tpmppi)
 void tpm_ppi_init(TPMPPI *tpmppi, MemoryRegion *m,
                   hwaddr addr, Object *obj)
 {
-    tpmppi->buf = qemu_memalign(qemu_real_host_page_size(),
-                                HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
+    size_t host_page_size = qemu_real_host_page_size();
+
+    tpmppi->buf = qemu_memalign(host_page_size,
+                                ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
     memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
                                       TPM_PPI_ADDR_SIZE, tpmppi->buf);
     vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
-- 
2.34.1



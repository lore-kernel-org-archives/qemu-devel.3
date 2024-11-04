Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5A2D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kpD-0007Xg-1o; Sun, 03 Nov 2024 19:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpC-0007Wy-4G; Sun, 03 Nov 2024 19:20:06 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpA-0002Sa-Jb; Sun, 03 Nov 2024 19:20:05 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e7086c231so3039068b3a.0; 
 Sun, 03 Nov 2024 16:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679602; x=1731284402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ph5Kd9QXTfnsJFYyLPHoftiyt4e7iSLYLRytO4VxqSY=;
 b=BhaUk8AoULzp+ejChfic5yEFgxlSt1hHg3+IOZBHriwf8WMm4TonlpQJs5x7DeQSgM
 YOKucsLx4DTQK90JTCgPxHn9byXh+H9dPpn4+hHLEzpig/SIOR0uGZXbx14aOw7I/sCc
 jiAuyqGNaAkB5x0cdd4ZUuSduzd+mplRAAJ8SHqpU5fxPclFaVzRctjoTHPmrH2O1r+J
 dikrLzBLL302BnG8IChStORGyuneO5c5CuY6CiEQaQUZ0B5uJfCHvRGaE3OhyxL1Dmrd
 hweNnYLCpn6pBFzUdohexHu57vN0kwov+ZPH3s3JkfTvr/2WxKHvDea8TrpwdQRvnxJo
 XMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679602; x=1731284402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ph5Kd9QXTfnsJFYyLPHoftiyt4e7iSLYLRytO4VxqSY=;
 b=fvqc3LAExbzlj+xLsgJfBJ18cyjAMda0Uo40Mo0tZ6h8ERS5TBW01cbYu1P9bruRnr
 cJVwomRF290MzwT+5sQk9MI++Patoq51+OPI0r8NZubnp443ZeS8roJYCBbk2icy7vQ6
 eUwKas/hWrhJ5MNxluVz0WQGJ0b0l2W8tTf0iRW0MVfb/1IUXjtLwZ1H7ThBEgmbIw+T
 hj90TbJRo4E6TgOeNlicgR7YaBDjPTv2zuFL9ix1stsNkbcyMfXcoBHuIr3rbutzhRo5
 ABQyY1wpCwOV7xVJrPP8AG5yEqUPMBIuqm56z+5faky5ILB1R+dO4lLISRTVePsGDYlr
 DVlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYsCgXGqavrgwIUe7+/KUVABdxEMtI+vdN7vt8Tw9YoafGKBU598Ywxs50/SZmJdB3MT5SrEEfXw==@nongnu.org,
 AJvYcCXB19V70d3SNl7NuGiYVcCm1QmKBEkEhijRgAfCEwbPexSXq1c1P2kjdaiy1Djm2w7Gc2ilaHYc/yny6K8=@nongnu.org
X-Gm-Message-State: AOJu0YzqKtyM7cn2JXDxY20Wka9k1ZfBGws0fMhgmQZcag+VF/m3x/LK
 KgXdxiZwKdAP2dA/oVrpY14LiIeYgttFUEVuTKvDghKxg/eEgi3GHIHKWw==
X-Google-Smtp-Source: AGHT+IFq3yLWRUyEiP8bjW+5GFICSUqSU6tsKjtujyZ35zLB+jgd7wQVXnsjkvmFHFAnaGNyhtynZw==
X-Received: by 2002:a17:902:d544:b0:20c:7181:51c7 with SMTP id
 d9443c01a7336-210c6c8ff93mr422093255ad.52.1730679602160; 
 Sun, 03 Nov 2024 16:20:02 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:01 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/67] hw/ssi/pnv_spi: Fixes Coverity CID 1558831
Date: Mon,  4 Nov 2024 10:18:03 +1000
Message-ID: <20241104001900.682660-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

In this commit the following coverity scan defect has been fixed
CID 1558831:  Resource leaks  (RESOURCE_LEAK)
  Variable "rsp_payload" going out of scope leaks the storage it
  points to.

Cc: qemu-stable@nongnu.org
Fixes: Coverity CID 1558831
Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Fixes: b4cb930e40 ("hw/ssi: Extend SPI model")
[PMD: Rebased on previous commit (returning earlier)]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ssi/pnv_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 72bcc00de7..c21b2ebb3c 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -239,6 +239,7 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payload)
         }
     }
     spi_response(s, s->N1_bits, rsp_payload);
+    pnv_spi_xfer_buffer_free(rsp_payload);
 }
 
 static inline uint8_t get_seq_index(PnvSpi *s)
-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65607D65530
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFz7r-0007BL-QP; Tue, 26 Nov 2024 12:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFz7c-00077R-Rg; Tue, 26 Nov 2024 12:13:09 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFz7b-0004H9-2V; Tue, 26 Nov 2024 12:13:08 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-211fb27cc6bso58341695ad.0; 
 Tue, 26 Nov 2024 09:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732641185; x=1733245985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLDexDsLbCBWjIqcEZsS2lHV4veIfgCX+HAnF6wNxlU=;
 b=JVrQgo7APatRZWjS7pWvDmIRjRWcaMjf8XGDHT2So1XjWNJY4FVvvaN0Wc3Z5Fa27Z
 mNppSwqSsNtziK/cbcA+SQGtiXCnGQmMjSNW/X1kesaNUWPUGWTgoIVvaz2zsU9Aswyg
 NR90woOHqlf8/Mltt92IdR3veq63p2cqHjIxgMlmZXvQ6440ii6RwPMKdT9zcTm/Y0x/
 KqwPejY4gQy+cl+iy19KnVvDXuml+x8/kPS73ks9HsVhKrp6Kjrm/mEGZI1qBHy/opik
 lcINa2Cfy/ruh90KRzMcbGU9CxEYJuIiDgFQ2ejVV/tKULus2DXzPouCp1qKgHlS0KE9
 4CWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732641185; x=1733245985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLDexDsLbCBWjIqcEZsS2lHV4veIfgCX+HAnF6wNxlU=;
 b=sb1+UuL0O+KDRa2pYTk5yDqes68afNc/emTPuv6HMPhYrryn92KE6qbTOEsrYV5m1C
 ZI+s6p9zL2HhJJqGUpwkuC3LcTnJgUBBrc1IkdE2iUkiXPnajF++U6eLrfFZ4U/rUBG+
 IlN9aau4J+Bm+PAzwbhRTMs7s+sG87xelUmhC/W+rXRGtAHvkYPsKp3e/ISxMYYYE48F
 Pv4ly8ryzC7JCy9un35G2vgi4OaFjKMPJIukEhdDPv4ZrTvtVnPO2R84uBb6OZTrxNkX
 TDBjcDIZql+mwAngC3Ab1xmMrI6ksdV9pkl5Glx0Iuiu0dv4+URehH+DUQ2NJuK/5BeN
 CPXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzGZd4HU6mcJyg9Ue9MQbSbDiZpxsorocLZZs5awEEviDdAIpjqmYsiFzBIuIEfQozwOg8+ymonQ==@nongnu.org
X-Gm-Message-State: AOJu0YxQKklEdSEQAzz//H/wvWkVmKpIzxvUajeQSIhRN5CO4YRz4WzE
 GE08pGZ/MehRcKrnHZSPH3OZ5/NO5lG0WHJFvYCT66TyVQgDg4yTGBdOHw==
X-Gm-Gg: ASbGncuG/ayQ0bm9q1qFDk/bCAgC8BO1APbBY91omJVvsYe3IEBERKW1Op/MuQmv7/t
 hpRF1b+A3YL6X1kvAjAxbJJOSWc3as/2E3JlQrE++SjKYbD4jz/H9zAITv/g5/1/wrTb0C8YOku
 rNkfjzQl1ePbQHfZBRh298+T+3JCe6TeFghW3rg/I3I/FzMh2kif1UZHmPKF+TuoMLxO4d9/fDe
 ZyCLqrVjlhdwCTYqpC+wPihCO0y5u/oJmiS44M+ZWi/81nl3G0Ou9GuDze3htq/XCU8u0cXPgEa
 znq5wQ==
X-Google-Smtp-Source: AGHT+IFOXZ2hO9RC6e9hN+qJrRVVAr4ropC6Drq9Gyb3ooh9eaEyudiIT17h1GxShRnJ+B3CLjrgZg==
X-Received: by 2002:a17:902:da8c:b0:211:18bf:e91d with SMTP id
 d9443c01a7336-2129f5f3176mr237270675ad.27.1732641185095; 
 Tue, 26 Nov 2024 09:13:05 -0800 (PST)
Received: from wheely.local0.net (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc21c28sm87321175ad.246.2024.11.26.09.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:13:04 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/6] ppc/pnv: Add xscom- prefix to pervasive-control region name
Date: Wed, 27 Nov 2024 03:12:33 +1000
Message-ID: <20241126171235.362916-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126171235.362916-1-npiggin@gmail.com>
References: <20241126171235.362916-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

By convention, xscom regions get a xscom- prefix.

Fixes: 1adf24708bf7 ("hw/ppc: Add pnv nest pervasive common chiplet model")
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_nest_pervasive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_nest_pervasive.c b/hw/ppc/pnv_nest_pervasive.c
index 77476753a4..780fa69dde 100644
--- a/hw/ppc/pnv_nest_pervasive.c
+++ b/hw/ppc/pnv_nest_pervasive.c
@@ -177,7 +177,7 @@ static void pnv_nest_pervasive_realize(DeviceState *dev, Error **errp)
     pnv_xscom_region_init(&nest_pervasive->xscom_ctrl_regs_mr,
                           OBJECT(nest_pervasive),
                           &pnv_nest_pervasive_control_xscom_ops,
-                          nest_pervasive, "pervasive-control",
+                          nest_pervasive, "xscom-pervasive-control",
                           PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE);
 }
 
-- 
2.45.2



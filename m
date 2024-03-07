Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74285C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAt9-00068W-HL; Thu, 07 Mar 2024 05:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsv-0005h1-H1
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:58 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsb-0007CO-Rb
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:56 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3c19dd9ade5so290687b6e.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806897; x=1710411697;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zd2GK/LwiDy+x5sdYIECrLQP++QUZzK/GPm/IzIIz+I=;
 b=gih6fdu5X+7Em/564vrF3AxKXg64Duvx7MJj4tK8+K5VpoJ5IX6HVa03Kng1m5asLu
 1/yGdwUSJ3sZ5Wj6nL+ECgGk10y6sNUzL5jfSCzblQ/W49spHkOgMFF96Kro+U4UrvCe
 AsmbqJAmO6jN7kwDvXv9IuxBSGMT6fvpZopzz5MVuw0BtQvShCL2Sle4P0l3jKo5b7j7
 KHlLzIAkMG3Jud9Qb51JLPx1/3CqxIjxYgzWMSOxvZvk3haBE/ZDiv5Ik+EDQX9kjEeX
 K5Itriyt8AoTwf6tPF5eBb+rYRy2darcxJFGQ69gQ0EOGW6JbpVUA901pKjIuv6xTu/Y
 b6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806897; x=1710411697;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zd2GK/LwiDy+x5sdYIECrLQP++QUZzK/GPm/IzIIz+I=;
 b=CC6d9eZRBVBILpN8FmzzIZU2ylTkdPRgIUmQv2t7K7PsVoqWScJbeV5+0te7xD0YQ+
 USSvq9XGYeDEGPKno/uvo1+tG0i63Fq1ctfB107HDecZVatPSKxIzU8KDd3YOl7q7Yg+
 53sYxJpIBPYWdNA3ooEoeLDzx84RvuceQ2Z34vRYmWs91HqNVo4LqoV10IkHjzhyvUew
 UdU55Ax1UgxKH0K+Jy3M1+SU+zwsJrIAKahetM32FE0L19MQLh7GS5BHSAvq2UtbPR5+
 mgWX7xKQsekUdPM1F0QZ4x37hFWQ/WqpTOelt5BZouzEYcmQszRrgKZcF1UehpI+DiCL
 p9+A==
X-Gm-Message-State: AOJu0YweGBgz8osKe3oPOCChQuQHFoGz+2234fttg6Ark0Z0ht0EaqLj
 CobvOtxnofK4kxKGDBXObOUNYmJh5NHihn2CcDQGkxRwhOXqchdEKdRfPZUPRW8=
X-Google-Smtp-Source: AGHT+IFh5+E/eS9NGlCYAwHg8bnfDHzD7Fy96mwn11F+dikQhF/w1TkxsAwgDW7xXP9BrOeuh3nv3g==
X-Received: by 2002:a05:6808:313:b0:3c1:f2fd:78c3 with SMTP id
 i19-20020a056808031300b003c1f2fd78c3mr7646919oie.15.1709806896863; 
 Thu, 07 Mar 2024 02:21:36 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d19-20020a630e13000000b005dcc8a3b26esm12042345pgl.16.2024.03.07.02.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:21:36 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:20:56 +0900
Subject: [PATCH v4 13/19] contrib/elf2dmp: Use lduw_le_p() to read PDB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-13-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The relevant value may be unaligned and is little-endian.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/pdb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 1c5051425185..492aca4434c8 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 
 #include "pdb.h"
 #include "err.h"
@@ -186,7 +187,7 @@ static bool pdb_init_symbols(struct pdb_reader *r)
 
     r->symbols = symbols;
 
-    r->segments = *(uint16_t *)((const char *)symbols + sizeof(PDB_SYMBOLS) +
+    r->segments = lduw_le_p((const char *)symbols + sizeof(PDB_SYMBOLS) +
             symbols->module_size + symbols->offset_size +
             symbols->hash_size + symbols->srcmodule_size +
             symbols->pdbimport_size + symbols->unknown2_size +

-- 
2.44.0



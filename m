Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1FCD11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kp7-0007Ns-6h; Sun, 03 Nov 2024 19:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kp5-0007Ms-5R; Sun, 03 Nov 2024 19:19:59 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kp3-0002KN-Oq; Sun, 03 Nov 2024 19:19:58 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e4244fdc6so2800537b3a.0; 
 Sun, 03 Nov 2024 16:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679595; x=1731284395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vP9Pv6akJ9wvw7JMuu+7UGFu2Y8Q3rLCweqIbGkYo8w=;
 b=F3mH+JPiETqE28cN7BS9xoA3Z6Djv5obgzYy5hvte1gyf2I5cG52yVpjaXkVz28p6a
 iYAf2/Da7O2f1CINPTpYnK2uWH8WAS9uV/VCfKgW1AeWA2V3pYgyn+TXXyKgghfSq+w7
 zJzznobSzNyoCLgFSgWr/dEtD8b1wst9HgHM8L/J/bxZK8ZmXFvPEkbfQ0p3jhrzjb/L
 SLdb/OZHBsAL9SmM1z6IXEd56TZfy0nCIa0G6ANxHIHa94TDexlvTAliWPSPv+2n4Yyy
 vWJel5+9JplDtGKFKSiMUWUApSKPVE4it9P57PXrLexi2T/jjupeN6cEJb4GkUKFpV8i
 hvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679595; x=1731284395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vP9Pv6akJ9wvw7JMuu+7UGFu2Y8Q3rLCweqIbGkYo8w=;
 b=lh20I3GGuZuTNmP5DN6NQ1HnGLRXFWzY1UjhUe/L6AxEwPkiRpniEUNBwRbV/R+MlV
 iQFQ4BVo/a65UDhi9jNS1HAGUTs7pORufs06fePPjbFzH8VwY3w9310cBI8zDBODmW1B
 z1kMOAJgGMO2d0UJJmKJZ3b7Y0BU2DPeQ1cwTTIJ+YvtTWJAhexZ/kRyhmLBrYu1hZtq
 1h42S1HfNHPTxoOSLFbZ56sNaMA0EjZ7JtEpoqw3tUbluYpjVi4ypF4Fp1lUWbA0X6uP
 Q95tGUoYwGIZqO9QJASbZMWoMJFd6jirWZETnwlo2KZqiX0EtRRlPNQvBZ0N3FDhCVv5
 2hlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbSJlTudbu5AdlFOqvu6s92t1jeJ87INnKx117Qc1k+ZyGJUGeCs2TI1brGsuoVFA+y57+YkMGwWgZTOY=@nongnu.org,
 AJvYcCXBg3hEJnWyZVSEbqEZoLCzfZrdY2JO45RHIwwvstnAu1jccD941Pbt6TyNomHcKq4kmkBWwQ011w==@nongnu.org
X-Gm-Message-State: AOJu0Ywj1FSFXr5DsXSMubTFDLqT7iauuJLbzPziv5ozxpTkfo3HG8yQ
 +Ss3JAXV3sUogGnRZVDRSkwInDN7TbgeAYzcg3v7GlrAWlNDDUIz+/nN6w==
X-Google-Smtp-Source: AGHT+IHoskG9t740LaqJsduWGHY7u4himZXqnYPo8/hOXH3ClDh4aelVld8CREyNo5l5v3Lf/Y3ACQ==
X-Received: by 2002:a05:6a21:670f:b0:1d9:266e:8216 with SMTP id
 adf61e73a8af0-1dba53bf472mr16052635637.22.1730679594691; 
 Sun, 03 Nov 2024 16:19:54 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:19:54 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/67] hw/ssi/pnv_spi: Match _xfer_buffer_free() with
 _xfer_buffer_new()
Date: Mon,  4 Nov 2024 10:18:01 +1000
Message-ID: <20241104001900.682660-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

pnv_spi_xfer_buffer_new() allocates %payload using g_malloc0(),
and pnv_spi_xfer_buffer_write_ptr() allocates %payload->data
using g_realloc(). Use the API equivalent g_free() to release
the buffers.

Cc: qemu-stable@nongnu.org
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ssi/pnv_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 9e7207bf7c..d15a5970b4 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -53,8 +53,8 @@ static PnvXferBuffer *pnv_spi_xfer_buffer_new(void)
 
 static void pnv_spi_xfer_buffer_free(PnvXferBuffer *payload)
 {
-    free(payload->data);
-    free(payload);
+    g_free(payload->data);
+    g_free(payload);
 }
 
 static uint8_t *pnv_spi_xfer_buffer_write_ptr(PnvXferBuffer *payload,
-- 
2.45.2



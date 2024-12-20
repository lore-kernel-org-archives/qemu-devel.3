Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D858CE7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSFm-0008Vu-F3; Thu, 19 Dec 2024 20:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFS-0007Vq-1B
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:17 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFP-0004Yx-0Y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:13 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7273967f2f0so1734102b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659768; x=1735264568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=csnlmIZP9qWpoQxYhNQ4ejdvpdIVgMo5uAQbmxbPJDc=;
 b=fBMb0cND5GjSTuE1/fmFwBx3WSEcIJprb6Pzr/4as8ykPBEN6AjRhGKN91snFF+FdZ
 rJlxHf4ddqcVZ903GYndRYgHUX1NRIQaGTee0VY7bRI757tIeSndAxmjkK7Ic1sV+EUV
 efDHjHgQuKVAhnc+TEmeAJs04uzJlwmp/+mnHiVMzSmN/sbPtgMzw84oz4CPcQsUOoWu
 n3jsbu36a6Ah8bmqcG9n6DGITBD/d1V5zoutYDX+MGOSlgns5kAgWlKaD/RijfXZue/B
 PXs+zkQgBqSmIuiSfGf/0Dp/UWmHf4JaLYmOyUFpAmPAcsO198m4Y9U+jeVPe6DtHr4D
 Lbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659768; x=1735264568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=csnlmIZP9qWpoQxYhNQ4ejdvpdIVgMo5uAQbmxbPJDc=;
 b=llFq1iwMzDv2MpHLEhygleHeTaZXXK2KcvFL5RWCNpCqf36wPgTYr1lJFLbTuKB+zy
 aEIH9N4RLHtjySm483nyk6FuuTHR2XHgNurNoh1/TxrHHaCUJyutaNM8zOdgZN/QdzUr
 OPrD6DMWstRaDUOC5l1yuL/Ju6Nd38FXoUBBvLKndViit4cPXjoLSmlSoUDDUHDnOBz5
 fR12YUp3yotTOMIYoiHgme181Oc9mSwZDk6XKD+1jsIPSoo3uxcw8e/bvb8uEuMO/ndO
 QR3m04MPoOnuHZCgqrlOb0msexyF9MVVQZ2dt8m3xGOALUsE5ACR1itX6MGv3kvv5dhx
 ED9g==
X-Gm-Message-State: AOJu0YxeW9YDIxNKWX5dtYuVh1+9ST6VMzWSEAI32+aNUQm0j4IhSBNm
 iLDA0mkc148D1VqCJjXbkdnNHLRcFmE6cXg/q7LTSKcMdiORGgDf1uCZmFDt
X-Gm-Gg: ASbGncsHwyFuaQ6Ql+X3jewQyGoaFkDCsXbZ8IxOeXKoygb362j1eSVEZMSA4N3PGAz
 fSZlK2TBySkLIKm1RyQZ+tM46YotoO4Z4CUqGsdq0pz6AH8rKH/dDR4bdtelCMJugDJtvUSCRlQ
 0B/Pjzw2MMwrO0U3J8vQS8bbgRhRTiO6PtsKW+QGzSSkampU48PHLz7yNLWJKolqva8//MKwSIf
 jMupln0JvFWzbZPOW9jPxNMereU9WacJV5cdlVhY3zSkrbl5ay8xq7AsbIeOfDxDtiQQsAfYvxn
 LwNs/CbKC1uk/Lq8sx88rFCObzHOsSexg+jaVDgA4PP7WqjxzXdO+Dp8/egTNqo=
X-Google-Smtp-Source: AGHT+IEr5G1+rQcCLAQdHw1vhEjHmaOiPpL25hNRtXoCIUyaVNNsQiySqo41b3SN6vO8r53swkAysg==
X-Received: by 2002:a05:6a21:6d9e:b0:1e1:ab03:866d with SMTP id
 adf61e73a8af0-1e5e0458e4amr2112155637.3.1734659768532; 
 Thu, 19 Dec 2024 17:56:08 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:08 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 25/39] hw/char/riscv_htif: Clarify MemoryRegionOps expect
 32-bit accesses
Date: Fri, 20 Dec 2024 11:54:25 +1000
Message-ID: <20241220015441.317236-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Looking at htif_mm_ops[] read/write handlers, we notice they
expect 32-bit values to accumulate into to the 'fromhost' and
'tohost' 64-bit variables. Explicit by setting the .impl
min/max fields.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241129154304.34946-4-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/riscv_htif.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 3f84d8d673..db69b5e3ca 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -325,6 +325,10 @@ static const MemoryRegionOps htif_mm_ops = {
     .read = htif_mm_read,
     .write = htif_mm_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
 };
 
 HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
-- 
2.47.1



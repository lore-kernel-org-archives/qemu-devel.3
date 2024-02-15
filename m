Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEE4C48BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafeL-0007yZ-0F; Thu, 15 Feb 2024 12:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeF-0007wQ-MR
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:49 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeD-0003vA-Gd
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:47 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33ce8cbf465so482594f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018543; x=1708623343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vDoCe9zmwIgtkxPsG1M+qUST4er2V8A1hFis8QW2WF4=;
 b=hYQqO5pa+4y1/eW8alXbKoGQciLQGPlMdIdDGE8DxYfb25HJXFwvDRcKMKOGZCKDWU
 RUUjpaTz4L++r4d+4iRD65Z6JKRa+0wnHeVYNtwHPAvZQOpwkrwHHOD/7DTIDos9NefM
 clHwc/AvCZHlTuJHt+yboRiY+tU0S/Yp99ovZx5mw7jnRTP98XLBHKM2Y50ZrpZehk9R
 ZR5uJ5GWT+e5sVHOG8reY9YkIbbVMIugIwSreHtagJN/DQhkcFmorSV8WFl+yhUBk1HN
 guhWgnVRo/uyz0lQ7vmquiEx5VSTVmBCwLtW3/jbPgNe2D3pFDgFZxeZwgGNTmncbaZt
 AFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018543; x=1708623343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vDoCe9zmwIgtkxPsG1M+qUST4er2V8A1hFis8QW2WF4=;
 b=bX+pxFhFxJYtdc6RqsvNcYtBvjKRIjNC/j3PtGEyqMmmquT2Yp359F0L3pmdSpqg5G
 orHlwFw/wFKJDwBh45Jl+LmkzndcdNCKdP2aeOkaYrEMaSThwQP6t+jMsfs5ii1O11nv
 v5Xyx3VarQvaJ5rrZUGso8gdR5AEF2n0wcNdqiFdJUxRgHIjfmaKhgpAOP88XfcG1hFV
 Mbo/K4CeOxT+uNtNpQLtfTJyi/uTOHzayQhv0gjEYN8f5Z0YeTd6YZc20bxDYLmjouaA
 DWgFIhbblY0rvMk8/58hmDmR3/E6+cgaOGF64+8jtJOu+PFKvuum4EINGakTREYW1Tti
 xgoA==
X-Gm-Message-State: AOJu0Yx2sVxodDhO0ujgsK766+WADVY+7u89J7ZCcEkcyiYS4dpjp0Gh
 mjW0JL5jr9jlFZXJEjLpaUAu1bzkc8jlTswLS96xIW2Z1u0l2tRgG7kVF/fRLiKd4Ko0SE6eFO6
 Z
X-Google-Smtp-Source: AGHT+IHC9kxi1eLIry1AxffiM/XZgQKLAtK6WsTBNGHx2NubLkNMkJ6TzQYhdnMQ3Pk24z82+WBGzw==
X-Received: by 2002:adf:e70a:0:b0:33b:697c:1fc6 with SMTP id
 c10-20020adfe70a000000b0033b697c1fc6mr1739030wrm.20.1708018543178; 
 Thu, 15 Feb 2024 09:35:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/35] hw/pci-host/raven.c: Mark raven_io_ops as implementing
 unaligned accesses
Date: Thu, 15 Feb 2024 17:35:11 +0000
Message-Id: <20240215173538.2430599-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

The raven_io_ops MemoryRegionOps is the only one in the source tree
which sets .valid.unaligned to indicate that it should support
unaligned accesses and which does not also set .impl.unaligned to
indicate that its read and write functions can do the unaligned
handling themselves.  This is a problem, because at the moment the
core memory system does not implement the support for handling
unaligned accesses by doing a series of aligned accesses and
combining them (system/memory.c:access_with_adjusted_size() has a
TODO comment noting this).

Fortunately raven_io_read() and raven_io_write() will correctly deal
with the case of being passed an unaligned address, so we can fix the
missing unaligned access support by setting .impl.unaligned in the
MemoryRegionOps struct.

Fixes: 9a1839164c9c8f06 ("raven: Implement non-contiguous I/O region")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-id: 20240112134640.1775041-1-peter.maydell@linaro.org
---
 hw/pci-host/raven.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index c7a0a2878ab..a7dfddd69ea 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -200,6 +200,7 @@ static const MemoryRegionOps raven_io_ops = {
     .write = raven_io_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .impl.max_access_size = 4,
+    .impl.unaligned = true,
     .valid.unaligned = true,
 };
 
-- 
2.34.1



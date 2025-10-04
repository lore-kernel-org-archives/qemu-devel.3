Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0391FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wT3-0004nD-D8; Sat, 04 Oct 2025 03:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wT0-0004fh-Sg
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:07 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSy-0004zs-7H
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:06 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e542196c7so23002895e9.0
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562042; x=1760166842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7uu27tZnPe0RsaDnrNRFgocmr+o3FTuX5ovq7Q9sqrs=;
 b=T+QwgV4D64adkiiEtVC51PVj0Y34wVUpyRogWTkS3O01JrtJKYMYrScVFYroEu2Vzs
 WBclY9WWhe7Xm6d5eI3b1dt0UXr9f0QAIKyM1grQKFbvcApC4IUf5GZIfswao9rdNpQE
 AYKGh2+dMRSm+VkmuMnBLxOWH1Und0UL5ykSWXA0geOjD8T5hb2xDPesN02oXn4njtVO
 VaB0HIV72meVlk0tS4+7dg/IiLHyvbN8whcRkYjUrH2Elr6sUaNSx1weKtvjVzDCEN88
 KEJ6nDWbsFN6xo3ykAfWTo1kfcs9jtQJQziFAqznGVcCJeR9VJPh9RUE+u+Pv2j+UxOc
 Fp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562042; x=1760166842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7uu27tZnPe0RsaDnrNRFgocmr+o3FTuX5ovq7Q9sqrs=;
 b=L8NR3n6iW6eyeinh6Kwu0d+IdReLVhDc5xkeBD+zykFmoDj5+NfehB2OqDSBUuUlOf
 QXUBGF1ovYZ54lORBkSgTcSU7iK8VabwHjD0BuEZB6hlJ0mcr1tSsAjUXXHawMnQHkID
 l+CXpAXqq1HYfXQB23AHoxN3UY7uNf74Z+NmM5LpHmS5tsZ62Gfhbh21HvbtkiFS3KdH
 rohJDSCisLIvx2zHWW6iHiKxNNH/iKKF+R5tejahcsNLFcEtGQmMQaoyD7dXY9AFey0n
 CQZ2/uuBIE8jO4hwZcWSKnnJ7w0ahhjqqcKmGgngtY5OoXhIL0ohMe6lSZmJmEx//Axv
 z6sw==
X-Gm-Message-State: AOJu0YydiOCW3faVfmtvvSoWJ/AIbaZvaKZDY8uH3qaY14uK2LcLbyDT
 2iXTiFl2riHG7EUMiiSqw4Ea/T9+aWiBsaKw/oQ+VJpcHkrVDgFSFleW7TzBmA+wn76TwJ+o/fk
 Oqm2TOeX8mA==
X-Gm-Gg: ASbGnctVIITbNLSQOn4RmanLR4qNIGhLoLDT4AExvE2DB/6vAXAjgBOL+NWpgFgSsRT
 kSpFc1He3pXDWKSw1eZu27jv7x7jPUvX7KDk46su2AzMQ7KWd6rzWooh/ppp1MP45/VTfIwpozl
 5fc29uOZTmLgxxQDt4nJRz9EXjxMKRso6pUqqoFmSm28LpvlVow3P+cGVdbsXuVa7U8vD4Q1f3p
 zHRoPFQvdPVRirt7k0n21EfE4O4FuWeB2tCXhu2zSiKwjzY8pRRurqArvYAe1P3xg6gd11QJqxL
 uI0kz5fDyRMl7GRxrG0thKNc5bu/P/ekjIfuZeGHqpZOqhWQx1O1RN8tlEpZbJfZgYCKnJx0sx8
 vQVL6GkFAlmohygh3cmKuUD0YtJgcQm0t+B676X81kVLNRwPbUp63w8Z/Pi2Gm//linqIsUa9kK
 UbgcxnpXgYVEjRcpcXVTtSb2l3
X-Google-Smtp-Source: AGHT+IErhLRX+nAk0QGKnkAXLKpVUYeUZsBMRNDrJnRg+B9TKpxVHuvNDq/BSm7TM0JcMwoBorbPtQ==
X-Received: by 2002:a05:600d:108:20b0:46e:1a60:c995 with SMTP id
 5b1f17b1804b1-46e71033bf4mr31839165e9.2.1759562042112; 
 Sat, 04 Oct 2025 00:14:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a18b76sm163088335e9.18.2025.10.04.00.14.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:14:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/41] system/physmem: Remove cpu_physical_memory_is_io()
Date: Sat,  4 Oct 2025 09:12:37 +0200
Message-ID: <20251004071307.37521-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

There are no more uses of the legacy cpu_physical_memory_is_io()
method. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-6-philmd@linaro.org>
---
 include/exec/cpu-common.h | 2 --
 system/physmem.c          | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index e413d8b3079..a73463a7038 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -149,8 +149,6 @@ void *cpu_physical_memory_map(hwaddr addr,
 void cpu_physical_memory_unmap(void *buffer, hwaddr len,
                                bool is_write, hwaddr access_len);
 
-bool cpu_physical_memory_is_io(hwaddr phys_addr);
-
 /* Coalesced MMIO regions are areas where write operations can be reordered.
  * This usually implies that write operations are side-effect free.  This allows
  * batching which can make a major impact on performance when using
diff --git a/system/physmem.c b/system/physmem.c
index c2829ab407a..4745aaacd8f 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3763,11 +3763,6 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
     return 0;
 }
 
-bool cpu_physical_memory_is_io(hwaddr phys_addr)
-{
-    return address_space_is_io(&address_space_memory, phys_addr);
-}
-
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
 {
     RAMBlock *block;
-- 
2.51.0



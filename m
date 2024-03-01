Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41F9C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByE-0005cP-8d; Fri, 01 Mar 2024 18:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBy7-0005M1-EZ
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:07 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBy6-0004Jz-0Q
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:07 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5d3912c9a83so1882158a12.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334425; x=1709939225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9UuugcteI3wsnFXZ+gvu7oCS1Hb/WPFzjY9R5VsQ974=;
 b=CiU8qvJbFF+CGuGEAAlV5cAr1aXwRDF1pFKlM2HmJTsfaz8FULHY9n69PycVwjM2RE
 Hr2aYQXqr1cOdIseZMXnNYuwFY7Qb/MrPHnYYAdJAVX/u+PvxyMBq31bqoPvgDjj5W77
 wEEMHFvrON9bGoSX3Uj1Sp+vzkWD38sDLvwVputAKmuX7MmZ0kIDe58LliZHeSwpVgSk
 c1vkAJqrcgELpghkAbYarxk17sUQzAw6eT8watYQIdlXnxNDVZ98zH9eQw/ZW967OvXh
 tXV70t5XobiGlVdoBDGGnKo5vhkJcKGxrQTsQjEq8oKQvJJ8tHnrx4JucvwAlRLoT6wl
 QYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334425; x=1709939225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9UuugcteI3wsnFXZ+gvu7oCS1Hb/WPFzjY9R5VsQ974=;
 b=ONWXxyYu0zo33oTkp91lYrP4CK+et+N7Ev+1zr5F3WSFx1Jh8saJmhDx7ZVVas7KVo
 CtMP3NwzmAmRKfGpk3smItAF5cnmuK1VroLd5MYhjOW0Hh+0Elrwpi4/z+PUQuCAiqSJ
 x/hwaVn0DW6kOk6hPVYKeowOxMOn1dYBinrkHVha+l+trtsFJpJ/x0AH5qlPP8//v6QA
 bjQnnMoU2LShcYc5dcyf1NZ/T1UYkOKCJgYUMpIsQMOnkJbh5+IRNkzH0Cn8GV8W67XY
 0RKg+zzyuOHKe3G/IcjHi6YzyrvejFsucvfpVA7UVHXifvKsVg/voVhOZjpQHdO0FoJS
 cL5w==
X-Gm-Message-State: AOJu0YwIketahH40SQiKW0xdmxUMl+lnLJjxRIWR1RYAJtqoXyMApX0K
 YL0nu3E4gjfMHemPYcKy0VK/Y23x14mVYOnoIbQYlBC/idgFwVXGW9V1kDd/GMMm/NUFwXRdLwI
 9
X-Google-Smtp-Source: AGHT+IFKC99CcxCg8ChJdZfnfMKzkGSiF8CR07H+vGH+yWnXbmLO/SEtpYi2VIzRSdqZCKjjNffjfQ==
X-Received: by 2002:a17:903:986:b0:1dc:b01e:f75d with SMTP id
 mb6-20020a170903098600b001dcb01ef75dmr3755834plb.10.1709334424775; 
 Fri, 01 Mar 2024 15:07:04 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:07:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 30/60] hw/tpm: Remove HOST_PAGE_ALIGN from tpm_ppi_init
Date: Fri,  1 Mar 2024 13:05:49 -1000
Message-Id: <20240301230619.661008-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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



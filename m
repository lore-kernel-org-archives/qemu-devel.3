Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18D8C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmsvU-0003ec-Ky; Thu, 23 Jul 2026 08:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wmsvS-0003dx-RF
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:53:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wmsvQ-00025l-VD
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:53:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so5175925e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784811199; x=1785415999; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=30Od0+huaCJZdt8piWFpgBuQnTP9aC9UoilTDQya/kA=;
 b=KfNKiOynQDKbXCen3WHQL46H6xncqb1Zw6NI+UTtFBP6GIEDNXhzjWfe4D3iJDUQ/x
 fhl+d4L4f00tWacn1wnDMBlXAGY3P0dJ6WPBpXBk630STjm20OMi8oil212b6Z+1jpIa
 JBCBj2ROyVNIXNL/ITiMVsvlQYsw+0oXo69BO/fsIoraLqUFQkHRLWXVVmZ/pynODuWr
 xsnjz7Wg3W9tan5K2zULqgjxwde43rXQrc3Yar061uUR0Qnh2r0O/RHIEjfIZk06bsEN
 16sMJ3WBBSH7YBkhF1gIGZYjeCImpBGRFAIEbfycBV0lgeNST2X39o9MwkwZb5QvjAcA
 4B2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784811199; x=1785415999;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=30Od0+huaCJZdt8piWFpgBuQnTP9aC9UoilTDQya/kA=;
 b=H1zegI2Q5Hu9zSULWUdi4pK4/wOo4/2yQ+YLCWbrGMV1tXSpfdEtqyYHX9izat1xAj
 rdUHubQWa4bLsYpWr8Dob1cKzYAL/09tiRU7kTW0bj8zhsvgGM1K9k1LjBUFw3GGbWl3
 nX8lJlzor5YL5jfoD+TYkG+sZ2QV2fztH6USlONNfnFjskTOqBvT2bOFV8jdr1scVf3R
 ppbveJKkAqb3FpOC4B7UtkZvdxalC6ViX977/SBeAA8R62wEQSOq7NYDYFZTKtTtF9fZ
 dVuKr5W8eehMgRTe4WUUNMyAf7ZpAAQKMw4ArGPMHtAZ6vkV71ZXWxDc8YX29OkZDyF4
 2ADg==
X-Gm-Message-State: AOJu0YwRqN2zN5VlxJj70xh2XICD80dhdFksdUzME2Lf7qwZ2CkJ0MTO
 etlqKU5ArxYuJcpK947t6QjGOyaQDiP81/MnXyg0ddsza/Dmi+2BoV+CVhMM06o2yNU=
X-Gm-Gg: AR+sD13AqrEvCzTVc0WgV7qrZTQJfuUjJAFH8VH2NKi/Ys5UNq4GpajnOyrbexpqLri
 X2IXbCdD6kk5Adv2Qi/xAdZ8lKFobafS0poqC/H1WxfaJ5455KlD1Uxd5iglg7TqyV2nvCMkDI7
 IDUi1UFW0tvdM5IrR0X1zWw2Pp6Z/iGrlQyJGvTwpatULuKcKT+ZxxS3sPn+/L8x3AZG8k14US5
 lPwfp+KLQhWw7YlhViJCVOam3uoXikFJhCzNjwLhduCYgi9RwQylt9Sd+U4gy1zc8SLV2A4pnDb
 W1qKbaMk9eFM+uMlct2gWBYf4/jxFM0cEt8MXHqMXMewXlHZq1WK72xmkyupoeG3LUiP3vF8qqx
 bRuQ0vfeF0/h2Cj8Jckx9IBwnyK5JpLFAg+kBDeunbrJNJTMY3puYuTjlGHnwbXolM5wa9eOUmm
 E1aQ==
X-Received: by 2002:a05:600c:1393:b0:495:6a50:3fb8 with SMTP id
 5b1f17b1804b1-49573c8c2b2mr31564375e9.1.1784811198848; 
 Thu, 23 Jul 2026 05:53:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653698bcsm200261835e9.2.2026.07.23.05.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 05:53:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BA3EB5F7C2;
 Thu, 23 Jul 2026 13:53:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH] include/hw: defend against weird elf headers
Date: Thu, 23 Jul 2026 13:53:10 +0100
Message-ID: <20260723125310.33707-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to the ELF spec:

  PT_LOAD

  The array element specifies a loadable segment, described by
  p_filesz and p_memsz. The bytes from the file are mapped to the
  beginning of the memory segment. If the segment's memory
  size (p_memsz) is larger than the file size (p_filesz), the
  ``extra'' bytes are defined to hold the value 0 and to follow the
  segment's initialized area. The file size may not be larger than the
  memory size. Loadable segment entries in the program header table
  appear in ascending order, sorted on the p_vaddr member.

which implies while both p_filesz and p_memsz can be zero we should
never see a case where p_filesz is greater than the in memory size.
Indeed it has been reported such a hand crafted ELF can blow up, for
example during rom_reset():

  address_space_set(rom->as, rom->addr + rom->datasize, 0,
                    rom->romsize - rom->datasize,
                    MEMTXATTRS_UNSPECIFIED);

which could trigger and underflow leaving QEMU slowly filling a very
large buffer.

Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4056
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 include/hw/elf_ops.h.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/hw/elf_ops.h.inc b/include/hw/elf_ops.h.inc
index 9c35d1b9da6..c6d94ef760c 100644
--- a/include/hw/elf_ops.h.inc
+++ b/include/hw/elf_ops.h.inc
@@ -427,6 +427,10 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
             file_size = ph->p_filesz; /* Size of the allocated data */
             data_offset = ph->p_offset; /* Offset where the data is located */
 
+            if (file_size > mem_size) {
+                goto fail;
+            }
+
             if (file_size > 0) {
                 if (g_mapped_file_get_length(mapped_file) <
                     file_size + data_offset) {
-- 
2.47.3



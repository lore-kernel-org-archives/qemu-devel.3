Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9B9C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 11:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugixv-0002Ii-Jc; Tue, 29 Jul 2025 07:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugixt-00028z-Jc
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:57:53 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugixo-0006Cr-Lv
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:57:53 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b78b2c6ecfso1117501f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 04:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753790266; x=1754395066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGU6a5L962cXOl9z6iat7nkHOVFeV0lVntYAA1OoA9c=;
 b=FSKyX+1UDbeCJT9Q/WHq8o87dKbBVqSUNM4gP2ylgKGCz1pyaj1315sYoqvweX1pbH
 RFFHkLXy0Ld6qE1N5I5UnvO/0lLkiMKN6bSh/9+HYkEJ6F0GZIrbzjl+YtgGwObKWBjX
 WNjAc5G31CtSdnwvb2NKnYIRR+oM1AmlBUNTY0mZ51FlkqtE8dUQxrk7lk8d1U9/F1/6
 0Bu3lmpKHa8pjUfn1r/LQ+bM/QaL6qsMw0QvzsdeNToiERqyUFaAmnW6AHZUaHXX1XY0
 gNFsJccdIKIvkxCJ1pGbUWqXAil7Z9MRh6DVHT+6tIdwWqiX4545H9NnxT+pkVl0T3De
 mK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753790266; x=1754395066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jGU6a5L962cXOl9z6iat7nkHOVFeV0lVntYAA1OoA9c=;
 b=TH8TxrO9DcXlALuWcaWYJyaLGXsda6v9TVN3I4CtUNUUw2ESOzlRdYE3KS5EYesLcN
 fjEdukMgSkCusaM6/FGXdVDIzu7KlOM+EdjMzUUtx5dhw1VtPq+5qaNNPq+9gxJqCHCy
 x5gr1urDFRO3LNy0EMQXVMIv6qRqa3ebfWbzpUZbxJyx/h20y3ZrUftv7SdjyZa3v3bS
 m9JvTXTgBls2OLYu8hMJ92QFrsM1NlqeFUNpwaL9zWSa+HqURRqiNwpf0o11uAz6y7BN
 xBDUFIyWkq6KjfTl0UnEYqQyZcJ5f/5QTLNx/cuXW8djBuArIfDSEFXrj5zuAxai2DHi
 DweA==
X-Gm-Message-State: AOJu0Yww8hJMczy9F4ulQ8nQgRyrYIs8smxJNydIantOVitx0qfanQV1
 Zf2vBXIFYdyX6+sohQNMc/CMNoNLXdnlLpv2y1YP0ywMslS/LL/o9QInorl8NnvxodIKOq0cAT5
 hFZui
X-Gm-Gg: ASbGncva3zJtaV/tgmktLzP9KD796ENzp9X9L/M1yzQaWhhgraLoLW6br50yFjOgvRZ
 VFqMdLlODfIRt2LjnJPRj/CQuDekP8I/xQvcPbiLsw+dOzaushrQvZOj/6QOC9tFJ98MTJYEX1u
 XnXrfeKiJORE1xv9xcTMe4IDfn573RneHgiE3K+P8uOFRu+LcgSyx3imNnCKIoUrTJCkIhLqs2d
 t5XCeiVD05Yz7Lxfe8wgWjfR1S1/b0el0GCEVWLAqrRRiu4t66GWempP5xkWycs/iiHytm2mD5s
 MVFRAbm/Z270eLAucd2sf+MbHIrxmaBWYgtRzSMCPvDvokqb8OoEwT/yPfYfLhXvAxWJX9iYssv
 tmTeGbFfaTrJTnBywoXfliOyDwrWz/MALHhkvXDRsiCNcx5OYB/MDrXLJrdLgSySE3o6koRwm
X-Google-Smtp-Source: AGHT+IGaUxUieApgTi5kqO6K6S0Ni/KFXUn6oguOcYa0zF8XTiYVC1AMPEjqsTEY7f0iVnu1k3AhuA==
X-Received: by 2002:a05:6000:40c9:b0:3b7:879c:c15c with SMTP id
 ffacd0b85a97d-3b7879cca06mr5994638f8f.47.1753790266442; 
 Tue, 29 Jul 2025 04:57:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b7842a3e59sm8582557f8f.44.2025.07.29.04.57.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Jul 2025 04:57:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Thaddeus Hogan <thaddeus@thogan.com>,
 Vadim Zeitlin <vadim@wxwidgets.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/9] hw/display/qxl-render: fix qxl_unpack_chunks() chunk size
 calculation
Date: Tue, 29 Jul 2025 13:57:27 +0200
Message-ID: <20250729115735.33619-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729115735.33619-1-philmd@linaro.org>
References: <20250729115735.33619-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Michael Tokarev <mjt@tls.msk.ru>

In case of multiple chunks, code in qxl_unpack_chunks() takes size of the
wrong (next in the chain) chunk, instead of using current chunk size.
This leads to wrong number of bytes being copied, and to crashes if next
chunk size is larger than the current one.

Based on the code by Gao Yong.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1628
Tested-by: Thaddeus Hogan <thaddeus@thogan.com>
Tested-by: Vadim Zeitlin <vadim@wxwidgets.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250221134856.478806-1-mjt@tls.msk.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/qxl-render.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index eda6d3de37c..c6a9ac1da10 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -222,6 +222,7 @@ static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
     uint32_t max_chunks = 32;
     size_t offset = 0;
     size_t bytes;
+    QXLPHYSICAL next_chunk_phys = 0;
 
     for (;;) {
         bytes = MIN(size - offset, chunk->data_size);
@@ -230,7 +231,15 @@ static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
         if (offset == size) {
             return;
         }
-        chunk = qxl_phys2virt(qxl, chunk->next_chunk, group_id,
+        next_chunk_phys = chunk->next_chunk;
+        /* fist time, only get the next chunk's data size */
+        chunk = qxl_phys2virt(qxl, next_chunk_phys, group_id,
+                              sizeof(QXLDataChunk));
+        if (!chunk) {
+            return;
+        }
+        /* second time, check data size and get data */
+        chunk = qxl_phys2virt(qxl, next_chunk_phys, group_id,
                               sizeof(QXLDataChunk) + chunk->data_size);
         if (!chunk) {
             return;
-- 
2.49.0



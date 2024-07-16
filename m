Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EFBC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmct-0007AD-KB; Tue, 16 Jul 2024 14:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmcs-00074l-08
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmcq-00011q-1C
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so46452065e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721153406; x=1721758206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5NkIaFDVC7mCONUcx74ZzxY6giGkJtU3xAyO2Vz6jhE=;
 b=SlCuDIqTNSAU0XZafHImW+vkQTc8KerUAgv2Xtw88DZPaacCDZbO+KP/WeThltH4/+
 gFQxOz6C2Ph8npnKpYlLEqgexKsP2hSnGfrTuZ/ynshfnK5JEb7t+eLpNYmM/a6MbM0f
 xeWB2cYtnLaDoHzHeOryWmy+NkKWKfFrQ8vRUwVsMpxbZKi9Hmdsa8D3Jmqf7eWfpaIR
 QoQ84Elzz4r03nYLx9w42HS0/u+VxVp2RnDw+lb/ZYcqhilPAWPLBlsjHeRZoKVtpnxy
 Z67OHs5UImoZ5ljMHdDN7+N8RcfA/klrBT4HBXu2oYe6MsA4PEjyg1b+JK07cUbmuj61
 1EdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721153406; x=1721758206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5NkIaFDVC7mCONUcx74ZzxY6giGkJtU3xAyO2Vz6jhE=;
 b=osFJ5dQAp/snQNpz+Ylw1JrJuFYO4NEU4ZJUR7JLF1FcoJiri5YgjKYQbDv3FIwje5
 HC3RJOO9FU515SfVBVw8wI6sNQ1BLHtBywgkKwlRQpvbUDuwm7EYngW20/KDI0G7QMxz
 igpBcf7GBxBFiyZnTrotKGSkaovKei5ES+KfOYvwKLTCinrhetZkgeiySlNsRbH8Lka6
 r/cEQGeY44RW3Zeej1qxZy0QjMxxr3Fkmk1eejKFjKdHD3ld33FKgVqITAfsm+Wmzb91
 wxlObYjkQ1i+uZOy5I0UPFJPInUaioCF6beliE1m/2SDprOWNJUZugzuE+t2XAGLYY3M
 kwEw==
X-Gm-Message-State: AOJu0Yx09P4MDmbE3mIOIX94NxabFFmI1/A4iW6L7mhEidi1UU2tnyov
 PmzlbqDwGhcQMt6KcqMRWGHZCE+67BwJccvHdAAQzbxwx9tP5hIcOuf8RtYAxkKz/6T7Qhis5B5
 PoRw1cw==
X-Google-Smtp-Source: AGHT+IHdodhoA0epDnnbqGTqdUBk0g1Gjnb+TH1mQmnHijHygTUmTo6CrO2Zqrh09qatHzq0zS4aBA==
X-Received: by 2002:a05:600c:1f90:b0:426:6b14:1839 with SMTP id
 5b1f17b1804b1-427ba47ab0amr26929585e9.0.1721153406167; 
 Tue, 16 Jul 2024 11:10:06 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabefa6sm9664487f8f.44.2024.07.16.11.10.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:10:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/13] loader: remove load_image_gzipped function as its not
 used anywhere
Date: Tue, 16 Jul 2024 20:09:31 +0200
Message-ID: <20240716180941.40211-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716180941.40211-1-philmd@linaro.org>
References: <20240716180941.40211-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Ani Sinha <anisinha@redhat.com>

load_image_gzipped() does not seem to be used anywhere. Remove it.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240711072448.32673-1-anisinha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/loader.h |  4 +---
 hw/core/loader.c    | 13 -------------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 9844c5e3cf..7f6d06b956 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -77,15 +77,13 @@ ssize_t load_image_targphys(const char *filename, hwaddr,
 ssize_t load_image_mr(const char *filename, MemoryRegion *mr);
 
 /* This is the limit on the maximum uncompressed image size that
- * load_image_gzipped_buffer() and load_image_gzipped() will read. It prevents
+ * load_image_gzipped_buffer() will read. It prevents
  * g_malloc() in those functions from allocating a huge amount of memory.
  */
 #define LOAD_IMAGE_MAX_GUNZIP_BYTES (256 << 20)
 
 ssize_t load_image_gzipped_buffer(const char *filename, uint64_t max_sz,
                                   uint8_t **buffer);
-ssize_t load_image_gzipped(const char *filename, hwaddr addr, uint64_t max_sz);
-
 /**
  * unpack_efi_zboot_image:
  * @buffer: pointer to a variable holding the address of a buffer containing the
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 39bd8f9e4d..31593a1171 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -845,19 +845,6 @@ ssize_t load_image_gzipped_buffer(const char *filename, uint64_t max_sz,
     return ret;
 }
 
-/* Load a gzip-compressed kernel. */
-ssize_t load_image_gzipped(const char *filename, hwaddr addr, uint64_t max_sz)
-{
-    ssize_t bytes;
-    uint8_t *data;
-
-    bytes = load_image_gzipped_buffer(filename, max_sz, &data);
-    if (bytes != -1) {
-        rom_add_blob_fixed(filename, data, bytes, addr);
-        g_free(data);
-    }
-    return bytes;
-}
 
 /* The PE/COFF MS-DOS stub magic number */
 #define EFI_PE_MSDOS_MAGIC        "MZ"
-- 
2.41.0



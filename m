Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBC2C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lNE-0000vx-VZ; Wed, 08 May 2024 13:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMJ-0000M1-PY
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:45:58 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMH-0007Kz-W3
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:45:39 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a59d0810f59so2275466b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190335; x=1715795135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4gAKoZA8GiThrSy3LlK57brDrhpN7s+nDa4hQZ9Yrx4=;
 b=xztPN7IBBEOzcv7Ko63eivjgOQG1G1yu0sRmVoMvtlFUKRFI5FpaCp0Jw7J9qVrzs0
 5RhzrGsOdPbfgAUIa9UR2mFg+WP16d0WexNHB2+sfEQTxZwXZCG7FqEty9Q03qOECkEe
 TTkJ4++b3amcKaB9xS5cOiaXPWxMAH8ua7JUXhNNGz+qaQwArO3j1NpcIsaa3I36eg5G
 rWEg6xd223GVnNDTNms69/zrkIUMfs0m/ju8abSXKpolYKSq31PI8WiA8RoQnj5m1rfM
 picxx6DMWP01QJtG913N7No83csvCId1tzB7Gf25GK7tHhxXv5GsoIbFR+gYqo3DXN8z
 5mIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190335; x=1715795135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4gAKoZA8GiThrSy3LlK57brDrhpN7s+nDa4hQZ9Yrx4=;
 b=X0GRXjLNIZUUY/PEZUKx0nn2LjfnkFRjb78YfCA3PAJ2HD4nz20KR5t/rGWq8hdTgZ
 DVtXwfpPEsTxM19dSJ4zdhKHroULOzLw5qTVR0Q/DXtMsmgTabrZFwCHRX4UcjT5jAQZ
 8p/r4OZp1vG7184B62YYcozFQcfA8x+NTK1OSdS1dXsQ7gLbzpymTXGXpDk1gvUHYN6G
 OGlG9Z4xJsEmwqgSZ4sycRcfHSxh03rdIiq2fwf/giuv+urC8V2tsDZWfoyKqnvWeu+J
 +z48MEDtiNB2fRtFQKsL+f9HcTx4VFF736NYFVmjMEI7LCKdpfYzlX0K9ay2HQGgrCm2
 fQvQ==
X-Gm-Message-State: AOJu0YycahPWelAaDlyr2396lftFt/ov/XM8iP+umvZi96Sjv/g3RR7D
 02qTNW+hoWebT3xYzGjYzCBEObH9YwuZc4KJm4LOG2EdaislyDRxs05Zzu5pXTvhZRiBak+GPsV
 I
X-Google-Smtp-Source: AGHT+IEixw6bc8oLqJY9DvIOYyNkfjsNzMGXlCRIptu5A3zVApqBYU3Tg9UVjkS7sDj7TiyoUdsBDQ==
X-Received: by 2002:a17:906:368e:b0:a59:c0a6:25d3 with SMTP id
 a640c23a62f3a-a59fb819d1amr195236366b.12.1715190335302; 
 Wed, 08 May 2024 10:45:35 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 z7-20020a1709060ac700b00a59a0ddcc3dsm6077937ejf.44.2024.05.08.10.45.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:45:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropber.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/26] hw/ppc/spapr_pci: Replace g_memdup() by g_memdup2()
Date: Wed,  8 May 2024 19:44:48 +0200
Message-ID: <20240508174510.60470-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Per https://discourse.gnome.org/t/port-your-module-from-g-memdup-to-g-memdup2-now/5538

  The old API took the size of the memory to duplicate as a guint,
  whereas most memory functions take memory sizes as a gsize. This
  made it easy to accidentally pass a gsize to g_memdup(). For large
  values, that would lead to a silent truncation of the size from 64
  to 32 bits, and result in a heap area being returned which is
  significantly smaller than what the caller expects. This can likely
  be exploited in various modules to cause a heap buffer overflow.

Replace g_memdup() by the safer g_memdup2() wrapper.

Trivially safe because the argument was directly from sizeof.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: David Gibson <david@gibson.dropber.id.au>
Message-Id: <20210903174510.751630-17-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr_pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 72cfba419a..7cf9904c35 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2188,10 +2188,9 @@ static int spapr_pci_post_load(void *opaque, int version_id)
     int i;
 
     for (i = 0; i < sphb->msi_devs_num; ++i) {
-        key = g_memdup(&sphb->msi_devs[i].key,
-                       sizeof(sphb->msi_devs[i].key));
-        value = g_memdup(&sphb->msi_devs[i].value,
-                         sizeof(sphb->msi_devs[i].value));
+        key = g_memdup2(&sphb->msi_devs[i].key, sizeof(sphb->msi_devs[i].key));
+        value = g_memdup2(&sphb->msi_devs[i].value,
+                          sizeof(sphb->msi_devs[i].value));
         g_hash_table_insert(sphb->msi, key, value);
     }
     g_free(sphb->msi_devs);
-- 
2.41.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5A0C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 20:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2y8i-0000hS-Gs; Thu, 10 Apr 2025 16:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.pentagrid@gmail.com>)
 id 1u2tBK-0000L9-Mw
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 10:47:07 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.pentagrid@gmail.com>)
 id 1u2tBI-0000wC-U1
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 10:47:06 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-30ddad694c1so8493931fa.2
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 07:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744296421; x=1744901221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=feZuaxrFBmW/7qEu/+5shM64Px/4u1yOOiSmxUSEtqg=;
 b=B46dZAKvlAooaM0u3u6UN3gtoPSGU3dy/hRBOWNcpOX6y0gNs25u3lgtedWQYlGVs4
 ahhqhi9Jjp5m7Nhx2jxVuIgFh7ZWpWv+0Ms33Z5EdheMWuOyfXTobt/hBvUw8Ms1ihOr
 Z4WNdQdEshQ6hwIiHAze7aqFHQHrGpqZYXUH++6ipso4kQQcfb6OhuPzutx1aA+7yZnw
 QsQcOXShkQqEXC1KIoEUO6SwHYFDJy2vSbEHfYhB3RBybEhTJpQmvn55UwzC2m58+FaH
 sSSQoZhIw5IgRrP22q/9XxsMsTnM070TqmARs6nQdwL+edZFx5RlwKESuwjnDoG6jzKZ
 +o5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744296421; x=1744901221;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=feZuaxrFBmW/7qEu/+5shM64Px/4u1yOOiSmxUSEtqg=;
 b=E0Qcqzyafhf14diVXbKqiObqWp1miO4H4Q70tiEiU2yHLxTfXAqjTvM/gd/8yg8XNU
 RBMUw/OeRlztrsEskiXfB9oXzTlJUmHmtMci7uxBWC63qqVu6yphydOOPT0lwntgTzut
 grI72zLJRF6nGIzdXueoUa3YJ/Bght9iSxiL5y9pV3YIqb3UkG3PIYU6w+vAUAOuQRea
 B5M+dvdTZB0zh0LBmFW3Igk4PReDZ8W8YPjrUHhxIaR5WCVoxrgv09IHmeah8KF8BOHR
 5+zPPzw3pHrOMxDFq2EZir4BOAED8D4zpK8y73WpzwfO45sqk1l0iYthHg1EsHbY7ndx
 AE5A==
X-Gm-Message-State: AOJu0YxPRrqMfc4f85h26veZopW0PDqPfi87Za2zEwx/Jxni37Md/aZR
 Oi6sz6p0U6IcbEt0OKDruDumTKvMXYpDoEQCnhU+JxrrFdTZg5VeZaV1XSZK6Qk4dQ==
X-Gm-Gg: ASbGnctQnA0+I8ejLrvzOMpWUjS0ozPfoCVCU0JYpCBFPbiASwSPVvVv4sFmlt+ONBe
 RZhfKVATWU/HvlZ9TVbxSRwmIlLZpJugLI9yYM/UvXiSDNuZZtvGuNzkr/ktmYKZd7UhjkquM4g
 2cjoeKRgxRJYsxN6lXVsta2ga+yEE9XQn7aFJylApRGzt9PmcW8MSQfOwYwZrS6t3+74BiN/3BW
 GpJ7yTkiNqFdkqvI262MBJ1PubjQKMJ2A2p7xU5dB/CgldPUHwldAxV0elmHBWhxgKFK8ULN0TO
 pbb6NysRo/hrER1fSMOIvrc3yM4jm90phgjurRIJUQeKVBysSgUCeGKRpqovkN3OuGvspQ==
X-Google-Smtp-Source: AGHT+IHps2ex7WUHYRh1F6pfalqAS+t3xoH5n99yd6RdsrQzd/R4jAa7Rvgik+13jW6mwMSpuV3Rdg==
X-Received: by 2002:a2e:a98c:0:b0:30d:62a6:4431 with SMTP id
 38308e7fff4ca-3103ea9cad7mr8840891fa.9.1744296420337; 
 Thu, 10 Apr 2025 07:47:00 -0700 (PDT)
Received: from localhost.localdomain ([79.134.198.58])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30f465f77f0sm5397991fa.94.2025.04.10.07.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 07:46:59 -0700 (PDT)
From: Aleksandr Partanen <alex.pentagrid@gmail.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Aleksandr Partanen <alex.pentagrid@gmail.com>
Subject: [PATCH] xen: mapcache: Fix finding matching entry
Date: Thu, 10 Apr 2025 17:46:04 +0300
Message-Id: <20250410144604.214977-1-alex.pentagrid@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=alex.pentagrid@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 10 Apr 2025 16:04:37 -0400
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

If we have request without lock and hit unlocked or invalid
entry during the search, we remap it immediately,
even if we have matching entry in next entries in bucket.
This leads to duplication of mappings of the same size,
and to possibility of selecting the wrong element
during invalidation and underflow it's entry->lock counter

Signed-off-by: Aleksandr Partanen <alex.pentagrid@gmail.com>
---
 hw/xen/xen-mapcache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 698b5c53ed..2c8f861fdb 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -376,12 +376,12 @@ tryagain:
 
     entry = &mc->entry[address_index % mc->nr_buckets];
 
-    while (entry && (lock || entry->lock) && entry->vaddr_base &&
-            (entry->paddr_index != address_index || entry->size != cache_size ||
+    while (entry && (!entry->vaddr_base ||
+            entry->paddr_index != address_index || entry->size != cache_size ||
              !test_bits(address_offset >> XC_PAGE_SHIFT,
                  test_bit_size >> XC_PAGE_SHIFT,
                  entry->valid_mapping))) {
-        if (!free_entry && !entry->lock) {
+        if (!free_entry && (!entry->lock || !entry->vaddr_base)) {
             free_entry = entry;
             free_pentry = pentry;
         }
-- 
2.39.5



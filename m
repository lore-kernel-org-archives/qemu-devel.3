Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3C3C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xd3-0005La-IN; Mon, 06 May 2024 08:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xd0-000535-OG
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xcy-0002BF-Lj
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41ba1ba5592so12617735e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999171; x=1715603971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPkYetppSsjPcJRijyPbZW3TmA+wkAdtU1ccC5YsPog=;
 b=hf0bccvLPsJ3T279ELV5hRP8x7mJNaqgetWH4sWKJ3kiFIjq8zl5+LEZN6xiSL4OIm
 yqqg0CQ9dUDdzLOflj9mtJ2v+v8y/Nq0MEOJmH/I3gAWx0O1hG2LAQW2BGo03dp0Aq85
 8KsGN2tN0XzaDCPkQQ984aoYx9bXIkeR973M41V7+WlzIUD6pmgfSTx4Rp2ziF7A+g8R
 BbY6B6r3D/vIjGvDV5W0a1ugO7Vdv9rdkhhpbtBRYssj3EQ3tvTeT8X0M7KtQvfYM+eV
 np+7equ/PqWRmdi4TCORQEV3J1QXYln/mR6XzS4OENmo5FOKEZg1Z0XQ6LgVj4HPetVu
 xntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999171; x=1715603971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vPkYetppSsjPcJRijyPbZW3TmA+wkAdtU1ccC5YsPog=;
 b=BPoHyhZRJB5IStndVvoia/+qVZOhQfXVexyqT33xSzLh08eEFa2EM1OOdVCyzQF0BY
 KthQKxJMkyNVJBX9i6sigDU907PhGy7Sm1QiZ/QJJwpCpAUGfbL439UvCOZCyto7yuK0
 aO8Cqf5x+I0d/2KVRzKZcC88tKqSaHS6xF1KbE9Ma5i089xZ/79yzg1qRegSPNYJ1sTw
 zgWeBI8dThxX+raBxXiqmlf1NqFYkfg5jwQxJ/W3nr0AVbeWf8KwyB1KigUM4Lwz1FvL
 yvarajInVj6dgiNr3aCg9zXP+QavyhUXmA9f3wFE3RyYYYLC4zWapsXLswCsYOSUhJpJ
 /V4w==
X-Gm-Message-State: AOJu0YzYgODdqrzYXptT2gxtPnAVPdakFky2drdwFPrrcoxp1plqb9hC
 bvOryzIqChZdM22Lf80LeXNQaNNxFuD7P2ErJZkHs4CcFkBfNcf90qEV8/I20E/WKieTRl4anyb
 k
X-Google-Smtp-Source: AGHT+IFMwT2CU499T0HLrxuDWtAES8yxvtF878ta820SmEae4RndjeuacLoAIPnzOFdGp5hduuZ1Dg==
X-Received: by 2002:a05:600c:4f02:b0:41b:d973:24c1 with SMTP id
 l2-20020a05600c4f0200b0041bd97324c1mr9426655wmq.12.1714999170931; 
 Mon, 06 May 2024 05:39:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 bg5-20020a05600c3c8500b0041bbec72670sm16031875wmb.39.2024.05.06.05.39.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:39:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/28] xen: let xen_ram_addr_from_mapcache() return -1 in case
 of not found entry
Date: Mon,  6 May 2024 14:37:17 +0200
Message-ID: <20240506123728.65278-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
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

From: Juergen Gross <jgross@suse.com>

Today xen_ram_addr_from_mapcache() will either abort() or return 0 in
case it can't find a matching entry for a pointer value. Both cases
are bad, so change that to return an invalid address instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Message-Id: <20231005181629.4046-5-vikram.garhwal@amd.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-ID: <20240430164939.925307-3-edgar.iglesias@gmail.com>
[PMD: Keep xen_ram_addr_from_mapcache_not_found trace event]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-mapcache.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 7f59080ba7..7771c6cb91 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -395,12 +395,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
     }
     if (!found) {
         trace_xen_ram_addr_from_mapcache_not_found(ptr);
-        QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
-            trace_xen_ram_addr_from_mapcache_found(reventry->paddr_index,
-                                                   reventry->vaddr_req);
-        }
-        abort();
-        return 0;
+        mapcache_unlock();
+        return RAM_ADDR_INVALID;
     }
 
     entry = &mapcache->entry[paddr_index % mapcache->nr_buckets];
@@ -409,7 +405,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
     }
     if (!entry) {
         trace_xen_ram_addr_from_mapcache_not_in_cache(ptr);
-        raddr = 0;
+        raddr = RAM_ADDR_INVALID;
     } else {
         raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
              ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
-- 
2.41.0



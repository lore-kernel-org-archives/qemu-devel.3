Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E978FCCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIB7t-0003VA-VN; Wed, 29 Apr 2026 16:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QR-00087f-82
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QP-0007h4-7G
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:02 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b0046078so113902205e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777471079; x=1778075879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6CTSBzsBgkNvhDnVz+9h4ZL7e9PYIu5uJhtdDT/D+nI=;
 b=UwEqwGh2PYO4Gre5r7ocHwshvBFK4kVDivUiqWB8cOSpkA+bSilWJk7rWDdx5dcazT
 xpvJ9WdyCTrF4l4VJBNKJJ1SFN6o8xJajZkQa3nuEUK67JOHbKWqU9CkMsGA2+NoSKsB
 +UEjzOIFW+HNxlpIYIewF2m7bBP0khBLNZ2hXatTu+3l4b0eKD28eTU37ljm9xFRPsMZ
 loaM8rdlp2EIxKi0QMiBPo4syP1e/04kljBAsoP668qV3pzaICYJ3SzrxRZwWGVkoG7U
 DLiVucsfGkunMxE8ephG61jjIW/MjT3/JKgtdX2OAtsMYqcreVRqGp6exCc94bblRSiq
 mpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471079; x=1778075879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6CTSBzsBgkNvhDnVz+9h4ZL7e9PYIu5uJhtdDT/D+nI=;
 b=DOyXxu7PDL3qzzYo+EUN2PGVZYi8qtolWgFEn5iTfpRu+ubyP/DHiGfLL9YGn4O8u5
 YCTHHDGIYcRqSquwWI8ucL8rPeDU5IWeae6tjcKjXqbkR2NGCcxi3f2U2aLkpOjUZq5g
 kZHaKfTAB6bsGfQxw6Iv+8ic1+lOYatM7p2hD92WVnHtgQdv7nG029aWcwEBIT1gQzel
 Sir1YFDJ3IdY3GZbFGQEeZyTkXutmg86voPH7piut2vHBEgi/eDnTz8UrdVPwR1p4raS
 b1LSi1upLCmfxCNRkIg/9Mlr6d8oGvgMKh2AEODY1+/pqIRRCeKk0IOdO9bfsobg+nrf
 09Gg==
X-Gm-Message-State: AOJu0YwSKEszMOkHD6uP/gyXZQa5X/lNMepKpkNS928rv16NIL1u2SbQ
 EDrk9X2kn4xnS86wQ4VIv5Q2YeTbOUc8U/8NeMyM40QEyGPBeM4Fsqk4
X-Gm-Gg: AeBDiesSjhu9swlteLn77igY37+D0GZXEWrcv58g8gDRVlY6h3UxPgAshQ2hHgfcerU
 mCZfASWYkbtIXbVpoRhZLmLErjfEeHmjAAPzNO9MDEM6QZhqGTglmwpxGmAHbv/WSeXHrgRCNAi
 cEsqcq4V1vKlN5KJ/xEDDfDVW8YWc7ddX4wUix3dyRA7kcn2BLGoV+hS/yHXt53dfVV84bUlUzQ
 fjE6vVvLp+e2PfZsrOIPRNeVDrWVGmBZb3NSPY421HDA7+sQDQNXyP1u/Zz0cZTRVdKSsdPxqGi
 XwvFlLiuo1p6II9Bx/qJtOZEpx3R8kGOMn1dlxNoKcaj4ALzVaLWHFIcKoVWJB60nUQ+wk49eg9
 0Qmf9V2xivq91c7ggZI+GLNpmVzxnIvPzB9dBlYYxSD6tSdW1g3cXerKrq8RX2Vq8O+8Zy0jOdE
 V+JdN5qgCpbYWoj/rwOX1bAI++fyP4NA6AA0BL8cR9G6SqPalgk5pQhYill8MKftY7+FyLVKu3
X-Received: by 2002:a5d:5d0f:0:b0:43d:7b90:fa23 with SMTP id
 ffacd0b85a97d-4464a447024mr14262935f8f.29.1777471079173; 
 Wed, 29 Apr 2026 06:57:59 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk.
 [130.88.198.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:57:57 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 arpit1.kumar@samsung.com, Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 03/10] cxl-type3: Properly unmap the memory-backend
 on device exit
Date: Wed, 29 Apr 2026 14:48:37 +0100
Message-ID: <20260429135717.3048713-4-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=joshualant@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 16:03:14 -0400
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

Currently the backend remains mapped, meaning that if the device owning
the backend is hot-removed, it cannot be readded in the same QEMU
instance.

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/mem/cxl_type3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 68cd04b7d9..414c776028 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1072,12 +1072,15 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_destroy_cci(&ct3d->cci);
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
+        host_memory_backend_set_mapped(ct3d->dc.host_dc, false);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
+        host_memory_backend_set_mapped(ct3d->hostpmem, false);
         address_space_destroy(&ct3d->hostpmem_as);
     }
     if (ct3d->hostvmem) {
+        host_memory_backend_set_mapped(ct3d->hostvmem, false);
         address_space_destroy(&ct3d->hostvmem_as);
     }
 }
-- 
2.47.3



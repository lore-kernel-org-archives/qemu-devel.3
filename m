Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3ECCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 22:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEEE5-0005IY-T1; Wed, 29 Oct 2025 18:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEEE3-00056H-4p
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 18:01:03 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEEDp-0000P6-Rd
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 18:00:57 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so2635295e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761775241; x=1762380041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=duuy25QCgDexk3mrUIcN43kXo2ogvu1PpVOfOdefns0=;
 b=DmVbyDNXkSUqYW/jrbWXtyk6sPC/6gEujmVf4DbvOgZ6511DpB93MT00qvWlnRoTuD
 7HbQT9Njb/FTIL9rmLRrGi4Re3JIpZd3YM0zYTmXlJfy+w8gq92k+5HNzgZwMZAxBJH+
 0Sv7BtWwkoVTAGpUtwtLrAKPifNxMFXZWH5PVgMf6XBVsjIDObImoll6KFclxraoitoN
 kRXEO90Q0WHDkis4IMuxMAGGwVUDLcw0EisE+UG318V2GTJRWmxVPibwJEmj7ZR/adAI
 NFYPngQYy9nbtOvCSX17Dn/o0w7cTLC97h9EWe/xwTnieu/iy3paRO7bWl6M1SO4K69A
 c7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761775241; x=1762380041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=duuy25QCgDexk3mrUIcN43kXo2ogvu1PpVOfOdefns0=;
 b=rh4w1nbqHFCwwZtsjaXfXCanElETGqeJj/i4HcplnEEsDd89cgXx9k6fTnoW78iAYZ
 4iHwMZVHRR7pAhm9rCZlLXKde3uhP459BisYcpheAgYEx8qn38sdzOoPCW+k/qRBpxRO
 KssYEnM9rN+GI1qHvzVWIAb25t97EH8w4/tdGpil+mRp+bqCQq7V/ytYV18fuZVszVPh
 MMHYjIrx8XM+dE7XWG4x3Q5gnPoLbjsSrDSqFmLA9rmgy9fQXuGohz4s8OkKC26/+2Dw
 Os2fDcgHDTcnzj0isEw+YeaVNIh4fNePSshbirw1Uy2zKaXeoF39mDnQ77aPrx09z+Kj
 QdMg==
X-Gm-Message-State: AOJu0YxgeTV2j5DOwe8hKNVcp2Piw+LtyUcoI+iSwRTrgiYPdZHk9nOO
 ZLlZc/MImf1J+8/dj376biBU7rjI0/+TRwc+GyPr2bFLilmtIeQtwiOo+WCg/nDC5ANXNLxx/kC
 jqIDWZ5w=
X-Gm-Gg: ASbGnctWqXa7bq13tRju3YkqxIZngcbDsuW903bQvloeox19BTR+FQ7YghjnEc5VeDa
 5T+ow85rql7Qv7BsU2G9Z8HwVJKzMVNQlV/nEqdnHKyDTVqwsMtOTDy1rxVc/y8yOLq4muCxyPT
 UhoNmT+SHW4CTAnVfC3HTlym+YyWQNaqF67PVDt6GHyiRkZ37lF1E6ouDPMoZy0iRSfvkKNASm6
 eyXDFxR3Ec1MtVBlRj9Ria9/X2WV8M07zJecOk6LGu/GRy8vglmuewVdE6yFTMB/5QKNqOWIkx9
 q3D/ROkU5Gp4z06z2EOFtSxpxs8g9jxn/i3V3yqicRLSrrYeW6IdDJSAReavPddHG1skZiJZ1JI
 n8ABZroY0HJfzeDyJX5j9EGtMvffurBxK6pZoq8yYDmq5SxEsG78tU247vN+IHsZ/MZoPTwG6Ya
 cYtEPfnIIbgLJYdsEowa16Z4/ZF8/KBITOa0DG7WtXT+sYmNTYVg==
X-Google-Smtp-Source: AGHT+IFL+2b301wjnMEbUO9ieOfomnCRNXNE7IcsbQWokfS/W+DYoao33XsfSveF1YTos1EsQTTvLw==
X-Received: by 2002:a05:600c:4e09:b0:46e:206a:78cc with SMTP id
 5b1f17b1804b1-4771e1e1079mr46937445e9.28.1761775241498; 
 Wed, 29 Oct 2025 15:00:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47718ffa42bsm52858005e9.4.2025.10.29.15.00.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 15:00:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 20/23] hw/xen: Use BITS_PER_BYTE & MAKE_64BIT_MASK() in
 req_size_bits()
Date: Wed, 29 Oct 2025 22:39:57 +0100
Message-ID: <20251029214001.99824-21-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Replace magic 8 by BITS_PER_BYTE, use MAKE_64BIT_MASK()
instead of open coding it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20251022140114.72372-2-philmd@linaro.org>
---
 hw/xen/xen-hvm-common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 52e2cce397a..258014370e1 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "exec/target_long.h"
@@ -448,12 +449,14 @@ static void cpu_ioreq_config(XenIOState *state, ioreq_t *req)
 
 static void handle_ioreq(XenIOState *state, ioreq_t *req)
 {
+    size_t req_size_bits = req->size * BITS_PER_BYTE;
+
     trace_handle_ioreq(req, req->type, req->dir, req->df, req->data_is_ptr,
                        req->addr, req->data, req->count, req->size);
 
     if (!req->data_is_ptr && (req->dir == IOREQ_WRITE) &&
             (req->size < sizeof (target_ulong))) {
-        req->data &= ((target_ulong) 1 << (8 * req->size)) - 1;
+        req->data &= MAKE_64BIT_MASK(0, req_size_bits);
     }
 
     if (req->dir == IOREQ_WRITE)
-- 
2.51.0



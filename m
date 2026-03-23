Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DD4F483C8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iXV-0004aK-A3; Mon, 23 Mar 2026 12:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXO-0004Rz-6l
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:59 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXL-0000ao-NJ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:57 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so518688f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284834; x=1774889634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hQjqq3u97AoFafmWsWE1btsU5OiybkBrm5wYCU6VUyo=;
 b=XGOa5Z4gPPqUaaY47TIj5tJLVEAuCsmE9H2qq3VNtKzoZlCGugg1pCC9SER1Czb1U3
 Ahi1zJMCnWRNwvyfps+V+MuzGAsLxsWLxoWr6TRYV9xoPahdA+R5TZoFePb57tkxFJgM
 YWDFGLGf8tg8WpN5CmftRHau91OdpcHGvnRyCZYW99SIzvFZWTK/SSTMqS+noW0qR2E3
 VYhLzct/CfHcdGOjehdYdVXfZLxMptanKlK1xZkJ1h54kbEqB2/NaTNb/+VW5NBzL6wl
 LbFsdT37O9oLQiMqJQYWqRpaKMokzveQsxZ8pI3oRA8AIb853/KZA5wyIARdoD5yMKiB
 uXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284834; x=1774889634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hQjqq3u97AoFafmWsWE1btsU5OiybkBrm5wYCU6VUyo=;
 b=n21I/a2QgkCOPHia9OFN5aTmuhrnIkk6ZpZcINHFatXzoIEWmHmVWbr8JeDyxu5Glv
 CPBCHCzp3/Wi8VGllQAuP9g1bszgYwRotvTdRF2mcUijVxXWHaHb1J2XnTTfWLOrIGog
 Uv6EmCHAyFC5JxlzJ419HrCf3rQlTkkyaq06ZE4he68JgrD2xcy1yNw1dHgcxYUWk9tY
 Fa7hzsRg8hj2F1/LOgVlAbnidKgyaFEe113pcx1VLz5EdtStWh69ACyk+u/ou9M/0Aqw
 FlNu0ymijsJiFrAXqGBQZ+X2kss9GaXYAySag2SCA4cpPP7LLFfd3eEbbCpgrTW5VcB/
 ogzw==
X-Gm-Message-State: AOJu0YzRvpgQEWSIUKecTDRYr3RDI/UJOqcaca9hmIAqllXXwrllxyYh
 xaCJfO8GeRsWzT2wsiMWCBbRpJIPESMiS5uIq433t9nTqYUypTZwoMAvqAP5X2KmGkUnV0+OLj/
 ds2e0zCE=
X-Gm-Gg: ATEYQzx2IMmBfaTkofrGFmZW197GBswyWzR5qEysOrxxgH6A35lqNf1z9lGVT5JQq3W
 M8FTl3yc5gnerFloKZtAmWHeJtBKrg4mHaSsbD9c94uhSY35mJPzQv75J6vRvA0YPvEsD1ZPDGl
 La+MApB9CfKOaCsMIm8lyY6u7c/+XMfIjCyHjed36KqXaMH3gVWFCmTnhJODwk8pgmM4F1biVhZ
 El544uQpVstzpMtZ3unZhKhH5XeZUVGQMdqZpR18AFORxok08sMgOU/O5zuHKVLVRHkTU8NNda9
 rXVt+P5B6U4Gljyt2qXLKmcWRzu8y921Kq2G0b1CRcVfOFLgT67eFjRly+0Xyj8zVOd8c+cUfLB
 qWJgxKHu+GpPXgtcbEaz8pnN/bbO0D/oRtz2u58J7/a8Al3LvfHAyS3avEBEi1O1werRNUn8e8g
 2Kn7UvbNvMD3QpTg6IMLCtmczNgahht1L7kXNuKPeX5/Sb7eP3SHJwlluRGLuqwhN8nikT/M65+
 gIP7SkNbdk=
X-Received: by 2002:a05:6000:4282:b0:439:b791:f920 with SMTP id
 ffacd0b85a97d-43b6423faafmr21067741f8f.17.1774284833835; 
 Mon, 23 Mar 2026 09:53:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644ae048sm30843201f8f.1.2026.03.23.09.53.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:53:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/27] hw/vfio/iommufd: report hint to user when
 vfio-dev/vfio*/dev is missing
Date: Mon, 23 Mar 2026 17:52:05 +0100
Message-ID: <20260323165218.96607-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Give a hint about missing kernel config CONFIG_VFIO_DEVICE_CDEV.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260319205942.367705-3-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/iommufd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 131612eb836..3e33dfbb356 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -274,7 +274,10 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
     }
 
     if (!g_file_get_contents(vfio_dev_path, &contents, &length, NULL)) {
-        error_setg(errp, "failed to load \"%s\"", vfio_dev_path);
+        error_setg(errp,
+                   "failed to load \"%s\""
+                   " (is your kernel config missing CONFIG_VFIO_DEVICE_CDEV?)",
+                   vfio_dev_path);
         goto out_close_dir;
     }
 
-- 
2.53.0



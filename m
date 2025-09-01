Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16301CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut427-0002S2-RP; Mon, 01 Sep 2025 08:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut425-0002QA-RT
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:53:13 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut423-0004Jl-FQ
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:53:13 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b042cc39551so132424366b.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 05:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756731189; x=1757335989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pd+2JDdfFwuawP7wDOXmAy8XWU5BClWFTFIACcDZ1/g=;
 b=okt85dMFhDBrNfezzIa+U0iCgSMXVeZM7LDmnZ3me6Asb+CeY75hnFivQbWqd5n4SI
 463LoyGtB6gjmDMw00MQlMfcLNI/th7nJga89XyK2IiB84LNLpoMz/8cghOdyUQPR9PU
 pda0e+8+d+gka/IsJ+zlV+cy80/HUlYhMMycwWfRYt3svclkpGpi6BKKqCG/kidkOW07
 XwUtG7nrKTYBsjkHngyEt+f2mKIBkPYsHSzNV0TbirJBkMxDtQVsBvVXfSDldv2JUZkb
 Oc/yZpQXl6J2ziLti0ZmfffBsZoISgqyo1R9og+MD1SiHWpBKSin3L3xQLWg1fD5oxIY
 1qxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756731189; x=1757335989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pd+2JDdfFwuawP7wDOXmAy8XWU5BClWFTFIACcDZ1/g=;
 b=QwYU56+a1w+yGALzev/Ukc940vpFk1BVpyeQNLD4+07lp+UYtb5QGxyMQgHfSMg7lj
 XkjrxVmbkgGx12l1h9HkyYGpfUBY9wRgayjfnUzP65ATnUWNbeNVDIcbEC1bFCunzx7b
 3HH+mIiaSFBGgTv/QfqmZtSRyafou0fow8at4f7yG8hU5bX6PNUsCSmJT1+VnGf8vjZb
 1bUykelw4kF8Yc4sIswV3SnpUyiAAvJA9YlDaNYaxG1irc0u53A3mpDpMx3a/54iL9Oi
 k3xiXOZqTEEFJdG5RjhY/gZkY+jSYew8FBRgO6bMpvU3nEu4Wtdn28+sMGT+r2/+0P/d
 cD9Q==
X-Gm-Message-State: AOJu0Yx88i7s80rLAuWO3wE0gw5xSbrOeW0gD3Fy3UmBEfUPmI50b48T
 Z+25+wCFiqGBYbuSG7m0uW9+jI5qU9Tqjy+Fqbi4aKqBAQxGLrfa4D4e2FzJugqveS4=
X-Gm-Gg: ASbGncudXlkATqhElHqLQ391jbx4ma7FMOkb8yMR6Agvi26u/I99aLOhhdxNX00No6A
 56PPnAEnVQVa3/UT03OdUVkQV7ygVHYrQQILTuXwT45TJIIOirAv3TqphkDq0sbxlSQgvYyDg3u
 L/UcrgdXRLG12XMP4d1O1muL6YIn1O80jVBvze16mmo7VDbmh+Jwb1gmXSfBDIVhjK0URU8Nfiw
 KOOTKfLYq1uvI8YZYC3HlA5hWLlxP7T1t48kmtjBfbbB1bTUJMcPDRnpwKyACm3eRhQFW6HKQ3q
 9DcVELBsOmUaaeCBXQvqq9kIBgRcwYJ1afIw6TUmeBH0eFbnXvlYMuV3t+TTBw1f96SdN4yi1Mf
 4RPDneZy6MKjtRvOGA7/TRyY=
X-Google-Smtp-Source: AGHT+IFR2ofR8BC43gwtMFx0eNeY9up3YTCSQsBXf6ChNjE8mxzM4irzoQwDJPzn9uvfHo+TF7yp4A==
X-Received: by 2002:a17:907:72ca:b0:afe:764d:6b19 with SMTP id
 a640c23a62f3a-b01d8a25c86mr744822966b.2.1756731189267; 
 Mon, 01 Sep 2025 05:53:09 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04241b2e7esm299693366b.43.2025.09.01.05.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 05:53:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 16E695F829;
 Mon, 01 Sep 2025 13:53:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/4] hw/arm: use g_autofree for filename in arm_load_dtb
Date: Mon,  1 Sep 2025 13:53:01 +0100
Message-ID: <20250901125304.1047624-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901125304.1047624-1-alex.bennee@linaro.org>
References: <20250901125304.1047624-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

The function has quite a number of exit cases so lets try and clean
things up with g_autofree. As the fdt hasn't be allocated yet we can
return directly from the fail point.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/arm/boot.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d391cd01bb1..56fd13b9f7c 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -528,20 +528,18 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     Error *err = NULL;
 
     if (binfo->dtb_filename) {
-        char *filename;
-        filename = qemu_find_file(QEMU_FILE_TYPE_DTB, binfo->dtb_filename);
+        g_autofree char *filename = qemu_find_file(QEMU_FILE_TYPE_DTB,
+                                                   binfo->dtb_filename);
         if (!filename) {
             fprintf(stderr, "Couldn't open dtb file %s\n", binfo->dtb_filename);
-            goto fail;
+            return -1;
         }
 
         fdt = load_device_tree(filename, &size);
         if (!fdt) {
             fprintf(stderr, "Couldn't open dtb file %s\n", filename);
-            g_free(filename);
             goto fail;
         }
-        g_free(filename);
     } else {
         fdt = binfo->get_dtb(binfo, &size);
         if (!fdt) {
-- 
2.47.2



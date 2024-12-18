Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FA7E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuLW-0003Jd-Ty; Wed, 18 Dec 2024 08:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKr-0001d7-Ig
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:36 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKo-0005j8-VK
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:33 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3eb6b16f1a0so2044460b6e.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529409; x=1735134209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hYPSVCXy6YsByONF1w8AEuukfDdwrauSD2FWZ6zJ6lM=;
 b=Vf5eJjOCLEBirjwprzMFzKksKZLI2J6J31mFd+PEF2EOReP4HxbNwQ9kL12j/TbIRn
 W509anMHDvLg7W8ud/MKaSPbE07/BhTKwcoKE50wOaPMlQOJaKfWgiatwah57zz6y22K
 oLiXYg0j6WgIBWdsOS/rqq+089JmZNCy/vRE36+Xrz/X4BzwRBNP4kSQX192FG0MjpIf
 RlyeRJ23+IhXBC6Gz3tiXU5o52ZscACqxiYKY2XMB83zOq9TealwoM4oVfAOQnlztVk0
 9NBrSbT36YCmgv1bovSptscnzpTOYSq9+9UyILmAXV3OPUoLAt677+JoP5tRsoKvNPs4
 tjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529409; x=1735134209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYPSVCXy6YsByONF1w8AEuukfDdwrauSD2FWZ6zJ6lM=;
 b=xEbjyzYSGsu14HHwKINT9tRcJy7miZKxFsZ29UsXIimV6T2I2wzHV/BfSQXsgNbXML
 mWfmLx/bYxR5wixEIQtxJS+BiaiEgy9C1wPoTcMePVy8kbmDx+rmsSGECSCMX/7UVJk5
 gKkf5rNiwni6wtQQKnUUQf/SSESe+Ooh9++soSMXJhLC3mUVjsm+QkVvvyREYCWxd8VY
 mhTEiOYMwitjwtLvbZHc1uHh5/xRkU8aHfxf4321Bn0Q9md6T1q6z8MY473k2/2ulKWh
 GJiEFUxG5/zn/nSYfCJc5pUgJWlSo3ZOoLStJGeBC9cEqY8cYGDjeNKsDa8APY1bBbyx
 UmSA==
X-Gm-Message-State: AOJu0YySVmtZjPkVFGSli5xDVGchSdGiwUSOiZnLiOdl3pv5Z8mxav0C
 fbzKevtrUO7KE5ngQ1b1P9KpOU0XYowrjQoFJFSWcXUpief0L69CMVKReB1UBYA1aqYigtjLBab
 XLbpUGXir
X-Gm-Gg: ASbGncvH1HvxOht4RN1DQOu6rjdqj0NaBv81uwaAfaBqx9l8D4YuVGhxb1W4cAhbxqD
 Qwd+Y4G8YYyH/vJiS1YeNxX7/EocjMx05vOuCFAnZCYtwVcSijPPtUIjPN01SPd4qAQJKeNfBUV
 e4PiZ5k2gHXsnucxvbxTVkU043Ofwv7MzodMAj5TQJ2vZXftAkJYlPR8dYevaVCp/OYp+3uxPQm
 Zf7CpC4M1mJqxCdCR50Vh9a/0w7ToeaJ2SM47FblZ84lwf4uzDlKcS+n8Dv+8qO
X-Google-Smtp-Source: AGHT+IGqrHQkjSQAQahoS9as5k2ZjTrUE37JHg/iCK39wZqhf9PFN7MwE9MbiXf4+lYeAN04XL8nlQ==
X-Received: by 2002:a05:6808:1a15:b0:3ea:519e:cc71 with SMTP id
 5614622812f47-3eccc0b7374mr1482834b6e.39.1734529409226; 
 Wed, 18 Dec 2024 05:43:29 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 23/24] hw/core/qdev-properties: Constify Property argument
 to PropertyInfo.print
Date: Wed, 18 Dec 2024 07:42:50 -0600
Message-ID: <20241218134251.4724-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

This logically should have accompanied d36f165d952 which
allowed const Property to be registered.

There is exactly one instance of this method: print_pci_devfn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/qdev-properties.h     | 2 +-
 hw/core/qdev-properties-system.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 447767688b..bf27375a3c 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -34,7 +34,7 @@ struct PropertyInfo {
     const char *description;
     const QEnumLookup *enum_table;
     bool realized_set_allowed; /* allow setting property on realized device */
-    int (*print)(Object *obj, Property *prop, char *dest, size_t len);
+    int (*print)(Object *obj, const Property *prop, char *dest, size_t len);
     void (*set_default_value)(ObjectProperty *op, const Property *prop);
     ObjectProperty *(*create)(ObjectClass *oc, const char *name,
                               const Property *prop);
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 22ea1ed358..1034e9b580 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -869,7 +869,7 @@ out:
     visit_end_alternate(v, (void **) &alt);
 }
 
-static int print_pci_devfn(Object *obj, Property *prop, char *dest,
+static int print_pci_devfn(Object *obj, const Property *prop, char *dest,
                            size_t len)
 {
     int32_t *ptr = object_field_prop_ptr(obj, prop);
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9ED9E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuKS-0001IF-2I; Wed, 18 Dec 2024 08:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKO-0001Dr-0o
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:04 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKM-0005e8-8t
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:03 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3eba583fbe8so1845159b6e.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529380; x=1735134180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ht4ZlthGspVYtEWG+5uRpgdlGJS5T3fuIdiO1kKsIqU=;
 b=E0xSH12XFmZy1DzKKswlOhi8K7dJWyGmg1xnUespHTC6tWgXo/YaFPunUsLUpefT5X
 eXW9nVHY4L3Brzu2oW8Rbrku4FLk6coIpb5FhIQBBRfvSGti1wtxXDxFl8VgmqvqmCjE
 YW4EbFOWHejLbdWlJctukKWlUe858bSLCaH6M2CTgOAKnm174U0AWtqIHQvQDGjZh7cG
 8cybpH2SrQUAzG5JOBjdDxf/3wUHQrxpALJW/3ge6s3Lcy+12sQLjexVHHAdc47U4Ty8
 fHG9/nP6iGfvhHbGa3O1dVWe+Z/1bdSZ561mi1uCM9ebwS0N0x7jy+NFtlb4ncIPpgiD
 f4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529380; x=1735134180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ht4ZlthGspVYtEWG+5uRpgdlGJS5T3fuIdiO1kKsIqU=;
 b=RQO4dxrccRpXAbash0TQFSBpV9TdedzJ4T8ECwkkQ78D03FueeSG+eZEh694g326VR
 rvors258bDgnzE7e7V458K5pqEP9omsBq2EPEbiTzMeZAF/75DnMZh8gLi4bO4souEZA
 nrw/cmtOkjK6A6u5Z+JfYajpUbEuf+BuEYF5e8VQ9GtsZA5O2rlQXmPra2BqeDG2wUSG
 MSIkN6BlSr7/ABmkDoOan+2iLjcu2JaebxLvueK5/x5WKVOb2SyppfB86dR6KX9Oy819
 HHPehKwKvAXj8l1cqKACk5c1dcuTi4MqK6hHFGFQ8yIR7KetqkJZS8o9DXx3/+W8rcRQ
 LG4A==
X-Gm-Message-State: AOJu0YyY6kEByTfblbLP3cDEaYcXvtZp9PstUGEPg2dajPVEDgWM+DN8
 g0EO06AziOqNyXKEp/edBPdJQxhU5q9BPpE5NrlHtbDmVtwKGNQRNqn6tZt41aIlXWfvoEz7nEk
 /HPfvuoFB
X-Gm-Gg: ASbGncsYxCtf8iTBcNcxqUFcuZCEsrSNY9qZLADy0LcpXJZZJng4iDCWy+yoaBKC3r4
 L1w0OBSx3KEWR5PTzV7WOEz/+2Pa0mVYykhw1glC2t5yKFogBskdSm5Uk1bUbyte2craw9q6nps
 EwgdcSPCShhkP7JpUPPd5JIVa0SRljk5EP+ZAahIAYQ5J19OsLS6X5ynZbB0osi44a0D2WlFgH3
 9/lRexP9tq+ez4PBGHH8EJ8LYKJoI8EWeLRrL28g/2pYE2MsWsDrHai2CIXAwqe
X-Google-Smtp-Source: AGHT+IEkGWN8l2cQqJfcFFTCZU+at0N2RhRNhdwRubNa3q+c7Esw5pNoS+dmPU7v92g5J4YdVIVhFg==
X-Received: by 2002:a05:6808:19a0:b0:3e6:147:6c5 with SMTP id
 5614622812f47-3eccbf4b348mr1756778b6e.10.1734529380513; 
 Wed, 18 Dec 2024 05:43:00 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:42:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 05/24] hw/pci-host/astro: Remove empty Property list
Date: Wed, 18 Dec 2024 07:42:32 -0600
Message-ID: <20241218134251.4724-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/pci-host/astro.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 379095b356..62e9c8acbf 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -461,10 +461,6 @@ static void elroy_pcihost_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), elroy_set_irq, ELROY_IRQS);
 }
 
-static Property elroy_pcihost_properties[] = {
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static const VMStateDescription vmstate_elroy = {
     .name = "Elroy",
     .version_id = 1,
@@ -490,7 +486,6 @@ static void elroy_pcihost_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, elroy_reset);
-    device_class_set_props(dc, elroy_pcihost_properties);
     dc->vmsd = &vmstate_elroy;
     dc->user_creatable = false;
 }
-- 
2.43.0



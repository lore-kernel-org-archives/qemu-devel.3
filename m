Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F49D6E2DD
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 08:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDgSl-00008P-CH; Wed, 20 Nov 2024 03:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDgSg-000070-9A
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 03:53:22 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDgSd-00053H-BC
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 03:53:20 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53c779ef19cso6546185e87.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 00:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732092797; x=1732697597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iN/AqNy/hKljQubEThCY6fG1Ip1/THaEqT2SsGhQViM=;
 b=g+D6trgUFFMXJ3XudxFedLF0n6je+FR/19zH/SZD3s4H0BKHuTGFOtujz9L7rLGpRF
 WxcczAbjiMckweif30xH9fecj7bpuoQbubcmCYUHhjfSJPuvSbQLuPVYmu9ilxP1tUNN
 5TXENSJx+LNgCJWb4Lo+Ludd/5A1NY93mc/1FVOAuDyfGoT9FWPC5JdEKnpTt96PQCUo
 FFljDT55zMpkZpUNru6ZMS4+Wul5qR9C93l2m6UeAnMSPSxYETCH/Z6Z9A1uhr8AiGKK
 9EQ8EtUltGBW+VxDQuyFgbtRklrYpKhVy5kl3vaWgL7qMBthY6vEJQYIjZS9hYeQgDr6
 bSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732092797; x=1732697597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iN/AqNy/hKljQubEThCY6fG1Ip1/THaEqT2SsGhQViM=;
 b=LZdc16u+xiarZNGpQCcq3mutZdCqvWyxlwB2Cuj/F/bIVot7SoEx0suIWn1WNhzT+X
 2fDX954m5zoY6Nu5AXKkFG5V4KerpYQFPMY4DVHTp8hurVda4HHw2lWNI5fAbbUisxFf
 BZMowshanTebvu2ZBoGZtvmKG/6vNAolBNU0eYTzBsB2FTEuGBiuSpHyGYVUm2oOoz9S
 qILJW8t+WEBeZ5IcQT50NfK+kVYDxrSXfpjj4CdJ5CpPiYSD7omQ00EXE4YPKzybAJkb
 bNs0kbb3z9W5yeIFncaLFARdfPXz+Alteyewp12fWl6CO9QMpnBN5I37Q1HrJudY7U7j
 2U1A==
X-Gm-Message-State: AOJu0YxJrJFmNJApaFDS+a1OUprpr3w645sUBAAJ9fM6YI65ZpygyFyR
 txma4joiRQqF1u8jPezIhlGpSgZMc20NmtCRfyzuXeug+BxfSCjMm+5+GSPd3DwL6KHFSRfvmN4
 V7Mc=
X-Google-Smtp-Source: AGHT+IEtSSCWWKMeSnUZaa6TANBJoF6/z6xYiQpE46mwhh3spO8Jt9gtUN/q94Xg7UuvqyBAmpaZaQ==
X-Received: by 2002:a05:6512:b0b:b0:539:ea49:d163 with SMTP id
 2adb3069b0e04-53dc132e21fmr605456e87.21.1732092796868; 
 Wed, 20 Nov 2024 00:53:16 -0800 (PST)
Received: from localhost.localdomain ([176.187.208.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b0139b22sm11956555e9.0.2024.11.20.00.53.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 Nov 2024 00:53:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] hw/scsi/scsi-disk: Avoid buffer overrun parsing
 'loadparam'
Date: Wed, 20 Nov 2024 09:53:00 +0100
Message-ID: <20241120085300.49866-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241120085300.49866-1-philmd@linaro.org>
References: <20241120085300.49866-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Coverity reported a 1 byte overrun in scsi_property_set_loadparm
(CID 15657462). Since loadparam[] length is known, simply directly
allocate it in the device state.

Fixes: 429442e52d ("hw: Add 'loadparm' property to scsi disk devices")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/scsi-disk.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 96a09fe170..f6d6b7c1ea 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -38,6 +38,7 @@
 #include "hw/block/block.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "hw/s390x/ipl/qipl.h"
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
@@ -112,7 +113,7 @@ struct SCSIDiskState {
     char *vendor;
     char *product;
     char *device_id;
-    char *loadparm;     /* only for s390x */
+    char loadparm[LOADPARM_LEN]; /* only for s390x */
     bool tray_open;
     bool tray_locked;
     /*
@@ -3145,19 +3146,12 @@ static char *scsi_property_get_loadparm(Object *obj, Error **errp)
 static void scsi_property_set_loadparm(Object *obj, const char *value,
                                        Error **errp)
 {
-    char *lp_str;
-
     if (object_property_get_int(obj, "bootindex", NULL) < 0) {
         error_setg(errp, "'loadparm' is only valid for boot devices");
         return;
     }
 
-    lp_str = g_malloc0(strlen(value));
-    if (!qdev_prop_sanitize_s390x_loadparm(lp_str, value, errp)) {
-        g_free(lp_str);
-        return;
-    }
-    SCSI_DISK_BASE(obj)->loadparm = lp_str;
+    qdev_prop_sanitize_s390x_loadparm(SCSI_DISK_BASE(obj)->loadparm, value, errp);
 }
 
 static void scsi_property_add_specifics(DeviceClass *dc)
-- 
2.45.2



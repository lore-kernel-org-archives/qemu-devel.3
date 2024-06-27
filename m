Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CDCC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 07:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMjHz-0006My-PF; Thu, 27 Jun 2024 03:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMjHx-0006MZ-7L
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:11:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMjHr-0004re-I7
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:11:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42562e4b5d1so6191875e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 00:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719472275; x=1720077075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MqiVMmEkjN8Fbce556VJrgK/N9f2zTrZ51XC0SKKdOs=;
 b=dNTPYXO/TYDtHmvMRq7xpMXpaso6rb6AJ09tB36mJD2kr8iYgUMLnOWXaquTuf8t03
 7pKU95CAW6EkYv/T7v/vOXE91/nsSb3pVWEPV+m9mwaok3DjE9m+m0BR3SKYbRdmdeYO
 oe0JGBK3sXteti5/1GhVTjQgrbwWVUMhiVZUmuzR4rg9hbJr1JFfpG3jN2nyspb1SgK+
 sFCh5255JxubzO7fhDzwymshXZ8+EmetU9hPM1HZ+h4S9cHk4Rh8+rTIhKKK+VRQw25u
 /GiFqC9XJUaOiH7LxhB5LEFqUX+nCur2pMi9ovttNUvi3cThkxN4A2TSlW6v9hcelKDF
 vuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719472275; x=1720077075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MqiVMmEkjN8Fbce556VJrgK/N9f2zTrZ51XC0SKKdOs=;
 b=buQvE25Ny7CxlPbgAqgNaYz1MRtQKBd8RGT92dfymOfAxW7NCQJ8ImS6c5jIlTQ660
 RbeM+Z+nwIfqDmMb8dboaI7q4VOEilf35RGmMSB87bODexQOce0k86vrcWGPa6U59cEy
 s3oa8fU/6hdD5lOeEtRO5Os/U2Iu5jWeeMAXSL7ceOCug+2G5a1jllMSP5WvefMinUxX
 M9JKZlFx5P9ghj5XjDJpjKom0vHp+O4LX+CSobGrhFoxW4rurs2vgi0/RUsDufrB809W
 flxDyuiE4S2JgpfRYyRKURPEJKsZb0GqAqUUTNbeiPdtslh44cIuLkvSvM9cGEPmjkx6
 KafA==
X-Gm-Message-State: AOJu0YwevEZwjwVIBkaqOLi+W1ussY2d1LGidK61ZtV1Bdy50cL+EJfa
 HTcp8gJYT5NgMdppAN081qkLagrMcwYBh4UUWY5asVUqA/vALRdU9BEEI9z9sZj6oDlWPQ9nxN+
 HsbU=
X-Google-Smtp-Source: AGHT+IE7FxGYasAWUuBxHkZ8gDR0rNja73NcLQilBhDLG513Io6NpXHqyZjn3C23nBvscKrjRIFb5g==
X-Received: by 2002:a05:600c:434b:b0:424:abd7:2321 with SMTP id
 5b1f17b1804b1-424abd72412mr35969995e9.12.1719472275489; 
 Thu, 27 Jun 2024 00:11:15 -0700 (PDT)
Received: from localhost.localdomain (163.red-95-127-40.staticip.rima-tde.net.
 [95.127.40.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564b7baa9sm12357225e9.22.2024.06.27.00.11.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 00:11:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 devel@lists.libvirt.org, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH-for-10.0 3/3] hw/sd/sdcard: Remove support for spec v1.10
Date: Thu, 27 Jun 2024 09:10:39 +0200
Message-ID: <20240627071040.36190-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627071040.36190-1-philmd@linaro.org>
References: <20240627071040.36190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Support for spec v1.10 was deprecated in QEMU v9.1.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       |  6 ------
 docs/about/removed-features.rst |  5 +++++
 include/hw/sd/sd.h              |  1 -
 hw/sd/sd.c                      | 12 ++----------
 4 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 02cdef14aa..ff3da68208 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -362,12 +362,6 @@ recommending to switch to their stable counterparts:
 - "Zve64f" should be replaced with "zve64f"
 - "Zve64d" should be replaced with "zve64d"
 
-``-device sd-card,spec_version=1`` (since 9.1)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-SD physical layer specification v2.00 supersedes the v1.10 one.
-v2.00 is the default since QEMU 3.0.0.
-
 Block device options
 ''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index fc7b28e637..dfe04b0555 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1056,6 +1056,11 @@ by using ``-machine graphics=off``.
 
 The 'pvrdma' device and the whole RDMA subsystem have been removed.
 
+``-device sd-card,spec_version=1`` (since 10.0)
+'''''''''''''''''''''''''''''''''''''''''''''''
+
+SD physical layer specification v2.00 supersedes the v1.10 one.
+
 Related binaries
 ----------------
 
diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 2c8748fb9b..362e149360 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -56,7 +56,6 @@
 #define AKE_SEQ_ERROR           (1 << 3)
 
 enum SDPhySpecificationVersion {
-    SD_PHY_SPECv1_10_VERS     = 1,
     SD_PHY_SPECv2_00_VERS     = 2,
     SD_PHY_SPECv3_01_VERS     = 3,
 };
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d0a1d5db18..37a6a989ee 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -168,7 +168,6 @@ static bool sd_is_spi(SDState *sd)
 static const char *sd_version_str(enum SDPhySpecificationVersion version)
 {
     static const char *sdphy_version[] = {
-        [SD_PHY_SPECv1_10_VERS]     = "v1.10",
         [SD_PHY_SPECv2_00_VERS]     = "v2.00",
         [SD_PHY_SPECv3_01_VERS]     = "v3.01",
     };
@@ -371,11 +370,7 @@ static void sd_set_ocr(SDState *sd)
 static void sd_set_scr(SDState *sd)
 {
     sd->scr[0] = 0 << 4;        /* SCR structure version 1.0 */
-    if (sd->spec_version == SD_PHY_SPECv1_10_VERS) {
-        sd->scr[0] |= 1;        /* Spec Version 1.10 */
-    } else {
-        sd->scr[0] |= 2;        /* Spec Version 2.00 or Version 3.0X */
-    }
+    sd->scr[0] |= 2;            /* Spec Version 2.00 or Version 3.0X */
     sd->scr[1] = (2 << 4)       /* SDSC Card (Security Version 1.01) */
                  | 0b0101;      /* 1-bit or 4-bit width bus modes */
     sd->scr[2] = 0x00;          /* Extended Security is not supported. */
@@ -1241,9 +1236,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 8:  /* CMD8:   SEND_IF_COND */
-        if (sd->spec_version < SD_PHY_SPECv2_00_VERS) {
-            break;
-        }
         if (sd->state != sd_idle_state) {
             break;
         }
@@ -2231,7 +2223,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
     int ret;
 
     switch (sd->spec_version) {
-    case SD_PHY_SPECv1_10_VERS
+    case SD_PHY_SPECv2_00_VERS
      ... SD_PHY_SPECv3_01_VERS:
         break;
     default:
-- 
2.41.0



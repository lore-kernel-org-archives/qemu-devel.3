Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7119CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurUw-0006CO-6L; Thu, 11 Apr 2024 06:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurUK-0005MV-IU
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:17:06 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurUH-0007bF-CO
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:59 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d700beb60bso123181411fa.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712830614; x=1713435414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=urm+Npyj3/f/E1cmlvhojimXxZbt++WU9CB9v2xORc4=;
 b=OSBc6wG+2rBkcpRghqTREESEvkDIHxU1tiW/aopm0NA7XmJngLRzAOe6LpUUKgrLVU
 ruuGvQbRRl2zRHczezhHm1a1ncYO6IB1D/U3OMvxdygk6SBCL3D9LvtSACmuj/DFF5d6
 qxs+EhjitLV+NfXTjS2+Ra7MX91wYwTe4aqerPZeuPXGlNvEju3eZ0sqb03Qm8vF0tAi
 PLplMIXcntOsJpZNuzJrhuP6YguSjGggNrQL7ZILHAz25rn1vav7OqHgkTn8ggh/elck
 U3Xu/lU20+0Lxr4+KB8gFCrhgqtZI4hc7BqSjIWh5rPgWEO+zFKAxtGtpvD4DAxDdgAM
 NRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712830614; x=1713435414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=urm+Npyj3/f/E1cmlvhojimXxZbt++WU9CB9v2xORc4=;
 b=cWA88EKt7UudNfaAHl/UjoTP+EjTIUWyG81LtqVnU6XylQ7bsFHixDIlJPv1Tmho6/
 Hjp1dy1dD7RPJFTcQWNHBkIYVYTplejJHR/B1+NPAWwpmwgO2WfYad4ZecX/pqzDV1/n
 y0PLJxseenovKnQLaiiJEWHPkqztZrUFId/eupdf3dJmK2YfDWlnS/+py5SLqdYc+c1v
 Gy4NhUoagBGwr14hV2UErsQF0NJXp4ZYGzISXTelVTXy25//lJIFxmYIQwE09Ry1iZeY
 hmCTD1nF5pWfJe/DtCrxwRAZtSpOvNUM+IethXQHbIiDMtnUjf4mRt0+2Hy1ArKK2oIg
 LsYw==
X-Gm-Message-State: AOJu0YxQBl7XLwwPb1wKZQjlrNnGBrzCzKqnm8sXDjNaOFV9rbzgT09Z
 0QvJ8advIrvLoTwQOPniSBqQSbMvkmZoUz1YoE4qEHikSO6lsuC170B8bsx3PPiBdF8Qlp+63el
 Qv+A=
X-Google-Smtp-Source: AGHT+IG9+lkMVPvqfPMMsIhH6GYCZs8mJ805Y9tsJCi4f8ryfbo2SNvTVUSv7O8vg7Yr25j2umi6hw==
X-Received: by 2002:a2e:9317:0:b0:2d8:5fe6:820d with SMTP id
 e23-20020a2e9317000000b002d85fe6820dmr4355192ljh.11.1712830613862; 
 Thu, 11 Apr 2024 03:16:53 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 iv11-20020a05600c548b00b0041665b6e111sm5064848wmb.12.2024.04.11.03.16.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:16:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 10/13] hw/scsi/scsi-disk: Use qemu_hexdump_line() to avoid
 sprintf()
Date: Thu, 11 Apr 2024 12:15:46 +0200
Message-ID: <20240411101550.99392-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411101550.99392-1-philmd@linaro.org>
References: <20240411101550.99392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience.

Use qemu_hexdump_line() to avoid sprintf() calls, silencing:

  [105/169] Compiling C object libcommon.fa.p/hw_scsi_scsi-disk.c.o
  hw/scsi/scsi-disk.c:2659:14: warning: 'sprintf' is deprecated:
    This function is provided for compatibility reasons only.
    Due to security concerns inherent in the design of sprintf(3),
    it is highly recommended that you use snprintf(3) instead.
    [-Wdeprecated-declarations]
        p += sprintf(p, " 0x%02x", buf[i]);
             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/scsi-disk.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 4bd7af9d0c..4f914df5c2 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2648,16 +2648,12 @@ static const SCSIReqOps *const scsi_disk_reqops_dispatch[256] = {
 
 static void scsi_disk_new_request_dump(uint32_t lun, uint32_t tag, uint8_t *buf)
 {
-    int i;
     int len = scsi_cdb_length(buf);
-    char *line_buffer, *p;
+    char *line_buffer;
 
     assert(len > 0 && len <= 16);
-    line_buffer = g_malloc(len * 5 + 1);
 
-    for (i = 0, p = line_buffer; i < len; i++) {
-        p += sprintf(p, " 0x%02x", buf[i]);
-    }
+    line_buffer = qemu_hexdump_line(buf, 0, len, false);
     trace_scsi_disk_new_request(lun, tag, line_buffer);
 
     g_free(line_buffer);
-- 
2.41.0



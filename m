Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994E2C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZjU-0006z0-Jb; Tue, 02 Jul 2024 05:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZjL-0006hy-La
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:21 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZjJ-0007Ay-2g
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:18 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2e72224c395so44436271fa.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912195; x=1720516995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBCC3n87rxfV/0t7pp/Ldl4A4zhR6I/rWoz/G7mokgI=;
 b=X3Ot5K6+ZY2wcvUeGg/7qQACiyfhsUUhGDQpCbVhYtD78RMNQA0t+hbp+hTwtpwui8
 kt0/xqD2JYORny57jgPfF/bYs0HnYFMUc7XHiganww9K5AbPbGseyRoaSjAe1IykHnly
 RzyL/Oxm74ipsnmHCcxyRixoj5L6jJ6g8TRduN5P4QV4pwSyPFFZVWXiCYalsUoxJzsP
 jh6ns/A53BoPvKNeX5I597ext0b5sBMaKxjUYU5F1VyYl2KuGYvHndMmp/4RLjvkZ37h
 oBk13b3oDN6fOCMLZ0KoPzfjXxwPJDv1JIJzRXtUGqrcFEC3NpHppAuiznTH2d0a5RCO
 AaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912195; x=1720516995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBCC3n87rxfV/0t7pp/Ldl4A4zhR6I/rWoz/G7mokgI=;
 b=HXzLj3ghl2920necEOIJSH7X1da/zbaon+7G1o1L4VRmGr7OpdUqDZfEgjLYw7id5/
 jgVoMhcbYsuWYc3+e06Md10KN1uGYBxtBIGDg4EQnjGGUiM1q+JCI+tIjrjkeQ9USJhe
 s0kbkBYRmtmYVHdA+FdPpKxYxRccQDt/iSF68PXt6vMzb9c1yU/M6x8uTJF3eIAwHcu+
 8+yyIiL1qtpZu/dn/ceYLA5iOWBmSlNOyonZ26ZkrrXJlRtqedonTT4NuAIyFOlSx4TG
 IIrNniaM9zPuCjroydxilUi0oQAQqHWDl2+kgvnUUGs6vRdMpMiTh/J015TfTy3uYdB1
 cZUA==
X-Gm-Message-State: AOJu0Yz1ClP9G3S+v32l5Lru34/l52NhyEbi4l8HUmKzj90TSliYLF/k
 8a9ps/xsMBvbssLiEu4ddhFMo+ImCg1ik/tokJVZWzKEa5fnZUUOJ6zr2w5wYWCKWf2EeJv7q23
 w
X-Google-Smtp-Source: AGHT+IGp0AS4iSkYsSN7jIgaKF4v5PiprPD+5s5EmK+JJag37o2gu5kbQF17wOGF+NP/ZGj55y1tSA==
X-Received: by 2002:a2e:99d8:0:b0:2ec:51e8:d8fe with SMTP id
 38308e7fff4ca-2ee5e382b9emr53809631fa.31.1719912194894; 
 Tue, 02 Jul 2024 02:23:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42577a0dda2sm83964945e9.0.2024.07.02.02.23.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:23:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/67] hw/sd/sdcard: Introduce sd_cmd_to_receivingdata /
 sd_generic_write_byte
Date: Tue,  2 Jul 2024 11:20:07 +0200
Message-ID: <20240702092051.45754-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

All commands switching from TRANSFER state to (receiving)DATA
do the same: receive stream of data from the DAT lines. Instead
of duplicating the same code many times, introduce 2 helpers:
- sd_cmd_to_receivingdata() on the I/O line setup the data to
  be received on the data[] buffer,
- sd_generic_write_byte() on the DAT lines to push the data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-30-philmd@linaro.org>
---
 hw/sd/sd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 78aabb65ac..990f038b79 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1095,6 +1095,22 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+/* Configure fields for following sd_generic_write_byte() calls */
+__attribute__((unused))
+static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
+                                             uint64_t start, size_t size)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    sd->state = sd_receivingdata_state;
+    sd->data_start = start;
+    sd->data_offset = 0;
+    /* sd->data[] used as receive buffer */
+    sd->data_size = size ?: sizeof(sd->data);
+    return sd_r1;
+}
+
 /* Configure fields for following sd_generic_read_byte() calls */
 static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
                                            uint64_t start,
@@ -1943,6 +1959,19 @@ send_response:
     return rsplen;
 }
 
+/* Return true if buffer is consumed. Configured by sd_cmd_to_receivingdata() */
+__attribute__((unused))
+static bool sd_generic_write_byte(SDState *sd, uint8_t value)
+{
+    sd->data[sd->data_offset] = value;
+
+    if (++sd->data_offset >= sd->data_size) {
+        sd->state = sd_transfer_state;
+        return true;
+    }
+    return false;
+}
+
 /* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
 static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
 {
-- 
2.41.0



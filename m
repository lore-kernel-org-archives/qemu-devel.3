Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720ACC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmdF-0000eb-9k; Tue, 16 Jul 2024 14:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmd9-0008Vj-Pe
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:28 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmd6-0001Ct-9S
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so129455e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721153422; x=1721758222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FU51jMVYxoSXZSJRtYZsN/eDuyNUsq+vn/b+UhmfSb8=;
 b=g5kNvtZ1ez567cFZpAs5pO/vfBD2amuY3nOG2ZBjxyQPHeEAmz9tGn9D0B71iSF41v
 owaC5JYAwrl+7pQXhPvAPnciExEhDoFZ80W09oOnqDqZ9gHMgnaS4NSVhZ3NoiekfGD0
 acHxeS6Cc/OnUor+QewcxXE49tPs5yejwHmpTtZ+bfEJ/uHKVkx0KWfsAgqb0DFqq4hs
 NQkFq3L8S/DOFT2Rt8psahswtB2N9TVQV1QJgZ76Iy7w8Hiot43pKjdCNyWHqpO94G8Z
 ZR0di/dXOwF1ZwG65USXUYmfiTD+Yhl13IMqZlabfwO7oY3oz3hgGgrG7PFLw9am3JD6
 e1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721153422; x=1721758222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FU51jMVYxoSXZSJRtYZsN/eDuyNUsq+vn/b+UhmfSb8=;
 b=Y+P06tBdSkskQ17iiXcDyEOIYCZCsgfNn+cGMZ0Wk93epZeoceA8hmDir+eod8W8BT
 jPVzvZMdvPn6Iyw4YfW7JXEO+MD1i0qlyJiBlJT5mDj8QgqdVLUuB/76yMvIptN/iwR8
 RthwaWRRv58CATYnSZB6DmrPYTQATgyLTTkvfX6Jo4E8FXIAUL6KdL26vAvGwjYjvXZ6
 rMB+e7NuN6jfvpevWsxoTHnbcWAVRhOWQdWFYyi05NlJQQrZBo8cOBoWHWiDT0LsYwC7
 3vsnxOfHhVKAv9AXBMJvNh1Y2Ypa/QOCIAUw+DQUA+GNc8AH2/znkQgakLFZRf5PW2fG
 ipUg==
X-Gm-Message-State: AOJu0Yw1AXtXTGIuyRVcIAh9badYnfDElPuomZOLZIbWdRdCno5KZv7m
 oYzSdeMEqe0aeVexoL/BaWZWI+WFmZgVepLe89qTg1PAe/Bdx9ti2xZLni7YXrn3ngndDobM2JQ
 0JHY1lw==
X-Google-Smtp-Source: AGHT+IGinRStQMPx7r0CBECg1tXMB+C0IDJCyxIMs1DD9xr+UlnjGFVo8vo52ciQyEijKBJiUHGd9w==
X-Received: by 2002:a05:600c:1e09:b0:426:62a2:34fc with SMTP id
 5b1f17b1804b1-427bf39020amr11850995e9.11.1721153422383; 
 Tue, 16 Jul 2024 11:10:22 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e77429sm138183465e9.8.2024.07.16.11.10.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:10:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/13] esp: remove transfer size check from DMA DATA IN and
 DATA OUT transfers
Date: Tue, 16 Jul 2024 20:09:34 +0200
Message-ID: <20240716180941.40211-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716180941.40211-1-philmd@linaro.org>
References: <20240716180941.40211-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The transfer size check was originally added to prevent consecutive DMA TI
commands from causing an assert() due to an existing SCSI request being in
progress, but since the last set of updates [*] this is no longer required.

Remove the transfer size check from DMA DATA IN and DATA OUT transfers so
that issuing a DMA TI command when there is no data left to transfer does
not cause an assert() due to an existing SCSI request being in progress.

[*] See commits f3ace75be8..78d68f312a

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2415
Message-ID: <20240713224249.468084-1-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 5d9b52632e..8504dd30a0 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -594,7 +594,7 @@ static void esp_do_dma(ESPState *s)
         if (!s->current_req) {
             return;
         }
-        if (s->async_len == 0 && esp_get_tc(s) && s->ti_size) {
+        if (s->async_len == 0 && esp_get_tc(s)) {
             /* Defer until data is available.  */
             return;
         }
@@ -647,7 +647,7 @@ static void esp_do_dma(ESPState *s)
         if (!s->current_req) {
             return;
         }
-        if (s->async_len == 0 && esp_get_tc(s) && s->ti_size) {
+        if (s->async_len == 0 && esp_get_tc(s)) {
             /* Defer until data is available.  */
             return;
         }
-- 
2.41.0



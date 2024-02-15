Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11D0C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafem-0008Mo-GN; Thu, 15 Feb 2024 12:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeG-0007wV-TS
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:49 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeD-0003vQ-Gw
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:47 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41222a56492so4858115e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018543; x=1708623343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RikRCXplsLtZPEBuIF7gu6g30mSRA9kA+w/7iCIMGaI=;
 b=TWBFSrXrB/2QV2GHNp0iNT4isyfSQUk6Y+CRsRIiKZbCcQORuxY8I8+dzsmnaDkeDb
 L5j1H5ofG4rxFrCCxUNsHUdtvwwqbE++BGlZs3v+zE0NMNYrxekO1UjkUzCePe/sCMYn
 kc5XjYIdecEJNwR5f5I7roOQ9ibZ4q4R/3W1uDMQRN3JRi0LqonUcztjXhpDXtSH+7qa
 QT839A98V8AWre2CSCioyZ2xpApcaK6tzaTJeCpe8IAg+w1wEl/b7WZq7V81iXV4EVJn
 whhWkQM0K0Mw3BUuyOJhezzQkio5iVRGtZrCugOcrUR9/EcHL9ZhRjlrmyovVr8xJqCS
 gg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018543; x=1708623343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RikRCXplsLtZPEBuIF7gu6g30mSRA9kA+w/7iCIMGaI=;
 b=mBjVkTYidPAHFHjPO818IdlzSbW76oI1yNBHWj2JonHx8s1WLYnu4kBNjtTU3CjdZS
 HWbZ0yJ1HfnX8JZX1CD/Kq/+pnkMBx0BXhEwYPPveXzTf6ALL+qF9DxfbOx8MmibvPVL
 edSmgbnS8I4m3v9+KrFDI38OOEsv2KcmTYavDlcgP/R6HoqKfod2hZhfGab+wNF4CCij
 9/A7QozDwUyXomgnWUe/f0SM3tvhpEejl9Kf+3NDAn8oJOPj+JqZGOMTzZSw04lxmt8U
 /Y4ylAQhjTp0oyxgHSiXI4xI7VoovsK5cRnPqiM24G30w8mjD+pxZ7K5Hvo4/GvdyEuy
 6WIA==
X-Gm-Message-State: AOJu0YwNcaqVg4DCy9tsm3EpPsLo1h0Dj3eQpLWhtklq4b4Y3F8F5ALz
 7ux/fMxwdzAr9jE6cbsFi64ihxm99eDAW6RMXpkt6LtayMsNPXUHwLurYJ9OOzTHZT4ZJtCfLQi
 w
X-Google-Smtp-Source: AGHT+IF8niI6gc09EKe1FUnwj28vGUWz/CGNgdDEW6CwDg5DYZpThE2BPhVHleipQwwHAAXkSlTGWQ==
X-Received: by 2002:a5d:430d:0:b0:33b:302:c08 with SMTP id
 h13-20020a5d430d000000b0033b03020c08mr2055463wrq.43.1708018543531; 
 Thu, 15 Feb 2024 09:35:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/35] hw/block/tc58128: Don't emit deprecation warning under
 qtest
Date: Thu, 15 Feb 2024 17:35:12 +0000
Message-Id: <20240215173538.2430599-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Suppress the deprecation warning when we're running under qtest,
to avoid "make check" including warning messages in its output.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240206154151.155620-1-peter.maydell@linaro.org
---
 hw/block/tc58128.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/block/tc58128.c b/hw/block/tc58128.c
index 6944cf58fa4..0984e37417b 100644
--- a/hw/block/tc58128.c
+++ b/hw/block/tc58128.c
@@ -202,7 +202,9 @@ static sh7750_io_device tc58128 = {
 
 int tc58128_init(struct SH7750State *s, const char *zone1, const char *zone2)
 {
-    warn_report_once("The TC58128 flash device is deprecated");
+    if (!qtest_enabled()) {
+        warn_report_once("The TC58128 flash device is deprecated");
+    }
     init_dev(&tc58128_devs[0], zone1);
     init_dev(&tc58128_devs[1], zone2);
     return sh7750_register_io_device(s, &tc58128);
-- 
2.34.1



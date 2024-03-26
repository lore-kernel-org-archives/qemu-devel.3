Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD55C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp8zQ-0003cl-6q; Tue, 26 Mar 2024 11:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp8zN-0003bL-M7
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:45:26 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp8zL-00017R-05
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:45:25 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33ed4d8e9edso4188059f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711467920; x=1712072720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+2sufPZV1jZbwqSWcGkqalb0YdlIEBcm3JneTAQYPE=;
 b=Wzwyak/7ZiMG+4lNbfNNccr5MkvX3BZdxFaaFdBknzcK/lMETq1KL0b1TzUFScDCOv
 NguG4ApTN7Zpq63mC1hdyC870eWV1XeaAWQ5BqNQxXxGbIGnfdg8J8ikvhBDs/krsitV
 RfHuilSd7d6JCs1NLTziC7tsKf0S9/jQK0qCrOEwn0VKdzv5PJhdRjqeIdkYul8AB0wC
 pSzUGVZ5jve+KThFj0UE5NSnsXdJyhF5sCQNLfybTHbJXI9GiXxhysSm6z1UQHaNRxcq
 LJnPeTyzQKPAWLD3mUw0OopzhfG1UoUU+kB2on+7iwIK7+Ndli/6eA/Ha2uVkoaEHWiZ
 /F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711467920; x=1712072720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+2sufPZV1jZbwqSWcGkqalb0YdlIEBcm3JneTAQYPE=;
 b=PLlvyynr2cAxgidaB7mfB9wkrc9B4kbVaNPq97W9cPxbLCWNXmFLu2bHKua9usKvki
 Em6wctJnmtAVQZIibMiwrS6W3jw7aVqXk5Wz0TsuZYpJG68zJnJXdk4rGZwl2w9wFA8i
 OUmZum4MLeUwB1tyjU2DNaLU81gPe6VDegwsleXpLsvtNnV0/vEyG2p189sAftHfzmw+
 Dksyvk8VDa/rjOSVpxoWdlI/l+iaUPn28Q0i0pJCDaOe/KR0UYTQkKNMGQhaVR835ZPa
 xr1++pGIKEvE6MOgvjF65J8yscNPQDRZd/U+8fKbNJ/kkiJcllpZf1T6Tsjk8t7KDoHx
 oTjg==
X-Gm-Message-State: AOJu0YwvzGZ9v0ZICM82yckiPyhZYnUTqMYYU7+XtnBCB+OR7mS5+Jf/
 47gRGPRljuawQDkoUtdy44Lh6Z6V3Z6PNzzumr41PgI3xIb81Wj1TD/7BGJfTNkT1c+HrS5/VmX
 1
X-Google-Smtp-Source: AGHT+IHwKtFMeWpq3ZJE9GoM5WPki6NX1BeYC0H8+aqSC47II9qYUq6lKqa65FD9RBme1NGAf6Rm0g==
X-Received: by 2002:a5d:63d1:0:b0:33e:bb5c:f60a with SMTP id
 c17-20020a5d63d1000000b0033ebb5cf60amr2406678wrw.66.1711467920447; 
 Tue, 26 Mar 2024 08:45:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 ay26-20020a5d6f1a000000b00341dc343e21sm573910wrb.65.2024.03.26.08.45.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 08:45:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Lorenz Brun <lorenz@brun.one>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 02/13] hw/scsi/scsi-generic: Fix io_timeout property not
 applying
Date: Tue, 26 Mar 2024 16:44:53 +0100
Message-ID: <20240326154505.8300-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326154505.8300-1-philmd@linaro.org>
References: <20240326154505.8300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Lorenz Brun <lorenz@brun.one>

The io_timeout property, introduced in c9b6609 (part of 6.0) is
silently overwritten by the hardcoded default value of 30 seconds
(DEFAULT_IO_TIMEOUT) in scsi_generic_realize because that function is
being called after the properties have already been applied.

The property definition already has a default value which is applied
correctly when no value is explicitly set, so we can just remove the
code which overrides the io_timeout completely.

This has been tested by stracing SG_IO operations with the io_timeout
property set and unset and now sets the timeout field in the ioctl
request to the proper value.

Fixes: c9b6609b69facad ("scsi: make io_timeout configurable")
Signed-off-by: Lorenz Brun <lorenz@brun.one>
Message-ID: <20240315145831.2531695-1-lorenz@brun.one>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/scsi-generic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index b7b04e1d63..ee945f87e3 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -752,7 +752,6 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
 
     /* Only used by scsi-block, but initialize it nevertheless to be clean.  */
     s->default_scsi_version = -1;
-    s->io_timeout = DEFAULT_IO_TIMEOUT;
     scsi_generic_read_device_inquiry(s);
 }
 
-- 
2.41.0



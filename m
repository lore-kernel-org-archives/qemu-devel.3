Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38528C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvaz-0000Ge-EO; Fri, 02 Feb 2024 10:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvav-0000Bd-TE
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:45 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvau-0004Ry-Cz
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:45 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e8d3b29f2so18558905e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888202; x=1707493002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y9n/AEkxgug8LnVgrJ59ksyGPxf9vBmtyi9ED3ze10g=;
 b=KtFlnEfD0ebWGaD1JzH11fi3nzN0vd1hVmOnHbNaI4gCXo5KKK9Z+1MhLWW1BD15Zq
 q4Q0xyy04horfOohhW0qEASezMBKzFZtfk7VqLwjsVhb3+gJgRNZsrWs97igWjmd2QMM
 5xuLxD1RrJpmguPRF5J9fE57WNTCMm44RAuTQbGLzR/HZQvRE+83DDRiPTjZBN/7mIV2
 UIFPYGCKPO50gQY/IYRixZNIV8bAzi3JlyA1hbbyDZpSuENAWmfN1kUKYCxn560ZPfmL
 h1TQfhAmsSqAsHTuTAom+kDob1YOSPnXHPeD8jORTDmzDPUBVEGfoONHK8GcXth1si8d
 og/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888202; x=1707493002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y9n/AEkxgug8LnVgrJ59ksyGPxf9vBmtyi9ED3ze10g=;
 b=MoZzDo8VHZKHeh87mVkKZWJFwHdV7iNERouqOMvnd6KWCnM456rTpV5pHpf0OS++A5
 E/QOG4iLUBx29UNH45cSKfHjAHrHTsEwN37BsbyyJ4c4tjJd62nCMtPuyn5qEtsc5KjI
 kj3AumEaB2C43Dp/NKKXu3bu+317aIGsuzw/HLoQY+z/qyGz52Dw1jeWi7ZbE7C8vZdB
 weez693gSCFSNtHpjQc6n0KVX4epzBYJRPZMJB8biOE9AB4LGTQt+5oupcfAoIAG7QYh
 DRHFwSrnb7x06gmELNqiw8UvwM4daJM+ph/RXJNMc4RtBU7ksgS6fX8OQq4uQnSLGI0Q
 nuOQ==
X-Gm-Message-State: AOJu0YyRNnBJdA9Yjs+mEjAey1gTMJ5kKIV8BZDeMN3zd3geWWfiL6Lc
 YCcn+C4cUMO40HQLYATTlr05k+HcKipMn44TrfI10KdHhedU5a5TJnuQzryTkyJ1XawKlhUPEst
 k
X-Google-Smtp-Source: AGHT+IEbre5vRsT8iOCWBqioeE41PYliJhhdBjr6PNNkM+ZEkY3/+QZVnyDdRZMUFAUK/JDY96orbA==
X-Received: by 2002:a05:600c:314a:b0:40e:7232:bdf9 with SMTP id
 h10-20020a05600c314a00b0040e7232bdf9mr4624655wmo.16.1706888202722; 
 Fri, 02 Feb 2024 07:36:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/36] qemu-options.hx: Improve -serial option documentation
Date: Fri,  2 Feb 2024 15:36:09 +0000
Message-Id: <20240202153637.3710444-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The -serial option documentation is a bit brief about '-serial none'
and '-serial null'. In particular it's not very clear about the
difference between them, and it doesn't mention that it's up to
the machine model whether '-serial none' means "don't create the
serial port" or "don't wire the serial port up to anything".

Expand on these points.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240122163607.459769-3-peter.maydell@linaro.org
---
 qemu-options.hx | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 484cc21c1fd..40e938c4877 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4129,7 +4129,8 @@ SRST
     This option can be used several times to simulate up to 4 serial
     ports.
 
-    Use ``-serial none`` to disable all serial ports.
+    You can use ``-serial none`` to suppress the creation of default
+    serial devices.
 
     Available character devices are:
 
@@ -4151,10 +4152,17 @@ SRST
         [Linux only] Pseudo TTY (a new PTY is automatically allocated)
 
     ``none``
-        No device is allocated.
+        No device is allocated. Note that for machine types which
+        emulate systems where a serial device is always present in
+        real hardware, this may be equivalent to the ``null`` option,
+        in that the serial device is still present but all output
+        is discarded. For boards where the number of serial ports is
+        truly variable, this suppresses the creation of the device.
 
     ``null``
-        void device
+        A guest will see the UART or serial device as present in the
+        machine, but all output is discarded, and there is no input.
+        Conceptually equivalent to redirecting the output to ``/dev/null``.
 
     ``chardev:id``
         Use a named character device defined with the ``-chardev``
-- 
2.34.1



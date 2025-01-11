Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3D2E7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 06:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWVCn-0007ca-RS; Sat, 11 Jan 2025 01:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWVCm-0007cP-U9
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 01:42:44 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWVCk-00056s-Qt
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 01:42:44 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21680814d42so38889425ad.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 22:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736577761; x=1737182561;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vdfXU/WIgwZi95hIyF1I/4JpycywByOPYoEA9TljnH4=;
 b=MNNGLB1DpPT2izHBPSy2msVfhAbNAar7dSIiiJbAIhoP7iYsuom014zq1TFIWV+TGt
 xy7Xy7qIL1nZ2+5Kh8pPDfH12iliqpgcLWyGYwVxA7XcEKzbiVP1WezFaLw7QgRAwiJi
 Wxhrg+y9Xrjchx17LsH5tbrZFLWENo7dIJXdcEPH9WNhBSdZ+PlI6FGfqHMhjBQnYY1u
 O/OdQfYd8LdkVTnYZnvWLnMVJ363rJdk42tfer0S5p9Vm2P9vTfn71RMj1FarKs7d4Xd
 EbX4aYsJ/7WFurCTStBJl/KZlD9Hp+4Sci7vcCvGBk/MGaLB+8AwDEdCy1bodKZCHIhi
 hPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736577761; x=1737182561;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vdfXU/WIgwZi95hIyF1I/4JpycywByOPYoEA9TljnH4=;
 b=RkCbg11tpFJMOG9g8UVmrGAfSQw9iCBh/ujwqwTzhdua7qH+ID8oB1RToS5iWGbU0P
 pIOwVZaxmiI1+PFVSh70d4eD9n2JQMJaL/NuMO0SgnVDR2L3Z+C0nItT5aHnlZGZGHC0
 +ydL+K78t1fQoEA8YAr+6RzL5Nu5KDtftPKZeHWXGM7Hs8qI9LqulNBaQw0Wvx0KrsxA
 67mO4aTxP8aGYF6Ai2ds5iYkB2o+KcuwDPtKkeXinz+1TEfNj30Kjfd7B6xLWUr72QxM
 ozmgp83JNykMPkti5gsQnPujVewjRpdtvAWdQxMoVzleGUVOE26FUxUvQJts3ODeJAZX
 vGyw==
X-Gm-Message-State: AOJu0YySEDOgqA9/41bTpQozqJb2g1BX41Ui3y258dlBeN/UyMIoJAQy
 s8awfWyvMfRqjE65hvg1ZsMCCBsU2P9gF3QtRI0leWe/cf6dWBk4yUhM/SD0wNw=
X-Gm-Gg: ASbGncsWdq/rocVHoKGWC9/YzHckkouxu3n+CVKJNTu7chqt+MU3/uR941zkWSnW+sJ
 V8Z+ehf7PcZcuGJpKmV8UJ6MJ//CEAzbjnyqR+n4rf3LWd1YyLS7dHwXU8LIf48P6Q9WhOo/uJA
 alO9H+f11Wf8to5lFsSAIOUAoQl7k/Wvf62Ys81iAlgNUiQzcCEXJFs1crNem6OksEMmyBV2JiO
 aH5Gh/lH65Y8S1fOt450wOmiSVFLVCBGo2BsU510v7nlhiLdbdcfU+saKo=
X-Google-Smtp-Source: AGHT+IElQ9Mhhcrf9yAmdKW1rFXWvvwdRvG5N71JCDxtiZZsH+NbCHd6BL0YzWb3aHzEz4kpHLCkVw==
X-Received: by 2002:a17:902:fb8e:b0:215:6426:30a5 with SMTP id
 d9443c01a7336-21a83fc150dmr171203915ad.40.1736577760943; 
 Fri, 10 Jan 2025 22:42:40 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21a9f22c33esm21726945ad.159.2025.01.10.22.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 22:42:40 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 11 Jan 2025 15:42:36 +0900
Subject: [PATCH] MAINTAINERS: Update path to coreaudio.m
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250111-maintainers-v1-1-faebe6ef0fec@daynix.com>
X-B4-Tracking: v=1; b=H4sIANsSgmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQ0ND3dzEzLwSIE4tKtY1skhKSkxJtExLMTBSAuooKEpNy6wAmxYdW1s
 LADMKOKRdAAAA
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Commit 8b46d7e2dc8e ("audio: Rename coreaudio extension to use
Objective-C compiler") renamed coreaudio.c to coreaudio.m.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38a290e9c2ce..1e30c0f14057 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2786,7 +2786,7 @@ M: Marc-André Lureau <marcandre.lureau@redhat.com>
 S: Odd Fixes
 F: audio/
 X: audio/alsaaudio.c
-X: audio/coreaudio.c
+X: audio/coreaudio.m
 X: audio/dsound*
 X: audio/jackaudio.c
 X: audio/ossaudio.c
@@ -2808,7 +2808,7 @@ M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
 R: Akihiko Odaki <akihiko.odaki@daynix.com>
 S: Odd Fixes
-F: audio/coreaudio.c
+F: audio/coreaudio.m
 
 DSound Audio backend
 M: Gerd Hoffmann <kraxel@redhat.com>

---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20250111-maintainers-28bbada9fd02

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>



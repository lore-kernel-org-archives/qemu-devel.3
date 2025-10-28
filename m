Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D5CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeYa-0008I4-B6; Tue, 28 Oct 2025 03:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeYI-0008Ap-LS
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:55:36 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeY6-000849-Nw
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:55:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-475dd559b0bso40457175e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638117; x=1762242917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o2Vwqg5FFZQQtmEVDjtXvUPqRVr9tAzsMqdepzlnyg0=;
 b=bBj3LSlVejCE6LBJAievxb6EtoBiECXW508sounJrzDsDWbhAPgScZqes1Vinp7TS8
 uGBUTtAPNy1gkr9q39ZXKEWK5HpHE4UXhfFA8NN5Hz4RrpIvEOoM6iS8qkzm2sj5LHtA
 H/2sfS4J2TO1NGuP2lNl2rWitfW5v+QJZBXqnKqLcdWIrwX+oyOoKsEcgvfq+4U/XPM5
 C7oHPQ406BC3yYI35+fegwNr38CCZNdXF71raXDLpUKSI+arwa4JBAbQiZXAMCMFf2zM
 NYjxpAjYMJLeTlACh3nf4Qenh77HRqBwnqsJyuIDe3g5JILOD0pxv4q2v+OBHKIb+uXQ
 R+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638117; x=1762242917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o2Vwqg5FFZQQtmEVDjtXvUPqRVr9tAzsMqdepzlnyg0=;
 b=xEGDxk/J1exMUbqabIwndpnixSfXvhJ3jtm6egSp2EGH3tYxiDZWIvDVFRMgR6Ow6v
 X8TiI80dgJG1QVeufz3nO7gXT2DwtLpuBaxi9RdfN/Wa9yeeQZi3y0rO380XB2iY6FZL
 UaqTWnW2jHbiMUkFP5fKxXznj1+BQaDMyWZb3s54Ss+Uc6wgwtBvIOXWxxpav2fVFjFk
 AxlacBEHSJzcoGy2FOgIWKCvrPQiggnfxZXcKpvMMYmC2t6EgnqyGXPmZ/oAncziA549
 Wrmo5aWMgDFOO3cdiyIaxEkvckFzWjElGkmIWx1z0UN0zaHDszxaWxhPJlT6Q5U9/9o2
 iJ1g==
X-Gm-Message-State: AOJu0Ywm2SFqKX02dC3VZ7XPVDcOXFgcDj8BYndwVC4lVUS7h+CjFJiC
 BrL5FGAjcfU0ByBGY8LpjupBA6A5N91AwsZSAHD5THGJb7VUtgZyhHWZ2yaV+hAVUbq79+lZMsD
 PMionnUk=
X-Gm-Gg: ASbGncukoBd98qenDY4vuB0mejbhw2wMx4CuhFy1Xvo811g43lO9cuMQLtOxMjUL4ps
 9irDzTVoBQ6A6SwIc6J0mWLR8Id8IxW/Q72ERZRmPRX88xDws0s4alBbTXAo62W3ZRzGgkt0fB0
 GZipBYDCmSP1MaI99CVY+R6cQNyVwAuTEbHCBK2NX45OCsutHweE21jfIkQ1f/Q2bIBTA2rIEty
 2vbrh70fipm5wFJ+MoU0NysD1DPV2o71cRYBqt05dF7UMWpeVmDtxHDpbEhPgUZWjniZ6LibxAG
 SUxdZrX3OppRg/rTQ45IcDVhDu2R4dpMOnEc5EFhNvTRvlGsloXQdyP9J/hzrGFJZtJoaBrjftv
 Di1jepLadHpblNzgEGMYGy46WV/YQPZoN8LSaDXbFrcJ8oQzjQQTRZebaBLwibB9mlquPYXMsk9
 yCncDupZYS6zJvd7xCd3KdwM6d4pGBm9dKR8Pxk5378Vd54lWqN/+mV5A=
X-Google-Smtp-Source: AGHT+IF5t32D4u++whWLR9vPw4g3NLtOqlFRgnRyzphMV1aj0lOVX4t0iCknsmqzXPC836l+NGUW0g==
X-Received: by 2002:a05:600c:a009:b0:477:e66:4082 with SMTP id
 5b1f17b1804b1-47717e6f566mr21791075e9.29.1761638116728; 
 Tue, 28 Oct 2025 00:55:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771906af34sm12511305e9.14.2025.10.28.00.55.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:55:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/23] hw/core/loader: add check for zero size in
 load_image_targphys_as
Date: Tue, 28 Oct 2025 08:48:53 +0100
Message-ID: <20251028074901.22062-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Vishal Chourasia <vishalc@linux.ibm.com>

Currently load_image_targphys_as() returns -1 on file open failure or
when max size is exceeded. Add an explicit check for zero-sized files
to catch this error early, since some callers check for size <= 0.

Also, remove the redundant size > 0 check later in the function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Message-ID: <20251024130556.1942835-10-vishalc@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/loader.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index d7c11c18f11..590c5b02aa1 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -140,18 +140,21 @@ ssize_t load_image_targphys_as(const char *filename,
         return -1;
     }
 
+    if (size == 0) {
+        error_setg(errp, "empty file: %s", filename);
+        return -1;
+    }
+
     if (size > max_sz) {
         error_setg(errp, "%s exceeds maximum image size (%s)",
                    filename, size_to_str(max_sz));
         return -1;
     }
 
-    if (size > 0) {
-        if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
-            error_setg(errp, "could not load '%s' at %" HWADDR_PRIx,
-                       filename, addr);
-            return -1;
-        }
+    if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
+        error_setg(errp, "could not load '%s' at %" HWADDR_PRIx,
+                   filename, addr);
+        return -1;
     }
     return size;
 }
-- 
2.51.0



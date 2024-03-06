Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D490C54E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkWW-0005C1-LY; Wed, 06 Mar 2024 01:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkW3-0004u0-4A
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:35 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkW1-0006FP-M6
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:34 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5dcc4076c13so356611a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705551; x=1710310351;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kYp/u0+4A+fT95r0+Uw8gBS/wuGX08IOGh8a1eJEdws=;
 b=qzygfLxljA9A+vjeb4E9JtFPNYtUh492pYkr+g+h64tCrmirW+CNmiPb7kP/oWzDSz
 KjLYO2ojCWwQ981O/X9xVgbXbbwtPm5TVheRI+b/lP2pq0Et0HD3xwdzZ7bRmYSjfblJ
 54OzSOQrPEjv3C6PNH7PpCD+Qz5NOqLM6alUBbjaXFGzkBaW3S+wVXh0/NHW9ZPRl3Oj
 jSkcwbTGvmaQr5A2CwJoUvS1vc2SAvMeOQevlHUSyez5EicXBIjX0vmJ6fpy/uc8Wki9
 mqvAzwzhPR8+j5a6Egulx9n4DVv16KRihISNRR19wZACny8Zkney/sCQpBr3W+hn2CnA
 vq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705551; x=1710310351;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYp/u0+4A+fT95r0+Uw8gBS/wuGX08IOGh8a1eJEdws=;
 b=CJ1ZNyGCXPRAsAEWwMtuUSCxf8gtcIpWvfwwkh/k82GysLzfOXErsf4woULbfELas1
 h5UH9TcYLuNdkINA83xUycMyxuztB+fkjJBIRdAeEQ33h3iVshsjSVjZ2i8OVk03UYHw
 waKgAS7vGNN7kj08uCu9tLTWRZIZTJn0ePhjt/QiYkNoUqxA3mmWE9CRr8psGEBMKEhG
 4U3HwXyq92ouGMWgw0hmvKcAdUT5mT0jPZ0WbiLDiNal4PWlvs+xrKjr+A9UKYFGcDNB
 tQXGo6lEbJbwNRhjd8XvlyKR5QgaAqYpSSZs8pkylPSGrS1Qr0kAyhvaI4zBZntDiqRO
 OuPQ==
X-Gm-Message-State: AOJu0YwlIQE32V2SABhp+u8Eb4mIVg8N2RZFQkLwP5Ol5NmxmkhfjhSB
 JnGlwonDltTC90SURq7NeRYGbFbKU1z9xJVbyc4CVlXk5GO+5Yenh19xIYQakSd4fIsXgeJXtZB
 L
X-Google-Smtp-Source: AGHT+IHXp3ls+rV/ctT2Zmam0oqVxE4TmZFzicSyAG68PYPi07riLYtOWECFY3y12NpvF77yWh3SlQ==
X-Received: by 2002:a17:90b:b06:b0:299:3780:e9c7 with SMTP id
 bf6-20020a17090b0b0600b002993780e9c7mr6146334pjb.2.1709705551347; 
 Tue, 05 Mar 2024 22:12:31 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 l3-20020a17090ac58300b0029b2e00359esm7610170pjt.36.2024.03.05.22.12.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:12:31 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:12 +0900
Subject: [PATCH v3 06/19] contrib/elf2dmp: Fix error reporting style in
 download.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-6-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::535;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

include/qapi/error.h says:
> We recommend
> * bool-valued functions return true on success / false on failure,
> ...

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/download.h |  2 +-
 contrib/elf2dmp/download.c | 10 +++++-----
 contrib/elf2dmp/main.c     |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/elf2dmp/download.h b/contrib/elf2dmp/download.h
index 5c274925f7aa..f65adb5d0894 100644
--- a/contrib/elf2dmp/download.h
+++ b/contrib/elf2dmp/download.h
@@ -8,6 +8,6 @@
 #ifndef DOWNLOAD_H
 #define DOWNLOAD_H
 
-int download_url(const char *name, const char *url);
+bool download_url(const char *name, const char *url);
 
 #endif /* DOWNLOAD_H */
diff --git a/contrib/elf2dmp/download.c b/contrib/elf2dmp/download.c
index 902dc04ffa5c..21306b3fd4c4 100644
--- a/contrib/elf2dmp/download.c
+++ b/contrib/elf2dmp/download.c
@@ -9,14 +9,14 @@
 #include <curl/curl.h>
 #include "download.h"
 
-int download_url(const char *name, const char *url)
+bool download_url(const char *name, const char *url)
 {
-    int err = 1;
+    bool success = false;
     FILE *file;
     CURL *curl = curl_easy_init();
 
     if (!curl) {
-        return 1;
+        return false;
     }
 
     file = fopen(name, "wb");
@@ -33,11 +33,11 @@ int download_url(const char *name, const char *url)
         unlink(name);
         fclose(file);
     } else {
-        err = fclose(file);
+        success = !fclose(file);
     }
 
 out_curl:
     curl_easy_cleanup(curl);
 
-    return err;
+    return success;
 }
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 09af39422f1e..d295fd92be2f 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -591,7 +591,7 @@ int main(int argc, char *argv[])
     sprintf(pdb_url, "%s%s/%s/%s", SYM_URL_BASE, PDB_NAME, pdb_hash, PDB_NAME);
     printf("PDB URL is %s\n", pdb_url);
 
-    if (download_url(PDB_NAME, pdb_url)) {
+    if (!download_url(PDB_NAME, pdb_url)) {
         eprintf("Failed to download PDB file\n");
         goto out_ps;
     }

-- 
2.44.0



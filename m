Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD8DC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAsL-0004WY-IC; Thu, 07 Mar 2024 05:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsI-0004WJ-VV
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:19 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsH-00079P-FQ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:18 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5d8b276979aso547711a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806876; x=1710411676;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kYp/u0+4A+fT95r0+Uw8gBS/wuGX08IOGh8a1eJEdws=;
 b=3QSm+eq6HoPJ3kZc7iZEV4S75npi9IQkLig9rQTUFt+rIt1eCHNI6Iu6PQrOWL+t0s
 aUxdfmlggf7e6VWnLEAzaGxW5F+Yvc19y0ptwdH/OkDSgiAAZtREofEib8+981qX2dVU
 IXRh5Pcbatzx5VnFy9sX558THxncAdf30BukRQqSi4GtHx45tNX567Iy8jm2k+IcS4bK
 OQLgBUXCNlLAjubcAM7U8rPkEPc5IHpkroglKb0MT8oAAy2kWXQEXEtG1CkDtWJT+DtU
 ctwlWnbtKul7p5hm0EyWtyByf46lBvQWmJHcDkx6DDImf8OhBsjc3QzvAL5FJLZNxpyI
 HgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806876; x=1710411676;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYp/u0+4A+fT95r0+Uw8gBS/wuGX08IOGh8a1eJEdws=;
 b=ZLo+YHCOLL4DNlGcj1ZzrzIiuHbM19GLXBTg4/aE9UNvzgH+o5q7akLixqE4EWdDjS
 uLkUZlj885u71lMVy3Voin465XJzCODoeEPRUUrBHufHzBr/W4QGtbMKaQoqBOjc3DLj
 7dgzJKQiLSc1RdsPwqXknE7nKLYcqvXocYP8wgaoEircyBrHITfL4/1fH4VIR04kxVJy
 ri+KZ0OL5TEOs4qhuPa84UBmeKio7lYovOMvxXrEkrxHe3WLBk5v63qTtsPfRoW56H74
 QHYt79R7WktJyRk87GiFyxZ3SRmO7eHrtvsCfMHAe57Jmh08aNG3pTMaN+uch+i5aqPi
 ynzQ==
X-Gm-Message-State: AOJu0Yzz0OXLMOLsCpfnpvsEfnpF9iZaDj+xULD4ysrTkvnk2uJTz2cz
 DocaGk21wn0xnhTy8NzGJX5xy+NcPxyNw7LMYrEDugUECx4+jF7L5An5GC0IO1T1T6HHepxT3Kt
 t
X-Google-Smtp-Source: AGHT+IGp0m4QZkAdHAahk/AwPLAAL/IdDQCwtFPNRvYGUWBGYQe0FWOceLpi957RqAMAKNvM05AGww==
X-Received: by 2002:a05:6a20:938f:b0:1a1:52d5:d17 with SMTP id
 x15-20020a056a20938f00b001a152d50d17mr8671578pzh.35.1709806876210; 
 Thu, 07 Mar 2024 02:21:16 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 m19-20020aa78a13000000b006e509762bc2sm12250118pfa.26.2024.03.07.02.21.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:21:07 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:20:49 +0900
Subject: [PATCH v4 06/19] contrib/elf2dmp: Fix error reporting style in
 download.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-6-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
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



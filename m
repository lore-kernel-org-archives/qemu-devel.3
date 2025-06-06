Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62750C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWHw-0002TZ-S3; Fri, 06 Jun 2025 08:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWHu-0002Qw-I6
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWHs-0005om-L9
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0N4/ek3rDKnJspa+pZ+XlKtcNsZl6mQsa0mbBdxvXA=;
 b=Wz3LGnz3pB0+DYA1nhWvoVmEAX2bQO8z6HJmxW1eqWsSAGof6BvN0ggU/8stWSJMQLnP92
 msVDOinif6AmWabAbiCcE/Ea+7QqplINJDW8+NqYChdo9UjE1dckRB+86KlVfWNYnPA1lW
 pEB+upWV9wd2X+AHjyd2f8ESJ6gWcog=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-GQgCsEUvP_iDzVLWeGt5TA-1; Fri, 06 Jun 2025 08:35:04 -0400
X-MC-Unique: GQgCsEUvP_iDzVLWeGt5TA-1
X-Mimecast-MFC-AGG-ID: GQgCsEUvP_iDzVLWeGt5TA_1749213304
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a3696a0d3aso857198f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213303; x=1749818103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0N4/ek3rDKnJspa+pZ+XlKtcNsZl6mQsa0mbBdxvXA=;
 b=MHTsQjEUW2xuQyQOLBPNt0qxydIKmcpEdREP4o+BD8jLZ+EhzNyjQfokf6ApbgpdOY
 qJ06QJoLsVwK1P1AtgdvvCxJSBGpeG9QYQtfi9FsaWtpfqnxq1tcRF+f2IjVgsj1ULEf
 +px+dkIMMbnS42jK9WlAQTcY/bRGQusMcgEg2ZphXnMPxYSrs/Q9GQa2oNXfoMR99C4y
 VNhsbkMObmt9mlLTMgC9m78Og/znHUleVQeYbY2qWP8S/Rnq6NOQ0MrkGMoTshPmBVsv
 Ifd7tV98ypHmXn38JLxq3BViaZ6HBpjmjcQT711pxRr2tjgrdldpqN2b/HCEsMdzSTjD
 Ec2Q==
X-Gm-Message-State: AOJu0YzVCqi6aceiY/pHGyuEkyfsgUVkZY2BqtqV3KrVvc8F7OkD/PTB
 Ca1u+CVYiWOGXk86o3sDabqHsqb7TbBUM0VaDpjjXVuvnk99Bekck0FHcfyXDOwp1mK5FGosFdk
 g7WC3eT3oyOYTw/Igg2k0iGqM6VcJHuVk59j+z1p8SIDqJCTTjNjPTPBhgTKqLcwoNuB1qi9Irh
 gfUiUzN8C9XEfz6fKhMAIaJt6KCF/IplyU4pNf1jDN
X-Gm-Gg: ASbGnctVsDFtBh9wp6zv//Xhn0C+CAee4SS9Eh+h+CKc+8Fy3xtqkyhGVCUaatzrsL6
 bCEH4Y82TvREKF6zFYZwi8uTOlzpdNpooRASuit30D9yBB6jaJMS8IR2hLxO/SNZ9V3wLrgZNtp
 2fYUVV2RYEirEvknWPCRyXuu2zTJL5HRyqd5HRwWQR8Mf/t0wefaQUkPvJhJTVQIOMGzejnTDuY
 EytC5SFd+a0UwhHhU/J8buQ1lPkJb1jewhW6WVam9ijQcQkgoPmUnHuRQvCz+KMwrKlEmppDBl+
 E9YEAIXgV49pwsneuu7f6p+X
X-Received: by 2002:a5d:5f86:0:b0:3a3:64fb:304d with SMTP id
 ffacd0b85a97d-3a5319ba166mr2505374f8f.12.1749213303315; 
 Fri, 06 Jun 2025 05:35:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEit2lgWsoW1LrwVsoSu/pU3Rft5jOX9vhL7tfrd3aY8ggHwSJ8mPzA2caOAgOc25jVUf1WZQ==
X-Received: by 2002:a5d:5f86:0:b0:3a3:64fb:304d with SMTP id
 ffacd0b85a97d-3a5319ba166mr2505342f8f.12.1749213302764; 
 Fri, 06 Jun 2025 05:35:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244df34sm1789580f8f.71.2025.06.06.05.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:35:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/31] util/error: allow non-NUL-terminated err->src
Date: Fri,  6 Jun 2025 14:34:18 +0200
Message-ID: <20250606123447.538131-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rust makes the current file available as a statically-allocated string,
but without a NUL terminator.  Allow this by storing an optional maximum
length in the Error.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qapi/error-internal.h | 9 ++++++++-
 util/error.c                  | 5 +++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/qapi/error-internal.h b/include/qapi/error-internal.h
index d5c3904adec..1ec3ceb40f0 100644
--- a/include/qapi/error-internal.h
+++ b/include/qapi/error-internal.h
@@ -18,7 +18,14 @@ struct Error
 {
     char *msg;
     ErrorClass err_class;
-    const char *src, *func;
+    const char *func;
+
+    /*
+     * src might be NUL-terminated or not.  If it is, src_len is negative.
+     * If it is not, src_len is the length.
+     */
+    const char *src;
+    int src_len;
     int line;
     GString *hint;
 };
diff --git a/util/error.c b/util/error.c
index e5bcb7c0225..3449ecc0b92 100644
--- a/util/error.c
+++ b/util/error.c
@@ -24,8 +24,8 @@ Error *error_warn;
 static void error_handle(Error **errp, Error *err)
 {
     if (errp == &error_abort) {
-        fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
-                err->func, err->src, err->line);
+        fprintf(stderr, "Unexpected error in %s() at %.*s:%d:\n",
+                err->func, err->src_len, err->src, err->line);
         error_report("%s", error_get_pretty(err));
         if (err->hint) {
             error_printf("%s", err->hint->str);
@@ -67,6 +67,7 @@ static void error_setv(Error **errp,
         g_free(msg);
     }
     err->err_class = err_class;
+    err->src_len = -1;
     err->src = src;
     err->line = line;
     err->func = func;
-- 
2.49.0



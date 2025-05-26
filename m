Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D90FC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYlt-0003Ct-0r; Mon, 26 May 2025 10:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYlQ-0002wo-8Y
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYlN-0007qW-Ba
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748269512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NpYGntv438dYQNUhSbgUIEWdF1v1wrR4ORdQOzf6Qfw=;
 b=IShx6BlQV0+QR15OW8R/Lntjg9SUGL1mQ1hqeCvLvqXt+Hps6giCs3bl/94OrJnooyUoUT
 bwJziBuyxu3R2zIIaQy5UKn47IvtEzjR0f0HBJ3xohD/E3aJOmtqJ5wuKA0i6M2Js/l9gg
 4+JryhcW1P6QvZAJtV4Uk6SyriKTReM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-UFnIRciHO8KNoA4wDvKyHw-1; Mon, 26 May 2025 10:25:11 -0400
X-MC-Unique: UFnIRciHO8KNoA4wDvKyHw-1
X-Mimecast-MFC-AGG-ID: UFnIRciHO8KNoA4wDvKyHw_1748269510
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a371fb826cso913061f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 07:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269509; x=1748874309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpYGntv438dYQNUhSbgUIEWdF1v1wrR4ORdQOzf6Qfw=;
 b=Bcu5pdsuuM7cWrSxaAHu3K8mirBmdpT9BM1MqFWP1xuSNg73cLdTyOFX8RYsarfQ+9
 T/zhSttqiesA3FEPwO1wVf5w1kKn/vCAtvkhZ3or4SgIBixq1dkPCWaoHA/TQJeadJ+N
 avOnIx2hUH0dZA+wsAgG4uNfymdj1Qc0dfiStJpJSm1S8pW3R3Oa92Lzm1q/CfiylghJ
 15Ok81s6s4pbA8Px5pKOTnf62obBFaEh9QrJGWmwad5YckwDX2zpRPM26oE/SB8hm2Ys
 Z0xrw514Zh93OV5l02TaeZ/7UNr6IiqoFIXF6OTaJtKHJiiGOxZDdUWqqgzDWm4QD77C
 b9YQ==
X-Gm-Message-State: AOJu0YxqDmymqIztO6hLnKk+Fhq+rDJHfeuv6GwD0Y5sd4nvQfYJTBAZ
 xKkTDN9Fq2WTK1e16WHiOww23YtHZ2xXNZhtMovELtkxQzd/IYhp51SyQuVF2rUCKyEepcWekZg
 nW4vOlt6x5ZfNHy3ljYkScjb71PZ3l61OvdF92I3lkrYXCAzKvER+7wF8cLBdcgYp2bg/RyDabt
 z+tBbo1BhZelHG9hmbmucAb5bWluI9sN6ojQQ+tYWh
X-Gm-Gg: ASbGncvOChPZZ3G9BLGizPEnwxTz9N4DKh0NT+c7tZoIHVdUDTy+SZIqYYB0hIkYZA2
 +T+KW+nQwaB5BuHKiyOVHXQ9V20NSO5RE+KpoYeYLenZ5SpGI0GA8HJkimCOoviVWO8qKsEaZHQ
 7EDcyzbRGyKA/Y4SPfqlgGJ4q45O/mnWy7Wt7fuvjYDZjXyK4Re4cn13uVfOKdCtLaFl2R8YNNQ
 7FbSDIQTi3KUQ5ZQSxOZ9Bih8BJVwIIaJ3zrAkRhx4uksN5ExX4kMEDTYVlEeCmt71oi3FX5Q08
 aslA1Y/Ab7IG8w==
X-Received: by 2002:a05:6000:1785:b0:3a3:6415:96c8 with SMTP id
 ffacd0b85a97d-3a4cb49dea3mr7153163f8f.41.1748269508858; 
 Mon, 26 May 2025 07:25:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETdttXPnZfK3l9FdiP+86UXu7Z77XeMloT+ILBa2OzcxJ3YSS6IjjsnMqJXILplkExEN6PpQ==
X-Received: by 2002:a05:6000:1785:b0:3a3:6415:96c8 with SMTP id
 ffacd0b85a97d-3a4cb49dea3mr7153137f8f.41.1748269508389; 
 Mon, 26 May 2025 07:25:08 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4db4e6f15sm2342195f8f.81.2025.05.26.07.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:25:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 05/12] util/error: allow non-NUL-terminated err->src
Date: Mon, 26 May 2025 16:24:48 +0200
Message-ID: <20250526142455.1061519-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526142254.1061009-1-pbonzini@redhat.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

Note that for portability I am not relying on fprintf's precision
specifier not accessing memory beyond what will be printed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qapi/error-internal.h | 1 +
 util/error.c                  | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/qapi/error-internal.h b/include/qapi/error-internal.h
index d5c3904adec..6178ce4a63d 100644
--- a/include/qapi/error-internal.h
+++ b/include/qapi/error-internal.h
@@ -19,6 +19,7 @@ struct Error
     char *msg;
     ErrorClass err_class;
     const char *src, *func;
+    ssize_t src_len;
     int line;
     GString *hint;
 };
diff --git a/util/error.c b/util/error.c
index e5bcb7c0225..6c1033eaba5 100644
--- a/util/error.c
+++ b/util/error.c
@@ -24,8 +24,13 @@ Error *error_warn;
 static void error_handle(Error **errp, Error *err)
 {
     if (errp == &error_abort) {
+        const char *src = err->src;
+        if (err->src_len >= 0) {
+            /* No need to free it, the program will abort very soon...  */
+            src = g_strndup(err->src, err->src_len);
+        }
         fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
-                err->func, err->src, err->line);
+                err->func, src, err->line);
         error_report("%s", error_get_pretty(err));
         if (err->hint) {
             error_printf("%s", err->hint->str);
@@ -67,6 +72,7 @@ static void error_setv(Error **errp,
         g_free(msg);
     }
     err->err_class = err_class;
+    err->src_len = -1;
     err->src = src;
     err->line = line;
     err->func = func;
-- 
2.49.0



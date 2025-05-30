Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F2CC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKui9-0002UE-G5; Fri, 30 May 2025 04:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKui5-0002Ry-G1
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKui3-0004ZI-So
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748592202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XCq8tY2fAXF+N+KSLu0bH/nomQD4+3xw+ZZePK8BKis=;
 b=bau0pGnRHB/9f4tdskmoA8en18Nvxb7qH/xvKBNqNg2g2wtiT+cDGKsDaCTKk/WwAKcLaQ
 C5/X2k2nZBoA6M5NxOkNbAdkHKXjUMG1hCN9+8RUC61AgRjtbrEbJO7E0aQoTO3vbuTnJt
 vkrjRccs6TFcea1T6qQ7DHevHLnazmw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-zLbCjBSPP2qW_n44XIdVlg-1; Fri, 30 May 2025 04:03:20 -0400
X-MC-Unique: zLbCjBSPP2qW_n44XIdVlg-1
X-Mimecast-MFC-AGG-ID: zLbCjBSPP2qW_n44XIdVlg_1748592200
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac3e0c1336dso108176566b.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592199; x=1749196999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XCq8tY2fAXF+N+KSLu0bH/nomQD4+3xw+ZZePK8BKis=;
 b=RzQY+P7BCni4UkteUGhevwM7tx0/aADuyuXd6KKovmbKXx1P78HBJOM3lJAmOyH27A
 1UEaZspHqKGRtu9A4uSkMyHtp8I4spSusN8Vjtz8gKnfDrKkfdTLtBFOxiwQNb7HX1L7
 W+2qb27pgFX7oMdouhe1SrtiOqg6gPPe9sDJC0OSQNpfd4VuFeFTphpYrdTkKBsUyDqW
 /rQxrKkHGAK/Dgbh6xlI5o7qUGwxBoipsSR5ZqerjKTwgmodlmUPeD7IxsBCkn1uNYto
 d74TTNiD239sOVaBgZl4PyuHR5GrBUzpl6lztbxGzC3lRcb6TyTnQgIChYeIcf3pL/Bs
 kKmg==
X-Gm-Message-State: AOJu0YxYsC/rX0DGJ2QwSbad36lWUjIFtJleWLL54WYL4J2w6fIs8ECj
 Y2T7rDzT1sg//Fj/gDh/BYTfkEzqO7cQGxG03dganhGqGwxptMnH58vPFGYRT+RCFH/suSnYknh
 pittBZCY8KXJpBRG510PRKXVYBJ7E+LBZhpDP0rRt/fONQor4aWwkHa+lj6xyQ+cVQulvynqtYP
 24AY9eb7VwYyWUNAEaIodimKUxDKx9cHSizeJwxFJJ
X-Gm-Gg: ASbGnctUI3nzmQdIMusxcKp5sj07XBrUsHUpDnwcvb7WsBvJcB4l27p7BGouqKLju7G
 TMuc7Fus1221rN8ojmt4wy2UhE8+hzO88qOsLhUvPOkWi7sG4xg5y850b4vVHL4vMFPWWKjJsNK
 9kA0D48FguhXf4Q9+qZQbR/fkMhikfK6a8o8OnP4wPMSVzei3UFMtt+4rLgL8iNYoz3AQjU/gy9
 NbKL9unWATt8fld2Vm7PQJqDgyH8U5wYYBe7hlftZjEVvgRTh/C3Qw8899gGYYgvuS+vt6+pX/A
 lK3pBB93uZ3sqQ==
X-Received: by 2002:a17:907:3fa1:b0:ad8:8efe:3205 with SMTP id
 a640c23a62f3a-adb36c28fccmr117420666b.55.1748592199309; 
 Fri, 30 May 2025 01:03:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEQo5YG2tBnLVZRsKJ1asxjNl5WUXpmCn1//UgZx80NcLLRq98xU2Qn9nIuErLvCzhcSS9LA==
X-Received: by 2002:a17:907:3fa1:b0:ad8:8efe:3205 with SMTP id
 a640c23a62f3a-adb36c28fccmr117416966b.55.1748592198752; 
 Fri, 30 May 2025 01:03:18 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82d6fdsm282107766b.49.2025.05.30.01.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:03:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 04/14] util/error: allow non-NUL-terminated err->src
Date: Fri, 30 May 2025 10:02:56 +0200
Message-ID: <20250530080307.2055502-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530080307.2055502-1-pbonzini@redhat.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 util/error.c                  | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/qapi/error-internal.h b/include/qapi/error-internal.h
index d5c3904adec..f5eb8ad2379 100644
--- a/include/qapi/error-internal.h
+++ b/include/qapi/error-internal.h
@@ -19,6 +19,7 @@ struct Error
     char *msg;
     ErrorClass err_class;
     const char *src, *func;
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



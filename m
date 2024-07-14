Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F453C3DA4B
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 07:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sStyp-00056I-22; Sun, 14 Jul 2024 03:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sStyl-00050P-Vr
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 03:49:09 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sStyk-0007ep-EL
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 03:49:07 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7f684af6af1so182689539f.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 00:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720943345; x=1721548145;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jiaYdGJdtPWsnfbPGe8XqhPOhb333O5wAJMSGqRo6p4=;
 b=T5UKe5fBpg9TLgDv9On6XoxnDE7/2W1YlEugvrnrI0/+5XklS5flkLkIzzhwayrqDT
 cXMpzQFboC9IFq+IDA+qJw3uN7rjNsKMsSnOXo7IRDjGlcJQ8TTcSNvRivvE25gssQV9
 vXaRbQEPAi//ZwHzyNh37wjnMS18bxQv/Aqt9Xq+badvtZDA+HAihz5dLNwhlCOaQI2X
 3aJaRCcAjxpZ+HDslk7GohSdP2kf9yj5Q6MqLzEyPKNcpuVPqDITp34Cgy1GtalYwj42
 iYqiZ13sgDKRd9O8IhSjuT0OwIc8YYYkyF+NU1x4hpumMw2DtVLG/gKEWgifsXbPgv1o
 BpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720943345; x=1721548145;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jiaYdGJdtPWsnfbPGe8XqhPOhb333O5wAJMSGqRo6p4=;
 b=PF7zwmwDysFcyjUUwVYwy0SybkVPTy4UTkmJ1SKjYAm5hs1t8PNnXiyw9aVcWndnua
 59XFJv0AN85aaG2XMQQJOqQXy2yJzOgbWz53CQBlh37TaGZvFbPi5lSKaaiKp+APgGbh
 R9/skShB3nPfU6jIwERYNKaJNwGPgLHZanuyDWz5DfKuV+r34109xWqO+RNaxAte3p57
 f2BDucF1QxQ5gBkrlp4wL10pW9dwcXWrjzZY4oMEDYxpSoG10e+jK9k9bGXCgh4JhrBr
 5WedaYAFkboMHJR6apTwmnCHETq/xzFnYXyNy9PnsGUkAyOMXrfZw1a8yc/1EaoDCKCR
 vjeA==
X-Gm-Message-State: AOJu0YxMT5QgV1NYtViF5KUrKHoZkfwbBP1E2R9HQupY49dGGb3Yi+6t
 Iy7y/YMSu+6zsfMmS86xH6mwVckNQGP3ms1kBF6X4tFW3+0N7col+CvBNEG1BQY=
X-Google-Smtp-Source: AGHT+IGeyT9Io5WCPCLinwvALS4/z429E0AdR3OuBJQgaQ8pTSd42NePCPmMkJmKNnJowZIOUw0IaQ==
X-Received: by 2002:a05:6e02:b49:b0:383:284:113 with SMTP id
 e9e14a558f8ab-38a57214449mr215364005ab.4.1720943345127; 
 Sun, 14 Jul 2024 00:49:05 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bb73f45sm19877665ad.13.2024.07.14.00.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 00:49:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 14 Jul 2024 16:48:32 +0900
Subject: [PATCH v2 2/4] qapi: Do not consume a value when visit_type_enum()
 fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240714-rombar-v2-2-af1504ef55de@daynix.com>
References: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
In-Reply-To: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::d35;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Consuming a value when visit_type_enum() fails makes it impossible to
reinterpret the value with a different type.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qapi/visitor.h | 5 -----
 qapi/opts-visitor.c    | 5 -----
 qapi/qapi-visit-core.c | 4 +++-
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index b3ae3188edfb..8e841b26428b 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -513,11 +513,6 @@ void visit_set_policy(Visitor *v, CompatPolicy *policy);
  * is an input visitor.
  *
  * Return true on success, false on failure.
- *
- * May call visit_type_str() under the hood, and the enum visit may
- * fail even if the corresponding string visit succeeded; this implies
- * that an input visitor's visit_type_str() must have no unwelcome
- * side effects.
  */
 bool visit_type_enum(Visitor *v, const char *name, int *obj,
                      const QEnumLookup *lookup, Error **errp);
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index e9fad756e189..d83434b95a56 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -359,11 +359,6 @@ opts_type_str(Visitor *v, const char *name, char **obj, bool consume,
         return false;
     }
     *obj = g_strdup(opt->str ? opt->str : "");
-    /* Note that we consume a string even if this is called as part of
-     * an enum visit that later fails because the string is not a
-     * valid enum value; this is harmless because tracking what gets
-     * consumed only matters to visit_end_struct() as the final error
-     * check if there were no other failures during the visit.  */
     if (consume) {
         processed(ov, name);
     }
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 89b52fc99202..1137d472290b 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -411,7 +411,7 @@ static bool input_type_enum(Visitor *v, const char *name, int *obj,
     int64_t value;
     g_autofree char *enum_str = NULL;
 
-    if (!visit_type_str(v, name, &enum_str, errp)) {
+    if (!visit_type_str_preserving(v, name, &enum_str, errp)) {
         return false;
     }
 
@@ -430,6 +430,8 @@ static bool input_type_enum(Visitor *v, const char *name, int *obj,
         return false;
     }
 
+    enum_str = NULL;
+    visit_type_str(v, name, &enum_str, &error_abort);
     *obj = value;
     return true;
 }

-- 
2.45.2



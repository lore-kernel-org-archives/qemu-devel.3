Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95E4E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOffo-0005y7-J7; Fri, 20 Dec 2024 11:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffk-0005qs-Kp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:16 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffh-0006ga-BF
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:15 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361d5dcf5bso22623705e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711371; x=1735316171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YaupKmRaiQE1rQ0k1M3YCIRubFuxasmL5+OyAuZAyCQ=;
 b=g1b0a9LqnPoufcmEXzmugZ9A2Hhiqgu9rv51cg5YIFvRsomTWGX1U/GEFsOFCLUkHT
 xmIm3jG4IAaF/zxwr/qAt1IiUpI20EmhPKpy5FpSm8zFOeOFJ3gjWq1KIJhlCraSrvlD
 b8V7zrs92Sozh+D581mTMuBsF7cmBoHyGSU8rluleKOL5G/3JqG71odI9ALzxruogDj5
 XlEn5zxZ9QuEDtORjil5TA4R3qPmZODRJ/WH2E39kkIgIvqouPbmZR3baVta1AvJ3q2n
 KIZuJl5Dmj5D6ZOfgyehecDM0S/U4sqP4zTMWkRS9acHeWWKnIyvfubPa5LiiWaouElD
 STWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711371; x=1735316171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YaupKmRaiQE1rQ0k1M3YCIRubFuxasmL5+OyAuZAyCQ=;
 b=kC0Rw1Q18MRdgxrBvIQ93/jpCHbZSB/VwjPWTDV5wED1h71KgrCojTCTm0sndeZK6g
 9X1ifFTZWH6lCmzlhx0yUkCd5wjDFhzz2HSfkpab5k5GqQ1W+QWOTp1BIIU9C+8EpIvc
 UAEbL9bpOh7w+2IdDN0FIbNwHPy1YTuhMyxoDbDX63tYZYB/i/BLbH/zutxhlVvapOde
 LlyQv8rGYhHJ71YabbHecn2oQ1ENZi6PgItI/u1ipQKv/Z1evU/rc/FoDVnvC/Limn9N
 nC68HQbeOAaospxoza1qi4E4jRj/eE2lxxP/Rdr9J9juH/mC+Q1ZRjVp0wVmCm1wnOVf
 S3tw==
X-Gm-Message-State: AOJu0YwqxQULVExxBooq+NNUvqrrF0MfaweiGFcr0w4kBUbjUh3fAOXQ
 qcUo890O7BXDDj3+3r3fW0w0/7G4ItSq3+zZPj075Z5RNsB1y+YgUvApDWJRT056SktzJt9Faef
 3
X-Gm-Gg: ASbGncuAME5eP71vMSbK3A8ah+pnZsWfjvLbN1pClrD26xxs4P0+IsRVIpH1vXMz4Ya
 AveYKLBejg5NYRcvS6m4GvggQs5UMK748R9CmczHWER+9GTGQX27l2MC4Gj+B+xB0nZHHNAeyAE
 h3ffVNm7eESbdFUlrLIyHO+WYLMMz+dp5N8PH0uHKg+Iwf2fuG+D+wmYmWdWfFWGOPHVfvQGjOI
 R1/YaKPW+oWoqsoq+HMao8vp1dsa3QVOXcImOuXQOs7HZrbIA4F+f6YCsa7/HdPCzpyyrFa8AI=
X-Google-Smtp-Source: AGHT+IE8JGDdkcwwUfQec342dLGKmWiBQpXQGKzUz+SS/+NnGz2gnoxLK5zwlQ/wR3kQTp9aBCe9xQ==
X-Received: by 2002:a05:6000:4a11:b0:385:dedb:a148 with SMTP id
 ffacd0b85a97d-38a223f5c90mr3454151f8f.46.1734711371349; 
 Fri, 20 Dec 2024 08:16:11 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8add5asm4318399f8f.107.2024.12.20.08.16.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:16:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/59] qom: New object_property_add_new_container()
Date: Fri, 20 Dec 2024 17:14:55 +0100
Message-ID: <20241220161551.89317-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Peter Xu <peterx@redhat.com>

To move towards explicit creations of containers, starting that by
providing a helper for creating container objects.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241121192202.4155849-3-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qom/object.h | 12 ++++++++++++
 qom/container.c      | 14 +++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index de02e16817c..95d6e064d9b 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2019,6 +2019,18 @@ int object_child_foreach_recursive(Object *obj,
  */
 Object *container_get(Object *root, const char *path);
 
+/**
+ * object_property_add_new_container:
+ * @obj: the parent object
+ * @name: the name of the parent object's property to add
+ *
+ * Add a newly created container object to a parent object.
+ *
+ * Returns: the newly created container object.  Its reference count is 1,
+ * and the reference is owned by the parent object.
+ */
+Object *object_property_add_new_container(Object *obj, const char *name);
+
 /**
  * object_property_help:
  * @name: the name of the property
diff --git a/qom/container.c b/qom/container.c
index cfec92a9447..20ab74b0e8d 100644
--- a/qom/container.c
+++ b/qom/container.c
@@ -24,6 +24,16 @@ static void container_register_types(void)
     type_register_static(&container_info);
 }
 
+Object *object_property_add_new_container(Object *obj, const char *name)
+{
+    Object *child = object_new(TYPE_CONTAINER);
+
+    object_property_add_child(obj, name, child);
+    object_unref(child);
+
+    return child;
+}
+
 Object *container_get(Object *root, const char *path)
 {
     Object *obj, *child;
@@ -37,9 +47,7 @@ Object *container_get(Object *root, const char *path)
     for (i = 1; parts[i] != NULL; i++, obj = child) {
         child = object_resolve_path_component(obj, parts[i]);
         if (!child) {
-            child = object_new(TYPE_CONTAINER);
-            object_property_add_child(obj, parts[i], child);
-            object_unref(child);
+            child = object_property_add_new_container(obj, parts[i]);
         }
     }
 
-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB42810ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Bh-0006NU-6w; Fri, 27 Mar 2026 07:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bc-0006Ki-17
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:08 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65BY-0007Uw-Jy
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-486fd5360d4so24981275e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610223; x=1775215023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkvAUvzvhzGaBsiBxwCLpDMp2ckMfQUEme3r+CbAUuk=;
 b=WZxrxWOYpQEu+uJ8THGO6CmppOOIoBWnMep52Ht6VL8mLFlbXJK25b4bi7b0Q9ETrR
 HXoY50TK343QR8CTrhgEAHOFBFsegAsl+r8ksmPEAl4oBkGxA/OJOL2OmJ8n7Ra241go
 wnWrY0fKvtQQdpMPLX065DUZfpJMPOxcf2ayFf2txMYNeYLVHlzXof2jN8eIv0TzCCOv
 12iOPp0skx17l+zD4jGleYv3/m1lRiuc7jL/UCiAWpqC2A0sinT81GNwi+WXBKKIRCc1
 c9fAZu4eB9+yyWcova5zpQQQz0bAemYpxXJ3yT1dTRWj5Bis0icNqpo6LsX+8iAih+tF
 u/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610223; x=1775215023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lkvAUvzvhzGaBsiBxwCLpDMp2ckMfQUEme3r+CbAUuk=;
 b=cODAEmjMkO2QGOwcguDgaYPxrOOI76ud1bP/E4dzyO7xrQUTE9NyvbwaMMwTOMlogO
 mXkuzV6qEPqe6NP8o1tcUxJOQr0teZEfqK041+9pZTnzfcAAeLFZE2jVgA1HLwP3eh36
 /+Dk2lDqDKm3aPzyBQKdqhFrw468elAT4AqBJpyf9H6AT59d+TUO4o8mcwRh0z2Nfbf6
 tqH0ojrMcwW0JJoJ6BvyMmaX0PxNyYsH3z59WlmnOAqa91ItStb3/Yiwm8NZIxE9/ZRj
 LXzASWoIcgTc90OLt2pg69Kw9niY6nSaXHkRxl2WByC8n1U6DholXNva8osAi66JqB/y
 Q2zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmVJTErIyZswpbZ1LE88c49WvbHRyo1uniEjHJxfctX6QV0Z5Zcnup6yUcKpGCLxhkyO7hZ8/Y9Kdx@nongnu.org
X-Gm-Message-State: AOJu0YxoyrvdDSpDZOscjWJYj/+SHViFjNkw721p+ppW4KPst5gp5pnI
 Mbxq3x8857yf4BLxIh0OWi2ljT02ZQcVt2iZmjyWZyWbp1ypXf3siPSUJ1aZBuK/j2Q=
X-Gm-Gg: ATEYQzwF4PFJFqtQS2Kt7ijuyTe2uDTMI+Qb0h71CPLOaHfwY3XtfPrBV9Gprj3Kl/c
 WO9apJ8h9OyW8EttBNdsSnLvmG+kdVz9Dfzo9RTZtoL4qlj7zOykP2Li+H/vULBJqpjj1TdBsoc
 vMWpPGP4n7Ns4ciUdolr3QkON/9eSKT82TWgLvw8GRyBzQBFcnj1DVx1wAYSu9BmvuWTU0o+Sv5
 hliVD2/luR2BgiYb83HsXXmYSZpB3kcWHdjowyNA8VMadMqeVMu1E6M+9M8gMWRP5xqwU8FYhxE
 piOG9WYgpQVlCz+nG5f+X1HOIM0bVUXFjFn3X9NjeMNkr/+oPYEJ3qeUxIuMTCGngq4lHLItDWX
 CtZ0hZHMYFlx7nONFTjciZGLKRxm/3hTu+sW2gOMrZqJgmCfJcAa17q90aLwt+gt1ZMeKBlX0yU
 EmHT9wIiJGDblhI/858lMiFw134gq+ikW/AfLTJVMjQssz7IcyzXNZWbv8dlJ5XN5RArl3yjJyW
 DXMBUd81zOJ5PV+pvDmUUbQeXd/Dnc=
X-Received: by 2002:a05:600c:524f:b0:485:4eaf:eb14 with SMTP id
 5b1f17b1804b1-48727ec7894mr34098055e9.21.1774610222821; 
 Fri, 27 Mar 2026 04:17:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 01/65] qom/object: Add object_resolve_and_typecheck()
Date: Fri, 27 Mar 2026 11:15:56 +0000
Message-ID: <20260327111700.795099-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a new function object_resolve_and_typecheck(), whose purpose is
to look up the object at a given QOM path, confirm that it is the
expected type, and return it.  This is similar to the existing
object_resolve_path_type(), but it insists on a non-ambiguous path.

We were already using this functionality internally to object.c as
part of the object_resolve_link() function, so this patch implements
the new function by pulling the link-property specific parts out of
the more generic resolve-and-typecheck part.

The motivation for this function is that we want to allow devices to
provide an array of link properties; for that we will need to be able
to provide the expected type of the linked object in a different way
to the single-item link properties.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qom/object.h | 17 +++++++++++++++++
 qom/object.c         | 41 +++++++++++++++++++++++------------------
 2 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 26df6137b9..797688f25e 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1750,6 +1750,23 @@ ObjectProperty *object_class_property_add_link(ObjectClass *oc,
                                             Object *val, Error **errp),
                               ObjectPropertyLinkFlags flags);
 
+/**
+ * object_resolve_and_typecheck:
+ * @path: path to look up
+ * @name: name of property we are resolving for (used only in error messages)
+ * @target_type: QOM type we expect @path to resolve to
+ * @errp: error
+ *
+ * Look up the object at @path and return it. If it does not have the
+ * correct type @target_type, return NULL and set @errp.
+ *
+ * This is similar to object_resolve_path_type(), but it insists on a
+ * non-ambiguous path and it produces error messages that are
+ * specialised to the use case of setting a link property on an object.
+ */
+Object *object_resolve_and_typecheck(const char *path, const char *name,
+                                     const char *target_type, Error **errp);
+
 /**
  * object_property_add_str:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index ff8ede8a32..046b15c7f4 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1895,26 +1895,12 @@ static void object_get_link_property(Object *obj, Visitor *v,
     }
 }
 
-/*
- * object_resolve_link:
- *
- * Lookup an object and ensure its type matches the link property type.  This
- * is similar to object_resolve_path() except type verification against the
- * link property is performed.
- *
- * Returns: The matched object or NULL on path lookup failures.
- */
-static Object *object_resolve_link(Object *obj, const char *name,
-                                   const char *path, Error **errp)
+Object *object_resolve_and_typecheck(const char *path, const char *name,
+                                     const char *target_type, Error **errp)
 {
-    const char *type;
-    char *target_type;
     bool ambiguous = false;
     Object *target;
 
-    /* Go from link<FOO> to FOO.  */
-    type = object_property_get_type(obj, name, NULL);
-    target_type = g_strndup(&type[5], strlen(type) - 6);
     target = object_resolve_path_type(path, target_type, &ambiguous);
 
     if (ambiguous) {
@@ -1931,11 +1917,30 @@ static Object *object_resolve_link(Object *obj, const char *name,
         }
         target = NULL;
     }
-    g_free(target_type);
-
     return target;
 }
 
+/*
+ * object_resolve_link:
+ *
+ * Lookup an object and ensure its type matches the link property type.  This
+ * is similar to object_resolve_path() except type verification against the
+ * link property is performed.
+ *
+ * Returns: The matched object or NULL on path lookup failures.
+ */
+static Object *object_resolve_link(Object *obj, const char *name,
+                                   const char *path, Error **errp)
+{
+    const char *type;
+    g_autofree char *target_type = NULL;
+
+    /* Go from link<FOO> to FOO.  */
+    type = object_property_get_type(obj, name, NULL);
+    target_type = g_strndup(&type[5], strlen(type) - 6);
+    return object_resolve_and_typecheck(path, name, target_type, errp);
+}
+
 static void object_set_link_property(Object *obj, Visitor *v,
                                      const char *name, void *opaque,
                                      Error **errp)
-- 
2.43.0



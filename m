Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A5EFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHlk3-0007Qo-5F; Tue, 28 Apr 2026 12:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3QuTwaQQKCiUSLJSHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--rkir.bounces.google.com>)
 id 1wHlk1-0007Q1-62
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:56:57 -0400
Received: from mail-qt1-x849.google.com ([2607:f8b0:4864:20::849])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3QuTwaQQKCiUSLJSHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--rkir.bounces.google.com>)
 id 1wHljz-0005qi-Sf
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:56:56 -0400
Received: by mail-qt1-x849.google.com with SMTP id
 d75a77b69052e-50d84b5f73bso109175961cf.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777395414; x=1778000214; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=TL1L51oQCGIW4br1aTdVOo6QOP2GeP5tlFhllIDhyrE=;
 b=PsZHb7gQBHD8+JG9PkgblEAz+KRI+gFmxiOUW2Rvj1R0w2XSY4DKPZTGZ6bslJRVTO
 8ClrCbv2O7CjOq9/BiR7vtv8iD26KnzBKXOv8fwWCk+MYMslh4TRUFkYPfBGGre871vO
 /aBJHg4pclpYhsH/fnA1aKaGo4kvpOusnuZgKvw7ok29WPnUlPiAzjWSGGbiNAm4iGJJ
 E8n3Rx2v064wwT89JCGdwjroA+LqaISo365BhHSQDqcfT7X7c9R8AH/7BClV5oU/43Yq
 zsEP9OCq/zkD9hZCjF/3lJ5G83fBswQh3oZyx2vKwigsx54guYCPa1HGNJRBfJXCMg/D
 9E2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777395414; x=1778000214;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TL1L51oQCGIW4br1aTdVOo6QOP2GeP5tlFhllIDhyrE=;
 b=DV2z+9QEBQI5nCnnyh0Db0Kel/OzMWMMwFvAGfUYITQsAgcbrVfLHF8ZlgdOv+dIdR
 7+4lWghUBPTGT0kU1PtWCMDxr6V5+kYlE9omHO9bRFlhJEPxDL1qybuMIxUsJKXUNoqC
 iXA3Lfb29+4QZ/TrAyWd5nKA9ZcWVB/gk8ZglqGBSHDOxO1fTaxD3PSV5Pe67ta+SOWd
 QvCxSfVpHpXENO6Ttv3QBhDMFHjos5nyYpu+C5J/w9KT58RbE/s1nc/xPSaP8je+ahrW
 SQgNf8o6xT/H8kXA1u/S0uiewip56X2tjVAmRww44Q89bAtlxGVtiAnfhMYtpPveX4TZ
 4Qnw==
X-Gm-Message-State: AOJu0YwQoPj+AxPxp8qDHgGz5QTMLEBWyuHC2/krQYYUwuZaDdOTfJPv
 WH4o1QSnd0PHfxOOZaIzQK/BrgceKKipgBeBmbMYjU8qudkwJaKCT6LA0dbWWbvJ/O0FKSj79w=
 =
X-Received: from pgar18.prod.google.com ([2002:a05:6a02:2e92:b0:c6d:c043:2cb4])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1344:b0:35b:90e7:c44f
 with SMTP id 98e67ed59e1d1-36491f8775cmr4174357a91.7.1777394754032; Tue, 28
 Apr 2026 09:45:54 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:45:44 +0000
In-Reply-To: <20260428164545.2782523-1-rkir@google.com>
Mime-Version: 1.0
References: <20260427154441.1918536-1-rkir@google.com>
 <20260428164545.2782523-1-rkir@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428164545.2782523-2-rkir@google.com>
Subject: [PATCH v2 1/2] qom: improve use-after-free debugging
From: Roman Kiryanov <rkir@google.com>
To: pbonzini@redhat.com, alex.bennee@linaro.org, marcandre.lureau@gmail.com
Cc: qemu-devel@nongnu.org, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::849;
 envelope-from=3QuTwaQQKCiUSLJSHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--rkir.bounces.google.com;
 helo=mail-qt1-x849.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This patch invalidates dead objects so their usage will
lead to more predictable results (crashes or asserts).

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v2:
- Updated clearing of obj->properties using g_clear_pointer.
- Moved clearing of obj->class into object_deinit.
- obj->class is checked to be NULL before obj->free(obj).

 qom/object.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index f981e27044..b8ffb00976 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -612,7 +612,7 @@ static void object_property_del_all(Object *obj)
         }
     } while (released);
 
-    g_hash_table_unref(obj->properties);
+    g_clear_pointer(&obj->properties, g_hash_table_unref);
 }
 
 static void object_property_del_child(Object *obj, Object *child)
@@ -658,6 +658,9 @@ static void object_deinit(Object *obj, TypeImpl *type)
     if (type_has_parent(type)) {
         object_deinit(obj, type_get_parent(type));
     }
+
+    g_assert(obj->properties == NULL);
+    obj->class = NULL;
 }
 
 static void object_finalize(void *data)
@@ -670,6 +673,7 @@ static void object_finalize(void *data)
 
     g_assert(obj->ref == 0);
     g_assert(obj->parent == NULL);
+    g_assert(obj->class == NULL);
     if (obj->free) {
         obj->free(obj);
     }
-- 
2.54.0.545.g6539524ca2-goog



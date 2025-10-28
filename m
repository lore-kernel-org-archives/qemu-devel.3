Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D2CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnbk-0006Pd-5y; Tue, 28 Oct 2025 13:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbU-0006LX-PU
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbK-0004gy-FV
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1CJCXRRGP7uLhGWFgtNrE3fPS/hb7R8Y1xh7f9G0YyU=;
 b=fjzxcmmHIKmR19U321SfHW+5cD1qBFdgQWCrum3Sxz1G3/HsJ10dHIorHTtv9icwzkmrQw
 DhSNzqkRSGpi9wXkYEMgf0/Qsu/Zv3nsNqsKrfAH5qcvZ11Q/qdUONttWyBshWOubVPEQ/
 E0vQ1J9oAuqOyE/nBT2NzXJWpLZ0hSw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-KoC2KdW9MNS_KwOW8rjGFg-1; Tue, 28 Oct 2025 13:35:15 -0400
X-MC-Unique: KoC2KdW9MNS_KwOW8rjGFg-1
X-Mimecast-MFC-AGG-ID: KoC2KdW9MNS_KwOW8rjGFg_1761672915
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-475de1afec6so375785e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672914; x=1762277714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1CJCXRRGP7uLhGWFgtNrE3fPS/hb7R8Y1xh7f9G0YyU=;
 b=Axb1nTV3HYznVgwslqtiz8ZMLWW6rUG91IV356r00DWn2Eq0/JA2PCutBB8Kv3xQjM
 RsweZkLiCtkkros+Ss+VrvMK02JW9N2jFe8q+LNp5dDXM2CnpW4wYzxV9kM1dt/TjEWl
 9wK+WQsqfcCEAuzHABoEJjWtkXWkCUS/Sq05+QuEbf2eMWC5sTuuIlPvpi3fqf5HxS9a
 xTtked6cpqwX5qsew57Uo6ehhAJ9vxb7A80AmdRESTyErusJ5ythLtoO5BVB+e6QiKKW
 WFU6rMUHOk4PmE+MO7divym63h9DldIcOIAFY+Qyl3Js/FdqLbKEmufpRVU53Cn25C/r
 oGdg==
X-Gm-Message-State: AOJu0YzCCGDq1r8TbzITQ+bsI7bti37I0USCuZ6SzH25HQcib/ZDZLQ5
 1f3cKI7UA8xRfTQDgveJUQmpn0+HuDydRjup8FiFTWqdGMOAC8NZ2RLkvVMMedvPGFZtCSwayTU
 4lU/+/UJhKgbt6qi7WJ5G5YzYBP25eNzKwq9eYgzNFmHKsklphB2Sdrte08F55gRSnCU3ssexT5
 lVTrurHElf6WpLzlyoSZBz4cylgg4R4agpq1g2u+KU
X-Gm-Gg: ASbGncvVt5vKeY3CFZr3hbZlsZnsTkBx89Ne/wPUbyct8Q0F1gUSf/KJ4//T6nOArGv
 IItAsM86H7WkGKn7brivwr0k/qA68Z2YD558mhgzHhI/zGvpbeCWqHcEh9Z4IEu/LSlotdSrC9x
 fNmVa2956HT7eMXrVtRQ2i5qK4HH+GKaPzrP+MtA22HypZ2nAtQOldKEUpDp7ykLLMNqJTgEgxB
 +/9rRXa6Em1HfzhkkpZg/BZ0HvKovsFKc1cg8m1TL/ene+H1KIhdi2rPv9P92A2Ud4VfImIkBYK
 3zNXDHwYsvpB1mAdvtgVSXlL/2+Tjey//0J53WqWsOAn3Rj6TJ+BB/gP3PW7hDmHUHnSUQjE+5g
 4fsn6SIqi0dysvuda8E6WlILe5wuafcLXLg2/8Q9w2fcdlRp5oukdPGE9dFRuzzGD+DlhUkQyFS
 NxPRs=
X-Received: by 2002:a05:600c:a219:b0:477:115b:878d with SMTP id
 5b1f17b1804b1-477181969damr21247395e9.15.1761672913648; 
 Tue, 28 Oct 2025 10:35:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe0BE3U50MxF4FLfVJUMMLlt3GnwC3c3MfG7x6VEJk3X2q5qIjKpngq3HtLGx09mqr+GrBNg==
X-Received: by 2002:a05:600c:a219:b0:477:115b:878d with SMTP id
 5b1f17b1804b1-477181969damr21247135e9.15.1761672913106; 
 Tue, 28 Oct 2025 10:35:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e196a4bsm4168825e9.6.2025.10.28.10.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:35:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 14/18] qdev: Change PropertyInfo method print() to return
 malloc'ed string
Date: Tue, 28 Oct 2025 18:34:26 +0100
Message-ID: <20251028173430.2180057-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Markus Armbruster <armbru@redhat.com>

Simpler (more so after the next commit), and no risk of truncation
because the caller's buffer is too small.  Performance doesn't matter;
the method is only used for "info qdev".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20251022101420.36059-2-armbru@redhat.com
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-properties.h     | 2 +-
 hw/core/qdev-properties-system.c | 7 +++----
 hw/core/qdev-properties.c        | 9 ++++-----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 0197aa4995e..60b81330097 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -34,7 +34,7 @@ struct PropertyInfo {
     const char *description;
     const QEnumLookup *enum_table;
     bool realized_set_allowed; /* allow setting property on realized device */
-    int (*print)(Object *obj, const Property *prop, char *dest, size_t len);
+    char *(*print)(Object *obj, const Property *prop);
     void (*set_default_value)(ObjectProperty *op, const Property *prop);
     ObjectProperty *(*create)(ObjectClass *oc, const char *name,
                               const Property *prop);
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index c15371f8cd1..13cc91680b1 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -865,15 +865,14 @@ out:
     visit_end_alternate(v, (void **) &alt);
 }
 
-static int print_pci_devfn(Object *obj, const Property *prop, char *dest,
-                           size_t len)
+static char *print_pci_devfn(Object *obj, const Property *prop)
 {
     int32_t *ptr = object_field_prop_ptr(obj, prop);
 
     if (*ptr == -1) {
-        return snprintf(dest, len, "<unset>");
+        return g_strdup("<unset>");
     } else {
-        return snprintf(dest, len, "%02x.%x", *ptr >> 3, *ptr & 7);
+        return g_strdup_printf("%02x.%x", *ptr >> 3, *ptr & 7);
     }
 }
 
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index b7e8a89ba5c..422a486969c 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1117,12 +1117,11 @@ static void qdev_get_legacy_property(Object *obj, Visitor *v,
                                      Error **errp)
 {
     const Property *prop = opaque;
+    char *s;
 
-    char buffer[1024];
-    char *ptr = buffer;
-
-    prop->info->print(obj, prop, buffer, sizeof(buffer));
-    visit_type_str(v, name, &ptr, errp);
+    s = prop->info->print(obj, prop);
+    visit_type_str(v, name, &s, errp);
+    g_free(s);
 }
 
 /**
-- 
2.51.1



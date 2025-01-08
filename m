Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F06E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 06:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVPOP-0000hi-HD; Wed, 08 Jan 2025 01:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVPON-0000h6-GZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 01:18:11 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVPOL-0000GL-EI
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 01:18:11 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216281bc30fso25418205ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 22:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736317088; x=1736921888;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EN+qqbOe1sSXYPmH2HeJgFF7KPD7SBBT9uZwyt+R3fE=;
 b=FqVpzpX/YWN/Ht8pwpwOxaQYWUcuF7Oam8iO+XNYkKHnfXhNJo64zulCMNI8SNJM6x
 RyhwwIy7/dpJkSL2s8RdgNPO14gDWtcvpUU8GjxNh3fOnJbl1G6XwDMi+nWtVj0d1Mdg
 Um62BbIFJC73i6995DhsOra0dH5NEUtGFTYygk5kM5MA2aAEf3mAsInx8oUM5eo4AEAo
 rUjmFe5oNO5qqKp+Gti2LlWj9LziHQGXzSQm/ZzcI/0ft+YRHKFAOh2cINd3xwyQlDsQ
 r5S5SBnIWcov3w2FJUaMdPCM5UUP2DCPSpINgG2SlPxVH639yCo1jDk3sodvumeltzsl
 vo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736317088; x=1736921888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EN+qqbOe1sSXYPmH2HeJgFF7KPD7SBBT9uZwyt+R3fE=;
 b=QnUsSJYgvA0+IXC16XyZgNS3jFHPqzPIN/HfthACH6GPD43xOY1bQcQlG/FVXnlBIC
 BklcuhQHTsXQmK0Jcmu8wVjDtUjEGuBDJASzN1FomjeEUDhlHYTs+JzjOy2H1n686mUe
 yQJei9HIde+vSzHpsoO8WuGq98pBrqhwhq0kEHpITt9x+q2OVOIRC8fxYmnjgLgvD6F5
 Gs1BNRiRbFl8+jWtrEJjR/XBcF0SLo9LfUX8xCP634L2mRaJEv9Jb+fksS79smVf5MH6
 iqlLsxHEmG6Dpvi6uegN+OQyZJFNdgUTSLYIHdSnU4fdZUm9J1jHGRrUmAw6Y45atH8y
 96VQ==
X-Gm-Message-State: AOJu0Yxq/UGN93t5IzubYdlQRKW1xZzpJDnjv/byTH8sCUZCfYV9voqz
 2fjTBl5acccRRgr/Ep6wVaXRtPI3RFz4bGZRSp76ReA4V4EejEhvZOiGDrxbL3Y=
X-Gm-Gg: ASbGnctGQFBFI8hBt9jVPOweH2NAgsojAh5l94anFYNqsN2fq/QVVgGF98zNvho87zO
 BHlbYHtA4EeXQAevdAIQXBBvcomg6TQWclOHRX3xORxgvUpNIpsUizDpClT9uQMj9rywy1SEP6o
 YZNnpkBG8bpf6t+2NZGzM7eyJFp/br1eezO0GPpmam70c665HWRPuxNZoV284mnfJuE3ZqLMPia
 UeZV29Zb3qLyK95R62V9KCLwDQ/e5uUPKgBa55/H1K8ac4B0oLWoiT7Ouo=
X-Google-Smtp-Source: AGHT+IEXlTmSqS2zl3C7FY9J+SGnB9yCDQen3MxQhKGoeW7uEYosnBkh43sAfeWomrPlhjnb2soM4g==
X-Received: by 2002:a17:903:1d0:b0:216:2474:3c9f with SMTP id
 d9443c01a7336-21a83fe2fb0mr24918145ad.52.1736317087851; 
 Tue, 07 Jan 2025 22:18:07 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc9f4406sm320111165ad.170.2025.01.07.22.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 22:18:07 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 08 Jan 2025 15:17:50 +0900
Subject: [PATCH v4 1/4] qapi: Do not consume a value if failed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-virtio-v4-1-cbf0aa04c9f9@daynix.com>
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
In-Reply-To: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Lei Yang <leiyang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Do not consume a value if interpreting one failed so that we can
reinterpret the value with a different type.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 qapi/qobject-input-visitor.c | 103 +++++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 34 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index f110a804b2ae..799c1c9bd6bd 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -116,9 +116,8 @@ static const char *full_name(QObjectInputVisitor *qiv, const char *name)
     return full_name_nth(qiv, name, 0);
 }
 
-static QObject *qobject_input_try_get_object(QObjectInputVisitor *qiv,
-                                             const char *name,
-                                             bool consume)
+static QObject *qobject_input_try_get_object(const QObjectInputVisitor *qiv,
+                                             const char *name)
 {
     StackObject *tos;
     QObject *qobj;
@@ -138,34 +137,19 @@ static QObject *qobject_input_try_get_object(QObjectInputVisitor *qiv,
     if (qobject_type(qobj) == QTYPE_QDICT) {
         assert(name);
         ret = qdict_get(qobject_to(QDict, qobj), name);
-        if (tos->h && consume && ret) {
-            bool removed = g_hash_table_remove(tos->h, name);
-            assert(removed);
-        }
     } else {
         assert(qobject_type(qobj) == QTYPE_QLIST);
         assert(!name);
-        if (tos->entry) {
-            ret = qlist_entry_obj(tos->entry);
-            if (consume) {
-                tos->entry = qlist_next(tos->entry);
-            }
-        } else {
-            ret = NULL;
-        }
-        if (consume) {
-            tos->index++;
-        }
+        ret = tos->entry ? qlist_entry_obj(tos->entry) : NULL;
     }
 
     return ret;
 }
 
 static QObject *qobject_input_get_object(QObjectInputVisitor *qiv,
-                                         const char *name,
-                                         bool consume, Error **errp)
+                                         const char *name, Error **errp)
 {
-    QObject *obj = qobject_input_try_get_object(qiv, name, consume);
+    QObject *obj = qobject_input_try_get_object(qiv, name);
 
     if (!obj) {
         error_setg(errp, QERR_MISSING_PARAMETER, full_name(qiv, name));
@@ -173,6 +157,38 @@ static QObject *qobject_input_get_object(QObjectInputVisitor *qiv,
     return obj;
 }
 
+static void qobject_input_consume_object(QObjectInputVisitor *qiv,
+                                         const char *name)
+{
+    StackObject *tos;
+    QObject *qobj;
+
+    if (QSLIST_EMPTY(&qiv->stack)) {
+        /* Starting at root, name is ignored. */
+        return;
+    }
+
+    /* We are in a container; find the next element. */
+    tos = QSLIST_FIRST(&qiv->stack);
+    qobj = tos->obj;
+    assert(qobj);
+
+    if (qobject_type(qobj) == QTYPE_QDICT) {
+        assert(name);
+        if (tos->h) {
+            bool removed = g_hash_table_remove(tos->h, name);
+            assert(removed);
+        }
+    } else {
+        assert(qobject_type(qobj) == QTYPE_QLIST);
+        assert(!name);
+        if (tos->entry) {
+            tos->entry = qlist_next(tos->entry);
+        }
+        tos->index++;
+    }
+}
+
 static const char *qobject_input_get_keyval(QObjectInputVisitor *qiv,
                                             const char *name,
                                             Error **errp)
@@ -180,7 +196,7 @@ static const char *qobject_input_get_keyval(QObjectInputVisitor *qiv,
     QObject *qobj;
     QString *qstr;
 
-    qobj = qobject_input_get_object(qiv, name, true, errp);
+    qobj = qobject_input_get_object(qiv, name, errp);
     if (!qobj) {
         return NULL;
     }
@@ -233,6 +249,7 @@ static const QListEntry *qobject_input_push(QObjectInputVisitor *qiv,
         tos->index = -1;
     }
 
+    qobject_input_consume_object(qiv, name);
     QSLIST_INSERT_HEAD(&qiv->stack, tos, node);
     return tos->entry;
 }
@@ -279,7 +296,7 @@ static bool qobject_input_start_struct(Visitor *v, const char *name, void **obj,
                                        size_t size, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
 
     if (obj) {
         *obj = NULL;
@@ -316,7 +333,7 @@ static bool qobject_input_start_list(Visitor *v, const char *name,
                                      Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
     const QListEntry *entry;
 
     if (list) {
@@ -382,7 +399,7 @@ static bool qobject_input_start_alternate(Visitor *v, const char *name,
                                           Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, false, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
 
     if (!qobj) {
         *obj = NULL;
@@ -397,7 +414,7 @@ static bool qobject_input_type_int64(Visitor *v, const char *name, int64_t *obj,
                                      Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
     QNum *qnum;
 
     if (!qobj) {
@@ -409,6 +426,7 @@ static bool qobject_input_type_int64(Visitor *v, const char *name, int64_t *obj,
                    full_name(qiv, name));
         return false;
     }
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -428,6 +446,7 @@ static bool qobject_input_type_int64_keyval(Visitor *v, const char *name,
                    full_name(qiv, name), "integer");
         return false;
     }
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -435,7 +454,7 @@ static bool qobject_input_type_uint64(Visitor *v, const char *name,
                                       uint64_t *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
     QNum *qnum;
     int64_t val;
 
@@ -448,12 +467,14 @@ static bool qobject_input_type_uint64(Visitor *v, const char *name,
     }
 
     if (qnum_get_try_uint(qnum, obj)) {
+        qobject_input_consume_object(qiv, name);
         return true;
     }
 
     /* Need to accept negative values for backward compatibility */
     if (qnum_get_try_int(qnum, &val)) {
         *obj = val;
+        qobject_input_consume_object(qiv, name);
         return true;
     }
 
@@ -479,6 +500,7 @@ static bool qobject_input_type_uint64_keyval(Visitor *v, const char *name,
                    full_name(qiv, name), "integer");
         return false;
     }
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -486,7 +508,7 @@ static bool qobject_input_type_bool(Visitor *v, const char *name, bool *obj,
                                     Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
     QBool *qbool;
 
     if (!qobj) {
@@ -500,6 +522,7 @@ static bool qobject_input_type_bool(Visitor *v, const char *name, bool *obj,
     }
 
     *obj = qbool_get_bool(qbool);
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -518,6 +541,7 @@ static bool qobject_input_type_bool_keyval(Visitor *v, const char *name,
                    full_name(qiv, name), "'on' or 'off'");
         return false;
     }
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -525,7 +549,7 @@ static bool qobject_input_type_str(Visitor *v, const char *name, char **obj,
                                    Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
     QString *qstr;
 
     *obj = NULL;
@@ -540,6 +564,7 @@ static bool qobject_input_type_str(Visitor *v, const char *name, char **obj,
     }
 
     *obj = g_strdup(qstring_get_str(qstr));
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -549,15 +574,20 @@ static bool qobject_input_type_str_keyval(Visitor *v, const char *name,
     QObjectInputVisitor *qiv = to_qiv(v);
     const char *str = qobject_input_get_keyval(qiv, name, errp);
 
+    if (!str) {
+        return false;
+    }
+
     *obj = g_strdup(str);
-    return !!str;
+    qobject_input_consume_object(qiv, name);
+    return true;
 }
 
 static bool qobject_input_type_number(Visitor *v, const char *name, double *obj,
                                       Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
     QNum *qnum;
 
     if (!qobj) {
@@ -571,6 +601,7 @@ static bool qobject_input_type_number(Visitor *v, const char *name, double *obj,
     }
 
     *obj = qnum_get_double(qnum);
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -593,6 +624,7 @@ static bool qobject_input_type_number_keyval(Visitor *v, const char *name,
     }
 
     *obj = val;
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -600,7 +632,7 @@ static bool qobject_input_type_any(Visitor *v, const char *name, QObject **obj,
                                    Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
 
     *obj = NULL;
     if (!qobj) {
@@ -608,6 +640,7 @@ static bool qobject_input_type_any(Visitor *v, const char *name, QObject **obj,
     }
 
     *obj = qobject_ref(qobj);
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -615,7 +648,7 @@ static bool qobject_input_type_null(Visitor *v, const char *name,
                                     QNull **obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
 
     *obj = NULL;
     if (!qobj) {
@@ -628,6 +661,7 @@ static bool qobject_input_type_null(Visitor *v, const char *name,
         return false;
     }
     *obj = qnull();
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -647,13 +681,14 @@ static bool qobject_input_type_size_keyval(Visitor *v, const char *name,
                    full_name(qiv, name), "size");
         return false;
     }
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
 static void qobject_input_optional(Visitor *v, const char *name, bool *present)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_try_get_object(qiv, name, false);
+    QObject *qobj = qobject_input_try_get_object(qiv, name);
 
     if (!qobj) {
         *present = false;

-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DD3C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4XJ-00029L-16; Thu, 06 Mar 2025 01:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tq4XH-000292-IA
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:16:47 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tq4XF-0003VD-8R
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:16:47 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22382657540so3880355ad.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741241803; x=1741846603;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PNVlTce1uhHhS6pAL94t07YGCV3qzSeEltruk5DehEo=;
 b=YStnCZx//8ZtmSQwHr4H0ypAy01Pk4rdEuQaGb4gZzi15UgIv8aPCllTdvuQPOJ2or
 ZPwkj+GyMgRSlNTaK68QPKQm1rbSU/j9FULyE41nSrKXsV17H3/nWHYmdLKStyW86wAA
 F1GOhIm123kf+6Uf9KZ/+aBPloulc0eJtdUn0Ot89PIkvCJqkjRR+7k2Py6xsS5SxxPS
 zTW1F2G7nykllQMfOPzc1HLw/TkbvtBjWAWwzFV+j6a7j00md/MaTcafLOwHR/d6J8um
 VplAn5n9dugcpeU0JaGha8Xx/LG+6xe/ThcwMuUL+mdyPYJxRsPkZaVCFzIZHLSQjc2J
 xSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741241803; x=1741846603;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PNVlTce1uhHhS6pAL94t07YGCV3qzSeEltruk5DehEo=;
 b=PshAZIX/EJlnQfxir1bXN4zm/qKhIaKIScnmfEeAG3Uh5xr1+D3OcTHNtEqMAk5NpU
 7HFiRV9n4tRor1CpOS+MEXqBBlRjfIG4Pcwy4VmEJ2zsYFcgKd8d466Ox/xzwhxFF4Lc
 KQ4sZwyFrTvUKAgOZ6vIS/9FqssDiJs8vaP4AFoO7xUv5FzPz/7d7V2UuDZr0n0jrGvS
 TK7YLam1G8I+toHTlX9hmFDY8+5veMMAdeJR0ZaqsaZNH/io+Y9sXGOGTElawbPNoH9n
 eHIcB9atF8feuLfqbrh1kosNs5KYwtV5+jzmiyz4OuZ7onOhzpZwkMlYjEByFfc2NG2R
 UWSw==
X-Gm-Message-State: AOJu0Yxd8dLypNMX5lvRT9CfjSQNsu+NC292eLRxHxXVVeU+M9VkCpds
 USVm9DqgtlkzAixnafocXjtFEkNunKsGv1jJDMb5xbI3ZZkbvTJGaP3Zzr5fNZw=
X-Gm-Gg: ASbGncvHJR8Og6/O5a5Ry/l7YEdFvA2Kta1KEjXN8LWVQPmbndhqP1yB72wrTFxvPIx
 seVpZKFUJIpYugnpCGM3ku+Vbw5bOFLZSHQKIXtPLZJ5FlRLYyDhxyvDTfOFAvQs9GEFSz0DYIh
 B+KwzV3Ur5JV3tzn6K+NWh6ELpFPH6J1RU/vyomOepMmgigulSsfoLt7E4gQIk0Tr0QhlRbtfyh
 cu3wwWZJfRXHFxdlIeF7HLxLzmq6Da5eN0IKrcI6SoDKZ3CNQdYMCofnDLUUkDNw9p8a32cb2Bl
 FQnG70AeH/Cb/5RXrVP6ET7g/Rr5g9Sts3wVOUKimlN6L+IA
X-Google-Smtp-Source: AGHT+IFjEjwNBXZq3sUdUFNGRgDCchxDULTae+EBzGiSea57VQUknE5+DPPRSgrKtIzRs6MxjfrbYw==
X-Received: by 2002:a17:902:c94b:b0:21a:8300:b9ce with SMTP id
 d9443c01a7336-223f1d40770mr97259135ad.49.1741241803595; 
 Wed, 05 Mar 2025 22:16:43 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22410a918e5sm4244205ad.167.2025.03.05.22.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 22:16:43 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 06 Mar 2025 15:16:27 +0900
Subject: [PATCH v6 1/4] qapi: Do not consume a value if failed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-virtio-v6-1-1235eab776d9@daynix.com>
References: <20250306-virtio-v6-0-1235eab776d9@daynix.com>
In-Reply-To: <20250306-virtio-v6-0-1235eab776d9@daynix.com>
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
 Lei Yang <leiyang@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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
index c52d36997df8d99bc575c553a413df8ebcb60c32..0cc75b3c74e40a24cb1ce764330ae2703e80d7cf 100644
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
2.48.1



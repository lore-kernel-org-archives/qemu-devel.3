Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1687BC3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCnye-0000fD-O2; Wed, 07 May 2025 19:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyb-0000dZ-SY
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:14:57 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyZ-00079d-Mp
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:14:57 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22fa28c761dso623645ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746659694; x=1747264494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhiIRKHyUZ235NNHNWt0hyw55Q2IbZusuEz+nlETwVY=;
 b=ibhAnEExR+slNbfTHAu2MEO4MhH1ZGVJok4kpnYuh+/56dsWq6YbLSkEH7Kh9swdCn
 uzNqj5w4YiXFwJISHw+ivXOj3dNlV9kdG+4+PYfxsCUsaGYGhHESKydi7YwELD3HJv7V
 UZzFXk0sCzrFuekzi5E2bEQ7WKouCaJfrDD+RbkzadKJc/4R6fwQ54kJOxqwXkZg97a3
 MPrviia1WymUziV1DjoaWYAy2btVxN0oTOQA7gDhZeM26EGanwU6MJMnP1i+5YU9HqUg
 a9ovw5YLpXO+bQEF4fNwPUZx6ACVZmkRWTXKpaGjywzk1o6jbgn1trMvbn+DwjfqDz5o
 dZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746659694; x=1747264494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhiIRKHyUZ235NNHNWt0hyw55Q2IbZusuEz+nlETwVY=;
 b=jm4zZhcGFBolFGZcemfk7F/rZPd/anzzkNc7N71gDwDdlu4LalGwCPPR1UHetjd0nv
 QtAB5HxOShQRJmutfj+dXokhy9tlaE2GbVpJRPRLepeXAdKSGj0J3OcrfgZbPDuGl5yQ
 TpecA6DgzGx+0jnzrqpcTaUPxREjQ+mYvszEvgTKKFguI5uiP/7PjMdRQGsa8T022Rb8
 DGrrRIDf5DM5EVUTctz8D7JlH3wBlC3HgyF9mM41v2rJNDAJVnzFRsL4jasZCnj+Fg+g
 GUIIYgE9mKfijLL1ITbRJX2XCxCrJb9cDGEIGaRVHmZITDTUZJ7zIixdFZaNZXqY9XTB
 6nmw==
X-Gm-Message-State: AOJu0YwwkCGhXA6KCKas3bsvf2j2hLnPFLgCLEB6hrYVEjtZOU0OWYXu
 JCzZjPwEdGKm8LBoMU1ENm5L5hggL0/N/2tKSOFqvrTmZqB/soEjfov5b3BFEH+ZPq2mSc2i4Mf
 lp9Dj1g==
X-Gm-Gg: ASbGncs3B7fh8//6+zGT6GLEkmyS8SMeVJ81jysaDx0ct/UOAAUI3sRV3tkuZGxuavN
 VKi/Jgx18XYHQP8u80ijk0wKNN3KzsUsagmGCEAv/Xj1bf2WcZ1huTlEzUj0Qxe4Lltkh0eUYMT
 EjN7vHE747rZvFDPnpykKoJjV6sOVGG1DaYf3c/UMmMUbOJm4QiH4JG7O+gcqqdizVMFgpqnHMO
 5cTgJKvQnLBtJI4j89fllh41RfOCNlz9rBZgIQys+8dpYKkvViEV9iTNo2LkJh5NGCQVCyyEbvF
 JT/Tw7Fg2jT2WtxLU0ZBToQ0gk5GuB6pjzi9x8+6
X-Google-Smtp-Source: AGHT+IE+tqhb23NzcyLZrS8zszCOAEaHMps9EvfqBIE/hUipmu4OmI9TA2OFHfgklbeiJ1hUjkRxQg==
X-Received: by 2002:a17:902:fc4e:b0:22f:a48f:7a99 with SMTP id
 d9443c01a7336-22fa48f7dd7mr1053085ad.26.1746659694154; 
 Wed, 07 May 2025 16:14:54 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e421a7dafsm40103205ad.69.2025.05.07.16.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:14:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, alex.bennee@linaro.org,
 stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 berrange@redhat.com, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 03/13] qobject/qlit: allow to hide dict or list entries
Date: Wed,  7 May 2025 16:14:33 -0700
Message-ID: <20250507231442.879619-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

We add a new .hidden field to qlit entries, which gets ignored when
creating the associated QObject.
By default .hidden is 0, so it means the entry is visible. This way,
only potentially hidden elements need to be assigned.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qobject/qlit.h | 12 ++++++++++++
 qobject/qlit.c         | 10 ++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/qobject/qlit.h b/include/qobject/qlit.h
index c0676d5daf2..3b66c22013c 100644
--- a/include/qobject/qlit.h
+++ b/include/qobject/qlit.h
@@ -28,25 +28,37 @@ struct QLitObject {
         QLitDictEntry *qdict;
         QLitObject *qlist;
     } value;
+    bool hidden;
 };
 
 struct QLitDictEntry {
     const char *key;
     QLitObject value;
+    bool hidden;
 };
 
 #define QLIT_QNULL \
     { .type = QTYPE_QNULL }
 #define QLIT_QBOOL(val) \
     { .type = QTYPE_QBOOL, .value.qbool = (val) }
+#define QLIT_QBOOL_HIDDEN(val, cond) \
+    { .type = QTYPE_QBOOL, .value.qbool = (val), .hidden = (cond) }
 #define QLIT_QNUM(val) \
     { .type = QTYPE_QNUM, .value.qnum = (val) }
+#define QLIT_QNUM_HIDDEN(val, cond) \
+    { .type = QTYPE_QNUM, .value.qnum = (val), .hidden = (cond) }
 #define QLIT_QSTR(val) \
     { .type = QTYPE_QSTRING, .value.qstr = (val) }
+#define QLIT_QSTR_HIDDEN(val, cond) \
+    { .type = QTYPE_QSTRING, .value.qstr = (val), .hidden = (cond) }
 #define QLIT_QDICT(val) \
     { .type = QTYPE_QDICT, .value.qdict = (val) }
+#define QLIT_QDICT_HIDDEN(val, cond) \
+    { .type = QTYPE_QDICT, .value.qdict = (val), .hidden = (cond) }
 #define QLIT_QLIST(val) \
     { .type = QTYPE_QLIST, .value.qlist = (val) }
+#define QLIT_QLIST_HIDDEN(val, cond) \
+    { .type = QTYPE_QLIST, .value.qlist = (val), .hidden = (cond) }
 
 bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs);
 
diff --git a/qobject/qlit.c b/qobject/qlit.c
index a44f47eaa57..7b372c5ebaa 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -90,6 +90,8 @@ bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs)
 
 QObject *qobject_from_qlit(const QLitObject *qlit)
 {
+    g_assert(!qlit->hidden);
+
     switch (qlit->type) {
     case QTYPE_QNULL:
         return QOBJECT(qnull());
@@ -102,7 +104,9 @@ QObject *qobject_from_qlit(const QLitObject *qlit)
         QLitDictEntry *e;
 
         for (e = qlit->value.qdict; e->key; e++) {
-            qdict_put_obj(qdict, e->key, qobject_from_qlit(&e->value));
+            if (!e->hidden) {
+                qdict_put_obj(qdict, e->key, qobject_from_qlit(&e->value));
+            }
         }
         return QOBJECT(qdict);
     }
@@ -111,7 +115,9 @@ QObject *qobject_from_qlit(const QLitObject *qlit)
         QLitObject *e;
 
         for (e = qlit->value.qlist; e->type != QTYPE_NONE; e++) {
-            qlist_append_obj(qlist, qobject_from_qlit(e));
+            if (!e->hidden) {
+                qlist_append_obj(qlist, qobject_from_qlit(e));
+            }
         }
         return QOBJECT(qlist);
     }
-- 
2.47.2



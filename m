Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061DEC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCnyg-0000gv-S3; Wed, 07 May 2025 19:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyc-0000dp-AL
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:14:58 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnya-00079h-DN
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:14:58 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22e730c05ddso4224435ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746659695; x=1747264495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjuelvnUp/HIq2Hd0vs1lGHg7jiDZ3rbSTbY7lWyET0=;
 b=OctKyx66STKS0eLIAbWqeLxjBXg3BxiofjY0z9ptfjm8yJu+snI56JV9vwYEesRhur
 475q+BgW2GMZWdFUEk3qxpUFo+CVextbO9N/UR3vdKNLcAERsXzD+/gD9XmzQ4AHrgHK
 /Mo521ifAsJYDYk8cqTsUtOEIMjcelcue7H6TkRCqN4WTbEwXWTOpk1hZ0ZpGGqUn/wl
 Pq09Kq1h/lPhUtdNyjKKmUZizd73xqYAyS00avvT69eviiiiPiRDzaWSqAQs3smvxMDX
 ISieEcxvHfm8ml/KYVnni5SE9bP9hd0MJJEzPQcIZk5eoXgiQ/tofHYzPOQGtTlZktVw
 XUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746659695; x=1747264495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjuelvnUp/HIq2Hd0vs1lGHg7jiDZ3rbSTbY7lWyET0=;
 b=MPbttm8OgBxvev/0enSE0mST3JMeRXzqYFZzo74DhbM0s2idtGXBMLTubbFSB0wSfO
 WB2xgVbi7Vuc4lfWRnHOzESo+doN2hi+UtF/D4mj2wZxD5vLPeJNbc0N2yNjpD/sPtyZ
 IKTTu/jaMFza1P0Km5ImlDDdStt2oqBq7qYcgJDJMyKpVWryGnbFJizqzRPgUzjq93sH
 ZQA+KwK8+G/XeP+Xa34XyTHiwz1f0nUMrq1TLMDJrSmyxZajrPdMQT3LTavHazWZ9eJc
 Rx3Oa8BEkFqIZa/FRGvQQ0wPO03AMfaDyoGvowUwJpklQNkEfxhG+RQOYuLHd0BTYfs/
 g9bA==
X-Gm-Message-State: AOJu0Yyd7t3W+kfMZ19/yoTqfPd6qrqmANB4HSgr+ln08Q1y0U978MZZ
 JFWz4i+YJFJc0zSDdjRbr2Vj5+ALmRY1HDoG7VArSKktsoD0OK+gkU9LRor54MQyumkvInmX5/C
 P3u3ZKg==
X-Gm-Gg: ASbGncuZnY0CdefnyeTLq83n6hP5nq/cQGHbd3gO2wRNAIiJak0JqhB5H3lqMaqnE6B
 0oqPje14GyVGs76TTkTk0fOXtNdZ5YqXAlKiwJDrijBs5R4Yahn7jVJq+sbxwAqPaQmI+eEi62h
 ELJLPXBVi8foWVmpfGxly7Eg0hQC4vw0l6kRZ+uJqdqCN1CtSjTsx+GGv0KNHucRJc1O/53jItx
 3gSl8jNtmBZE0JU31fkx7fUYwX3TsA5MB5cw4YdpxRdWLCcE6umH+39RQIU0ofxBsGwJH2NJvxd
 9Y6B7PL4wM498spn6K8crZB4h0ogrCDAYnxhGIYl
X-Google-Smtp-Source: AGHT+IHHV4ZKHwtbbunbQgWgCHbPnlAj9frXqvzp3WTiimeKr0yxuoRjAnppV0SUUlPq62wmdGn/9Q==
X-Received: by 2002:a17:902:cccc:b0:21f:4649:fd49 with SMTP id
 d9443c01a7336-22e8e441fccmr13039685ad.49.1746659695044; 
 Wed, 07 May 2025 16:14:55 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e421a7dafsm40103205ad.69.2025.05.07.16.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:14:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, alex.bennee@linaro.org,
 stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 berrange@redhat.com, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 04/13] qapi/introspect: hide fields in schema
Date: Wed,  7 May 2025 16:14:34 -0700
Message-ID: <20250507231442.879619-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

We know have a way to parse runtime conditionals in QAPI json, and hide
qlit elements at runtime.
So we can combine both to hide elements in our schema based on a
conditional specified in json.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 scripts/qapi/introspect.py | 28 +++++++++++++++++++---------
 scripts/qapi/schema.py     |  3 +++
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index e0269bef0ce..c70b97a455d 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -94,7 +94,8 @@ class Annotated(Generic[_ValueT]):
 
 def _tree_to_qlit(obj: JSONValue,
                   level: int = 0,
-                  dict_value: bool = False) -> str:
+                  dict_value: bool = False,
+                  hidden_cond: str = '') -> str:
     """
     Convert the type tree into a QLIT C string, recursively.
 
@@ -120,7 +121,11 @@ def indent(level: int) -> str:
             ret += indent(level) + f"/* {obj.comment} */\n"
         if obj.ifcond.is_present():
             ret += obj.ifcond.gen_if()
-        ret += _tree_to_qlit(obj.value, level)
+        hidden_cond = obj.ifcond.get_runtime_cond()
+        # reverse runtime_if
+        if hidden_cond:
+            hidden_cond = '!(' + hidden_cond + ')'
+        ret += _tree_to_qlit(obj.value, level, hidden_cond=hidden_cond)
         if obj.ifcond.is_present():
             ret += '\n' + obj.ifcond.gen_endif()
         return ret
@@ -129,30 +134,35 @@ def indent(level: int) -> str:
     if not dict_value:
         ret += indent(level)
 
+    macro_suffix = ''
+    if hidden_cond:
+        macro_suffix = '_HIDDEN'
+        hidden_cond = ', (' + hidden_cond + ')'
+
     # Scalars:
     if obj is None:
         ret += 'QLIT_QNULL'
     elif isinstance(obj, str):
-        ret += f"QLIT_QSTR({to_c_string(obj)})"
+        ret += f"QLIT_QSTR{macro_suffix}({to_c_string(obj)}{hidden_cond})"
     elif isinstance(obj, bool):
-        ret += f"QLIT_QBOOL({str(obj).lower()})"
+        ret += f"QLIT_QBOOL{macro_suffix}({str(obj).lower()}{hidden_cond})"
 
     # Non-scalars:
     elif isinstance(obj, list):
-        ret += 'QLIT_QLIST(((QLitObject[]) {\n'
+        ret += 'QLIT_QLIST' + macro_suffix + '(((QLitObject[]) {\n'
         for value in obj:
             ret += _tree_to_qlit(value, level + 1).strip('\n') + '\n'
         ret += indent(level + 1) + '{}\n'
-        ret += indent(level) + '}))'
+        ret += indent(level) + '})' + hidden_cond + ')'
     elif isinstance(obj, dict):
-        ret += 'QLIT_QDICT(((QLitDictEntry[]) {\n'
+        ret += 'QLIT_QDICT' + macro_suffix + '(((QLitDictEntry[]) {\n'
         for key, value in sorted(obj.items()):
             ret += indent(level + 1) + "{{ {:s}, {:s} }},\n".format(
                 to_c_string(key),
-                _tree_to_qlit(value, level + 1, dict_value=True)
+                _tree_to_qlit(value, level + 1, dict_value=True),
             )
         ret += indent(level + 1) + '{}\n'
-        ret += indent(level) + '}))'
+        ret += indent(level) + '})' + hidden_cond + ')'
     else:
         raise NotImplementedError(
             f"type '{type(obj).__name__}' not implemented"
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 533d0dfe088..7767893f979 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -79,6 +79,9 @@ def gen_runtime_if(self) -> str:
     def gen_runtime_endif(self) -> str:
         return gen_runtime_endif(self._cgen_runtime())
 
+    def get_runtime_cond(self) -> str:
+        return self._cgen_runtime()
+
     def is_present(self) -> bool:
         return bool(self.ifcond) or bool(self.runtime_ifcond)
 
-- 
2.47.2



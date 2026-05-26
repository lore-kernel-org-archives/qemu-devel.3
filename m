Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A986CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw1P-00025y-Ff; Tue, 26 May 2026 13:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1O-00025e-Aq
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1M-0007zD-HU
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5xgvznU+zEK4LsBHFLUJzRFiM54fPC5CxNWDMaKguw=;
 b=BeHmr/wZYjDuY4tLSk9WXuIsCtew99w4/XTaqgVlF+CNxMZWHlV0MbXujuVeyrtv6MLyq4
 tSNAfzW3Orzw+sZZr1ryJw7Tz2cqCz2/ULd0HIMMBxpKD2my/Hx1vnYd12bVJ5i8NWpfwn
 2iA9XTQlB5PCuZmjM5198ZukRNVZuak=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-RGBrBxHLO3mEf705Eq4kzg-1; Tue, 26 May 2026 13:56:48 -0400
X-MC-Unique: RGBrBxHLO3mEf705Eq4kzg-1
X-Mimecast-MFC-AGG-ID: RGBrBxHLO3mEf705Eq4kzg_1779818207
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49047e9ca88so35851955e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818207; x=1780423007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A5xgvznU+zEK4LsBHFLUJzRFiM54fPC5CxNWDMaKguw=;
 b=lCgdnFc4KhlyHkdcMwwISKQYUNhiQkKT/wMLMKnYcAI9WFZUhZJzREFt+0OdcKSSLf
 AhLuLAJgQ3bFCec6HqO70+XRTkWO0c3/R/5sK+4zcucVlUbqIvyDqTyMur5ti1KVlDUH
 p0ScRuFIlBJMzSCzPr6L29pHshJ0P+hisDVdZ6XYwMKgOo/mddt8W/YcSK2w6Qv0MaJt
 ldZzMaipADR0CejN/1hDp+BQNKYPt0nbwanBPxw3C/zcd1WCzbr+1FpSVqKlc3y9ep8/
 dKet/9AM/zQf8LnVAXQbvGvFl4L8WaHm1K2pz7YDmXDNXjGIhLBpmMW+RTRkfU2N8RMM
 9XqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818207; x=1780423007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A5xgvznU+zEK4LsBHFLUJzRFiM54fPC5CxNWDMaKguw=;
 b=aZMZkmw+5dgPfyRNNZpQ0rDDeOxxGTdVahluv99uOYnE5tvmlV8DvFWZ9A6QqWGfV2
 DO3h3Xop+M7DLiFHsoPrZLNO/y/BTWQKdTv5l+gWSHxbXSYVDkbkXjQvW/NpsUbpFH5a
 cRbqckH1HaaC7luzdsfw4NHb/LMcSvXjuRllnrZ0HflIrYYBmYz/LRgas1CKTvqHQXk6
 nAJXkwsP5T4mMaTJ7NVRLv/+OlAWnRjjL+80gH0mB7v3rzdfWsGFogo+/IjGp1STs76m
 WwCSRQbVT6gtS+SmFu1SKH1VFOMeWt+7CGKFYY0vkbVt3ndXL0/dx89KB2FFCUDHLtWO
 pkzw==
X-Gm-Message-State: AOJu0YyzqA/EH3JNxId1I8FpmofdbopuvV/sTxuP7l+qIZDHyFSaottB
 +ADLSNeDbpwep8V7bM21349aqLoW45gy0kVp4ICysYvEcPPf2Pgh9GL8siMxP0zbqM7IzxPz4Cf
 EIz9MreAMnTgXqzXU8hS3+Lw5uhZYM2TRtkCJIQDH+1kuNMk3lp4XXrMtoMM/jKWWo4IKwZTsYm
 DWQ2u5hsKUUhMmWZdkForrIbgXjbDNKt8vYBcAkqa4
X-Gm-Gg: Acq92OGswQme8J0sy2WeDZopa8n+i8ZIjqQzDSh/tq8O00TRqaYfwinldJtYOftE4+e
 aWlxoMj0rSpQwrtbgwostuLGBWxLkPAYnE9lAuBQEn904swr7EitSDJUo+Y7sL35OC32PD+Yjtg
 EhUM3ELnVSqmqnWse/Ei/C3R0kMo44Gv/T38Y/HO3WEznLWmd3iOdJ7JOpLHNI1NSLKEfOydqVA
 5N+zlaQKezqNmnqYNxZwxIWY0QIKk4ityqHguhgyXzxZ9xXEhMWK1s9DvzbMWyHGwfdBbchBO9z
 7GlMqSFTqmhWPaKDsP6Rj40kn9+Fuxq+DG8luwKFolUWznVu+dj0Qa8zHTA6CyNmTruIU9c3kdl
 aNRgowpp0FzwQbCGi39zzitDcuUzk403WQ3G2xhbB0iOG+c5o3Yk/TFu53ERr8PfTpynDucFDLx
 rPxJIC/kfW7IMuaV84oPgWcYFQm+d9mhcM0OTD/Q==
X-Received: by 2002:a05:600c:4f82:b0:490:48e2:5618 with SMTP id
 5b1f17b1804b1-49048e257admr293040855e9.22.1779818207046; 
 Tue, 26 May 2026 10:56:47 -0700 (PDT)
X-Received: by 2002:a05:600c:4f82:b0:490:48e2:5618 with SMTP id
 5b1f17b1804b1-49048e257admr293040395e9.22.1779818206576; 
 Tue, 26 May 2026 10:56:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm509045595e9.7.2026.05.26.10.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:56:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH v3 10/19] scripts/qapi: enum with conditional first item must
 be optional
Date: Tue, 26 May 2026 19:56:09 +0200
Message-ID: <20260526175618.227743-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526175618.227743-1-pbonzini@redhat.com>
References: <20260526175618.227743-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Prevent an all-zero struct from having different meanings with
different configurations or builds of QEMU.

This needs some changes to doc-good.json, which used unwittingly
such an enum.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/schema.py                        |  8 ++++++++
 tests/qapi-schema/doc-good.json               | 16 ++++++++--------
 tests/qapi-schema/doc-good.out                | 12 ++++++------
 tests/qapi-schema/doc-good.txt                |  8 ++++----
 tests/qapi-schema/enum-if-first-required.err  |  2 ++
 tests/qapi-schema/enum-if-first-required.json |  6 ++++++
 tests/qapi-schema/enum-if-first-required.out  |  0
 tests/qapi-schema/meson.build                 |  1 +
 8 files changed, 35 insertions(+), 18 deletions(-)
 create mode 100644 tests/qapi-schema/enum-if-first-required.err
 create mode 100644 tests/qapi-schema/enum-if-first-required.json
 create mode 100644 tests/qapi-schema/enum-if-first-required.out

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 78c2a25fc9a..a5a11298817 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -967,6 +967,14 @@ def check(self, schema: QAPISchema) -> None:
         assert self.defined_in
         self.type = schema.resolve_type(self._type_name, self.info,
                                         self.describe)
+        if (not self.optional
+                and isinstance(self.type, QAPISchemaEnumType)
+                and self.type.members[0].ifcond.is_present()):
+            raise QAPISemError(
+                self.info,
+                "enum type '%s' of %s has a conditional first value"
+                " and must be optional"
+                % (self.type.name, self.describe(self.info)))
         seen: Dict[str, QAPISchemaMember] = {}
         for f in self.features:
             f.check_clash(self.info, seen)
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index fac13425b72..76521ffe9e6 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -73,12 +73,12 @@
 # @enum-feat: Also _one_ {and only}
 # @enum-member-feat: a member feature
 #
-# @two is undocumented
+# @zero is undocumented
 ##
 { 'enum': 'Enum',
-  'data': [ { 'name': 'one', 'if': 'IFONE',
-              'features': [ 'enum-member-feat' ] },
-            'two' ],
+  'data': [ 'zero',
+            { 'name': 'one', 'if': 'IFONE',
+               'features': [ 'enum-member-feat' ] } ],
   'features': [ 'enum-feat' ],
   'if': 'IFCOND' }
 
@@ -112,10 +112,10 @@
                       'if': 'IFSTR' } } }
 
 ##
-# @Variant2:
+# @Variant0:
 #
 ##
-{ 'struct': 'Variant2', 'data': {} }
+{ 'struct': 'Variant0', 'data': {} }
 
 ##
 # @Object:
@@ -128,8 +128,8 @@
   'base': 'Base',
   'discriminator': 'base1',
   'data': { 'one': 'Variant1',
-            'two': { 'type': 'Variant2',
-                     'if': { 'any': ['IFONE', 'IFTWO'] } } } }
+            'zero': { 'type': 'Variant0',
+                      'if': { 'any': ['IFONE', 'IFTWO'] } } } }
 
 ##
 # @Alternate:
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 04a55072646..bf589061cbc 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -10,10 +10,10 @@ enum QType
     member qbool
 module doc-good.json
 enum Enum
+    member zero
     member one
         if IFONE
         feature enum-member-feat
-    member two
     if IFCOND
     feature enum-feat
 object Base
@@ -24,12 +24,12 @@ object Variant1
         if IFSTR
         feature member-feat
     feature variant1-feat
-object Variant2
+object Variant0
 object Object
     base Base
     tag base1
     case one: Variant1
-    case two: Variant2
+    case zero: Variant0
         if {'any': ['IFONE', 'IFTWO']}
     feature union-feat1
 alternate Alternate
@@ -110,14 +110,14 @@ doc symbol=Enum
 
     arg=one
 The _one_ {and only}, description on the same line
-    arg=two
+    arg=zero
 
     feature=enum-feat
 Also _one_ {and only}
     feature=enum-member-feat
 a member feature
     section=Plain
-@two is undocumented
+@zero is undocumented
 doc symbol=Base
     body=
 
@@ -137,7 +137,7 @@ Another paragraph
 a feature
     feature=member-feat
 a member feature
-doc symbol=Variant2
+doc symbol=Variant0
     body=
 
 doc symbol=Object
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index 74b73681d32..922a61dcf23 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -43,14 +43,14 @@ Enum Enum
    Values:
       * **one** -- The _one_ {and only}, description on the same line
 
-      * **two** -- Not documented
+      * **zero** -- Not documented
 
    Features:
       * **enum-feat** -- Also _one_ {and only}
 
       * **enum-member-feat** -- a member feature
 
-   "two" is undocumented
+   "zero" is undocumented
 
 Object Base
     *Availability*: "IFALL1 and IFALL2"
@@ -75,7 +75,7 @@ Object Variant1
 
       * **member-feat** -- a member feature
 
-Object Variant2
+Object Variant0
 
 Object Object
 
@@ -84,7 +84,7 @@ Object Object
 
       * When "base1" is "one": The members of "Variant1".
 
-      * When "base1" is "two": The members of "Variant2".
+      * When "base1" is "zero": The members of "Variant0".
 
    Features:
       * **union-feat1** -- a feature
diff --git a/tests/qapi-schema/enum-if-first-required.err b/tests/qapi-schema/enum-if-first-required.err
new file mode 100644
index 00000000000..6d8bdcf2507
--- /dev/null
+++ b/tests/qapi-schema/enum-if-first-required.err
@@ -0,0 +1,2 @@
+enum-if-first-required.json: In struct 'TestStruct':
+enum-if-first-required.json:5: enum type 'TestEnum' of member 'field' has a conditional first value and must be optional
diff --git a/tests/qapi-schema/enum-if-first-required.json b/tests/qapi-schema/enum-if-first-required.json
new file mode 100644
index 00000000000..1769b5fdef9
--- /dev/null
+++ b/tests/qapi-schema/enum-if-first-required.json
@@ -0,0 +1,6 @@
+# Enum with conditional first value cannot be used in required fields
+{ 'enum': 'TestEnum',
+  'data': [ { 'name': 'member1', 'if': 'CONFIG_FOO' },
+            'member2' ] }
+{ 'struct': 'TestStruct',
+  'data': { 'field': 'TestEnum' } }
diff --git a/tests/qapi-schema/enum-if-first-required.out b/tests/qapi-schema/enum-if-first-required.out
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index debff633ac1..3b0c16a8b67 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -97,6 +97,7 @@ schemas = [
   'enum-bad-prefix.json',
   'enum-clash-member.json',
   'enum-dict-member-unknown.json',
+  'enum-if-first-required.json',
   'enum-if-invalid.json',
   'enum-int-member.json',
   'enum-member-case.json',
-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D127C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFWN-0002YJ-8v; Fri, 24 Jul 2026 09:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wnFWL-0002RU-CL
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wnFWH-0002cd-NA
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784898051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xX7A7nyNxFP073ud26/uwemwUIjt9lbN+6fG2uf9t7U=;
 b=dK1u0qTlg/b0GUxczaRmZvgmaVyMX7T3xsJ5wc+aCwS49h1tWIkcnyrm2x3u7hJKtb29/q
 CA6EKxayh3cBPhYJEIBv78ru5KcNbPrMGTzYe3e7vz+Rts2HgCX3r/XJX2Be37uqoK9oex
 EkNVcpHYhuoink0fdFYoAe912bmyvos=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-F-yzVrzxMeSPyBSFiR2vrw-1; Fri, 24 Jul 2026 09:00:50 -0400
X-MC-Unique: F-yzVrzxMeSPyBSFiR2vrw-1
X-Mimecast-MFC-AGG-ID: F-yzVrzxMeSPyBSFiR2vrw_1784898049
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-474170b59dfso351031f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784898049; x=1785502849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xX7A7nyNxFP073ud26/uwemwUIjt9lbN+6fG2uf9t7U=;
 b=E9/7tRHuO1n9cD11U794SOnkhnccRFzMwTpkeYVTleEFpN+eDn0g2TkeNrmWtFBfLS
 /nHCm6VGZsrLmIKd8utVK60LMyLWwXz2PF3DfaDFfJ6iicBtsEtKEn34+LmXEMBcPGJK
 Wy9vYGDcwoijeaQR8mHxF11PWfcO5+iLAV7KPFYz4AchLAOoBIS3EQuyWMFkJ8LWIezS
 OCbf2HJNv8gqToZUNAgnbKvRz66fN4Yqw44ksrpott2qintHTtHQjdi3Wv8xl7vIojvs
 nui+L36ryeeaPoreg5SIVlybVjQYtnnJFBcTzXFfVEj/P4dFHlrtMcVteHxj/8S6UJjm
 pmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784898049; x=1785502849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xX7A7nyNxFP073ud26/uwemwUIjt9lbN+6fG2uf9t7U=;
 b=LBnhu1w2x9FV0bo3mYeJ0V05n/x1dbojFu9vlGoqyp7BI14mOp1drbqtQ1MmCcettb
 jvZ6PW6Dlx/MAxPzmsCsCzjsv8Trca6YrmnWxEOnGDpeznv8KVoBC5+P0DAWtrMlCmDU
 mDr6STvgzKW52UwI37dVILzP/J3YvsOGcseXCEut+09YjOr0fny8KVKq1AUygIwINnZJ
 at/LCoOSl2prByjvus5cDk57P4VK6gogAx/SA/0llj3KRDNuteVaPfgkvrwCPdNvWjqW
 PHM22hYtyViIGZNyv3LsZ3tHWtNakMWvJrMsHeaCrBDqmd0LD91aQ28QDtboRJo+yP1B
 gwrg==
X-Gm-Message-State: AOJu0Yz6mia8geDMp/RhxPrVhZ3E7ISUe2UHzBg0WdUg0cjT1w6SDQ/h
 +qzcgzyKc9B/6WYHEyBTQoCb4i23W1A5li9u6KFWdaEUj5WNVjHe+DqAuav/VXRTEXydJXf+nw1
 5NKlntuxaoEFQpyh1nkWVlTbxNmCgjHAcaoCR7U0X09EQDJl+CEL3zM6oqFMlZrNDKnz9mRcGhg
 dRb5Z5e/Ev62yKrZmDhA/u1EkqxfL9iccJwN+hVtIJ
X-Gm-Gg: AR+sD13vPz095jRPd/IlwwUCoKcLZiU7cobxKhPRzUklWilZYbijnnyKfKJwm1XDaEp
 BKELPodggt6KkllCJLLVjpqgv9hLwPycknZb7C2Q0SUVsJYkdhS7pG3REE33O/Rvpl5/xzGZraX
 nYtz8BUjQXJlx6SY/qDcm4ZWANE7jFR33YSlHtQeZsS24lD0tpaJKeNiyKWC/8pMfglMqYup6Ie
 dNCSqf3hgwCAL1JO71st6irJ6HYfAn+QLS+hLQGGIb+x9xO/xgzlqAlWCj/wUzvyXVmJS2MI4Wv
 5N73QdgmiQea8GOrYgQ7R6rrlnyTq/1gU4n9Ta6u5owWdsiCJ1wVvx2rmvKOAWsyjNEKVrGSetJ
 45IbbJFWZ/vWaK0ar/IZRn7rAnZExxxjq5VEDODie/XNW2l9C0+rfnuSqJ3kNpSgCZgYpTQSLxg
 s0NlKA
X-Received: by 2002:a05:6000:983:b0:47f:89cd:b48 with SMTP id
 ffacd0b85a97d-47f8d76de31mr9288738f8f.5.1784898048698; 
 Fri, 24 Jul 2026 06:00:48 -0700 (PDT)
X-Received: by 2002:a05:6000:983:b0:47f:89cd:b48 with SMTP id
 ffacd0b85a97d-47f8d76de31mr9288664f8f.5.1784898048136; 
 Fri, 24 Jul 2026 06:00:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c67339sm25550692f8f.31.2026.07.24.06.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:00:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 1/3] scripts/qapi: enum with conditional first item must be
 optional
Date: Fri, 24 Jul 2026 15:00:41 +0200
Message-ID: <20260724130044.1369843-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724130044.1369843-1-pbonzini@redhat.com>
References: <20260724130044.1369843-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
index 8d88b40de2e..71296b15de2 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -963,6 +963,14 @@ def check(self, schema: QAPISchema) -> None:
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
index 371dd25ffc7..2782f6b57d9 100644
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
 
     Member=one
 The _one_ {and only}, description on the same line
-    Member=two
+    Member=zero
 
     Feature=enum-feat
 Also _one_ {and only}
     Feature=enum-member-feat
 a member feature
     Plain
-@two is undocumented
+@zero is undocumented
 doc symbol=Base
     Intro
 
@@ -139,7 +139,7 @@ Another paragraph
 a feature
     Feature=member-feat
 a member feature
-doc symbol=Variant2
+doc symbol=Variant0
     Intro
 
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
2.55.0



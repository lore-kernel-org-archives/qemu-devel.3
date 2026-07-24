Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AACC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnDGw-000338-2p; Fri, 24 Jul 2026 06:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wnDGt-00032x-Jt
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 06:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wnDGq-0004b4-Li
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 06:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784889407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6LEVqaYz5Nr7Gc+nFv1HNSD9Y4E2vrGm/B1mVS87XeU=;
 b=VpMRL02tcZOundkeeaqk4ku2Q0WkMYPY/dURjqPupCM27ZqnHU0O3ywF80Quq/rs21FlZ7
 mzGdZ20Kck3TECnPYU1AHda3LPTA2u20MUa3LNgw00XtrgCw64cZuW45Ti3HzfwQw97EkJ
 RjGeZ//HDgXXBH2+2QZw7NiyT7IwyqA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-nzIfwUxaORiqUJAp1iPy3g-1; Fri, 24 Jul 2026 06:36:45 -0400
X-MC-Unique: nzIfwUxaORiqUJAp1iPy3g-1
X-Mimecast-MFC-AGG-ID: nzIfwUxaORiqUJAp1iPy3g_1784889405
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-495517d39fbso2124965e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 03:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784889404; x=1785494204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6LEVqaYz5Nr7Gc+nFv1HNSD9Y4E2vrGm/B1mVS87XeU=;
 b=jVHJOprGTd/QH3fs1/u/52MG6zRhvVEE79NTRCNXaz2V+9DjpFWuXp50mzAS/oxfjm
 oJyDh/yowaianwcLIic88CtnrF3HOwncxJ6pspHmx8b8t7kNLThM/eXB+mhGyCyJTxGr
 VUlg4QRDjaUNFLkP/qaWGFfC02XJcKx+XEGAPhsF4D4vSyeysrRemxE4teFtzNYsmPcU
 lHFtyXndGmIV52PabnToUgPXMR3iJmke8hNMZFq6HFJaO8DovXvEdv0IW8X9i9/0E2FH
 VoY1zrcYFi5Zt67dZl6wlikoqKsp8cvDiSCRoG5lQ0kzvjbrl3BJgo+9IZ7jYJk/QUjm
 SbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784889404; x=1785494204;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6LEVqaYz5Nr7Gc+nFv1HNSD9Y4E2vrGm/B1mVS87XeU=;
 b=q78bkkgGaKLRZXM8odXwNUoJSeb17GTud2aeHWUVFghJh0vuqqpbWg2MF29bfUJYce
 wT/wuWOwbzMc5BSygw9RKRS8D+TEacF11R8RSPSDrmfCf84KKeYkuNio5VyrOm6nkKtY
 +BAKw4+GiTKP6HNNEgqSzwSwSeNDEdKJz00qmJjqkTS4gUnOtB1+RJukuM599X02KR9T
 ekKGGwxC422O0kfMjyArKsWnLaE7qo1rCLwLzn3fzMRMRKa8FtgaQgHRCERu9ZOkedj+
 F5KYvHrP8MYdj3Sv1tOY9AbGmXs3uDH6f0vekSQFFRPaEcnUjjjmr+ttGacuCPkOXXUb
 ErYw==
X-Gm-Message-State: AOJu0YyFGL4P7TCs5Q21RLOhG6CSSFKFC7NC6nxENNP+e0JPC1XPP0Kr
 vy5MvYGZRv0rHbCVceT7BY5GGsnJFylxubg9GWHHABYxt2h8IVMkJPY3XBfmNvaDrlf2ulTm4dR
 ArAr+Ac6eM4jz4OmYsTzX+RF3GqDXiQbFQ6mo8Cqir+CnSPo0NYgFuIF3SxPZgmjcaZAHJ2THPV
 SQvVorsMAbMAklqgrVpEqArokRLdBbj/gnGEIv08Xz
X-Gm-Gg: AR+sD11y0w3m3uFntklU49Qh167JbI6UdtVfCchSQGgKS4RQLevL+x4+Gp2SbcOzeoO
 v0i4vFJ2WF0JMf6ACI+a7JFqrRchnkgCX5CiYDPznNyfcLaXIFuGofT9AFd3Lhz1a7q071cA/D3
 SRO2ksAUXNlODBJcKnfo4NA6oGDUXQnFQITcTL6l74ZM6Q4/9bF7DLzoVVTcgB9E6qAXtuU8PDI
 IRZNYOo3tqNgBQIguYLHZEFBA9gr/4DzMFq6j/ihERYYxWfUsImSYx/0H1+yZi6XMph8ArjExGR
 Sk+GEufpjW1SJyJ8r5x3Qd6L2cfcBuX/WB8T6wqKhSV2V20f5AWvTSLQlGny+pEHxuPnFzMWFDk
 ckmKB0IYjqX5tJXMbj3Igz8yuWtG8vLYpcDl4TgIYV1Ei7qyJgn9GN9fGg9Y2caimECDCerZPMS
 lbkhae
X-Received: by 2002:a05:600c:4f87:b0:493:f176:dc69 with SMTP id
 5b1f17b1804b1-49573d25ec8mr81844345e9.37.1784889404380; 
 Fri, 24 Jul 2026 03:36:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4f87:b0:493:f176:dc69 with SMTP id
 5b1f17b1804b1-49573d25ec8mr81843705e9.37.1784889403578; 
 Fri, 24 Jul 2026 03:36:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af6a14csm57801775e9.5.2026.07.24.03.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:36:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 0/3] scripts/qapi: non-Rust-specific preparatory patches
Date: Fri, 24 Jul 2026 12:36:39 +0200
Message-ID: <20260724103639.1339912-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series include a few small QAPI patches extracted out of the Rust
series.

The first two tighten the language in ways that are necessary for Rust (the
structs would not be representable) but probably a good idea in general.

The last one moves C-specific knowledge out of functions with a generic
name.

Paolo

Paolo Bonzini (3):
  scripts/qapi: enum with conditional first item must be optional
  scripts/qapi: reject empty enums
  scripts/qapi: pull c_name and lstrip from camel_to_upper to caller

 scripts/qapi/common.py                        |  4 ++--
 scripts/qapi/schema.py                        | 12 ++++++++++++
 tests/qapi-schema/doc-good.json               | 16 ++++++++--------
 tests/qapi-schema/doc-good.out                | 12 ++++++------
 tests/qapi-schema/doc-good.txt                |  8 ++++----
 tests/qapi-schema/enum-empty.err              |  2 ++
 tests/qapi-schema/enum-empty.json             |  2 ++
 tests/qapi-schema/enum-empty.out              |  0
 tests/qapi-schema/enum-if-first-required.err  |  2 ++
 tests/qapi-schema/enum-if-first-required.json |  6 ++++++
 tests/qapi-schema/enum-if-first-required.out  |  0
 tests/qapi-schema/meson.build                 |  2 ++
 tests/qapi-schema/qapi-schema-test.json       |  3 ---
 tests/qapi-schema/qapi-schema-test.out        |  1 -
 tests/qapi-schema/union-empty-if.err          |  2 ++
 tests/qapi-schema/union-empty-if.json         |  6 ++++++
 tests/qapi-schema/union-empty-if.out          |  0
 tests/qapi-schema/union-empty.err             |  4 ++--
 18 files changed, 56 insertions(+), 26 deletions(-)
 create mode 100644 tests/qapi-schema/enum-empty.err
 create mode 100644 tests/qapi-schema/enum-empty.json
 create mode 100644 tests/qapi-schema/enum-empty.out
 create mode 100644 tests/qapi-schema/enum-if-first-required.err
 create mode 100644 tests/qapi-schema/enum-if-first-required.json
 create mode 100644 tests/qapi-schema/enum-if-first-required.out
 create mode 100644 tests/qapi-schema/union-empty-if.err
 create mode 100644 tests/qapi-schema/union-empty-if.json
 create mode 100644 tests/qapi-schema/union-empty-if.out

-- 
2.55.0

From a2b41f1f5bf5735359ff256244e04ff09fd9a072 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 3 Mar 2026 14:30:12 +0100
Subject: [PATCH 1/3] scripts/qapi: enum with conditional first item must be
 optional

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


From b0a1a5a95ecbe66bd42a61bb3196b151c9764faf Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 3 Mar 2026 14:38:00 +0100
Subject: [PATCH 2/3] scripts/qapi: reject empty enums

Raise an error if an enum has no members.  Such enums cannot be populated
with a valid value, and therefore they can only be used as optional
members.  But QAPI leaves out optional members from the serialization
protocol, and therefore the existence of the enum is completely pointless.

The same limitation is not extended to an enum whose members are all
compiled out; these can still be useful as optional members.  However they
cannot implicitly block usage of parent structures because, by virtue
of having only conditional members, they are "enums with conditional
first item" and must therefore be optional.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/schema.py                  | 4 ++++
 tests/qapi-schema/enum-empty.err        | 2 ++
 tests/qapi-schema/enum-empty.json       | 2 ++
 tests/qapi-schema/enum-empty.out        | 0
 tests/qapi-schema/meson.build           | 1 +
 tests/qapi-schema/qapi-schema-test.json | 3 ---
 tests/qapi-schema/qapi-schema-test.out  | 1 -
 tests/qapi-schema/union-empty-if.err    | 2 ++
 tests/qapi-schema/union-empty-if.json   | 6 ++++++
 tests/qapi-schema/union-empty-if.out    | 0
 tests/qapi-schema/union-empty.err       | 4 ++--
 11 files changed, 19 insertions(+), 6 deletions(-)
 create mode 100644 tests/qapi-schema/enum-empty.err
 create mode 100644 tests/qapi-schema/enum-empty.json
 create mode 100644 tests/qapi-schema/enum-empty.out
 create mode 100644 tests/qapi-schema/union-empty-if.err
 create mode 100644 tests/qapi-schema/union-empty-if.json
 create mode 100644 tests/qapi-schema/union-empty-if.out

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 71296b15de2..a5a11298817 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -428,6 +428,10 @@ def __init__(
 
     def check(self, schema: QAPISchema) -> None:
         super().check(schema)
+        if not self.members:
+            raise QAPISemError(
+                self.info,
+                "enum '%s' must have at least one value" % self.name)
         seen: Dict[str, QAPISchemaMember] = {}
         for m in self.members:
             m.check_clash(self.info, seen)
diff --git a/tests/qapi-schema/enum-empty.err b/tests/qapi-schema/enum-empty.err
new file mode 100644
index 00000000000..6070bf62cbd
--- /dev/null
+++ b/tests/qapi-schema/enum-empty.err
@@ -0,0 +1,2 @@
+enum-empty.json: In enum 'TestEmpty':
+enum-empty.json:2: enum 'TestEmpty' must have at least one value
diff --git a/tests/qapi-schema/enum-empty.json b/tests/qapi-schema/enum-empty.json
new file mode 100644
index 00000000000..3b3dfb2e3d8
--- /dev/null
+++ b/tests/qapi-schema/enum-empty.json
@@ -0,0 +1,2 @@
+# An enum must have at least one value
+{ 'enum': 'TestEmpty', 'data': [] }
diff --git a/tests/qapi-schema/enum-empty.out b/tests/qapi-schema/enum-empty.out
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index 3b0c16a8b67..1058b7ecfae 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -196,6 +196,7 @@ schemas = [
   'union-clash-member.json',
   'union-discriminator-bad-name.json',
   'union-empty.json',
+  'union-empty-if.json',
   'union-inline-invalid-dict.json',
   'union-int-branch.json',
   'union-invalid-base.json',
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 8ca977c49d2..195f1c4847b 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -23,9 +23,6 @@
   'data': { 'enum1': 'EnumOne',   # Intentional forward reference
             '*enum2': 'EnumOne', 'enum3': 'EnumOne', '*enum4': 'EnumOne' } }
 
-# An empty enum, although unusual, is currently acceptable
-{ 'enum': 'MyEnum', 'data': [ ] }
-
 # Likewise for an empty struct, including an empty base
 { 'struct': 'Empty1', 'data': { } }
 { 'struct': 'Empty2', 'base': 'Empty1', 'data': { } }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 4617eb4e98a..ddd8bf80d66 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -18,7 +18,6 @@ object NestedEnumsOne
     member enum2: EnumOne optional=True
     member enum3: EnumOne optional=False
     member enum4: EnumOne optional=True
-enum MyEnum
 object Empty1
 object Empty2
     base Empty1
diff --git a/tests/qapi-schema/union-empty-if.err b/tests/qapi-schema/union-empty-if.err
new file mode 100644
index 00000000000..2b8691ab2f5
--- /dev/null
+++ b/tests/qapi-schema/union-empty-if.err
@@ -0,0 +1,2 @@
+union-empty-if.json: In struct 'Base':
+union-empty-if.json:5: enum type 'Empty' of member 'type' has a conditional first value and must be optional
diff --git a/tests/qapi-schema/union-empty-if.json b/tests/qapi-schema/union-empty-if.json
new file mode 100644
index 00000000000..36625dc4a89
--- /dev/null
+++ b/tests/qapi-schema/union-empty-if.json
@@ -0,0 +1,6 @@
+# union discriminator enum cannot have only conditional items
+{ 'enum': 'Empty',
+  'data': [ { 'name' : 'bar', 'if': { 'all': ['FOO'] } } ] }
+
+{ 'struct': 'Base', 'data': { 'type': 'Empty' } }
+{ 'union': 'Union', 'base': 'Base', 'discriminator': 'type', 'data': { } }
diff --git a/tests/qapi-schema/union-empty-if.out b/tests/qapi-schema/union-empty-if.out
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/tests/qapi-schema/union-empty.err b/tests/qapi-schema/union-empty.err
index d4284399621..c07dcf32a5a 100644
--- a/tests/qapi-schema/union-empty.err
+++ b/tests/qapi-schema/union-empty.err
@@ -1,2 +1,2 @@
-union-empty.json: In union 'Union':
-union-empty.json:4: union has no branches
+union-empty.json: In enum 'Empty':
+union-empty.json:2: enum 'Empty' must have at least one value
-- 
2.55.0


From 0a3095a0e4f7f994d2a6f8e40f98d4355b666154 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 8 Jan 2026 11:22:46 +0100
Subject: [PATCH 3/3] scripts/qapi: pull c_name and lstrip from camel_to_upper
 to caller

Allow using camel_to_upper for other languages too.

In particular, the lstrip() is needed to avoid reserved C identifiers,
for example:

    typedef enum __org_qemu_x_Enum {
        __ORG_QEMU_X_ENUM___ORG_QEMU_X_VALUE,
        __ORG_QEMU_X_ENUM__MAX,
    } __org_qemu_x_Enum;

Insulate Rust from this, since underscores have a different meaning
in Rust (though only for the sake of warnings).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/common.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d7c8aa3365c..43a0be5f97f 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -61,7 +61,7 @@ def camel_to_upper(value: str) -> str:
         ret += ch
         upc = ch.isupper()
 
-    return c_name(ret.upper()).lstrip('_')
+    return ret.upper()
 
 
 def c_enum_const(type_name: str,
@@ -75,7 +75,7 @@ def c_enum_const(type_name: str,
     :param prefix: Optional, prefix that overrides the type_name.
     """
     if prefix is None:
-        prefix = camel_to_upper(type_name)
+        prefix = c_name(camel_to_upper(type_name)).lstrip('_')
     return prefix + '_' + c_name(const_name, False).upper()
 
 
-- 
2.55.0



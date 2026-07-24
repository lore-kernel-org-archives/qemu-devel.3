Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CBEC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFWO-0002a0-18; Fri, 24 Jul 2026 09:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wnFWL-0002SP-HJ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wnFWJ-0002gG-Ck
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784898054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Am04rAViHBWH56STMMt95NmhR4rS6t7b5I/fYOQuq1I=;
 b=NKghtqI8PyM1Yo8TRZ9YZ0XKjGfbc8lctLyczTlbfD/uaZ9qijW4PICMvWEmyE64HkdCip
 whpI7zy5sU5f9gVs9J5s1mIjnGaD624nEpujn28S7NgkupMkTrmwQvQPqFsL0pe/xIq+sx
 yPjeH97KBMPtbiQLU7n0gYhSNrzFFrY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-4m6AP_2NOG25_DfFxg0Mvw-1; Fri, 24 Jul 2026 09:00:53 -0400
X-MC-Unique: 4m6AP_2NOG25_DfFxg0Mvw-1
X-Mimecast-MFC-AGG-ID: 4m6AP_2NOG25_DfFxg0Mvw_1784898052
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49571407d1dso3445095e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784898052; x=1785502852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Am04rAViHBWH56STMMt95NmhR4rS6t7b5I/fYOQuq1I=;
 b=gzb3yP9DoIG+rpUxRbQvDRHyIFXgS9VmPlpAWXOLgW6VMMcgRO0OFS8VaoZKF19Ixb
 cho0ZAI1xjFZNo5261vE3xAlD3gptHGtmnUJTmgj69alMUH4oogz5cyoGYNGDF1p34dF
 dWplO1fzUbEnx0X0rGYg3BCVwcnioCJh0fin+aUCMDVctQN28foy9KZZypuGWmm0o1Zi
 o7B3e7QIPF8mVGColvSzaX8xq1fmjK27kKELf9FmqzN/e4UEAc/ZOA8fHfzAcBNV2ouj
 x9z5VvX7OaZq2gPTTbcm6GHh56wH5KuB65FviVkCuJS8DQ2PKbVljth34YaLkfWzn6NZ
 9bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784898052; x=1785502852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Am04rAViHBWH56STMMt95NmhR4rS6t7b5I/fYOQuq1I=;
 b=hvmIoffo5o5Cun6YF5dR6KVC2ZCytFB7ammBpc6BqvpGgtPQ3E2grgoA7OpKQgYozF
 /rgLIRl0iA28hDeCaDWGDlvP2/uHDrfCH+vIGn4GwUAnKNoFMO9EuoZfw1dWRhEL5o4F
 jJaJEyTf9tkLhxbixjxIlFcSgv2toH2Q7KWAzbNJZcgI+Fy9dqqZlCFJqmWt/1IntN+A
 x0HCmuhVtytG4ugUvM1wB0gNUDj0RbRZtdfgwVtTA01eLr0ZOxWmZ3UhKMdoUalkCn10
 +70U9Se8jeZtmh3JBKBAFTLQkS0jhGCWyfPX/3FNYvr6giAsdfVAhWf7PsrrERXeP0FY
 YEEA==
X-Gm-Message-State: AOJu0YzOOAiXidqk8d2231Cn++08NMzuGKos5j4mDJktQlxPPqdlTpTr
 1lOjPAopTysO5WvrCFY6Z3rSsTbI01c7MiApMj4bd+mfQUnK02TgWpYGOaDkAI48hnKWbPd59yl
 XT+n6pViXuXsQBPQ6jnFgBG7p8MZ5gwni9ykyU0zwyBCD+94SaHUMzonwEABBdne131P7JO5BZT
 yobzj2s78J9RXE0AbrOqKdRDMkdCQK2ImMNCfILttE
X-Gm-Gg: AR+sD13phGCwtaaDDkHvAPPZFy/iyeqnxM5j4Ac7zmDFb16GXnOZSTzSOCNaShNxZkD
 subhVw5UIbn2S2LUWO7Zt1XPVQFykgWVC0kqnt6LVgRIeb9UqUmQGWN15TSLn77hamMcwDKB7Ip
 3YrhyNXmXWvTiknd5t+5zAns5++9Wi75SpTZs1svHIjNqgEg55dvkutfrt4uwrvtfuCA87L2Aw6
 xMw7J+rMotqJ+x+BENulNvXxtY2j8H93CvCDE+zlsfck6K3K0OBtjWVbV0IBUb1TU0Z9lYsJkSw
 l+1jRP2ZtOTugPhdP+Cuc9QWOFhHLZwTZsZDmekyXEJeb7fqpPrZoyl3WW/hyvjeEjYhvdEyTZy
 /Op3s4jeNNs42nvtL3VwVMZCurobWVKoz+eywBni2e549gG/D9Q3FZbp6JISoxF7vALVuk2iHd0
 vsJrI/
X-Received: by 2002:a05:600c:35cb:b0:495:4fd4:619b with SMTP id
 5b1f17b1804b1-49573cc1305mr103003755e9.1.1784898051366; 
 Fri, 24 Jul 2026 06:00:51 -0700 (PDT)
X-Received: by 2002:a05:600c:35cb:b0:495:4fd4:619b with SMTP id
 5b1f17b1804b1-49573cc1305mr103002805e9.1.1784898050650; 
 Fri, 24 Jul 2026 06:00:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b5f35a1sm47388715e9.0.2026.07.24.06.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:00:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 2/3] scripts/qapi: reject empty enums
Date: Fri, 24 Jul 2026 15:00:42 +0200
Message-ID: <20260724130044.1369843-3-pbonzini@redhat.com>
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



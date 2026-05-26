Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D776CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw1o-0002Ne-2s; Tue, 26 May 2026 13:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1m-0002Lx-At
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1k-00087K-Hd
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6C9lsEi5iNLqmgqFh1Mzb9/99gwNr4jDcrF6Yon6gz4=;
 b=FoBPA64OpvFN4GSLTAkJVkRvdfNpSU4UghDY06tqdJMd8OooN9yrId3Di6+Gbpq9w7kyOx
 XvdY/z8wg572qcYsfqtUHCO9QOOh4vMjgaePaBvGILkJazaiubGgdpIswBSWezlJTlYrie
 x7/hKSoxgaw68t0iNABwFrGONsClzro=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-0uQ73Yi3N5GPrDkKNJop-w-1; Tue, 26 May 2026 13:57:13 -0400
X-MC-Unique: 0uQ73Yi3N5GPrDkKNJop-w-1
X-Mimecast-MFC-AGG-ID: 0uQ73Yi3N5GPrDkKNJop-w_1779818233
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-449dcfe8005so8596291f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818232; x=1780423032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6C9lsEi5iNLqmgqFh1Mzb9/99gwNr4jDcrF6Yon6gz4=;
 b=R7tPD3j5ku0wB7QWoxoMQla9TDd04dxwZscyWNixOY5gq6CMgyvUm53W158n5xtZ0v
 v5n2+BBVIcsokSvlt2d9swJDD1R5+hfm/tP1V6WQZxaXfx2jiyhOiUME24tlsJAummEW
 rzibfqvRyLcbLwd75mnhh825BqCGtArz+MPh4QrdzDjfBAzqGxoMxoFA1ncOb0iKafas
 YN6zM75o26W/MvwX/g46C96RsojvIXanbAKJJ1OtlZJBAYLDUQGYBtEzIPBwGAm5hQvF
 kAcpIuSCU4P5FjGS2xKZyNaIJwGCnjqBzFjEJxR5cZ1EpBabPsx8SbshRXcB4vAfYJ/O
 z6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818232; x=1780423032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6C9lsEi5iNLqmgqFh1Mzb9/99gwNr4jDcrF6Yon6gz4=;
 b=cJx6/9qKHOhkPTD6VT9hN1+aYFQHFP8x910AWmpmnSdOvxd99Xg0sCYAQsRJ3KuMWc
 s9ySwfVcxVTqt5gm/ER5gkGBf0ctRfwnNOCjwM4iDoJiLVxslKT8USsyJBrWL4G//s5i
 oF4OgYzRiw8ExHyJ0ZfONOBKmn0U9OEUK+Ewcrr0VBNA6/pSn9LnjXunLnNcd8MR56uw
 FkzWiQdr0iHio7h7X7i8JAXxIlfobJ3EaWBebChlmfWG4GqaCQL7oAiDr+dIW7OVKV1H
 Qg++qI4fbrqk2pdEz7yoi2utiBWDNpSULxLcN0p8ZJ3SU1tvzzqLkXVBXcQXmlMfubfs
 CdDA==
X-Gm-Message-State: AOJu0Yx6PCTePF/29WghvDUSACuSlosNq69EWKxtIE5Ien9k5oFH8xgj
 7gkTG64ivUxO7R+Og9myzjc1Ohoq+QxeZ2fDsMF1U0YdJW9lWwgWlPdoBgCyifM8zCJCwj0KM9A
 FBjePM2NO2XzwRyYsPKG4gcrlvFAbZ63BhQQiMjDfltEVsdJ4PYbHt5iUA+c2nYlh/rRMk4t6OB
 Sam6dL/kzJt3WmVSFvQw00o+hiaAWgAqc4bsjs5ZpZ
X-Gm-Gg: Acq92OHFCaSm89j/6Ud/0HXpTM+no97q7ImNC3r5kueCVlLHboHzAKrO0Tfi0O2xs8F
 9/TY2aFNv7Eti/cpkTd5Hl/ekc93oZekXEJvycdJFNZFnmPAaSenfzJMWMdL4uqzUks0mDdZUfQ
 gKYk05TuwLI1KA0g9FBbTM1naALHIJu7LRg060OFgZVVDDnHuA+NrlWimdNYK82fOhXrWu0MxKI
 J91GEJrZiEC6NxhiOslg+9Q5CLvKaxVKxR8H92qOE3tWjTY1FtHD8VrrDUEnXHpPrmgM9JVey6d
 CyOF1CfBSm/4c6PqsYx4pnT3iYFG5KIxFsDi8QY7vGhEgZchsdS+0gqUCjA7YE7UD8iqP1mvpu4
 M7g8ut95H1EAfolw8E+ufxFap90fYgi9FCY91gdp2Cz51czp1q/fkXpxyy0QaqDSa3malYKDkoi
 kJE38ai42zsN5g6G15Jdcdm07y3jE=
X-Received: by 2002:a05:6000:2888:b0:43d:d037:d59c with SMTP id
 ffacd0b85a97d-45eb3697a48mr34282361f8f.16.1779818232584; 
 Tue, 26 May 2026 10:57:12 -0700 (PDT)
X-Received: by 2002:a05:6000:2888:b0:43d:d037:d59c with SMTP id
 ffacd0b85a97d-45eb3697a48mr34282303f8f.16.1779818232079; 
 Tue, 26 May 2026 10:57:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9de2dsm35999338f8f.4.2026.05.26.10.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:57:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH v3 18/19] scripts/qapi: add serde attributes
Date: Tue, 26 May 2026 19:56:17 +0200
Message-ID: <20260526175618.227743-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526175618.227743-1-pbonzini@redhat.com>
References: <20260526175618.227743-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Generate serde attributes to match the serialization format to QAPI's:

- for enums, map Rust enum variants to original QAPI names

- for structs, rejects JSON with extra fields and omit optional fields
  (as opposed to serializing them as null)

- for union variants:
  - use tagged union format matching QAPI's discriminator,
  - map variant names to original QAPI names
  - flatten union data into parent struct

- for alternates, use type-based discrimination

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/rs_types.py | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi/rs_types.py b/scripts/qapi/rs_types.py
index 874ebdbfa41..41ed83c381d 100644
--- a/scripts/qapi/rs_types.py
+++ b/scripts/qapi/rs_types.py
@@ -34,6 +34,7 @@
 
 
 objects_seen = set()
+SERDE_SKIP_NONE = '#[serde(skip_serializing_if = "Option::is_none")]'
 
 
 def gen_rs_variants_to_tag(name: str,
@@ -80,10 +81,12 @@ def gen_rs_variants(name: str,
     ret = mcgen('''
 
 %(cfg)s''', '''
-#[derive(Clone, Debug, PartialEq)]
+#[derive(Clone, Debug, PartialEq, Serialize, Deserialize)]
+#[serde(tag = "%(tag)s")]
 pub enum %(rs_name)sVariant {''',
                 cfg=ifcond.rsgen(),
-                rs_name=rs_name(name))
+                rs_name=rs_name(name),
+                tag=variants.tag_member.name)
 
     for var in variants.variants:
         type_name = var.type.name
@@ -91,18 +94,22 @@ def gen_rs_variants(name: str,
         if type_name == 'q_empty':
             ret += mcgen('''
     %(cfg)s''', '''
+    #[serde(rename = "%(rename)s")]
     %(var_name)s,
 ''',
                          cfg=var.ifcond.rsgen(),
-                         var_name=var_name)
+                         var_name=var_name,
+                         rename=var.name)
         else:
             ret += mcgen('''
     %(cfg)s''', '''
+    #[serde(rename = "%(rename)s")]
     %(var_name)s(%(rs_type)s),
 ''',
                          cfg=var.ifcond.rsgen(),
                          var_name=var_name,
-                         rs_type=var.type.rs_type())
+                         rs_type=var.type.rs_type(),
+                         rename=var.name)
 
     ret += mcgen('''
 }
@@ -158,9 +165,11 @@ def gen_struct_members(members: List[QAPISchemaObjectTypeMember],
             typ = 'Option<%s>' % typ
         ret.append(mcgen('''
 %(cfg)s''', '''
+%(skip_if)s''', '''
     pub %(rs_name)s: %(rs_type)s,
 ''',
                          cfg=memb.ifcond.rsgen(),
+                         skip_if=SERDE_SKIP_NONE if memb.optional else '',
                          rs_type=typ,
                          rs_name=rs_name(camel_to_lower(memb.name))))
     return '\n'.join(ret)
@@ -181,17 +190,23 @@ def gen_rs_object(name: str,
     ret = ''
     objects_seen.add(name)
 
+    serde_deny_unknown_fields = "#[serde(deny_unknown_fields)]"
     if variants:
         ret += gen_rs_variants(name, ifcond, variants)
+        # we can't use because of the flatten unions
+        # serde FlatMapAccess should consume the fields?
+        serde_deny_unknown_fields = ""
 
     ret += mcgen('''
 
 %(cfg)s''', '''
-#[derive(Clone, Debug, PartialEq)]''', '''
+#[derive(Clone, Debug, PartialEq, Serialize, Deserialize)]''', '''
+%(serde_deny_unknown_fields)s''', '''
 pub struct %(rs_name)s {
 ''',
                  cfg=ifcond.rsgen(),
-                 rs_name=rs_name(name))
+                 rs_name=rs_name(name),
+                 serde_deny_unknown_fields=serde_deny_unknown_fields)
 
     if base:
         if not base.is_implicit():
@@ -213,6 +228,7 @@ def gen_rs_object(name: str,
 
     if variants:
         ret += mcgen('''
+    #[serde(flatten)]
     pub u: %(rs_type)sVariant,
 ''', rs_type=rs_name(name))
     ret += mcgen('''
@@ -227,7 +243,7 @@ def gen_rs_enum(name: str,
     ret = mcgen('''
 
 %(cfg)s''', '''
-#[derive(Copy, Clone, Debug, PartialEq)]
+#[derive(Copy, Clone, Debug, PartialEq, Serialize, Deserialize)]
 ''',
                 cfg=ifcond.rsgen())
 
@@ -242,10 +258,12 @@ def gen_rs_enum(name: str,
     for member in members:
         ret += mcgen('''
     %(cfg)s''', '''
+    #[serde(rename = "%(member_name)s")]
     %(c_enum)s,
 ''',
                      cfg=member.ifcond.rsgen(),
-                     c_enum=rs_name(camel_to_upper(member.name)))
+                     c_enum=rs_name(camel_to_upper(member.name)),
+                     member_name=member.name)
     ret += '''}
 
 '''
@@ -279,7 +297,8 @@ def gen_rs_alternate(name: str,
 
     ret += mcgen('''
 %(cfg)s''', '''
-#[derive(Clone, Debug, PartialEq)]
+#[derive(Clone, Debug, PartialEq, Serialize, Deserialize)]
+#[serde(untagged)]
 pub enum %(rs_name)s {
 ''',
                  cfg=ifcond.rsgen(),
@@ -329,6 +348,8 @@ def visit_begin(self, schema: QAPISchema) -> None:
 // that *could* be Eq too.
 #![allow(clippy::derive_partial_eq_without_eq)]
 
+use serde_derive::{Serialize, Deserialize};
+
 use util::qobject::QObject;
 '''))
 
-- 
2.54.0



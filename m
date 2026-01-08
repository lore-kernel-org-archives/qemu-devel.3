Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A416D185F2
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpnc-00089N-Ok; Thu, 08 Jan 2026 08:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpna-00088S-K9
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnY-00084k-Vi
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767877892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nyF4XBGwym7P72pkoLWyXPv/dFuoXRVdsycFcj1MYQ4=;
 b=PL5XQht5AlriPF5rYJem/HENfBDy4xBMexJNj+KJT6XX1V2RTGt/eNTjTRdlZ7q3zu3PyI
 rRBnJePGpHXwTSXpzaqw9bWQP2pe9xUxg65cDITXMiFcIjgbthwFpKJ/KNN6cbyn/OUSh6
 fghs3+0mr7QsojahScUse6Lg7jq8UkU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-IzAUtesNMW6i-gbouiPFXw-1; Thu, 08 Jan 2026 08:11:30 -0500
X-MC-Unique: IzAUtesNMW6i-gbouiPFXw-1
X-Mimecast-MFC-AGG-ID: IzAUtesNMW6i-gbouiPFXw_1767877890
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43009df5ab3so2062140f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767877889; x=1768482689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nyF4XBGwym7P72pkoLWyXPv/dFuoXRVdsycFcj1MYQ4=;
 b=AVMXrEDupfTgJ6o6/Q3wrrhGVYKWaxruMIYlbh90kTb4UuIrRS8P6yDgXgZ4reD9dl
 EiXRCbkZtmzN+mBePeX3aoY9Qr8o3cyEaeMSqBSTDBr5oyDJyY0w8K/0LMg+BonXr9vg
 gCI3rpgowVw/X+9y1RA35/cAtlMBbWcGljEU5yQfhnly9TNo0F7q2sr7QZkfZKPIvOSV
 t0NiXjvU3dgtSbaFjuGEn3mEMDzn7HYdqJLOY/nXjI5YZdTV/MUMxW3nDapuHh+4Cs+l
 4W44lYOiEAqCI1Ha9U30tGk4zBCUHYQH2UBnkz9nwVyixlc3MuC5dNFvXx8ifza27Xlk
 562A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767877889; x=1768482689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nyF4XBGwym7P72pkoLWyXPv/dFuoXRVdsycFcj1MYQ4=;
 b=OcAsUYjWDihcEULYKsxHF5TF+GW6fsH0Gns0DqormFX4fIxZ+ac33B0TgrHJEUi5nj
 PtzcpBcgMsl/LHaMftGb58dhCjJpxWyePazhcTLM/4NfwMmZBnRXXpG1JzOSYrCW1kpk
 DwHdcuDoy72S4Eciqt+xcV5angX3IPpFlgiApS9EXDrCe0Pgg8QlpDt3BgRVhu+kSqjQ
 kV57TmpEkJY5Hsz/1EKrXThoDZ0kMrsRr77ilfsRMSTfjjsJxIrxjiTEmPx3GUHGnDOu
 2RGQL2ibSX9jHObCalhxcU6yhq8iAtYz1avvN/m7WFxrb83IDB/mh3ES+TVuygd1B8FH
 wq8g==
X-Gm-Message-State: AOJu0Yyj0L8PeKH+655cVkg8vGrGi3sZMNG4dRATtfPGJRvSTLGJmC4A
 i+zJdWkb15MS7veFjx3M8996OrLPTl4URdzSkJEaKWxDXGvwMuRZNlLHZvGxwpO1zNw6oGiBTTs
 djMKHqOWOm/mujsy5WX0DzEpUlQmUUS/gJu8TVPz3WysoUEIx7C7Sh/2ToJJIp3HCuNlg3aDYb7
 sFKpQ3RCsMs/N/D44sM4LyEqv7V93Lpn2KbK5w9Gwd
X-Gm-Gg: AY/fxX4OFBW8mH17blUJgF/kb0bsguFacbuD0lzpg/E4mGYMtbLO047xIaAo9sFEGpR
 KkqxmobMSbbDHTUquqLJ3P9yEtRXGvrHnYhJ+zn51X0TkDYGNCaNdxsybH6S2BAZmyksW3UvN9g
 iJiH1BQtLjv5AIWi7fzzgk93BuGF42ANewfTEx2j1ZIqWs+nTmjuVn/CGW4i6enCF2QapYmY4zp
 g6XJfvBuTMasmOJ/39JbwQ1RPqPZAfx+chjJVKYRhZ7gDtYYY5XDpnhcGTHWHlJBtkOyh9GRc6W
 ecfxEyC3T7+NlyihQuttghetQcnFRMQfB69FS0gAb73oZmaGCtcl4xbd3fzg/cC6QnvSrGV+O8c
 Pg6sJtn2TKzMjt8QV/4myQnMNarNgjtHftMb/sXdqODE+xUbcTHAUuIWWHx02gDMmeIpWzoeRXv
 pixKWj6+5DwJ1R4A==
X-Received: by 2002:a5d:5f51:0:b0:430:ff81:295d with SMTP id
 ffacd0b85a97d-432c374fc38mr8437619f8f.41.1767877888726; 
 Thu, 08 Jan 2026 05:11:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeYdz1HHfLuHgabdLWpi2Jvct5rCgEFFttH08X/7L6jRyLNg+eS5CiRzT/qYKozVSkJ61Bxw==
X-Received: by 2002:a5d:5f51:0:b0:430:ff81:295d with SMTP id
 ffacd0b85a97d-432c374fc38mr8437582f8f.41.1767877888225; 
 Thu, 08 Jan 2026 05:11:28 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e6784sm16315281f8f.19.2026.01.08.05.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:11:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: [PATCH v2 15/16] scripts/qapi: add serde attributes
Date: Thu,  8 Jan 2026 14:10:42 +0100
Message-ID: <20260108131043.490084-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108131043.490084-1-pbonzini@redhat.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

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
index 64702eb54ae..fb3362ad601 100644
--- a/scripts/qapi/rs_types.py
+++ b/scripts/qapi/rs_types.py
@@ -33,6 +33,7 @@
 
 
 objects_seen = set()
+SERDE_SKIP_NONE = '#[serde(skip_serializing_if = "Option::is_none")]'
 
 
 def gen_rs_variants_to_tag(name: str,
@@ -79,11 +80,13 @@ def gen_rs_variants(name: str,
     ret = mcgen('''
 
 %(cfg)s
-#[derive(Clone, Debug, PartialEq)]
+#[derive(Clone, Debug, PartialEq, Serialize, Deserialize)]
+#[serde(tag = "%(tag)s")]
 pub enum %(rs_name)sVariant {
 ''',
                 cfg=ifcond.rsgen(),
-                rs_name=rs_name(name))
+                rs_name=rs_name(name),
+                tag=variants.tag_member.name)
 
     for var in variants.variants:
         type_name = var.type.name
@@ -91,18 +94,22 @@ def gen_rs_variants(name: str,
         if type_name == 'q_empty':
             ret += mcgen('''
     %(cfg)s
+    #[serde(rename = "%(rename)s")]
     %(var_name)s,
 ''',
                          cfg=var.ifcond.rsgen(),
-                         var_name=var_name)
+                         var_name=var_name,
+                         rename=var.name)
         else:
             ret += mcgen('''
     %(cfg)s
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
         ret += mcgen('''
     %(cfg)s
+    %(serde_skip_if)s
     pub %(rs_name)s: %(rs_type)s,
 ''',
                      cfg=memb.ifcond.rsgen(),
+                     serde_skip_if=SERDE_SKIP_NONE if memb.optional else '',
                      rs_type=typ,
                      rs_name=rs_name(camel_to_lower(memb.name)))
     return ret
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
 
 %(cfg)s
-#[derive(Clone, Debug, PartialEq)]
+#[derive(Clone, Debug, PartialEq, Serialize, Deserialize)]
+%(serde_deny_unknown_fields)s
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
 
 %(cfg)s
-#[derive(Copy, Clone, Debug, PartialEq)]
+#[derive(Copy, Clone, Debug, PartialEq, Serialize, Deserialize)]
 ''',
                 cfg=ifcond.rsgen())
 
@@ -243,10 +259,12 @@ def gen_rs_enum(name: str,
     for member in members:
         ret += mcgen('''
     %(cfg)s
+    #[serde(rename = "%(member_name)s")]
     %(c_enum)s,
 ''',
                      cfg=member.ifcond.rsgen(),
-                     c_enum=rs_name(camel_to_upper(member.name)))
+                     c_enum=rs_name(camel_to_upper(member.name)),
+                     member_name=member.name)
     ret += '''}
 
 '''
@@ -280,7 +298,8 @@ def gen_rs_alternate(name: str,
 
     ret += mcgen('''
 %(cfg)s
-#[derive(Clone, Debug, PartialEq)]
+#[derive(Clone, Debug, PartialEq, Serialize, Deserialize)]
+#[serde(untagged)]
 pub enum %(rs_name)s {
 ''',
                  cfg=ifcond.rsgen(),
@@ -330,6 +349,8 @@ def visit_begin(self, schema: QAPISchema) -> None:
 // that *could* be Eq too.
 #![allow(clippy::derive_partial_eq_without_eq)]
 
+use serde_derive::{Serialize, Deserialize};
+
 use util::qobject::QObject;
 '''))
 
-- 
2.52.0



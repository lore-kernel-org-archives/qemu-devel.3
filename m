Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97891C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 20:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whCNf-0002th-Tv; Tue, 07 Jul 2026 16:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1whCNe-0002r7-6q
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:26:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1whCNb-00011q-Mc
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783456013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4rRVOD9JdtFyrvbr21MiljNX4Qwlq5H4qhDRzDY8Vko=;
 b=HhaBoyekO2RjSCU3jrRN3d155I+AtpSyyo+iCgbCY1R0UA1zFmEv6IkFv/BMS0ApxFhu5w
 OzkDeeZlDAnd8dQZKLEiMwUR/JCAJELf+KKLSklQXhBbNvpcSSx1QXwKVSJ0ORd/kMcZ8s
 FekJ+61G7SHv4p1j/yGzOGl5hx/koYM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-NjBhF1dlPXKg4XtqNk7rsg-1; Tue,
 07 Jul 2026 16:26:50 -0400
X-MC-Unique: NjBhF1dlPXKg4XtqNk7rsg-1
X-Mimecast-MFC-AGG-ID: NjBhF1dlPXKg4XtqNk7rsg_1783456009
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C441A1809C8D; Tue,  7 Jul 2026 20:26:48 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75DCB1955F1C; Tue,  7 Jul 2026 20:26:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] meson: detect bindgen and LLVM 22 incompatibility
Date: Wed,  8 Jul 2026 00:26:40 +0400
Message-ID: <20260707202640.2099841-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

bindgen < 0.72.1 linked against libclang >= 22 generates opaque structs
for C types declared with "typedef struct X X;" forward declarations,
common in QEMU. The struct fields are missing from the generated Rust
bindings. For example, with bindgen 0.71.x and LLVM 22, a struct like:

  typedef struct VMStateField VMStateField;
  struct VMStateField {
      const char *name;
      int version_id;
  };

produces:

  pub struct VMStateField {
      pub _address: u8,
  }

instead of:

  pub struct VMStateField {
      pub name: *const c_char,
      pub version_id: c_int,
  }

The build then fails with:
  error[E0609]: no field `version_id` on type `VMStateField`
  error[E0609]: no field `flags` on type `VMStateField`
  error[E0560]: struct `util_sys::Error` has no field named `msg`

Check the bindgen version against llvm-config at configure time. With
-Drust=enabled, error out; with -Drust=auto, disable Rust and suggest
the upgrade.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 meson.build | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/meson.build b/meson.build
index 164328ded83..c965cef352e 100644
--- a/meson.build
+++ b/meson.build
@@ -125,6 +125,25 @@ if have_rust
       have_rust = false
     endif
   endif
+
+  # bindgen < 0.72.1 generates opaque structs for "typedef struct X X;"
+  # patterns when linked against libclang >= 22.
+  if have_rust and bindgen.version().version_compare('<0.72.1')
+    llvm_config = find_program('llvm-config', required: false)
+    if llvm_config.found()
+      llvm_version = run_command(llvm_config, '--version',
+                                 check: true).stdout().strip()
+      if llvm_version.version_compare('>=22.0.0')
+        if get_option('rust').enabled()
+          error('bindgen ' + bindgen.version() + ' is incompatible with LLVM ' + llvm_version + '. ' +
+                'Please upgrade with "cargo install --locked bindgen-cli@0.72.1"')
+        else
+          warning('bindgen ' + bindgen.version() + ' is incompatible with LLVM ' + llvm_version + ', disabling Rust.')
+          have_rust = false
+        endif
+      endif
+    endif
+  endif
 endif
 
 if have_rust
-- 
2.55.0



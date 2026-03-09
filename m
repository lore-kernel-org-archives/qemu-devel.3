Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0280EEF371E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzWPU-0001f5-2c; Mon, 09 Mar 2026 04:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vzWPO-0001eA-43
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vzWPL-0001OT-Ls
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773046569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/HlY8JJ2ZwQtAbGhleOP05qyV3gQEb1rXboDai36nKE=;
 b=et934AtP5SW342yeN4FhgjG4DDhJSZKdh2h9tp0QNeGNPJWTX7+J4lfIYVqVK43uN2B9Hl
 XemWqfaNs6jfBLmSchvUSH33UYuOWVkTWZ2wadmtnxgjKUP1mhyuKa0p0lM2eH0zTFhuH7
 OE2ZRdyACjRZsbReMZ2nIWNAWTZjM3M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-GTOatqOWMC-hi_QcULEz3Q-1; Mon, 09 Mar 2026 04:56:06 -0400
X-MC-Unique: GTOatqOWMC-hi_QcULEz3Q-1
X-Mimecast-MFC-AGG-ID: GTOatqOWMC-hi_QcULEz3Q_1773046565
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439b20722e3so4221623f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773046565; x=1773651365; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/HlY8JJ2ZwQtAbGhleOP05qyV3gQEb1rXboDai36nKE=;
 b=P1Q2Q1aTCA9tF7EtXwvwHKG+5x6QJdBSZMY5OO0JX26GBjaLSzLWtE2Arv0s8VSdgh
 Ytr5nk51c06QeoLE0M5qrUzQEZhA7LiVB3Rqi9XpozgGxEosjt7z+PMBYfoQsxOntT0b
 zjU5AE1K2Ae8udqeo6fDhCulyBdR1bhM+fexhgBmJ73qoyvTQ3wxCIz3LzyYzuJzNY70
 vKrL3NeaKDQlEg0cAqLZc5VBI6eNqz1ja+4g/V5kscptP/yIQjOJWQCp7D229dmlDz+r
 wcvec8rHjp/fUucUUsUHhon42Vd6Woqb7AD15FlqpiD6b/L0NhYSiJPgpgIpGZ5LChKN
 jtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773046565; x=1773651365;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HlY8JJ2ZwQtAbGhleOP05qyV3gQEb1rXboDai36nKE=;
 b=apr+jZGw2oUburzQeyNA6oOPO2qotUAT+IqyRPOw9qHJznOedWJWHmLzvy1Qv7BlCH
 3NDnJ1fQGzUiOMX48GwBxloIfAkPC3tmROK17S7dflPOK027vspU4VlFDj8VAhRl9gd4
 sSi7WV+yjy4cJAEeAVF2CPLuFrCSIp8x4YuWSqDY+kvNAFD+ry1k9GUg+8S4sO+uHgRm
 6uKzRGBGyS+LUSIfYGBdYbZJ3+MGf6oQYPdOaElXZaOGG7AAWUoe1Y0VqB9utar0Vgvo
 MvoVLr68ECzK7DFigoGMCkNb149QxoituAEB3JSFeN9/NKZxsk1WlZe8vEbKvEUcp0/r
 +bpg==
X-Gm-Message-State: AOJu0YySE/rsC6CxBWtA92bsC4XWp8+fQDbQmBv7XzazclsjxsPseEmx
 LOxqixYE12KwFZr9ul/wvHfWXDaJLgXbl2mW4fFU97FxyEBxDoeWtN/yke0efmKDGUlaanjjVA5
 zE3v8jilQPkKfkBZVQQFiOpBtDf2HunpUqbeQKzdQH6Am5oLeqfnf+za4
X-Gm-Gg: ATEYQzw9XG0tQ6JkBP67cYdoRwdGxlYhYJEPTybMVdzD8eIDeATp5qgthNus/jr2bXw
 qJ+716AEkb+hGBce4zlu4qtb4biaIAqYS0Y2HtTtzAcGpsrNmXfEWuHVtbween1ysoiJFrkmUVf
 6cbnIKWjtm6HS3wZspLQj4Xh/ISTNGd6zrh4pk431D92UbRGqQLNEw+Yv11lmTgmm2HQWl1xq5Z
 u+FU/HDA8hbdmxRYMNO4XiWN/KLwH3NCrLnfRkAZmQjtGDfREQM+14VHAx7N9rlU32CzZ5yhH+7
 IXTWlPtwCEwyz/XtSGu82FZ+a2gRs67sQEvF4z5IntgLerH9VHB4m1mwxApn/OFkL1Vl8wCUAnI
 soHHoq2VEQlESksKxwsYXhOTsW5/eEX+zpUDpd2jLFqe2Wkcu3AXz/BAuuyvi
X-Received: by 2002:a05:6000:2881:b0:439:b744:c601 with SMTP id
 ffacd0b85a97d-439da894037mr16836619f8f.40.1773046564822; 
 Mon, 09 Mar 2026 01:56:04 -0700 (PDT)
X-Received: by 2002:a05:6000:2881:b0:439:b744:c601 with SMTP id
 ffacd0b85a97d-439da894037mr16836573f8f.40.1773046564313; 
 Mon, 09 Mar 2026 01:56:04 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dada3b43sm25342856f8f.13.2026.03.09.01.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 01:56:03 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 09 Mar 2026 09:55:52 +0100
Subject: [PATCH v2] igvm: fix build when igvm is not installed in a well
 known path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-master-v2-1-7e02f07a1096@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XMyw7CIBCF4VdpZi2G4VKJK9/DdIHtVFi0NQMhm
 oZ3F7t1+Z+cfDsk4kgJrt0OTCWmuK0t1KmDMfj1SSJOrUFJ1UstrVh8ysSCEN1DO9JoCNr5xTT
 H9wHdh9Yhprzx53AL/tY/oqBA0duLMUbNlsjdmKbg83ncFhhqrV9TB/7qnQAAAA==
X-Change-ID: 20260305-master-e118b38e314e
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Oliver Steffen <osteffen@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

`stubs/igvm.c` includes `igvm-internal.h`, that in turn includes the igvm library.
This is required just for the QIgvm declaration and creates an
unnecessary dependency on the library.

Since igvm is not listed as a dependency of stubs, this results in build
failing when the library is not installed in a "well known" path of the
system.

Add a forward declaration for QIgvm and move the definition of
`qigvm_directive_madt` to `igvm.h` so that we can drop `igvm-internal.h` from
`stubs/igvm.c`.

Fixes: dea1f68a5c ("igvm: Fill MADT IGVM parameter field on x86_64")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v2:
- Removed blankline between tags [Stefano]
- Removed typedef for QIgvm in igvm-internal.h [Stefano]
- Link to v1: https://lore.kernel.org/qemu-devel/20260305-master-v1-1-6574442f5ee8@redhat.com
---
 include/qemu/typedefs.h        | 1 +
 include/system/igvm-internal.h | 9 ++-------
 include/system/igvm.h          | 5 +++++
 stubs/igvm.c                   | 1 -
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 416a8c9acead659786f22dfa7542f7af93699cec..cbe6f7f4c7c1092017296cbba09cc79b03b45b79 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -102,6 +102,7 @@ typedef struct QEMUSGList QEMUSGList;
 typedef struct QemuSpin QemuSpin;
 typedef struct QEMUTimer QEMUTimer;
 typedef struct QEMUTimerListGroup QEMUTimerListGroup;
+typedef struct QIgvm QIgvm;
 typedef struct QList QList;
 typedef struct QNull QNull;
 typedef struct QNum QNum;
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 38004bd908e773a3ffc2343a9035be86dc6a8ace..76ae1bc3be9249cc1796bd7eec77dd9084358f98 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -42,7 +42,7 @@ typedef struct QIgvmParameterData {
  * QIgvm contains the information required during processing of a single IGVM
  * file.
  */
-typedef struct QIgvm {
+struct QIgvm {
     IgvmHandle file;
     MachineState *machine_state;
     ConfidentialGuestSupportClass *cgsc;
@@ -67,16 +67,11 @@ typedef struct QIgvm {
     unsigned region_start_index;
     unsigned region_last_index;
     unsigned region_page_count;
-} QIgvm;
+};
 
 IgvmHandle qigvm_file_init(char *filename, Error **errp);
 
 QIgvmParameterData*
 qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index);
 
-/*
- *  IGVM parameter handlers
- */
-int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp);
-
 #endif
diff --git a/include/system/igvm.h b/include/system/igvm.h
index 5573a6111ae754e2de49ba72a354b36c4b6fe747..f9231f03ec8015928d0968ac59c72a1b6d9f00b9 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -27,4 +27,9 @@ int qigvm_x86_get_mem_map_entry(int index,
 int qigvm_x86_set_vp_context(void *data, int index,
                              Error **errp);
 
+/*
+ *  IGVM parameter handlers
+ */
+int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp);
+
 #endif
diff --git a/stubs/igvm.c b/stubs/igvm.c
index 47d5130d9d7488fb1092a0b5389a864d83e8b2f2..9e9f683fc9607bae85baaaa2f269eba594ae0574 100644
--- a/stubs/igvm.c
+++ b/stubs/igvm.c
@@ -12,7 +12,6 @@
 #include "qemu/osdep.h"
 
 #include "system/igvm.h"
-#include "system/igvm-internal.h"
 
 int qigvm_x86_get_mem_map_entry(int index,
                                 ConfidentialGuestMemoryMapEntry *entry,

---
base-commit: 333aaa55f051977cc897fb71e0a9ed52bb00a675
change-id: 20260305-master-e118b38e314e

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>



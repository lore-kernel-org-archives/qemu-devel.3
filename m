Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848DAC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzgC-0004aG-0k; Wed, 16 Jul 2025 06:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzcw-0007AS-Kc
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzct-0000Mf-8F
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zAxmSkHttozgNdccvGKZ4nR50Gke4h/XKAmd7tQ3IBs=;
 b=ifAOHIuLcCaRGkJOBBVFyHexy5AKh3Q35Jvb1x26Ys60iwvn5q6Od1Y1bgwHn8dLXhJ9w1
 IPzm/GtT7CauXmMqjj0164Lzq1Lw4UsgQKqzp7xJBknSLEmDlRffdgVzMGF6y9zCQ+6Ekb
 /WFGSxvalxQNgmkAlysLIoNXJ3i4K6Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-ipUPg6FKNOWlVnl8ziVaBg-1; Wed, 16 Jul 2025 06:44:37 -0400
X-MC-Unique: ipUPg6FKNOWlVnl8ziVaBg-1
X-Mimecast-MFC-AGG-ID: ipUPg6FKNOWlVnl8ziVaBg_1752662676
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3141f9ce4e2so10598525a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662676; x=1753267476;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAxmSkHttozgNdccvGKZ4nR50Gke4h/XKAmd7tQ3IBs=;
 b=teH0NvG5kyRKNtdNXOlpxohiJY3DUAEveoUr4OATrFcCsvlrDbuD+HmoBzTr+OI5fV
 7giTllZ1O8FUxWSiDV4VgojndxQMn4GzvpRRBroVEMU2SAK4KH+rIC1+z0LmM2eCIWde
 +LXJK76NoWfcZeLK1QA2KWAK6+/wxUX9Pi0yp1ItpTPg1sRRkqx/ZW8nzx1+KjFzKi8h
 ke/G0TNCcatCPhBwmT/zTUH7vQFHbxtnnMNU88Nnq0PF/v5sYzrOLVEOQtkS31OkuoWY
 iNvuCWATYnpZleu4ZAkb1I1ys0dYlVxnOg7jdPYf8d8y2ODZg2N3XZO34wDwILcLrzW7
 BY1Q==
X-Gm-Message-State: AOJu0YxVC41+hIsPBcpa5HU9G7XU4Lfert4GtpfVLtC1MDMjFDPNX0Yg
 1F4sBss2529QOl8ASaalQYiDmMhmfSswkNwQsjgOjLsk0X6rhGYVWAPaiEPD/PJaELF6q1i6PbU
 pDN6P5PZxO0Tczxm6SiHoVLssYpSqnlxU/2YzeLwFlAK22rSlJsUBAZCE
X-Gm-Gg: ASbGnct6ljburJBIJXSC6CQIChjlxTvMPrTljR5WGoSTZxO6ObaoL2P+/DRbM4DQYdN
 wgHa4rReq/dN6tA/zTJ+dMVN9060CK9NU8hgrb0yN/EZh6Ud9y4j2fAcvyPxa3zd6dCTRWlYCBH
 /i1i0zPu3Sq/jMiFRZt6joZj5kqM8MnBiPqdfVpRLJ8iv6QhEmLaesB+U8J+4BtjRvTU7qj1SAo
 /8wFVVInDKcgYt8RPeZMwkqaGxplqFYwFQxzixuUpawGs48vs0xnBJhE3W62V9427OWdau7WVCX
 gY/wvfkF84CusH3bsFD4V5SAxC+/tAs6xE59cl02UWgypOGKSQ==
X-Received: by 2002:a17:90b:2dc4:b0:313:62ee:45a with SMTP id
 98e67ed59e1d1-31c9f3c5de9mr2702356a91.13.1752662676277; 
 Wed, 16 Jul 2025 03:44:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRDmXF7FzYxT0/6ZxcCkRXvygWzHx04/JRLf0D3HlquF5nizPvxS8dU5IsP/vims6wqMiVcw==
X-Received: by 2002:a17:90b:2dc4:b0:313:62ee:45a with SMTP id
 98e67ed59e1d1-31c9f3c5de9mr2702316a91.13.1752662675865; 
 Wed, 16 Jul 2025 03:44:35 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:44:35 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:12:59 +0530
Subject: [PATCH v4 09/23] migration: push Error **errp into
 ram_postcopy_incoming_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-9-7141902077c0@redhat.com>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
In-Reply-To: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5078; i=armenon@redhat.com;
 h=from:subject:message-id; bh=TwajBvD+zatrJRO4j0iPb+JGwx4gsnGk8Zv4fEigR3I=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5kz1zR3SMl3uKZHTrvLTKIOap757uWMd6xfODzpfv0
 67+4X/QUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCKXZBj+Z75/cY/Z9vB8tnPX
 VZkk489w7m4sVvMI0wwxapi81u9tJMP/pJ1/77+SmfUiNqyG2+XDi2CHm4Z5fw5+ctn46fYnAQ5
 FHgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that ram_postcopy_incoming_init() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/postcopy-ram.c | 9 ++++++---
 migration/postcopy-ram.h | 2 +-
 migration/ram.c          | 6 +++---
 migration/ram.h          | 2 +-
 migration/savevm.c       | 3 ++-
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 45af9a361e8eacaad0fb217a5da2c5004416c1da..05617e5fbcad62226a54fe17d9f7d9a316baf1e4 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -681,6 +681,7 @@ out:
  */
 static int init_range(RAMBlock *rb, void *opaque)
 {
+    Error **errp = opaque;
     const char *block_name = qemu_ram_get_idstr(rb);
     void *host_addr = qemu_ram_get_host_addr(rb);
     ram_addr_t offset = qemu_ram_get_offset(rb);
@@ -701,6 +702,8 @@ static int init_range(RAMBlock *rb, void *opaque)
      * (Precopy will just overwrite this data, so doesn't need the discard)
      */
     if (ram_discard_range(block_name, 0, length)) {
+        error_setg(errp, "failed to discard RAM block %s len=%zu",
+                   block_name, length);
         return -1;
     }
 
@@ -749,9 +752,9 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
  * postcopy later; must be called prior to any precopy.
  * called from arch_init's similarly named ram_postcopy_incoming_init
  */
-int postcopy_ram_incoming_init(MigrationIncomingState *mis)
+int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)
 {
-    if (foreach_not_ignored_block(init_range, NULL)) {
+    if (foreach_not_ignored_block(init_range, errp)) {
         return -1;
     }
 
@@ -1703,7 +1706,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis, Error **errp)
     return false;
 }
 
-int postcopy_ram_incoming_init(MigrationIncomingState *mis)
+int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)
 {
     error_report("postcopy_ram_incoming_init: No OS support");
     return -1;
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 3852141d7e37ab18bada4b46c137fef0969d0070..ca19433b246893fa5105bcebffb442c58a9a4f48 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -30,7 +30,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis);
  * postcopy later; must be called prior to any precopy.
  * called from ram.c's similarly named ram_postcopy_incoming_init
  */
-int postcopy_ram_incoming_init(MigrationIncomingState *mis);
+int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp);
 
 /*
  * At the end of a migration where postcopy_ram_incoming_init was called.
diff --git a/migration/ram.c b/migration/ram.c
index 7208bc114fb5c366740db380ee6956a91b3871a0..8223183132dc0f558f45fbae3f4f832845730bd3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3708,7 +3708,7 @@ static int ram_load_cleanup(void *opaque)
 /**
  * ram_postcopy_incoming_init: allocate postcopy data structures
  *
- * Returns 0 for success and negative if there was one error
+ * Returns 0 for success and -1 if there was one error
  *
  * @mis: current migration incoming state
  *
@@ -3716,9 +3716,9 @@ static int ram_load_cleanup(void *opaque)
  * postcopy-ram. postcopy-ram's similarly names
  * postcopy_ram_incoming_init does the work.
  */
-int ram_postcopy_incoming_init(MigrationIncomingState *mis)
+int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp)
 {
-    return postcopy_ram_incoming_init(mis);
+    return postcopy_ram_incoming_init(mis, errp);
 }
 
 /**
diff --git a/migration/ram.h b/migration/ram.h
index 921c39a2c5c45bc2344be80854c46e4c10c09aeb..275709a99187f9429ccb4111e05281ec268ba0db 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -86,7 +86,7 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms);
 void ram_postcopy_send_discard_bitmap(MigrationState *ms);
 /* For incoming postcopy discard */
 int ram_discard_range(const char *block_name, uint64_t start, size_t length);
-int ram_postcopy_incoming_init(MigrationIncomingState *mis);
+int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp);
 int ram_load_postcopy(QEMUFile *f, int channel);
 
 void ram_handle_zero(void *host, uint64_t size);
diff --git a/migration/savevm.c b/migration/savevm.c
index 1953842177f03691b3f401a4ea8b1425ef90ac9e..4abb3d8c84ee29de60912b4d5890074a39e87704 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1983,7 +1983,8 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
         return -1;
     }
 
-    if (ram_postcopy_incoming_init(mis)) {
+    if (ram_postcopy_incoming_init(mis, NULL)) {
+        error_setg(errp, "PostCopy RAM incoming init failed");
         return -1;
     }
 

-- 
2.50.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DB2C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCjN-0001JT-Cu; Wed, 16 Jul 2025 20:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCfo-0003i3-6J
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCfl-00051C-Uk
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKQyWcOpPufP5JITdKZpkOm1yyO5xPfIw8y7KjCS+g8=;
 b=ekc/G48kZyVpb0HK1TpvVwFUDz6jilZW34la3ZC3ckscDNw5rgd+MiDBrOmlFz1SiwTxOb
 Rk2L+/wQgm1X36eH696E7Sd/nTe8Tkh51OYIqS0tOKKqEP85qmU9Jvl5M4flKvce2PpEwa
 oGtSSzRSHNh57HonfJAk2Sm3ZYuZsxY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-XnFhG8sWOP64UUt1ysR2tw-1; Wed, 16 Jul 2025 20:40:25 -0400
X-MC-Unique: XnFhG8sWOP64UUt1ysR2tw-1
X-Mimecast-MFC-AGG-ID: XnFhG8sWOP64UUt1ysR2tw_1752712823
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31315427249so332223a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712823; x=1753317623;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKQyWcOpPufP5JITdKZpkOm1yyO5xPfIw8y7KjCS+g8=;
 b=rxfqNhiuwA8QPsO5yzyWuWJodtNI4FZ/YLw/PlX4WMPP2IKK4GeyU609mLDWeVYgze
 UgIkDZslNckP1e82oVzJDQIsOIPtLlOFHZa+g0tBkdibO7tmYh88/zIjLViEVfIrVwG7
 X8YtLT38/NmenBnEj+09NX94Lhx3Rg/7sSaq0QcnZdIDO66p9FdjFBBpvuD7MLZdjHSd
 vGT9qeRPpzF8yr7U3CyePRVEs5HmwZyHM8oM3QzK4da0cpRKmR3JzNWUSI6E9CGbqoV5
 BII7HPCTv0EAe6+QaSbylf18SoAQeTj5vBPM7dXNlN5WpYE8hg7PqNattw+bQXosylQu
 jdww==
X-Gm-Message-State: AOJu0YzUNyHRy5DoMELQCadQ+oW2Mbdy4L0Dn5drvZ4k0SXzgP5M6EYP
 FREGhI3cmcuse1E1NIfPEdVfmZLjQhP8LPZBoB8HABhpWBWq/fZnkvZgKJgOAvy52DD4+CYIkT+
 Hlha4z9NMz8xF7sx29RksF3dZ22vN/VQKfVV8U4DWDGV0R2qYdOpPPdxF
X-Gm-Gg: ASbGncsQiKNMlwJk/nfxUQfZ9/jITP3OUxzP4CJRAH6wwfCZR9zvE//bXztCDtbbRWP
 716fZ7BaqsJ4bTNVKP1YeG9MQcVlgrtW8jAt/xo7yfFBB+iNEuhdDtrtUIuO4lozRqeeQrYYoqa
 Ft5cvblCkZUEbxNxjO6zDrA+jt5Od0UTvr4wJ6SwTrkZsgN3vjMJSgZMvKwBIiARHbnaJ9YgQxu
 KQXxiTSJnt9DQWfJZtBaf9il+mq7Dl+k0aMWOYMVBPGtYSUPVJDRKvyxLYCJrQhhYNSvrKne1Bp
 cx2jlKdjfYLiln8i/TNJYhQuxk5hthmFSbjV9pAICneJzgcMY774
X-Received: by 2002:a17:90a:d88c:b0:313:1c7b:fc62 with SMTP id
 98e67ed59e1d1-31c9e7637cemr6768792a91.22.1752712822834; 
 Wed, 16 Jul 2025 17:40:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdE3jtdynvAcuGPAv5ENe+dqxO+z5HGos0Ro1boy1+finrgFfk2v8kBSd9CI/N4AJFMVhILw==
X-Received: by 2002:a17:90a:d88c:b0:313:1c7b:fc62 with SMTP id
 98e67ed59e1d1-31c9e7637cemr6768741a91.22.1752712822383; 
 Wed, 16 Jul 2025 17:40:22 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:40:22 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:32 +0530
Subject: [PATCH v5 09/23] migration: push Error **errp into
 ram_postcopy_incoming_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-9-1f406f88ee65@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
In-Reply-To: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5012; i=armenon@redhat.com;
 h=from:subject:message-id; bh=EfcWz721HWgZSnvmLz/RL/EZn1pipgur7I4mNBwsm38=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm4LsyiuHN8Zxdm5lLmiRZFTdZ/l2G/+D4BcnfV+Jf
 j5Yprq5o5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwEQKbzAyzCqOcF0SWi100i5x
 ker2uWFz/Z/5LFDdvi6/TGpf+oOJNQz/k86d3xZdsvgR/6kNojp3j4TvyJTm57j952fngVajkht
 +vAA=
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 migration/savevm.c       | 2 +-
 5 files changed, 12 insertions(+), 9 deletions(-)

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
index d1edeaac5f2a5df2f6d94357388be807a938b2ef..8eba151a693b7f2dc58853292c92024288eae81e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1983,7 +1983,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
         return -1;
     }
 
-    if (ram_postcopy_incoming_init(mis)) {
+    if (ram_postcopy_incoming_init(mis, NULL)) {
         return -1;
     }
 

-- 
2.50.0



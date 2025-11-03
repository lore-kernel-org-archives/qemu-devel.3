Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B91BCCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lC-0000t0-4P; Mon, 03 Nov 2025 16:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lA-0000sb-KT
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1l7-00059P-DR
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762203992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HlbfcBz1rjrLqAgM/bLe8/TJucjYOTnKZj3amceTg+k=;
 b=I6+BHB0+4s3qQDm8Gz4jL+CrUrfy6tmhxwz6m5L7DQCcoXuM90Q7kPavWIId5bhwwSdpYg
 h2Fpvrc7tylFioFeSvh2kd190rklkgPmG3Ycqf98qz6axgG4rD4+cJGfnFCQItLVJp6ePf
 88XG3XWdP6ubSiG7BqIGFedx5wZ4aZ8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-QoRJrcAnNTaoCC1_iF5ORw-1; Mon, 03 Nov 2025 16:06:31 -0500
X-MC-Unique: QoRJrcAnNTaoCC1_iF5ORw-1
X-Mimecast-MFC-AGG-ID: QoRJrcAnNTaoCC1_iF5ORw_1762203991
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a9d56c36caso2242910185a.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762203990; x=1762808790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HlbfcBz1rjrLqAgM/bLe8/TJucjYOTnKZj3amceTg+k=;
 b=EA8vK6bsjK9AmCAzP+m4XMqvB2sx00LuqydP+5S4Q+tPrTUzIOIUKpSwUMOgDiiKGi
 uotMn8R1UmcQRoXnZ2foGv8lM1QJGywoMT2IDnkdC+l06I3BDN+IYn7AOhaNtsa/sZOi
 HfFMQJKucGf2P6CfarlgZ4qgu0CQ7RX5kL4yf25NH4GEioN7gmtldy2EV1mE4rLaMYpj
 +XXW1Cazp745Txz3ldEAWx2JL9yaYHGJmaqEB9FqQdlSi0ZRWnAl74DoYeAM6ZOm6t7J
 6pf59AsIbym0oOvTH/0l+hFBBxHRd5kgEH+O0hAx42towFo0G4q9BLYHViqYskwsKebF
 7yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762203990; x=1762808790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HlbfcBz1rjrLqAgM/bLe8/TJucjYOTnKZj3amceTg+k=;
 b=r+ptbFMF4fnsZ/JboTAzB5K3QjRF3CVB6TF1XXU6gzfOg5Apte4BXXetBSZLZEzKQO
 24U0pjLqLVa2+ROqpReG+xC7pQppmBr8t7eYfZieaPVOdutNVMmfwh/pOtlXNHNETStw
 8qa+0aqQU7A1SbNBfiXjGdzwSwO2poalz2nlGE4T9n9mGXtloSCxO81LKARpdiLijeTU
 sLbD8N8TzypS9HD8bmnqcdLu7jb0rLv7Q2vAQASrnKuHk5yVKIJa6PMc0OR9B7tW+FcQ
 bnpU73NDoEjue2/hoEXTgz+j96zljt5GOF3XdLl7vHjg34jI25LvsiFGDgXT/lrA3XK1
 c2lQ==
X-Gm-Message-State: AOJu0Yyz2Xpuvjqfo4xn9UtVHhk0CpGo/ZFPaTxB9ha6hoqNi/H6XNIG
 XlHibwvIm5/tscznqLIY8rm286St/lLGvILppdpOPCSO/dH2dw4sxzH8k3g6QVe0QNtobOZ4pLB
 q39mmP62zmKSeRW9xW8jYqkOjvWi99U+gBAZ9JrVDYruu0/58+CX6KyEBPns2EnON6eofntFUvL
 m5PHHN4R0VKNSGjGF4tW4WYKt/il36GytT3IA6MQ==
X-Gm-Gg: ASbGncu8rgzojc0B5XvESwMImKDAbbXRBd0HJcFq/nHbLjP7t2KbR1z3eOub8jkcQZo
 VVnqR27BWSP0PwgaR/lk5L7uTfDCn98lLdXf9Ephqb0IYLRVlTLJaLsb2kAD3VLemXrHeusuBmD
 VPJoUAnxz0J8R2JGGHk0OHXOD1CLS2JP8MhGQJaJ6XlhjyYb83Dl5v5w1zpKvgu1hbwsKAL7x+w
 oxVKWSLRgaAzebDpBu2nxJ6NXdUDLCXoHRu8ugriPp94YNojAdoVeoX3rSepZX+aqvYzz3EVNkE
 +rwRtcLfv/dpvWqqIlXkgCVShr5rFa/Wc82fwumJtC2S1CcgPKAKfLoYEAQ/nFHM
X-Received: by 2002:a05:620a:3193:b0:8a2:4d02:eeb3 with SMTP id
 af79cd13be357-8ab98eba6f4mr1528914185a.11.1762203990085; 
 Mon, 03 Nov 2025 13:06:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAi6PZSb3lH+72mA2t3DewjjKP/jqPOHNARdPJnGTlNfevW6GO/eoZ4nQQP+ac80RbqPx7hQ==
X-Received: by 2002:a05:620a:3193:b0:8a2:4d02:eeb3 with SMTP id
 af79cd13be357-8ab98eba6f4mr1528907485a.11.1762203989410; 
 Mon, 03 Nov 2025 13:06:29 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:28 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 01/36] migration/savevm: Add a compatibility check for
 capabilities
Date: Mon,  3 Nov 2025 16:05:50 -0500
Message-ID: <20251103210625.3689448-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

It has always been possible to enable arbitrary migration capabilities
and attempt to take a snapshot of the VM with the savevm/loadvm
commands as well as their QMP counterparts
snapshot-save/snapshot-load.

Most migration capabilities are not meant to be used with snapshots
and there's a risk of crashing QEMU or producing incorrect
behavior. Ideally, every migration capability would either be
implemented for savevm or explicitly rejected.

Add a compatibility check routine and reject the snapshot command if
an incompatible capability is enabled. For now only act on the the two
that actually cause a crash: multifd and mapped-ram.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2881
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251007184213.5990-1-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.h |  1 +
 migration/options.c | 27 +++++++++++++++++++++++++++
 migration/savevm.c  |  8 ++++++++
 3 files changed, 36 insertions(+)

diff --git a/migration/options.h b/migration/options.h
index 82d839709e..a7b3262d1e 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -59,6 +59,7 @@ bool migrate_tls(void);
 
 bool migrate_rdma_caps_check(bool *caps, Error **errp);
 bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp);
+bool migrate_can_snapshot(Error **errp);
 
 /* parameters */
 
diff --git a/migration/options.c b/migration/options.c
index 5183112775..d9227809d7 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -445,11 +445,38 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_background_snapshot,
     MIGRATION_CAPABILITY_VALIDATE_UUID,
     MIGRATION_CAPABILITY_ZERO_COPY_SEND);
 
+/* Snapshot compatibility check list */
+static const
+INITIALIZE_MIGRATE_CAPS_SET(check_caps_savevm,
+                            MIGRATION_CAPABILITY_MULTIFD,
+                            MIGRATION_CAPABILITY_MAPPED_RAM,
+);
+
 static bool migrate_incoming_started(void)
 {
     return !!migration_incoming_get_current()->transport_data;
 }
 
+bool migrate_can_snapshot(Error **errp)
+{
+    MigrationState *s = migrate_get_current();
+    int i;
+
+    for (i = 0; i < check_caps_savevm.size; i++) {
+        int incomp_cap = check_caps_savevm.caps[i];
+
+        if (s->capabilities[incomp_cap]) {
+            error_setg(errp,
+                       "Snapshots are not compatible with %s",
+                       MigrationCapability_str(incomp_cap));
+            return false;
+        }
+    }
+
+    return true;
+}
+
+
 bool migrate_rdma_caps_check(bool *caps, Error **errp)
 {
     if (caps[MIGRATION_CAPABILITY_XBZRLE]) {
diff --git a/migration/savevm.c b/migration/savevm.c
index 7b35ec4dd0..aafa40d779 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3322,6 +3322,10 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
 
     GLOBAL_STATE_CODE();
 
+    if (!migrate_can_snapshot(errp)) {
+        return false;
+    }
+
     if (migration_is_blocked(errp)) {
         return false;
     }
@@ -3507,6 +3511,10 @@ bool load_snapshot(const char *name, const char *vmstate,
     int ret;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
+    if (!migrate_can_snapshot(errp)) {
+        return false;
+    }
+
     if (!bdrv_all_can_snapshot(has_devices, devices, errp)) {
         return false;
     }
-- 
2.50.1



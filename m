Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E782AE6F090
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Py-0002Po-83; Tue, 23 Dec 2025 09:31:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PP-0001Jx-TX
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PH-0003o2-Vr
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VrUtnHfZ+2Rr8s/jaxbMJK+CYiAFQapL4Ex3k09w4fg=;
 b=a2awF837YPVn8jgpj2PQ1LZ6mBtkl8NPpieFppnU9bTV2q6nDWJVUG9YYOUkkLggOavoId
 k737IgvSx9jhlFCb0wrhh+kUc11++GFyAgZv0THvpsuL1yWW/0DFtgHA8hAIK7OW+tXDrM
 cT9NOX4wDtXgYQ4/64Dx3LnK00IuaO0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-M-U7SbaqMSOI4wFoe7Jfdg-1; Tue, 23 Dec 2025 09:30:30 -0500
X-MC-Unique: M-U7SbaqMSOI4wFoe7Jfdg-1
X-Mimecast-MFC-AGG-ID: M-U7SbaqMSOI4wFoe7Jfdg_1766500230
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8bb0ae16a63so565656285a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500230; x=1767105030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VrUtnHfZ+2Rr8s/jaxbMJK+CYiAFQapL4Ex3k09w4fg=;
 b=imE84Muv7yAe27CvOSaL8jIeYZJ7c1KxgSqqyVCEzzqsmusnnHsu2UfpfkDwGtxVJx
 tc5dpj4lfZLHWul10RvuyLz6u52wAMt1NX9+z1ImFjLhJR3KMMh4RkQzZwb1mp9u20hY
 mpKH0klB9phFtby9GBCP879rBQWgQpXsa7mEGHUeuiU31eof+WQuu+qhAqwm6c4SclON
 CtXMCn0KpxWBNmHDgfPBzpqoGhYZHBFsqjh7qZ1m8QEndKJEOMwa1GFS2hVvTetRLgyr
 VK05WOyo+mEJsl4AGRpJFMF4nTdNIT+sl2nx8hmuMWLhzrumRkH+z0avRiEHQMBQIVhs
 9zbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500230; x=1767105030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VrUtnHfZ+2Rr8s/jaxbMJK+CYiAFQapL4Ex3k09w4fg=;
 b=HqaoF7rpuhF7yfY92iTIQeTFukkfyNh9giPENewzHbWhbobWFpMA0XvMIzx8yELl7y
 FbxhsTOJzzrkdzvW7bU7HgA4bK3MMIlqw+VZ/kPzQNyTRWSSW7gA7UpLNF+9fIlPDIW7
 2kGGhi2gtsTa/qVrwZ49VKBvqKylS3CYCYFDAIdP7aOEDPuajCYIal2ltsUSK9PjnGxV
 mDrj+Pb8Zo5RJkixiVO3dLjfLzO5/xijFVwK6EBhvesA5QwbU0Frll6Cq+wJKbVy6cB6
 MUOPMRc3QVRxAy/9dPKxAlrRSctcTLhRRQmUSX4u4nUtw2ElS2Upuyjdv4wRL2NnwvAR
 Bv0Q==
X-Gm-Message-State: AOJu0YxAdC83jKdsuYeTqzqgw1tBz+jFrJ8bY74UauAMdzhx91wuJn4w
 K1SzKvIHRoILYflWRBsOm0xomXj3jruQ038Hx1qoAB1XXB9/S2O1ijQ8BKzE3+e7InHfkb7T8MR
 vfpHILzPNEReXoB6D1Ioa+jL65gHh1Y7/HfFDaYDvebAdxnoVX18N8IGUi9Sb8sAjIPiO5597OO
 +V1sJlFyO5w/Th6oSEh4VkR9ySTg+cGUbN3yunJw==
X-Gm-Gg: AY/fxX4zfFsGPcfR1qV7zM7nWMmVlKMM8V0Srl+YLIlrh7dDfogzrTsRNCxqO69pkbA
 8i7zzn8qPTdR+mONyDYQhaYysUoEUPCi0NvuWDe0upLIbZYsVLz8I2WaGl4J6eYOWimtnQqLnxk
 nlF4P6iqCpA5AIJIXyquzm0SZt8ozDct8ocfprzBmiWLH2wAD4H4VxurszNrE4OAcS9Jrl41zFX
 QX/InVrXicdvHMEmkAN2RAqSzrgFmmjzSDHPMzgJasQe+59rMK4hn1dRaZFq638Qe+5ExyEBBdU
 VbCJiqA6tPyUDtDiXG+lSW6LaexMzzKAR1othKrYDDng1pSvoGFBiHpuo0NkJg1vn25ahlvos2e
 G4B0=
X-Received: by 2002:a05:620a:4623:b0:8b2:db27:425b with SMTP id
 af79cd13be357-8c09001917bmr2202458785a.74.1766500229601; 
 Tue, 23 Dec 2025 06:30:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyZM/lqXXdAybYDoRiYNwYZ3m0+PNFkLIfesroNnhNllG70PiWbU8lt8g09kdd5rEm1kwdFw==
X-Received: by 2002:a05:620a:4623:b0:8b2:db27:425b with SMTP id
 af79cd13be357-8c09001917bmr2202447785a.74.1766500228899; 
 Tue, 23 Dec 2025 06:30:28 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:28 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 22/31] migration: Run a post update routine after setting
 parameters
Date: Tue, 23 Dec 2025 09:29:50 -0500
Message-ID: <20251223142959.1460293-23-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

Some migration parameters are updated immediately once they are set
via migrate-set-parameters. Move that work outside of
migrate_params_apply() and leave that function with the single
responsibility of setting s->parameters and not doing any
side-effects.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251215220041.12657-9-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 38 ++++++++++++++++++++++++++++----------
 migration/ram.c     |  2 +-
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index b17347e43b..cb127e9c72 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1125,6 +1125,31 @@ void migrate_params_init(MigrationParameters *params)
     params->has_cpr_exec_command = true;
 }
 
+static void migrate_post_update_params(MigrationParameters *new, Error **errp)
+{
+    MigrationState *s = migrate_get_current();
+
+    if (new->has_max_bandwidth) {
+        if (s->to_dst_file && !migration_in_postcopy()) {
+            migration_rate_set(new->max_bandwidth);
+        }
+    }
+
+    if (new->has_x_checkpoint_delay) {
+        colo_checkpoint_delay_set();
+    }
+
+    if (new->has_xbzrle_cache_size) {
+        xbzrle_cache_resize(new->xbzrle_cache_size, errp);
+    }
+
+    if (new->has_max_postcopy_bandwidth) {
+        if (s->to_dst_file && migration_in_postcopy()) {
+            migration_rate_set(new->max_postcopy_bandwidth);
+        }
+    }
+}
+
 /*
  * Check whether the parameters are valid. Error will be put into errp
  * (if provided). Return true if valid, otherwise false.
@@ -1439,7 +1464,7 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 }
 
-static void migrate_params_apply(MigrationParameters *params, Error **errp)
+static void migrate_params_apply(MigrationParameters *params)
 {
     MigrationState *s = migrate_get_current();
 
@@ -1479,9 +1504,6 @@ static void migrate_params_apply(MigrationParameters *params, Error **errp)
 
     if (params->has_max_bandwidth) {
         s->parameters.max_bandwidth = params->max_bandwidth;
-        if (s->to_dst_file && !migration_in_postcopy()) {
-            migration_rate_set(s->parameters.max_bandwidth);
-        }
     }
 
     if (params->has_avail_switchover_bandwidth) {
@@ -1494,7 +1516,6 @@ static void migrate_params_apply(MigrationParameters *params, Error **errp)
 
     if (params->has_x_checkpoint_delay) {
         s->parameters.x_checkpoint_delay = params->x_checkpoint_delay;
-        colo_checkpoint_delay_set();
     }
 
     if (params->has_multifd_channels) {
@@ -1514,13 +1535,9 @@ static void migrate_params_apply(MigrationParameters *params, Error **errp)
     }
     if (params->has_xbzrle_cache_size) {
         s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
-        xbzrle_cache_resize(params->xbzrle_cache_size, errp);
     }
     if (params->has_max_postcopy_bandwidth) {
         s->parameters.max_postcopy_bandwidth = params->max_postcopy_bandwidth;
-        if (s->to_dst_file && migration_in_postcopy()) {
-            migration_rate_set(s->parameters.max_postcopy_bandwidth);
-        }
     }
     if (params->has_max_cpu_throttle) {
         s->parameters.max_cpu_throttle = params->max_cpu_throttle;
@@ -1594,7 +1611,8 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     migrate_params_test_apply(params, &tmp);
 
     if (migrate_params_check(&tmp, errp)) {
-        migrate_params_apply(params, errp);
+        migrate_params_apply(params);
+        migrate_post_update_params(params, errp);
     }
 
     migrate_tls_opts_free(&tmp);
diff --git a/migration/ram.c b/migration/ram.c
index ecd81601e2..18e4e26eaf 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -176,7 +176,7 @@ static void XBZRLE_cache_unlock(void)
 /**
  * xbzrle_cache_resize: resize the xbzrle cache
  *
- * This function is called from migrate_params_apply in main
+ * This function is called from migrate_post_update_params in main
  * thread, possibly while a migration is in progress.  A running
  * migration may be using the cache and might finish during this call,
  * hence changes to the cache are protected by XBZRLE.lock().
-- 
2.50.1



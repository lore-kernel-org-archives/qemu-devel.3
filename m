Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4799D6CFAB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 23:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj3iM-0004z6-Pm; Thu, 22 Jan 2026 18:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vj3iK-0004xx-VB
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 18:03:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vj3iJ-0007Vm-As
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 18:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769123022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDiedGlQr/KQRJYDxCSC/2kq29zJ5agXHeHdCKxHIMw=;
 b=AL3L4WbafSlk5v8+QLGn5FbCUgpXXyfDqtYfWcE+YQs3w/CzOxFlrWQrCzln77fbFdXAD9
 mjZkHISZRnm9GMq3pCcu7V4lRNJdvskxRp8Aox+ME1lv1HJRloRNW1uRojSvdZEE4/xH/F
 VaJRniwx+QYNRjeVNEay9pcCmddnNoc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-N2QfMRgcPAOw3uWylK4rUg-1; Thu, 22 Jan 2026 18:03:40 -0500
X-MC-Unique: N2QfMRgcPAOw3uWylK4rUg-1
X-Mimecast-MFC-AGG-ID: N2QfMRgcPAOw3uWylK4rUg_1769123020
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c52fd47227so250002285a.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 15:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769123019; x=1769727819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDiedGlQr/KQRJYDxCSC/2kq29zJ5agXHeHdCKxHIMw=;
 b=l0CxvEcWYqpY2ht7W62nlbtVJ0TCrDRe1e9s/Q2LVmYCTwGt+NYbbgp241KLq9D9RD
 WJ8UXKKzHpHecQq4aRcY1t0rCw6MIY+fyUlC5fano9ZxZFMCcSTKvYMv2O75HiBtxxKo
 u2xaMRRe08zLw6pdsCdIbrg/XbuBWE7H4L4+2knYYFhMRNinj4yVdm3YgyI+xAZn0C5N
 0+LLjMf3lLynY19Umo4v2mXMegou9vdp/C2E9iszCRVOWnHRNmqJg9ylVhtMzriJsIyJ
 lQoQSa7lXOSm1IdjDk0+b/5KXbhnsXZGuoNcqXZhcHbOF8Ln5DuNjrXwxu4AJAiFMN03
 Q1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769123019; x=1769727819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pDiedGlQr/KQRJYDxCSC/2kq29zJ5agXHeHdCKxHIMw=;
 b=tAWL3wLLwSQ1aVstB0xinufKPaKS997ktJSWRH+AoN+kF7qwhq4Z+U8D5z5GAHAmIg
 uIYOn+Y1HsTkbnKvOOIHCIIIKfPiU5mq38g82gvnYJXdxcVSNnoRVjaBbbk01DFH8j0e
 /OcDCz0rr7UWPZZLvSLnt+8GnkEbOJCFM8EgdMeIlrAUnToro82rlbaCO2+PPkznOcIW
 SGV8gaawYfFeGhQ3VdLQ0+81KBzZBvdJo9feAOfYUaOIE1fLrjhrAHRB6+1QJi7BesQP
 GJH0bQHcxRIEFDWofNOh5mO44YtmnHBCRgsdgtdDhJEgutJeUA7BdcEds56ZFqJu48Lq
 h8Rg==
X-Gm-Message-State: AOJu0YzDLI7mm4BzLjlDBLxr7WrlBFtX/MWe0el90OtLq2HVmn+XKlFI
 KmvXdpoEdf9xUO6CpV9wHHCc6is6xyiwGE6U33aHnPQpDG9xNr88nEt8hFFOvmefGO60WE8V6QM
 LVrKEnP0w8OsEcbbtJSJUccpbjzK74Z/rPpAJqGTKuBSWewEbXGXFWjtF7DNNjCigMC7cHyDp7h
 9gWYLxyt0GWtUfr3DHwwKSt/3Nk4XbOFmoreCSPA==
X-Gm-Gg: AZuq6aK9cVqZ86X6x1S62UHMFa26imov2o6pg+Jkb0yGu0KHntVVChtP4lX7S7OR0ZT
 oRgOajYHN4N0IUWUERYmprG7P0/1TMg73wx5Z+0I+Jq7UZDfW9gp/bB0DcMaWzEA38EszF2cX3l
 1PXlvMjbw11orWqIanqwmYsWFRCMrQvcH64l13FKrXtbdHorbK4ZN56PLqstLWPN8/EtPK+sRFB
 4Tzvybe80itw4dm8MMZT+JdbBEN4fJHCcinM1I1CXKbxhELhvUExsR/RW/rYkx0+nBYHBOO6BcD
 g8ssbElJdoU4OEPFpL44vyGBHaRCiBGF5iKXvu733tY4AeOKTzkABfX2qcMRcuGZSBvfbsvS2Zv
 r
X-Received: by 2002:a05:620a:45a4:b0:8c2:e8b3:7c3a with SMTP id
 af79cd13be357-8c6e2e5ced7mr148903885a.87.1769123019404; 
 Thu, 22 Jan 2026 15:03:39 -0800 (PST)
X-Received: by 2002:a05:620a:45a4:b0:8c2:e8b3:7c3a with SMTP id
 af79cd13be357-8c6e2e5ced7mr148898385a.87.1769123018730; 
 Thu, 22 Jan 2026 15:03:38 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e37d2a56sm41032785a.20.2026.01.22.15.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 15:03:37 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 3/5] migration: Notify migration FAILED before starting VM
Date: Thu, 22 Jan 2026 18:03:29 -0500
Message-ID: <20260122230331.3543312-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260122230331.3543312-1-peterx@redhat.com>
References: <20260122230331.3543312-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Devices may opt-in migration FAILED notifiers to be invoked when migration
fails.  Currently, the notifications happen in migration_cleanup().  It is
normally fine, but maybe not ideal if there's dependency of the fallback
v.s. VM starts.

This patch moves the FAILED notification earlier, so that if the failure
happened during switchover, it'll notify before VM restart.

After walking over all existing FAILED notifier users, I got the conclusion
that this should also be a cleaner approach at least from design POV.

We have these notifier users, where the first two do not need to trap
FAILED:

|----------------------------+-------------------------------------+---------------------|
| device                     | handler                             | events needed       |
|----------------------------+-------------------------------------+---------------------|
| gicv3                      | kvm_arm_gicv3_notifier              | DONE                |
| vfio_iommufd / vfio_legacy | vfio_cpr_reboot_notifier            | SETUP               |
| cpr-exec                   | cpr_exec_notifier                   | FAILED, DONE        |
| virtio-net                 | virtio_net_migration_state_notifier | SETUP, FAILED       |
| vfio                       | vfio_migration_state_notifier       | FAILED              |
| vdpa                       | vdpa_net_migration_state_notifier   | SETUP, FAILED       |
| spice [*]                  | migration_state_notifier            | SETUP, FAILED, DONE |
|----------------------------+-------------------------------------+---------------------|

For cpr-exec, it tries to cleanup some cpr-exec specific fd or env
variables.  This should be fine either way, as long as before
migration_cleanup().

For virtio-net, we need to re-plug the primary device back to guest in the
failover mode.  Likely benign.

VFIO needs to re-start the device if FAILED.  IIUC it should do it before
vm_start(), if the VFIO device can be put into a STOPed state due to
migration, we should logically make it running again before vCPUs run.

VDPA will disable SVQ when migration is FAILED.  Likely benign too, but
looks better if we can do it before resuming vCPUs.

For spice, we should rely on "spice_server_migrate_end(false)" to retake
the ownership.  Benign, but looks more reasonable if the spice client does
it before VM runs again.

Note that this change may introduce slightly more downtime, if the
migration failed exactly at the switchover phase.  But that's very rare,
and even if it happens, none of above expects a long delay, but a short
one, likely will be buried in the total downtime even if failed.

Cc: Cédric Le Goater <clg@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 91775f8472..1d9a2fc068 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1481,7 +1481,6 @@ static void migration_cleanup_json_writer(MigrationState *s)
 
 static void migration_cleanup(MigrationState *s)
 {
-    MigrationEventType type;
     QEMUFile *tmp = NULL;
 
     trace_migration_cleanup();
@@ -1535,9 +1534,15 @@ static void migration_cleanup(MigrationState *s)
         /* It is used on info migrate.  We can't free it */
         error_report_err(error_copy(s->error));
     }
-    type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
-                                     MIG_EVENT_PRECOPY_DONE;
-    migration_call_notifiers(s, type, NULL);
+
+    /*
+     * FAILED notification should have already happened.  Notify DONE if
+     * migration completed successfully.
+     */
+    if (!migration_has_failed(s)) {
+        migration_call_notifiers(s, MIG_EVENT_PRECOPY_DONE, NULL);
+    }
+
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
@@ -3589,6 +3594,13 @@ static void migration_iteration_finish(MigrationState *s)
             error_free(local_err);
             break;
         }
+
+        /*
+         * Notify FAILED before starting VM, so that devices can invoke
+         * necessary fallbacks before vCPUs run again.
+         */
+        migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
+
         if (runstate_is_live(s->vm_old_state)) {
             if (!runstate_check(RUN_STATE_SHUTDOWN)) {
                 vm_start();
-- 
2.50.1



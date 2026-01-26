Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07884D1951A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 21:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUG8-0003pe-3F; Mon, 26 Jan 2026 16:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkUG4-0003k9-OS
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkUG3-0003MH-6n
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769463386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cRHZgxbr0wPoDbo/Jl1zs6PXyi4flpY3KByUtN/i888=;
 b=jUlmjqVCneoPPxOiePNpYOt8x+ZVTldS24wlr77gPCTTx8BV9bAWXbpwnQlztFqcQ514kn
 aPDhSqcifByn1+rJSODk/gHSZOifC7pt92oUVQuem0kYQS5sP6Xi8981civniNT5dJGc1A
 nzq8KmWum2whxZtbk20MzB+rzC2iX84=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-ihSK-VXmOgGY5ZrFTtINcA-1; Mon, 26 Jan 2026 16:36:23 -0500
X-MC-Unique: ihSK-VXmOgGY5ZrFTtINcA-1
X-Mimecast-MFC-AGG-ID: ihSK-VXmOgGY5ZrFTtINcA_1769463383
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5013c19b92dso145539651cf.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 13:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769463383; x=1770068183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRHZgxbr0wPoDbo/Jl1zs6PXyi4flpY3KByUtN/i888=;
 b=Txrek7Na3HuoF0IVXMxMNHhQwaClW0PuaMZ4vldqT5G9YpwZq/6UFV6FWHjV9TSdSL
 8EV3KJuqKLenwEUCAYw/mWiuEQj7qzvc0QKD+KmJiY7G/1FmnY46s2xApOebL/zhGjHo
 1RYEwR7WvCB4iEYdPOJwwAq+kUtoH3JSU0kptkGSqwtSyFp9CA9vD2dYENt4Ds5teGKr
 Q0edgSr1qbpTptOG7dNjbAH0neAL8X897C+QHB/EQ72A+EesGGYjiI34H5zSmA3Dtglo
 ilL9j2BVODNkgtl8bZXOtlv9jkeZaSJWNHHZ0rNwGn/nOubvF9fbrbIzJbq2mkp07MvH
 RMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769463383; x=1770068183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cRHZgxbr0wPoDbo/Jl1zs6PXyi4flpY3KByUtN/i888=;
 b=XIe6OLTIUKG7g1P9ui245rM3VpH/aQV21t/oNaQBqKXyHeiT8REPL0LtGIPqN1Troe
 2+sNhDd0v2ubD26w/8I/0/ryziZM4g+TAefeprpEP//PRqEPZN383KA2i803K9wsWs7r
 OPKlgncgFwHU25wUsTo2b8HqeqUPi4sGGgcY4yerC9iCUjzmc90MMAV/OOglCIb1UbOj
 5UJQe4ZO54/YIK6inhzu5YoDNZvJObD/QfA9Io9OXLLMK7CTIaPcaoXpioEeLzAG1ffg
 ZpvHjPQzFUXWzczfDWMjhBDCt3fS4EWdrO8zPWwv6IGWgQre1S83IRv012w9sS+c/8J2
 F7Uw==
X-Gm-Message-State: AOJu0YyO3tB2xGigS5+NC2QnrWVrXx1c/o/eR94vqRXVyXXGi2q3IUDa
 xOWyGSx1VjVqWgbF7bf49Ak3BC48spOH/+eHR/4f0dHpBxlhU9KuHL745nmqSaMDLO7RX/7OtWI
 lyCKk8cqOJZrZaEq7y0xgjIBAnAGYlAMu0SBSMHLulGWI4oHpydt6QZQzuBsLInAieba2ZOTeYt
 sTllgfZzUjB9CRIpE/k/j3a6DHExG6vF6IRtGNcQ==
X-Gm-Gg: AZuq6aItzkhPBjnGta2jTVaL1kf/KJMbFuDneh3+Whhd1qhZ9urFSxHklVnnA3suLcm
 ACADISAtaWOEULcHHHD3cnLPuIiYrRxj3YF66xwApA5fTz6L/Zd6AtceDrsbIdsB2binr6+JVRF
 4tjBK+MSp/SVTBc2XBZcqZBNaIoKZhtuIZR1XGYgghcRCvr6+7xuc3KqaAibiQAONEi7e+eS57q
 ZoXO4puOGEP7hYgfF7MYTOox+6Oiy+Kg1xrGzFPuNaiBpUKnrVDvr5ohY/xq8rLFW/yKdQdIwfZ
 DO+rlzUoI4yUcwBm8EQCA//OX4sF/oNRRgUWYkrrtRhIxmVN5iwmzTOzPKykkNpNfwtfiejCYPb
 o
X-Received: by 2002:a05:622a:107:b0:501:489d:f405 with SMTP id
 d75a77b69052e-50314bcfbd2mr65576181cf.30.1769463382718; 
 Mon, 26 Jan 2026 13:36:22 -0800 (PST)
X-Received: by 2002:a05:622a:107:b0:501:489d:f405 with SMTP id
 d75a77b69052e-50314bcfbd2mr65575911cf.30.1769463382127; 
 Mon, 26 Jan 2026 13:36:22 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502f7f9cd9esm89769281cf.33.2026.01.26.13.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:36:21 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 3/5] migration: Notify migration FAILED before starting VM
Date: Mon, 26 Jan 2026 16:36:12 -0500
Message-ID: <20260126213614.3815900-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260126213614.3815900-1-peterx@redhat.com>
References: <20260126213614.3815900-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index bd24006c1a..8d1c294b47 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1283,7 +1283,6 @@ static void migration_cleanup_json_writer(MigrationState *s)
 
 static void migration_cleanup(MigrationState *s)
 {
-    MigrationEventType type;
     QEMUFile *tmp = NULL;
 
     trace_migration_cleanup();
@@ -1333,9 +1332,14 @@ static void migration_cleanup(MigrationState *s)
                           MIGRATION_STATUS_CANCELLED);
     }
 
-    type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
-                                     MIG_EVENT_PRECOPY_DONE;
-    migration_call_notifiers(type, NULL);
+    /*
+     * FAILED notification should have already happened.  Notify DONE if
+     * migration completed successfully.
+     */
+    if (!migration_has_failed(s)) {
+        migration_call_notifiers(MIG_EVENT_PRECOPY_DONE, NULL);
+    }
+
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
@@ -3323,6 +3327,13 @@ static void migration_iteration_finish(MigrationState *s)
             error_free(local_err);
             break;
         }
+
+        /*
+         * Notify FAILED before starting VM, so that devices can invoke
+         * necessary fallbacks before vCPUs run again.
+         */
+        migration_call_notifiers(MIG_EVENT_PRECOPY_FAILED, NULL);
+
         if (runstate_is_live(s->vm_old_state)) {
             if (!runstate_check(RUN_STATE_SHUTDOWN)) {
                 vm_start();
-- 
2.50.1



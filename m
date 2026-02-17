Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B964CE909CF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNkX-00044q-2j; Tue, 17 Feb 2026 11:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNkV-00044J-Lt
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:31 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNkT-0003H1-Jx
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:31 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 754EF5BCF4;
 Tue, 17 Feb 2026 16:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DtTv1je5CyqSvnbsAfVhoJ21iD/5ZKXGp6EmA4yPnGc=;
 b=Cob0VPCgNur3JlqPV4hLs7A3rBLJ33T8tdKsia2BvNMj0yBGMAUudtb4K4Vt8sG5e/VJ7M
 y8YGrkJ5G7BQSnxVmCfBhtoSy/i5trDodU8a0LIQcsqNiIyULV97Dl4yYX4lPqaIxSjYMX
 Af1Mh4wD821G1sujjW2WptJTzBoJeFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DtTv1je5CyqSvnbsAfVhoJ21iD/5ZKXGp6EmA4yPnGc=;
 b=Mt65+UdgTIIQSTo5OTsALSahj19I0boXTrFhIJZ0kvBhcsE7PcgxyXq7kr+iexe6MBeDZT
 GOQR6+PyJUuF/MBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DtTv1je5CyqSvnbsAfVhoJ21iD/5ZKXGp6EmA4yPnGc=;
 b=Cob0VPCgNur3JlqPV4hLs7A3rBLJ33T8tdKsia2BvNMj0yBGMAUudtb4K4Vt8sG5e/VJ7M
 y8YGrkJ5G7BQSnxVmCfBhtoSy/i5trDodU8a0LIQcsqNiIyULV97Dl4yYX4lPqaIxSjYMX
 Af1Mh4wD821G1sujjW2WptJTzBoJeFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DtTv1je5CyqSvnbsAfVhoJ21iD/5ZKXGp6EmA4yPnGc=;
 b=Mt65+UdgTIIQSTo5OTsALSahj19I0boXTrFhIJZ0kvBhcsE7PcgxyXq7kr+iexe6MBeDZT
 GOQR6+PyJUuF/MBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF2D63EA66;
 Tue, 17 Feb 2026 16:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2K2pICmUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Paul Durrant <paul@xen.org>, Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 30/32] migration/colo/xen: Use generic helpers in
 qemu_save_device_state()
Date: Tue, 17 Feb 2026 13:14:41 -0300
Message-ID: <20260217161443.12738-31-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,infradead.org:email];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,infradead.org,xen.org,web.de];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Use qemu_savevm_state_non_iterable*() helpers for saving device states,
rather than walking the vmstate handlers on its own.

Non-iterables can be either early_setup devices, or otherwise.

Note that QEMU only has one early_setup device currently, which is
virtio-mem, and I highly doubt if it is used in either COLO or Xen users..
However this step is still better needed to provide full coverage of all
non-iterable vmstates.

When at it, allow it to report errors.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-25-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/colo.c   |  2 +-
 migration/savevm.c | 30 +++++++++++++++---------------
 migration/savevm.h |  3 +--
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index db804b25a9..f7a5bd3619 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -454,7 +454,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     }
 
     /* Note: device state is saved into buffer */
-    ret = qemu_save_device_state(fb);
+    ret = qemu_save_device_state(fb, &local_err);
 
     bql_unlock();
     if (ret < 0) {
diff --git a/migration/savevm.c b/migration/savevm.c
index b29272db3b..3a16c467b2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1887,26 +1887,24 @@ static bool qemu_savevm_se_iterable(SaveStateEntry *se)
     return se->ops && se->ops->save_setup;
 }
 
-int qemu_save_device_state(QEMUFile *f)
+int qemu_save_device_state(QEMUFile *f, Error **errp)
 {
-    Error *local_err = NULL;
-    SaveStateEntry *se;
+    int ret;
 
-    cpu_synchronize_all_states();
+    /* Both COLO and Xen never use vmdesc, hence NULL. */
+    ret = qemu_savevm_state_non_iterable_early(f, NULL, errp);
+    if (ret) {
+        return ret;
+    }
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        int ret;
-
-        ret = vmstate_save(f, se, NULL, &local_err);
-        if (ret) {
-            error_report_err(local_err);
-            return ret;
-        }
+    ret = qemu_savevm_state_non_iterable(f, errp);
+    if (ret) {
+        return ret;
     }
 
     qemu_savevm_state_end(f);
 
-    return qemu_file_get_error(f);
+    return 0;
 }
 
 static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id)
@@ -3346,9 +3344,11 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
     f = qemu_file_new_output(QIO_CHANNEL(ioc));
     object_unref(OBJECT(ioc));
     qemu_savevm_send_header(f);
-    ret = qemu_save_device_state(f);
+    ret = qemu_save_device_state(f, errp);
     if (ret < 0 || qemu_fclose(f) < 0) {
-        error_setg(errp, "saving Xen device state failed");
+        if (*errp == NULL) {
+            error_setg(errp, "saving Xen device state failed");
+        }
     } else {
         /* libxl calls the QMP command "stop" before calling
          * "xen-save-devices-state" and in case of migration failure, libxl
diff --git a/migration/savevm.h b/migration/savevm.h
index 6a589b2990..2ba0881f3b 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -66,8 +66,7 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
                                            uint64_t *start_list,
                                            uint64_t *length_list);
 void qemu_savevm_send_colo_enable(QEMUFile *f);
-int qemu_save_device_state(QEMUFile *f);
-
+int qemu_save_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
-- 
2.51.0



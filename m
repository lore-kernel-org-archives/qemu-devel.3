Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AE7C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 21:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXRfw-0004nF-PF; Mon, 13 Jan 2025 16:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tXRft-0004mb-G5
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 16:08:41 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tXRfr-0003BG-G7
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 16:08:41 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67F3921180;
 Mon, 13 Jan 2025 21:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736802517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Wk6yUGyvVCUz+SFD4+WOhGpbMQ7549oE/R4Y6MGm0Jc=;
 b=NM/sNDROTbTTcvCL75JBQC/C/1XnYpsR6ooLroALFn8lTQwxOBaujcl9voPoLtCKWg2diR
 c6dzfQa5L7E5yUBsBLgTOcAcbIgQpNnt1/fyKUEfg60ZeIa4A1vxD4/PVSzVlHg8UGPaFb
 etLC47mhmW/YabotcWEPfOe0JMtsZt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736802517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Wk6yUGyvVCUz+SFD4+WOhGpbMQ7549oE/R4Y6MGm0Jc=;
 b=HU3NqyUDNKjBsu8abopx3vp8Gz7vMrtQo9QqKD/XaUxLa4dyG9H6I2YL4UQzasmeJib8Ox
 tWg3h+a5WS26oiCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736802517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Wk6yUGyvVCUz+SFD4+WOhGpbMQ7549oE/R4Y6MGm0Jc=;
 b=NM/sNDROTbTTcvCL75JBQC/C/1XnYpsR6ooLroALFn8lTQwxOBaujcl9voPoLtCKWg2diR
 c6dzfQa5L7E5yUBsBLgTOcAcbIgQpNnt1/fyKUEfg60ZeIa4A1vxD4/PVSzVlHg8UGPaFb
 etLC47mhmW/YabotcWEPfOe0JMtsZt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736802517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Wk6yUGyvVCUz+SFD4+WOhGpbMQ7549oE/R4Y6MGm0Jc=;
 b=HU3NqyUDNKjBsu8abopx3vp8Gz7vMrtQo9QqKD/XaUxLa4dyG9H6I2YL4UQzasmeJib8Ox
 tWg3h+a5WS26oiCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFEEC13876;
 Mon, 13 Jan 2025 21:08:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nr2TLNOAhWcVNQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 13 Jan 2025 21:08:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC PATCH] tests/qtest/migration: Add cpu hotplug test
Date: Mon, 13 Jan 2025 18:08:33 -0300
Message-Id: <20250113210833.1712-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Bug #2594 is about a failure during migration after a cpu hotplug. Add
a test that covers that scenario. Start the source with -smp 2 and
destination with -smp 3, plug one extra cpu to match and migrate.

The issue seems to be a mismatch in the number of virtqueues between
the source and destination due to the hotplug not changing the
num_queues:

  get_pci_config_device: Bad config data: i=0x9a read: 4 device: 5
  cmask: ff wmask: 0 w1cmask:0

Usage:
$ QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_BINARY=./qemu-system-x86_64 \
  ./tests/qtest/migration-test -p /x86_64/migration/hotplug/cpu

References: https://gitlab.com/qemu-project/qemu/-/issues/2594
References: https://issues.redhat.com/browse/RHEL-68302
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
As you can see there's no fix attached to this. I haven't reached that
part yet, suggestions welcome =). Posting the test case if anyone
wants to play with this.

(if someone at RH is already working on this, that's fine. I'm just
trying to get some upstream bugs to move)
---
 tests/qtest/migration/misc-tests.c | 76 ++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 6173430748..bde567b124 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -251,6 +251,79 @@ static void test_validate_uri_channels_none_set(void)
     do_test_validate_uri_channel(&args);
 }
 
+static void test_cpu_hotplug_virtqueues(void)
+{
+    MigrateStart args = {
+        .hide_stderr = false,
+    };
+    QTestState *from, *to;
+    g_autofree char *device_virtio_scsi = NULL;
+    g_autofree char *device_virtio_blk = NULL;
+    g_autofree char *filename_scsi = g_strdup_printf("%s/qtest_disk0.qcow2", tmpfs);
+    g_autofree char *filename_blk = g_strdup_printf("%s/qtest_disk1.qcow2", tmpfs);
+
+    /*
+     * Matching the queues between src/dst allows the test to pass.
+     * Defaults are:
+     *   virtio-scsi-pci:   #vcpus + 2 queues that are always present.
+     *   virtio-blk-pci:    same number of queues as vcpus.
+     * See virtio_pci_optimal_num_queues() for the exact computation.
+     */
+    bool match_queues = false;
+    const char *qs_scsi = "num_queues=5";
+    const char *qs_blk = "num-queues=3"; /* _ vs. - is not a mistake */
+
+    g_assert(mkimg(filename_scsi, "qcow2", 1));
+    g_assert(mkimg(filename_blk, "qcow2", 1));
+
+    device_virtio_scsi = g_strdup_printf(
+        "-drive id=drive0,if=none,format=qcow2,file=%s "
+        "-device virtio-scsi-pci,id=scsi0,%s "
+        "-device scsi-hd,drive=drive0,bus=scsi0.0 ",
+        filename_scsi, match_queues ? qs_scsi : "");
+
+    device_virtio_blk = g_strdup_printf(
+        "-drive id=drive1,if=none,format=qcow2,file=%s "
+        "-device virtio-blk-pci,drive=drive1,id=blk0,%s ",
+        filename_blk, match_queues ? qs_blk : "");
+
+    /* The missing cpu will be hotplugged before migration */
+    args.opts_source = g_strconcat("-smp 2,threads=1,sockets=1,maxcpus=4 ",
+                                   device_virtio_scsi,
+                                   device_virtio_blk, NULL);
+
+    args.opts_target = g_strconcat("-smp 3,threads=1,sockets=1,maxcpus=4 ",
+                                   device_virtio_scsi,
+                                   device_virtio_blk, NULL);
+
+    if (migrate_start(&from, &to, "defer", &args)) {
+        return;
+    }
+
+    g_free((char *)args.opts_source);
+    g_free((char *)args.opts_target);
+
+
+    migrate_ensure_converge(from);
+    wait_for_serial("src_serial");
+
+    qtest_qmp_assert_success(from, "{ 'execute': 'device_add',"
+                             "  'arguments': { "
+                             "    'node-id': 0, 'socket-id': 0,"
+                             "    'core-id': 2, 'thread-id': 0,"
+                             "    'id': {},"
+                             "    'driver': 'qemu64-x86_64-cpu' } }");
+
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
+
+    migrate_qmp(from, to, NULL, NULL, "{}");
+    wait_for_migration_complete(from);
+
+    migrate_end(from, to, true);
+    unlink(filename_scsi);
+    unlink(filename_blk);
+}
+
 void migration_test_add_misc(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
@@ -279,4 +352,7 @@ void migration_test_add_misc(MigrationTestEnv *env)
                        test_validate_uri_channels_both_set);
     migration_test_add("/migration/validate_uri/channels/none_set",
                        test_validate_uri_channels_none_set);
+
+    migration_test_add("/migration/hotplug/cpu/virtqueues",
+                       test_cpu_hotplug_virtqueues);
 }
-- 
2.35.3



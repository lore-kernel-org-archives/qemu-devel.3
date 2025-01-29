Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C521C02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAWA-0003v7-Nx; Wed, 29 Jan 2025 11:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVr-0003PK-W7
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:01 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVo-0005LH-Bs
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:58 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 16BEF210F9;
 Wed, 29 Jan 2025 16:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ne8zasNAUKeQPHV8fe2tlKT45NW5x2BvopjfSXSIWGY=;
 b=ZaWWKTMxHJQNFVIaFiK4OdBhSgk/m7ok8dFwcawkmOPO1fzKRNzULicQLCNsoSMnAeMymM
 ZQXvsaYzRJituyl100cGaqarijRhCV6rdXb+q1z7NQKbik6aGaKTwYCet5TFIfMaYdihQn
 cChBO1tLT3DNs2RQxjBYaHeHgGdXO1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ne8zasNAUKeQPHV8fe2tlKT45NW5x2BvopjfSXSIWGY=;
 b=Ffo3gmChxuaoOikL8LQ27MWetCzmDhkTQ0w2vAFqnqPNKfHZuNa4X4QWRDkT74OeIwfAqu
 t3iApCQOmzjyBvAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZaWWKTMx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ffo3gmCh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ne8zasNAUKeQPHV8fe2tlKT45NW5x2BvopjfSXSIWGY=;
 b=ZaWWKTMxHJQNFVIaFiK4OdBhSgk/m7ok8dFwcawkmOPO1fzKRNzULicQLCNsoSMnAeMymM
 ZQXvsaYzRJituyl100cGaqarijRhCV6rdXb+q1z7NQKbik6aGaKTwYCet5TFIfMaYdihQn
 cChBO1tLT3DNs2RQxjBYaHeHgGdXO1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ne8zasNAUKeQPHV8fe2tlKT45NW5x2BvopjfSXSIWGY=;
 b=Ffo3gmChxuaoOikL8LQ27MWetCzmDhkTQ0w2vAFqnqPNKfHZuNa4X4QWRDkT74OeIwfAqu
 t3iApCQOmzjyBvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3ABF137DB;
 Wed, 29 Jan 2025 16:01:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sKXjIPFQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 25/42] migration: cpr-transfer documentation
Date: Wed, 29 Jan 2025 13:00:42 -0300
Message-Id: <20250129160059.6987-26-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 16BEF210F9
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Add documentation for the cpr-transfer migration mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-25-git-send-email-steven.sistare@oracle.com
[add -machine memory-backend=ram0]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/CPR.rst | 184 ++++++++++++++++++++++++++++++++++-
 1 file changed, 182 insertions(+), 2 deletions(-)

diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
index 63c36470cf..7897873c86 100644
--- a/docs/devel/migration/CPR.rst
+++ b/docs/devel/migration/CPR.rst
@@ -5,7 +5,7 @@ CPR is the umbrella name for a set of migration modes in which the
 VM is migrated to a new QEMU instance on the same host.  It is
 intended for use when the goal is to update host software components
 that run the VM, such as QEMU or even the host kernel.  At this time,
-cpr-reboot is the only available mode.
+the cpr-reboot and cpr-transfer modes are available.
 
 Because QEMU is restarted on the same host, with access to the same
 local devices, CPR is allowed in certain cases where normal migration
@@ -53,7 +53,7 @@ RAM is copied to the migration URI.
 Outgoing:
   * Set the migration mode parameter to ``cpr-reboot``.
   * Set the ``x-ignore-shared`` capability if desired.
-  * Issue the ``migrate`` command.  It is recommended the the URI be a
+  * Issue the ``migrate`` command.  It is recommended the URI be a
     ``file`` type, but one can use other types such as ``exec``,
     provided the command captures all the data from the outgoing side,
     and provides all the data to the incoming side.
@@ -145,3 +145,183 @@ Caveats
 
 cpr-reboot mode may not be used with postcopy, background-snapshot,
 or COLO.
+
+cpr-transfer mode
+-----------------
+
+This mode allows the user to transfer a guest to a new QEMU instance
+on the same host with minimal guest pause time, by preserving guest
+RAM in place, albeit with new virtual addresses in new QEMU.  Devices
+and their pinned memory pages will also be preserved in a future QEMU
+release.
+
+The user starts new QEMU on the same host as old QEMU, with command-
+line arguments to create the same machine, plus the ``-incoming``
+option for the main migration channel, like normal live migration.
+In addition, the user adds a second -incoming option with channel
+type ``cpr``.  This CPR channel must support file descriptor transfer
+with SCM_RIGHTS, i.e. it must be a UNIX domain socket.
+
+To initiate CPR, the user issues a migrate command to old QEMU,
+adding a second migration channel of type ``cpr`` in the channels
+argument.  Old QEMU stops the VM, saves state to the migration
+channels, and enters the postmigrate state.  Execution resumes in
+new QEMU.
+
+New QEMU reads the CPR channel before opening a monitor, hence
+the CPR channel cannot be specified in the list of channels for a
+migrate-incoming command.  It may only be specified on the command
+line.
+
+Usage
+^^^^^
+
+Memory backend objects must have the ``share=on`` attribute.
+
+The VM must be started with the ``-machine aux-ram-share=on``
+option.  This causes implicit RAM blocks (those not described by
+a memory-backend object) to be allocated by mmap'ing a memfd.
+Examples include VGA and ROM.
+
+Outgoing:
+  * Set the migration mode parameter to ``cpr-transfer``.
+  * Issue the ``migrate`` command, containing a main channel and
+    a cpr channel.
+
+Incoming:
+  * Start new QEMU with two ``-incoming`` options.
+  * If the VM was running when the outgoing ``migrate`` command was
+    issued, then QEMU automatically resumes VM execution.
+
+Caveats
+^^^^^^^
+
+cpr-transfer mode may not be used with postcopy, background-snapshot,
+or COLO.
+
+memory-backend-epc is not supported.
+
+The main incoming migration channel address cannot be a file type.
+
+If the main incoming channel address is an inet socket, then the port
+cannot be 0 (meaning dynamically choose a port).
+
+When using ``-incoming defer``, you must issue the migrate command to
+old QEMU before issuing any monitor commands to new QEMU, because new
+QEMU blocks waiting to read from the cpr channel before starting its
+monitor, and old QEMU does not write to the channel until the migrate
+command is issued.  However, new QEMU does not open and read the
+main migration channel until you issue the migrate incoming command.
+
+Example 1: incoming channel
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In these examples, we simply restart the same version of QEMU, but
+in a real scenario one would start new QEMU on the incoming side.
+Note that new QEMU does not print the monitor prompt until old QEMU
+has issued the migrate command.  The outgoing side uses QMP because
+HMP cannot specify a CPR channel.  Some QMP responses are omitted for
+brevity.
+
+::
+
+  Outgoing:                             Incoming:
+
+  # qemu-kvm -qmp stdio
+  -object memory-backend-file,id=ram0,size=4G,
+  mem-path=/dev/shm/ram0,share=on -m 4G
+  -machine memory-backend=ram0
+  -machine aux-ram-share=on
+  ...
+                                        # qemu-kvm -monitor stdio
+                                        -incoming tcp:0:44444
+                                        -incoming '{"channel-type": "cpr",
+                                          "addr": { "transport": "socket",
+                                          "type": "unix", "path": "cpr.sock"}}'
+                                        ...
+  {"execute":"qmp_capabilities"}
+
+  {"execute": "query-status"}
+  {"return": {"status": "running",
+              "running": true}}
+
+  {"execute":"migrate-set-parameters",
+   "arguments":{"mode":"cpr-transfer"}}
+
+  {"execute": "migrate", "arguments": { "channels": [
+    {"channel-type": "main",
+     "addr": { "transport": "socket", "type": "inet",
+               "host": "0", "port": "44444" }},
+    {"channel-type": "cpr",
+     "addr": { "transport": "socket", "type": "unix",
+               "path": "cpr.sock" }}]}}
+
+                                        QEMU 10.0.50 monitor
+                                        (qemu) info status
+                                        VM status: running
+
+  {"execute": "query-status"}
+  {"return": {"status": "postmigrate",
+              "running": false}}
+
+Example 2: incoming defer
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This example uses ``-incoming defer`` to hot plug a device before
+accepting the main migration channel.  Again note you must issue the
+migrate command to old QEMU before you can issue any monitor
+commands to new QEMU.
+
+
+::
+
+  Outgoing:                             Incoming:
+
+  # qemu-kvm -monitor stdio
+  -object memory-backend-file,id=ram0,size=4G,
+  mem-path=/dev/shm/ram0,share=on -m 4G
+  -machine memory-backend=ram0
+  -machine aux-ram-share=on
+  ...
+                                        # qemu-kvm -monitor stdio
+                                        -incoming defer
+                                        -incoming '{"channel-type": "cpr",
+                                          "addr": { "transport": "socket",
+                                          "type": "unix", "path": "cpr.sock"}}'
+                                        ...
+  {"execute":"qmp_capabilities"}
+
+  {"execute": "device_add",
+   "arguments": {"driver": "pcie-root-port"}}
+
+  {"execute":"migrate-set-parameters",
+   "arguments":{"mode":"cpr-transfer"}}
+
+  {"execute": "migrate", "arguments": { "channels": [
+    {"channel-type": "main",
+     "addr": { "transport": "socket", "type": "inet",
+               "host": "0", "port": "44444" }},
+    {"channel-type": "cpr",
+     "addr": { "transport": "socket", "type": "unix",
+               "path": "cpr.sock" }}]}}
+
+                                        QEMU 10.0.50 monitor
+                                        (qemu) info status
+                                        VM status: paused (inmigrate)
+                                        (qemu) device_add pcie-root-port
+                                        (qemu) migrate_incoming tcp:0:44444
+                                        (qemu) info status
+                                        VM status: running
+
+  {"execute": "query-status"}
+  {"return": {"status": "postmigrate",
+              "running": false}}
+
+Futures
+^^^^^^^
+
+cpr-transfer mode is based on a capability to transfer open file
+descriptors from old to new QEMU.  In the future, descriptors for
+vfio, iommufd, vhost, and char devices could be transferred,
+preserving those devices and their kernel state without interruption,
+even if they do not explicitly support live migration.
-- 
2.35.3



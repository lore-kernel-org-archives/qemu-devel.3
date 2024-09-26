Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F14DCCFA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 11:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stmtf-0001fh-5u; Thu, 26 Sep 2024 07:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1stmtC-0000s1-H5
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:42:31 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1stmtA-0005mc-Qb
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:42:30 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F7971F853;
 Thu, 26 Sep 2024 11:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1727350947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DI5rEM33/JyPmPA9ISnjGysUOJRzoUG5DrbkoRbspA=;
 b=UNfStjeyl3XyvIboYw4+10/Vxgusp/FULaGJfcwYhGl4aBdE3mQNrrFrBDRzKzdD8nRCEv
 ntEXDyTkDvlKf5pozGjbcqrb9Q9J4B01P8KLr536KlYWkwXOWtlil1MzzDBUwUowNF2Wii
 0SJa6JJbKZ0p5yJ2+n8v7BrhNj2pCIc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1727350947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DI5rEM33/JyPmPA9ISnjGysUOJRzoUG5DrbkoRbspA=;
 b=UNfStjeyl3XyvIboYw4+10/Vxgusp/FULaGJfcwYhGl4aBdE3mQNrrFrBDRzKzdD8nRCEv
 ntEXDyTkDvlKf5pozGjbcqrb9Q9J4B01P8KLr536KlYWkwXOWtlil1MzzDBUwUowNF2Wii
 0SJa6JJbKZ0p5yJ2+n8v7BrhNj2pCIc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC6C413ABC;
 Thu, 26 Sep 2024 11:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mHy3M6JI9WbcRAAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Thu, 26 Sep 2024 11:42:26 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH v6 11/16] docs/interop/firmware.json: Add igvm to
 FirmwareDevice
Date: Thu, 26 Sep 2024 12:42:00 +0100
Message-ID: <927995008d7c3457305155aa36dc1d531d85ded0.1727341768.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727341768.git.roy.hopkins@suse.com>
References: <cover.1727341768.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 RCPT_COUNT_TWELVE(0.00)[19]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 FROM_HAS_DN(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 R_RATELIMIT(0.00)[to_ip_from(RLm8d31jk6dhzwhww9bgqrb1jt)];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out2.suse.de
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

Create an enum entry within FirmwareDevice for 'igvm' to describe that
an IGVM file can be used to map firmware into memory as an alternative
to pre-existing firmware devices.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 docs/interop/firmware.json | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 57f55f6c54..9c56dbffd1 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -57,10 +57,17 @@
 #
 # @memory: The firmware is to be mapped into memory.
 #
+# @igvm: The firmware is defined by a file conforming to the IGVM
+#        specification and mapped into memory according to directives
+#        defined in the file. This is similar to @memory but may
+#        include additional processing defined by the IGVM file
+#        including initial CPU state or population of metadata into
+#        the guest address space. Since: 9.2
+#
 # Since: 3.0
 ##
 { 'enum' : 'FirmwareDevice',
-  'data' : [ 'flash', 'kernel', 'memory' ] }
+  'data' : [ 'flash', 'kernel', 'memory', 'igvm' ] }
 
 ##
 # @FirmwareArchitecture:
@@ -367,6 +374,24 @@
 { 'struct' : 'FirmwareMappingMemory',
   'data'   : { 'filename' : 'str' } }
 
+##
+# @FirmwareMappingIgvm:
+#
+# Describes loading and mapping properties for the firmware executable,
+# when @FirmwareDevice is @igvm.
+#
+# @filename: Identifies the IGVM file containing the firmware executable
+#            along with other information used to configure the initial
+#            state of the guest. The IGVM file may be shared by multiple
+#            virtual machine definitions. This corresponds to creating
+#            an object on the command line with "-object igvm-cfg,
+#            file=@filename".
+#
+# Since: 9.2
+##
+{ 'struct' : 'FirmwareMappingIgvm',
+  'data'   : { 'filename' : 'str' } }
+
 ##
 # @FirmwareMapping:
 #
@@ -383,7 +408,8 @@
   'discriminator' : 'device',
   'data'          : { 'flash'  : 'FirmwareMappingFlash',
                       'kernel' : 'FirmwareMappingKernel',
-                      'memory' : 'FirmwareMappingMemory' } }
+                      'memory' : 'FirmwareMappingMemory',
+                      'igvm'   : 'FirmwareMappingIgvm' } }
 
 ##
 # @Firmware:
-- 
2.43.0



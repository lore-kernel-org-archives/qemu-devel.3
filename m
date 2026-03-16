Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5083CF53D90
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 19:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Dv9-0005wP-EZ; Mon, 16 Mar 2026 15:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Dv8-0005wC-1z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 15:48:10 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Dv6-0003NH-Da
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 15:48:09 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 93D535BDA1;
 Mon, 16 Mar 2026 19:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773690484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HZnBOeFGVZQcm4BscBgc1OFT4EXInuKSpyT4vCMq6Hk=;
 b=cQzbYHLRyVJpZUc7HgX2jfghcHo6y4RglJZGI8qjgtz6Da+inypuCg5XNDab++I0pzakh5
 Q7jTVeA+S1gG+VrCESCKwt2l4L0/vmlB/uKty/sNBEssR7CCYuHnj/XY5Z1TjWjQztfr5F
 5eVBTt/GQssH0rltz+VMGiPZy9mMXV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773690484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HZnBOeFGVZQcm4BscBgc1OFT4EXInuKSpyT4vCMq6Hk=;
 b=6A/x/RbjFU8+yM1Ph5aMLz7LP0AWvVXvw+q9rAO5d9TIZZFwEM5lfLVjaEhu3AwRITW3+o
 V38P0sGonnCk5PBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773690484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HZnBOeFGVZQcm4BscBgc1OFT4EXInuKSpyT4vCMq6Hk=;
 b=cQzbYHLRyVJpZUc7HgX2jfghcHo6y4RglJZGI8qjgtz6Da+inypuCg5XNDab++I0pzakh5
 Q7jTVeA+S1gG+VrCESCKwt2l4L0/vmlB/uKty/sNBEssR7CCYuHnj/XY5Z1TjWjQztfr5F
 5eVBTt/GQssH0rltz+VMGiPZy9mMXV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773690484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HZnBOeFGVZQcm4BscBgc1OFT4EXInuKSpyT4vCMq6Hk=;
 b=6A/x/RbjFU8+yM1Ph5aMLz7LP0AWvVXvw+q9rAO5d9TIZZFwEM5lfLVjaEhu3AwRITW3+o
 V38P0sGonnCk5PBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82A114273B;
 Mon, 16 Mar 2026 19:48:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id miE/EnJeuGmeZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Mar 2026 19:48:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Kiryanov <rkir@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v1] migration/savevm: Allow stub VMSDs
Date: Mon, 16 Mar 2026 16:47:59 -0300
Message-ID: <20260316194759.22672-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,linaro.org:email,suse.de:mid,suse.de:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

After the referenced commit, empty VMStateDescription objects declared
as part of stubs have started reaching the vmstate code.

A valid VMStateDescription must at minimum have a name and either the
.fields or .unmigratable fields set. Stubs, being empty, have
none. Code that assumes a non-NULL name field will now cause a
crash. E.g.

$ ./build/mips/qemu-system-mipsel -nographic -drive if=none,format=qcow2,file=dummy.qcow2
    [Type "C-a c" to get the "(qemu)" monitor prompt)]
    (qemu) savevm foo

    Backtrace from doing this under gdb:

      #0  0x0000555555df7d4d in vmsd_can_compress (field=0x5555564f78a0
      <__compound_literal.3>) at ../../migration/vmstate.c:339
      #1  0x0000555555df7dbb in vmsd_desc_field_start
          (vmsd=0x555556431ba0 <vmstate_cpuhp_state>, vmdesc=0x555556918690,
      field=0x5555564f78a0 <__compound_literal.3>, i=0, max=1) at
      ../../migration/vmstate.c:362
      #2  0x0000555555df85a7 in vmstate_save_state_v
          (f=0x555556b5a0c0, vmsd=0x555556431ba0 <vmstate_cpuhp_state>,
      opaque=0x555556c9aac0, vmdesc=0x555556918690, version_id=1,
      errp=0x7fffffffc948) at ../../migration/vmstate.c:528
      #3  0x0000555555df8032 in vmstate_save_state
          (f=0x555556b5a0c0, vmsd=0x555556431ba0 <vmstate_cpuhp_state>,
      opaque=0x555556c9aac0, vmdesc_id=0x555556918690, errp=0x7fffffffc948)
      at ../../migration/vmstate.c:427
      #4  0x0000555555df8f83 in vmstate_subsection_save
          (f=0x555556b5a0c0, vmsd=0x555556431c40 <vmstate_acpi>,
      opaque=0x555556c9aac0, vmdesc=0x555556918690, errp=0x7fffffffc948)
          at ../../migration/vmstate.c:695

Due to their very nature, it's better to allow stubs to be
completely empty instead of forcing any rules. Teach the code to skip
them.

Fixes: 7aa563630b ("pc: Start with modern CPU hotplug interface by default")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index dd58f2a705..e8d3360877 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -861,6 +861,10 @@ static void vmstate_check(const VMStateDescription *vmsd)
     const VMStateField *field = vmsd->fields;
     const VMStateDescription * const *subsection = vmsd->subsections;
 
+    if (!vmsd->name) {
+        return;
+    }
+
     if (field) {
         while (field->name) {
             if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
@@ -897,6 +901,11 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
 {
     SaveStateEntry *se;
 
+    if (!vmsd->name) {
+        /* assume it's a stub and ignore */
+        return 0;
+    }
+
     /* If this triggers, alias support can be dropped for the vmsd. */
     assert(alias_id == -1 || required_for_version >= vmsd->minimum_version_id);
 
-- 
2.51.0



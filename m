Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43409E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 18:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVxeg-0002Nb-O9; Thu, 09 Jan 2025 13:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVxeR-0002HZ-Ih
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:53:04 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVxeP-0005u1-RF
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:53:03 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9BDE21F452;
 Thu,  9 Jan 2025 18:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736448780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6WacRuqRrdcyMeDgo9GvyPLzv8WI8HC5taw+smLiyY0=;
 b=nNf4uxEQBPc4esxYBH90u1VnrtXfx5/cNW2mlP8qQHTNoc74Nws5gVoB4vbAjOAkMYOLZJ
 tf0LfRhcRnptP/DDNXwpxwvSQ7hGyiVpnIt7niwWD5W1Tv7rEA5fTjBzooIkBKOxFVO1EO
 ysAsFHVCw2XA4S6GXBFXtHzYxt3rjOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736448780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6WacRuqRrdcyMeDgo9GvyPLzv8WI8HC5taw+smLiyY0=;
 b=DK9ad+5NeS3MOBRE6jpP/tCfiB926q3mrokAT4LtBMMKkgTiCaLi9RoBLHRSlKNPqkTaK+
 5LfS7rLcvd/EKIDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736448780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6WacRuqRrdcyMeDgo9GvyPLzv8WI8HC5taw+smLiyY0=;
 b=nNf4uxEQBPc4esxYBH90u1VnrtXfx5/cNW2mlP8qQHTNoc74Nws5gVoB4vbAjOAkMYOLZJ
 tf0LfRhcRnptP/DDNXwpxwvSQ7hGyiVpnIt7niwWD5W1Tv7rEA5fTjBzooIkBKOxFVO1EO
 ysAsFHVCw2XA4S6GXBFXtHzYxt3rjOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736448780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6WacRuqRrdcyMeDgo9GvyPLzv8WI8HC5taw+smLiyY0=;
 b=DK9ad+5NeS3MOBRE6jpP/tCfiB926q3mrokAT4LtBMMKkgTiCaLi9RoBLHRSlKNPqkTaK+
 5LfS7rLcvd/EKIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FFAA139AB;
 Thu,  9 Jan 2025 18:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8Kx3CQsbgGdcMAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Jan 2025 18:52:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 4/7] migration: Rename vmstate_info_nullptr
Date: Thu,  9 Jan 2025 15:52:46 -0300
Message-Id: <20250109185249.23952-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250109185249.23952-1-farosas@suse.de>
References: <20250109185249.23952-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.993];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Rename vmstate_info_nullptr from "uint64_t" to "nullptr". This vmstate
actually reads and writes just a byte, so the proper name would be
uint8. However, since this is a marker for a NULL pointer, it's
convenient to have a more explicit name that can be identified by the
consumers of the JSON part of the stream.

Change the name to "nullptr" and add support for it in the
analyze-migration.py script. Arbitrarily use the name of the type as
the value of the field to avoid the script showing 0x30 or '0', which
could be confusing for readers.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate-types.c    |  2 +-
 scripts/analyze-migration.py | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index e83bfccb9e..d70d573dbd 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -338,7 +338,7 @@ static int put_nullptr(QEMUFile *f, void *pv, size_t size,
 }
 
 const VMStateInfo vmstate_info_nullptr = {
-    .name = "uint64",
+    .name = "nullptr",
     .get  = get_nullptr,
     .put  = put_nullptr,
 };
diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index fcda11f31d..923f174f1b 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -417,6 +417,28 @@ def __init__(self, desc, file):
         super(VMSDFieldIntLE, self).__init__(desc, file)
         self.dtype = '<i%d' % self.size
 
+class VMSDFieldNull(VMSDFieldGeneric):
+    NULL_PTR_MARKER = b'0'
+
+    def __init__(self, desc, file):
+        super(VMSDFieldNull, self).__init__(desc, file)
+
+    def __repr__(self):
+        # A NULL pointer is encoded in the stream as a '0' to
+        # disambiguate from a mere 0x0 value and avoid consumers
+        # trying to follow the NULL pointer. Displaying '0', 0x30 or
+        # 0x0 when analyzing the JSON debug stream could become
+        # confusing, so use an explicit term instead.
+        return "nullptr"
+
+    def __str__(self):
+        return self.__repr__()
+
+    def read(self):
+        super(VMSDFieldNull, self).read()
+        assert(self.data == self.NULL_PTR_MARKER)
+        return self.data
+
 class VMSDFieldBool(VMSDFieldGeneric):
     def __init__(self, desc, file):
         super(VMSDFieldBool, self).__init__(desc, file)
@@ -558,6 +580,7 @@ def getDict(self):
     "bitmap" : VMSDFieldGeneric,
     "struct" : VMSDFieldStruct,
     "capability": VMSDFieldCap,
+    "nullptr": VMSDFieldNull,
     "unknown" : VMSDFieldGeneric,
 }
 
-- 
2.35.3



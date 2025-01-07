Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC17DE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 19:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVFbF-00039J-3f; Tue, 07 Jan 2025 14:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVFb5-00038L-0I
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:50:39 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVFb1-0002EC-Ke
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:50:37 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66FAF21169;
 Tue,  7 Jan 2025 19:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736279434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIA5oCNeozHsI1Yqn22E3q7yYwnd9W2prkpovubO0gk=;
 b=KAT5sMeNZDJcQHaowUboXtt49f3UdkOHtxK7IlCCzOsfN7lWiReIeENH/8qXM4jrPaEURY
 XbB6iAnIta3h2m/Kg2DIgrTatU+FLfmM0i+hPAlRo0uf5yeXuOy4Hq+aJ1+5Rm6/GurYtT
 3vGinGqXwrSXd/DhLZ0FFNpmkdki884=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736279434;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIA5oCNeozHsI1Yqn22E3q7yYwnd9W2prkpovubO0gk=;
 b=Qk7Ux+hijfA6wriqTztqlzHRVEKqm9q3KImsRdM2rHv5p9NFj6mkQ5m4HmyAtCuM7KPWGG
 wIpiBITqX6bNKADw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KAT5sMeN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Qk7Ux+hi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736279434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIA5oCNeozHsI1Yqn22E3q7yYwnd9W2prkpovubO0gk=;
 b=KAT5sMeNZDJcQHaowUboXtt49f3UdkOHtxK7IlCCzOsfN7lWiReIeENH/8qXM4jrPaEURY
 XbB6iAnIta3h2m/Kg2DIgrTatU+FLfmM0i+hPAlRo0uf5yeXuOy4Hq+aJ1+5Rm6/GurYtT
 3vGinGqXwrSXd/DhLZ0FFNpmkdki884=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736279434;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIA5oCNeozHsI1Yqn22E3q7yYwnd9W2prkpovubO0gk=;
 b=Qk7Ux+hijfA6wriqTztqlzHRVEKqm9q3KImsRdM2rHv5p9NFj6mkQ5m4HmyAtCuM7KPWGG
 wIpiBITqX6bNKADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3069913A6A;
 Tue,  7 Jan 2025 19:50:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cOy/OIiFfWeCGAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 07 Jan 2025 19:50:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH 3/7] migration: Document the effect of vmstate_info_nullptr
Date: Tue,  7 Jan 2025 16:50:21 -0300
Message-Id: <20250107195025.9951-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250107195025.9951-1-farosas@suse.de>
References: <20250107195025.9951-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66FAF21169
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

The migration stream lacks magic numbers at some key points. It's easy
to mis-parse data. Unfortunately, the VMS_NULLPTR_MARKER continues
with the trend. A '0' byte is ambiguous and could be interpreted as a
valid 0x30.

It is maybe not worth trying to change this while keeping backward
compatibility, so add some words of documentation to clarify.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate-types.c    | 6 ++++++
 scripts/analyze-migration.py | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index e83bfccb9e..08ed059f87 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -339,6 +339,12 @@ static int put_nullptr(QEMUFile *f, void *pv, size_t size,
 
 const VMStateInfo vmstate_info_nullptr = {
     .name = "uint64",
+
+     /*
+      * Ideally these would actually read/write the size of a pointer,
+      * but we're stuck with just a byte now for backward
+      * compatibility.
+      */
     .get  = get_nullptr,
     .put  = put_nullptr,
 };
diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index f2457b1dde..4292fde424 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -388,12 +388,21 @@ def read(self):
         return self.data
 
 class VMSDFieldUInt(VMSDFieldInt):
+    NULL_PTR_MARKER = 0x30
+
     def __init__(self, desc, file):
         super(VMSDFieldUInt, self).__init__(desc, file)
 
     def read(self):
         super(VMSDFieldUInt, self).read()
         self.data = self.udata
+
+        if self.data == self.NULL_PTR_MARKER:
+            # The migration stream encodes NULL pointers as '0' so any
+            # 0x30 in the stream could be a NULL. There's not much we
+            # can do without breaking backward compatibility.
+            pass
+
         return self.data
 
 class VMSDFieldIntLE(VMSDFieldInt):
-- 
2.35.3



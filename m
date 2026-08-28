Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65320C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyzX-0001cW-Q5; Fri, 28 Aug 2026 11:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyzW-0001c1-Sc
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:42 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyzP-00006V-CR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:42 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 13A672229A;
 Fri, 28 Aug 2026 15:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tuHdlGGPQPD+UD6SrlaKWBfSOvo8qV7InxoVIfCWkY=;
 b=bSlBK6pG/Rm8W6xwjR3wrozx5glA7d0tAAJXa1B7fVjWlHq6qX3UYNoZsi38sbF5qiMJwk
 SDtR8bAqmc6ZUIJIv3R+1bCyUFOUV59Ouiumv7/wEgfbLXyeAElYuU5l1uEl14DLXa18ch
 ZGiy9PM3mOcu6H+Rxc9V9p+/qvDlLIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932769;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tuHdlGGPQPD+UD6SrlaKWBfSOvo8qV7InxoVIfCWkY=;
 b=BwEKlopgSq1gOf3j/1o1WF96ZXVQgKYxlZNSL+DKlEunK2ioaD04zgiJ5QgAhG2rzATNjl
 WZ+pcU55pemeMTDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tuHdlGGPQPD+UD6SrlaKWBfSOvo8qV7InxoVIfCWkY=;
 b=oqsPiWzataUjyicl5EnjBN23XJV19wF8D72Y2OZg0m04zeYaqNlsrPnGGBzjfE58uXpjMB
 Y1OCnS/Ovukue/ywU36J2zVKVcG40k4DnB8oqLv157SA4vmQ4FIHnT30C8cPHtcXnbii5W
 qSBNzemLNVQ4jE7kPshLZ4HaBtsIAhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932765;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tuHdlGGPQPD+UD6SrlaKWBfSOvo8qV7InxoVIfCWkY=;
 b=yw0/X495X9ZcpuALbElVu1tIlYxxQZp/veu52heUgItX5QoMJjA/i2r+LKbsCp0nYpZaY9
 DoCQBQDdE8qR9mCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20AAF13687;
 Fri, 28 Aug 2026 15:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MJOfOFuwkWpoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Aug 2026 15:59:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL v2 27/30] migration: Check more vmstate flags
Date: Fri, 28 Aug 2026 12:58:42 -0300
Message-ID: <20260828155845.2874508-28-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828155845.2874508-1-farosas@suse.de>
References: <20260828155845.2874508-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

Add more checks for vmstate flags constraints.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index ba705c941aa..5b0e89ca7c8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -893,6 +893,25 @@ static void vmstate_check(const VMStateDescription *vmsd)
                 assert(field->flags & VMS_ARRAY_OF_POINTER);
             }
 
+            /*
+             * The VMS*ARRAY flags and VMS_VBUFFER affect allocation,
+             * they must have the proper fields set and no other
+             * vmstate types can set those fields, otherwise it won't
+             * be picked-up due to the missing flag.
+             */
+
+            if (field->flags & (VMS_ARRAY | VMS_VARRAY)) {
+                assert(field->num > 0 || field->num_indirect.size != 0);
+            } else {
+                assert(field->num == 0 && field->num_indirect.size == 0);
+            }
+
+            if (field->flags & VMS_VBUFFER) {
+                assert(field->size_indirect.size != 0);
+            } else {
+                assert(field->size_indirect.size == 0);
+            }
+
             if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
                 /* Recurse to sub structures */
                 vmstate_check(field->vmsd);
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DE3FEC107
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57fl-0003LM-Vb; Tue, 24 Mar 2026 15:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fi-0003IP-2s
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:15 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fg-0008FE-HM
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:13 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5141F4D29B;
 Tue, 24 Mar 2026 19:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eFmCs2WROEl+hnfjKFhtGMxmvHhxybnFTEhGAiVUOgQ=;
 b=EyFZKPy0VBip4blieR8mL2xSy67KttGTyTU9FKxTXPxe42Krbqs46pYSiQSXJ+9FkBkYOg
 ph+2w1qezhDFKfnbJlKXXgv7GHufJr0T2Td1b4IeA8Gf28fisFPD5sU3ZsAu/oQPlVv+Nt
 1byJOPJ+Anpm45rTd8+t3sokVaREa9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eFmCs2WROEl+hnfjKFhtGMxmvHhxybnFTEhGAiVUOgQ=;
 b=ufVsmDprC7rfAaUF7BTDMOB1Ezbel1NX6MiuO2FrjDRASjpvFcV7XLliaU4G3Qh+jr8wYt
 6hwNbjBM7jNfhOAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eFmCs2WROEl+hnfjKFhtGMxmvHhxybnFTEhGAiVUOgQ=;
 b=EyFZKPy0VBip4blieR8mL2xSy67KttGTyTU9FKxTXPxe42Krbqs46pYSiQSXJ+9FkBkYOg
 ph+2w1qezhDFKfnbJlKXXgv7GHufJr0T2Td1b4IeA8Gf28fisFPD5sU3ZsAu/oQPlVv+Nt
 1byJOPJ+Anpm45rTd8+t3sokVaREa9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eFmCs2WROEl+hnfjKFhtGMxmvHhxybnFTEhGAiVUOgQ=;
 b=ufVsmDprC7rfAaUF7BTDMOB1Ezbel1NX6MiuO2FrjDRASjpvFcV7XLliaU4G3Qh+jr8wYt
 6hwNbjBM7jNfhOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A68D43FE4;
 Tue, 24 Mar 2026 19:43:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gJGfOnbpwmlkMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 24 Mar 2026 19:43:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [RFC PATCH v1 10/17] vmstate: Remove curr_elem_p
Date: Tue, 24 Mar 2026 16:43:25 -0300
Message-ID: <20260324194333.30004-11-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324194333.30004-1-farosas@suse.de>
References: <20260324194333.30004-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
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

The usage of curr_elem_p for holding the array of pointers element is
a bit confusing. The side effect of updating what this variable points
to is not very clear. Remove it in favor of a local array_elem
variable with the same purpose, but make it of type void** instead,
since this is what it really is. Move it under the
VMS_ARRAY_OF_POINTER check.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 0cdfde2232..85e63305f6 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -261,16 +261,15 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                 /* If we will process the load of field? */
                 bool load_field = true;
                 bool ok = true;
-                void *curr_elem_p = first_elem + size * i;
-                void *curr_elem = curr_elem_p;
+                void *curr_elem;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
+                    void **array_elem = (void **)first_elem + i;
                     bool use_dynamic_array =
                         field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
                     bool use_marker_field;
 
-                    curr_elem = *(void **)curr_elem_p;
-
+                    curr_elem = *array_elem;
                     use_marker_field = use_dynamic_array || !curr_elem;
 
                     if (use_marker_field) {
@@ -293,9 +292,11 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                              */
                             curr_elem = g_malloc0(field->size);
                             /* Remember to update the root pointer! */
-                            *(void **)curr_elem_p = curr_elem;
+                            *(void **)array_elem = curr_elem;
                         }
                     }
+                } else {
+                    curr_elem = first_elem + size * i;
                 }
 
                 if (load_field) {
-- 
2.51.0



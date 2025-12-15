Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2022D5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGds-00040C-Fc; Mon, 15 Dec 2025 17:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdp-0003tO-Sf
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:05 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdo-0002ob-3P
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:05 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB1225BDEF;
 Mon, 15 Dec 2025 22:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PBzJkpOkkK0HoW8hl5SIwKzpENa8ip8NNhwNebfQdeQ=;
 b=neDJY19ZQraqjlqh4jn+5vUdT8phTL8z903OQem8H9z3H5xLDNy8oEW57DDUyeTJGgEMuC
 Uk6dmlVLymbN0jkxWVYl1wcMAhEkVSfV91N42JG/28PZ3rloKYyHDuDE4S/4MNmzapkjHf
 Q/sO19DvjVJ0eKRDDfPvbpaTSpsyUro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836091;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PBzJkpOkkK0HoW8hl5SIwKzpENa8ip8NNhwNebfQdeQ=;
 b=blHkOrCGLeG2XJ4qfT58FhBmzH4fwKE1s+IwN1ACYY4uZOMckK/Z/y/ZK4WXlcTVEi9vvz
 YnY8w9HQGbcy7KCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PBzJkpOkkK0HoW8hl5SIwKzpENa8ip8NNhwNebfQdeQ=;
 b=AEIukR4IH+ynN8FQIKAVlUO6QuaUHVt7mel1xsb3GJ+bD6ygs6hGjB8Ove55JfP6Wjhrvl
 jQky8dbf2uxvMfxBglbjbbVNo/TUAy04OwJgVtv9/aDrcydVFVxQV8hVcNVM/ctgiEkdle
 SVRJz08+CUGVMDi7jG3URPTykT8k5Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836090;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PBzJkpOkkK0HoW8hl5SIwKzpENa8ip8NNhwNebfQdeQ=;
 b=RCCI7oznM22hXdEvmWGUTVRrkiVN2PteAk7cVG7KreTJbBzYQU+nsSsBKJ61AlQz5vxsFk
 Y/v563+7XBQAU7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DAF23EA63;
 Mon, 15 Dec 2025 22:01:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CPK5NziFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 16/51] qapi: Add QAPI_MERGE
Date: Mon, 15 Dec 2025 19:00:02 -0300
Message-ID: <20251215220041.12657-17-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.995];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
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

The migration subsystem currently has code to merge two objects of the
same type. It does so by checking which fields are present in a source
object and overwriting the corresponding fields on the destination
object. This leads to a lot of open-coded lines such as:

    if (src->has_foobar) {
        dst->foobar = src->foobar;
    }

This pattern could be replaced by a copy using visitors. Implement a
macro that extracts elements from a source object using an output
visitor and merges it with a destination object using an input
visitor.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qapi/type-helpers.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/qapi/type-helpers.h b/include/qapi/type-helpers.h
index fc8352cdec..011716c6ad 100644
--- a/include/qapi/type-helpers.h
+++ b/include/qapi/type-helpers.h
@@ -10,6 +10,8 @@
  */
 
 #include "qapi/qapi-types-common.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qobject-output-visitor.h"
 
 HumanReadableText *human_readable_text_from_str(GString *str);
 
@@ -20,3 +22,30 @@ HumanReadableText *human_readable_text_from_str(GString *str);
  * cleanup.
  */
 char **strv_from_str_list(const strList *list);
+
+/*
+ * Merge @src over @dst by copying deep clones of the present members
+ * from @src to @dst. Non-present on @src are left untouched on @dst.
+ */
+#define QAPI_MERGE(type, dst_, src_)                                    \
+    ({                                                                  \
+        QObject *out_ = NULL;                                           \
+        Visitor *v_;                                                    \
+        /* read in from src */                                          \
+        v_ = qobject_output_visitor_new(&out_);                         \
+        visit_type_ ## type(v_, NULL, &src_, &error_abort);             \
+        visit_complete(v_, &out_);                                      \
+        visit_free(v_);                                                 \
+        /*                                                              \
+         * Write to dst but leave existing fields intact (except for    \
+         * has_* which will be updated according to their presence in   \
+         * src).                                                        \
+         */                                                             \
+        v_ = qobject_input_visitor_new(out_);                           \
+        visit_start_struct(v_, NULL, NULL, 0, &error_abort);            \
+        visit_type_ ## type ## _members(v_, dst_, &error_abort);        \
+        visit_check_struct(v_, &error_abort);                           \
+        visit_end_struct(v_, NULL);                                     \
+        visit_free(v_);                                                 \
+        qobject_unref(out_);                                            \
+    })
-- 
2.51.0



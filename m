Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09539D37E33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0qU-0006YJ-4R; Wed, 14 Jan 2026 08:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg0qL-0006Xk-V3
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:23:25 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg0qK-0006i9-75
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:23:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E9863411C;
 Wed, 14 Jan 2026 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768397001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NDK5VnnkFXqjnSY/+1rjEdw0JQMtPwLYXBs1hRb32U=;
 b=mqi/+1M+ut4kWCYVsqPJuKH28X/nzdiXLDPbDxCOL+XUysa2kCC2mIZAioW7daIMSjB0E+
 Celo07s0WgXiXp51O4Uutna+SwkG/SAwg4DpK+uY6fScyM26GVmwIdpv9KKhEfRjKOOkzX
 d8eWQAjy1T0EgqdybXF2T0+WGtz+Ytg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768397001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NDK5VnnkFXqjnSY/+1rjEdw0JQMtPwLYXBs1hRb32U=;
 b=Y7qwDrvTDspUAheKM0Rvt8/xkTTzmND/5Z4VKmvJhVOUz9SpOPRdFDeiwnQ+lvumdrFrFZ
 pKOwyf258e/loBBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="mqi/+1M+";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Y7qwDrvT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768397001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NDK5VnnkFXqjnSY/+1rjEdw0JQMtPwLYXBs1hRb32U=;
 b=mqi/+1M+ut4kWCYVsqPJuKH28X/nzdiXLDPbDxCOL+XUysa2kCC2mIZAioW7daIMSjB0E+
 Celo07s0WgXiXp51O4Uutna+SwkG/SAwg4DpK+uY6fScyM26GVmwIdpv9KKhEfRjKOOkzX
 d8eWQAjy1T0EgqdybXF2T0+WGtz+Ytg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768397001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NDK5VnnkFXqjnSY/+1rjEdw0JQMtPwLYXBs1hRb32U=;
 b=Y7qwDrvTDspUAheKM0Rvt8/xkTTzmND/5Z4VKmvJhVOUz9SpOPRdFDeiwnQ+lvumdrFrFZ
 pKOwyf258e/loBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A24673EA63;
 Wed, 14 Jan 2026 13:23:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4A2uGMeYZ2nxBwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Jan 2026 13:23:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, armbru@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 4/5] qapi: Add QAPI_MERGE
Date: Wed, 14 Jan 2026 10:23:08 -0300
Message-ID: <20260114132309.5832-5-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114132309.5832-1-farosas@suse.de>
References: <20260114132309.5832-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3E9863411C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qapi/type-helpers.h | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/qapi/type-helpers.h b/include/qapi/type-helpers.h
index fc8352cdec..f22d7b7139 100644
--- a/include/qapi/type-helpers.h
+++ b/include/qapi/type-helpers.h
@@ -10,6 +10,9 @@
  */
 
 #include "qapi/qapi-types-common.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qapi/dealloc-visitor.h"
 
 HumanReadableText *human_readable_text_from_str(GString *str);
 
@@ -20,3 +23,40 @@ HumanReadableText *human_readable_text_from_str(GString *str);
  * cleanup.
  */
 char **strv_from_str_list(const strList *list);
+
+/*
+ * Merge @src over @dst by copying deep clones of the present members
+ * from @src to @dst. Non-present on @src are left untouched on
+ * @dst. Pointer members that are overwritten are also freed.
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
+         * Free the memory for which the pointers will be overwritten   \
+         * in the next step.                                            \
+         */                                                             \
+        v_ = qapi_dealloc_present_visitor_new(out_);                    \
+        visit_start_struct(v_, NULL, NULL, 0, &error_abort);            \
+        visit_type_ ## type ## _members(v_, dst_, &error_abort);        \
+        visit_end_struct(v_, NULL);                                     \
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



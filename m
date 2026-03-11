Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C14FCA19A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 05:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Bwq-0007sz-Fo; Wed, 11 Mar 2026 01:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1w0Bwo-0007sg-IZ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 01:17:30 -0400
Received: from va-2-111.ptr.blmpb.com ([209.127.231.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1w0Bwj-0003LX-Oh
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 01:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1773206232; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Gy4SfHfJxOuY+25XeZZKLoUaXoKj3Tsevtcwd81Vgxw=;
 b=ErTl02moxsMS3yLcqFCiavN7vqYbeXhcxdev7R21eXnQjiWZKaXxNPCT1kTTZYjBN2zLgV
 DuU9083yfSZ9lO5zorVKBDdETAnENh37CM33v9IP49rcqHscpPIlpu2FW9+8BR9XcFQ3l4
 kXXyln+ghPJtKy1UdXyl7DLyXPBdSzFp9atb/Jigvdvd3p7vPH7VozENj5PFrzjq38LLfK
 tD2v3SWdGEhzUbkvBSgobvtwhAJKMwDckZn66jpdq0cHAGSredIxBCgFBrhW6/sX1GRSbo
 Vp9bz29CmTXxx7EyPctTxEVnRVSUkQ884u6YBp9YDljQXKrQh0jxxuriGzsvNw==
Mime-Version: 1.0
X-Lms-Return-Path: <lba+269b0fad6+3463a7+nongnu.org+yanfei.xu@bytedance.com>
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH] migration: check is_active for old-style vmstate
Date: Wed, 11 Mar 2026 13:16:58 +0800
To: <qemu-devel@nongnu.org>
Cc: <peterx@redhat.com>, <farosas@suse.de>, <caixiangfeng@bytedance.com>, 
 <liwenbo.liwenbo@bytedance.com>, <yanfei.xu@bytedance.com>
Message-Id: <20260311051658.1074299-1-yanfei.xu@bytedance.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.127.231.111;
 envelope-from=yanfei.xu@bytedance.com; helo=va-2-111.ptr.blmpb.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

old-style vmstate doesn't use vmsd and instead rely on SaveStateEntry
ops. Check is_active for old-style vmstate to determine whether they
should be skipped during migration.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
 migration/savevm.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 197c89e0e6..7eee83ffca 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1030,15 +1030,27 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc,
                         Error **errp)
 {
     int ret;
+    const bool has_old_style = se->ops && se->ops->save_state;
 
-    if ((!se->ops || !se->ops->save_state) && !se->vmsd) {
+    if (!has_old_style && !se->vmsd) {
         return 0;
+    } else if (has_old_style && se->vmsd) {
+        error_report("%s: '%s' (section_id=%u): unexpected: both vmsd (%s) and"
+                     " old-style save_state are set", __func__, se->idstr,
+                     se->section_id, se->vmsd->name);
+        return -EINVAL;
     }
+
     if (se->vmsd && !vmstate_section_needed(se->vmsd, se->opaque)) {
         trace_savevm_section_skip(se->idstr, se->section_id);
         return 0;
     }
 
+    if (has_old_style && se->ops->is_active && !se->ops->is_active(se->opaque)) {
+        trace_savevm_section_skip(se->idstr, se->section_id);
+        return 0;
+    }
+
     trace_savevm_section_start(se->idstr, se->section_id);
     save_section_header(f, se, QEMU_VM_SECTION_FULL);
     if (vmdesc) {
-- 
2.20.1


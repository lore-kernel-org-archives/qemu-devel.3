Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0262BCCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ZlU-000857-Uk; Tue, 30 Sep 2025 08:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3ZlP-000839-3S
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3Zl8-0002Ms-Um
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759236426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hhp3A0Ok0hueUzTv/YAOZ+wnHKN/iRf5eq99+sRzYn0=;
 b=KpHuHIQx1z3qZ+WkCRo+h9B6k32RotbSH0BFizn+ylyHwWMbN9vT23b0WFkV4ozACoGVlQ
 NbaZaoEZ08cGwp7LwnItHSb3bE3kUtZfxbGAejZufZqPeu2ANJuZqwJ7o0MZAhkDyAIOFz
 CnXxcIwqkIPtb3xyYjk1Lv6TJVhvIxE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-i1dk9aN4MBStT86iFSa5Jw-1; Tue,
 30 Sep 2025 08:47:00 -0400
X-MC-Unique: i1dk9aN4MBStT86iFSa5Jw-1
X-Mimecast-MFC-AGG-ID: i1dk9aN4MBStT86iFSa5Jw_1759236419
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CBB7197764F; Tue, 30 Sep 2025 12:46:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D55C1944DD7; Tue, 30 Sep 2025 12:46:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 65C5521E6925; Tue, 30 Sep 2025 14:46:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 02/13] tcg: Fix error reporting on mprotect() failure in
 tcg_region_init()
Date: Tue, 30 Sep 2025 14:46:42 +0200
Message-ID: <20250930124653.321609-3-armbru@redhat.com>
In-Reply-To: <20250930124653.321609-1-armbru@redhat.com>
References: <20250930124653.321609-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

tcg_region_init() calls one of qemu_mprotect_rwx(),
qemu_mprotect_rw(), and mprotect(), then reports failure with
error_setg_errno(&error_fatal, errno, ...).

The use of &error_fatal is undesirable.  qapi/error.h advises:

 * Please don't error_setg(&error_fatal, ...), use error_report() and
 * exit(), because that's more obvious.

The use of errno is wrong.  qemu_mprotect_rwx() and qemu_mprotect_rw()
wrap around qemu_mprotect__osdep().  qemu_mprotect__osdep() calls
mprotect() on POSIX, VirtualProtect() on Windows, and reports failure
with error_report().  VirtualProtect() doesn't set errno.  mprotect()
does, but error_report() may clobber it.

Fix tcg_region_init() to report errors only when it calls mprotect(),
and rely on qemu_mprotect_rwx()'s and qemu_mprotect_rw()'s error
reporting otherwise.  Use error_report(), not error_setg().

Fixes: 22c6a9938f75 (tcg: Merge buffer protection and guard page protection)
Fixes: 6bc144237a85 (tcg: Use Error with alloc_code_gen_buffer)
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250923091000.3180122-3-armbru@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 tcg/region.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 7ea0b37a84..2181267e48 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -832,13 +832,16 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads)
             } else {
 #ifdef CONFIG_POSIX
                 rc = mprotect(start, end - start, need_prot);
+                if (rc) {
+                    error_report("mprotect of jit buffer: %s",
+                                 strerror(errno));
+                }
 #else
                 g_assert_not_reached();
 #endif
             }
             if (rc) {
-                error_setg_errno(&error_fatal, errno,
-                                 "mprotect of jit buffer");
+                exit(1);
             }
         }
         if (have_prot != 0) {
-- 
2.49.0



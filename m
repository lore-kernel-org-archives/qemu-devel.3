Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87F0CAC5B1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0z2a-0007AX-87; Tue, 23 Sep 2025 05:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0z2T-00076d-Ig
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0z2L-0000Pe-3h
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758618608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aa+CVIcaT2b4xDOaeK2XatKCUaNE/cwrQaJu0zdze9U=;
 b=Ja9aXpzvOH5+FJHlvOSww4IX0xVAUZ7O5n9C69B+AH4F8F47z6CVik2v0W83Rb4xnem91A
 Ln4P5AMZ6d93gwk4WaNvl87JSDC2tas/vGEgqpZJnFZHixO5/74B+MfOwvBNzg53QhdOLn
 wZI+9fi4KSarwWzz9xAuaIfirN7IbVg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-3HGlIFdANhKkzfcOjjMMCw-1; Tue,
 23 Sep 2025 05:10:04 -0400
X-MC-Unique: 3HGlIFdANhKkzfcOjjMMCw-1
X-Mimecast-MFC-AGG-ID: 3HGlIFdANhKkzfcOjjMMCw_1758618603
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87696195608F; Tue, 23 Sep 2025 09:10:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04D013000198; Tue, 23 Sep 2025 09:10:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 52DCB21E6925; Tue, 23 Sep 2025 11:10:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org,
 vsementsov@yandex-team.ru
Subject: [PATCH v3 02/13] tcg: Fix error reporting on mprotect() failure in
 tcg_region_init()
Date: Tue, 23 Sep 2025 11:09:49 +0200
Message-ID: <20250923091000.3180122-3-armbru@redhat.com>
In-Reply-To: <20250923091000.3180122-1-armbru@redhat.com>
References: <20250923091000.3180122-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



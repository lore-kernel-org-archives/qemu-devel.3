Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B9AC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUPL-0007aq-Te; Thu, 30 Jan 2025 08:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOt-0007Ns-HL
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOr-000060-2w
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738242964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWsDyjiWNhoCKkFG5lKI1wUdEVo4sQK8TD8VKf6UJmE=;
 b=eu+4Ok43MshGRg+SvJpqi13TTZa+uNQBOARNuhRzjsMrJ8XkiJe6ax/ry2WLyQcl24Pw7X
 xUMi+MMr/kh90gCFpXkZqQ1urJ/pohODqunQhW5DhzbzoDaupOc10VjY5sLVwcaA0gZN+W
 Dn3gvUPGAY/K1p40OVyuhEO6UiEl1lc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-w3MtKG1oOOeV-5Y4nMdlxw-1; Thu,
 30 Jan 2025 08:16:00 -0500
X-MC-Unique: w3MtKG1oOOeV-5Y4nMdlxw-1
X-Mimecast-MFC-AGG-ID: w3MtKG1oOOeV-5Y4nMdlxw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41DB9195609E; Thu, 30 Jan 2025 13:15:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B7A33003FD1; Thu, 30 Jan 2025 13:15:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Berthold Gunreben <azouhr@opensuse.org>,
 Sarah Kriesch <ada.lovelace@gmx.de>, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 08/20] target/s390x: Fix MVC not always invalidating
 translation blocks
Date: Thu, 30 Jan 2025 14:15:22 +0100
Message-ID: <20250130131535.91297-9-thuth@redhat.com>
In-Reply-To: <20250130131535.91297-1-thuth@redhat.com>
References: <20250130131535.91297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Node.js crashes in qemu-system-s390x with random SIGSEGVs / SIGILLs.

The v8 JIT used by Node.js can garbage collect and overwrite unused
code. Overwriting is performed by WritableJitAllocation::CopyCode(),
which ultimately calls memcpy(). For certain sizes, memcpy() uses the
MVC instruction.

QEMU implements MVC and other similar instructions using helpers. While
TCG store ops invalidate affected translation blocks automatically,
helpers must do this manually by calling probe_access_flags(). The MVC
helper does this using the access_prepare() -> access_prepare_nf() ->
s390_probe_access() -> probe_access_flags() call chain.

At the last step of this chain, the store size is replaced with 0. This
causes the probe_access_flags() -> notdirty_write() ->
tb_invalidate_phys_range_fast() chain to miss some translation blocks.

When this happens, QEMU executes a mix of old and new code. This
quickly leads to either a SIGSEGV or a SIGILL in case the old code
ends in the middle of a new instruction.

Fix by passing the true size.

Reported-by: Berthold Gunreben <azouhr@opensuse.org>
Cc: Sarah Kriesch <ada.lovelace@gmx.de>
Cc: qemu-stable@nongnu.org
Closes: https://bugzilla.opensuse.org/show_bug.cgi?id=1235709
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Fixes: e2faabee78ff ("accel/tcg: Forward probe size on to notdirty_write")
Message-ID: <20250128001338.11474-1-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 32717acb7d..c6ab2901e5 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -149,7 +149,7 @@ static inline int s390_probe_access(CPUArchState *env, target_ulong addr,
                                     int mmu_idx, bool nonfault,
                                     void **phost, uintptr_t ra)
 {
-    int flags = probe_access_flags(env, addr, 0, access_type, mmu_idx,
+    int flags = probe_access_flags(env, addr, size, access_type, mmu_idx,
                                    nonfault, phost, ra);
 
     if (unlikely(flags & TLB_INVALID_MASK)) {
-- 
2.48.1



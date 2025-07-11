Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868FEC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaA94-0000nN-IF; Fri, 11 Jul 2025 05:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA8i-0000iK-LH
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA8e-00072K-Rd
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752226431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4f+WLNxeAr1wBxQEb2gPlinpNSInYgM8vAB5Vu0S58=;
 b=jVDqkjGSphMdyXxTCtf1zcNammPg+1Zit8w7rigkODBeT5B39RC1/SqyQoQJtahgjjQqce
 F3bXgsdLEk0IysZUjKpOOFFc7Z/RJ93T/Zi90p20wTL/OzpFRNMnrYJjsgldki2J0CZPGt
 t5gUc29Ozr63M+Cg0cIm5VxCbsu1wM8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-9LpSSvqhMCKkOjPwUh3RDg-1; Fri,
 11 Jul 2025 05:33:47 -0400
X-MC-Unique: 9LpSSvqhMCKkOjPwUh3RDg-1
X-Mimecast-MFC-AGG-ID: 9LpSSvqhMCKkOjPwUh3RDg_1752226426
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A388819560B5; Fri, 11 Jul 2025 09:33:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.54])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A93019560A3; Fri, 11 Jul 2025 09:33:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/15] target/s390x/kvm: Use vaddr in
 find/insert_hw_breakpoint()
Date: Fri, 11 Jul 2025 11:33:26 +0200
Message-ID: <20250711093340.608485-2-thuth@redhat.com>
In-Reply-To: <20250711093340.608485-1-thuth@redhat.com>
References: <20250711093340.608485-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commit b8a6eb1862a both kvm_arch_insert_hw_breakpoint()
and kvm_arch_remove_hw_breakpoint() use a vaddr type. Use the
same type for the callees.

Fixes: b8a6eb1862a ("sysemu/kvm: Use vaddr for kvm_arch_[insert|remove]_hw_breakpoint")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250707171059.3064-2-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/kvm/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 67d9a1977c0..491cc5f9756 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -889,7 +889,7 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
     return 0;
 }
 
-static struct kvm_hw_breakpoint *find_hw_breakpoint(target_ulong addr,
+static struct kvm_hw_breakpoint *find_hw_breakpoint(vaddr addr,
                                                     int len, int type)
 {
     int n;
@@ -904,7 +904,7 @@ static struct kvm_hw_breakpoint *find_hw_breakpoint(target_ulong addr,
     return NULL;
 }
 
-static int insert_hw_breakpoint(target_ulong addr, int len, int type)
+static int insert_hw_breakpoint(vaddr addr, int len, int type)
 {
     int size;
 
-- 
2.50.0



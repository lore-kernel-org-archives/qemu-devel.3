Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C35C3ABB3
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 23:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spyiW-0007PW-PJ; Sun, 15 Sep 2024 19:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1spyiV-0007OX-2g
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 19:31:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1spyiT-0000fT-GC
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 19:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726443095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=U+/24G//Ch8Yv0HN3P/EzAbY8BhMmG1vwPYM2IzWMkI=;
 b=G2q3+hBYWKs7DLa6bkJL2KwM5wi3hOQ1ziN6qWJ0K7vRQKD7/XaEJrnBHkrgMaMHYFHkOQ
 5vcPDLcbXCv7a5pOyeo0EZm8nkK1RKEgPifHwROlY2MaUesHViwRRlp1xecaMz+cQqRfqb
 2LkAiFThiILXSnXlucH/bXbwZyXgUDs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-R_6FpWW2O0efbtMYlkmJFA-1; Sun,
 15 Sep 2024 19:31:31 -0400
X-MC-Unique: R_6FpWW2O0efbtMYlkmJFA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F0621955F2C; Sun, 15 Sep 2024 23:31:30 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.54])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05A2830001AB; Sun, 15 Sep 2024 23:31:24 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, david@redhat.com, imammedo@redhat.com,
 philmd@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 zhenyzha@redhat.com, shan.gavin@gmail.com
Subject: [PATCH] hostmem: Apply merge property after the memory region is
 initialized
Date: Mon, 16 Sep 2024 09:31:17 +1000
Message-ID: <20240915233117.478169-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The semantic change has been introduced by commit 5becdc0ab0 ("hostmem:
simplify the code for merge and dump properties") even it clarifies that
no senmatic change has been introduced. After the commit, the merge
property can be applied even the corresponding memory region isn't
initialized yet. This leads to crash dump by the following command
lines.

  # /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64  \
    -accel kvm  -machine virt -cpu host                      \
    -object memory-backend-ram,id=mem-memN0,size=4096M,merge=off
    :
    qemu-system-aarch64: ../system/memory.c:2419: memory_region_get_ram_ptr: \
    Assertion `mr->ram_block' failed.

Fix it by applying the merge property only when the memory region is
initialized.

Fixes: 5becdc0ab083 ("hostmem: simplify the code for merge and dump properties")
Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 backends/hostmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 4e5576a4ad..181446626a 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -178,7 +178,7 @@ static void host_memory_backend_set_merge(Object *obj, bool value, Error **errp)
         return;
     }
 
-    if (!host_memory_backend_mr_inited(backend) &&
+    if (host_memory_backend_mr_inited(backend) &&
         value != backend->merge) {
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
-- 
2.45.2



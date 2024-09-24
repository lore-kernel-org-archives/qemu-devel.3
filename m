Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86369CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 10:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st2Ol-0002nJ-De; Tue, 24 Sep 2024 06:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1st2Oi-0002cr-Ih
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 06:03:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1st2Of-00031d-Pn
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 06:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727172232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awsejfNqiJTGB7bVdBQ+7TGfVln40WtAFHmHDEbWm20=;
 b=TkfSQvZxSK0wd6DbeyLU4DAMSDKKFMNdH+3uccuzxyguGOOq7CqSH8WlY9cJB+8OUJFIN9
 v03FewyP7tTzJ4BHHYyR9UOSH7hbSFSZr2lOM9hKNJKeVxbzE/Un8lcsYQeNSsow+zILwm
 3EkdkCffvEsbQ/DEd7iy11DjxQL7zI8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-4je3NliENCeY0LVpu_P3Ww-1; Tue,
 24 Sep 2024 06:03:51 -0400
X-MC-Unique: 4je3NliENCeY0LVpu_P3Ww-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8698C18B63F2; Tue, 24 Sep 2024 10:03:50 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.16.106])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BD971956048; Tue, 24 Sep 2024 10:03:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Zhenyu Zhang <zhenyzha@redhat.com>
Subject: [PULL 6/6] hostmem: Apply merge property after the memory region is
 initialized
Date: Tue, 24 Sep 2024 12:03:29 +0200
Message-ID: <20240924100329.248738-7-david@redhat.com>
In-Reply-To: <20240924100329.248738-1-david@redhat.com>
References: <20240924100329.248738-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Gavin Shan <gshan@redhat.com>

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

Message-ID: <20240915233117.478169-1-gshan@redhat.com>
Fixes: 5becdc0ab083 ("hostmem: simplify the code for merge and dump properties")
Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
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
2.46.1



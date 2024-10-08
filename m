Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056CACEF151
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 10:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy7s9-0001IZ-F6; Tue, 08 Oct 2024 06:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7s4-0001HV-9r
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7s2-0001d3-VL
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728384913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UwCj+hgqyB9x40oN682O/EprONvoL/7W9oor1YYT55A=;
 b=ZKTkPP+BK7JZX2+0I2KDtMoi/pdAQu5b5zn+wB0Azzhh1HX8VqVS8Jt688CLUIFIS2okkW
 +x0kUCVpVeNQHzfMLPy4bv+9Usus7kvuOG/GMKiqJ+J8mjIU5GTA4sbXorsTAcyLY1Rzv6
 D/Zf7jeBzBbYYsG4y6iv38bs9sUtgB0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-5wXBN5JRMy2_3UUA9sZW0w-1; Tue,
 08 Oct 2024 06:55:10 -0400
X-MC-Unique: 5wXBN5JRMy2_3UUA9sZW0w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EBC51955EAD; Tue,  8 Oct 2024 10:55:09 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.16.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7861619560A3; Tue,  8 Oct 2024 10:55:03 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 01/14] s390x/s390-virtio-ccw: don't crash on weird RAM sizes
Date: Tue,  8 Oct 2024 12:54:42 +0200
Message-ID: <20241008105455.2302628-2-david@redhat.com>
In-Reply-To: <20241008105455.2302628-1-david@redhat.com>
References: <20241008105455.2302628-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

KVM is not happy when starting a VM with weird RAM sizes:

  # qemu-system-s390x --enable-kvm --nographic -m 1234K
  qemu-system-s390x: kvm_set_user_memory_region: KVM_SET_USER_MEMORY_REGION
    failed, slot=0, start=0x0, size=0x244000: Invalid argument
  kvm_set_phys_mem: error registering slot: Invalid argument
  Aborted (core dumped)

Let's handle that in a better way by rejecting such weird RAM sizes
right from the start:

  # qemu-system-s390x --enable-kvm --nographic -m 1234K
  qemu-system-s390x: ram size must be multiples of 1 MiB

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5aa8d207a3..b88ec8e78a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -180,6 +180,17 @@ static void s390_memory_init(MemoryRegion *ram)
 {
     MemoryRegion *sysmem = get_system_memory();
 
+    if (!QEMU_IS_ALIGNED(memory_region_size(ram), 1 * MiB)) {
+        /*
+         * SCLP cannot possibly expose smaller granularity right now and KVM
+         * cannot handle smaller granularity. As we don't support NUMA, the
+         * region size directly corresponds to machine->ram_size, and the region
+         * is a single RAM memory region.
+         */
+        error_report("ram size must be multiples of 1 MiB");
+        exit(EXIT_FAILURE);
+    }
+
     /* allocate RAM for core */
     memory_region_add_subregion(sysmem, 0, ram);
 
-- 
2.46.1



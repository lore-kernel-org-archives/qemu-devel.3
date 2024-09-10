Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A45EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so58n-0006hi-NH; Tue, 10 Sep 2024 13:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so58m-0006YW-0L
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so58k-0006QV-Ay
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725991137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cECBk1qPAy/kFJQbJli+ig8bld14E32zOLZX1hTjPnw=;
 b=S9n+LsJQ1H3HRm2Sp0+xX6ZK9sMLAiyoq7u8cHHZM9PDIAF0eBo3tB7evibGh5vG6g7F/R
 9GuftQk0vIREgol64ziJZo24KJXRIQo+4ntMObFS3rcPnx3dLGG3Xmo6GLBD3+K13NIVh8
 wZP2pIbpIlpye+SLWNdYQVyiOvooapA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-43twLiD5OiSpbQqui4OpKg-1; Tue,
 10 Sep 2024 13:58:54 -0400
X-MC-Unique: 43twLiD5OiSpbQqui4OpKg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF208195394C; Tue, 10 Sep 2024 17:58:52 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.32.182])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 423BB19560AD; Tue, 10 Sep 2024 17:58:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v1 07/14] s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT
Date: Tue, 10 Sep 2024 19:58:02 +0200
Message-ID: <20240910175809.2135596-8-david@redhat.com>
In-Reply-To: <20240910175809.2135596-1-david@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A guest OS that supports memory hotplug / memory devices must during
boot be aware of the maximum possible physical memory address that it might
have to handle at a later stage during its runtime

For example, the maximum possible memory address might be required to
prepare the kernel virtual address space accordingly (e.g., select page
table hierarchy depth).

On s390x there is currently no such mechanism that is compatible with
paravirtualized memory devices, because the whole SCLP interface was
designed around the idea of "storage increments" and "standby memory".
Paravirtualized memory devices we want to support, such as virtio-mem, have
no intersection with any of that, but could co-exist with them in the
future if ever needed.

In particular, a guest OS must never detect and use device memory
without the help of a proper device driver. Device memory must not be
exposed in any firmware-provided memory map (SCLP or diag260 on s390x).
For this reason, these memory devices will be places in memory *above*
the "maximum storage increment" exposed via SCLP.

Let's provide a new diag500 subcode to query the memory limit determined in
s390_memory_init().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-hypercall.c | 3 +++
 hw/s390x/s390-hypercall.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
index f09e8a1d81..ac48fc0961 100644
--- a/hw/s390x/s390-hypercall.c
+++ b/hw/s390x/s390-hypercall.c
@@ -68,6 +68,9 @@ int handle_diag_500(CPUS390XState *env)
     case DIAG500_VIRTIO_CCW_NOTIFY:
         env->regs[2] = handle_virtio_ccw_notify(env->regs[2], env->regs[3]);
         return 0;
+    case DIAG500_STORAGE_LIMIT:
+        env->regs[2] = s390_get_memory_limit() - 1;
+        return 0;
     default:
         return -EINVAL;
     }
diff --git a/hw/s390x/s390-hypercall.h b/hw/s390x/s390-hypercall.h
index b7ac29f444..f0ca62bcbb 100644
--- a/hw/s390x/s390-hypercall.h
+++ b/hw/s390x/s390-hypercall.h
@@ -18,6 +18,7 @@
 #define DIAG500_VIRTIO_RESET            1 /* legacy */
 #define DIAG500_VIRTIO_SET_STATUS       2 /* legacy */
 #define DIAG500_VIRTIO_CCW_NOTIFY       3 /* KVM_S390_VIRTIO_CCW_NOTIFY */
+#define DIAG500_STORAGE_LIMIT           4
 
 int handle_diag_500(CPUS390XState *env);
 
-- 
2.46.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5C5C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4oko-0007Vs-13; Thu, 10 Sep 2026 20:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lTV-0005rE-24
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lTJ-0002Yr-Hf
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8nca6ab6j9DpnVime3jEZyKCaQ7UUnAbl2LkixdkLlA=;
 b=HvB0saZyf4KvXb3zRJ6SsYZWWxcsex1Z0ffp5DZzq1GvyPel9Mysn8dgfVY6glrmDQLgcV
 kxI6gJJUrrDVYmMRYUgnd0k5D6+rutBzYi/tSXZ1zTrA5+cS7HIaR8zPUuh4bC8fKSh/Vt
 NKDjAQffC+T0fLilJLe2lh7lHfOBA9o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-f74Zrb17OJmiu_No0YgU7g-1; Thu, 10 Sep 2026 16:11:40 -0400
X-MC-Unique: f74Zrb17OJmiu_No0YgU7g-1
X-Mimecast-MFC-AGG-ID: f74Zrb17OJmiu_No0YgU7g_1789071099
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48437090e74so60116f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071099; x=1789675899; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8nca6ab6j9DpnVime3jEZyKCaQ7UUnAbl2LkixdkLlA=;
 b=Vo33G8S8xnE5731NGwWikEHf4PyN+wgwGc01xUiYr8Fga9eManNVY9h7rGsZ5HfPaG
 uqbx6rEO9odGbJK6EzPaJ5C45O3COnb2+XZl+51Vx6YZRAU1nXYf6OG5UIxIlqG+mY+o
 EvTaz+r058NHd8dTh0ZW5ZlKhQuP2UlokZv1OiNIhgZftR8GQ9iJVt/ii+lNpVPjDbVo
 rH8SOWd+B+HFx3+Jnnwc17s/P16tVyWuqUmDjMZDBnwwIeRN3gmkQUfNtdigSVIFciC2
 RAS+uFn5Mu1ELAFKaHmJDv9cIaFw0i42JzXL2kGgianrIW0E6cm1Zskbs+CaeUKJol0w
 FzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071099; x=1789675899;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8nca6ab6j9DpnVime3jEZyKCaQ7UUnAbl2LkixdkLlA=;
 b=AalO5QJzrZ+D8wCs1WYTFT2N5LEnDGVZnDEdY8eMosFOE3I1E2uF/NgpLByanb+gOn
 sNR0Ca89Ao/JplW9Vpt3nGFSLqDXvGHB/PB08q1C3Opv9fht6YdoN01xU6VAh9l8u+Lb
 ChInIXa8aKO0jbkrGVOm4zBRlgpuxPdtdzW/mxv23+hRISckvJC8utzwhKveqjd9qigs
 NCAddV4mLR33CbUjEg6+DvZoGYvlfRKPUhZ6amyMqGwofI0+qi2Ku20oj9xOKP9oOeIj
 sFN0SP22zeANRIJH+HdTwH7P0MI6/Sy83wq7kRE8WZe3UIQu5PYm766xhXZ3KxPbprNb
 sSsQ==
X-Gm-Message-State: AFuF++ljhmu7XBWWLhTS5RytDevbdkar1LnJMgeuJF2EtE3yfzFgntYZ
 /PBi9YjymyMdjSQCCKAe+Fp5rqhvyJ5VmLouyUh3I8rulE51wVVm1yUl9yRFCmsgSh/NJPT/+Kf
 tZR+GKEaU7g56bZjaJmD9fkk1C/in1sH5Z3o5KjQbOHDVZUkXMG4vqpYlbRaCgZF6Dgj13ohXQA
 qpLBM7SLof52thX99FLyb9mpWyUIfUL1Thgg==
X-Gm-Gg: AYBFou2+Mqp1kynj5jJoXqVooNZQSZwTIMeE+4BiQodnfb61L0kLK45XoyAfF84MtYj
 +v0YP3OgKq9aU4AVApuOmjTGM7JG6raOWilA6nIzSekzIeFIIxrpCJWH/Ig469j4PZkW5EHS85F
 Gabh6kDvHY4oYrVn6ZzqlaIs4dk+RsFkB1E349+N5xWgq6YCaggVJzMM1nNa8OYCaB+DfQ+LU+Q
 LE4rIdovOwtIQbNfo4/b877tH1rmxf3IqkCSc7caNAwjN/dKxzJFSoHD5i1ZnzkXAlIAuMYZC4m
 w0VYqcrlF7nB+gcjU88LBhkrGSDz3623ZJjUPU5mzfp7gAqz4fKtimZfhq1TOas2Ik67RukeXb0
 bb5dmNf41B3udVJXVDnCib7Y=
X-Received: by 2002:a5d:64cc:0:b0:485:7cb9:4ec4 with SMTP id
 ffacd0b85a97d-486eb2ec226mr897160f8f.5.1789071099053; 
 Thu, 10 Sep 2026 13:11:39 -0700 (PDT)
X-Received: by 2002:a5d:64cc:0:b0:485:7cb9:4ec4 with SMTP id
 ffacd0b85a97d-486eb2ec226mr897098f8f.5.1789071098378; 
 Thu, 10 Sep 2026 13:11:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32d5f1sm904567f8f.12.2026.09.10.13.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:37 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Mark Kanda <mark.kanda@oracle.com>,
 Steve Sistare <steven.sistare@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 06/90] vhost: add vhost_reset_owner op
Message-ID: <afe60e95f0a39c369e91efab884b66f48725cb54.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Add a VhostOps callback issuing VHOST_RESET_OWNER, wired up for the kernel
backend.  The CPR (checkpoint-restore) path uses it to release device
ownership on the source so the destination can reclaim it later with
VHOST_SET_OWNER.

Originally-by: Mark Kanda <mark.kanda@oracle.com>
Originally-by: Steve Sistare <steven.sistare@oracle.com>
Originally-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com> # for CPR
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260820113955.509478-3-andrey.drobyshev@virtuozzo.com>
---
 include/hw/virtio/vhost-backend.h | 1 +
 hw/virtio/vhost-kernel.c          | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index d878d7b733..6c949e6a38 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -204,6 +204,7 @@ typedef struct VhostOps {
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
     vhost_set_owner_op vhost_set_owner;
+    vhost_set_owner_op vhost_reset_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;
diff --git a/hw/virtio/vhost-kernel.c b/hw/virtio/vhost-kernel.c
index 3390b48c6f..55d316b88e 100644
--- a/hw/virtio/vhost-kernel.c
+++ b/hw/virtio/vhost-kernel.c
@@ -261,6 +261,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
 }
 
+static int vhost_kernel_reset_owner(struct vhost_dev *dev)
+{
+    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
+}
+
 static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
 {
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
@@ -385,6 +390,7 @@ const VhostOps kernel_ops = {
         .vhost_get_features_ex = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
+        .vhost_reset_owner = vhost_kernel_reset_owner,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
-- 
MST



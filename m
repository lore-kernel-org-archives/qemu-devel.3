Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E41CE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrhB-0000c5-7K; Wed, 18 Dec 2024 05:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrh9-0000bd-Fh
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:54:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrh7-0006mB-Lz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QndkQAdv+aZOEQr2b2o41BTTLOjnawhbhJJcyyz1yzo=;
 b=QfG24xi7jqTAq2SG8L5rSTkrTmBQD+aIdBUljBVQFDtawR4yXzn+H1wGyBnCxR8/IktRDe
 +LVEDb1Bpg5ePAyezohC8im446g1DBkoeuXLzdLc9tUJbH0ZacCYlgExfk+yWZhQs0oGOv
 9Wa/QJSJg0JwvfgMLWjzrkV/WGgtknw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-654OZlAmPouDCk7lUTMWxQ-1; Wed, 18 Dec 2024 05:53:12 -0500
X-MC-Unique: 654OZlAmPouDCk7lUTMWxQ-1
X-Mimecast-MFC-AGG-ID: 654OZlAmPouDCk7lUTMWxQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43610eba55bso21948595e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519191; x=1735123991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QndkQAdv+aZOEQr2b2o41BTTLOjnawhbhJJcyyz1yzo=;
 b=qDPQGIHhYaoWfDygj+tcusmtcKnrEfWKsfenIjA0NQkVSIDXESaoTPmyyDs224BP7y
 rmXQ4EzDCaRAT7DAaNfVZf+UGOenm3zF73lOq94kT3Q+16eIZ3tv0UZ21q5un+hiI/2H
 q6MBSIw1UKXQ0hVRe8ddpUwfjGPU19EFTmGt6vsdYenqONopvCSztMiljq/ibOxaVNRc
 cD+RoIgBoyveaN9FZ2YKaV3tUj6/E3kr0KYAFC9UAAToatJ8LNlg/kkVOwNmLrbcpN68
 kytdbMYRP/zG1ZncvdY6Pjilp/gBKLj0pHDTXApSqa00sfnV1jBGfa0y7YEe/JasEdeG
 l8zQ==
X-Gm-Message-State: AOJu0Yz29rAHiRk4VlQT8oiaBN7NMiiA1XWFy7Kwoj9RP3ZANpC0tLsq
 LAccoKESK4nLli8pZS3kr10SJG7QglK0XUVAP+QH0JthcE3uoNZe9QswZMYadX3gGMC6tFEVggv
 vucUAgH0CvZwjA3XtrD12NLPzeeHqVxuEUYOHjp+zPES3tmGMV/8oDw3mqAFliIEoPxDX49xPsZ
 qTqH0I+DZXhtAEu7SgL7DFFpT6nVvfc4sC6jc=
X-Gm-Gg: ASbGncvzhjYq+7fXbsqx5KMV5fGjxv4uK9taMw6Uzy5IRg/7Lw3eZKMsGIphrY6ksUi
 yoMogSuY/W+jqc7Mxl5DyTB3KBLPw8HDsQaH2xJRYxhUZf21XUgKJ0AcAt2bOTiWvyShDy0TtvF
 y8RilMlBt4iIlCrbFbBmdLLYNnNekvA8s9KxYM+Elxi/CPs5LPUxwIRMSVL4/dCGdTU2jeOc/x4
 wgqJBC+ddb7ORMxzNd8xT1pKgy8ZHc7nmmEbNLLYFkWJdRew/d3qvzJTVPLdzf9rYhAoA456bC1
 lnRj9W6dcg6Iwd59KOUBaxiJ5Nogl0LNMEHiVE8BnA==
X-Received: by 2002:a05:600c:45cd:b0:434:fddf:5bfa with SMTP id
 5b1f17b1804b1-43655341465mr21064715e9.2.1734519191588; 
 Wed, 18 Dec 2024 02:53:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR0GhsNJkR9YG52+yzP7+HPVmEa2YqTJ+dNd52NFn3823753NX0Tgszl+whEt1epgFq1rrhQ==
X-Received: by 2002:a05:600c:45cd:b0:434:fddf:5bfa with SMTP id
 5b1f17b1804b1-43655341465mr21064355e9.2.1734519191118; 
 Wed, 18 Dec 2024 02:53:11 -0800 (PST)
Received: from localhost
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43656b1143dsm16214115e9.18.2024.12.18.02.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:53:10 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Subject: [PULL 02/15] s390x/s390-virtio-ccw: don't crash on weird RAM sizes
Date: Wed, 18 Dec 2024 11:52:50 +0100
Message-ID: <20241218105303.1966303-3-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218105303.1966303-1-david@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Message-ID: <20241008105455.2302628-2-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 67ae34aead..f2a17ecace 100644
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
2.47.1



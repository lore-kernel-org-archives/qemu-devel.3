Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465DEE7718B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 19:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP53R-0002Mc-2l; Sat, 21 Dec 2024 14:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53Q-0002ML-0U
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53O-00008c-Ji
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734808941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOXr2Dzl9Uc55CdyQyMKaFxc2uZ6Bg9cL7pok6fw/Mk=;
 b=VURB2pNNrv4M74kcKRhTolBnP99HHbMkM+knyUuWIkEAg/t2ROqvSjkZuICgtaQ9iDu76V
 vEbfQyn1g1nodte1EPvyC7ZKBrBim0a6t2sJ6zxO5XswfXWkMVJfSgjP96YXZlOAmKgqLb
 oXni4qNLOguydt7QydbkO3a04nce/nE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-oltUJG4vNC2s0K3Ogq8nfQ-1; Sat, 21 Dec 2024 14:22:20 -0500
X-MC-Unique: oltUJG4vNC2s0K3Ogq8nfQ-1
X-Mimecast-MFC-AGG-ID: oltUJG4vNC2s0K3Ogq8nfQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361a8fc3bdso16094225e9.2
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 11:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734808939; x=1735413739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BOXr2Dzl9Uc55CdyQyMKaFxc2uZ6Bg9cL7pok6fw/Mk=;
 b=V+WYOEBvHWffMXgW5zvlsxlT7MhXbz9b9kCpcYpZw6O1ANYoYtGMti9Rljoi1vD2W8
 KTw0sYJ9vsVG3ZZnMT0KI8nB/GhOqAC3eiGG2F+o/qCwNtsSkMO4usQ6t0P0C/xTmW9g
 S3LAPuujKvHg6TMt0g87w9q9Ixwffk2EFSPC7mxdK6N1ZSEoC3LMlmfL89+O3P73g6hn
 ToJDroOTeJw+hyEHdF7OJf7qr8TqsNefYzXF8mhV2LEoX/E0d/fWtcxYJBs8RB65l3ED
 hyFoGuKnAUNQSFk+99EEPVc995kTVg242gALl7T7qkrA16lM+jGPqMHmsfIl8RRjXH2d
 x96Q==
X-Gm-Message-State: AOJu0YyNrc2fGXNXbn+WLq77l5LdW+wQus2Ook5NUXBQ7NPxM0rycKeO
 7Zi6PsmcAjE6uhjr8WB8s6L5fj8V2WgFgLa7lQW4oUVVcOsQsxWAZVLzOZrlrLDy2OpPRq34udz
 hfqg2S9oguO7gVmlB0e1oP8EY+N2u7Mz7qlmo/mVHeikuQNIUB9Q4Wk9T6UcUE2jX4Ggl4LZOVa
 7kph7FRxgZ8UYBszjW9oPcOyTymYTcRz+r
X-Gm-Gg: ASbGnctQqovNYFfytc2G7IP2VtbRD08CY1TmLbmB8/XT1B+5WbCG58e/GzNuDk5lGso
 hsazav4+K0TxuxCL4UIcHw1lTUwGDf8lzOsjrvUTs4JtCN6e4KBD2r8/6B0NDW12wbrmwCtmOs7
 WvjxkRfUU3iKqXFCDCVG/++eVfVRzuAGmitRczfbDfkajzLfzIBPSusb94scj2/vDyDBdccGP1x
 vaeGTmM6urapZTokbWy707gIotA3S3EPh4Wi8+TY7Epx0HfG1+v8CnOKkqKD5+EHIXGZ6ppEaUJ
 1o0lz0RQAPSv62pR9I+TVepzCrA64+9gs3LRgOY=
X-Received: by 2002:a05:600c:19c6:b0:434:f2bf:1708 with SMTP id
 5b1f17b1804b1-4366854740fmr55911395e9.7.1734808939146; 
 Sat, 21 Dec 2024 11:22:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmhM/JDbnZdQ9xrkFvpWu/TcMWHhFRB2eCxVjCDlYSGhs9Z7LSQ8UnTkH0rDx9RLTG7X74Og==
X-Received: by 2002:a05:600c:19c6:b0:434:f2bf:1708 with SMTP id
 5b1f17b1804b1-4366854740fmr55911225e9.7.1734808938800; 
 Sat, 21 Dec 2024 11:22:18 -0800 (PST)
Received: from localhost
 (p200300cbc7137800820d0e9f08ce52bd.dip0.t-ipconnect.de.
 [2003:cb:c713:7800:820d:e9f:8ce:52bd])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4366127c639sm82369085e9.31.2024.12.21.11.22.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 11:22:17 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Subject: [PULL v2 02/15] s390x/s390-virtio-ccw: don't crash on weird RAM sizes
Date: Sat, 21 Dec 2024 20:21:56 +0100
Message-ID: <20241221192209.3979595-3-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221192209.3979595-1-david@redhat.com>
References: <20241221192209.3979595-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
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

Message-ID: <20241219144115.2820241-2-david@redhat.com>
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



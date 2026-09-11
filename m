Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93EDC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAr-0005Vw-Qr; Fri, 11 Sep 2026 05:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAW-0004QG-KF
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAS-0008Je-On
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlpYQy/1MbjiL1NkAZwSro3mr5gaZVYlMNIrEIu3Rs4=;
 b=dI6LfGzIx+bu/0ELhR2bLdW4UA3MKYsG6FYDfSq03J9Yu6MFEMOmBIHCOWMhqJpc/IY9aN
 vwhXZndkYw0zGHkB4vQNbvf/MO/vNoYvrbFYy3q6qcIkp6lWWRzEXTfYdszJiL5RLg4ClN
 X90ROb/pgxIb5s14R4dPAGGXD0OaQ18=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-k7LnJeZzOG6kZzuZR24-zg-1; Fri, 11 Sep 2026 05:03:30 -0400
X-MC-Unique: k7LnJeZzOG6kZzuZR24-zg-1
X-Mimecast-MFC-AGG-ID: k7LnJeZzOG6kZzuZR24-zg_1789117409
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48439eea716so326682f8f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117409; x=1789722209; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zlpYQy/1MbjiL1NkAZwSro3mr5gaZVYlMNIrEIu3Rs4=;
 b=t2QVLxXLll7FDJze0O/4/wpCgEXlJGQcvqfJvzznEU512Jk1RJSZLy7dhRyORKGQVV
 63HToyjDS9JrTRYYDpu/w5pC7qaajCKevvtv8Kk0nZVnJIm4CotRVWear8oD0wmoaL3N
 lz9wFNy6GsdKqf4iKIATJ1EQmqwO2d82Pj8NaKXEZSyINGxkaLPMvBL95ehq7nHysPgN
 Jx6hEbySBF9P+r+3c65j3KhOLHDjJNGNo+mnLMW0gi7/qMago9+yzc0XPiaEjmA77YID
 KwwKUdlDTE0Wi62vvUcAnUVj0UXPENnGElWpZh7vtM/pNYKOTv5CtBTuce6g+8I4J6Rn
 s5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117409; x=1789722209;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zlpYQy/1MbjiL1NkAZwSro3mr5gaZVYlMNIrEIu3Rs4=;
 b=MbXm4/WnlYNfzEpWZUJeNLEZoX+NtbFOJ164c3jFJcJn5a4sS1BnsY4HiX1KSZfR3g
 2vogSkn5BNXJZX16JM8PEt5OnZtllwcBOwaRA5YZp+iT4O86AO37GkZGAGbvvZcrHYpf
 2v0ggY13Xih5SgJDRfHgMMC+/yRzJrsUHfxVTi6gzfUSMtgB5ixygHr3noUhzXigbjIy
 762JkrxXj7hn6G9rqmCnH20MppOrrkC2tUaVBOh7r3SR6swIZzmorqGxvLwLpSDDA2JM
 V/U+xDIGQuxc5FlG5NIZgOWL8oV7HCnnBqSw06ZFgj9NQlUq21iG6JlJndev8EBwGZOS
 I8dg==
X-Gm-Message-State: AFuF++kHwuNlN1+2NHFPnJ4UrA/2pHAc8qoO8Mr7OI96j8+vyJFVhZL1
 0//pnfg4YD/4Hv3jbGVefOoyd5HesYF76c1tI9CLrZXTdlnAPm1hhmNOBTlPuFPfeQTeMtFo5Ix
 MJ+rU5lxRQpvLZrb/p0v80SSDs5ZnoX21elek+nhv5j7/J1aaqrP4MHTiJf4sFtX1BtmfWMGhxI
 QxWzO6IwHAAdV2bMAXNsXInTU6Q8iocV9mWg==
X-Gm-Gg: AYBFou23aBiZvCdWkL5WzyBwPJjjtiQktshuXFWLlVNZI1xoAr9OOaILx8WNzjcHtVj
 ol3vFgMOtfY8c/elbkFhHm8E1t1UvY111/unS90wE1A0D/oqCXQe6jPKuw1xjuIpus7YEWmGfPX
 7uuEJUL3Z6M3A0WC373dQAovzOsRd4bXZ+ZEvRv87h9iMm1T9UknKSWjPgn4h2GflkyUY2Ndq6H
 s0y54A7X4vNet9AOMJoiTg+b+Vq0lrXzYsOrNoJw6v8ZvjHLDKNdNK5yX0nCeOZ8BmWtZsVqvYe
 XOEPF05llI0f1bEqSV5xbgLv9fhCy4uon9aldg3NzdYXVGUbJikGJMvZp4DE5lRcSI/KAI09wER
 RYAEXN8PDdoo15xQJ/aPnuLI=
X-Received: by 2002:a05:600c:46cc:b0:49c:fc6c:be03 with SMTP id
 5b1f17b1804b1-49e619f63a5mr30047615e9.26.1789117408640; 
 Fri, 11 Sep 2026 02:03:28 -0700 (PDT)
X-Received: by 2002:a05:600c:46cc:b0:49c:fc6c:be03 with SMTP id
 5b1f17b1804b1-49e619f63a5mr30047005e9.26.1789117408083; 
 Fri, 11 Sep 2026 02:03:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a33e34sm39073565e9.0.2026.09.11.02.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:27 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL v2 54/75] virtio-scsi: set dataplane_started to false upon
 failure
Message-ID: <bd116301a1fc4a89c6aea055a4d87a03c69513cf.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Commit e24a47c5b73e ("virtio-scsi: do not use vring in dataplane") set
dataplane_started to true when virtio_scsi_dataplane_start() fails. This
is likely a typo since dataplane is not functional after failure.

The non-ioeventfd fallback is broken because dataplane_started is true
after virtio_scsi_dataplane_start() failure. As a result, the following
assertion failure occurs when a virtio-scsi device exceeds the open file
descriptor ulimit when setting up notifiers (eventfds):

  $ ulimit -n 104 # exact number can vary based on QEMU version
  $ qemu-system-x86_64 -M q35,accel=kvm -m 1G -cpu host -smp 14 \
         --blockdev file,node-name=drive0,filename=test.img,cache.direct=on,aio=native \
         --blockdev file,node-name=drive1,filename=data01.img,cache.direct=on,aio=native \
         --device virtio-scsi-pci,id=virtio-scsi-pci0 \
         --device scsi-hd,drive=drive0,bus=virtio-scsi-pci0.0 \
         --device virtio-scsi-pci,id=virtio-scsi-pci1 \
         --device scsi-hd,drive=drive1,bus=virtio-scsi-pci1.0
  qemu: virtio-scsi: Failed to set guest notifiers (-24), ensure -accel kvm is set.
  qemu: virtio_bus_start_ioeventfd: failed. Fallback to userspace (slower).
  qemu-system-x86_64: ../hw/scsi/virtio-scsi.c:1017: virtio_scsi_reset: Assertion `!s->dataplane_started' failed.
  Aborted                    (core dumped)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Fixes: e24a47c5b73e ("virtio-scsi: do not use vring in dataplane")
Buglink: https://redhat.atlassian.net/browse/RHEL-193328
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260825154854.263819-1-stefanha@redhat.com>
---
 hw/scsi/virtio-scsi-dataplane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 95f13fb7c2..bcb6e44133 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -230,7 +230,7 @@ fail_host_notifiers:
 fail_guest_notifiers:
     s->dataplane_fenced = true;
     s->dataplane_starting = false;
-    s->dataplane_started = true;
+    s->dataplane_started = false;
     return -ENOSYS;
 }
 
-- 
MST



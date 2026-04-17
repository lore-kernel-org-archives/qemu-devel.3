Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D02F4369F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 13:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDjDl-0003vO-CF; Fri, 17 Apr 2026 09:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wDjDj-0003vC-SV
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wDjDh-0008Qy-5d
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776432412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5FLvEUTJzBhjaMhsLSDKZhofMEBgN8vkhhO4bHBevMQ=;
 b=iu98LT1DHRW/SSo54wZ0b5xTTPFWdVw/KNsIGkZBOehkK0XuWGzh9pbKc1yNhCWbPfRJIc
 1G58JGCcHVNI4LkQ2/2qH7AS47WI6sE+hcfYxyk3rBSz7oBo46bzzc2Sljo1HnR7x6FpAe
 U95oCfWNi2A1F8T0zJVD2TCtjVz9GI0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170--gpnIhwdNsmEv0BPFOEjPw-1; Fri, 17 Apr 2026 09:26:51 -0400
X-MC-Unique: -gpnIhwdNsmEv0BPFOEjPw-1
X-Mimecast-MFC-AGG-ID: -gpnIhwdNsmEv0BPFOEjPw_1776432410
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso7447565e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 06:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776432409; x=1777037209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5FLvEUTJzBhjaMhsLSDKZhofMEBgN8vkhhO4bHBevMQ=;
 b=INVr6NQ7L1yaz+iCvnCQm49XmtpwXqXB/UpssZH0XMoesv5hUrferfldf30IgosFwh
 iOqUSGchvCMf8HUBJj8KRX6kNWf8XA92Yx/tYxgmg3r6xpfeDGjmRfR4NrpXmFVbL4gD
 C3Jz6Q/6kRo8MZgPWk2Vkv+zdQXJ/+m0PpCbruFFVx5LvVmqOrx2CFMikCaaDmr5hrXr
 Z0/VPOqtrrPWJbr9wIjaCBDde24rIH1xtjEJwZdDZ9Lcm6pFgMbT8Xlb7byUjImgZV/K
 1Y2ntHlp7imNTGTLxXqww9KG8OcxV3Tbx2k5+tf9wZ//XA+KUFrlt2O0Scj6ogZP3NTN
 co/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776432409; x=1777037209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5FLvEUTJzBhjaMhsLSDKZhofMEBgN8vkhhO4bHBevMQ=;
 b=lTwTYDwjjpZWx//+CG7UHyFwgKPCRt+tlrhG4KANZ/UktI4oiT34x22tQNM6VhcbwU
 LqR/p/T4P4+Gs2MKN2c80ibh4ozALyVrFrdRqWS0uf6oAreeU9341z4P2GFDm9HoJH4H
 7ej5/hJHVuDanVCGq4U/QJ7ELhvQ0821MIKyHjW5cmhJEKKWAYZpPGIOLwN+hliy8R4t
 aMs82SavqksEYeDpd3+1PRsQGHLcWqKOmREI+bQQzHOevHDJlXUlA/tvlXxOibXxlVPE
 fnX3vUgn2F2YPQIZ1tOK263VVCy8bfLfJmncbTM6ivlkcErIHF2yUNAihSB0q2XWhQRb
 bHzg==
X-Gm-Message-State: AOJu0Yw/K0GZVhSs2+qvI8mkPNqx2P/giXAg1m+DD0xIwfS2sGPtZ/Wd
 hhlOgVc7H6fW4k8FUY3XcO2IQHK10F/nrEBzdccPUcsXclCjRUlIZz9BYIBe94w+acoI1pLNDaX
 tL0so6mC/12stqPvvO+ceAzh4dbkECgdFsrAO9FHrO9QLs2KMTlUVryb8HBcatCG/jzSShFzvh6
 YIGcNAM8GIlsPwsc4QOckhvfYkHGJBqkEH9yc8Rdfe
X-Gm-Gg: AeBDiet7EsY1aRdGOGaQvlWFPdL07zkC1QNfE5MNRg0gPYnF4eF/XvziKOmiKN6stxk
 6QkmyYHF1QV0/d4+Qgzgvq7wJZSgHcBofdlq/FhgTibSxG7TlqNr2JDhuTc67WymsWtqjTruDW0
 8R7l52DbgmE0aMh10qcQth6ZOtoGDLJn8/DG4Rlr2f8gHLDKSvjaOMhoDvBTpm/OsEDp1j7W6RN
 UlzJTpAedPQxEYYRccTO0nGxyrc3AwIsL9mcXHL09F1+95eQVLZM8U+tGby0mlBR0p5pt+UYVG9
 WPfdStzCO9yBbO3g8/1LSA4Rgyx/7QPNu/uQ0McKUQ5eBlXN3XCgxtxqqtnl/Pdbq4/yjSeHj18
 f5DP9rWK5IpU+b69brOSCxlvwKEl+jF6HpilFhwCeSD8Yxu7cTOzGs5Sv3U9Ocki091wlY1WcE3
 Va8ZJGZyLf
X-Received: by 2002:a05:600c:8115:b0:488:8577:d9cc with SMTP id
 5b1f17b1804b1-488fb77faacmr38425205e9.20.1776432408732; 
 Fri, 17 Apr 2026 06:26:48 -0700 (PDT)
X-Received: by 2002:a05:600c:8115:b0:488:8577:d9cc with SMTP id
 5b1f17b1804b1-488fb77faacmr38424785e9.20.1776432408160; 
 Fri, 17 Apr 2026 06:26:48 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-16-204-83.retail.telecomitalia.it.
 [87.16.204.83]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc177dafsm56757575e9.4.2026.04.17.06.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 06:26:47 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xie Yongji <xieyongji@bytedance.com>, qemu-stable@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 0/2] libvhost-user,
 libvduse: fix buffer overflow (CVE-2026-6425)
Date: Fri, 17 Apr 2026 15:26:43 +0200
Message-ID: <20260417132645.121192-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A guest-triggerable buffer overflow was reported in libvhost-user.
When an indirect descriptor table crosses a memory region boundary,
virtqueue_read_indirect_desc() falls back to a chunked copy, but
the destination pointer is a struct vring_desc pointer advanced by
a byte count, so it overflows the buffer.

libvduse has vduse_queue_read_indirect_desc() which was inspired by
the libvhost-user counterpart, so it has the same issue.

Stefano Garzarella (2):
  libvhost-user: fix buffer overflow in virtqueue_read_indirect_desc()
  libvduse: fix buffer overflow in vduse_queue_read_indirect_desc()

 subprojects/libvduse/libvduse.c           | 7 ++++---
 subprojects/libvhost-user/libvhost-user.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.53.0



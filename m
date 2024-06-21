Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAF7C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZZa-0008NO-16; Fri, 21 Jun 2024 04:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKZZX-0008Mg-1d
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKZZV-0003GR-FR
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718958276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TFwkPEil3RhQ1ag2338azPs9GtKaIzukwqTqnt+O+cE=;
 b=ZDGWQZptzYOrmYvt+T79s8fcecbqDnYhfF/u+A4D9MTI537kPNezNclItB0ABf9F6sa3dB
 GlQrIHN3u6TmAwwG2Xq12JBGoCEjhs8YSEbSK9I31bLHwDumK0OJfIP4kGCGjeLTrv+I1R
 xAEVRUNRozSGfrpBzg//C75MJ79aaAE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-Kxjj2rD-OSCoGF74NoktVw-1; Fri,
 21 Jun 2024 04:24:31 -0400
X-MC-Unique: Kxjj2rD-OSCoGF74NoktVw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32A631955E84; Fri, 21 Jun 2024 08:24:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.213])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9EB6A1956087; Fri, 21 Jun 2024 08:24:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Collin L . Walling" <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PATCH 0/7] pc-bios/s390-ccw: Merge the netboot loader into
 s390-ccw.img
Date: Fri, 21 Jun 2024 10:24:15 +0200
Message-ID: <20240621082422.136217-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

We originally built a separate binary for the netboot code since it
was considered as experimental and we could not be sure that the
necessary SLOF module had been checked out. Time passed, the netboot
code proved its usefulness, and the build system nowadays makes sure
that the SLOF module is checked out if you have a s390x compiler available
for building the s390-ccw bios. In fact, the possibility to build the
s390-ccw.img without s390-netboot.img has been removed in commit
bf6903f6944f ("pc-bios/s390-ccw: always build network bootloader")
already.

So it does not make too much sense anymore to keep the netboot code
in a separate binary. To make it easier to support a more flexible
boot process soon that supports more than one boot device via the
bootindex properties, let's finally merge the netboot code into the
main s390-ccw.img binary now.

Thomas Huth (7):
  pc-bios/s390-ccw: Remove duplicated LDFLAGS
  hw/s390x/ipl: Provide more memory to the s390-ccw.img firmware
  pc-bios/s390-ccw: Use the libc from SLOF for the main s390-ccw.img
    binary, too
  pc-bios/s390-ccw: Link the netboot code into the main s390-ccw.img
    binary
  hw/s390x: Remove the possibility to load the s390-netboot.img binary
  pc-bios/s390-ccw: Merge netboot.mak into the main Makefile
  docs/system/s390x/bootdevices: Update the documentation about network
    booting

 docs/system/s390x/bootdevices.rst |  20 +++----
 pc-bios/s390-ccw/netboot.mak      |  62 ---------------------
 hw/s390x/ipl.h                    |  12 ++--
 pc-bios/s390-ccw/cio.h            |   2 +
 pc-bios/s390-ccw/iplb.h           |   4 +-
 pc-bios/s390-ccw/libc.h           |  89 ------------------------------
 pc-bios/s390-ccw/s390-ccw.h       |  10 +++-
 pc-bios/s390-ccw/virtio.h         |   1 -
 hw/s390x/ipl.c                    |  65 +++-------------------
 hw/s390x/s390-virtio-ccw.c        |  10 +---
 pc-bios/s390-ccw/bootmap.c        |   4 +-
 pc-bios/s390-ccw/cio.c            |   2 +-
 pc-bios/s390-ccw/dasd-ipl.c       |   2 +-
 pc-bios/s390-ccw/jump2ipl.c       |   2 +-
 pc-bios/s390-ccw/libc.c           |  88 -----------------------------
 pc-bios/s390-ccw/main.c           |  15 +++--
 pc-bios/s390-ccw/menu.c           |  25 ++++-----
 pc-bios/s390-ccw/netmain.c        |  15 +----
 pc-bios/s390-ccw/sclp.c           |   2 +-
 pc-bios/s390-ccw/virtio-blkdev.c  |   1 -
 pc-bios/s390-ccw/virtio-scsi.c    |   2 +-
 pc-bios/s390-ccw/virtio.c         |   2 +-
 pc-bios/meson.build               |   1 -
 pc-bios/s390-ccw/Makefile         |  69 +++++++++++++++++++----
 pc-bios/s390-netboot.img          | Bin 67232 -> 0 bytes
 25 files changed, 122 insertions(+), 383 deletions(-)
 delete mode 100644 pc-bios/s390-ccw/netboot.mak
 delete mode 100644 pc-bios/s390-ccw/libc.h
 delete mode 100644 pc-bios/s390-ccw/libc.c
 delete mode 100644 pc-bios/s390-netboot.img

-- 
2.45.2



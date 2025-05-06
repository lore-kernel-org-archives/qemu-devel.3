Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAECC3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 06:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCBgn-0007w1-QJ; Tue, 06 May 2025 02:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCBgm-0007vZ-2v
 for qemu-devel@nongnu.org; Tue, 06 May 2025 02:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCBgk-0005pc-3b
 for qemu-devel@nongnu.org; Tue, 06 May 2025 02:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746512517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bVXed4CfJ5N/1Rk4tLCVRixEk751sgzBwiMjmwL5gh8=;
 b=d7zGrKbd4Jhgw34baKuLL0DvQkbB76PAwBGUyzfqUsNobKny+ItXK1b9vnGYJ5A6DAGI6u
 tFE4lve9dMQ+t9ftwtDCRdwwMKNXhKK9qblCuNDvxwew7rV9r8FB0O3pXQgrOGkExaot1n
 2ofWrZmMR4vV5LUYse0UtieLiPbKdZg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-Z8tjab0COwS9KmE-YHuIbQ-1; Tue,
 06 May 2025 02:21:54 -0400
X-MC-Unique: Z8tjab0COwS9KmE-YHuIbQ-1
X-Mimecast-MFC-AGG-ID: Z8tjab0COwS9KmE-YHuIbQ_1746512513
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F25631956048; Tue,  6 May 2025 06:21:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.237])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0AE0B18001D5; Tue,  6 May 2025 06:21:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/9] s390x: Remove deprecated machine types up to v4.0
Date: Tue,  6 May 2025 08:21:39 +0200
Message-ID: <20250506062148.306084-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The machine types up to s390-ccw-virtio-4.0 are older than 6 years
and thus, according to our support policy, are scheduled for being
deletion now. These patches remove the machines and clean up the
related compatibility handling that is not required anymore.

v2:
- Some patches are already upstream, thus dropped them from the series
- Split the patch to remove 2.10 and 2.11 into two separate patches
  (for consistency with other patches)
- Fixed a problem with the QemuFeatDef feature set

Thomas Huth (9):
  hw/s390x/s390-virtio-ccw: Remove the deprecated 2.10 machine type
  hw/s390x/s390-virtio-ccw: Remove the deprecated 2.11 machine type
  hw/s390x/event-facility: Remove the obsolete "allow_all_mask_sizes"
    code
  target/s390x: Rename the qemu_V2_11 feature set to qemu_MIN
  hw/s390x/s390-virtio-ccw: Remove the deprecated 2.12 machine type
  hw/s390x/s390-virtio-ccw: Remove the deprecated 3.0 machine type
  hw/s390x: Remove the obsolete hpage_1m_allowed switch
  hw/s390x/s390-virtio-ccw: Remove the deprecated 3.1 machine type
  hw/s390x/s390-virtio-ccw: Remove the deprecated 4.0 machine type

 include/hw/s390x/s390-virtio-ccw.h |   4 -
 hw/s390x/event-facility.c          |  37 +-------
 hw/s390x/s390-virtio-ccw.c         | 131 -----------------------------
 target/s390x/gen-features.c        |  13 +--
 target/s390x/kvm/kvm.c             |   6 --
 5 files changed, 4 insertions(+), 187 deletions(-)

-- 
2.49.0



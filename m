Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B267606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c+QEHZyh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMZGH-0005p6-7V; Thu, 29 Oct 2026 19:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMZGB-0005oK-UV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMZG8-0004tZ-AM
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793315409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Mo0NKJ5nYx1OHmJI/AhW+idTQR4QlQSCQa/aAzOK6LI=;
 b=c+QEHZyhhK4UQqFVwidHSMoa/jPSs+f+kl0ufR0hYCz7sce4RhjxYTQ0Sb0umMBV2KO0Oe
 lqbLW0uIL/BsAIZC9kuXhW50FKsTwIbzE0FuudvYYSVmbHJzP17NYEr5QxPy+2ksQIxx/4
 69gwn/QLB8xrNC34vqBvPWur0m3d5R8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-urPWIRSAPZ-TG1SEQz62ag-1; Thu,
 29 Oct 2026 19:10:08 -0400
X-MC-Unique: urPWIRSAPZ-TG1SEQz62ag-1
X-Mimecast-MFC-AGG-ID: urPWIRSAPZ-TG1SEQz62ag_1793315407
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B316B1953991; Thu, 29 Oct 2026 23:10:06 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C9AA30002CB; Thu, 29 Oct 2026 23:10:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, mst@redhat.com,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] virtio-blk: Deprecate silent truncation of serial
Date: Fri, 30 Oct 2026 00:09:57 +0100
Message-ID: <20261029231001.194240-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QEMU has allowed the user to specify serials of arbitrary length for
virtio-blk devices, even though the virtio-blk protocol can only
communicate 20 characters of the serial to the guest. This means that a
longer serial number on the command line is silently truncated to 20
characters from the guest perspective.

As a first step to fix this, deprecate the silent truncation and turn it
into a warning; we can later make this a hard error. While touching
GET_ID, let's make it more spec compliant and clean up the internal
state.

Another part is planned that will actually enable users to use longer
serials and additional device identifiers. This will need spec changes
and would take more time than we have until the QEMU 11.2 freeze anyway,
so I'll address this later. For now, the important thing is to get the
deprecation period started.

v2:
- Drop truncation of qdev property for now [Stefan]
- Add test case for exactly 20 characters [Stefan]
- Fix missing guest_free() [Stefan]
- Pass pattern_byte to get_id_request() instead of hardcoding it
  [Stefan]

Kevin Wolf (4):
  virtio-blk: Implement full NUL padding for GET_ID
  virtio-blk-test: Add a basic GET_ID test case
  virtio-blk: Deprecate silent truncation of serial
  virtio-blk-test: Test truncated serial

 docs/about/deprecated.rst     |  13 ++++
 hw/block/virtio-blk.c         |  18 +++--
 tests/qtest/virtio-blk-test.c | 119 ++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 4 deletions(-)

-- 
2.56.0



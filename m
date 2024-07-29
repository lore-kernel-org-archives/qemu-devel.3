Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A60C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 09:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYMyM-0003DR-Ok; Mon, 29 Jul 2024 05:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sYMyL-0003Cv-SL
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sYMyJ-0004YL-Qe
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722246433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xb+BN4b1zWwX8br0aAaM5kJm4JTZN4RwRpyG1ARW1ds=;
 b=PuhaFCFH/LdRmuGHv6nrGTNhpdqXRixajaf7fs0j2B+ZEsWPdRE/bylY2BJrnq9BquVV0U
 jQUMCq5RjSLXhmRfPhEdwNth4QW69ZN4SKNtg6CxqndPQ5r/n7iTdLRrBpl//E+kSKfG8L
 RpzNKuBOLV4/s5NUniQj3oxOfpFYpwQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-VNV2tDAdPjuGsOx7LUr61g-1; Mon,
 29 Jul 2024 05:47:10 -0400
X-MC-Unique: VNV2tDAdPjuGsOx7LUr61g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ECC819560BF; Mon, 29 Jul 2024 09:47:09 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.89])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 713B71955F40; Mon, 29 Jul 2024 09:47:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 0/4] scsi-block: Fix error handling with r/werror=stop
Date: Mon, 29 Jul 2024 11:46:57 +0200
Message-ID: <20240729094702.50282-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Running validation tests in Windows 2019's Failover Cluster Manager
fails in two different ways when run with rerror/werror=stop:

1. It runs into an assertion failure because the sgio-based I/O path
   takes shortcuts in its error handling that skip necessary cleanup

2. RESERVATION_CONFLICT is treated as a host error and stops the VM,
   which in some cases can't be resumed at all because nothing will make
   the error go away on retry. The error should always go to the guest
   instead, it's an invalid request from the guest.

This series fixes these problems.

Kevin Wolf (4):
  scsi-disk: Use positive return value for status in dma_readv/writev
  scsi-block: Don't skip callback for sgio error status/driver_status
  scsi-disk: Add warning comments that host_status errors take a
    shortcut
  scsi-disk: Always report RESERVATION_CONFLICT to guest

 hw/scsi/scsi-disk.c | 53 +++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4188C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 12:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ8VD-00023y-DM; Wed, 31 Jul 2024 08:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sZ8VB-00020I-UE
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sZ8VA-00046D-HY
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722429139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z/uiMfzB513CBRTKXjBJZePpGg7cf/Zjba5IDHN79WQ=;
 b=hx8uEL2Na+Dfbx51ADjUUcMiPNHd0E/IR2XwmF+sTAMyASe6WNGx8MHY6i+1zEgpybTQ8v
 jWsVRt/UMeUDT0Jm8UiXWc5gaUQeO3ppIM3t9eV59w58H8lpWepqob6R2yX1S/xCAT3xCM
 VgLE/MhsHCGGAC9wgjEdOGQISIEmbCo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-bOTCx2WrOde0vBRCuBc5Zg-1; Wed,
 31 Jul 2024 08:32:16 -0400
X-MC-Unique: bOTCx2WrOde0vBRCuBc5Zg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24FED19054E3; Wed, 31 Jul 2024 12:32:15 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.1])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB29219560B2; Wed, 31 Jul 2024 12:32:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] scsi-block: Fix error handling with r/werror=stop
Date: Wed, 31 Jul 2024 14:32:03 +0200
Message-ID: <20240731123207.27636-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

v2:
- Patch 4: [Paolo]
  * Set error = 0 explicitly, remove useless variable initialisation
  * Add comment to explain why we consider it a guest error
  * Mention scsi-block specifically in the commit message

Kevin Wolf (4):
  scsi-disk: Use positive return value for status in dma_readv/writev
  scsi-block: Don't skip callback for sgio error status/driver_status
  scsi-disk: Add warning comments that host_status errors take a
    shortcut
  scsi-disk: Always report RESERVATION_CONFLICT to guest

 hw/scsi/scsi-disk.c | 73 +++++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 22 deletions(-)

-- 
2.45.2



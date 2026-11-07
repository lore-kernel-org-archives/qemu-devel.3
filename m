Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3158D606A326
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q678r+dy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPpN1-0007jo-1T; Sat, 07 Nov 2026 17:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xPpMz-0007jG-6f
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 17:58:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xPpMx-0002WJ-HR
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 17:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794092320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E/tfmy0/E41CqPzfZuxRFSaQdDdo86ZMcs2PMMnvEIo=;
 b=Q678r+dyB2juTnT/vmZWa6LyNPnzn+jrp5yngd/DEZQw0oK/hs1Tc9knQwQDT5H9LIst+6
 lTSivY+62HD26+NtRD0zfBtqjZnfgsj587XnM0+sZv13XzKNORX87rJDaN3WIifLtqg3gz
 WMguQ/Mb65WRMPOjRFimL5RAnRA3YWk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-BJLBF2xHPUOz4Cl64yNhPg-1; Sat,
 07 Nov 2026 17:58:37 -0500
X-MC-Unique: BJLBF2xHPUOz4Cl64yNhPg-1
X-Mimecast-MFC-AGG-ID: BJLBF2xHPUOz4Cl64yNhPg_1794092316
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68D551956089; Sat,  7 Nov 2026 22:58:36 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60D841956087; Sat,  7 Nov 2026 22:58:35 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	berrange@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH for-11.2 v2 0/3] Avoid low-severity NBD denial-of-service
 attack
Date: Sat,  7 Nov 2026 16:54:35 -0600
Message-ID: <20261107225834.778738-5-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AI found a way to trip an assertion failure by sending a particular
BLOCK_STATUS command in violation of the NBD protocol, documented at
https://gitlab.com/qemu-project/qemu/-/work_items/3796 and again at
https://gitlab.com/qemu-project/qemu/-/work_items/4091. Since the
attack can be trivially avoided by using TLS + x509 certificates to
avoid untrusted clients avoiding the protocol non-compliance, I'm
posting the patch now, rather than waiting for a CVE assignment, per
https://www.qemu.org/contribute/security-process/

v1: https://lists.nongnu.org/archive/html/qemu-devel/2026-11/msg01615.html
- since then, adjust wording based on Dan's feedback
- add the NBD fix and a unit test

Eric Blake (3):
  docs: Mention security considerations for NBD
  nbd/server: Reject rather than assert on non-compliant BLOCK_STATUS
  iotests: Add new nbd-robustness test

 docs/system/security.rst                    |  21 +++
 nbd/server.c                                |   4 +-
 tests/qemu-iotests/tests/nbd-robustness     | 137 ++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-robustness.out |   5 +
 4 files changed, 165 insertions(+), 2 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-robustness
 create mode 100644 tests/qemu-iotests/tests/nbd-robustness.out

-- 
2.56.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019E0606A54B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XWdLTjZD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRzu5-0003sP-Pj; Fri, 13 Nov 2026 17:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRzu4-0003rv-KD
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 17:37:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRzu2-0007pG-Me
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 17:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794609469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MeyBMfXnr5O7WgpTtKOQCSjuYWLRsRo0zfUgrLXFI3E=;
 b=XWdLTjZD8HmNuVoELv7MdQku2Ko7O/TaqtwrVE+sTGsBppPEWXmV9PsHBZxjDEQqjuoNP2
 g7141jj82+19lZCAtqfsSufkhPhzbtC3zdh1tP5Nc+T3a2frhrSPKDFa9H1P+8sXRBH6HY
 abUgtVraEhXOMrJLGCVZyvJBFsyb1eY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-JqA0_E83NLeM0gpDtSeLWg-1; Fri,
 13 Nov 2026 17:37:46 -0500
X-MC-Unique: JqA0_E83NLeM0gpDtSeLWg-1
X-Mimecast-MFC-AGG-ID: JqA0_E83NLeM0gpDtSeLWg_1794609465
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ADDE1956053; Fri, 13 Nov 2026 22:37:45 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC50A1956086; Fri, 13 Nov 2026 22:37:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	qemu-stable@nongnu.org,
	bea1e@proton.me
Subject: [PATCH for-11.2 0/4] Another NBD CVE fix: incomplete read
Date: Fri, 13 Nov 2026 16:34:48 -0600
Message-ID: <20261113223742.2546619-6-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://gitlab.com/qemu-project/qemu/-/work_items/3815

This one is a bug with QEMU as NBD client leaking qemu heap data under
the influence from a malicious server. Not as dramatic as the
denial-of-service attacks that my two CVE fixes earlier this week
(those were both assertion failures on QEMU as NBD server to a
malicious client), but the data exfiltration may make other attacks on
QEMU easier to pull off.  As before, the ability to insist on TLS and
perform x509 cert checks reduces the risk when you restrict NBD
connections to assumed-safe servers.

Eric Blake (4):
  nbd: Refactor structured payload interpretation
  nbd: Pass back offset/length for all structured read replies
  nbd/client: Don't leak uninitialized memory on malicious server
  nbd: Add iotest exposing previous CVE fix

 block/nbd.c                                   |  87 +++++--
 .../tests/nbd-structured-read-gaps            | 215 ++++++++++++++++++
 .../tests/nbd-structured-read-gaps.out        |   5 +
 3 files changed, 293 insertions(+), 14 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-structured-read-gaps
 create mode 100644 tests/qemu-iotests/tests/nbd-structured-read-gaps.out

-- 
2.56.0



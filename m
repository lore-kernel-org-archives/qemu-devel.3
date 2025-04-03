Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBBEC3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Swk-0005uf-7X; Thu, 03 Apr 2025 18:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u0Swc-0005tr-42
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u0SwW-0006Ii-TA
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743718905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5wR4aGBjzJI8E30RW08e4qGd51Uo93ETZN08GvHd2HY=;
 b=KK4EcxwOkYZrdzx2o/5nPY9omgq7WsTs+ciYQbG2XAYlYw7v+lAW5GkLBsqvGRdQtW0BkT
 KyAx2t0Zs+kdVs+l+mgOP4BKwU/5FpJj6DhZ9RKpJwylMeVjPhi/Us2X5pMXItLTzEGatA
 rF65OPFVnwIMfx/wMvDL4psKGeGo1DQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-VkVM5UeQNou9UiYaoh1G5A-1; Thu,
 03 Apr 2025 18:21:43 -0400
X-MC-Unique: VkVM5UeQNou9UiYaoh1G5A-1
X-Mimecast-MFC-AGG-ID: VkVM5UeQNou9UiYaoh1G5A_1743718902
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7962B19560BC
 for <qemu-devel@nongnu.org>; Thu,  3 Apr 2025 22:21:42 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.8])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DBBDB180A803
 for <qemu-devel@nongnu.org>; Thu,  3 Apr 2025 22:21:41 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL -rce 0/1] NBD patches for 2025-04-03
Date: Thu,  3 Apr 2025 17:19:26 -0500
Message-ID: <20250403222139.1317475-3-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 0adf626718bc0ca9c46550249a76047f8e45da15:

  Update version for v10.0.0-rc2 release (2025-04-01 13:15:45 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2025-04-03

for you to fetch changes up to 961841472d25ab70642d182e486b36afeb3fef26:

  Revert "iotests: Stop NBD server in test 162 before starting the next one" (2025-04-03 16:57:57 -0500)

----------------------------------------------------------------
NBD patches for 2025-04-03

- revert iotest 162 workaround, now that qemu-nbd bug is fixed

----------------------------------------------------------------
Thomas Huth (1):
      Revert "iotests: Stop NBD server in test 162 before starting the next one"

 tests/qemu-iotests/162 | 1 -
 1 file changed, 1 deletion(-)

Low risk for -rc3 (only affects iotest not main binaries), but that
also means that given how close we are to release, it's also okay if
it gets delayed if nothing else that actually needs -rc3 surfaces.

-- 
2.48.1



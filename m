Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C784EC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 10:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9iFs-0000Zi-Ix; Tue, 29 Apr 2025 06:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1u9iFm-0000RC-IX; Tue, 29 Apr 2025 06:31:54 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1u9iFi-0007Q9-GM; Tue, 29 Apr 2025 06:31:53 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id 60CBF1520EAE;
 Tue, 29 Apr 2025 12:31:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1745922698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=z5lX2oOTTWrWTLFLJ3cBHwUGD75JBr8YAaCk3kvF4BU=;
 b=TBzG7rnHRX1VfAzG0T9Gyh41TIp8Al5zzpEkTAuPIE4QovhvYiX1eHkpoq3Ac+NH+kh3zs
 8uJW9OijhPKjc7tF65pJ4r6LB7y4ghOTQUYLOKkMG6ItNIoEIj9u8+8m4m6ptHC3y8k6T3
 lGtEkhjJVP0qPVsCdeOVe4n7P0JwFA4WuYHVmacUJ75vM5L70UyS1UtHcx6Z0MU769ODJD
 w2ekXSS3baIlT+dGahQdL5lesKnVIe6PcUwrDZgMpO9I0uEa4GnjkA9oxneAp2xRKsXqFA
 CtLH9UBhy0N+uRYpVYyKkIGPN60xj139vmpZq6uj38xHZzgzZ+dr3hObXl4w+Q==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH 0/2] qcow2: queue discards when discard-no-unref enabled
Date: Tue, 29 Apr 2025 12:31:08 +0200
Message-ID: <20250429103110.761910-1-jean-louis@dupond.be>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Partially based on the proposal of Andrey in
https://patchew.org/QEMU/20240913163942.423050-1-andrey.drobyshev@virtuozzo.com/
Split up this from the rest might get it merged a bit quicker hopefully :)

Since the implementation of discard-no-unref, we did not queue the discards correctly
when discard-no-unref was enabled.

Jean-Louis Dupond (2):
  qcow2: rename update_refcount_discard to queue_discard
  qcow2: put discards in discard queue when discard-no-unref is enabled

 block/qcow2-cluster.c  | 16 ++++++----------
 block/qcow2-refcount.c | 25 +++++++++++++++++++++----
 block/qcow2.h          |  4 ++++
 3 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.49.0



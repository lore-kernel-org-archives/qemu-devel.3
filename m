Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44ED3CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 10:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBVrY-0000TC-9g; Wed, 22 Oct 2025 06:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBVrU-0000SH-4y
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBVrS-0000N8-5S
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761128068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XgrQgtsvhT478P9b/yzIirHz5rDq6Wp7Ehm2pI+bIKI=;
 b=d7mLpTi+h8Dw41pMIn3fqPt2vVQVbojksiPPK1tOVOJRwob79/EqQcyF1kHYO5M0W2hB3t
 H890blZqb8rH1UpnzcipzpDh4xS7qfi3kuPrz+Sh8H1XmdQIoOhx987HvXPMVgz4iVI9hb
 mGUUfcOOQ2KonZalrONCmXJXy0lngN4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-BjIvZ-jKMeWai8qnInueYA-1; Wed,
 22 Oct 2025 06:14:24 -0400
X-MC-Unique: BjIvZ-jKMeWai8qnInueYA-1
X-Mimecast-MFC-AGG-ID: BjIvZ-jKMeWai8qnInueYA_1761128064
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB6E11955EC2; Wed, 22 Oct 2025 10:14:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 327DD19560B4; Wed, 22 Oct 2025 10:14:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 70FDB21E6A27; Wed, 22 Oct 2025 12:14:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, philmd@linaro.org
Subject: [PATCH 0/3] qdev: Fix "info qtree" to show links
Date: Wed, 22 Oct 2025 12:14:17 +0200
Message-ID: <20251022101420.36059-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is an alternative to Marc-André's "[PATCH] RFC: qdev: add legacy
properties only for those print()-able"
Message-ID: <20251015105419.2975542-1-marcandre.lureau@redhat.com>

Markus Armbruster (3):
  qdev: Change PropertyInfo method print() to return malloc'ed string
  qdev: Fix "info qtree" to show links
  qdev: Legacy properties are now unused, drop

 include/hw/qdev-properties.h     |  2 +-
 hw/core/qdev-properties-system.c |  7 ++---
 hw/core/qdev-properties.c        | 47 --------------------------------
 system/qdev-monitor.c            |  7 ++---
 4 files changed, 7 insertions(+), 56 deletions(-)

-- 
2.49.0



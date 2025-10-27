Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D1DCCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 09:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDJ5F-0004Bb-PH; Mon, 27 Oct 2025 05:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDJ58-0004Ae-Pg
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDJ56-0002Yk-I4
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761555598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id; bh=OgOqHzECojrio+QiUpINwgy3noG5LmHAkBJz/ivQpTA=;
 b=FhIeivCQRccur3RIG3MpmQIN1ZCKM8yWCiPjooTgHGcks27MmaOZzRI+0nlWIHJcbprdF5
 hfKkEVCikW4Ve/3Yit/8TOfuyACQSUGgfr+LMxL1YQX93hGN9I9239aa8CAL09d2Sb+AGL
 z9zuwzEjFnefxELQyEQEQwoom/4AnDI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-3H0xH6_sOkWTSOhD881KtQ-1; Mon,
 27 Oct 2025 04:59:54 -0400
X-MC-Unique: 3H0xH6_sOkWTSOhD881KtQ-1
X-Mimecast-MFC-AGG-ID: 3H0xH6_sOkWTSOhD881KtQ_1761555592
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FFD11801375; Mon, 27 Oct 2025 08:59:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 182F619560AD; Mon, 27 Oct 2025 08:59:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5E4C921E6924; Mon, 27 Oct 2025 09:59:48 +0100 (CET)
Resent-To: guobin@linux.alibaba.com, qemu-devel@nongnu.org, farosas@suse.de
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 27 Oct 2025 09:59:48 +0100
Resent-Message-ID: <87ms5cpvnf.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Mon Oct 27 07:45:03 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E5D921E6A27; Mon, 27 Oct 2025 07:45:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 guobin@linux.alibaba.com
Subject: [PATCH 0/3] migration: Cleanup around MigMode sets
Date: Mon, 27 Oct 2025 07:45:00 +0100
Message-ID: <20251027064503.1074255-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Markus Armbruster (3):
  migration: Use unsigned instead of int for bit set of MigMode
  migration: Use bitset of MigMode instead of variable arguments
  migration: Put Error **errp parameter last

 include/migration/blocker.h |  9 ++----
 include/migration/misc.h    | 10 +++----
 hw/vfio/container-legacy.c  |  6 ++--
 hw/vfio/cpr-iommufd.c       |  6 ++--
 hw/vfio/cpr-legacy.c        |  8 +++---
 hw/vfio/cpr.c               |  5 ++--
 hw/vfio/device.c            |  4 +--
 migration/migration.c       | 57 +++++++++----------------------------
 stubs/migr-blocker.c        |  2 +-
 system/physmem.c            |  8 +++---
 10 files changed, 40 insertions(+), 75 deletions(-)

-- 
2.49.0




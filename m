Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A966FCEE32A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNvt-0004Xk-UA; Tue, 18 Nov 2025 10:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLNvd-0004UF-R4
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:47:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLNvb-0001tK-KI
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763480853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XlFPm/6Vn5//ageUIgCDyho1oWvAIX14rUHJmHVn7ws=;
 b=LAvtAm7C0Ut9rAGqDrqW8+DX8/HTGqIVsitJpmJ8BpVc2apcoUL+XJlq7/0md3owMX8U6m
 TkvmB32smHIXdBeeGzy93+5qRvWj4YaPJcAMCoCbCwTHyLnfgSZoYpPtbSzscJ3zp70NH0
 smzVXgxSwtZC+6bMyFbalI+LRqi/cgY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-USWRZq6zNva5JmDU_t7Vvw-1; Tue,
 18 Nov 2025 10:47:32 -0500
X-MC-Unique: USWRZq6zNva5JmDU_t7Vvw-1
X-Mimecast-MFC-AGG-ID: USWRZq6zNva5JmDU_t7Vvw_1763480851
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FA89189A345
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 15:47:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 025041800297
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 15:47:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1821421E6A27; Tue, 18 Nov 2025 16:47:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
	mst@redhat.com,
	berrange@redhat.com
Subject: [PATCH 0/3] ebpf: Error fixes and cleanups
Date: Tue, 18 Nov 2025 16:47:15 +0100
Message-ID: <20251118154718.3969982-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Note: not cc'ed to Andrew Melnychenko <andrew@daynix.com> and Yuri
Benditovich <yuri.benditovich@daynix.com> (R: in MAINTAINERS), because
e-mail to these addresses bounces.

Markus Armbruster (3):
  ebpf: Fix stubs to set an error when they return failure
  ebpf: Clean up useless error check in ebpf_rss_set_all()
  ebpf: Make ebpf_rss_load() return value consistent with @errp

 ebpf/ebpf_rss-stub.c |  4 +++-
 ebpf/ebpf_rss.c      | 10 +++-------
 hw/net/virtio-net.c  |  4 +---
 3 files changed, 7 insertions(+), 11 deletions(-)

-- 
2.49.0



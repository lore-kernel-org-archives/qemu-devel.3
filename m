Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C173510F6FDC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7zEe-000423-0T; Wed, 01 Apr 2026 13:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w7zEA-0003Et-8e
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w7zE8-0001IM-SJ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775063975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wa3tgXDwjHGBlgvCWZRQZZMqIWeIdAuwu3ajIUqnh6w=;
 b=cyWw8OhHHlQacYeyZm9qoEBrbS1FKc7AhBpc2+HDiHNwSKmf4oWhWkV3JNHiDGtrMJpnYs
 WW4QTu0Q/IFlJnEaVPxJ2Jh68r2/gHQpaI4vGW2hjtbXqbDDBaXpYMQTAVt3BDnpX77iia
 RNjV9HK6AUfgPluTgpBo7UpBraHQRD4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-FnQHFicmO6SezMUKGnFG6g-1; Wed,
 01 Apr 2026 13:19:33 -0400
X-MC-Unique: FnQHFicmO6SezMUKGnFG6g-1
X-Mimecast-MFC-AGG-ID: FnQHFicmO6SezMUKGnFG6g_1775063972
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9E22195608C; Wed,  1 Apr 2026 17:19:31 +0000 (UTC)
Received: from localhost (unknown [10.44.32.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6543C180058B; Wed,  1 Apr 2026 17:19:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, <qemu-stable@nongnu.org>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/3] scsi: PR live migration PREEMPT fixes
Date: Wed,  1 Apr 2026 13:19:24 -0400
Message-ID: <20260401171927.396672-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These patches are for QEMU 11.1 and 11.0-stable because they are not release
blockers.

Testing SCSI Persistent Reservation live migration with the Linux LIO iSCSI
target exposed two issues:

1. The LIO target interprets the request's TYPE field even though the spec says
   it should be ignored. This led to PREEMPT commands failing on the LIO
   target. Work around this by sending a "valid" TYPE field value. I have also
   contacted the LIO maintainers about improving spec-compliance but QEMU needs
   to work with existing targets.

2. The LIO target removes all matching registrations, including the I_T nexus
   that is sending the PREEMPT command, when PREEMPT is used to remove
   registrations rather than preempt a reservation. This actually appears to
   comply with the spec, but the hardware target I previously tested against
   would not remove the calling I_T nexus' registration and therefore QEMU's
   behavior was wrong. Implement a fix that works regardless of the target.

Stefan Hajnoczi (3):
  scsi: adjust error_prepend() formatting
  scsi: always send valid PREEMPT TYPE field
  scsi: register again after PREEMPT without reservation

 include/scsi/constants.h | 10 ++++++++++
 hw/scsi/scsi-generic.c   | 24 ++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9BAF433CC
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 23:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD9fc-00012o-MS; Wed, 15 Apr 2026 19:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wD9fb-00012J-DP
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wD9fZ-0000yY-0b
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776295753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eRDJeOhvEEg3buQqopkdMURfU8JKDrrhfEh08JWIev4=;
 b=AWON6AyWH9KlAan/wHedqcl5e4uAtCRAQMOa4nX67gEN9YcPsQpuMu/xaATYpkJikWAXzL
 Vd4g2lAPLlmPC99s3gdkeDvPCegI8NfEESyLbMtBwjbREqSyoOHhN/QnOtCmAzXAKObW+J
 HDMJ46eTF06hMBLwlUtrioUXrxOfrlc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-hQamaioCNbW0jfqx5fmfdQ-1; Wed,
 15 Apr 2026 19:29:12 -0400
X-MC-Unique: hQamaioCNbW0jfqx5fmfdQ-1
X-Mimecast-MFC-AGG-ID: hQamaioCNbW0jfqx5fmfdQ_1776295751
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 223D919560AA; Wed, 15 Apr 2026 23:29:11 +0000 (UTC)
Received: from localhost (unknown [10.44.34.70])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89D02180044F; Wed, 15 Apr 2026 23:29:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/2] scsi: handle reservation changes across migration
Date: Wed, 15 Apr 2026 19:29:04 -0400
Message-ID: <20260415232906.212349-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

The SCSI Persistent Reservation code can fail if another node has interfered
with the reservation (e.g. by sending a PERSISTENT RESERVE OUT command with a
PREEMPT or CLEAR service action). This is rare but can happen if the
application or clustering framework performs recovery and wants to take away
the guest's reservation.

This patch series adds an extra step when loading device state that
synchronizes the transferred vmstate against the actual reservation state of
the disk before moving the reservation. This way we can gracefully handle
changes to reservations that were performed externally.

Stefan Hajnoczi (2):
  scsi: change buf_size to unsigned int in scsi_SG_IO()
  scsi: handle reservation changes across migration

 include/hw/scsi/scsi.h |   3 +-
 hw/scsi/scsi-generic.c | 175 +++++++++++++++++++++++++++++++++++------
 2 files changed, 152 insertions(+), 26 deletions(-)

-- 
2.53.0



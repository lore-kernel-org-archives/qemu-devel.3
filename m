Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7702DCF65FA
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkLrM-0006D3-MN; Mon, 26 Jan 2026 07:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vkLr3-0000jt-L1
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 07:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vkLr2-0004cu-0g
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 07:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769431083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iilabDunhld8QTJn2zll31f5UPvfX3naGAzm/WruvZg=;
 b=eFpy32s1aUGDGKyHL/MJOFOPmEmbNXXMw+3bncsUqGx69MS2FTuHDrjAbCdMI1Nky6o567
 A+aqGjC+V4qDyM2BQAWtm3tGP+f1cfCSp4L10/yRewjGv42b11kSfndBgL1eidLynD/eyp
 SasPXzbP5uMO9OgROtf2xncrwc9MHp8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-4hLmxFPkPeWKirHyD2uqsw-1; Mon,
 26 Jan 2026 07:38:00 -0500
X-MC-Unique: 4hLmxFPkPeWKirHyD2uqsw-1
X-Mimecast-MFC-AGG-ID: 4hLmxFPkPeWKirHyD2uqsw_1769431079
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFCC61800451; Mon, 26 Jan 2026 12:37:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E36611958DC5; Mon, 26 Jan 2026 12:37:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9074E180009C; Mon, 26 Jan 2026 13:37:55 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Luigi Leonardi <leonardi@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 0/5] igvm: rework igvm file loading + processing, fix reset
Date: Mon, 26 Jan 2026 13:37:50 +0100
Message-ID: <20260126123755.357378-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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

v3:
 - Rebase to latest master, solve conflicts + build errors due
   to header files being moved around.
 - Pick up review tags.
 - No functional changes.
v2:
 - Reorganize igvm headers (new patch #1) to fix build problems
   in case the igvm library is not present.
 - Pick up review tags.

Gerd Hoffmann (5):
  igvm: reorganize headers
  igvm: make igvm-cfg object resettable
  igvm: move file load to complete callback
  igvm: add trace points for igvm file loading and processing
  igvm: move igvm file processing to reset callbacks

 include/qemu/typedefs.h        |  1 +
 include/system/igvm-cfg.h      | 12 +------
 include/system/igvm-internal.h | 33 ++++++++++++++++++
 include/system/igvm.h          |  2 +-
 backends/igvm-cfg.c            | 64 ++++++++++++++++++++++++++++++++--
 backends/igvm.c                | 16 ++++++---
 hw/i386/pc_piix.c              | 10 ------
 hw/i386/pc_q35.c               | 10 ------
 backends/trace-events          |  7 ++++
 9 files changed, 116 insertions(+), 39 deletions(-)
 create mode 100644 include/system/igvm-internal.h

-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA000D41C20
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 10:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTeJr-0007G8-Tr; Thu, 11 Dec 2025 05:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vTeJk-0007Dh-Cn
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:54:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vTeJj-0005Xn-1t
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765450477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iKvA6m5oXUQKXw+oh4D9SCHQUXQcy/ogXLLzMWIveec=;
 b=dMPQ02gbYp9lKvAdeiHxEz6/xaQaj5TJryAIUv7SoeWIXIUyl4XX1aRjSENdAIDzdbh04u
 N+07fMtDnAj4w0VvoyylwQssYFjx9o0BtOdtIiZ4WiqLmRa/6Gp+ubP2g3M+TLgbIuKU0h
 iUQVfdnPeMFEn2xLktQBiEyZliKRxhc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-bvoATO-jPPK89iTeuZWFjg-1; Thu,
 11 Dec 2025 05:54:24 -0500
X-MC-Unique: bvoATO-jPPK89iTeuZWFjg-1
X-Mimecast-MFC-AGG-ID: bvoATO-jPPK89iTeuZWFjg_1765450463
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 471B81800378; Thu, 11 Dec 2025 10:54:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.156])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ED4C30001A2; Thu, 11 Dec 2025 10:54:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CA91D1800608; Thu, 11 Dec 2025 11:54:19 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v2 0/5] igvm: rework igvm file loading + processing, fix reset
Date: Thu, 11 Dec 2025 11:54:14 +0100
Message-ID: <20251211105419.3573449-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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
 include/system/igvm-cfg.h      | 13 ++-----
 include/system/igvm-internal.h | 32 +++++++++++++++++
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D834CED624
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 12:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLKiQ-0004po-0e; Tue, 18 Nov 2025 07:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vLKiO-0004nk-Rp
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:21:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vLKiN-0005Et-26
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763468501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j9X5ArIPpXmGuSD+aF/cK5p0tzMysHblDvV3R1otnNI=;
 b=GMNkks1O0YefupwG1tI2t5PlXa6ZdXTUkHEtdo2MlAbxrtSNvjmiXph7LDP/y/aGWB5jWO
 WZRlMprPXS/DQXCUsmEO2IhfI8o4YdkrRhnppjhVthx2tREymEGIOzYcv2HWWECqFHdyUP
 bZMdWX0ujKUut3U8Imr4QgbVEMs0sJI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-zM7t2yK6Nianq8Y2zza5UQ-1; Tue,
 18 Nov 2025 07:21:38 -0500
X-MC-Unique: zM7t2yK6Nianq8Y2zza5UQ-1
X-Mimecast-MFC-AGG-ID: zM7t2yK6Nianq8Y2zza5UQ_1763468497
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3161618AB30A; Tue, 18 Nov 2025 12:21:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.167])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEE0D19560B0; Tue, 18 Nov 2025 12:21:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4B215182C024; Tue, 18 Nov 2025 13:21:33 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/4] igvm: rework igvm file loading + processing, fix reset
Date: Tue, 18 Nov 2025 13:21:28 +0100
Message-ID: <20251118122133.1695767-1-kraxel@redhat.com>
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



Gerd Hoffmann (4):
  igvm: make igvm-cfg object resetable
  igvm: move file load to complete callback
  igvm: add trace point for igvm file loading and processing
  igvm: move igvm file processing to reset callbacks

 include/system/igvm-cfg.h |  5 ++++
 include/system/igvm.h     |  1 +
 backends/igvm-cfg.c       | 53 ++++++++++++++++++++++++++++++++++++++-
 backends/igvm.c           | 14 +++++++----
 hw/i386/pc_piix.c         | 10 --------
 hw/i386/pc_q35.c          | 10 --------
 backends/trace-events     |  7 ++++++
 7 files changed, 74 insertions(+), 26 deletions(-)

-- 
2.51.1



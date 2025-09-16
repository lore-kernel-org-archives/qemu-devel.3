Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CDECAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 10:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uySy3-0005C8-DL; Tue, 16 Sep 2025 06:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uySxz-0005BO-DQ
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uySxw-0002Ch-C7
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758018671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HRRaP3YOh11DGKpKCBD7YcRfyGTOhHZ0vAs1/Yxy2kY=;
 b=YB/RDETo+SQxSMKeg769eJvzkjwlWiXbCEUdMFS4VT+6cZabggxVHbqAYQotXgIssu+tVQ
 c+yuT2i0d3E0ASp/12RPxfeaw3Vy1f8PeLGg7EdyXNeN482xiDudYrBTBvGUfYaBJJF3F3
 MMd7BHlTi8EzJUppzdGG19BxpChPpoc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-kmzyqjgzMZ6C-Ccw5TuDBw-1; Tue,
 16 Sep 2025 06:31:07 -0400
X-MC-Unique: kmzyqjgzMZ6C-Ccw5TuDBw-1
X-Mimecast-MFC-AGG-ID: kmzyqjgzMZ6C-Ccw5TuDBw_1758018666
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85E3718002C1; Tue, 16 Sep 2025 10:31:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.55])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D936D1956056; Tue, 16 Sep 2025 10:31:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7A0C51800399; Tue, 16 Sep 2025 12:31:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/2] igvm: add support for igvm memory map parameter in native
 mode
Date: Tue, 16 Sep 2025 12:31:01 +0200
Message-ID: <20250916103103.400662-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



Gerd Hoffmann (2):
  igvm: move igvm.h file to include/system
  igvm: add support for igvm memory map parameter in native mode

 {backends => include/system}/igvm.h |  5 ++++
 backends/igvm-cfg.c                 |  2 +-
 backends/igvm.c                     | 20 +++++++++----
 stubs/igvm.c                        | 21 ++++++++++++++
 target/i386/igvm.c                  | 44 +++++++++++++++++++++++++++++
 stubs/meson.build                   |  1 +
 target/i386/meson.build             |  3 ++
 7 files changed, 90 insertions(+), 6 deletions(-)
 rename {backends => include/system}/igvm.h (73%)
 create mode 100644 stubs/igvm.c
 create mode 100644 target/i386/igvm.c

-- 
2.51.0



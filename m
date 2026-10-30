Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6D9606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eEAWcu//
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMlJn-0004jC-Cx; Fri, 30 Oct 2026 08:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xMlJl-0004in-Qq
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xMlJk-0006Q9-DX
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793361763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dmEmHKeUPb7z3XCiANZ0X+bVbK5E+tjrqKtAHLhYHhQ=;
 b=eEAWcu//EGzLx+oQ2wGWGpOMmE7Ltg1OrILjJnekHlgi89THJsgU+L/HIi7eekrQ8h5J3S
 XpmWUFFok76B1OH/48+UR0NqUcs5L14bM/kuWkZ6ZpSJEJaY+lMDbhQ1Oxw0QpAOxnoksc
 JQ1c3CecT8lZ3ssPIGxPyxpBE8O0EAs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-zPcLGsdWMZyqgxhMmrAW7Q-1; Fri,
 30 Oct 2026 08:02:39 -0400
X-MC-Unique: zPcLGsdWMZyqgxhMmrAW7Q-1
X-Mimecast-MFC-AGG-ID: zPcLGsdWMZyqgxhMmrAW7Q_1793361758
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85F461954AC8; Fri, 30 Oct 2026 12:02:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.136])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D07927D6; Fri, 30 Oct 2026 12:02:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5FCEA18326C8; Fri, 30 Oct 2026 12:54:55 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?=C4=90=E1=BA=A1t=20Ng=C3=B4=20Qu=E1=BB=91c?= <datlechin@gmail.com>
Subject: [PATCH v2 2/2] pci id: assign pci subsystem id for osmates
Date: Fri, 30 Oct 2026 12:54:55 +0100
Message-ID: <20261030115455.1121808-3-kraxel@redhat.com>
In-Reply-To: <20261030115455.1121808-1-kraxel@redhat.com>
References: <20261030115455.1121808-1-kraxel@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allows the guest driver to identify the host implementation,
useful to be more specific when applying quirks etc.

OSMates is an open source VMM for macOS under MIT license.
It will be released in near future and will be available from
github.com/osmates.

Cc: Đạt Ngô Quốc <datlechin@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/specs/pci-ids.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 832f8bd1b802..45e0d22e71bd 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -50,6 +50,10 @@ maintained as part of the virtio specification.
   QEMU, such as the intel chipset devices.  Also used for virtio
   devices and generic pci class devices (1b36:00xx, see below).
 
+1af4:1101
+  PCI Subsystem ID for OSMates (github.com/osmates), will be used
+  for virtio devices and pci class devices (xhci, nvme).
+
 1af4:1110
   ivshmem device (:doc:`ivshmem-spec`)
 
-- 
2.56.0



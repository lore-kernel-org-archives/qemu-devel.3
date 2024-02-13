Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536EDC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxXg-0006hx-Pq; Tue, 13 Feb 2024 13:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rZxXe-0006hV-8E
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:30:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rZxXb-0001uY-UW
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707848999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIDmTnaAUiishdIiFaeP/BW6AbE5AkNMCdkImrTN2v0=;
 b=Cj+BMt0dAxXSnqABLMLvCLK0WDtOPr3VViRm8F4wKb8IsTlcudYiakAt2DvX2SNy58YKjo
 9qI8LB4KTaSlDdsCikOzhyoPSYN+QksZrvsJfnzgQ1ibOfXrbHR93xld0qqytT/L0KkSIu
 MnzlJejbz9jNYoseGMKkSvoKNVYeqII=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-UNU4iw8WN_albE_ioc9_5g-1; Tue, 13 Feb 2024 13:29:56 -0500
X-MC-Unique: UNU4iw8WN_albE_ioc9_5g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6A1C863061;
 Tue, 13 Feb 2024 18:29:55 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B648F40D1B60;
 Tue, 13 Feb 2024 18:29:52 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, mst@redhat.com,
 peter.maydell@linaro.org, clg@redhat.com, zhenzhong.duan@intel.com,
 yanghliu@redhat.com
Cc: alex.williamson@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v4 4/4] qemu-options.hx: Add an entry for virtio-iommu-pci and
 document aw-bits
Date: Tue, 13 Feb 2024 19:28:31 +0100
Message-ID: <20240213182933.825268-5-eric.auger@redhat.com>
In-Reply-To: <20240213182933.825268-1-eric.auger@redhat.com>
References: <20240213182933.825268-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We are missing an entry for the virtio-iommu-pci device. Add the
information on which machine it is currently supported and document
the new aw-bits option.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 qemu-options.hx | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 8547254dbf..6a8c970640 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1172,6 +1172,14 @@ SRST
     Please also refer to the wiki page for general scenarios of VT-d
     emulation in QEMU: https://wiki.qemu.org/Features/VT-d.
 
+``-device virtio-iommu-pci[,option=...]``
+    This is only supported by ``-machine q35`` and ``-machine virt``.
+    It supports below options:
+
+    ``aw-bits=val`` (val between 32 and 64, default depends on machine)
+        This decides the address width of IOVA address space. With
+        q35 it defaults to 39 bits. On arm virt it defaults to 48 bits.
+
 ERST
 
 DEF("name", HAS_ARG, QEMU_OPTION_name,
-- 
2.41.0



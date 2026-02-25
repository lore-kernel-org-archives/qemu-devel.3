Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD480EFD214
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvB5g-0002Hs-S9; Wed, 25 Feb 2026 04:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvB5f-0002DH-8G
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:21:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvB5d-0003We-Sz
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772011313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+idG/FNRcvgyo0Ya+dZvjy0Jls4f0CHw+qPTvohqBs=;
 b=PPz6LdlGfk07YPJRom2YeMgokgksiY6IdjYHfbiggczYruLxxtuf+cweFasIP572Kjga/p
 w2LN/jIgojn+Y6rC3xsKFB2rnd/pIoLdaWmnV+MwSxDUjqcecu5l2Gr7KM2F2ux9xMR9XQ
 SenUUzfewPTmXzjQIDqNLJo7zf5xSKE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-d500E929NxilmdmgiMoT-g-1; Wed,
 25 Feb 2026 04:21:49 -0500
X-MC-Unique: d500E929NxilmdmgiMoT-g-1
X-Mimecast-MFC-AGG-ID: d500E929NxilmdmgiMoT-g_1772011308
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4841C1956096; Wed, 25 Feb 2026 09:21:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.158])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24A2719560A2; Wed, 25 Feb 2026 09:21:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 12/16] hw/core/machine: Remove hw_compat_2_9[] array
Date: Wed, 25 Feb 2026 10:20:20 +0100
Message-ID: <20260225092024.794595-13-thuth@redhat.com>
In-Reply-To: <20260225092024.794595-1-thuth@redhat.com>
References: <20260225092024.794595-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The hw_compat_2_9[] array was only used by the pc-q35-2.9 and
pc-i440fx-2.9 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501210456.89071-16-philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/core/boards.h | 3 ---
 hw/core/machine.c        | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 71d6b234f68..e17bdb3dd96 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -877,7 +877,4 @@ extern const size_t hw_compat_2_11_len;
 extern GlobalProperty hw_compat_2_10[];
 extern const size_t hw_compat_2_10_len;
 
-extern GlobalProperty hw_compat_2_9[];
-extern const size_t hw_compat_2_9_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 848d0dc83d7..26af39d3ea5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -264,14 +264,6 @@ GlobalProperty hw_compat_2_10[] = {
 };
 const size_t hw_compat_2_10_len = G_N_ELEMENTS(hw_compat_2_10);
 
-GlobalProperty hw_compat_2_9[] = {
-    { "pci-bridge", "shpc", "off" },
-    { "intel-iommu", "pt", "off" },
-    { "virtio-net-device", "x-mtu-bypass-backend", "off" },
-    { "pcie-root-port", "x-migrate-msix", "false" },
-};
-const size_t hw_compat_2_9_len = G_N_ELEMENTS(hw_compat_2_9);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51361EFD214
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvB5Y-0001Hk-9j; Wed, 25 Feb 2026 04:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvB5V-00013M-TI
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:21:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvB5U-0003VT-Dt
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772011303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5G47PNfgQ5seBUdaqp1E/EwjqmlCyb4byiHzUBoKW0=;
 b=LkNDa4Quk90iT4A4H9TEjwtelYbL0F9dDXM0nKGBolWcKoeuM5xG6k8k/rPXrqLkbxczvB
 kPKDRUWsNZ0CoVQAEYZ/4NdIXeSJhRnlLVWxTHJCNCLiJz9WpDDQxY8aZbZJWnKyH9cgSD
 OggJv7Cmh06sTofskShbeuXfHMLeVnc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-SsRLB3ThOOKLGEsPmlHX0g-1; Wed,
 25 Feb 2026 04:21:38 -0500
X-MC-Unique: SsRLB3ThOOKLGEsPmlHX0g-1
X-Mimecast-MFC-AGG-ID: SsRLB3ThOOKLGEsPmlHX0g_1772011297
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86E711800613; Wed, 25 Feb 2026 09:21:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.158])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B82219560B6; Wed, 25 Feb 2026 09:21:31 +0000 (UTC)
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
Subject: [PATCH v2 10/16] hw/i386/pc: Remove deprecated pc-q35-2.9 and
 pc-i440fx-2.9 machines
Date: Wed, 25 Feb 2026 10:20:18 +0100
Message-ID: <20260225092024.794595-11-thuth@redhat.com>
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501210456.89071-14-philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc_piix.c | 9 ---------
 hw/i386/pc_q35.c  | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 58d76d2d410..d8417d1824f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -705,15 +705,6 @@ static void pc_i440fx_machine_2_10_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 10);
 
-static void pc_i440fx_machine_2_9_options(MachineClass *m)
-{
-    pc_i440fx_machine_2_10_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_9, hw_compat_2_9_len);
-    compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 9);
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 7fe6ca64f9d..b94d1839e3f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -652,12 +652,3 @@ static void pc_q35_machine_2_10_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 10);
-
-static void pc_q35_machine_2_9_options(MachineClass *m)
-{
-    pc_q35_machine_2_10_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_9, hw_compat_2_9_len);
-    compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
-}
-
-DEFINE_Q35_MACHINE(2, 9);
-- 
2.53.0



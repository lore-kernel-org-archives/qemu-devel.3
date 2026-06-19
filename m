Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FA9CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 05:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waRuI-0005XA-AK; Fri, 19 Jun 2026 01:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waRuF-0005WR-QZ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 01:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waRuE-0003Gb-Dt
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 01:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781847401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQ2HpR0WFgqm8qJgydfubSQlOn0F80nDU3NQ+9sYN1k=;
 b=YlKMBrv7lcSY0ph1wUyCP2nI0kAhwpVTaQskT1ZMeBhc6N3beLz/dLxrisfc439nch9cFo
 KDjv7XHMZtXgutD2p8oMxkMPxt+E8OPHg/j9CJxWYN/5gK1xlHCrgqAQvfU8aLAVWJAD0A
 y7dm9CpWok2Tz0N/Y08PWsITchCp/74=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-N2dcKPVUMs2Wzwem1DfEIw-1; Fri,
 19 Jun 2026 01:36:36 -0400
X-MC-Unique: N2dcKPVUMs2Wzwem1DfEIw-1
X-Mimecast-MFC-AGG-ID: N2dcKPVUMs2Wzwem1DfEIw_1781847395
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E707D180266B; Fri, 19 Jun 2026 05:36:34 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6129F180058F; Fri, 19 Jun 2026 05:36:32 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/3] hw/core/machine: disable tpm-tis-device PPI for
 machine type <= 11.0
Date: Fri, 19 Jun 2026 11:06:22 +0530
Message-ID: <20260619053623.756021-3-mbawa@redhat.com>
In-Reply-To: <20260619053623.756021-1-mbawa@redhat.com>
References: <20260619053623.756021-1-mbawa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Set ppi=off in hw_compat_11_0[] so that older machine types do not
register the "tpm-ppi" RAMBlock, restoring backward migration.

Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
 hw/core/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9a10e45aab..92cf5e1ca1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -44,6 +44,7 @@ GlobalProperty hw_compat_11_0[] = {
     { "chardev-vc", "encoding", "cp437" },
     { "tpm-crb", "cap-chunk", "off" },
     { "tpm-crb", "x-allow-chunk-migration", "off" },
+    { "tpm-tis-device", "ppi", "off" },
     { TYPE_ARM_SMMUV3, "ats", "off" },
     { TYPE_ARM_SMMUV3, "ril", "on" },
     { TYPE_ARM_SMMUV3, "ssidsize", "0" },
-- 
2.54.0



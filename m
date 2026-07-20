Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C44FC4452A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlp82-0003li-3R; Mon, 20 Jul 2026 10:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wlp3J-0001sp-1P
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wlp3H-0002dx-Fn
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784557982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hy2YLW/gLMo797VszhQ6PHzzCHyjlqdKcsagTuGlT/4=;
 b=Vl+ArHhcyJ0AU4K9S6rih9vs+/GE5BaS44MzFystrWOQkMc/mRfmQxNtEsnsidLe5QQn3s
 z5IPgNjzlj3zE0YS/ah9Q3tp6zIcUh+XRk62cdaLJ7MNyDfv6eK52bHkh9PrQtmUlpkm9w
 vjo7ujzp9PNSNMuTXE1GLtaKdDK9vA4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-Y26WR_SdOKSmLBr7kUVdig-1; Mon,
 20 Jul 2026 10:32:58 -0400
X-MC-Unique: Y26WR_SdOKSmLBr7kUVdig-1
X-Mimecast-MFC-AGG-ID: Y26WR_SdOKSmLBr7kUVdig_1784557977
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC9BA180A997; Mon, 20 Jul 2026 14:32:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.44])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A1EF30001BE; Mon, 20 Jul 2026 14:32:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8C6411800900; Mon, 20 Jul 2026 16:32:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mcascell@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 3/6] hw/uefi: check lower limit for signature list size
Date: Mon, 20 Jul 2026 16:32:39 +0200
Message-ID: <20260720143244.821889-4-kraxel@redhat.com>
In-Reply-To: <20260720143244.821889-1-kraxel@redhat.com>
References: <20260720143244.821889-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=kraxel@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Specifically disallow zero which can lead to an endless loop.

Fixes: CVE-2026-61406
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3899
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-siglist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/uefi/var-service-siglist.c b/hw/uefi/var-service-siglist.c
index 8948f1b78471..9e03a4dc0c28 100644
--- a/hw/uefi/var-service-siglist.c
+++ b/hw/uefi/var-service-siglist.c
@@ -94,6 +94,9 @@ void uefi_vars_siglist_parse(uefi_vars_siglist *siglist,
             break;
         }
         efilist = data;
+        if (efilist->siglist_size < sizeof(*efilist)) {
+            break;
+        }
         if (size < efilist->siglist_size) {
             break;
         }
-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E80CA0EDA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 10:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ullp9-0002H7-Hk; Tue, 12 Aug 2025 06:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ullp4-0002F4-1H
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 06:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ulloy-0004x7-Ps
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 06:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754992887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVB34e9Uj7epez3MD5LTEJ1aRum/LY79+Mc50gVpemg=;
 b=PAbfhYKrMjfAO2GhaPKXM9KWC5ioxR6tdp0JYyoi9Tz4ED1Cve+Mt+/ui4BdsvrL/MNPPn
 Z+O15pWbgFM+p32ERotBcY5aux3LLj49j2S6CFNevfTHDpjuZqJrcyKT93MX8WU7aumYU4
 JOGwaUyZrCfsIIhIP7FrIdetFY3nBGg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-G1eLbleIMK-o12qO-LA9cw-1; Tue,
 12 Aug 2025 06:01:24 -0400
X-MC-Unique: G1eLbleIMK-o12qO-LA9cw-1
X-Mimecast-MFC-AGG-ID: G1eLbleIMK-o12qO-LA9cw_1754992880
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CDDC1800451; Tue, 12 Aug 2025 10:01:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.64])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB4D61954199; Tue, 12 Aug 2025 10:01:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 72C461800393; Tue, 12 Aug 2025 12:01:11 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/4] hw/uefi: open json file in binary mode
Date: Tue, 12 Aug 2025 12:01:10 +0200
Message-ID: <20250812100111.1520917-5-kraxel@redhat.com>
In-Reply-To: <20250812100111.1520917-1-kraxel@redhat.com>
References: <20250812100111.1520917-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Fixes file length discrepancies due to line ending conversions
on windows hosts.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3058
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20250811130110.820958-4-kraxel@redhat.com>
---
 hw/uefi/var-service-json.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/uefi/var-service-json.c b/hw/uefi/var-service-json.c
index ad3462cd1557..f5f155683334 100644
--- a/hw/uefi/var-service-json.c
+++ b/hw/uefi/var-service-json.c
@@ -172,7 +172,7 @@ static GString *uefi_vars_to_json(uefi_vars_state *uv)
 void uefi_vars_json_init(uefi_vars_state *uv, Error **errp)
 {
     if (uv->jsonfile) {
-        uv->jsonfd = qemu_create(uv->jsonfile, O_RDWR, 0666, errp);
+        uv->jsonfd = qemu_create(uv->jsonfile, O_RDWR | O_BINARY, 0666, errp);
     }
 }
 
-- 
2.50.1



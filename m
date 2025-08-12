Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFB5CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 10:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ullpF-0002I2-E2; Tue, 12 Aug 2025 06:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ullp2-0002EV-0O
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 06:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ullou-0004we-Lg
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 06:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754992884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZIBu9E5mZXIA6EHZusH6ldSPFv2AgE11eh7RdqzdMg=;
 b=emTMWdPo1feneBt5flxyKEVIw06LZqyXTgH4zWSp+2bbob0YuMvApaij0Fpr56M+n1YpHI
 +aymrsNFi0YQNvaObdjhOWdGCFQ7Zz4TkLJd2/imjBgGztbifwJ3ARvk8OfKwaretcU7Kh
 V23jzHZZtyTWDsxeJSZYZe/RKQOKxso=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-QBFIAeE9Nc21nr-_LnaWbw-1; Tue,
 12 Aug 2025 06:01:18 -0400
X-MC-Unique: QBFIAeE9Nc21nr-_LnaWbw-1
X-Mimecast-MFC-AGG-ID: QBFIAeE9Nc21nr-_LnaWbw_1754992877
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8070118004A7; Tue, 12 Aug 2025 10:01:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.64])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C82BF1955F16; Tue, 12 Aug 2025 10:01:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5666C180038E; Tue, 12 Aug 2025 12:01:11 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/4] hw/uefi: return success for notifications
Date: Tue, 12 Aug 2025 12:01:08 +0200
Message-ID: <20250812100111.1520917-3-kraxel@redhat.com>
In-Reply-To: <20250812100111.1520917-1-kraxel@redhat.com>
References: <20250812100111.1520917-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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

Set status to SUCCESS for ready-to-boot and exit-boot-services
notification calls.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20250811130110.820958-2-kraxel@redhat.com>
---
 hw/uefi/var-service-vars.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index 37d05b71cf70..cbeccdbd2664 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -702,12 +702,14 @@ uint32_t uefi_vars_mm_vars_proto(uefi_vars_state *uv)
     case SMM_VARIABLE_FUNCTION_READY_TO_BOOT:
         trace_uefi_event("ready-to-boot");
         uv->ready_to_boot = true;
+        mvar->status = EFI_SUCCESS;
         length = 0;
         break;
 
     case SMM_VARIABLE_FUNCTION_EXIT_BOOT_SERVICE:
         trace_uefi_event("exit-boot-service");
         uv->exit_boot_service = true;
+        mvar->status = EFI_SUCCESS;
         length = 0;
         break;
 
-- 
2.50.1



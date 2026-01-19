Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D07BCCF2F2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 12:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhnzT-0002Zx-1u; Mon, 19 Jan 2026 07:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vhnzR-0002Xh-BW
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:04:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vhnzP-0000AJ-O1
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768824249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dXsbdsGlrwBYF65PN58enFnfGKnTOmms549qpQjWqGc=;
 b=MT0DN94g9vVLX0Wo1oazxCW2biBUVDvTMfmsy4CenOa/w/l2WE4KC3KbeM9Niqs+/1Wqts
 JPpbokcCnNgljv1Wu7b7m125fTgL/JsvqK2fjFIpff3bgK2DtJ2Fi8vT0kbNgs/CKrBRLS
 qI/pNoE4i1XXN0/T2L7lcS0BAipcZ5c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-MoyY3-0ZPuSJ_Q-Cvuvmvg-1; Mon, 19 Jan 2026 07:04:07 -0500
X-MC-Unique: MoyY3-0ZPuSJ_Q-Cvuvmvg-1
X-Mimecast-MFC-AGG-ID: MoyY3-0ZPuSJ_Q-Cvuvmvg_1768824246
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430f527f5easo3205970f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 04:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768824246; x=1769429046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dXsbdsGlrwBYF65PN58enFnfGKnTOmms549qpQjWqGc=;
 b=jqccYq0/EcbDt+wsl+cDP36+WW7+kZszJP3uiYtznsfjHzBjj9Cx13/IL9oLj1DE99
 X9ylAc8XfhoJEfeqLcNKtKRZxc8dhIig4+la0X88vfU75mw5o0GG3UgMn/cI0go7hMTx
 N6l7i3kDMNu2QXm3pGxpOskKG0zY0sGXhZWJuFxQxVAElu4LKsOLCLgVVHNNPxqo4oi0
 MZk/9DgOzmRMbsW94tvrMM1eGcja3AArSg2fWiHXbAnOtqblLg3YAQyYy0P1CVM3SO0D
 bLpLpCEU9VAUoc/28wHa1LThRd4VsxhnsIngDzaW948BFc3rsZJ8j2HGq3R+AjacG9yI
 3zXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768824246; x=1769429046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dXsbdsGlrwBYF65PN58enFnfGKnTOmms549qpQjWqGc=;
 b=aqmoqSa2T10bWW3oiXzXv9cVzL6hh5h1bP6u/mvpF6Fvv3YNAsizf4ljQ1oaRpZ3Ac
 bUXgMoN4t/QLZ6WGq0vtaP8iNu24PPZ7iXzTlLaofRAIZ6npzhyVjVj7ho6bRFA0vcFN
 9xxBKzsD8AYBLh53yYDKD6VmfyKFqXGvCrHoYQ0teJ24a9h+/T7W06AtuxOonSV0pcgk
 b/ekIZFTbk+kfQUOPmNurtl9YzpU2C52nrAfaMyFqUqB2mICPd8qDbTsDzZf1bNpX4Jy
 cYv1KVl9PTCOx3vQpofQP4EhFpOJrV3DkO9P5NTkof0xAKONXuD0QROTgXuHCOx9Ybj2
 6GRg==
X-Gm-Message-State: AOJu0Yyt1qJuIigL3TnapS9OFLf2pLXTRccX6O35OmVLEVV0VS1sJC4q
 dHRPax3u0r5FoDDsflgsv7XPHecSd0ar/lGCOpWJOloqmSPqDHqzYRWuXiwg0AoqDRCr2VIWP33
 8u/747WBZUovuJ0gUMytqWOGqHjALjFWQBcW2kYUr9uzjXk63ixpRxn5Ob03ItPSqmLxD1V5GvX
 l4g9uqa3tU0v5DIWXqoVx37PGg+sIDVtvMtd8eZFAx
X-Gm-Gg: AZuq6aJ+KpLvetM6kUGpcjilZy+Yy6/r1sL0lzl80I+MKA9FrAGbv5N/sWQopVmuC0Y
 yPexg1uEvLsPP3kPCXKHloJ3vG1Eak11NizuFgHNIQQ8gEc9Ykesfgdnbw+Zj5nXSWloEOoqT+l
 AqSxSLLqhLzEw8u+xWtCiY91uqHYS8bDWEtsnNI0ynjZiVP+VaY9Gt8VUyazVcaB5uWOoJuXsqt
 G6pqob1mPIzKtv313XYVkoGyJ5H3dL6zhZuZrHirqyx5FkN+Iyp24/aU/sgSd91DiQ0DRZ3R4nt
 TyN+iYAQlXgSXgzBcPjH949mlo1eqtlyGCg+7MWPO9cUunW5WrByogCTNJyw/pPc+HACXfg3gdn
 QvjH9cyBEKKoZ6lS8+QFWWlaLGMwBE7ujSyIWa0XVjvd0FHXNcvFPGCBl8yx68LpJHAE3It5DM5
 kYtSTjaYuCEMqcfw==
X-Received: by 2002:a05:6000:2484:b0:430:fcbc:dc4a with SMTP id
 ffacd0b85a97d-434d75c16c1mr18488924f8f.19.1768824245500; 
 Mon, 19 Jan 2026 04:04:05 -0800 (PST)
X-Received: by 2002:a05:6000:2484:b0:430:fcbc:dc4a with SMTP id
 ffacd0b85a97d-434d75c16c1mr18488826f8f.19.1768824244450; 
 Mon, 19 Jan 2026 04:04:04 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997eb0bsm22498452f8f.34.2026.01.19.04.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 04:04:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dorjoychy111@gmail.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] virtio-nsm: include qemu/osdep.h
Date: Mon, 19 Jan 2026 13:04:02 +0100
Message-ID: <20260119120402.284985-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The file hw/virtio/cbor-helpers.c does not include our standard qemu/osdep.h
header, add it.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/cbor-helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/cbor-helpers.c b/hw/virtio/cbor-helpers.c
index 49f55df3994..010454d5383 100644
--- a/hw/virtio/cbor-helpers.c
+++ b/hw/virtio/cbor-helpers.c
@@ -8,6 +8,7 @@
  * top-level directory.
  */
 
+#include "qemu/osdep.h"
 #include "hw/virtio/cbor-helpers.h"
 
 bool qemu_cbor_map_add(cbor_item_t *map, cbor_item_t *key, cbor_item_t *value)
-- 
2.52.0



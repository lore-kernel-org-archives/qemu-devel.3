Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1934F9B5F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFTtY-00041e-Kw; Wed, 22 Apr 2026 05:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wFTtW-00041C-C8
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 05:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wFTtU-0007nJ-W8
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 05:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776850155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JHv1/XTf9edFWemRwnCrfJaa3/BnSoBME4/dbjjZqjg=;
 b=SEkt0nnNbyQrfDRvw4b9fM9djIunRgUcbDy2WFS/A7hyTzpMBApM2Y7RTFWpmQMEA0e3bA
 ENVRcX4On/kWyBDAQpCznP5NgPmjrKUi6uXCvVMgBTFzxwYHlOykSttYjIyt9lHgdJQB19
 nPr7vnTNFzCvBiY6AoaXnJIWnfi7UQ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-hfGjkM4vOTuI9m45IHlOaA-1; Wed,
 22 Apr 2026 05:29:13 -0400
X-MC-Unique: hfGjkM4vOTuI9m45IHlOaA-1
X-Mimecast-MFC-AGG-ID: hfGjkM4vOTuI9m45IHlOaA_1776850153
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BED7D1800451
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 09:29:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.53])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5509B180047F; Wed, 22 Apr 2026 09:29:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1C9BE1800609; Wed, 22 Apr 2026 11:29:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/6] hw/uefi: a batch of security fixes
Date: Wed, 22 Apr 2026 11:29:03 +0200
Message-ID: <20260422092910.444997-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Gerd Hoffmann (6):
  hw/uefi: fix buffer overruns
  hw/uefi: verify pio_xfer_offset before calculating buffer checksum
  hw/uefi: fix ucs2 string helper functions
  hw/uefi: add name_size check to uefi_vars_mm_lock_variable()
  hw/uefi: verify data size before accessing it in wrap_pkcs7
  hw/uefi: avoid possibly unaligned variable_auth_2 struct field access

 hw/uefi/var-service-auth.c  | 16 +++++++-------
 hw/uefi/var-service-core.c  |  4 ++++
 hw/uefi/var-service-pkcs7.c |  3 ++-
 hw/uefi/var-service-utils.c | 42 +++++++++++++++++++++----------------
 hw/uefi/var-service-vars.c  | 22 +++++++++++++++----
 5 files changed, 57 insertions(+), 30 deletions(-)

-- 
2.53.0



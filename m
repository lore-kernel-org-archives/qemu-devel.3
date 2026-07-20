Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164E8C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlp7u-0003jA-JW; Mon, 20 Jul 2026 10:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wlp3a-0001vn-4W
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:33:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wlp3V-0002em-DU
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784557996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Opl3WIimNLrYXcW08+LG/Q46jv4FUq6grJVxg59Ms7Q=;
 b=YBdTFkSZSev1PArdQqlI/Gvn49QHPWyD5bUHq1DPxtPNKfqICTdzSvl9D3pCyaqLtsGYH9
 52bUDzTFSfsbz0dKBFhoCSPwu21f9Re3wegNe5qq8aBVSnDViaJXsD8H01gNKqO/k9Vy8G
 Nk24E27LNEJHEm1Qpmku3FLXYklT+rA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-d1e8yUt4ON-Aoqb085OqdA-1; Mon,
 20 Jul 2026 10:33:15 -0400
X-MC-Unique: d1e8yUt4ON-Aoqb085OqdA-1
X-Mimecast-MFC-AGG-ID: d1e8yUt4ON-Aoqb085OqdA_1784557994
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2095619352F6; Mon, 20 Jul 2026 14:32:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.44])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B2121800352; Mon, 20 Jul 2026 14:32:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5D89C1800391; Mon, 20 Jul 2026 16:32:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mcascell@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 0/6] hw/uefi: security fixes
Date: Mon, 20 Jul 2026 16:32:36 +0200
Message-ID: <20260720143244.821889-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=kraxel@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

v4:
 - add fix for CVE-2026-16288
 - fix format string (Luigi).
v3:
 - just drop debug function instead of trying to fix it.
 - add three more CVE fixes.

Gerd Hoffmann (6):
  hw/uefi: add sanity check
  hw/uefi: remove debug function
  hw/uefi: check lower limit for signature list size
  hw/uefi: account variable policy entries against storage size
  hw/uefi: add post_load checks
  hw/uefi: make SetupMode read-only

 hw/uefi/var-service-auth.c    |  7 ++++
 hw/uefi/var-service-core.c    | 14 +++++++-
 hw/uefi/var-service-json.c    |  5 +++
 hw/uefi/var-service-policy.c  | 68 ++++++++++++++++-------------------
 hw/uefi/var-service-siglist.c |  3 ++
 hw/uefi/var-service-vars.c    | 19 ++++++++++
 6 files changed, 78 insertions(+), 38 deletions(-)

-- 
2.55.0



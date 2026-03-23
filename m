Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F55F46100
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ep9-0008Rt-9E; Mon, 23 Mar 2026 08:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4ep6-0008RP-2P
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4ep4-00062U-4W
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774270555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8J5p7UensCSbhBhuPmiSrG4FNeXOqDUZipi1LscYnLM=;
 b=T9skZg3fA/r+ShpxTiUmiFuoS/afIYcHZ6/tpj8ZVLoJ4ZW9BycvbG6ohW62Sj97w4ezlD
 B+LD3hel3bUxJMYhh38G1OK3Nn40/oQIMkJrKB73jIfLEEEITxs0iafTCVvo/T9AELUPW4
 3u/p7YYFnemyenXnCJ9vKZ5BwBaaDF4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-B9REFdwvPQegPFuII5QMpg-1; Mon,
 23 Mar 2026 08:55:52 -0400
X-MC-Unique: B9REFdwvPQegPFuII5QMpg-1
X-Mimecast-MFC-AGG-ID: B9REFdwvPQegPFuII5QMpg_1774270551
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3012180035D; Mon, 23 Mar 2026 12:55:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.42])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 232A819560B7; Mon, 23 Mar 2026 12:55:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 0/3] aspeed: Improve error handling and fix DMA issues
Date: Mon, 23 Mar 2026 13:55:42 +0100
Message-ID: <20260323125545.577653-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

Hello,

This series addresses several error handling issues in Aspeed device
models that could lead to guest-triggerable denial of service or
incorrect behavior.

The first two patches improve DMA error handling by properly
propagating memory transaction errors to the guest. The aspeed_smc
patch converts memory operations to use read/write_with_attrs to
return MEMTX_ERROR on invalid conditions, while the ftgmac100 patch
checks DMA operation return values.

The third patch fixes an incorrect assertion in the aspeed_i2c model
that could be triggered when firmware uses the RX_BUF_LEN_W1T bit to
program DMA length fields separately, which is valid per the Aspeed
datasheet.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3335
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3315

Thanks,

C. 

Changes in v2:

- v1 was taking into account patch : 
  https://lore.kernel.org/all/20260224065556.3847942-14-jamin_lin@aspeedtech.com
  Rebased on upstream 

Cédric Le Goater (3):
  hw/ssi/aspeed_smc: Convert mem ops to read/write_with_attrs for error
    handling
  ftgmac100: Improve DMA error handling
  hw/i2c/aspeed_i2c: Remove assert

 hw/i2c/aspeed_i2c.c |  1 -
 hw/net/ftgmac100.c  | 10 +++++++--
 hw/ssi/aspeed_smc.c | 49 ++++++++++++++++++++++++++-------------------
 3 files changed, 36 insertions(+), 24 deletions(-)

-- 
2.53.0



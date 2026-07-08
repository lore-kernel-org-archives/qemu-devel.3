Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B368C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 11:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whQGA-0007Us-L6; Wed, 08 Jul 2026 07:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1whQG4-0007Tt-Eq
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 07:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1whQG2-0003GF-Lt
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 07:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783509360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Dqh52SJNw1jmtIsWY3SageHrCb0gQ7j4BR6OhPjjFRs=;
 b=BYezuuBzlFSAOc7m+t90+lv8rSRe7LCafor+P9HjKj5Mf8OCoOozhkA+fthZfruPCMVJ0P
 8KSscUycQbALmanx8sjRcg3z5WLoKON2peZhb3myEmy11pgwjfzrV+Dt+Vldc8kpytaQil
 Ci2SFquboSfytktCY9KW4gg8Q9XdcnM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-cRX3yOQhNQaKPOkGHg8OTw-1; Wed,
 08 Jul 2026 07:15:55 -0400
X-MC-Unique: cRX3yOQhNQaKPOkGHg8OTw-1
X-Mimecast-MFC-AGG-ID: cRX3yOQhNQaKPOkGHg8OTw_1783509353
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09B551955D88; Wed,  8 Jul 2026 11:15:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.253])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A3DC1955F43; Wed,  8 Jul 2026 11:15:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/4] tests/qtest: aspeed_smc: Add fast-read variant test
 coverage
Date: Wed,  8 Jul 2026 13:15:40 +0200
Message-ID: <20260708111544.1440761-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series extends the Aspeed SMC qtest suite with coverage for
fast-read and multi-IO read commands :
  - Fast Read (single IO with dummy byte)
  - Dual Output Read (DOR, dual data IO)
  - Quad Output Read (QOR, quad data IO)

Each patch tests both the memory-mapped CTRL_FREADMODE path and the
user-mode command path, to exercise the dummy cycle handling recently
reworked in the m25p80 flash model.

Thanks,

C. 

Cédric Le Goater (4):
  tests/qtest: aspeed_smc: Introduce read_page_mem_fn for page read
    helpers
  tests/qtest: aspeed_smc: Add fast-read test coverage
  tests/qtest: aspeed_smc: Add Dual Output Read (DOR) test coverage
  tests/qtest: aspeed_smc: Add Quad Output Read (QOR) test coverage

 tests/qtest/aspeed-smc-utils.h |  13 +++
 tests/qtest/aspeed-smc-utils.c | 178 +++++++++++++++++++++++++++++++--
 tests/qtest/aspeed_smc-test.c  |  53 ++++++++++
 tests/qtest/ast2700-smc-test.c |  12 +++
 4 files changed, 248 insertions(+), 8 deletions(-)

-- 
2.54.0



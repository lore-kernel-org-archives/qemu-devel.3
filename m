Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC529C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEpev-0006Ug-Oe; Tue, 13 May 2025 09:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1uEpes-0006S9-Al; Tue, 13 May 2025 09:26:58 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1uEpej-00073i-NM; Tue, 13 May 2025 09:26:57 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id B765A1520BB6;
 Tue, 13 May 2025 15:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1747142802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=z5lX2oOTTWrWTLFLJ3cBHwUGD75JBr8YAaCk3kvF4BU=;
 b=cgALxH2aJbhLaCGBVhnX6DZybffXbEPIGTMR37hLk3sc5ZJDvQjJp7OOBf8vnTAYii/EEs
 KW1Ka8Tj+GU0UdUi6tWf3VYvzEHsvWZEOnRYM4+el2wQ7vhXSp+zK+Lg5JKZE0U1TZPBWY
 OIkyBY9pbVnM1yiSn0r0NRCIVtxzfModQm1DOF1jkKJxHThOlbpLi00jU0Pd4+TOzqER7l
 C7qdiJN9ftIHMuMUCAm8nHzti19vsA1OP+lqfeeGHoLFvoAwtgfmSFLNHlRs/vY/jzZphu
 abhnVb8tmqq2UvmR5c+1mEL21owZuRvCsOtV8a2z/1TLfX0Fbvk8ey/QMKfF3Q==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org,
 Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH v2 0/2] qcow2: queue discards when discard-no-unref enabled
Date: Tue, 13 May 2025 15:26:26 +0200
Message-ID: <20250513132628.1055549-1-jean-louis@dupond.be>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Partially based on the proposal of Andrey in
https://patchew.org/QEMU/20240913163942.423050-1-andrey.drobyshev@virtuozzo.com/
Split up this from the rest might get it merged a bit quicker hopefully :)

Since the implementation of discard-no-unref, we did not queue the discards correctly
when discard-no-unref was enabled.

Jean-Louis Dupond (2):
  qcow2: rename update_refcount_discard to queue_discard
  qcow2: put discards in discard queue when discard-no-unref is enabled

 block/qcow2-cluster.c  | 16 ++++++----------
 block/qcow2-refcount.c | 25 +++++++++++++++++++++----
 block/qcow2.h          |  4 ++++
 3 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3C1CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 19:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEuOy-00016v-DJ; Fri, 31 Oct 2025 15:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEuOw-00016Q-9o
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 15:03:06 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEuOp-0004XZ-9X
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 15:03:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1315EC0157;
 Fri, 31 Oct 2025 22:02:51 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id m2mTmi0FnuQ0-TucAVi9w; Fri, 31 Oct 2025 22:02:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761937370;
 bh=4oBc5ZbucfxWlQTOJFuCzElW/m4jSJhuL6QDb4yhs+M=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=R+THQORqpEsZ3G4tsHzn0WJWDpWS6uAbNGUYsN14t2+uI6BPwrMrwKoj3GejitoPT
 8lH4mqKDaezkiVsRyoNsDyRDssy1aubIkh9aOF5MMPkfjmZ6VtU2eQHId5TilvzPCb
 2QmiUHM9xpaehTVcRfO0RQErbMpFPBPyqpQogwE8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH v2 0/2] util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
Date: Fri, 31 Oct 2025 22:02:44 +0300
Message-ID: <20251031190246.257153-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all. qemu_hexdump() wrongly indents ASCII part of the output for
the list line, it it's not bound to 16-bytes boundary. Let's fix.

v2: add test

Vladimir Sementsov-Ogievskiy (2):
  util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
  tests/unit: add unit test for qemu_hexdump()

 tests/unit/test-cutils.c | 43 ++++++++++++++++++++++++++++++++++++++++
 util/hexdump.c           | 38 ++++++++++++++++++++++-------------
 2 files changed, 67 insertions(+), 14 deletions(-)

-- 
2.48.1



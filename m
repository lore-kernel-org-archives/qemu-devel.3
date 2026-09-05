Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C3AC79F82
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2eU7-0003ud-HD; Fri, 04 Sep 2026 20:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1x2eU5-0003t2-KG
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 20:42:17 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1x2eU3-0000E5-Ej
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 20:42:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 6B21D80A6D;
 Sat, 05 Sep 2026 03:42:09 +0300 (MSK)
Received: from i101646577.yandex-team.ru (unknown [2a02:6bf:8080:11b::1:22])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 7g79b72ad0U0-Z6mXC11F; Sat, 05 Sep 2026 03:42:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788568929;
 bh=LHMal1OgkA0QQwrDgN2RhrxJOqaHo4jThwV6u8+OTro=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=gvF3r/EgJa7gGZXJBxoK4M22cxIVmunfUaqvmb962SnwhubmuQ2NWuWrDse6SCppY
 YAWAbB0kETl87Wa8vs+e1A3NzuXlxbO/PVhZxtDLIVJLFDnWU+RiEh4C98hosXZlZ0
 jdBcVu6JNxJYvq3MzdY5tS1/vhF6TiYS4e3RxfUI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/2] x86: fix a stale ExtINT request after LINT0 is masked
Date: Sat,  5 Sep 2026 03:41:50 +0300
Message-ID: <20260905004153.836866-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This fixes a few problems that eventually lead to the guest receiving a
bogus #GP due to a stale interrupt still being asserted. Either patch
fixes the problem, but the first one fixes the actual root cause, and
the second one simply aligns interrupt handling with KVM, which made
the bug invisible by simply dropping the IRQ targeting a bogus vector.

Daniil Tatianin (2):
  hw/intc/apic: don't drop irq line re-evaluation when LINT0 is masked
  target/i386: drop attempts to deliver an interrupt without a vector

 hw/intc/apic.c                      | 3 ++-
 target/i386/tcg/system/seg_helper.c | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.43.0



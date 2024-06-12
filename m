Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96965C27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 10:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHLeZ-00064S-K1; Wed, 12 Jun 2024 06:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHLeX-00063z-Vx
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 06:56:30 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHLeV-0001B4-S7
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 06:56:29 -0400
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTP id 65B1D40755CC;
 Wed, 12 Jun 2024 10:56:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 65B1D40755CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1718189763;
 bh=oGk8dGXd4OkTXR6QlYvfvDb9SPvNEhgY45nwwk+Bdy8=;
 h=From:To:Cc:Subject:Date:From;
 b=Mf6a+9MGk4INbR4QUTKEm6TjD6EZhhuwy6WD9PhqDVvNv25RA970TKonjsdczoPdj
 iuooqz6F4mLBHMANFXKfno6DcA+q08TPxhV7Z6rRJ8Q4ONl9dndvqzsXJJZr2bI5im
 KIR2jX2oNJuX6ND6fImtyUxsbRrJpWXmBGV4jiyE=
From: Alexander Monakov <amonakov@ispras.ru>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
Date: Wed, 12 Jun 2024 13:55:20 +0300
Message-Id: <20240612105525.8795-1-amonakov@ispras.ru>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,

I'm sending straightforward reverts to recent patches that bumped minimum
required x86 instruction set to SSE4.2. The older chips did not stop working,
and people still test and use new software on older hardware:
https://sourceware.org/bugzilla/show_bug.cgi?id=31867

Considering the very minor gains from the baseline raise, I'm honestly not
sure why it happened. It seems better to let distributions handle that.

Alexander Monakov (5):
  Revert "host/i386: assume presence of POPCNT"
  Revert "host/i386: assume presence of SSSE3"
  Revert "host/i386: assume presence of SSE2"
  Revert "host/i386: assume presence of CMOV"
  Revert "meson: assume x86-64-v2 baseline ISA"

 host/include/i386/host/cpuinfo.h |  3 +++
 meson.build                      | 10 +++-------
 tcg/i386/tcg-target.c.inc        | 15 ++++++++++++++-
 tcg/i386/tcg-target.h            |  5 +++--
 util/bufferiszero.c              |  4 ++--
 util/cpuinfo-i386.c              |  7 +++++--
 6 files changed, 30 insertions(+), 14 deletions(-)

-- 
2.32.0



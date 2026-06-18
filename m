Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAAACD98F0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa83J-0007MS-EM; Thu, 18 Jun 2026 04:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wa83G-0007MF-PI
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:24:42 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wa83D-0007ID-AM
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1781771069;
 bh=JAp5FcGz5D+jAHVu+b2vzKzsbqtxmsLmp2LUrDvGCdM=;
 h=From:To:Cc:Subject:Date;
 b=YmsGSepSjekdxJV9zDnweFLXKr5THqzjP79aiS9IQiCYSMlEjOAzoB+06UyUpvcXP
 CCavVfDGmDACoolmi9TalajT61o3CO8/zYCcFgwXJUiJqPDX/uax3twu9L2Ez+Cze3
 NZeP2MisRPUCEyILbR8bxDPAO6cPCrQhLamvIH2bMN1ROIZ2w1XkKeTUshInpq08fn
 2gPKy68aldN+JjJ3FeuNklE0N4LkJGMkrRJVFRysujzqQsmAQ5IZ6cU540FzRh6/99
 g0UwgU9jvSpY4KSCaZPn++R62AKeUxosvbU4GAAQkG2Wij8807yBRyhEgl1aQBSBWD
 qVp5n9vEvnXsw==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id AADA5300110;
 Thu, 18 Jun 2026 08:24:29 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 384E037C951;
 Thu, 18 Jun 2026 16:24:28 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>,
 Ziyang Zhang <functioner@sjtu.edu.cn>
Subject: [PATCH v2 0/1] plugins: fix syscall filter return value type
Date: Thu, 18 Jun 2026 16:24:25 +0800
Message-Id: <20260618082426.790315-1-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
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

Hi,

The sysret value of the syscall filter callback is declared as uint64_t,
but it is semantically signed: the negative range encodes errno. This
makes it int64_t, matching the ret parameter of
qemu_plugin_vcpu_syscall_ret_cb_t, which already uses int64_t for the
same syscall return value.

As discussed on v1, this is not a correctness fix (the filter only sets
sysret, so the bit pattern is the same either way); it is a consistency
and readability improvement, so that the same syscall return value is
typed the same way on the read side and the write side.

I did not bump QEMU_PLUGIN_VERSION, since this only changes the
signedness of an existing argument.

v1: https://lore.kernel.org/qemu-devel/20260612054800.587419-1-functioner@sjtu.edu.cn/

Changes since v1:
- rebased onto current master, where the syscall callbacks now take a
  userdata argument; the filter signatures were adjusted to keep that
  while changing only the sysret type. No functional change otherwise.

Thanks for your review.

Ziyang Zhang (1):
  plugins: use int64_t for the syscall filter return value

 include/plugins/qemu-plugin.h | 2 +-
 include/qemu/plugin.h         | 4 ++--
 linux-user/syscall.c          | 2 +-
 plugins/core.c                | 2 +-
 tests/tcg/plugins/setpc.c     | 2 +-
 tests/tcg/plugins/syscall.c   | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.34.1



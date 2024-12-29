Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85D1E77191
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 23:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tS2vK-0003sR-AW; Sun, 29 Dec 2024 18:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tS2vD-0003rq-Ct
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 18:42:13 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tS2vA-0001ex-Nx
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 18:42:11 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 504F05C0085;
 Sun, 29 Dec 2024 23:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D44C4CED1;
 Sun, 29 Dec 2024 23:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735515717;
 bh=OoGjIdGkQs/LAkesL2BbKNybWRhIbwxRPbgMIQiuLHA=;
 h=From:To:Cc:Subject:Date:From;
 b=cHuaqvQoeSZvkUmkdajG2Jo/zrF9cg+wfS7n6y/TyrptQ7akMeKzZWESTIKQi+u7y
 8TT2gTqP3S201AsxmCJlR47tSsuIA3IeeeqCQuhIYZsKh5iA0yc4S6/fNnDOGxwLir
 dyNczU3qfuAxJwnJk37/YIuB8kTSaq5hgGdEWEtvMUriBxcE/hlvLV5Nd3JamLexIJ
 931ShcvyrBeo8PkGregg4iGdjJoJlpbp1yziU3gtqJp5RDC/yUcIiraK6CoMDeyFt4
 hk+ZvYD4bYX33wuEFJ9eGuDbIuizRd5GaE9Nv986MqqQJe0QzBsuO0Wc2OwuPa92Ll
 gxmrzEDTyf6gQ==
From: deller@kernel.org
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 0/2] hppa CPU reset and speedup
Date: Mon, 30 Dec 2024 00:41:52 +0100
Message-ID: <20241229234154.32250-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Add CPU reset function and speed up runtime and translataion.

Helge Deller (2):
  target/hppa: Add CPU reset method
  target/hppa: Speed up hppa_is_pa20()

 hw/hppa/machine.c |  6 +++---
 target/hppa/cpu.c | 27 +++++++++++++++++++++++++--
 target/hppa/cpu.h |  9 ++++++++-
 3 files changed, 36 insertions(+), 6 deletions(-)

-- 
2.47.0



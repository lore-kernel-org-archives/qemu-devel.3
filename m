Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E90AC2BA1B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 19:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsS1T-0001iL-1E; Wed, 12 Mar 2025 15:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tsS1E-0001h6-EU
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:45:33 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tsS16-0006Mw-NI
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=IsLQrz5ZEK88T9pa/2HfcCUhJSubcTWR63LGnay0es4=; b=G/986ozURvJwAkh
 9XtlwogiKc4pTZlNgPuxwB3+d98FYNjiKyK9Dub0ULu9uFjdypZmCaTLXG+QwuSL4lN5XwMjNe9WD
 lXnVH2Lgq2OpYF8SV/aLoIzdG3+bD0Vy/qNVRuUyhA99enKhb/gevAJ3uuy/Q4NWRz8+iUEf3oZUS
 Vo=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, brian.cain@oss.qualcomm.com,
 philmd@linaro.org
Subject: [PATCH 0/2] target/hexagon: Fix macOS build
Date: Wed, 12 Mar 2025 20:45:45 +0100
Message-ID: <20250312194547.7364-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A default macOS build with xcode cli tools installed lacks the `indent`
program needed by the idef-parser postprocess step, remove this step. 

Additionally `cpp` used by the idef-parser preprocess step expands into
`clang ... -traditional-cpp` and doesn't support macro concatenation
among other things, replace it with a meson custom_target running
`${compiler} -E`.

fixes: https://lore.kernel.org/qemu-devel/d95ebf5d-c1f6-42c5-8aeb-65764fa87125@linaro.org/

Note: default bison on macOS is still too old (v2.3 vs v3.0) and a newer
version needs to be installed via homebrew. I'll take a look at
supporting v2.3.

Anton Johansson (2):
  target/hexagon: Replace `prepare` script with meson target
  target/hexagon: Drop `ident` postprocess step

 target/hexagon/idef-parser/prepare | 24 ------------------------
 target/hexagon/meson.build         | 24 ++++--------------------
 2 files changed, 4 insertions(+), 44 deletions(-)
 delete mode 100755 target/hexagon/idef-parser/prepare

-- 
2.47.1



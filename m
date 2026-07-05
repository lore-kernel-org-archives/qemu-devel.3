Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119DAC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 15:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgP4Y-0007dS-3m; Sun, 05 Jul 2026 11:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wgP4W-0007dA-Sk
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 11:47:56 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wgP4V-00017r-Fu
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 11:47:56 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE8DF4191B;
 Sun,  5 Jul 2026 15:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668441F000E9;
 Sun,  5 Jul 2026 15:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783266473;
 bh=g7jmObg3vUtjcnfbCYcy5VGxGEmBC7WjT8cy9vhrEwM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EE0/tjbFng33KikscDA9NrAjBdv2QAOH2K6/XrKwGEjUkFnsRjTHcFLKkz8jOUyHO
 tPxCs79DwUTkrU2dTX64aW9TWfSnhHtwFqGYKihuHoX1BFZsCJ5gbbLUmczZrdJpM8
 UZyQGikOSy2eCTjGjiwg7cjJAAl74Uyq4ewCg0FBeEXDN8ofsckoeGm03HZnj68ksB
 IADUcd6w/mf7yEP18r7w3OcwXoiic/ifozHrYK4l3KJsBm4wYkWzK7+3m80JhCaFLy
 3yQNZ0MIKKNYQvRkjsGjK7aUXJ1nR2Rjnz1mr/5u/qqFUcJz0k2n40H5jOynvTQPZt
 /yXEJyzKJuqIQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 1/4] target/hppa: Work-around for Fast TLB insert instruction
 on HP-UX 9
Date: Sun,  5 Jul 2026 17:47:45 +0200
Message-ID: <20260705154749.7368-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705154749.7368-1-deller@kernel.org>
References: <20260705154749.7368-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

The HP-UX 9 kernel uses two TLB insert instructions (0x05315440 and
0x05385400), which seem to be wrongly encoded fast TLB instructions, but
similiar to the non-fast instructions idtlba r17,(r9) and
idtlbp r24,(r9).

It's not clear, if those undocumented instructions were used by mistake,
or intentionally. Either way, this patch allows qemu to handle those
instructions, so that a HP-UX 9 boot-CD can now boot somewhat further (but
still crashes due to other reasons afterwards).

Signed-off-by: Helge Deller <deller@gmx.de>
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 13c6a55bf2..f700fe472e 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -164,6 +164,8 @@ ixtlbx          000001 b:5 r:5 ... 000000 addr:1 0 00000        \
 
 # pcxl and pcxl2 Fast TLB Insert instructions
 ixtlbxf         000001 00000 r:5 00 0 data:1 01000 addr:1 0 00000
+# workaround for non-standard encoding as used in HP-UX 9
+ixtlbxf         000001 01001 r:5 01 0 data:1 01000 addr:1 0 00000
 
 # pa2.0 tlb insert idtlbt and iitlbt instructions
 ixtlbt          000001 r2:5 r1:5 000 data:1 100000 0 00000    # idtlbt
-- 
2.54.0



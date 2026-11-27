Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA60606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=sP1UN1MI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoxW-0001qr-6j; Fri, 27 Nov 2026 00:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoxS-0001h4-U2; Fri, 27 Nov 2026 00:57:18 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoxR-0002s2-Cr; Fri, 27 Nov 2026 00:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758877; bh=ztzvlsBc1ybuzo3QuF9Eko++ByJD06ZdqSDdNUldBPg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sP1UN1MI2G8v8l4Y08OAxd5dBl/F4Yn+LJpRbBd4Grp7RYdzKeZ/JvX9h2srDyGW1
 rm5pOTE0EFtg2kODkl/nx2PIyo7fOSeZfAq3m+V7MhV8p3leCAsrOoMXprt2C+ixQr
 bhBojgCIud/BzATjNxmHV4Q9vpssmc8CMRuZ3OWa8mvk0lC6HHSKh08W/PnEH8rMDT
 Ar38ivv7cXm3JMBedemXZz+SPv8wcPZ9uZu03J3wDjzSemBP2/CqB2Z0O92PZUTB3z
 Wmh62MWxlQ05WZ8eBwJx6lB6qorHnnjGci8XqhiHdwPQ6l+ALcKs+/PTncNo4yV6gk
 DfJxuguZvHQRg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8D8011EA2E5;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8B3A8469920;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 81522CF24C; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Yifan Wang <w-yf22@mails.tsinghua.edu.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 091/140] hw/block/m25p80: fix write enable latch
 after WRSR2
Date: Fri, 27 Nov 2026 08:53:17 +0300
Message-ID: <20261127055421.39015-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Liu <chao.liu@processmission.com>

The flash clears the write enable latch when a WRSR2 command completes,
just like a WRSR write; otherwise a following program or erase could
proceed without a new WREN.

Cc: qemu-stable@nongnu.org
Fixes: 9785731ec4f7 ("hw/block:m25p80: Support write status register 2 command (0x31) for w25q01jvq")
Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
Message-ID: <0c80a9c01452a8695b46a6d9fa920f9a14f4de47.1794558546.git.w-yf22@mails.tsinghua.edu.cn>
[PMD: Directly assign @write_enable]
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 81ce8c16ee54360a443ed200bdf4a80bde8f1930)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 0887c103e4f..1dea85ae295 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -835,6 +835,7 @@ static void complete_collecting_data(Flash *s)
         default:
             break;
         }
+        s->write_enable = false;
         break;
     case BRWR:
     case EXTEND_ADDR_WRITE:
-- 
2.47.3



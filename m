Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC389606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=jWs7cMD4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp6P-0004P2-N4; Fri, 27 Nov 2026 01:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp5p-00011T-Qx; Fri, 27 Nov 2026 01:05:58 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp5n-0006lp-Uw; Fri, 27 Nov 2026 01:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759046; bh=7lfo7PRum13h/yo8Wgrzn7GuGpxyhgcoUhHTTjDZkxA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jWs7cMD415N/bQKJ0k0AH+jmOtMpRteI946zixOtSpslYTzDEoA1apoWJqL/+bqc4
 A3VofU5aa5tet11xZfz2wOsJtXaUgDKwMhHllQb/8hecZLAuuv0q+PlrXebqY+yRDK
 RoV0vRbVpPDR15Ql2WMsIvSm+Pd0UIOhXzz3T7J/lJVlp3AvgMh5i++UeJZpGHBcse
 0THe9nH2TTkZLQ5726MfLWjlBh0lOTpIql+QXUgrXB229rHowhBYP2xn23L87d8XYz
 JT+qVWgoZeGxs+n2b0+YMRwBkdh4sHcID7uZo22w9DspYeW9NZ8dX6M4Z8pVRCV4H3
 TQO9tbZzxXi/w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F401E1EA353;
 Fri, 27 Nov 2026 08:57:26 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id F181D46997E;
 Fri, 27 Nov 2026 08:57:26 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E7222CF2F4; Fri, 27 Nov 2026 08:57:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Yifan Wang <w-yf22@mails.tsinghua.edu.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 097/152] hw/block/m25p80: fix write enable latch
 after WRSR2
Date: Fri, 27 Nov 2026 08:53:55 +0300
Message-ID: <20261127055709.39630-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
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
index 545e0b57285..b7b3ed4936f 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -838,6 +838,7 @@ static void complete_collecting_data(Flash *s)
         default:
             break;
         }
+        s->write_enable = false;
         break;
     case BRWR:
     case EXTEND_ADDR_WRITE:
-- 
2.47.3



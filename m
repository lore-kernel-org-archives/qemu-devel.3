Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA21B606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=YbvRfwPI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpD9-000240-Fp; Fri, 27 Nov 2026 01:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpBS-00081p-FG; Fri, 27 Nov 2026 01:11:49 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpBQ-000334-PV; Fri, 27 Nov 2026 01:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759049; bh=EWjowyrm/FsVwNhP37WjL6i2sCk3C3pFO/ULXufcMnk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YbvRfwPILdy8CRKnUsG/ggBNPSx8UB4eMRYN9Cwc/9vxGfbMS1+qvz4PPDv0mG755
 g+8qNxxXr0AXFJmt3oWj54ej5Ovji1y9JJiIyyBXS4BgdxVleAyKRX2oj7vwqBAcAe
 8OM81We96q8+voGmRVYzJvO/O1vhbUSdYye4HI3tmSzgCRKofT+ZVAZNm+/kc8klja
 FToOq4dx793PAgHbpc+/BBK1/83SC6wHbmmEy9Nv1ul92Mmgdupr1Y+ud7BdFYqvFB
 unmtAnpFFKbgXVfVNWxIgJ0gsX2lFgWNX0so0hMIPe0KLKwj4rrxCdnCJZjWKsFwcb
 QbXCHLCu3Q2qQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D06021EA389;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CE0274699B4;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9B917CF360; Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 151/152] hw/ppc/amigaone: Invalidate TBs on NVRAM
 write
Date: Fri, 27 Nov 2026 08:54:49 +0300
Message-ID: <20261127055709.39630-88-mjt@tls.msk.ru>
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

The NVRAM is a ROM device, mapped in romd mode, so the guest can
execute from it. Its write callback stores the byte with a direct
store, which TCG does not see: translated blocks of the byte survive.

Flush the written byte, as the other models (TYPE_PFLASH_CFI01/2
and TYPE_NRF51_NVM) do.

Cc: qemu-stable@nongnu.org
Fixes: addff513a10e ("ppc/amigaone: Implement NVRAM emulation")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20261124180138.69682-1-philmd@oss.qualcomm.com>
(cherry picked from commit c3800302668ff745e10b810f12723eac7068abda)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 2e94e80b569..9b60782172f 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -109,6 +109,7 @@ static void nvram_write(void *opaque, hwaddr addr, uint64_t val,
     uint8_t *p = memory_region_get_ram_ptr(&s->mr);
 
     p[addr] = val;
+    memory_region_flush_rom_device(&s->mr, addr, 1);
     if (s->blk && blk_pwrite(s->blk, addr, 1, &val, 0) < 0) {
         error_report("%s: could not write %s", __func__, blk_name(s->blk));
     }
-- 
2.47.3



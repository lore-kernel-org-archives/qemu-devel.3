Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4BEE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 14:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLNG9-0002Iy-03; Wed, 11 Dec 2024 09:00:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman.artemev@syntacore.com>)
 id 1tLHKz-0000WA-MG; Wed, 11 Dec 2024 02:40:50 -0500
Received: from m.syntacore.com ([178.249.69.228] helo=pmg.syntacore.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman.artemev@syntacore.com>)
 id 1tLHKw-0007pE-TI; Wed, 11 Dec 2024 02:40:49 -0500
Received: from pmg.syntacore.com (localhost.localdomain [127.0.0.1])
 by pmg.syntacore.com (Proxmox) with ESMTP id 46C6FB41C57;
 Wed, 11 Dec 2024 10:40:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:message-id:mime-version:reply-to:subject:subject
 :to:to; s=m; bh=24jjebVxl79h81yZ4ZOMnFvWOOT17NmrrmaEOORRkFo=; b=
 MCggHLCE7u4t457FTFV9vqLjTRwNMCSoA3ldabunLd4flYrgrm5YufkkhZpepTvO
 Fh0rnnaiA07uFkUwd7YN/VWFBxOet5S2Dalpg8obouiVHH3TY6rZJuU22FCqulLV
 fAGfsocRINYLonRj6OSt9UB53lZL8Ibp73LTRUj7TIw0y08xVek2Nqilm2okdIXx
 kbWUVlNthFOfAZRqLi2RAEfr2XRk7ZR9XVGb+9bV8G/avJbj0h5Lh6Xy+ihy+xon
 ePMSwxpp3G0hITJ56Q+Dx0RiOgNnfh5bFcP/0fcSy01uVb1nHJS1bDpjD3zRgr5r
 azoNqshn/zZODXgyt4JiSQ==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com
 [10.76.202.20])
 by pmg.syntacore.com (Proxmox) with ESMTPS id 25D59B41C53;
 Wed, 11 Dec 2024 10:40:34 +0300 (MSK)
Received: from S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Dec 2024 10:40:04 +0300
Received: from S-SC-EXCH-01.corp.syntacore.com ([::1]) by
 S-SC-EXCH-01.corp.syntacore.com ([::1]) with mapi id 15.02.1544.011; Wed, 11
 Dec 2024 10:40:04 +0300
From: Roman Artemev <roman.artemev@syntacore.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "Alistair.Francis@wdc.com"
 <Alistair.Francis@wdc.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, Roman Artemev <roman.artemev@syntacore.com>, "Denis
 Tomashev" <denis.tomashev@syntacore.com>
Subject: [PATCH] tcg/riscv: Fix StoreStore barrier generation
Thread-Topic: [PATCH] tcg/riscv: Fix StoreStore barrier generation
Thread-Index: AQHbS5+XMPWvlhEe/kmr6ENsbls0/w==
Date: Wed, 11 Dec 2024 07:40:04 +0000
Message-ID: <e2f2131e294a49e79959d4fa9ec02cf4@syntacore.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.76.202.1]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=roman.artemev@syntacore.com; helo=pmg.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Dec 2024 09:00:05 -0500
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

On RISC-V to StoreStore barrier corresponds
`fence w, w` not `fence r, r`

Signed-off-by: Denis Tomashev <denis.tomashev@syntacore.com>
Signed-off-by: Roman Artemev <roman.artemev@syntacore.com>
---
 tcg/riscv/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index f8331e4688..96f9a7e348 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1624,7 +1624,7 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
         insn |=3D 0x02100000;
     }
     if (a0 & TCG_MO_ST_ST) {
-        insn |=3D 0x02200000;
+        insn |=3D 0x01100000;
     }
     tcg_out32(s, insn);
 }
--=20
2.39.2



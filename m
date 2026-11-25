Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D3606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIRt2U6l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW35D-00086R-2b; Tue, 24 Nov 2026 21:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW358-000833-MX
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:50:04 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW357-0006mQ-A0
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:50:02 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 334416155A;
 Wed, 25 Nov 2026 02:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6A31F000C4;
 Wed, 25 Nov 2026 02:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795574999;
 bh=tdV56/N+Z3489H+GVC+HI7UT/qv8mrf3CmNSbQDnlFg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NIRt2U6ltPU+a+zia2xyU7JBk4PXeh9RNfn5K8c15GO+ilo2HezHj2bcIil1iAZy1
 B49WY5CaZJ7mIfueFZmlhGDcs7zUkjQ9MASxi9UcBM6CbHJjbzVbMtdoFTSTbDsQGb
 6MjtQJHEsb5czU1Rpww/TGnKxegt20oh+Eg4hTyeKk9PG+coMPLd7hc5OWW5+dljsn
 JzPTHaTso3vqgziAQw/6Jshdbac28nQdXXltt4/IUxITPtE0eU7UytAc9StMGe8zhy
 Ru9kVbEmfHCeZICmLrLq5wEOCKGVCWk08JqfdFhT0drqUqNp5X/nCVGs7IFaMueQfr
 UJTYGtaTjcUtQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Keith Monahan <keith@techtravels.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL for 11.2 02/14] hw/scsi/ncr53c710: Do not load SBCL from DBC
 after a SCRIPTS phase move
Date: Wed, 25 Nov 2026 03:49:39 +0100
Message-ID: <20261125024951.10428-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125024951.10428-1-deller@kernel.org>
References: <20261125024951.10428-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

After a SCRIPTS Block Move, ncr710_execute_script() copies DBC, the
transfer byte count, into SBCL. SBCL (SCSI Bus Control Lines) mirrors
the state of the SCSI bus control signals, it is not a byte counter, so
this overwrites it with unrelated data. The preceding line already
updates CTEST5 from the DBC bits that the chip exposes there.

Remove the assignment. The effect on guests is inferred from the
register definition; it has not been reproduced with a failing guest.

AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 10daa66e84..9ea2c47744 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1400,7 +1400,6 @@ again:
             BADF("Unimplemented phase %d\n", s->sstat2 & PHASE_MASK);
         }
         s->ctest5 = (s->ctest5 & 0xfc) | ((s->dbc >> 8) & 3);
-        s->sbcl = s->dbc;
         break;
 
     case 1: /* IO or Read/Write instruction.  */
-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F089C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 11:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLLqW-0002js-0R; Sun, 23 Jun 2024 07:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sLLqU-0002j8-3o
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 07:57:22 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sLLqS-0003Z9-Ho
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 07:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=6m4pndhvEEGb/KsMnXUlAPgJn0IM+aTr6p0i/RohjqY=; b=yjgekzosKC8Lkb7D7pqotBe7iz
 fiVY4bpBrnAXSwNuirBT7+Ah+MOjX5na+lPQpdNnGf/Tfb0J2SMxUn4IenlGOqbhdtCkvkQkJtsSu
 xg/63naBbIQyKzWEdssrWSnY14jQp/GD2soLUNOS/Ag+25LMSRBX8VFFvSAu5+zBgtFwYUelwxz2a
 LSWxGhxly9xGvLS77hDUttG37FjUixqfp7jZwBJTp1B2FwDhvN0oGxBZks+fUnduQrspzFA6fNGw3
 Oo0uNVTWhPKJTTFJCCyiChRRUQAmmErdwkQGBvIAjArsECv4FqGaBscs+AKuK1/yNIRqNchxpw2wi
 vCnL1aV0qJOrk8uJahga0UAkBgrStJZV01AxZ4Yi7kQGsbR7itSn94JRMOQOTydV+prZUTr5nOWqX
 c4Pqfj0YW5z8n8+socoePJ8BhyjmvGKbPNJklzqcLQt3I9/Eql2/3p9h7pIZkm+9JxvdRZTXFPQqD
 XlnZ4WgvKE2c8200nRu2+U0BO02PXz25FJss4g95apMhmeH6kpmGCCU/KZeHeCb9QRxoXIqrL/Udd
 yw4Vg0JkyT5/YFnZcpJ5w2oZraFyesT93SZnSEmIv+42HO7nWhqXZXCAnYU2EY97WAGtssvddN+H8
 z+VTSVg3zhEZ8UOkk9DdIt3WF8XXjIcSvYX/vjTVo=;
Received: from [2a00:23c4:8bb4:4000:e8db:395:a8c5:fda6]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sLLp2-00080P-1T; Sun, 23 Jun 2024 12:55:56 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	laurent@vivier.eu
Date: Sun, 23 Jun 2024 12:57:02 +0100
Message-Id: <20240623115704.315645-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:e8db:395:a8c5:fda6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 0/2] target/m68k: implement unaligned accesses for m68k CPUs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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

This series implements unaligned accesses for early m68k CPUs that do not
support word/long accesses at byte granularity. Patch 1 implements the
do_unaligned_access function for m68k CPUs, whilst patch 2 is based upon a
prototype patch developed by Laurent as part of Gitlab Issue #2165.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2165


Mark Cave-Ayland (2):
  target/m68k: implement do_unaligned_access callback for m68k CPUs
  target/m68k: pass alignment into TCG memory load/store routines

 target/m68k/cpu.c       |  1 +
 target/m68k/cpu.h       |  4 ++++
 target/m68k/op_helper.c | 11 +++++++++++
 target/m68k/translate.c | 18 +++++++++++++++---
 4 files changed, 31 insertions(+), 3 deletions(-)

-- 
2.39.2



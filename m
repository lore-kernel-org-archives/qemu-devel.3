Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB2BCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 12:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1l64-000553-Ny; Thu, 25 Sep 2025 08:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1v1l60-00054j-9m
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 08:29:12 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1v1l5u-00005s-SA
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 08:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=zT+mFifkx6mrfoJu5Ra9oCKfvTQW3XId3qS52KTKNJQ=; b=Q39TYL5f1w8DDZ/4Hr0+bKXkO+
 qyUy5CoLPEoRktIMJ0FRgnh4DWwQ5Td7fALm7zLBRSOT+PX7cUuEkvT7erlfYwV+J4rC6UiMy3++7
 jRGniwSTxofK8k+d1vi1DU2FpypuHIRO05MB/MwpIbSdjLnEdJV+fCOZVqtmeBsJbQbF9AGFd+nOh
 042VdZVvuGS9mEGMWHiw2sZijGnGJWmJplaav0UvmDSExT3Jw17yAn5ZOAWE76L+AVME2e3oGLVH2
 9XcjAzBYzhg7BX0tTbwXKFIDlKSFFVns85FUMdlAwE0iGCkYxTP7dWwimUn3Ju7uA9L3gm3bIYR8T
 uGh5+iWNkNLjphCU3sxreRosOy5zMCULSjjLEw2YhGVaFUqKx5zIDlAfwZMVYrh/nXWF51FZJfTca
 apwMQtQabmcxJQq8gHNCPZyyx/BtgaxBhCooDJ8rknaUE747gyNHZGktAgsNuC+T4nABZZtHgi/t5
 Mh3foZRoC5ziIy74Qh7rUkvr0Byxr6M9YIVjcGPNunpQIMBSOnFo8CiGR5jFH74c+sRH8qzoZbGMJ
 5zVLx/SOHG8sTBPLrZBM97JVkLoDc5NTm3Er7pFVMm19NPNUIzxwUgkCKq2PvcAPOaTRNghCg617D
 Tx3/VHtTNY2kbWUx7/GeuPTy423pRYvE5wzVAKAK0=;
Received: from [217.155.175.48] (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1v1l3c-0008Tc-L5; Thu, 25 Sep 2025 13:26:48 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, farosas@suse.de, lvivier@redhat.com,
 qemu-devel@nongnu.org
Date: Thu, 25 Sep 2025 13:28:44 +0100
Message-Id: <20250925122846.527615-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.155.175.48
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 0/2] esp.c: fix esp_cdb_ready() FIFO wraparound limit
 calculation
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

This small series fixes a bug in the ESP cmdfifo FIFO wraparound limit
calculation as reported at https://gitlab.com/qemu-project/qemu/-/issues/3082, as
well as adding the reported test case to qtest.

In normal usage the cmdfifo does not overflow, however the test case reported by
the fuzzer was enough to show that the FIFO overflow check in esp_cdb_ready()
was not working correctly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (2):
  esp.c: fix esp_cdb_ready() FIFO wraparound limit calculation
  qtest/am53c974-test: add additional test for cmdfifo overflow

 hw/scsi/esp.c               |  6 ++++--
 tests/qtest/am53c974-test.c | 40 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

-- 
2.39.5



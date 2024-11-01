Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF6FE6F092
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 22:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6zhf-0004Kv-KV; Fri, 01 Nov 2024 18:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6zhd-0004KW-Pe
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 18:01:09 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6zhY-0002nZ-M2
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 18:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=dz2qn4pcCOO+M1jGbs5LK5mD90i7lVDyT+Myoa7jZr8=; b=w+RPC8HiPWkHmibnQu7opopABp
 Fnq/GxCGpgQFLvF3dSM/LCGTfdHNfVxkmqfKo4XIw+x9DigwGyksk/B/LH+bBtgxcnYEJwq4e4AR+
 Kv5blCXEPWKNlmChjZ/tk67Rfmy9/KNuXeFKnKOW/Mj6jyqecFVChMw5n7kRVuIr/mfa/uw+uGnsO
 /1CzTg+oMb3qo/73YvLro/kQBecR77BDbTuVocvpukXzfnQEWOfr0x1Bpt7Ycii2rdNTxpYk5pe2/
 u+eIKN8k3Pvhycz4AzgphxDDIFFA1HGkbY5tolV8Jm2KKyOi78Mdmblmbv6t+nr5ZpZxfrJOKP708
 10UZU9pTq02tgjj5BgemqoX+zAYR9nbTxxtmFFdXYfNOJxlGTXA/0QxBBiCr87eDMgBsgEUmwJVVH
 L5wj1Wj6AXP5eS8gzD3+Jzz2GvStX3FaWxE0CFZxyVyJKVGP0k4whE1LTx8C3x5lYR7M88NtxVXOD
 6eZS9avO9u9kTCoC18a3VQPEWMh4BNUUTWwwtRHYA0DB7/YuVaDm4lLaR5QQUmVkZe/g9DlV0tFGY
 +dR/Woj6snQOVpS05pH82HhTir+6f1y1ssPYeFLccG+Uru9arZ+G4KbJklWnsa3s4JTzW4vYbYSRn
 YoaIgTq0iOeATqE32StXNR2LKkfiblwDczSz63Btg=;
Received: from [2a00:23c4:8bb8:f600:91a1:336d:3931:745]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6zh8-0002pk-B5; Fri, 01 Nov 2024 22:00:42 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Fri,  1 Nov 2024 22:00:47 +0000
Message-Id: <20241101220052.1463805-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:91a1:336d:3931:745
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 0/5] esp.c: only allow ESP commands permitted in the current
 mode
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

This series contains a few minor tidy-ups along with an implementation of the
logic to only allow ESP commands permitted in the current mode. The motivation
is to fix GitLab issue #2464 which causes Windows NT MIPS to bluescreen on
boot.

Patches 1 to 3 are simple tidy-ups from investigating the issue. Patch 4 adds
a new asc_mode variable to indicate the current ESP mode, whilst patch 5 implements
the feature which fixes GitLab issue #2464.

IMPORTANT: unfortunately the SeaBIOS (and SeaBIOS hppa) binaries currently
distributed with QEMU also use an illegal ESP command sequence, and so will
fail to boot from an ESP SCSI device until binaries containing the relevant patch at
https://github.com/coreboot/seabios/commit/2424e4c04aa30d90e85073ea41d18a7845460783
have been merged. The hope is that the SeaBIOS binaries will be updated soon to
allow this series to be merged in time for the 9.2 release.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (5):
  esp.c: only raise IRQ in esp_transfer_data() for CMD_SEL, CMD_SELATN
    and CMD_TI commands
  esp.c: improve comment in esp_transfer_data()
  esp.h: remove separate ESPState typedef
  esp.c: add asc_mode property to indicate the current ESP mode
  esp.c: only allow ESP commands permitted in the current asc_mode

 hw/scsi/esp.c         | 68 +++++++++++++++++++++++++++++++++++++++----
 hw/scsi/trace-events  |  1 +
 include/hw/scsi/esp.h | 15 +++++++++-
 3 files changed, 78 insertions(+), 6 deletions(-)

-- 
2.39.5



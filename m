Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E14CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV7PW-0003Ad-Q1; Thu, 04 Jun 2026 08:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1wV2Lh-0006sx-Pe
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 03:18:42 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1wV2Ld-0003aV-Iy
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 03:18:41 -0400
DKIM-Signature: a=rsa-sha256; bh=/YajwBMrIbzz2hRzAXJP8Wk5Dz4I2bcjcAcr014L1gA=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1780557513; v=1;
 b=QPDq0QzBnNDyYmR97cwTBq8vlFKAhVQ7x30E+/7e9KOD4nRykC0b3MIcPI74Vt0Vg/WetjVj
 JggLEkFtZel1rILUfzBtx+TKGfr06Q/OvwiZLr6Md/kpIRu1e4GBdyi2Rtrd+y1EganvOPD1qFx
 Nuiws8eUc7kFm2M1kjeLodnMsdfoQwu1OH9SYZHhXJLot1TKJDDjDItgJHguabrNPdXhOBYI5kg
 tifJOonah1YvzoeqCt+FrnTFxvlKRR2IRqZwI63HjRpG4wrmYWZVBT5Fzu8cckjBLrTZ/cirELG
 g57Tes9kDklPkB7Es/0h/k7t7c5RNBCvEaQGoBmc1CYOw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 9A32D21302;
 Thu, 04 Jun 2026 07:18:33 +0000 (UTC)
From: ~kholia <kholia@git.sr.ht>
Date: Thu, 04 Jun 2026 07:18:33 +0000
Subject: [PATCH qemu 0/1] hw/usb/dev-storage: add vid/pid/other overrides
MIME-Version: 1.0
Message-ID: <178055751360.22223.153528865155723674-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 04 Jun 2026 08:42:53 -0400
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
Reply-To: ~kholia <dhiru.kholia@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch adds the ability to override the Vendor ID, Product ID,
Manufacturer and Product strings for USB storage devices via properties.

This allows emulating specific USB storage devices more accurately.
When vid or pid is specified, a per-instance USB descriptor is
created to hold these values.

This helps with debugging and reversing of various VID+PID restricted
applications (e.g. Samsung SecretZone, SanDisk SecureAccess and others).

Dhiru Kholia (1):
  hw/usb/dev-storage: add vid/pid/manufacturer/product overrides

 hw/usb/dev-storage-bot.c     |  1 +
 hw/usb/dev-storage-classic.c |  1 +
 hw/usb/dev-storage.c         | 43 ++++++++++++++++++++++++++++++++++++
 include/hw/usb/msd.h         |  3 +++
 4 files changed, 48 insertions(+)

-- 
2.49.1


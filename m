Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AD9E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVTxS-0005QI-MS; Wed, 08 Jan 2025 06:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b94846bdbc75b454f255+7808+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tVTxP-0005Ov-3U
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:10:40 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b94846bdbc75b454f255+7808+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tVTxL-00050T-AZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=oFradcDpithIj07YVftxrAE8S5k0+vOLR8t1oTdefLo=; b=KfR7NjyG8hl5mlzWh6UNf2AC+s
 nljJmi9Nj6OYaGVm1YPeYvakk55my9z1N4xYQfQEGP1o7zXi5RnkaTL47wwXSvTU/tEY0AfD/yjr4
 708aMngPhfpqBLxHZ/aAAeXPrQforz1P2BYul+TVpyAVqYt9fLa37ZNIYVfQTK64jjR/Xv8MA1ZUF
 CjPtN+iHiqyCIvkmZPNbLKkn8WOADlWQnPfEoOZT+yq3quNVynON6F9gSjw9+ufkOMEoD4uY9NNO/
 VGxSWoMs9Og4WWNzwBMT0NLrYT63luqwWU/dYBwdVJY6Cr7b6JfIGplpU51X7V13gwoXELueMuLna
 DOXOS0zw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tVTxA-0000000FoUT-15E7; Wed, 08 Jan 2025 11:10:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tVTxA-00000000ebR-00QL; Wed, 08 Jan 2025 11:10:24 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Hilber <quic_philber@quicinc.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>
Subject: [PULL 0/1] vmclock queue
Date: Wed,  8 Jan 2025 11:10:22 +0000
Message-ID: <20250108111023.156073-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+b94846bdbc75b454f255+7808+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

The following changes since commit 6528013b5f5ba6bb3934b7f5fe57a3110680530f:

  Merge tag 'qga-pull-2025-01-06' of https://github.com/kostyanf14/qemu into staging (2025-01-06 09:39:02 -0500)

are available in the Git repository at:

  git://git.infradead.org/users/dwmw2/qemu.git tags/pull-vmclock-20250108

for you to fetch changes up to 6502ea82b26dc28c83fbc9c766af7a408a8ca827:

  hw/acpi: Add vmclock device (2025-01-07 16:22:04 +0000)

----------------------------------------------------------------
Add vmclock device

----------------------------------------------------------------
David Woodhouse (1):
      hw/acpi: Add vmclock device

 hw/acpi/Kconfig                              |   5 +
 hw/acpi/meson.build                          |   1 +
 hw/acpi/vmclock.c                            | 179 ++++++++++++++++++++++++++
 hw/i386/Kconfig                              |   1 +
 hw/i386/acpi-build.c                         |  10 +-
 include/hw/acpi/vmclock.h                    |  34 +++++
 include/standard-headers/linux/vmclock-abi.h | 182 +++++++++++++++++++++++++++
 scripts/update-linux-headers.sh              |   1 +
 8 files changed, 412 insertions(+), 1 deletion(-)
 create mode 100644 hw/acpi/vmclock.c
 create mode 100644 include/hw/acpi/vmclock.h
 create mode 100644 include/standard-headers/linux/vmclock-abi.h


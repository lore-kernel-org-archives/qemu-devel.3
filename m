Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D171AF9D0D0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdhW-0000oO-RR; Tue, 14 Apr 2026 09:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCdhV-0000ny-8B
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:21:09 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCdhT-0007xT-H6
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:21:09 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43cfd1f9fd1so3620569f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776172863; x=1776777663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kW3uIpjUwfDQapuH1LUbUIQVanSYu349LO0tAUhlRAA=;
 b=AfXrDaiIMoypTxdwUHYADEM+LHG88HdF4tPeg+RZ/FrWZ87k0Dx6gyTbSmYELATy76
 UNDWbdvGxUE7v4/1ffIrD6Bsn/G8TVPlg5R5KlUCV7uiBb8yTMjS/zQ1/G9XYrF4GVpE
 PDuJEc0AandiUAIzo2HBLzQuguWRdXFtqpCMZpdOQLMctcfKk4I7LLvGufNkHgHYGd7O
 xVSLJs4W8EaCMQSPEIq9UMJPBVRTvk+KP5+ubv4GdNUt+WQKU9y59eL0QI7CUpIchkqz
 4BZsaenhfGVN2Zi19TzL+Z+TcA5qmZzo6mliMSZU/QqexHF0lGqMoH9mSv96YU9lElXE
 7MFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776172863; x=1776777663;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kW3uIpjUwfDQapuH1LUbUIQVanSYu349LO0tAUhlRAA=;
 b=ChITuwHDn5mhSQU1ppW2AEs41vv4DUxxjmdl86kKJ+PCmGlkmbFsoAl9qPprxGA+3J
 ZELVjHqW/0s4vPAu4ibqL5MfXKLHUTeE64ucm1WcQ7S61arJKvX7q8FbPAVChXNRi/xy
 z/xf7RiTKGYh4samfonqAAk5xHeZwmnph/EsFhIZIXqJO9ZuA5OYRVEhFj+ZpLt+40F5
 2Ymzv2WvVMOL98ztma0r5ertXAHj09dwFFVG/JrF/9lpxdWiHjL9iMmBr28lCPXqPxrC
 mr1uNuy27iP3grh2INLSd63weTK0+F0pAOmbwE5l6QpiVUwuU2XQLvkPUNJt6BqvhaCl
 fVrQ==
X-Gm-Message-State: AOJu0Yyvr2XNU5pV8onGSgDiXYCT+vkd31dTyjizmfXV6UPrJcZq5XF3
 WNUirBnUzAlwjRFkpGl266k/VBBW5/QsUhYF4G7cs1BeAlRhGRv7sKcnmy8FWt6/Iqn5uIGEN1Q
 y8CrEFiM=
X-Gm-Gg: AeBDieuyb/iH8LnZ9C7ffLUUInl9r6wOJM2qZinifnTq/rR/DD3ooWDdptZZxBPzhym
 EmjrSi61S115KAMstA+5usNgzlMuTuvsza81Dh7JpU81PpWbAZiZn+++gktZ3NYfRnH6v8jd/YG
 adTlj9PZPErgJwOHTcRYTvUtUkAAoOqBfpNN7L8+su8+dtY4tCLfvuwvl0sqaS6ngIvkvDsghG1
 vBcbyHX6BkiIU45bPlVe9NdDq/nFX2sp0l2d19/jdRtPVyl4KwvTAumgYGiX2ylNBxff5U0i93t
 0RcYvi8mGhMHx/JpzUknNFqsdQ7uY1+WwsiVwBKCtnfKabxDtle0pbfX9PnIFakqcCeqlH8hiqj
 PZOy4+rCyCVAQag5N+XUDwzS4iWjLHP7aJvf2GdL/Cmfbi0RQLAlme9dtIrrcqzUR8D6zElWNBV
 OCQlFVjLXA1fmeWNDW32po11BSOVRm/LpzJZh3hfEI6hvaHHRxoY3zDLAlq7JvXww0ovdXgWcN
X-Received: by 2002:a05:6000:2303:b0:43d:7af0:3a8a with SMTP id
 ffacd0b85a97d-43d7af03dffmr11007609f8f.46.1776172862477; 
 Tue, 14 Apr 2026 06:21:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7794cce5sm19141887f8f.9.2026.04.14.06.21.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Apr 2026 06:21:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Misc HW patches for 2026-04-14
Date: Tue, 14 Apr 2026 15:20:56 +0200
Message-ID: <20260414132100.53861-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit becd22fdc2a071783d9e04421526633772b3b98c:

  Update version for v11.0.0-rc3 release (2026-04-09 21:18:56 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260414

for you to fetch changes up to 31ebdb207f99bf7d72abbbb82fced15d161a548f:

  ati-vga: fix unsigned integer overflow in cursor bounds checks (2026-04-14 11:35:13 +0200)

----------------------------------------------------------------
Misc HW patches

Few more VGA & PPC fixes.
----------------------------------------------------------------

Junjie Cao (1):
  ati-vga: fix unsigned integer overflow in cursor bounds checks

Mohamed Mediouni (1):
  hw: q35: fix VGA text console with SMM disabled

Vivien LEGER (1):
  hw/ppc/e500: fix bus-frequency property hardcoded to zero in CPU FDT
    node

 hw/ppc/e500.h      |  1 +
 hw/display/ati.c   |  4 ++--
 hw/pci-host/q35.c  | 22 +++++++++++++---------
 hw/ppc/e500.c      |  2 +-
 hw/ppc/e500plat.c  |  1 +
 hw/ppc/mpc8544ds.c |  1 +
 6 files changed, 19 insertions(+), 12 deletions(-)

-- 
2.53.0



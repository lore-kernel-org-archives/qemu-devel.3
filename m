Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC954C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 11:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSE30-0008VL-VO; Fri, 12 Jul 2024 07:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sSE2y-0008UJ-4D
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:02:40 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sSE2w-0003af-3I
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:02:39 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52e976208f8so2135772e87.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720782155; x=1721386955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YDi3aHOISc4g4l2QB4EUVCHplHZ5EmTx9pOA9H0LoG0=;
 b=Zs1S5BlpWxKrPHCIFTdestU3W8zaY10OnqrLsBb/RpMNKVSKGJ3VO/5zb6EjkL0paC
 6TXYrv5Y4VwHAuI36/Ww/ZxWz/FQWpXVQyk1WBpOMdReTsLIgvn1Ccr82Opey7IT2u8F
 0BFjpeXSwHTJ+4qZA4MhCq4VA3zdQy1shZSWkHkz41um9f6ZnZ5KcLafHUqBO+dgNWgu
 JIggQGZ8GDHlZxgPREKTd7DefV4ZPHtkWBM8hXZvkHSRbp38q56aycSSPuHF+OUoaYOe
 t5WM18Hak3pA8ULoRHN76VNFKIXZEKdpYt7uQ/f4DGLYDjeMX2A7d/wF6eWoUzGlR3uR
 T8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720782155; x=1721386955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YDi3aHOISc4g4l2QB4EUVCHplHZ5EmTx9pOA9H0LoG0=;
 b=gKDQIybZecYiVahdhxXNNw0G4p7Zci9h6RP9P5uXRCS21Q65slw7iunHGyoiYLtY+a
 XtGZWZUhf9/rSjDMkcVTJpk8XZGdOLec1m5fO72dhzZDW7Mj7rIztSwvLBOqmzooHwA3
 TbP9ZePUFbMEgX8+VaJ8+oSkanuYlgD2Syi5h8T7FSenWV5VsGwdChQUJnoliKXL3RPe
 x7qrW9ayu/csgHc4OIIiMEsjWF/rEgZDT7IMq/BpA59PMdHzTntlCBtScu+5ykXzWoXo
 c0VxExyFRgfei8Yx65E3b6lGIH1MXekD6LwemUL1R8gc5WYlA3V7w/7jBoFrEH3NdQdg
 JSLg==
X-Gm-Message-State: AOJu0YwirBoEFxjb9UgVPs+GhZOY7G46u/UceSlgFYR2Gozu952B55Jm
 F1YnnrUszbof3WVjYN15RiulnkHHMGRS91aQbf9OFkVJSIgdwAoAZm/pXPYm
X-Google-Smtp-Source: AGHT+IFvDyDG2RtxgI1dCSwH630RGKfaukmen1TDL6ZzE345JhyvC7Zls1reJUSyqRCErs4kTkwxrw==
X-Received: by 2002:a05:6512:2249:b0:52c:dea5:7c8c with SMTP id
 2adb3069b0e04-52eb9994b30mr9508302e87.22.1720782154239; 
 Fri, 12 Jul 2024 04:02:34 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52eb9061a8asm1224978e87.147.2024.07.12.04.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 04:02:33 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, edgar.iglesias@amd.com
Subject: [PULL v1 0/3] Xen queue
Date: Fri, 12 Jul 2024 13:02:27 +0200
Message-ID: <20240712110230.4098056-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

The following changes since commit 23901b2b721c0576007ab7580da8aa855d6042a9:

  Merge tag 'pull-target-arm-20240711' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-07-11 12:00:00 -0700)

are available in the Git repository at:

  https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/xen-queue-2024-07-12.for-upstream

for you to fetch changes up to 872cb9cced796e75d4f719c31d70ed5fd629efca:

  xen: mapcache: Fix unmapping of first entries in buckets (2024-07-12 00:17:36 +0200)

----------------------------------------------------------------
Edgars Xen queue.

----------------------------------------------------------------
Edgar E. Iglesias (2):
      physmem: Bail out qemu_ram_block_from_host() for invalid ram addrs
      xen: mapcache: Fix unmapping of first entries in buckets

Stefano Stabellini (1):
      MAINTAINERS: add Edgar as Xen maintainer

 MAINTAINERS           |  1 +
 hw/xen/xen-mapcache.c | 12 +++++++++++-
 system/physmem.c      |  4 ++++
 3 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.43.0



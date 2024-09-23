Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD363CF9C74
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 14:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sskTM-0007tC-4c; Mon, 23 Sep 2024 10:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sskTK-0007rv-9R
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 10:55:30 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sskTI-0006um-9g
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 10:55:30 -0400
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-49bd32f6a11so1486498137.1
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727103325; x=1727708125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+QQOENS13gaCUbXadLVFx2Tu1Z0wMPeEs0jQvlcRlJg=;
 b=F4oWbbj2tcXE2IKwJybGH7SM8Zk4RKJ9S6QuY9QaeGLWK/nsbehsP/gikdlFzT0qEf
 +aSbf8DkGjSShSkMQMFBWZzBRBaGeeguZ1yUFkJxC1Re0SOwRxNP2B0S2LYyO0ftU0ad
 kvMaHNianssOo9djWJu86p4N2KWFsRk2tZ/nhSpe/EuIkOBJYLNYg+DtOCHGJxBk9ka1
 5AVS/y1B+mHv8eGbahM6Ck/MAoByCqw6ZpomU/OvP5ygtKvyWY1to6N6reck7mXwaYlt
 WM7f3OTBp+cta+S2RKBPCtLGkazMTGhv2LpWzsvkfyqa9bc2fGwIvBP5Vl6lLtSSAK3N
 TTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727103325; x=1727708125;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+QQOENS13gaCUbXadLVFx2Tu1Z0wMPeEs0jQvlcRlJg=;
 b=SQp2gko53MMR95OZh9EmISihjx5MaZHKhswz+8TFO0PyuyuoU32J/WiADsmTeYMVG4
 MO0aBY6B15uOuZ+6twmQl3fD/44E4lY3/pNQBPjik3234M4libDIE0IKC66TwUlhpWYp
 /rxIsXNM63NHXZwtAdMVmJUvs/TZHMPW+INtZ2hfBnXPsECUNmY+WO7k+5tQF8HLZnSX
 7n9jv4duV+BwlMKTcPQi9DHJyeROTy9Xd7Fm0UNjwmWYg8N5MS23d/5vO2vKfbHFySlu
 9IQujic3yG9Q7TZPO3QKQ4KrumhGEBepzF2v/YkF9xZZO7T37eURfrOveAShuL/VIZ07
 c/wQ==
X-Gm-Message-State: AOJu0Yyj0BKdkPqKAM7AEXVXS12gJKJ9GiKG4Pl+OuS2oH3xZ7S/kBhl
 4y2boFDj3j8RvH0ZZZwQZwCU6r7wbcCfI0HNq7JKhgYmXcBv1kIBDRP0Lj1r
X-Google-Smtp-Source: AGHT+IFWpltF4DszBNmdJLzxxWpl0+PQALaUS57FnKxMcmGpkC84SrzYntpJhu1WF5lbFBJlQoOcCw==
X-Received: by 2002:a05:6102:50ab:b0:498:d12b:4774 with SMTP id
 ada2fe7eead31-49fc755285fmr7477451137.7.1727103324966; 
 Mon, 23 Sep 2024 07:55:24 -0700 (PDT)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-49e6b343070sm3626517137.11.2024.09.23.07.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 07:55:24 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 0/4] hw/arm: xenpvh: Enable PCI for ARM PVH
Date: Mon, 23 Sep 2024 16:55:16 +0200
Message-ID: <20240923145520.1323504-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vs1-xe35.google.com
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

Enable PCI on the ARM PVH machine. First we add a way to control the use
of buffered IOREQ's since those are not supported on Xen/ARM.
Finally we enable the PCI support.

I've published some instructions on how to try this including the work in
progress Xen side of the PVH PCI support:
https://github.com/edgarigl/docs/blob/master/xen/pvh/virtio-pci-dom0less.md

Cheers,
Edgar

ChangeLog:

v1 -> v2:
* Change handle_ioreq from int to uint8_t.
* Fallback to legacy API if buffered ioreqs are enabled and also if
  the new API is not supported. Clarify with comments.


Edgar E. Iglesias (4):
  hw/xen: Expose handle_bufioreq in xen_register_ioreq
  hw/xen: xenpvh: Disable buffered IOREQs for ARM
  hw/xen: xenpvh: Add pci-intx-irq-base property
  hw/arm: xenpvh: Enable PCI for ARM PVH

 hw/arm/xen-pvh.c                |  17 ++++++
 hw/i386/xen/xen-hvm.c           |   4 +-
 hw/i386/xen/xen-pvh.c           |   3 +
 hw/xen/xen-hvm-common.c         | 101 ++++++++++++++++++++------------
 hw/xen/xen-pvh-common.c         |  40 ++++++++++++-
 include/hw/xen/xen-hvm-common.h |   3 +
 include/hw/xen/xen-pvh-common.h |   3 +
 include/hw/xen/xen_native.h     |   3 +-
 8 files changed, 133 insertions(+), 41 deletions(-)

-- 
2.43.0



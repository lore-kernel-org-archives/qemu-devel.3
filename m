Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E5EC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqDLc-0004V7-9M; Mon, 16 Sep 2024 11:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sqDLa-0004Tt-Qf
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 11:09:03 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sqDLZ-000481-3I
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 11:09:02 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-82d24e18dfcso176639939f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726499338; x=1727104138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vu2bW3oPLPtiaOMxv8oJDWfzTzC5BBzl6CK0bwZlSkE=;
 b=WPm/b0iQGyZQIg9QZaUPfrS5iWBVXP9gdgk46vIqlwDb7tadKIquhRm0adAjKPUiyu
 a+J+mtswONNbago9EPrT6Zybe2naf9wSXLNsEH6Bqy9wJEyfG6hBgVj3kzxEe/ju9nmX
 TPylMJXUt6nJfXouyXpAxRZRGNh8GzRz9Q+igRyYc0XTRbe6aOzh+W1jW1/QhSZ+8y5w
 wt08ntT7IqXvYISbGSogOKEatbrm85ZezMisVBeVAZB0snqJM55+x6DwrCBhe9sSPBkX
 pEzUS+dl24b5zs70eQ/4VOf0mbuUmfx2/6nNVm220e9MxBg4wsD6NPXtXfoTmq/S73+3
 HDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726499338; x=1727104138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vu2bW3oPLPtiaOMxv8oJDWfzTzC5BBzl6CK0bwZlSkE=;
 b=NFMIKDvmxoP7xAfXX/6DGsNNc0TC3tMpyvXD1GcKYS8sPvP5HFo6nq0iMtN90hgIDH
 /vj4EoA1GR6fj1vkk0eRDYoeYhbwpy0FQSl793p5GgUR76y190o1ZDqqa34sLphMJ3Jt
 GRcFrhQAgKpUcdSVqSB19WrV1sNuvLn9E1PNtjG5P4VC3jWM4AtgsuVHCVXZj/OvaJgO
 Oe9aa4OFBQpTsIBD6h0MWfeYGW5tqaV4icejlwv8TjOh7HoFryl8VE5gFPO3h/j0hG6U
 fsZlzdsDlKJzOiV71dfES4V/Kw1D21qxm0RG+5BhLL+Y2IGmXDiqbnbmtYUiK+BqLwUc
 VZHQ==
X-Gm-Message-State: AOJu0Yz7V+DbSWNtmS2zxkgW+254Of1l3NjmCeGhueIFz+EI/QswNx63
 eecvRMCBL70vE+BY915geZzOUwyVeR3Stmf4nvvAwmuGFaR79iy9y9B5DCKI
X-Google-Smtp-Source: AGHT+IH1gIPF3EhKwbuaRZX0PCyEdS4IBTEEIWk/DkQLPPf+Ots073bm8ldHhRNAHmGef5GuPCQXYg==
X-Received: by 2002:a05:6602:26ca:b0:82a:4c58:e1e0 with SMTP id
 ca18e2360f4ac-82d1f93f6dcmr1923382739f.12.1726499337890; 
 Mon, 16 Sep 2024 08:08:57 -0700 (PDT)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d37ed351ebsm1525037173.141.2024.09.16.08.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:08:56 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PATCH v1 0/4] hw/arm: xenpvh: Enable PCI for ARM PVH
Date: Mon, 16 Sep 2024 17:08:48 +0200
Message-ID: <20240916150853.1216703-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-io1-xd2d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Edgar E. Iglesias (4):
  xen: Expose handle_bufioreq in xen_register_ioreq
  hw/xen: xenpvh: Disable buffered IOREQs for ARM
  hw/xen: xenpvh: Add pci-intx-irq-base property
  hw/arm: xenpvh: Enable PCI for ARM PVH

 hw/arm/xen-pvh.c                |  17 ++++++
 hw/i386/xen/xen-hvm.c           |   4 +-
 hw/i386/xen/xen-pvh.c           |   3 +
 hw/xen/xen-hvm-common.c         | 100 +++++++++++++++++++-------------
 hw/xen/xen-pvh-common.c         |  40 ++++++++++++-
 include/hw/xen/xen-hvm-common.h |   3 +
 include/hw/xen/xen-pvh-common.h |   3 +
 include/hw/xen/xen_native.h     |   3 +-
 8 files changed, 129 insertions(+), 44 deletions(-)

-- 
2.43.0



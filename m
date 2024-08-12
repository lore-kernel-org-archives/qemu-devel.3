Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B45FC52D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 13:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdUkq-0003w9-90; Mon, 12 Aug 2024 09:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUki-0003qU-5D
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 09:06:24 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUkd-00045k-T8
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 09:06:23 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52f00ad303aso5836882e87.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 06:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723467977; x=1724072777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CShc+/eJ/eiKg8FqCgbRmAZvWuQTxo7AG/GfIA6PJS0=;
 b=F0GofdzWb/y2QLZ9uYOqQ88JqDO3SHt95lXGHVTbHRszbwq8YK7oZjbiFg8Ha9S120
 AZhcSEl9WfIPdYffpsk626//kSf+3mQ78Y3OhFxQrWVBIG3kYKyrK97Os1B5KNEEBc5O
 DIe4OBmGF3y1zck9DVsFNoccW4X19ivT9oLYWaoh5EJ88gjmNGsFovL8FfrgHmFrehwt
 YFgh7D1/3stlzfyH/SRI1sbNfIpFx/k8q/Krz1VA6zYPsi81nq2YjELGfQ4SRiqNFu+v
 Enl/BN97DYDUXk7dcl1tr/FUC62d8466/BVLSHUk6TOT71W383yLp3U/mkInXHeyfm/T
 0l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723467977; x=1724072777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CShc+/eJ/eiKg8FqCgbRmAZvWuQTxo7AG/GfIA6PJS0=;
 b=nlTaeQK2l0rUywDajsndC2gTE2dPzMiRktEQoCaSQGYGrApmhdsTlMDiRdvABQWmZU
 Fwg8tMmOcULIfXpK+nooZIfiQbQILttBSienvD41eHfT9vS0P4MeQZP7Ac9UTVXasOAD
 ie37nDpDspXp/29REUn3XX+9+zBK0g5sSUC/ROIzI84O8cDAz2/fVY90SQQ5HUpaav36
 dGny0caNIENaWerrTHnh8N4TwH/g/MeLfaPp7wBRwc4ieGs94Hs05QZ5S9N40JfDsHf2
 KRGeXNj5gQF5rT36T+9q19R7C3Z5zLzUEfrsTGgDFBHA12cTruX6ZmPobwugiWPmySJs
 C86Q==
X-Gm-Message-State: AOJu0Yxojcc5qhRKN3Jo3VjsAXDt4xAnJawqL/v0sKAXEZ5B+SBjw4ms
 uqN4Nx2yA0t9zQG+HCHgbZGLV+KbykqOKx96mIf+NNOZvxnFgl421OBs3lgh
X-Google-Smtp-Source: AGHT+IGyAfAGEwHpXN3mXDKP16d0LaryN/gTiqmKRJmEMkapDIMD5759JSxXq0T/pSPMTWqkAaeRxA==
X-Received: by 2002:a05:6512:696:b0:52c:d6d7:9dd0 with SMTP id
 2adb3069b0e04-53213658bdamr53118e87.20.1723467976051; 
 Mon, 12 Aug 2024 06:06:16 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53200f3f7cbsm733690e87.246.2024.08.12.06.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 06:06:15 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PATCH v1 00/10] xen: pvh: Partial QOM:fication with new x86 PVH
 machine
Date: Mon, 12 Aug 2024 15:05:55 +0200
Message-ID: <20240812130606.90410-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series breaks-out parts of the ARM PVH support into a reusable
QOM module. There's a bit of refactoring and some bug-fixes along
the way.

Finally we add a new x86 xen-pvh machine using the new xen-pvh-common
module.

The corresponding changes Xen for PVH x86 are work in progress
(by Xenia Ragiadakou). You can find a current version here:
https://github.com/edgarigl/xen/tree/edgar/virtio-pvh-upstream 

I've briefly described the steps to run Xen PVH x86 guests here
(including example guest kernel config, xl.cfg and xl command-lines):
https://github.com/edgarigl/docs/blob/master/xen/pvh/xenpvh-x86.md

Cheers,
Edgar

Edgar E. Iglesias (10):
  MAINTAINERS: Add docs/system/arm/xenpvh.rst
  hw/arm: xenpvh: Update file header to use SPDX
  hw/arm: xenpvh: Tweak machine description
  hw/arm: xenpvh: Add support for SMP guests
  hw/arm: xenpvh: Break out a common PVH module
  hw/arm: xenpvh: Rename xen_arm.c -> xen-pvh.c
  hw/arm: xenpvh: Reverse virtio-mmio creation order
  hw/xen: pvh-common: Add support for creating PCIe/GPEX
  hw/i386/xen: Add a Xen PVH x86 machine
  docs/system/i386: xenpvh: Add a basic description

 MAINTAINERS                     |   2 +
 docs/system/i386/xenpvh.rst     |  49 ++++++
 docs/system/target-i386.rst     |   1 +
 hw/arm/meson.build              |   2 +-
 hw/arm/trace-events             |   5 -
 hw/arm/xen-pvh.c                | 165 ++++++++++++++++++++
 hw/arm/xen_arm.c                | 267 --------------------------------
 hw/i386/xen/meson.build         |   1 +
 hw/i386/xen/xen-pvh.c           | 196 +++++++++++++++++++++++
 hw/xen/meson.build              |   1 +
 hw/xen/trace-events             |   4 +
 hw/xen/xen-pvh-common.c         | 262 +++++++++++++++++++++++++++++++
 include/hw/xen/xen-pvh-common.h |  53 +++++++
 13 files changed, 735 insertions(+), 273 deletions(-)
 create mode 100644 docs/system/i386/xenpvh.rst
 create mode 100644 hw/arm/xen-pvh.c
 delete mode 100644 hw/arm/xen_arm.c
 create mode 100644 hw/i386/xen/xen-pvh.c
 create mode 100644 hw/xen/xen-pvh-common.c
 create mode 100644 include/hw/xen/xen-pvh-common.h

-- 
2.43.0



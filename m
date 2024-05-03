Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99793C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2sFe-0004UA-Df; Fri, 03 May 2024 08:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s2sFc-0004T7-7R
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:42:56 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s2sFZ-0004Et-NT
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:42:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1eca195a7c8so25739545ad.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1714740171; x=1715344971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6EtT61KpBPa2eCBY2p0PwNLKs+b9PV1vePmApP7UedU=;
 b=SqJNT3qK4L2IFgx6d8bC8Bzb7i79pBqmqcVqDjBexNRF1w2ZJHXPOQabI7pGjjynXD
 KPjOtzqdl7sQhywe01qAR/xz1+TmPf4bUe2nYFHmIPPXefdbIBGd+L7uoidqbncyh88L
 J3qtPhNQj/euakYshbsibUlRUF3+1usmonldjwskMKu66HPIsReuRI/kjuY++/n3deQQ
 cOoT/f14e0cYu+M3zRuhc+IWHmE6VSNkq4r/C5kFNqtNH51OISiblTuMXXndX3fmEqZB
 05BJmgtRygRv9QH4WtL3+lMpYd5rErXp8UigtTMLyEyYQ1ONBYBUGc90bDdB+jkCfjjH
 d7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714740171; x=1715344971;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6EtT61KpBPa2eCBY2p0PwNLKs+b9PV1vePmApP7UedU=;
 b=Vz1862SE/DUTZ03Y4EYhXDEjxbMWrwCG1zRkp+71kEhEAGCOT6PN6MXhwVKad0lMqe
 S2X4L9Fxo3MXr7clsWQSp5FgxCCdzDZdavaeQRi3B77LQMtZOrDmWgeviT8O7NH6SLg7
 j8YWEVPqUO9pkwhRHxzhU8AvuPxZdthcwkuNF226Nw1PtWwR2t9s/RVtpuGkWFOj2kC/
 U//BX8zCBYMJ7sv4vDBwE5IG1hK2KRfdghDxHi7T8YxnBB+PRIfL9ZvAUs6YPxL9pj5k
 wYHu5IGBN9k6suHlrY8DwD0Yq9VkAfu18hP8izKKnlUHyVgGLqao0OmuymfMtbStMToz
 67NQ==
X-Gm-Message-State: AOJu0YyWthilNXHBUCl7KyV6REk9lwpkYp87k+ySkla+ZXatkTDC3k66
 0p6aS1UsuwEe87f613bMZv7cmag+QzMGToGCDCbrE5ji5MYQSJ8pe4IyjxtDVRLFBrQRJ3hy3FH
 V
X-Google-Smtp-Source: AGHT+IE5FjOw33Mnz1mLnJletlNHGKo50IggPL+HqovUUgul8bwgwWsA9v7v2XBr5Kb5fZcoHHAjMQ==
X-Received: by 2002:a17:902:ce0f:b0:1eb:5452:8606 with SMTP id
 k15-20020a170902ce0f00b001eb54528606mr3320900plg.48.1714740171602; 
 Fri, 03 May 2024 05:42:51 -0700 (PDT)
Received: from grind.. ([187.11.154.208]) by smtp.gmail.com with ESMTPSA id
 f7-20020a170902684700b001e3cee88212sm3192998pln.230.2024.05.03.05.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 05:42:51 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, kraxel@redhat.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [RFC PATCH 0/1] pci: allocate a PCI ID for RISC-V IOMMU
Date: Fri,  3 May 2024 09:42:43 -0300
Message-ID: <20240503124244.8804-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

In this RFC I want to check with Gerd and others if it's ok to add a PCI
id for the RISC-V IOMMU device. It's currently under review in [1]. The
idea is to fold this patch into the RISC-V IOMMU series if we're all ok
with this change.

Gerd, we picked the ID right after the PCI UFS device. Let me know if
you want another ID instead. 


Daniel Henrique Barboza (1):
  pci-ids.rst: add Red Hat pci-id for generic IOMMU device

 docs/specs/pci-ids.rst | 2 ++
 include/hw/pci/pci.h   | 1 +
 2 files changed, 3 insertions(+)

-- 
2.44.0



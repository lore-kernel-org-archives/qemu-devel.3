Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD30AC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 11:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx33h-0002re-HU; Wed, 17 Apr 2024 07:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rx33e-0002n6-6z; Wed, 17 Apr 2024 07:02:30 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rx33a-0002XH-1M; Wed, 17 Apr 2024 07:02:29 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ee12766586so501019b3a.0; 
 Wed, 17 Apr 2024 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713351743; x=1713956543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kK/n54eluvIUtrMSC8VuLlli9qeLf3bhJHkaVbW0upY=;
 b=ZneeXU96lh03nJFtjzV5M/aiDZV3go91ZqgiTsPZ9MERRylBqGQigj9fXOzqqKKzzw
 OM6nt0UQeuRQLkWE4H8HUX6WAEV6Des7iBVTuR4KqmrnI1JcDhm7eJSiqaxQ9EBY2Fzv
 yaiiVn8n29MuK2yUR8u6LL89kIbj+1xvvNjfMq4hhxTIPJC25ZQ72pXCI7nBji/Zny/Y
 yGBAn9LSACSERPVA36QX6gSOddGXpub0Q3c+vlLTh+zUBlqposS6sfQmVbYC0vOLuCxQ
 X7/mg1pdctB8YD3JXcbeTzBA8OCKi2zbtQ0iC1jwa0ePt0ZsPzKtlo9QYI0oUSW732o3
 yx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713351743; x=1713956543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kK/n54eluvIUtrMSC8VuLlli9qeLf3bhJHkaVbW0upY=;
 b=v+ISf9i8b6kA8ZYmdqsUy7PEetukP5kbrAgLhYD07PzEnTeaTItXa272ZRtUATw2Fi
 Lv0GeN2uwwyucelR+PqlZ4nbEUygRDMx5oii62tKZHT28LZv/qC/3j7SWBzUeHtgFIwq
 FaTh8qFbHJ7wND76TLrt9esZ7JUMUZGB49IiKOEKS5kOICyXsTDD4H1lIieSTQEYRt0d
 sTFRIDeoZhkqRSAED2wgub402X1ug5kHiVQ0SqnA6F9EWA6H+c+IlGUitOFLrxHgll88
 sYdQQa+J8G5PzFfAoaDA8DkE+vXvEp7cOx2Ln+c76tCUE+W6BMPqcDJr4bOlMxthd/mv
 jXKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfKtKtCbBoY9JCts9cfBWABbDW4CObAnXjPVAwIf/4eft6GYuW7IUpU6zfCa1kYN/iumzLUZX96In3YoTkaKIzqwTYp8U=
X-Gm-Message-State: AOJu0Yxt9Oz1+odeJczIEDwyl1xMTgxD5O0TSes1CpzQXLJufS9OkfCV
 etuDUKOHK6lMnnN6lTjSLnK1p2VhYrIRiPio816HhenVau8LpYvp/o13xw==
X-Google-Smtp-Source: AGHT+IEZYWmX2nC3+NqhdcqbtsZzEjqIBUmVij2wnuypvNV1UHloRrCEjysj1pA8tFy0/TRfcU+htw==
X-Received: by 2002:a05:6a21:9202:b0:1a7:590e:279e with SMTP id
 tl2-20020a056a21920200b001a7590e279emr6813516pzb.5.1713351743491; 
 Wed, 17 Apr 2024 04:02:23 -0700 (PDT)
Received: from wheely.local0.net ([1.146.62.55])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a056a0023c500b006e6be006637sm10407787pfc.135.2024.04.17.04.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 04:02:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Subject: [PATCH 0/2] ppc/pnv: ADU model for POWER9/10
Date: Wed, 17 Apr 2024 21:02:11 +1000
Message-ID: <20240417110215.808926-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

These patches adds the framework for a proper ADU model rather than
putting registers into the xscom default ops, and implements ADU's
indirect LPC access functionality which IBM's proprietary firmware
uses to provide consoles on UARTs.

Patch 1 should be quite a simple hooking up the xscom address space.

Patch 2 implements one of the memory access functions of the ADU that
drives access to LPC address space from XSCOM register operations which
is non-trivial but there are similar examples already in tree.

Thanks,
Nick

Nicholas Piggin (2):
  ppc/pnv: Begin a more complete ADU LPC model for POWER9/10
  ppc/pnv: Implement ADU access to LPC space

 include/hw/ppc/pnv_adu.h   |  41 ++++++++
 include/hw/ppc/pnv_chip.h  |   3 +
 include/hw/ppc/pnv_lpc.h   |   5 +
 include/hw/ppc/pnv_xscom.h |   6 ++
 hw/ppc/pnv.c               |  20 ++++
 hw/ppc/pnv_adu.c           | 202 +++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_lpc.c           |  12 +--
 hw/ppc/pnv_xscom.c         |   9 --
 hw/ppc/meson.build         |   1 +
 hw/ppc/trace-events        |   4 +
 10 files changed, 288 insertions(+), 15 deletions(-)
 create mode 100644 include/hw/ppc/pnv_adu.h
 create mode 100644 hw/ppc/pnv_adu.c

-- 
2.43.0



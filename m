Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C5CC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk37M-0005U7-Ke; Tue, 12 Mar 2024 10:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rk36x-0005NB-OD
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:28:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rk36v-0005O1-AI
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:28:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4132a436086so13584145e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1710253686; x=1710858486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dXi5tmsrXivALkRrCcWzIonKD+Tj1f5wxXwS4HZXIxk=;
 b=CxLOBL/gMflmqCJ4FDo12JMrDZgyikta565BaxMFt21lpVGWzbMnf4wotInR9oiRKX
 wqyYwb8oMBNL6S46jdHkSKKKwaJ3Cd+wqQ8dOxrm+s08rpeTmMKzXCNSIycN6yR0wlg/
 nvdtl5NJ4jHmRM+BgikyjmFC7nkKYqLifG9Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710253686; x=1710858486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dXi5tmsrXivALkRrCcWzIonKD+Tj1f5wxXwS4HZXIxk=;
 b=Q9+FMOfxRVjR0WeSBcqLoMd7cZQ2Siftvbd5Iwfj+Z4hNVv7ggYjDgKI0aAI3RB6Eo
 /UkeoxigRBfm2k4tD44XPZuiBdNE9NIwXspsXrhu8g3TpsAWp5ApSXeUdIjuJpiwozF/
 Tbgskrlwj/72Z3baB9+vIz0FA7a+LFITBZRW74ebsbSA1sydlFDZVIFjpfjs+htXw3rn
 R9Jueq8xKJUXPfpqV+jWoJYqW8z+4F041JHfIvSPPGraF62B6sUOh2/ehr5jPxEPyxXY
 XbJslYG+DTCoVqJoPOPDrah8Q0KkqSPu9MCUmTKR6mFb5AYF1H4Nnp1LT8nExsYvA75y
 peLw==
X-Gm-Message-State: AOJu0YxhaSZ2igOUtTnlX5V/yTa5dCtEvoYL4Kz1rKd6Eo127pR3XdSz
 Ou+3ZarmY2xdTVILUNILQDtFH5bJXfHRVm+YWdMPIYL4ddVz0eFW/9jsAA34g5BXXoT31LHirbe
 M
X-Google-Smtp-Source: AGHT+IH/E/aFCGLF4xzgbjjOVu2GKK0+gMwSyGkeprPV2pz9FhPy/+j6qXF7gKxgPz/lcZ8pKdM7LA==
X-Received: by 2002:a05:600c:b8c:b0:413:3391:2f23 with SMTP id
 fl12-20020a05600c0b8c00b0041333912f23mr1511084wmb.35.1710253686050; 
 Tue, 12 Mar 2024 07:28:06 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92320-cmbg19-2-0-cust35.5-4.cable.virginm.net. [82.13.64.36])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a05600c198d00b00412b0e51ef9sm12810270wmq.31.2024.03.12.07.28.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:28:05 -0700 (PDT)
From: Anthony PERARD <anthony.perard@citrix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Xen queue 2024-03-12
Date: Tue, 12 Mar 2024 14:27:54 +0000
Message-Id: <20240312142757.34141-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=anthony.perard@cloud.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
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

The following changes since commit 8f3f329f5e0117bd1a23a79ab751f8a7d3471e4b:

  Merge tag 'migration-20240311-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-03-12 11:35:41 +0000)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20240312

for you to fetch changes up to 918a7f706b69a8c725bac0694971d2831f688ebb:

  i386: load kernel on xen using DMA (2024-03-12 14:13:08 +0000)

----------------------------------------------------------------
Xen queue:

* In Xen PCI passthrough, emulate multifunction bit.
* Fix in Xen mapcache.
* Improve performance of kernel+initrd loading in an Xen HVM Direct
  Kernel Boot scenario.

----------------------------------------------------------------
Marek Marczykowski-Górecki (1):
      i386: load kernel on xen using DMA

Peng Fan (1):
      xen: Drop out of coroutine context xen_invalidate_map_cache_entry

Ross Lagerwall (1):
      xen/pt: Emulate multifunction bit in header type

 hw/i386/pc.c                |  3 ++-
 hw/xen/xen-mapcache.c       | 30 ++++++++++++++++++++++++++++--
 hw/xen/xen_pt_config_init.c |  7 +++++--
 3 files changed, 35 insertions(+), 5 deletions(-)


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F55CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Za9-0002BD-Bj; Tue, 30 Sep 2025 08:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Za4-00029K-Cg
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:35:44 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3ZZx-0007ZY-0I
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:35:43 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e52279279so16917315e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759235731; x=1759840531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KFWv8ruIA0VwK/mFTz18WFSqvuIfjBdUaheVoSUMAQM=;
 b=c85wpTs+d0CBAvx2Nezfr1WuKU8FcO2NfJprOHMd0cKNMyYwoV6BQqVhCPoB8J32d4
 wlUh8pmE8RoV0Blq9BEXco2t1WfRnMP4lYXib1nI1bkYQ/uOJVu0cS2o6r7oNpvgstW+
 MPGmsTD/cObFjrx+XwbsTZBblGj1NDkjGazUmFucNy1oIblgmT6BzqjWR+wv4ecwfd8h
 W24YY5i9hF7XWZBQlX02hys47AKsic/Gwbg4/WiYPT1PO0XU2S6QFYEr/PD0NJpj9kLt
 lHVF273AdGZD8lTIVRLZFQIIyJKRHQwj3rZLyxS1EuR6kt0ua22xrPkhwIKSXtB76V36
 pQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759235731; x=1759840531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KFWv8ruIA0VwK/mFTz18WFSqvuIfjBdUaheVoSUMAQM=;
 b=H+JXlDJxRovAeRkxuJOJes1JXFqNbX4SEh2YLBhcOVbKeOsbThCJVe9mP7+vyQJZsA
 X13kTHXwV3zSntYSI2rENknEHO3xQtcm7b+i2nVJlASeTNYB/3j0a/AXrrkpiuTIvx/z
 Uaty5fG+aQC9k1wazCr7PLLgNy6T99bVycLy5ZVXoCQwe9hDrqglLlL5CCxR4EdlDlUS
 8J6lih/PmlcsFaw5oXSy0IuV/8958PWsmwLiB3VNB1wFEhu1oMSHucZZuczgPsLgF2W4
 tLOJdEi4FzD3LN9xBqOJGloGkh523idxlV+FvaaxB1qB6+/9mfo2/MhJoQi7rxC5Uyby
 Qgyw==
X-Gm-Message-State: AOJu0YwOFvz1C2rZXctSMY76OkrHGLoIZRVedTna+IgKpzDOKzSB7QzC
 VQBO+Naaq0Q6PFQWyQ+iPyX4NBa6tBciH9egUheVUNqKHmD6xYJSIDw2yDLSBUhGRBQmxL64uXH
 TvQ2KHxlTpA==
X-Gm-Gg: ASbGncvqkCEKIiJD0lEWyxFfuh2r2EsHgyOBIysIw3ol+Us1PPc9ctqe/j6YkB8CmzJ
 WdBBNQDFf2ghXLd6kpeXkr3X7IDLS9WgOiePEkJyKWtksqWw20VzeG1Dr4foJ31GCu7xoF/Nznv
 TnwKaTJmhOg1HKZAuRvmJfxJmAstL+TVpTHaePPhVLJxLkVu2yUDO6OQa2rEaH9pNzuyu70OS9w
 pvwlJKvbiCju4FDgs1rAHG67sj2EXtlouAXhxRDhY1WyYWiOYgYYG3njrelm7zcyNOfHjK0OvI3
 Nxh+sV65g0PZCJnjZArYo6xlldxQ0SDwG8T5nY9Fxkl8TLBZOv42dnVRgFr848u+3ENyBlLXdD3
 VWin7YdtzQulI3ayDEVLL2ov/nrDDo1lqDDgenSDBzCg7f/W9dB+/eHqx97mG6uJPNtjB1ktwQh
 ltpA5ZgLlBmsl19Ga84tnt
X-Google-Smtp-Source: AGHT+IGB+uzpHeqfu0jFbRTMTzgTb7KsOzcXhfauf4qGnBFYqWe08kCxxBXdbINjPn0IHNEHnOdXdg==
X-Received: by 2002:a05:600c:4e8b:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-46e37fce148mr150226115e9.9.1759235731365; 
 Tue, 30 Sep 2025 05:35:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5c3cad50sm12533085e9.3.2025.09.30.05.35.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 05:35:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/4] hw/vfio: Remove invalid uses of ram_addr_t type
Date: Tue, 30 Sep 2025 14:35:24 +0200
Message-ID: <20250930123528.42878-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Replace ram_addr_t by either hwaddr or uint64_t types.

Since v2:
- Rename variables as 'translated_addr' (Cédric)

Philippe Mathieu-Daudé (4):
  system/iommufd: Use uint64_t type for IOVA mapping size
  hw/vfio: Reorder vfio_container_query_dirty_bitmap() trace format
  hw/vfio: Avoid ram_addr_t in vfio_container_query_dirty_bitmap()
  hw/vfio: Use uint64_t for IOVA mapping size in vfio_container_dma_*map

 include/hw/vfio/vfio-container.h | 13 +++++++------
 include/hw/vfio/vfio-cpr.h       |  2 +-
 include/system/iommufd.h         |  6 +++---
 backends/iommufd.c               |  6 +++---
 hw/vfio-user/container.c         |  4 ++--
 hw/vfio/container-legacy.c       |  8 ++++----
 hw/vfio/container.c              | 15 ++++++++-------
 hw/vfio/cpr-legacy.c             |  2 +-
 hw/vfio/iommufd.c                |  6 +++---
 hw/vfio/listener.c               | 18 +++++++++---------
 hw/vfio/trace-events             |  6 +++---
 11 files changed, 44 insertions(+), 42 deletions(-)

-- 
2.51.0



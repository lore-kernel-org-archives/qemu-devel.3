Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18537C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 12:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg0lj-0003UM-JG; Thu, 06 Feb 2025 07:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tg0lf-0003TO-TF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 07:14:04 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tg0lZ-0004TT-Ds
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 07:14:00 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5dcd9158717so1388560a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 04:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738844033; x=1739448833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fKLBqAkCuqGvjbdKBK1WvDvysW5flfn6d3BJYimk/6g=;
 b=gVR2jR6FwJ7PgYhnRnaRg95fAKaSgkb9/ucavgwGuzR2LfGaGOASWSacEXh9a3x2O7
 DkGwG9zEQU9YDnINI2xcAQi76j0VM/yBO60cxf+T03u5Lc/kbWX6Z33Lt88cg1cXZ+l9
 /tiEDl6h0xchtlEV5nbECL/Qedr8hNY45Wu8Q6wQQlSahi/t6x6DNQ9qEVujN+NxTJQl
 vSaVHymDT/PXf3VT6WXVEPoYR73fWaYK+B9iB5TxNhjhFgZknDKRYzAY82pYHyTPqajr
 NK8LKl+EyjfcH0TKKsiNDqeM/uGG+T+OmipaqUKkcWP3h9Vl08/yg8Hu3kQEte1++FVb
 JhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738844033; x=1739448833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fKLBqAkCuqGvjbdKBK1WvDvysW5flfn6d3BJYimk/6g=;
 b=dogLczJ5SNwNqMqX7r2/R8/dQABAbmMy3BUQTjLjFnhn+3i5QezBBo2cb/eCw0tEjU
 HoD+aC1tWO1HEixnIQO5r90aJx8KXaiHJfOt9ssM3vG94aooVpLYixqiRdCdYYvlMuTH
 rxu5NxJ3C6Iehom1AgXgm4QfQd0dd1hBCew9rUbobayUrJBcdYzRyZ84a1/bhFuK/O0Z
 QNObMWsOCJFdO/kOp5b8ai44PbjJkspMDCGxRNGprHZWd+WdN8G+NGsasKihc0BJcXvn
 R/KFFu5IUSVHTt458EgXo1ocw/c18oDlW360w9bU7g1Q2K0PAFIMhcEAOEv8rmcGycaL
 DOsQ==
X-Gm-Message-State: AOJu0Yz1+UZxGNuKq+ixfEgMRvQY6FrzCKXzijJYy6OiG3l3d1LReTEN
 isBiwqZocWT5QSNEKMkwGroBgSd6mf1XAEWESaoORLk+/Dqc3jwbWZ97M/INiMQ=
X-Gm-Gg: ASbGncuvwRmISxmkcBnsOeYu4XlKgKtdmoEXetW2v0eA3IjWi9mgdTTWvwPRrE9n03u
 A4cpWOMuQTz6JTdC9rCx0DXJjvGRdDEHGjLr18QrtjI6CbbLAzEluWsConZV09kpjIbBd3DGvwp
 Mp3hoE9bqw4ykjItw3s5racSAeY2XFyYu4qQaEXvp3EWzPPDy1pJw6AhVrU8Ygn+21wWhBBcRZ4
 b2KYkOBwj1fyRQZ0wQnYvVeFVu8wgxIAAVsQAS4R0kljMNfZIv5+rplUkTUgU+CbXRQ7jbWG74L
 XfC0qV+DhLfFLMh6rFZZ1+mMa3yJ413IVjmCV476LHY=
X-Google-Smtp-Source: AGHT+IGxAK/r6LJ+fG01E3tMbgMxIGsG/fUWirEHl/7iJ9GWEW6ffEEnH0a1JT/U+XIooIoIJxqnkg==
X-Received: by 2002:a05:6402:13d5:b0:5db:f52c:806c with SMTP id
 4fb4d7f45d1cf-5dcdb77525emr6789001a12.20.1738844033080; 
 Thu, 06 Feb 2025 04:13:53 -0800 (PST)
Received: from corvink-nb.tail0f5ff.ts.net ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf1b7ade9sm772388a12.25.2025.02.06.04.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 04:13:52 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 0/4] vfio/igd: sync PCI IDs with i915
Date: Thu,  6 Feb 2025 13:13:36 +0100
Message-ID: <20250206121341.118337-1-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x531.google.com
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

From: Corvin Köhne <c.koehne@beckhoff.com>

Hi,

we're currently maintaining an own list of PCI IDs to match the generation of
Intels integrated graphic devices. Linux maintains a list too. It's list is
more recent, contains the full PCI ID of all devices and ships some macros to
easily match them. This patch series imports the PCI ID list from Linux and
reuses it.

Best regards,
Corvin

Corvin Köhne (4):
  include/standard-headers: add PCI IDs for Intel GPUs
  scripts/update-linux-headers: include PCI ID header for Intel GPUs
  vfio/igd: use PCI ID defines to detect IGD gen
  vfio/igd: sync GPU generation with i915 kernel driver

 hw/vfio/igd.c                               |  81 +-
 include/standard-headers/drm/intel/pciids.h | 834 ++++++++++++++++++++
 scripts/update-linux-headers.sh             |   6 +
 3 files changed, 886 insertions(+), 35 deletions(-)
 create mode 100644 include/standard-headers/drm/intel/pciids.h

-- 
2.48.1



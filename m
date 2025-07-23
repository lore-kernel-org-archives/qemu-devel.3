Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D00DC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 16:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uec1z-00028E-P8; Wed, 23 Jul 2025 12:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uec1u-00026m-RB
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:09:19 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uec1t-00049v-EB
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:09:18 -0400
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-313bb9b2f5bso1887a91.3
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286955; x=1753891755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ryJs4fnsAEOocYYXtesa1hTFW3TNwArTaKjHOpZPxFc=;
 b=Qit9WxnYBu10uAfXgoIK7w4AQUKNFvtGxpAEOswls0Evo7iYDLw7yBp2xRU5nVtcKx
 3FqGic0GoimdRvSltevfesf2pTH1hy5ZGkgzA9X/vKtqKHEZrYcGUliiAu84HnpugviG
 +wHjHz10yk7J1PA1pSDUJgTJNPHOkxH/aMZ19HU6VRRVBCYxa/yqbKf9W7hxKvn6HS9r
 sCuLWbw2ELtPRuHifRvnY6aJejw1ynWXGezTz47p5JnAuKJNUqYYxQt+nh5zT59887MW
 h2TLW0zTOOOlZBpDH3tmPUy1koRMVnwbM91cWj9jUQYxBXHYptu8jhjW0gHmREYvXAd5
 28jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286955; x=1753891755;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ryJs4fnsAEOocYYXtesa1hTFW3TNwArTaKjHOpZPxFc=;
 b=f1tjZFh0ZzlhOd79p54QkBg/Ic0DSe8f3frd5fWo3xvf5HMBsukU7AQXtodmvcR3ny
 3BVM82xZw3lstnd9rUB791zP0u9XhDwRXXgcay3oDTaFEOJLrIA444O9IDACYzFoD0nA
 ZXHKchVXTW+E074zgOIfja+05D8+yJB9tIrTVvWKaV/pLPD6tZKNbME8Zegw6TVL3i3C
 zzAcbHvVFIwQ9nrLjOqP4QcZqeVkUnbQpfvICcR1ncJh3VPkxEViIj5e47wI0ckm8oOl
 7Wwg0XOK24JlAhydejbqoY6KHZYSN0x9XSorDIP3U/ptZ6259f6d/DkC+BUCKSJnzBoc
 0xNg==
X-Gm-Message-State: AOJu0YwNTvAbCXj44g9PrUEsQWwjJvbq2FtsE147xh1QVW3YpRkqrt9c
 1zRky7RvHXn8CUizdp5kIBe7CVN+UCr9zCkXy7SgwBJSq29XkbScmAc=
X-Gm-Gg: ASbGncvHL1yAjxR9Z3ktbsjWgUFKcpuspOyUvwZcWN/Tf1hGqIxv0+Ju0FaZaO0ZV3z
 9FuYfzyJreP/v4HQqFVQ0gLMA54g3x17LtxJBS4jOmJjA+KH0Cr6FMVfvEjS5jNjKF8zXMogqDF
 O8KN/723HRAfTgB6Lg0VPzKjdGC0j4U8rLqGy6ZaQiMF6MY7JoEbxZ3xLJY8mciwd0odm15nneh
 5k1YlqKzzloqFDQnp38b2+tBGc+lhOnr4/buo4+S2Puu3ZBXJCNhwymIfoMepAmpWBj3c73SFIV
 KL8FKmRIQs75q2QW1n9iCwSudV+39XGDkfN7xd3HCC356uswSZw5PivWVY18JoLiybATido+aGZ
 Fb7j664XKWsc6A2i1hlRUjldEuEw27kBjrWY=
X-Google-Smtp-Source: AGHT+IHaHrHMc3cjQtsJE7erJRTun7smKt8p9riAreEVtH7cW0Vlj0ufLpevHAuxWxiODetbvrpRzQ==
X-Received: by 2002:a17:90b:1c01:b0:313:d6ce:6c6e with SMTP id
 98e67ed59e1d1-31e507a852bmr5353323a91.8.1753286955097; 
 Wed, 23 Jul 2025 09:09:15 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.46])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e519f61eesm1968353a91.14.2025.07.23.09.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 09:09:14 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 0/2] vfio/igd: Legacy mode fixes after introduction of
Date: Thu, 24 Jul 2025 00:09:04 +0800
Message-ID: <20250723160906.44941-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1042.google.com
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

This patchset aims to fix 2 bugs on legacy mode brought by commit
a59d06305fff ("vfio/pci: Introduce x-pci-class-code option").

1. QEMU tries to enable VGA access on device emulated to VGA controller.
2. pci_register_vga() is not called after calling vfio_populate_vga().


Tomita Moeko (2):
  vfio/igd: Require host VGA decode for legacy mode
  vfio/igd: Fix VGA regions are not exposed in legacy mode

 docs/igd-assign.txt |  1 +
 hw/vfio/igd.c       | 19 ++++++++++++-------
 hw/vfio/pci.c       | 13 ++++++++++---
 hw/vfio/pci.h       |  1 +
 4 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.47.2



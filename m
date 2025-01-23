Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4476BC02181
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 01:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1talwm-0001oW-95; Wed, 22 Jan 2025 20:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1talwk-0001o7-SE
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 20:23:50 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1talwf-0005DO-Dc
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 20:23:50 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso612285a91.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 17:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737595422; x=1738200222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fc1pxH5JH9iMSor5aAW6WHLdKG7RTTfXZVLVZRy0xpc=;
 b=QLedx7CHUED4T8GjzH4u7IX3hn/m+5XROu6Xz8eiVBnRckxW+4ABYZt+kipRUfdOCd
 i1h1xA5r7iQvMa6KdaaxYW12QlMZKK98u4A6VVGEcaNvsJE8Ttie6nmTnT520+3PuxbT
 PJO3gSsffPNIIzB0kfb8+hupeMbL2sJ0kk4mrqfGgfUlbYjS5x5N4Fgkb39A3UGvnXfj
 z9oMmM9qzEEVd9UI8oMdK2sgWrMw6OxbHFcyVb0rhzy/YFqeYPpWXC15Msne4dOTbkDx
 autSqomc9SjtVj3E53uUMm+Qe2mpQ5+0zy2kLWKrnIMgZKv8ayKYIFqHx0rwGAlJMoDZ
 OPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737595422; x=1738200222;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fc1pxH5JH9iMSor5aAW6WHLdKG7RTTfXZVLVZRy0xpc=;
 b=FwCItqfWKeDQ62GRkAnloez1ur/+x5zCoFhNZdglZEfVHKOchM+hR/BFg2Ragbd5zY
 t8HcYifUdAWfkDbAsmFnCKMKO6580nTuxb+tbUyCV65A2bcehOb5NueJ+GcH+zN+EVl+
 W8Em6sNJ613EQMU1ylPuoMofBJC6annP//J8U+/CnAztPSqggUJzi/5C2FNBgOb0rBUa
 eEI6DwyCm+LD+udRrLoUMWcjp/umb9/9Mt+gvCetN3aBZqTCrKIIR/cc5emPxUVk46VO
 PtWyVTf6B1ajGCPoY/QSECgn6mgVMaFORScCjNArU2fISwYDMQsZUiGNz40XGB5gCpfx
 lbqw==
X-Gm-Message-State: AOJu0YzOS01Z7WKm4CEyZtjgQJHu3vwrMn2PMtwJbmxYFenK5RzmMj/N
 wWwBqmCz4LZ8d82/JZTTNJgvSRdwyokSHbdgu0A9b07w6ewK21PrqNjfDlgmByMbqgshDbs6Fmv
 z
X-Gm-Gg: ASbGncuC9+PIPH7cTUCyv6Eeg+m238Wz2VwVk0ZsJ5rhDPrlgR2VhXJxxQ6/ID2cKPp
 HaaB4w0VTemg34vKLinQphHznohbE2mux0XTdTLXLQC3YMPZl5PU4Odm66eg/l8tW9Dbow9Zyf1
 0Rumk0sYppYXeTptbkH+uQQAW9RzA8bFuLjQmcA/QKJmO4sy+ciQ0l/x0rI7mnETv0mY8UO9UJP
 ZSmO266MYObloottgOK8gcMukNU9qLvp595Jv8qF0IsfRZS7h1E/g15QzsC/qR8WNT32rvcBkaV
 9kujAFZEIAw=
X-Google-Smtp-Source: AGHT+IFfk49E65l6BmaXy0QWtqWd78JmO+XxaTB+/zJGP1Mj2ZSHI9hc8feFp8wSi5PzV3jF5QAgHg==
X-Received: by 2002:a17:90b:530f:b0:2ea:5054:6c44 with SMTP id
 98e67ed59e1d1-2f782d86491mr33568631a91.31.1737595422244; 
 Wed, 22 Jan 2025 17:23:42 -0800 (PST)
Received: from gromero0.. ([191.205.214.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7e6a5e389sm2498793a91.4.2025.01.22.17.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 17:23:41 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	philmd@linaro.org,
	armbru@redhat.com
Cc: alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 0/2] Add me as the maintainer for ivshmem-pci
Date: Thu, 23 Jan 2025 01:22:10 +0000
Message-Id: <20250123012212.716499-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x102a.google.com
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

Add me as the maintainer for the ivshmem-pci.c device, the ivshmem
server, and the ivshmem client tool. Also, adjust remaining parts left
behind after ivshmem PCI device was renamed from ivshmem.c to
ivshmem-pci.c, like header files, Kconfig, docs, and build scripts.


Cheers,
Gustavo

Gustavo Romero (2):
  hw/misc/ivshmem-pci: Rename remaining parts for consistency
  MAINTAINERS: Add me as the maintainer for ivshmem-pci

 MAINTAINERS                                          | 9 ++++++++-
 contrib/ivshmem-client/ivshmem-client.h              | 2 +-
 contrib/ivshmem-server/ivshmem-server.h              | 2 +-
 docs/system/device-emulation.rst                     | 2 +-
 docs/system/devices/ivshmem-flat.rst                 | 2 +-
 docs/system/devices/{ivshmem.rst => ivshmem-pci.rst} | 4 ++--
 hw/misc/Kconfig                                      | 4 ++--
 hw/misc/ivshmem-pci.c                                | 2 +-
 hw/misc/meson.build                                  | 4 ++--
 include/hw/misc/{ivshmem.h => ivshmem-pci.h}         | 6 +++---
 tests/qtest/meson.build                              | 2 +-
 11 files changed, 23 insertions(+), 16 deletions(-)
 rename docs/system/devices/{ivshmem.rst => ivshmem-pci.rst} (96%)
 rename include/hw/misc/{ivshmem.h => ivshmem-pci.h} (88%)

-- 
2.34.1



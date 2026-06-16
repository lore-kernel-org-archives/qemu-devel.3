Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F6FCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZUKD-000507-8l; Tue, 16 Jun 2026 09:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wZUKB-0004zz-An
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:59:31 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wZUK9-0007KF-N5
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:59:31 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5aa2c25c632so4652188e87.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781618368; x=1782223168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YcfhzjV8hzdJ4Kkr/cLAEMHF7Fz9wIaChqqT5b3fyPs=;
 b=iRfz5IbuESCBuA8lcgDfXWdZpdUN3H1YGYoDf3fL4jzqwUaf5M6gEZsHKfvugzFkMW
 v/K6ztG+qbw1wf/wmY77rFvLpKrxj1JwqWp+RxHeVxHxjDpouwifTX+isnBwdQIT/QHq
 /gUFOu9VAxO68EWwkUxX1s6nB9I2fucK8mgng4cQnMtasAQZF9hkyB5gA2QWfgvQ0lbz
 OS4InJjPUFzMTpqT09Bj6xIlFOBwhDBxKiqJ7+CNXv/hjCc7Pp/qUSYuluyUZ1hzJoYT
 kY8/qh1Mqi9WOrWIORR3z6g3VJ7eEj26mlh52LRVT35786QfdAGAj8LyZKZvUmIw/3dK
 OAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781618368; x=1782223168;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YcfhzjV8hzdJ4Kkr/cLAEMHF7Fz9wIaChqqT5b3fyPs=;
 b=ibj6bK5KG2CexfDzi5SDJDebv4uznoEMG9jVgirr1XF68RQkhLDDz7jRY/EnLYBbjp
 t7o2dR09gSBQj9C4lsW0mhRASV75IyuoOCuQy2oHSYPXh2mE3Qa3k81X4eNPkMoOAjCe
 b3gdTiww3tUiqZu67YJ6cOvtAdOM6sR8hqBrwQkRAxc7pY/wnoLdJAG+hT7nxAK8fdMw
 laehylF80wgWgAVTMjUFARSdCy9DJcIYjyZKl33VznYUgxxPJo9uz/ugZLF8Zd6RB3qQ
 UOLlDuCxTG1DEn/oyX6tju54T2usqgXWljUzwThHGYR5YY3PIt7foxg3UjURBeGVHNVb
 AZJA==
X-Gm-Message-State: AOJu0YzzBMKo4mwpJAiq3e/Sf3LUS7nxZT6LtTgWE1iE6IiSCfiNNCeG
 mlUtIK8GhfNFHEORrIBXHQOs8+YYC31aMCcw8hnO0FZE50eH6yVjlp5pP5n7U8k6bLw=
X-Gm-Gg: Acq92OE/kPOjPD65cI9oyS/5zSSha3LCeBmMi2wk5xV5f4pbZ9dI/t9hc3pxXC6/rp6
 hZ0ZY6zCntVGg4uNt60bROdDykZc4m+zUANwCY3rgmbXQ18xcvj2TDB79pmeOI/j4SSiL8VO0eW
 jYHrRCe2IAnhThpTJ9A8WczNwr7OEVerPx5SYBwH88DFVpFearaqmoZwOEGn6XPBxg/Qq7cyk0c
 /EWoyYaj+86ZDbajBXfSgfytdIsGJ96BwOiin3lUa8QYyr2XYBc39x8VwnlZpy8/owd9ko6gGSN
 PaQaUkNWY/LoVANXGnZ/PhDc+w7NLp9ZLUjAOSDh5oHXMqZibqLoZOwhe3LsM9+yt6sOhZfTE/I
 bzcIarNAFRPak1vGBJMns0TQi+echDuseMDDf7fDtpuo3nnFUQPxO5xM6xrAgd9jQ/CbKzaWt1g
 I1wr4/RClOIr5n0KUvW1s8vV3JHztWz2fqvpOOEPm4QALtweaJ
X-Received: by 2002:a05:6512:800d:20b0:5a7:4822:368c with SMTP id
 2adb3069b0e04-5ad30da70d7mr3053238e87.22.1781618367426; 
 Tue, 16 Jun 2026 06:59:27 -0700 (PDT)
Received: from xpahos-osx.yandex.net ([2a02:6bf:8011:f00:689d:b3a0:c7eb:5526])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161f1esm3634677e87.2.2026.06.16.06.59.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 06:59:25 -0700 (PDT)
From: Alexander Gryanko <xpahos@gmail.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com, philmd@linaro.org,
 anisinha@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 zhao1.liu@intel.com, Alexander Gryanko <xpahos@gmail.com>
Subject: [PATCH v2 0/3] hw/smbios: Add dedicated handle range for Type 8 tables
Date: Tue, 16 Jun 2026 16:59:01 +0300
Message-Id: <20260616135904.44930-1-xpahos@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=xpahos@gmail.com; helo=mail-lf1-x133.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a continuation of the work originally proposed by Felix Wu [1],
which changed the SMBIOS Type 8 handle base unconditionally. As Igor
Mammedov pointed out in review, an unconditional change would break
live migration between hosts running different QEMU versions.
This series addresses the review feedback by:
- Using machine-type versioning (pc-*-11.2) to opt in to the new
  behavior, preserving T0_BASE for older machine types
- Adding a PCMachineClass field to control the setting per machine type
- Adding tests for both new and compat machine versions
[1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg03208.html

Changes since v1:
- Resent with Igor Mammedov on Cc as the ACPI/SMBIOS supporter.
- No code changes.

Alexander Gryanko (3):
  hw/i386/pc: Introduce 11.2 machine type for SMBIOS type 8 base
    migration
  hw/smbios: Add dedicated handle range for Type 8 tables
  tests/qtest: Add SMBIOS Type 8 handle base tests

 hw/core/machine.c              |  3 ++
 hw/i386/fw_cfg.c               |  1 +
 hw/i386/pc.c                   |  3 ++
 hw/i386/pc_piix.c              | 16 +++++++-
 hw/i386/pc_q35.c               | 16 +++++++-
 hw/smbios/smbios.c             | 10 ++++-
 include/hw/core/boards.h       |  3 ++
 include/hw/firmware/smbios.h   |  1 +
 include/hw/i386/pc.h           |  4 ++
 tests/qtest/bios-tables-test.c | 70 +++++++++++++++++++++++++++++++++-
 10 files changed, 121 insertions(+), 6 deletions(-)

-- 
2.39.5 (Apple Git-154)



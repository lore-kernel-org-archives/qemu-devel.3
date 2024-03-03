Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB2BC54E49
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 18:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgqyG-0002z4-W8; Sun, 03 Mar 2024 13:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgqy4-0002xg-IC
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 13:53:49 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgqy2-0003xj-Al
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 13:53:48 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-412b83cfac4so27157125e9.0
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 10:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709492023; x=1710096823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=baHI6m1T65RnSlCWzDcEpxWd9aF6YHbHZbyLFWSGcSE=;
 b=L+G/aUryPMlmj2f1olTd7EtwUdBjHi4s3tqixKn5xiqXeZXRgK6XgX3KWBajWOIHdw
 K8mD/XiJdcC/bIgnzVGWcCWwxXt2YFVgoAlYhb7M4D/uAD18JovHMq1qXTr5+ojRWls9
 P/UP3tG3s+lDOtvaXfQ6OpZYe4pjT/BW0RMUmmyuxO48vDUty5ZpRliooJng5ZHuMfJd
 P+FN5Qg/tGoHibkr4Ob7FQnFMCWyU0TAjffgOF3hVGU98xJuxwt8yFfPO7Y9Pw5xFC0R
 M2C7TbmJ89q+IZj5qN+l3uj2Wv0DwLlZ1An+l2tzYYarspUlEJ8RVW5UXYtdmTAAgtN4
 elYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709492023; x=1710096823;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=baHI6m1T65RnSlCWzDcEpxWd9aF6YHbHZbyLFWSGcSE=;
 b=D7YAizCB7iIa6lbjEbhGb5Hx8FDRfmXLjLt7F9U69PM8gMS7RY3x6P12teBLvO8qyw
 j/xaB54I075XGS6gw1OpmBRd3bifhesybVztNLefXWElPFSmF3ht2GqVWeyMeQaPuhpr
 zN1EU4QYwVs8X27E5TKLm6BMQE+sBgQ8l459SfL0sBDu0EGwJ5i5fFyVv5Pr+gN0U/rc
 fxMkX4NCyUJKR6QJP3bE+Myhf4Gm7dAXUwJtUULcPU4aQ0dOOkiNU0yKh9Qi7exvg09U
 +CjBfm6UZQqkqCblFXJKoxM62vPFQEku0zGlPt/PJU6DfcaKb4KtzdDkpC47VGdeiHfb
 xaqg==
X-Gm-Message-State: AOJu0YwLg9OM5GSPbtp0htbbpJvmg4gSU6pAL2kOPOUyWx/UKs4ArBxM
 YnrzSV+seyPXARqBmVAdALQk7j4MFg4MFmyIq6PD6h9ebwdOmZ2LcvTztZnc
X-Google-Smtp-Source: AGHT+IFturk5GX+lhlPN3YepGRWihgPxtRNCAM68IeaNQR1j+vinjP3fwQpALeoFXlwM7gmOw2KNjw==
X-Received: by 2002:a05:600c:4fc2:b0:412:dda9:1038 with SMTP id
 o2-20020a05600c4fc200b00412dda91038mr1433440wmq.4.1709492023212; 
 Sun, 03 Mar 2024 10:53:43 -0800 (PST)
Received: from archlinux.. (dynamic-092-224-118-014.92.224.pool.telefonica.de.
 [92.224.118.14]) by smtp.gmail.com with ESMTPSA id
 o17-20020a05600c4fd100b00412d68dbf75sm5259460wmq.35.2024.03.03.10.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 10:53:42 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 0/4] Simplify initialization of PC machines
Date: Sun,  3 Mar 2024 19:53:28 +0100
Message-ID: <20240303185332.1408-1-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The series aims to simplify the initialization process of all PC-based mach=
ines=0D
by streamlining redundant code.=0D
=0D
Since I haven't seen patches on the list so far for folding CMOS data=0D
generation into pc.c, which frees all PC machines from performing this duty=
=0D
explicitly, I've appended this cleanup as the last two patches.=0D
=0D
Testing done:=0D
* `make check` -> all tests pass=0D
* `make check-avocado`=0D
* I'm sending this series from within a VM containing these changes.=0D
=0D
v3:=0D
* Rebase onto master=0D
* Fix boot-order-test=0D
* Remove the "rtc_state" link again which got accidently reintroduced=0D
* Add patch avoiding one use of the current_machine global=0D
=0D
v2:=0D
* Rebase onto master, leaving only patches 1, 3, and 5=0D
* Patch 2: Rename "bus" attribute to "pcibus" (Phil)=0D
* Patch 4: Spotted while rebasing=0D
* Patch 6: New patch possible after [1]=0D
=0D
Best regards,=0D
Bernhard=0D
=0D
[1]=0D
https://patchew.org/QEMU/20240221211626.48190-1-philmd@linaro.org/202402212=
11626=0D
.48190-10-philmd@linaro.org/=0D
=0D
Bernhard Beschow (4):=0D
  hw/i386/pc: Remove "rtc_state" link again=0D
  hw/i386/pc: Avoid one use of the current_machine global=0D
  hw/i386/pc: Set "normal" boot device order in pc_basic_device_init()=0D
  hw/i386/pc: Inline pc_cmos_init() into pc_cmos_init_late() and remove=0D
    it=0D
=0D
 include/hw/i386/pc.h |  2 --=0D
 hw/i386/pc.c         | 29 ++++++-----------------------=0D
 hw/i386/pc_piix.c    |  2 --=0D
 hw/i386/pc_q35.c     |  2 --=0D
 4 files changed, 6 insertions(+), 29 deletions(-)=0D
=0D
-- =0D
2.44.0=0D
=0D


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C194ECCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnHU-0000MK-FS; Mon, 20 Oct 2025 06:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnHR-0000Li-VC
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:38:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnHP-0000Cm-TA
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:38:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso4346032f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956697; x=1761561497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SXVYYZzATC/E68BfF5OyOxwIvYVntwCirLZoygFZ/oU=;
 b=TfHPIBNau9dgrFYkSjIEzAkygTt23zjh4KnAeAsMWvg63wNhl4330bKIOiGWwaqsFS
 8Dx58DkfL2A8CGHWdsled+99+0hEH+c29KKcUq7shrL2tVFPHQKfpY/iGSaUtcqcit99
 wKGcnWGk0XmAkg8zH24zcQuoAxdHYYJL+gelLBY5eY1vd+bHBQQ/939sNkGc6UO/6++A
 THVlRsGBZ4mHiRGzzkq3K4pB7C4460Moi2HFpZQIkypbFZAZNLcHyUmccicCdOtBbQ8C
 aF/Jc1hK6Epg+eekryVvWwhwBihKvK1v/yu4QvLCUig72ciX/fuPRPwa9iFarbxIQXOV
 s/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956697; x=1761561497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SXVYYZzATC/E68BfF5OyOxwIvYVntwCirLZoygFZ/oU=;
 b=iidzRfetxtgV2+7uC3Vde+TwLHL3TbdYlfW8b4GJGcfdQT+fpoIIYdcmRxK61hOnJS
 i/bYKZzIq/fUQ4NFl8apqmCrJsxF8aa/kNJeN1l36D+nTri17KdffFMYuJg40l3FMVFb
 exEoX3e94lZo+uTpAuvh5kPpRM6B5ok/qlpo0hKvrT+FU6Qgztw9VAxkMGNpso7GfvuB
 r4ZnqQtTNSIYPF5fRt58e1SsehX0WlDo25IV+KgWuvMQpzD3vNwSKqvCKvw0qZoNnVR4
 aAowYdaG/1dtlKEmZ7noHCOPAkzVy8nbcc9vXETR66VRY7/L5zj/yAPb7BkuZJzFkkst
 TdwQ==
X-Gm-Message-State: AOJu0YwMPApFmueo03tDo1EjX170f0jy/tU4yxqlsf968NfgFpvQE6Ew
 P/Dax6mRFTkRwiCsGKztK6RbV4IkT+0iUq42fplBOKyMOclG+O9PeDVB6B4+rr1QhtNeoyUdXOU
 a/QZhEP4=
X-Gm-Gg: ASbGncsdmlsGtUM/qwPdi0I5nas2H2DH2BrgwUTTODEGtcXYI9g3zaMcnMGYPktPB6B
 Xu7Fx599wbaovVLV8Gkq/ORQHzc2RNLRcJHeJbWpwzQROwpdcpm8Uq+SgbQG/bZM4gqCwoJc57O
 Xc5YayQxgbDouCrx3wbihssX5z/2SCJXnOz2gX3IZVzDH1jNWdiFNzgO/fBSfDSLUPedmyaqAKa
 M+aSF+WlZ+T514MxGhGUC2dsacoQGX+TEpGjRtUrAql5zwDjd6XpOkeQ3vSWsrl5JzpIH+ZnS4Q
 +GLUsgZX4MxHdv7Uhrc5lSDntJ+H/PSR3Mlr1YhyO4QPBbUKmtLmq0Ze7fOpND8LjZLjuNShDe9
 Sw6vljrRZX72CZK1VsE7H6afp2B7dqAPx7ImfzRp/apoZ3uIcTKbEYzQr9tyMtvZpzVVmQWVZNi
 QpxHtMVkk51HzynS1vPygbxGLGtV4KckniUW16x/6v6CfXoGKWsg==
X-Google-Smtp-Source: AGHT+IEsi0dFkicIb9qfrLx6BzuXKcU/q9Gch4z8m56d2LnefsNIPkEC8bohEE/RQuoCpdMJImcuaQ==
X-Received: by 2002:a05:6000:186d:b0:3ed:e1d8:bd72 with SMTP id
 ffacd0b85a97d-42704d8d000mr8191167f8f.17.1760956697633; 
 Mon, 20 Oct 2025 03:38:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b985esm15176777f8f.34.2025.10.20.03.38.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 03:38:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/18] hw/ppc/spapr: Remove deprecated pseries-3.0 ->
 pseries-4.2 machines
Date: Mon, 20 Oct 2025 12:37:56 +0200
Message-ID: <20251020103815.78415-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Remove the deprecated pseries-3.0 up to pseries-4.2 machines,
which are older than 6 years. Remove resulting dead code.

Philippe Mathieu-Daudé (18):
  hw/ppc/spapr: Remove deprecated pseries-3.0 machine
  hw/ppc/spapr: Remove SpaprMachineClass::spapr_irq_xics_legacy field
  hw/ppc/spapr: Remove SpaprMachineClass::legacy_irq_allocation field
  hw/ppc/spapr: Remove SpaprMachineClass::nr_xirqs field
  hw/ppc/spapr: Remove deprecated pseries-3.1 machine
  hw/ppc/spapr: Remove SpaprMachineClass::broken_host_serial_model field
  target/ppc/kvm: Remove kvmppc_get_host_serial() as unused
  target/ppc/kvm: Remove kvmppc_get_host_model() as unused
  hw/ppc/spapr: Remove SpaprMachineClass::dr_phb_enabled field
  hw/ppc/spapr: Remove SpaprMachineClass::update_dt_enabled field
  hw/ppc/spapr: Remove deprecated pseries-4.0 machine
  hw/ppc/spapr: Remove SpaprMachineClass::pre_4_1_migration field
  hw/ppc/spapr: Remove SpaprMachineClass::phb_placement callback
  hw/ppc/spapr: Remove deprecated pseries-4.1 machine
  hw/ppc/spapr: Remove SpaprMachineClass::smp_threads_vsmt field
  hw/ppc/spapr: Remove SpaprMachineClass::linux_pci_probe field
  hw/ppc/spapr: Remove deprecated pseries-4.2 machine
  hw/ppc/spapr: Remove SpaprMachineClass::rma_limit field

 include/hw/ppc/spapr.h     |  16 --
 include/hw/ppc/spapr_irq.h |   1 -
 target/ppc/kvm_ppc.h       |  12 --
 hw/ppc/spapr.c             | 298 ++++++++-----------------------------
 hw/ppc/spapr_caps.c        |   6 -
 hw/ppc/spapr_events.c      |  20 +--
 hw/ppc/spapr_hcall.c       |   5 -
 hw/ppc/spapr_irq.c         |  36 +----
 hw/ppc/spapr_pci.c         |  32 +---
 hw/ppc/spapr_vio.c         |   9 --
 target/ppc/kvm.c           |  11 --
 11 files changed, 75 insertions(+), 371 deletions(-)

-- 
2.51.0



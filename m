Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498F9D44D5E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8gB2-0001f5-Ec; Wed, 06 Nov 2024 08:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8gB0-0001dr-9o
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:34:26 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8gAx-0001ZX-Os
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:34:26 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7203c431f93so5672139b3a.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 05:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730900062; x=1731504862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6bdbdz8vU0Bbihl18UjLAjwVvI21BGXXW+x8R30xk2M=;
 b=eDBbFTdxnflfsC6Yt4E3bXlm9gaAxsfQINXdRImj7x8472GCPwcqOpWHx3MpMc6ARk
 SfeasvRYTw83ZFCHOZw+jGcSCINPNDDVtkj3Sfoz/2ieRr22HtLWUmMEdB3+BEFQ5hPt
 8Eyes+ep/X2o+Dsq769ipnpqYuIhnd/vYbcaBmvg+z9XyEV4R9KhC3Ik66HiHS9Sn7+P
 i9sDEJ0lZlUaG/itCHqQ8c4h3tPqaQIyvqEHlNrPisOmLc/qfr3M6D9uVFGsSTNfMYYD
 Whpo1oW6221KWtOGP+SWIfsspn+OqYL3wpPS8sIwU31ihpxMlLTIgh+Ul+06x7VNrbOf
 21Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730900062; x=1731504862;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6bdbdz8vU0Bbihl18UjLAjwVvI21BGXXW+x8R30xk2M=;
 b=l/vDmeNUtnD4S2xud9Z/Pxa84P0bUkjCK9Y/OBLixoxSUIjjfTyvXVtbTLh7YpTR2s
 jqd3pa+xye2q9+NWwQOvGb4gujqMxs8hECjcUWy6GhqKfYQowr4GDoquHvFBbBulYw6I
 ZBWl7aZyWCG9HNpiMK120Hsg2w5z5PIvbI7fSxPPJvJMwx/KBkSZNLwcBLXdwjVytLOI
 ENIr8pi8pJCjWkZ6TbnX4eXK3hUtVCkeyWe7YN8aMSmMSQllE+kg8jiHamr+zCHzgmTF
 w3//NmgCaoFQv8AlrE0QoDY/m5k+7cl0L0SHR9Zo/0Kqyzrk+P0wcqP3WbZVNCJPvpvH
 Nvxg==
X-Gm-Message-State: AOJu0YxQMhVzkB89v2w4wWMItqOtehJ78JxhNtdHg5QMKEz5oyLvW9mT
 XVlXj26biMQC4P/rX7XdEf9oU5pRRyEDH7C2WWnnRbIUEhwRrytqZG2wZoZXSv1jrOPfI97nvw/
 m
X-Google-Smtp-Source: AGHT+IFFgz97DkAlOq5csTvhDrpBAGsm2N8BS5PnUS3m9dNi3TvNz/r1V4Za1oYBXe7wlAZrg0wmKw==
X-Received: by 2002:a05:6a00:cc3:b0:71e:744a:3fbc with SMTP id
 d2e1a72fcca58-720b9d9490fmr31457555b3a.21.1730900061698; 
 Wed, 06 Nov 2024 05:34:21 -0800 (PST)
Received: from grind.. ([189.79.22.174]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2eb64esm11749765b3a.168.2024.11.06.05.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:34:21 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 0/7] hw/riscv: riscv-iommu-sys device
Date: Wed,  6 Nov 2024 10:34:00 -0300
Message-ID: <20241106133407.604587-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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

Now that we have merged the base IOMMU support we can re-introduce
the riscv-iommu-sys platform device that was taken away from the initial
posting.

Aside from adding support for the device in the 'virt' machine we're
also adding MSI support for it, something that we weren't doing before.
The Linux driver is then free to choose either MSI or WSI to use the
device.

Patches based on master.

Daniel Henrique Barboza (5):
  hw/riscv/riscv-iommu.c: add riscv_iommu_instance_init()
  hw/riscv/riscv-iommu: parametrize CAP.IGS
  hw/riscv/virt.c, riscv-iommu-sys.c: add MSIx support
  hw/riscv/riscv-iommu: implement reset protocol
  docs/specs: add riscv-iommu-sys information

Sunil V L (1):
  hw/riscv/virt: Add IOMMU as platform device if the option is set

Tomasz Jeznach (1):
  hw/riscv: add riscv-iommu-sys platform device

 docs/specs/riscv-iommu.rst  |  30 ++++-
 docs/system/riscv/virt.rst  |  10 ++
 hw/riscv/meson.build        |   2 +-
 hw/riscv/riscv-iommu-bits.h |   6 +
 hw/riscv/riscv-iommu-pci.c  |  21 +++
 hw/riscv/riscv-iommu-sys.c  | 256 ++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.c      | 114 +++++++++++-----
 hw/riscv/riscv-iommu.h      |   5 +
 hw/riscv/trace-events       |   4 +
 hw/riscv/virt.c             | 108 ++++++++++++++-
 include/hw/riscv/iommu.h    |  10 +-
 include/hw/riscv/virt.h     |   6 +-
 12 files changed, 530 insertions(+), 42 deletions(-)
 create mode 100644 hw/riscv/riscv-iommu-sys.c

-- 
2.45.2



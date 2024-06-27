Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AD9C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpKK-0000wP-3o; Thu, 27 Jun 2024 09:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKF-0000u0-Vg
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:13 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKD-0006K5-Th
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:11 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70698bcd19eso2357529b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495487; x=1720100287;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R7xdJXPQ/0h5i2oefmhppGMlFOw41XX+zUeXH5357TE=;
 b=RLU4ZjHTJ/lDAqzkVnqCB7ldV98yxbN5XPfBoCnJoyv+v2H3E4AP65QT2RCrPZdXVo
 DTw+Zf6XYAFJ0bCHCPWi1BSFhlLEqpnszg50lyHY7rNrRkY8qtIbe/ZwJw4/xqMFMvr/
 P66pdTPMb3Byr+khfw7wq9bsq4Puo3GkW/GET/B+osr5AEBZuSbdebY76dP2bgtqrVSz
 G3jHvwNtto7bMK67tYK3VbzkrfWXcfdL/YcIJcpfyFR1+kMwrsFDl5MHNo0nceraopTy
 JtInjf1YmCFjUfPcy8p87tDOEi6SROGRcQfA/6DeJxdsOnO/yGt1a0VfRIRrIPBet8iQ
 szGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495487; x=1720100287;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R7xdJXPQ/0h5i2oefmhppGMlFOw41XX+zUeXH5357TE=;
 b=txzLqU2dPtQi4speqLGqvHYS/hvD+ERXruzR5nsgjlcmb6vsB6NHNB5weYQeKDBg0s
 P+wX7NaEA5xwKf9ENFm9Vl/OD5/Lhpn6/f47/J/TCEvXrcq+dexi0X3t2zV5dpU18TzT
 tphBwnD25hwAw3Exj3ojNcFZWY7E05NIn+epAUlzoexj7Eu85boabWtF5HC0fSy00siK
 fZIOKfMs1q43zs1sdQ94ObJSsbP9vOxs5oR6ZlDm3cgL2880cisbvj2Wyx+pI7hto+Q3
 TkJP73FLlSNsIYz5XEMHLT8nsgPJMYD1bs+3t1iuH1g95fYDblByeQ2zo84LpgJ+GqlB
 8GzA==
X-Gm-Message-State: AOJu0Yw7gvpTpqsHkjpXRz3ylr3dlJmxAnamHsI9OREfMVEPYM1n8cTh
 BZd1FAyw3ktJc/BXKSiQKQ6iUs2zmxLNXviiZRODUS4q5GmVX3Q1l1bZPrxHBoE=
X-Google-Smtp-Source: AGHT+IGwTrPdvWef3J4iAXhB+zx8QCinKcVnw3a3AwZKpx32cS5pjuRoAHRckaAb07ZY39+jtK2d/A==
X-Received: by 2002:a05:6a20:4e18:b0:1bd:2520:c595 with SMTP id
 adf61e73a8af0-1bd2520cc54mr6173708637.31.1719495487456; 
 Thu, 27 Jun 2024 06:38:07 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-706b491bf0fsm1337964b3a.76.2024.06.27.06.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:38:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 00/15] Fix check-qtest-ppc64 sanitizer errors
Date: Thu, 27 Jun 2024 22:37:43 +0900
Message-Id: <20240627-san-v2-0-750bb0946dbd@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACdrfWYC/zWMQQ7CIBBFr9LMWgxMsdquvIfpglCwsxAMY0ibh
 ruLJC7fz3/vAHaJHMPUHZBcJqYYKuCpA7ua8HSClsqAErUc8CLYBCHHq/HGa68sQn2+k/O0tcp
 jrrwSf2LaWzSr3/r3h+ZnJaTwvbUae4nqNt4Xswfazja+YC6lfAGYbqKRlwAAAA==
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Based-on: <3ad18bc590ef28e1526e8053568086b453e7ffde.1718211878.git.quic_mathbern@quicinc.com>
("[PATCH] cpu: fix memleak of 'halt_cond' and 'thread'")

I saw various sanitizer errors when running check-qtest-ppc64. While
I could just turn off sanitizers, I decided to tackle them this time.

Unfortunately, GLib does not free test data in some cases so some
sanitizer errors remain. All sanitizer errors will be gone with this
patch series combined with the following change for GLib:
https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4120

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Rebased to "[PATCH] cpu: fix memleak of 'halt_cond' and 'thread'".
  (Philippe Mathieu-Daudé)
- Converted IRQs into GPIO lines and removed one qemu_irq usage.
  (Peter Maydell)
- s/suppresses/fixes/ (Michael S. Tsirkin)
- Corrected title of patch "hw/virtio: Free vqs after vhost_dev_cleanup()"
  (was "hw/virtio: Free vqs before vhost_dev_cleanup()")
- Link to v1: https://lore.kernel.org/r/20240626-san-v1-0-f3cc42302189@daynix.com

---
Akihiko Odaki (15):
      cpu: Free cpu_ases
      hw/ide: Convert macio ide_irq into GPIO line
      hw/ide: Remove internal DMA qemu_irq
      hw/isa/vt82c686: Define a GPIO line between vt82c686 and i8259
      spapr: Free stdout path
      ppc/vof: Fix unaligned FDT property access
      hw/virtio: Free vqs after vhost_dev_cleanup()
      migration: Free removed SaveStateEntry
      memory: Do not create circular reference with subregion
      tests/qtest: Use qtest_add_data_func_full()
      tests/qtest: Free unused QMP response
      tests/qtest: Free old machine variable name
      tests/qtest: Delete previous boot file
      tests/qtest: Free paths
      tests/qtest: Free GThread

 include/hw/ppc/mac_dbdma.h           |  5 +++--
 hw/core/cpu-common.c                 |  1 +
 hw/ide/macio.c                       | 18 +++++++++++++-----
 hw/isa/vt82c686.c                    |  7 ++++---
 hw/misc/macio/mac_dbdma.c            | 10 +++++-----
 hw/ppc/spapr_vof.c                   |  2 +-
 hw/ppc/vof.c                         |  2 +-
 hw/virtio/vhost-user-base.c          |  2 ++
 migration/savevm.c                   |  2 ++
 system/memory.c                      | 11 +++++++++--
 tests/qtest/device-introspect-test.c |  7 +++----
 tests/qtest/libqtest.c               |  3 +++
 tests/qtest/migration-test.c         | 18 +++++++++++-------
 tests/qtest/qos-test.c               | 16 ++++++++++++----
 tests/qtest/vhost-user-test.c        |  6 +++---
 15 files changed, 73 insertions(+), 37 deletions(-)
---
base-commit: af799a2337c3e39994411f90631905d809a41da4
change-id: 20240625-san-097afaf4f1c2

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>



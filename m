Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5174BC27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYcp-0006GZ-K7; Mon, 10 Jun 2024 02:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYco-0006Eq-4z
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:35:26 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYcl-0007Hw-D4
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:35:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-421798185f0so14895285e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718001321; x=1718606121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nfSilvdfrEKWoWt9H1THfJIQcnGzklXjLBwkyIQq6ws=;
 b=KczG6KScGO0C+EMA/Z0XZmMo+zorsO/Mh33Y/Q4dPg0Z4ypKSnMkNT0+Hk+FjnhC9s
 BZhnYrGAqn5hylRF1mvnXfMRs90eWSKB+SmstBivOu+6XS2YS0Q1ffL+tyK/D8umyaTK
 Qp4YmnPXUgtRZ4i3/BPjc5/hX7iU+1eCCr2Bjn6n3MOBejfX0AlCJ07VQZEzxxjCo70E
 CU7rcaQY6Gbbf83lBIZIiQXY/TYKfArwvjY/I6is0NmDh+rAP+loR34eoYYyhIdGZJeO
 BqL8nUOZmvNZ9P03DfnAqkhuTWMefMfN0WYWUj30NWiQPYZcpjgaYsrLm0MV0lvpeGxd
 es3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718001321; x=1718606121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nfSilvdfrEKWoWt9H1THfJIQcnGzklXjLBwkyIQq6ws=;
 b=RP9HSMvPml0oEE23m+or7Y4+pmtK2990HI2yBVAtIHxjMGWa3a+KFMa8C0e0uZNZAs
 mQbUE1jEJIFIc62m6tsVJjHt0p1Q4Ef6ryCuss6/bHlluWKit8Vj4jUCdtepI5ie+RTo
 rteAPECWhKEmv4pKu6QX4QO+zkFzd76StszU2rLe5svD/JzObfcqueIeulazztvib0gB
 wtdCbcqo2602GfC0o3zkETVNfcD2RJ2AX3CP2BIFmTjT5yszJDEibP8LYXUQVLM18rTN
 DUxqod3A5+m2EF5NvWCJ9VRVSe0r39no5/q0LMnpSpQvKlSprgHCfBWQrtxOfw9HRxeI
 8iCA==
X-Gm-Message-State: AOJu0YxZEWoKBhbbVbknAOpnmFa2XpzZw7rkAO/QC9EddOOJXkZc/nY7
 yeFuDeaOIa1lcpj3IlXYm1XqJUaJejM9L5Iw47Ai2WauaT1ZZwsfpuS7lkeKzN6H+tj4QfKx9P5
 T
X-Google-Smtp-Source: AGHT+IFjvF3PijKU4jrk+8sWSpcoqq7ogYu5FKxZMA70n4WSOOUP8azQM2w+hGtvt97enW54c+AtEg==
X-Received: by 2002:a5d:6982:0:b0:35f:1dcb:724c with SMTP id
 ffacd0b85a97d-35f1dcb73c8mr2081415f8f.68.1718001321427; 
 Sun, 09 Jun 2024 23:35:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5fc12e0sm10178493f8f.100.2024.06.09.23.35.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:35:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Don Porter <porter@cs.unc.edu>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 0/2] hw/intc: Introduce x-query-interrupt-controllers QMP
 command
Date: Mon, 10 Jun 2024 08:35:15 +0200
Message-ID: <20240610063518.50680-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Continuing previous work from Daniel:
https://lore.kernel.org/qemu-devel/20211028155457.967291-1-berrange@redhat.com/

- Prefer HumanReadableText over Monitor in hw/intc/
- Introduce x-query-interrupt-controllers QMP command

See commits f2de406f29 ("docs/devel: document expectations for
QAPI data modelling for QMP") and 3d312f417d ("docs/devel: document
expectations for HMP commands in the future") for rationale.

Based-on: <20240610062105.49848-1-philmd@linaro.org>

Philippe Mathieu-Daudé (2):
  hw/intc: Avoid using Monitor in INTERRUPT_STATS_PROVIDER::print_info()
  hw/intc: Introduce x-query-interrupt-controllers QMP command

 qapi/machine.json          | 17 ++++++++++++
 include/hw/intc/intc.h     |  2 +-
 hw/core/machine-qmp-cmds.c | 29 +++++++++++++++++++
 hw/intc/goldfish_pic.c     |  8 +++---
 hw/intc/i8259_common.c     | 14 +++++-----
 hw/intc/ioapic_common.c    | 57 +++++++++++++++++++-------------------
 hw/intc/m68k_irqc.c        |  5 ++--
 hw/intc/slavio_intctl.c    | 11 ++++----
 hw/ppc/pnv.c               | 10 +------
 hw/ppc/spapr.c             | 10 +------
 monitor/hmp-cmds.c         | 27 ------------------
 hmp-commands-info.hx       |  2 +-
 12 files changed, 97 insertions(+), 95 deletions(-)

-- 
2.41.0



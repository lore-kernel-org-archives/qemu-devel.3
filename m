Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B233C38150
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 09:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ1jY-0008LL-KW; Sat, 06 Jul 2024 05:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQ1jX-0008L4-Gh
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 05:29:31 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQ1jV-0006lI-MJ
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 05:29:31 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d55ed47cc6so1373316b6e.2
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 02:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720258168; x=1720862968;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8BtKp85eCnJynLkwYiKVD/gTPyFYNMB7/OmMo7haiVM=;
 b=Bhn2E1ftsosIH4ySMoy7cXNesi8qDadwkK5g9zr7yST6mld1MO9O6nlCGn/nBmSEQg
 Cvcz+LT1d1BfIDGfNpDvfji1E7TPMjCsrlqeAZ5z3VeP7zkUHc5xWaPf5/dOj7kwusF8
 xejUMvG7VSkqJLPx54OOwkY4fWp9rYnalj9U3I8TGt4Fw8soDPo56dLJQakRI1LovI6j
 UueIHJj0zTVPUFs18XNAYslvvtr2YiDxiu87a90BvqsTrQxUlBgzTLTG1rw9mgn8nrHb
 HoPJQzvj5Pmyo5GaAaqdqaVX+gs01NDjkMuxw73K5MPD7KrBblZpIMOroCI4KtjBLGk7
 tQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720258168; x=1720862968;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8BtKp85eCnJynLkwYiKVD/gTPyFYNMB7/OmMo7haiVM=;
 b=J9eyQfQ+M9nDJ+Tuq9hD3ttxqM/ClZLXMofCRnluvS0DWKBnkQadMFGewDMOkQdVDX
 82epWZ2feqbPzcMzbbKQh4fBFg81TqiN15b0lN4y8RsQO6Uk+Uz/nQxt65f7RZdXCt8H
 0FsKi8m5IAKG6/ppZlsztFRY4udrXXBwtAJ3gR7RbVxsl23ATOlCWU6yL8e44pZrzTYv
 9BhceRNlTfsYygdSy1ZEci+di0+r0if9r7fPRPu+1t/Mwau3vEn4AsKrnQCh5Xfy3qxR
 lmwb1fzZswucZN29vO3pQyqwrsS5eaRN2UWQnXqBzQEhYadKpAFykSfDh6yONLbULPrd
 uqFg==
X-Gm-Message-State: AOJu0YwN37pvPB27v+1Yvv0MZwSW9ail7qQ3GlA82EMMk9hDzyA2UIkf
 6inSfdX/U6LdEd/PM32I/gLKuY26Pvhtb8PreQbAHFoagNfI9GGLkL94Pr3gvzk=
X-Google-Smtp-Source: AGHT+IEgznHFAtgs5uy9wgyKZPJEgsz7y54Uw6QRnN6lMHhyUGOavXOHiiwSXDm35XS1moMwWuuGww==
X-Received: by 2002:a05:6808:16a3:b0:3d9:28b7:a4a5 with SMTP id
 5614622812f47-3d928b7a950mr143730b6e.36.1720258168318; 
 Sat, 06 Jul 2024 02:29:28 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-708043b70c8sm15409525b3a.151.2024.07.06.02.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jul 2024 02:29:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/4] hw/pci: Convert rom_bar into OnOffAuto
Date: Sat, 06 Jul 2024 18:29:20 +0900
Message-Id: <20240706-rombar-v1-0-802daef2aec1@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHAOiWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwMT3aL83KTEIl3DRJOkRCMLS4MUs2QloOKCotS0zAqwQdGxtbUABkn
 XGFgAAAA=
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::235;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x235.google.com
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

rom_bar is tristate but was defined as uint32_t so convert it into
OnOffAuto to clarify that. For compatibility, a uint32 value set via
QOM will be converted into OnOffAuto.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (4):
      qapi: Add visit_type_str_preserving()
      qapi: Do not consume a value when visit_type_enum() fails
      hw/pci: Convert rom_bar into OnOffAuto
      hw/qdev: Remove opts member

 docs/igd-assign.txt               |  2 +-
 include/hw/pci/pci_device.h       |  2 +-
 include/hw/qdev-core.h            |  4 ---
 include/qapi/visitor-impl.h       |  3 ++-
 include/qapi/visitor.h            | 25 +++++++++++++----
 hw/core/qdev.c                    |  1 -
 hw/pci/pci.c                      | 57 +++++++++++++++++++++++++++++++++++++--
 hw/vfio/pci-quirks.c              |  2 +-
 hw/vfio/pci.c                     | 11 ++++----
 hw/xen/xen_pt_load_rom.c          |  4 +--
 qapi/opts-visitor.c               | 12 ++++-----
 qapi/qapi-clone-visitor.c         |  2 +-
 qapi/qapi-dealloc-visitor.c       |  4 +--
 qapi/qapi-forward-visitor.c       |  4 ++-
 qapi/qapi-visit-core.c            | 21 ++++++++++++---
 qapi/qobject-input-visitor.c      | 23 ++++++++--------
 qapi/qobject-output-visitor.c     |  2 +-
 qapi/string-input-visitor.c       |  2 +-
 qapi/string-output-visitor.c      |  2 +-
 system/qdev-monitor.c             | 12 +++++----
 tests/qtest/virtio-net-failover.c | 32 +++++++++++-----------
 21 files changed, 154 insertions(+), 73 deletions(-)
---
base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
change-id: 20240704-rombar-1a4ba2890d6c

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>



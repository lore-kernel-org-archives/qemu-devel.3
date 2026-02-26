Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0DDFD45F9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 03:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvRrm-0003aI-Dz; Wed, 25 Feb 2026 22:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vvRrk-0003a4-Uw
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 22:16:41 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vvRrj-0004fn-FG
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 22:16:40 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-896f82e5961so6391056d6.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 19:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772075798; x=1772680598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lJSMQZ2oT82HUBkn5K3fhR+S8/lTnedYUtXRN1+ash8=;
 b=iDe9cj89c205KfQmNp7HlErMEgOYNgrBXBaiHsx0HbNpV1fyzEClGYXtuziJZHSVmS
 c9t07wXKpZvLKB9SkAmBAtvNToEntNGdswROyoqbX3Npr/XhvuYXNtrwgGnfDxn5USnF
 v9uxZbutAE+Apushex952hGMd784WmYd98/b8t2CxJyXmAVzeTB411B+w/JLVJ0PQlld
 N9a5C7gFx5NjtkT/fOkf7Onh37ENg7K/KV0Q7UMMsdnk63LdItFIsyKeiN1GtaaBf8ob
 7jdu2ZoVdCoUoSnz1xi2lCYTOPm4CGygGFOPr7cIAxRaCrn3BNEndHk0i0LyjS2liCFa
 8ZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772075798; x=1772680598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJSMQZ2oT82HUBkn5K3fhR+S8/lTnedYUtXRN1+ash8=;
 b=wIRK+A2AKX2kYp1IfLlVQNiIB4SCJvW0gzVLJxMIdS2ExJ9YAiiX0gCzq5JL6vphS8
 ITYXkLCVm41/fUhl48WvRgAi1YTInnP1Rv9gcwUdmnFArWd+MZMCJIVtdBOHeuyZ6HL9
 koR3eVHk1SteU8KbKyw7TiW9Tw2M5AU5VLGUm5OL1no+oAJdKranjPXuRgCWtutUoay5
 a7CmZhCTeMWtwushXvD6dBx1p16cH7lsVCTDSPLuJ5Mht3zpjF09OHAbn2zCSXSVcO1N
 gge1oC+gtaP8w60QSYiFznrJZQv9NHCUPo2gh4pnGnsoDWCio5PZbMKsOAYOPZ2JRCFc
 FeNw==
X-Gm-Message-State: AOJu0YwxygGe4rwMMz8P6MJgtGTXFEUfC/LgsO0HoJJRrduhIR0oEkWR
 n7vLxa0W9uyHMwWK6ODf9cWcOP9SGVPDSparWe62YFPrzjqQ1Jpeo/rarVNpJg==
X-Gm-Gg: ATEYQzxnxbSZWvboVJh/F5vtHO/jjVG/AzMWqXxUJv/30F3/5CgBrnRUiE2rSAHfc/b
 23psZ2GH99Ie45solLg1muMXGSt0vUkSPNif0hPgMdRsKfi/1ezZBmYg4+otZhnOCNtLr+CNiQ2
 jESJzz0WAYUiFc7jqqUj6zlEB9bsDv7co0lM1FwADasEZkSn7kapa4C0DBi9i5KdEw9pMaC8IQf
 OPhIORhHCfR7ho9EojQX/J2rH6MoG0jFXv+raVJfNowNtD7n4RjiE37IB8ujhgZtJQHgo9jKcOw
 R8Eczfw3COnphngmUtdjabGtKMelvAzkdIqRPSbtZTIf2hie38LepsGpNl337xpoR+Kg5YpfVyj
 BGbcgXm5v5q+oDD4qi/EolmtkWD1CIQMmvx0uOxxa5lGbEQxmKp+mlFt3j8KfhEBXVeXEsT9noY
 84EbfUQbBuoc+lZ+qsjnQepsag387c47aaakVLjJksPU5+NYeQz+0=
X-Received: by 2002:a05:6214:2a8a:b0:895:7864:f69d with SMTP id
 6a1803df08f44-899c1c55728mr46012276d6.40.1772075797733; 
 Wed, 25 Feb 2026 19:16:37 -0800 (PST)
Received: from localhost.localdomain ([207.98.184.46])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899c715af1fsm7376156d6.1.2026.02.25.19.16.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 19:16:37 -0800 (PST)
From: David Hamilton <dahamilt0@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Hamilton <dahamilt0@gmail.com>
Subject: [PATCH v3 0/2] hw/misc/ivshmem-pci: Improve error handling
Date: Wed, 25 Feb 2026 22:16:31 -0500
Message-ID: <20260226031633.12369-1-dahamilt0@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=dahamilt0@gmail.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This series addresses two error handling issues in the ivshmem
PCI device:

1. Handle the return value of kvm_irqchip_add_irqfd_notifier_gsi()
   which was being silently ignored.

2. Check for errors from setup_interrupt() in process_msg_connect()
   before continuing to ioeventfd setup.

Changes from v2:
- Added close(fd) cleanup on setup_interrupt() failure (Markus)

Changes from v1:
- Made setup_interrupt() return bool per QEMU conventions (Markus)
- Simplified errp check using bool return, dropped ERRP_GUARD()
- Dropped vector number from error message

David Hamilton (2):
  hw/misc/ivshmem-pci: Handle error from
    kvm_irqchip_add_irqfd_notifier_gsi()
  hw/misc/ivshmem-pci: Check error after setup_interrupt() in
    process_msg_connect()

 hw/misc/ivshmem-pci.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

-- 
2.50.1 (Apple Git-155)



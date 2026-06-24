Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940D2CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcGZ2-0006zf-5p; Wed, 24 Jun 2026 01:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGYz-0006zB-Uh
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGYy-00060x-1B
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782280454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=y4EObMPmg4WFSnU71/4/A0A2aYeAjdSFp3IZmokTWzc=;
 b=B2KmIR+jM7JUGH1TDJzCVXqU4TrhkWS67Kq3zJ9DTnxoPAFJPaOgorC/ZGMifsOLQ6PoEx
 7AdCMxOiQM9pPfYy5GG7hRq879TcbFnBRtdch7U007J/UY3jP1Mb7CEFVYJPet07czREdV
 JqCNH7463XpbUAoCFBFmp7rTFlChMOE=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-ppXLq-_xNxefgmagJbGv8g-1; Wed, 24 Jun 2026 01:54:12 -0400
X-MC-Unique: ppXLq-_xNxefgmagJbGv8g-1
X-Mimecast-MFC-AGG-ID: ppXLq-_xNxefgmagJbGv8g_1782280452
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c108c19d4so807697eec.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 22:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782280451; x=1782885251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y4EObMPmg4WFSnU71/4/A0A2aYeAjdSFp3IZmokTWzc=;
 b=tnauBSfCk4GRwKOxvSjZ1AbX02gHB4oy5w4r4SYu7Ca6sNc3kkeqWRo7lxe+iKUxq7
 UFBQ3pfdr+mCCv1JVlIn6+r3/FdbEm6lWQhgUx91wLCwi3XmsDMBscmhCvqT5r1ENHhh
 POEaF0VhUYXbuoxgxhhRNMLqMwMndzx1PpSaEA/1kGghTrWYCzauw+1+ml02HBiI89sC
 IIUti21boBlbWnnNv/NQxx1MewN57/yenn9DpaZfigFN4q7W5rNY3UXnX7MkuNCjdVnD
 f0quDPS/ZM6Qz4Rl2eiAyrYQcBb5d6t9ChIcVDXXYpicghFhjkOpMQ/Z0DlkgVPX6B/9
 YdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782280451; x=1782885251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4EObMPmg4WFSnU71/4/A0A2aYeAjdSFp3IZmokTWzc=;
 b=MC87tDT5mbYkXKQ/skNPQVpQAVBu7Qr1BAQlgX86u1oe6EbmKcu4Ke85gQA8pCDu+5
 DymUT1w26pwCyUWhdPw4WlsqXP/upNrvVnmRcYn9mO8kXYuN1O2w+aDnvDHya2h3JR5N
 xjH2/zJahRJUMydbUbXml5ANq4P2pMtlg9dTf+M45XFtvbf0JYxVx09f+A75FA3jxnum
 266lof7VgrWas7i6mfYJe9zrYTgDw8B7Ekfn7N7TwRFWJ0CjU1OaQHzRRvESD2ecrg7M
 VyzQQN5iYRof56engN8L4He25aacM5L5H4JPLPcJ2nTheWaynI30mT89/nAAMupqSoR9
 3PeA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqio6V1+MyTjD2YLnldW5O2oFcRCRRJnFd4weaWTROhMca+4BteNBX80vZ7l8yPaIKwAeXkLmaO2yXA@nongnu.org
X-Gm-Message-State: AOJu0YwI89t2XrN8eTYsD/FP6c+z0M1B1OvMnlkAw8PNVUWPIJk/9aWC
 QpzmfqacmlBmGRpjsiTS3VSDzbEyfb1QGG70BT+yjM2kALnICsK5O3+c2xlZ8ezyJnMihy3zR1j
 HAXK2Z1z2I1oIbDzBQV/TzNFlivByWdznQcYN/BjbsGJCbhxW9O+s9oVM
X-Gm-Gg: AfdE7clXwD8slc8ET+6TyjuMsYN64Foia1LaCLwKlKyHjI+YBckI6NLtideB1ghr9Vl
 PZLFUt30YCHlFv2OKVhztQpx1UYxIaBRqdlq3QSJMCCe7gQEWq/mUPHKCObNVwmTKRTjB1g5G8w
 XkP2WZalEEsgc3Lu7vxUO0LS7Rr5fLHBbtz+lI9glx0S/+FIsmV8XVmriFpDy580OhoHHpdFUFm
 hu9v+sd5chdbcapKjIpvJuoAYHGfVY2pFdPHcJ1dNKegCak1XnPE1cRt53IzPOZLGSwlXOTA3/3
 dEQTKdzrKiv9cs3MbLlbI+fGDcvmN9UWY/45Syfnxj+Hs7BH9Wh81189/+L546oNcpErm3riziM
 +LwctJFz3QS2OmBZYD7+yGddQmA9z6uXp8XrvRtvMV9+v
X-Received: by 2002:a05:7300:72ce:b0:30c:6458:5566 with SMTP id
 5a478bee46e88-30c69389e80mr1993800eec.26.1782280451453; 
 Tue, 23 Jun 2026 22:54:11 -0700 (PDT)
X-Received: by 2002:a05:7300:72ce:b0:30c:6458:5566 with SMTP id
 5a478bee46e88-30c69389e80mr1993787eec.26.1782280450953; 
 Tue, 23 Jun 2026 22:54:10 -0700 (PDT)
Received: from rhel9-box.lan ([110.227.100.91])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d6edsm21075803eec.14.2026.06.23.22.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 22:54:10 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, Alex Graf <graf@amazon.com>,
 Gerd Hoffman <kraxel@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v1 0/8] Introducing guest driven VM launch update mechanism
 (BYOF interface)
Date: Wed, 24 Jun 2026 11:23:22 +0530
Message-ID: <20260624055339.46862-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is the resurrection of the work that was previously discussed here:
https://lists.endsoftwarepatents.org/archive/html/qemu-devel/2025-03/msg05872.html

This relates to the 'bring your own firmware' work that we are driving at Red Hat,
now with IGVM support.

The patchset includes a spec doc that has more details.

This patchset implements the hypervisor interface using fw-cfg. Using this interface, the guest
can pass its own IGVM file to the hypervisor. Upon reset, the hypervisor re-initializes the guest
using the IGVM file the guest provided.  This is useful in order to have deterministic and trustworthy
launch measurements, mostly for the cloud confidential guest deployments.

This patchset has added functional and unit tests that exercize the hypervisor interface. It has been
tested for both confidential guests and non-confidential guests. Gerd has also independently tested
the patchset.

CC: Alex Graf <graf@amazon.com>
CC: Gerd Hoffman <kraxel@redhat.com>
CC: qemu-devel@nongnu.org

Ani Sinha (5):
  hw/misc/vmlaunchupdate: Introduce hypervisor fw-cfg interface support
  docs/spec: Add a specification document for vm-launch-update device
  tests/qtest: Add small igvm files for testing purpose
  Add functional and unit tests for the vm-launch-update device
  Update MAINTAINERS

Gerd Hoffmann (3):
  igvm: store IgvmCfg pointer in QIgvm
  igvm: track memory regions
  igvm: cleanup memory regions

 MAINTAINERS                                   |  12 +
 backends/igvm-cfg.c                           |   1 +
 backends/igvm.c                               |  91 +++--
 docs/specs/index.rst                          |   1 +
 docs/specs/vmlaunchupdate.rst                 | 147 ++++++++
 hw/misc/meson.build                           |   3 +
 hw/misc/trace-events                          |   5 +
 hw/misc/vmlaunchupdate.c                      | 236 +++++++++++++
 include/hw/misc/vmlaunchupdate.h              |  85 +++++
 include/system/igvm-internal.h                |   8 +-
 include/system/igvm.h                         |   3 +
 tests/data/igvm/README                        |  24 ++
 tests/data/igvm/hello.igvm                    | Bin 0 -> 153624 bytes
 tests/data/igvm/qemuinit.igvm                 | Bin 0 -> 256856 bytes
 tests/functional/aarch64/meson.build          |   1 +
 .../aarch64/test_vm_launch_update_aarch.py    |  33 ++
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vm_launch_update.py           |  48 +++
 tests/qtest/launchupdate-test.c               | 321 ++++++++++++++++++
 tests/qtest/meson.build                       |   2 +
 20 files changed, 989 insertions(+), 33 deletions(-)
 create mode 100644 docs/specs/vmlaunchupdate.rst
 create mode 100644 hw/misc/vmlaunchupdate.c
 create mode 100644 include/hw/misc/vmlaunchupdate.h
 create mode 100644 tests/data/igvm/README
 create mode 100644 tests/data/igvm/hello.igvm
 create mode 100644 tests/data/igvm/qemuinit.igvm
 create mode 100755 tests/functional/aarch64/test_vm_launch_update_aarch.py
 create mode 100755 tests/functional/x86_64/test_vm_launch_update.py
 create mode 100644 tests/qtest/launchupdate-test.c

-- 
2.42.0



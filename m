Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E9CE7718E
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 19:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP53N-0002Lg-Nv; Sat, 21 Dec 2024 14:22:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53L-0002LT-TV
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53K-00007z-33
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734808936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wh/XJcDLG4haZ0I99kxZxm6Q4mRwSI+Ko/QTidmvGPs=;
 b=HLCDift8ScoAFoWHGJInyofm0kiHfyBXZCPtuMLJIWVzbDH+UJdMiU7f2e7U9yG3PHScX2
 /fixXwTTt+f1WrESTUR+AAqqfLWorVBXUVe0KykWAo3xxlr0L+JI58I+8jkOPTfKydTArg
 Nt7HRcr6vYSzrEgWKtuHCEu8vvy2SMg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-Sl_ChOrgOD-9AZK-bpPdAw-1; Sat, 21 Dec 2024 14:22:14 -0500
X-MC-Unique: Sl_ChOrgOD-9AZK-bpPdAw-1
X-Mimecast-MFC-AGG-ID: Sl_ChOrgOD-9AZK-bpPdAw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385ed79291eso1985288f8f.0
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 11:22:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734808933; x=1735413733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wh/XJcDLG4haZ0I99kxZxm6Q4mRwSI+Ko/QTidmvGPs=;
 b=lYXHOw9pwPKT7+w1nJHBtMYX9bVk79ksXe8WwhASb4o1hUnQvCZRN3XyeUblfqmKyA
 FhiC2JTmImYj2bOB7AeBwC7Iz8ZGBDAACDlbWz/mLtg5tct5Oxb1jtCLnqiq6NVaYzHY
 KHQBxrAgP6rJJOjLLDsh4mehRXNYMZ73EeRHKdzx4QIiJ2FV4We0bFJnTm3b6JHls7W0
 xJdOEuSNmjRdyqcqRAfp7LNfw6zI+6SRQ3laD27bgF6qbeIEL3v1xGFq9hXsCH+Y74tp
 UnS+8fLG7cYvWgBqbAp3y9aa/7Dz0NnOId9jWqHVtDLU+1243+OoalWSV2UTzbBLsB5c
 dRfw==
X-Gm-Message-State: AOJu0YzMviimI9Po300wY3k7uG+c3I249Fbr85qkys4aPRuQVUuZijZ5
 cMlbHSrDGuJCCKTKsLK8Mf57nuqwc8Nseur++ISygH2HX2ui4mNtlPIWfXzX+GaHlim8u1zCuTM
 gPqBTqP8H+lY8m75y5ToVxCH8YOUTDkuA+Vah8RLBbo5JcW6qJaEHI9A1Kc+Wviuwp/NK+5wK/e
 jDfQVzVWFwx8Idg21pdIpGLa108RO88YeP
X-Gm-Gg: ASbGncsDvS/3c4RmJhduSSE7qUfradFy2N6yBTqqhKKi6ojCBQVYH6nemopTEgXD/BH
 ax3AfN2MdDiQApY5ZMUEnt9dr/sdqntjLdbbvHBgZ5BjXyROEUyyMO20H4Mn/Vx2OMb3BfBJMpv
 HL634SCob7b4P6p1QBTJL944+gYJH5jXOE5FH14asy1GB4CJuuC+zTwuDvkR3SEIhzJpptVZ0Wk
 YKQ1mF/+ALyaqU5aa5Ituk8/W4DgrWfzBarJoiguVtnPekFwSBDki7U/PJ/z/vz+Od8pXQ+5XJG
 SEH4S8H1sXvkOfnFbxEtANuWrqlgSUn785AY+Xg=
X-Received: by 2002:a05:600c:198a:b0:434:fe3c:c662 with SMTP id
 5b1f17b1804b1-43669a22e68mr64678555e9.12.1734808933391; 
 Sat, 21 Dec 2024 11:22:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOi41GylqZyjhRSi0PpqPb9bTOccR25IdBY9hAT1xG/hjuaeT+dgjQ2h9tO1Zm7RBJXFpr2g==
X-Received: by 2002:a05:600c:198a:b0:434:fe3c:c662 with SMTP id
 5b1f17b1804b1-43669a22e68mr64678395e9.12.1734808932964; 
 Sat, 21 Dec 2024 11:22:12 -0800 (PST)
Received: from localhost
 (p200300cbc7137800820d0e9f08ce52bd.dip0.t-ipconnect.de.
 [2003:cb:c713:7800:820d:e9f:8ce:52bd])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43661219a08sm83579355e9.25.2024.12.21.11.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 11:22:11 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL v2 00/15] Host Memory Backends and Memory devices queue
 2024-12-21
Date: Sat, 21 Dec 2024 20:21:54 +0100
Message-ID: <20241221192209.3979595-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

this is the updated pull request from 2024-12-18; gitlab-ci seems to
be happy with it (container,build,avocado tests).

The following changes since commit 9863d46a5a25bfff7d2195ad5e3127ab3bae0a2b:

  Merge tag 'pull-loongarch-20241219' of https://gitlab.com/bibo-mao/qemu into staging (2024-12-19 15:46:43 -0500)

are available in the Git repository at:

  https://github.com/davidhildenbrand/qemu.git tags/mem-2024-12-21

for you to fetch changes up to aa910c20ec5f3b10551da19e441b3e2b54406e25:

  s390x: virtio-mem support (2024-12-21 20:15:06 +0100)

----------------------------------------------------------------
Hi,

"Host Memory Backends" and "Memory devices" queue ("mem"):
- Fixup handling of virtio-mem unplug during system resets, as
  preparation for s390x support (especially kdump in the Linux guest)
- virtio-mem support for s390x

----------------------------------------------------------------
David Hildenbrand (15):
      virtio-mem: unplug memory only during system resets, not device resets
      s390x/s390-virtio-ccw: don't crash on weird RAM sizes
      s390x/s390-virtio-hcall: remove hypercall registration mechanism
      s390x/s390-virtio-hcall: prepare for more diag500 hypercalls
      s390x: rename s390-virtio-hcall* to s390-hypercall*
      s390x/s390-virtio-ccw: move setting the maximum guest size from sclp to machine code
      s390x: introduce s390_get_memory_limit()
      s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT
      s390x/s390-stattrib-kvm: prepare for memory devices and sparse memory layouts
      s390x/s390-skeys: prepare for memory devices
      s390x/s390-virtio-ccw: prepare for memory devices
      s390x/pv: prepare for memory devices
      s390x: remember the maximum page size
      s390x/virtio-ccw: add support for virtio based memory devices
      s390x: virtio-mem support

 MAINTAINERS                        |   5 +
 hw/s390x/Kconfig                   |   1 +
 hw/s390x/meson.build               |  10 +-
 hw/s390x/s390-hypercall.c          |  85 ++++++++++++++
 hw/s390x/s390-hypercall.h          |  25 ++++
 hw/s390x/s390-skeys.c              |   6 +-
 hw/s390x/s390-stattrib-kvm.c       |  67 +++++++----
 hw/s390x/s390-virtio-ccw.c         | 160 +++++++++++++++++---------
 hw/s390x/s390-virtio-hcall.c       |  41 -------
 hw/s390x/s390-virtio-hcall.h       |  25 ----
 hw/s390x/sclp.c                    |  17 +--
 hw/s390x/virtio-ccw-md-stubs.c     |  24 ++++
 hw/s390x/virtio-ccw-md.c           | 153 +++++++++++++++++++++++++
 hw/s390x/virtio-ccw-md.h           |  44 ++++++++
 hw/s390x/virtio-ccw-mem.c          | 226 +++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw-mem.h          |  34 ++++++
 hw/virtio/Kconfig                  |   1 +
 hw/virtio/virtio-mem.c             | 107 ++++++++++++------
 include/hw/s390x/s390-virtio-ccw.h |   9 ++
 include/hw/virtio/virtio-mem.h     |  13 ++-
 target/s390x/cpu-sysemu.c          |  15 ---
 target/s390x/cpu.h                 |   2 -
 target/s390x/kvm/kvm.c             |  21 +---
 target/s390x/kvm/pv.c              |   2 +-
 target/s390x/tcg/misc_helper.c     |  10 +-
 25 files changed, 874 insertions(+), 229 deletions(-)
 create mode 100644 hw/s390x/s390-hypercall.c
 create mode 100644 hw/s390x/s390-hypercall.h
 delete mode 100644 hw/s390x/s390-virtio-hcall.c
 delete mode 100644 hw/s390x/s390-virtio-hcall.h
 create mode 100644 hw/s390x/virtio-ccw-md-stubs.c
 create mode 100644 hw/s390x/virtio-ccw-md.c
 create mode 100644 hw/s390x/virtio-ccw-md.h
 create mode 100644 hw/s390x/virtio-ccw-mem.c
 create mode 100644 hw/s390x/virtio-ccw-mem.h

-- 
2.47.1



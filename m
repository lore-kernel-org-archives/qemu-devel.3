Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E97CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3dL-0006bn-T6; Fri, 26 Jun 2026 06:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dH-0006ZD-DS
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dF-00056F-Dt
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wSl12UVXDks9Qe2n6ujvTkHNGtVjvaUxO6b2abd2oQs=;
 b=OxOaBKowqP/fjNipahDFYrkxkLmNaCiCyLxCQl2iftPBBekIKBfFlAlW17n+5lg9A+jGMa
 su6Vz6q8rffnD5i3qSEL1Eh4ypi9MvoqWQsH94nN1gbXyWFFCckUdEVe50J08CLbhMVidz
 Tg6HhYshY7tU3z6Nryna3gkaE+u7MeA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-ifdfGm4qMQuO6Vlm-mQIFQ-1; Fri, 26 Jun 2026 06:17:52 -0400
X-MC-Unique: ifdfGm4qMQuO6Vlm-mQIFQ-1
X-Mimecast-MFC-AGG-ID: ifdfGm4qMQuO6Vlm-mQIFQ_1782469071
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-46e18156b61so729673f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469071; x=1783073871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wSl12UVXDks9Qe2n6ujvTkHNGtVjvaUxO6b2abd2oQs=;
 b=anQBQubJp+PNGLqUUQcmcHP9rMscK2TYwyBarv8WuvtcAAGTy1mlkqQ1xdN2R8Uq1N
 gqCVnJlZqQ4EEbO28yHu47T1CFF8tjlqyUgfgn8D8ylTjmYZgGeT151poAKa9SXyLAxR
 DkrcTEZbElaTMQ6CvzRLa7UCajAuJs9ATHiGiKXlLkRgzqgC39zek6x8Khg7mGWqZAsl
 DRcik/USenLV+LxFFsLGhW1jQQnOUB0EqWcIp+JCCoT7GdN5vr1aJ0hFopYVX4y+pi/l
 dCBJj5v7ZhNYdh9YMzt6rxYXf9WIPc7AQbeannQYbrVBwmRis1cBXXKfZM+Vei7T6gU5
 9xiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469071; x=1783073871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wSl12UVXDks9Qe2n6ujvTkHNGtVjvaUxO6b2abd2oQs=;
 b=ACGD6OcgOGqgZ9Ox7+Mq5UOHDbQJHOxAIQsiX0+kRZ+t0zMf2HDEBsT6e8HEZjx9Ll
 kvggfGWGycV/J5HiAQeHO50BvH1oDrIsKNXNAwaV78qu9VwrRIAf0UCjSaHhT5yERGp+
 JtMC9sop0CJb51db5+2KaBtPpc/0PQkDMjhh0O1+7XNMOFnhtFQC6Lsu7DJ0Oizrc+Y/
 e9s/aCpUy+Q/Cld30H2tTstbjdYHxfCspyJCY3fl+wF5rQnv4z9xw1WcfzYdUMSgzrnr
 7V+yolLY37gag3bU1dxEdz+DIee7208Vus2t/UyrRgeolOf6g45w91GHMn/K1IHIPE4T
 VnbA==
X-Gm-Message-State: AOJu0YwkGR4AcASGivmyyiG11eJVi1wwn7TAdlMpNIeO3HAEBa/s4h4H
 ewkZpsM4ckU1WGSlkLzLj5SAYuoGbyBgGFVKcVnftSC0iOc3HSvmX2dZ2n+DaDmUpHsbLQB2xL3
 l9TIGmy+G1IkUK0AkOI3t9rinPN3IPnRokYGuGz+HRAzqRIXVX2oN/jN12ucaIQDoU9nDPm6WfG
 Dv4cATfD5UDv/Hm+x4VYnUMUsFssStLpxykgsMnE1w
X-Gm-Gg: AfdE7cmSnCeCZoMVbzoAIOsrYiuFsmbBKkUhbVxwROMqxwu4cNiJ0eFdtMBu04pSzFg
 SjH7l6fFSuSX/S07N1BSOxsYkxPXwWI9n1gZcWGKli+LCJ5xci2v3zV+KzYGDkM/XsahOA4idc1
 oieVHkG/gmCn7CKBft3XtWIJwpTpmS0E7PnJSvjgTkt2xsBnu8FMNNKi1r8Z2G+5Rr5T8NQgRSj
 pD8Rl8a2CY1YPwzQwazhxc0fkA4J6LiunCRdSa3/NoEuek7CBvDoSO7mEpgyPJ7Basl/ayiCKXZ
 K/dag9Tf31AFESXr5tSBjq5ojx5a3kJO66aP0RXz71nO0Dij71LrKFr4vHMqo14le0t7sqDRzM1
 8xxaYnsWSThx0dlrO96cxHXtOBR0vfpQBk/8a78vj7DMHut8tA6D8TBq8zrn87wWPhf3mN7S6Ub
 49eA==
X-Received: by 2002:a05:600c:1d1b:b0:492:4caa:e2f4 with SMTP id
 5b1f17b1804b1-492668ad885mr93422725e9.36.1782469071090; 
 Fri, 26 Jun 2026 03:17:51 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1b:b0:492:4caa:e2f4 with SMTP id
 5b1f17b1804b1-492668ad885mr93422165e9.36.1782469070499; 
 Fri, 26 Jun 2026 03:17:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49269009163sm75237305e9.11.2026.06.26.03.17.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:17:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/45] target/i386, CLI deprecation patches for 2026-06-25
Date: Fri, 26 Jun 2026 12:17:03 +0200
Message-ID: <20260626101748.1728079-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit b83371668192a705b878e909c5ae9c1233cbd5fb:

  Merge tag 'pbouvier/pr/plugins-20260618' of https://gitlab.com/p-b-o/qemu into staging (2026-06-19 15:00:01 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to db13fe80ef455f9e2be60c1bdc6be67a6b82d24f:

  i386/tdx: Add CPUID_24_0_EBX_AVX10_VL_MASK as supported (2026-06-26 00:48:23 +0200)

----------------------------------------------------------------
* target/i386/mshv: CPU model support
* target/i386/mshv: first part of migration support
* target/i386/mshv: faster register access for MMIO exits
* target/i386/tdx: add support for AMX alias bits in CPUID and AVX10
* Deprecate memory-encryption in favor of confidential-guest-support

----------------------------------------------------------------
Doru Blânzeanu (4):
      include/hw/hyperv: add hv_vp_register_page struct definition
      target/i386/mshv: hv_vp_register_page setup for the vcpu
      target/i386/mshv: use the register page to get registers
      target/i386/mshv: use the register page to set registers

Magnus Kulke (32):
      accel/mshv: use mshv_create_partition_v2 payload
      target/i386/mshv: fix cpuid propagation bug
      target/i386/mshv: fix various cpuid traversal bugs
      target/i386/mshv: change cpuid mask to UINT32_MAX
      target/i386/mshv: set cpu model name on -cpu host
      target/i386: query mshv accel for supported cpuids
      target/i386/mshv: populate xsave area offsets
      target/i386/mshv: use hv-provided [0xD,1+2].EBX
      accel/mshv: disable la57 (5lvl paging)
      target/i386/mshv: use arch_load/store_reg fns
      target/i386/mshv: use generic FPU/xcr0 state
      target/i386/mshv: impl init/load/store_vcpu_state
      accel/accel-irq: add AccelRouteChange abstraction
      accel/accel-irq: add generic begin_route_changes
      accel/accel-irq: add generic commit_route_changes
      accel/mshv: add irq_routes to state
      accel/mshv: update s->irq_routes in add_msi_route
      accel/mshv: update s->irq_routes in update_msi_route
      accel/mshv: update s->irq_routes in release_virq
      accel/mshv: use s->irq_routes in commit_routes
      accel/mshv: reserve ioapic routes on s->irq_routes
      accel/mshv: remove redundant msi controller
      accel/mshv: store partition proc features
      target/i386/mshv: expose mshv_get_generic_regs
      accel/mshv: enable dirty page tracking
      target/i386/mshv: move msr code to arch
      target/i386/mshv: migrate pending ints/excs
      target/i386/mshv: migrate XSAVE state
      target/i386/mshv: reconstruct hflags after load
      target/i386/mshv: migrate MSRs
      target/i386/mshv: migrate MTRR MSRs
      target/i386/mshv: migrate CET/SS MSRs

Paolo Bonzini (1):
      accel: remove unnecessary #ifdefs

Xiaoyao Li (8):
      i386/sev: Remove the example that references memory-encryption
      qemu-options: Change memory-encryption to confidential-guest-support in the example
      qemu-options: Add confidential-guest-support to machine options
      qemu-options: Add description of tdx-guest object
      machine: Deprecate memory-encryption
      i386/tdx: Use .has_gpa field to check if the gpa is valid
      i386/tdx: Make AMX alias bits supported
      i386/tdx: Add CPUID_24_0_EBX_AVX10_VL_MASK as supported

 docs/about/deprecated.rst      |    7 +
 include/accel/accel-route.h    |   17 +
 include/hw/hyperv/hvgdk_mini.h |  133 +++++
 include/hw/hyperv/hvhdk.h      |  195 +++++++
 include/system/accel-irq.h     |    6 +-
 include/system/kvm.h           |   23 +-
 include/system/mshv.h          |   18 +-
 include/system/mshv_int.h      |   72 +--
 target/i386/cpu.h              |    9 +-
 accel/accel-irq.c              |   51 +-
 accel/kvm/kvm-all.c            |    6 +-
 accel/mshv/irq.c               |  362 ++++++-------
 accel/mshv/mem.c               |  211 ++++++++
 accel/mshv/mshv-all.c          |  161 +++++-
 accel/mshv/msr.c               |  375 -------------
 accel/stubs/kvm-stub.c         |    2 +-
 accel/stubs/mshv-stub.c        |    7 +-
 hw/core/machine.c              |    2 +
 hw/misc/ivshmem-pci.c          |    8 +-
 hw/vfio/pci.c                  |   11 +-
 hw/virtio/virtio-pci.c         |    3 +-
 system/runstate.c              |    2 +-
 target/i386/cpu.c              |    8 +
 target/i386/kvm/kvm.c          |    5 +-
 target/i386/kvm/tdx.c          |   28 +-
 target/i386/mshv/mshv-cpu.c    | 1143 ++++++++++++++++++++++++++++++----------
 target/i386/mshv/msr.c         |  425 +++++++++++++++
 target/i386/sev.c              |    4 -
 accel/mshv/meson.build         |    1 -
 qemu-options.hx                |   52 +-
 target/i386/meson.build        |    2 +-
 target/i386/mshv/meson.build   |    1 +
 32 files changed, 2353 insertions(+), 997 deletions(-)
 create mode 100644 include/accel/accel-route.h
 delete mode 100644 accel/mshv/msr.c
 create mode 100644 target/i386/mshv/msr.c
-- 
2.54.0



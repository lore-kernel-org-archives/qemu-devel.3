Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF02CAC5BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RkF-0001Z6-Pp; Tue, 30 Sep 2025 00:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RkC-0001Yp-LE
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:13:42 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rk5-0000d3-9g
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:13:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so40782275e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205609; x=1759810409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LfIkfL6gj/tPGL1om2pz6zaZ+tStdg+utOiTzyFtZrQ=;
 b=VJ3JYc64oNq2t8UCVA5cQNSTZsXS4d6lrpuor+Bivti4xoRuB6hH3S58zhGijIKW65
 hQ3npFu4T8puoyn1fbUgUGIUbfPrayq3X1qrYPXhq6zqO6P0imcGe4GUMXoEussNeN1K
 uwu7WdijFixnkw7HloAuGCEvLOHsSpyZC4jkbRJSzDrwsV2PblJ8YRVhOlMSItT7K1qy
 Pn1mTVEMpVxP3lTbS10n+6mhmYxS2Qlq1YRZgrKZBuwzIQSEQalIQWsWSdjrn5rJtxMB
 My+8+AMtZh1UKCEZaux6q/r6hRjv0ZErbOE5VUobgE6SXvflaHOT9CJyJQ1C374IJM/e
 /heA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205609; x=1759810409;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LfIkfL6gj/tPGL1om2pz6zaZ+tStdg+utOiTzyFtZrQ=;
 b=GzEx3Cst6kHa5sF6aOL0dYaP5f7T6NFi8nj/QakE0npxLqXXN4drT0lxIYIrJJNH/u
 kMbHfflcS93eK+L3B9CMp76NwpdqMX+K7YIlIgFPS+g/4RMPNA3beHyuHCUhhqssJXfb
 3hEAny4TWlhnamKouGKYw660f47lZQYCWsBDq94UXgV4BjsPkQD8hQQ9HrivuftD4HRp
 EfIuCBc0STUPyJOX3W6VKIY9Y4wBhcsSpUNHG0zqJXXVX6czt1DH/37A+viFouqb0iQa
 2TZ0PX4VBsSyH7f89qnhcMsfHSkkc4WjEFjebt/TOE9/3BZ7UbIeXQwJbl7qg48zpdJD
 mqfg==
X-Gm-Message-State: AOJu0YzIC5rVzea159aiqDAXgABLX+ubika/YrRnAmWUXPNicJK5TT2I
 27+3ACYf79pgEbCo3k4DvruqSD5xGukLtuuJVONgM3eOf+VuyMuJAa6zPiLZh0MwW2/A7XtR5tJ
 Tgmgw8+5F0w==
X-Gm-Gg: ASbGnctxQiLOnZjOo+r41gUn4n4SCc9Rh622q/6J2FdooRtGNyMHTaUTkzdrkaLe9Qw
 f7KBhJXlrDIEL52aJsmNxsx/J5jvsg8jhLFB5ptA0q6KGoDRw7rL7lEUVXMrxLAhzM07wpcyXU5
 qrz+xDRzVNllEDjY7KWsJ+eBRQIGPuMWrc8JjJODUuHpRZ/r315cYkc2Xypr8dvvMMkoNUdJa9X
 KLxs5gfWQEmufJDG9kzHQkTksEDgn6bP1ajtA0SS6xtiih7Su1flUCHoAD6BNPrlOQvJmu5lbPr
 LN7gszXmey5IqxWwjkYRyFic9bOiOX1t7XxTye8YaCXlFyFNWLdDjPyND+XjVszOI2D5Sw/UtfT
 X2KqT6MAFX4sCnIQWg9Ar6ZNvyCuqgXJzfFDZdufih1/1ND88DQqJHDg//WUG5GgokkNIQVp2t9
 aBI9pQ4p69wTCXEA4t6uRU
X-Google-Smtp-Source: AGHT+IGJB5LpSuDvwMbeYMOlRXcgfKRnczQzMLqCO1F91RV/zBDeRDsDtJpaavO640EWA/h8XFRCSw==
X-Received: by 2002:a05:600c:608d:b0:46e:4f25:aace with SMTP id
 5b1f17b1804b1-46e510d28edmr61572215e9.6.1759205608862; 
 Mon, 29 Sep 2025 21:13:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5707c1e7sm37549775e9.21.2025.09.29.21.13.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:13:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 00/17] system/physmem: Remove cpu_physical_memory _is_io()
 and _rw()
Date: Tue, 30 Sep 2025 06:13:08 +0200
Message-ID: <20250930041326.6448-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since v1:
- Removed extra 'len' arg in address_space_is_io (rth)

---

The cpu_physical_memory API is legacy (see commit b7ecba0f6f6):

  ``cpu_physical_memory_*``
  ~~~~~~~~~~~~~~~~~~~~~~~~~

  These are convenience functions which are identical to
  ``address_space_*`` but operate specifically on the system address space,
  always pass a ``MEMTXATTRS_UNSPECIFIED`` set of memory attributes and
  ignore whether the memory transaction succeeded or failed.
  For new code they are better avoided:
  ...

This series removes:
  - cpu_physical_memory_is_io()
  - cpu_physical_memory_rw()
and start converting some
  - cpu_physical_memory_map()
  - cpu_physical_memory_unmap()
calls.

Based-on: <20250922192940.2908002-1-richard.henderson@linaro.org>
          "system/memory: Split address_space_write_rom_internal"

Philippe Mathieu-Daudé (17):
  docs/devel/loads-stores: Stop mentioning
    cpu_physical_memory_write_rom()
  system/memory: Better describe @plen argument of flatview_translate()
  system/memory: Factor address_space_is_io() out
  target/i386/arch_memory_mapping: Use address_space_memory_is_io()
  hw/s390x/sclp: Use address_space_memory_is_io() in sclp_service_call()
  system/physmem: Remove cpu_physical_memory_is_io()
  system/physmem: Pass address space argument to
    cpu_flush_icache_range()
  hw/s390x/sclp: Replace [cpu_physical_memory -> address_space]_r/w()
  target/s390x/mmu: Replace [cpu_physical_memory -> address_space]_rw()
  target/i386/whpx: Replace legacy cpu_physical_memory_rw() call
  target/i386/kvm: Replace legacy cpu_physical_memory_rw() call
  target/i386/nvmm: Inline cpu_physical_memory_rw() in nvmm_mem_callback
  hw/xen/hvm: Inline cpu_physical_memory_rw() in rw_phys_req_item()
  system/physmem: Un-inline cpu_physical_memory_read/write()
  system/physmem: Inline cpu_physical_memory_rw() and remove it
  hw/virtio/vhost: Replace legacy cpu_physical_memory_*map() calls
  hw/virtio/virtio: Replace legacy cpu_physical_memory_map() call

 docs/devel/loads-stores.rst            |  6 ++--
 scripts/coccinelle/exec_rw_const.cocci | 22 ------------
 include/exec/cpu-common.h              | 18 ++--------
 include/system/memory.h                | 16 +++++++--
 hw/core/loader.c                       |  2 +-
 hw/s390x/sclp.c                        | 14 +++++---
 hw/virtio/vhost.c                      |  6 ++--
 hw/virtio/virtio.c                     | 10 +++---
 hw/xen/xen-hvm-common.c                |  8 +++--
 system/physmem.c                       | 48 ++++++++++++++------------
 target/i386/arch_memory_mapping.c      | 10 +++---
 target/i386/kvm/xen-emu.c              |  4 ++-
 target/i386/nvmm/nvmm-all.c            |  5 ++-
 target/i386/whpx/whpx-all.c            |  7 ++--
 target/s390x/mmu_helper.c              |  6 ++--
 15 files changed, 89 insertions(+), 93 deletions(-)

-- 
2.51.0



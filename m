Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A70CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Ett-0006kx-KE; Thu, 02 Oct 2025 04:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Ete-0006fa-2C
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:42:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EtI-0000rd-5X
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:42:34 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso6121115e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394525; x=1759999325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NTegPe0Bb/he6v221vBe7onQOEmqDcWQ9UUafnugHrk=;
 b=AlHfGb33ELJBz+0W6zn4PcBEfWzE/CdxHrMQk3sO94FSKOPt4kGb0TmWnwnwNEiXxA
 lQyshc/Vz/RbYBTBlYhjwO60c2HMjf1/xtrXeKhbpO+oaDtnv0Fl2seqUF2Me6AwAsX1
 K4lFuoGGQQ3p+EmGoIpBCpcKoui5cVAN6WLMGPYUJ2mmMtN0SZdxUAPdBMZYJY/5UFZP
 lAJv5dFFdokAsPQeebsJ/Xh+CLfTPSyQF9Q8yph6wGIdr65bBqCNFOxjLFFBtD+647H/
 LkPALau6DBeX0h9/A+B77af3+GSYXD1LjExZ8fbGdIPNyr75HuEWmBQcDap69eCGD54Y
 YFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394525; x=1759999325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NTegPe0Bb/he6v221vBe7onQOEmqDcWQ9UUafnugHrk=;
 b=pAmmmBRFhUYrBgGewfqkHLUtCcFQGQAQlmMGZIWsqX3hNzxMbJlkSJd5+vW3jN3Her
 EYG1qJpvJCs/ynQY74WoZKYvHk7IzHNoXdQI5sBROLfaQ6FU7s9McasXfHxeg7CQ+jiD
 jeeXtYQoYz1yrFzLtJ6N0Q8Ut4gO3rDgDhFiDLnieugbU9+RGJvyOULMsPP5mqXtefie
 E/DHRnkoa5bVD/0Zf1rjG7ldjzmkhFyc3bORV1vMh8GfC1y5wuTIAvMhnG7DHcvB7eqf
 jWldPXiX+Zdg88eHJcswffaGxy5a4EXBdfSf317Cgh3o/AUPIEWbz7c4Yge9m7bwFMDT
 pqqA==
X-Gm-Message-State: AOJu0YwuPrXR+oizo6zgOW8tOM9EuwSZwYIWT/uCMYjcON5VArCf+8q5
 K31KT8xjDckayOjZtwHoi2Uekw/G7l5i3GVj3oZyuY+7sXiyrSFkiNZTrlPAy+SUl4YMjZoOMu3
 PBvrWDvNIfQ==
X-Gm-Gg: ASbGncuw/9ivwL+FE6uuh+1n/+1/05cTQJWwCryjt84SOEajp6nigpqXeiDAg2utjJq
 4hTMQDeH/GaGdOCcp6zFVxZw4jzyrXFOHPfP6NKaRY7ql1hsCkPDkwoJ3iWN4qNpLV1rRRac++P
 0UsqdAnT0UcVbVnGo1/GCHCFlRHfDVOvuBLFg+i+l0gp9ly7ICQAR0dd0Xmyu6jBnuGrHZc7LKh
 24G76t31sVyjdB5MnzyBXfJoVRgNWBDRT7utRFjnyH0WQZyP07Kzooer8RrrzjplF2S4cwkXdWx
 A88j0yGO0SFGwlqt3IcdecDOvCXghXxDox9UxdjwwtRk2J1ILwCy42F8VZoS/aRSf+r4yBAdF8S
 aPeR3GkofNavYDgTtRQsujOAeuFxCDz94rp96J6TJkKF60mZqfjjfpU2Bi02D+QfmYbTRrnoFLk
 pSYiJ7xiidaGyN1SlkFbmN0rUh+2k2kQ==
X-Google-Smtp-Source: AGHT+IG73iHN+13Rh40JFYt36cqDPiR27XBT7Y9OfRVKOo6LBiQqBv7ff1ie3ldwhto5T24zRQdzaQ==
X-Received: by 2002:a05:6000:240e:b0:3eb:5e99:cbbc with SMTP id
 ffacd0b85a97d-425577ecad9mr3404901f8f.9.1759394524821; 
 Thu, 02 Oct 2025 01:42:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ab8b0sm2683613f8f.18.2025.10.02.01.42.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:42:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 00/17] system/physmem: Remove cpu_physical_memory _is_io()
 and _rw()
Date: Thu,  2 Oct 2025 10:41:45 +0200
Message-ID: <20251002084203.63899-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

(Series fully reviewed)

Since v3:
- Do not describe flatview_translate()'s plen argument
- Use cpu->as instead of cpu_get_address_space(idx=0)
Since v2:
- Fixed vhost change
- Better describe cpu_physical_memory_rw() removal (thuth)
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
  system/physmem: Avoid cpu_physical_memory_rw when is_write is constant
  system/physmem: Remove legacy cpu_physical_memory_rw()
  hw/virtio/vhost: Replace legacy cpu_physical_memory_*map() calls
  hw/virtio/virtio: Replace legacy cpu_physical_memory_map() call

 docs/devel/loads-stores.rst            |  6 ++--
 scripts/coccinelle/exec_rw_const.cocci | 22 --------------
 include/exec/cpu-common.h              | 18 ++---------
 include/system/memory.h                | 11 +++++++
 hw/core/loader.c                       |  2 +-
 hw/s390x/sclp.c                        | 14 ++++++---
 hw/virtio/vhost.c                      |  7 +++--
 hw/virtio/virtio.c                     | 10 +++---
 hw/xen/xen-hvm-common.c                |  8 +++--
 system/physmem.c                       | 42 ++++++++++++++------------
 target/i386/arch_memory_mapping.c      | 10 +++---
 target/i386/kvm/xen-emu.c              |  4 ++-
 target/i386/nvmm/nvmm-all.c            |  5 ++-
 target/i386/whpx/whpx-all.c            |  7 +++--
 target/s390x/mmu_helper.c              |  7 +++--
 15 files changed, 85 insertions(+), 88 deletions(-)

-- 
2.51.0



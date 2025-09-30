Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B5FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Vco-0008Qt-8D; Tue, 30 Sep 2025 04:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vcj-0008P9-Qi
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vc5-0000dg-Da
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso31676255e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220489; x=1759825289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YvhoIhSsQDGRzJiqmuuLIQQZhU1t8TAbJtfU17YXnRc=;
 b=JlRSNR0guw4lmGtN1CvXhf80Y7hI9HnOujWtwiN/2Gh0EzY5tnRssnAq7zTbHfILNE
 LFQWh1TTnTd6u0gArQVgAfR5hA9JM3wvdtC7Va6xEeBxN0ZnUn3LnSCw885HlKvbj/Zz
 1J9UIDu9XWO6epOfIWrlhTUOBFkgMh7t9aaw5cbSlEdxsmWr69qDHEp1xWu+RkVBy0DL
 k9Upj+3L8yt3XEA2OAod7W/hPyguY3DjBgPKZ0McE8dl154I6pPiDkrY/qcgnuWQBhbW
 lwzt3GZMqyo6AyKM/kExL6e0r/wEqztMUuSEBt440qEFjYQZNSYmLICuv8qogSiNko7+
 h5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220489; x=1759825289;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YvhoIhSsQDGRzJiqmuuLIQQZhU1t8TAbJtfU17YXnRc=;
 b=VUeT8Dd8lNeaAG7QHSCujDBU4ti3lLCbUYu2ESw/aknfZqiPw5ewG27Z19dHi7ONYp
 8TbyKivSpaDfytphC+XFCgjh+cuL4Oc8zMfOcVcPLLej/1aBBiRn0XgPmFL7jNKFJASg
 sCdzAf41eLPpjxRHp9XViKnkdvg0z/cnmdPS/yc9xs6LF7S3RFHwSCPmRj/XDYuFunCb
 HBB+WH0YNxU2/zYpOH7Dctb1J2nbf5+aveIFPIXsXT1JCXkFwNamZbTv60HH1MU/yALa
 EAliRZCMD2lAzTjhFEq7S1YBprgYwB/dCGCv6QOzKyQIPdpm/N9Gyyb8xfUc7Ev8qcD5
 YlrQ==
X-Gm-Message-State: AOJu0YzXtYyzeiAHB+jMt3Dm3G04inn1dQbFrixLWzJ2QjMhgn093eKd
 +nzxu/h/9c/UxBiXQjt5jB/kHSHVzQ8GdlMbKJTcmZoqW3JQDzTJHkNSDGjXvcyHz3N03e1rA1b
 OiW4YBmoy+w==
X-Gm-Gg: ASbGncu1jJQEPTzJdexg4b+98PMzOa1aRdzcIQJdv4qjZpLuVqnqGXkxJw4Svki6IiK
 lBuxcIMl00IDY/9Xdp99Uy4WBvIgUZyenrdD3+KjQPnJQpFglFwDBSeSyK5Cf4MlkCFMQSEYWWW
 ACLPLYWBwkzcoeWZt6HJApw6FVN5nCzt8QNGdO97Ii8NwedbexI4BrW7CNWh1ymCYUMxRPlltA7
 J1f6HQIN713eL1bO56gS33zI1eWPfAAMxysEto3tCSu18rcL7yzmdlM9fHX55h9lV4+B3A9GS8E
 0N14Wn2MjdPht9jnG4vX4fkp1GhQ69uvCZmKZwHU7BiMKedroWzT62fGzmtxfOpJShY8+23+Ut/
 84JJmWRDgnCXMtJQ3lSlSFMG0lGknF0hzr24W/dj390QFQG2ELi8os1O/RrcBZXwhzUUdIAbdAX
 g5l7S8+UnHilzOUKr7FQyG
X-Google-Smtp-Source: AGHT+IH0LOZYhQvlCCwRE6HguOW9UpuwkFMjTOLA/D/C2ktVUpzuFK1TrAy7o+BecbtxQsJYTDH8eA==
X-Received: by 2002:a05:600c:8209:b0:46e:376a:c9db with SMTP id
 5b1f17b1804b1-46e376acfbbmr166369605e9.26.1759220489083; 
 Tue, 30 Sep 2025 01:21:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab31f1dsm257244235e9.13.2025.09.30.01.21.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:21:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Jason Herne <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 00/18] system/physmem: Remove cpu_physical_memory _is_io()
 and _rw()
Date: Tue, 30 Sep 2025 10:21:07 +0200
Message-ID: <20250930082126.28618-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Since v2:
- Fixed vhost change
- Better describe cpu_physical_memory_rw() removal (thuth)

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

Philippe Mathieu-Daudé (18):
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
  system/physmem: Avoid cpu_physical_memory_rw when is_write is constant
  system/physmem: Remove legacy cpu_physical_memory_rw()
  hw/virtio/vhost: Replace legacy cpu_physical_memory_*map() calls
  hw/virtio/virtio: Replace legacy cpu_physical_memory_map() call

 docs/devel/loads-stores.rst            |  6 +--
 scripts/coccinelle/exec_rw_const.cocci | 22 -----------
 include/exec/cpu-common.h              | 18 +--------
 include/system/memory.h                | 16 +++++++-
 hw/core/loader.c                       |  2 +-
 hw/s390x/sclp.c                        | 14 ++++---
 hw/virtio/vhost.c                      |  7 +++-
 hw/virtio/virtio.c                     | 10 +++--
 hw/xen/xen-hvm-common.c                |  8 ++--
 system/physmem.c                       | 51 ++++++++++++++------------
 target/i386/arch_memory_mapping.c      | 10 ++---
 target/i386/kvm/xen-emu.c              |  4 +-
 target/i386/nvmm/nvmm-all.c            |  5 ++-
 target/i386/whpx/whpx-all.c            |  7 +++-
 target/s390x/mmu_helper.c              |  6 ++-
 15 files changed, 92 insertions(+), 94 deletions(-)

-- 
2.51.0



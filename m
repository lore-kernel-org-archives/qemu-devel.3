Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD5CCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3IgP-0004yN-FE; Mon, 29 Sep 2025 14:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IgM-0004xx-Q7
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IgH-0002zH-GZ
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso32868785e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170777; x=1759775577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gjcLUmOUJAsFuFPIcikgqMGc8qGXLm4Hg2dBmXJH0DU=;
 b=FSFOIUs/3am6NfFrqS+1iDFuzuUVIT4L1spupPB/LtLpyI97t8cW+5CHeZzAV/Z1rG
 jbNXb2KjddbJQrfhtZA7aDTC7sUqErxmG1IxWK1/45HWS683/Z0HFjqxTgvK7WTovgQm
 2Io37SIpU25nKCuV2JyzDSRMhNQ0zXQ+4b7RZfryDdDA+iQ6/oo479wb5DixHjOMu+HM
 9jQA8eSjP7B6IiDn0JCH1wzrnXoNU5nouS+pr3/9NbBGkCQJMeerY7hhR5PSUDW5KzV7
 FTRCkB90Mm9Umj9Bw+6Ud6etQ65u/7a0qs1pSYEDGv8PqAslks8zb+0f8DQ8HYLz6KmF
 RwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170777; x=1759775577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gjcLUmOUJAsFuFPIcikgqMGc8qGXLm4Hg2dBmXJH0DU=;
 b=KmY2FyJZtPkUxGSGnCOL1z+8iKFy4riwHt8YktEyQAJY/gMyfh2I7WCPBCqD6Ncf7R
 JyJbR0ltztG6VLDiK1SNlA6JNr6vnaBZ79bu2sdMjFkDOH/Aos7wPJafG1Se9Oa8+hMS
 Bwsmiccc0keuCNZMlA6ovN2fuNDNAG19Vm0jyMAsKOp4ksw8aop9MsAHOD5dpX5KjgZ8
 vaXPKZjuyNhBcje5NjYhywzB8SvzQRRXeB4xA0GICzIAocEaXX2dRmtKbfJ2tEIEThJ7
 3S9YHiiLDc51f5bmb67ipvIC7x37B7wXtIbw9cFEkrcbmQLR6CXpTur0MLb+epqRy2xT
 gEJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbHETholWbBnUQd8ZmxXNrmqWhcZ7AdFLfQc9+wu9Jk20ebkAhln+PGdhhSsq9XekWue/eq1UmhwVH@nongnu.org
X-Gm-Message-State: AOJu0Yz1UctKqKOQLku9QR0A7G01f1MElgeH+MYiSX7CTx0o3XS+cDCq
 yULV4t/Dmjwx+eirZmelGSmrQO8D9ZKRRwGXxu7KXBWek/FiSlxABTVvu4JcHEqgdnM=
X-Gm-Gg: ASbGncvZb3o0pmtMzvArliT+hpCakq9MY21mMtKPfC6PHxnzPufcImnRAbA9DzOxtSt
 /SlewJS1mtlpp+DVu6rt0ADMTJETAC8IQJ1A0148tSIY9c/QJFlS/ITbh1ADtXz3+tAFCThPobs
 UHBHN93o7zIJC/XHsnpTWB5LpIADpPNRioDHUvaPMZZnRySyxg4YTCvZIaz9qDXsvV72KTtsWXH
 je1oDcpVR/DZSd7XHoF1YGl3CW2Znl9Xvtv8FvCZ6kBJXHraCzM1LFqhq2tw82RmvHBt0DogNwh
 fwmRiWzc9noX8K9y6I3ZJvOmDnoMI4EY5D4buZRe6497ghZZdYIMzyT1NpwOyA1fpkeFR/11AbU
 JOgfjnzn3U20r6OpG3XjzovsNWemldAC2R8lr7niHWXFL1aJM6U9gDTUsWOsfFTVj8hUIEtBN
X-Google-Smtp-Source: AGHT+IGPwe4k1nSiLo3Q7fXg2P2eLKRZ1aglm2SdrtFWVXuSkGkjq+3L8RzYMElaCZp3EfcaDxFBpg==
X-Received: by 2002:a05:600c:350b:b0:46e:36fa:6b40 with SMTP id
 5b1f17b1804b1-46e36fa6c4emr125120035e9.24.1759170777268; 
 Mon, 29 Sep 2025 11:32:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f76b21sm21984265e9.19.2025.09.29.11.32.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:32:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 00/15] system/physmem: Remove cpu_physical_memory _is_io() and
 _rw()
Date: Mon, 29 Sep 2025 20:32:39 +0200
Message-ID: <20250929183254.85478-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Philippe Mathieu-Daudé (15):
  docs/devel/loads-stores: Stop mentioning
    cpu_physical_memory_write_rom()
  system/memory: Factor address_space_memory_is_io() out
  target/i386/arch_memory_mapping: Use address_space_memory_is_io()
  hw/s390x/sclp: Use address_space_memory_is_io() in sclp_service_call()
  system/physmem: Remove cpu_physical_memory_is_io()
  system/physmem: Pass address space argument to
    cpu_flush_icache_range()
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
 scripts/coccinelle/exec_rw_const.cocci | 22 --------------
 include/exec/cpu-common.h              | 18 ++---------
 include/system/memory.h                | 12 ++++++++
 hw/core/loader.c                       |  2 +-
 hw/s390x/sclp.c                        | 14 ++++++---
 hw/virtio/vhost.c                      |  6 ++--
 hw/virtio/virtio.c                     | 10 +++---
 hw/xen/xen-hvm-common.c                |  8 +++--
 system/physmem.c                       | 42 ++++++++++++++------------
 target/i386/arch_memory_mapping.c      | 10 +++---
 target/i386/kvm/xen-emu.c              |  4 ++-
 target/i386/nvmm/nvmm-all.c            |  5 ++-
 target/i386/whpx/whpx-all.c            |  7 +++--
 target/s390x/mmu_helper.c              |  6 ++--
 15 files changed, 84 insertions(+), 88 deletions(-)

-- 
2.51.0



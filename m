Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5841EC4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 17:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wl9D0-0004bK-NB; Sat, 18 Jul 2026 13:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wl9Cy-0004bB-NV
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 13:52:16 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wl9Cx-00081P-8d
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 13:52:16 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49253e951cdso4048715e9.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784397133; x=1785001933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+cxDL+TeRNmGdGsgn0w9xPPD0Q0Ur6fljO5UtTAg+xg=;
 b=WJSI++kMtFh/CMpsKkrwEm0C611JzeHJ7Uef02Tr7u9U8KTwWgcMdb3EXhr76MtN+1
 5wjG4h6KNwxl2yZMsszKGVohFF7MlUowyeZFk1N7s7zLTyqnsm+NLgfiZ7vDNDkYG+0r
 WFOx57qJnA+fD1qBFuVR+/Bsb/SFfaFFjJb3kOUzunPUph793bviQFltgsoOPUoaaSYa
 7IDWELdnfoNGJ3k+rMJcWbDnUibc5PyMCK5wtJngV86gEwxtQiCrLTvylGA80LbSYE4k
 5IZk9H/i2XptLj6f/KBLmuq6EjiSNM6aO7kPAeJNWrXiqDSXJe7bZ6vP4QKugMxf2rh4
 tAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784397133; x=1785001933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+cxDL+TeRNmGdGsgn0w9xPPD0Q0Ur6fljO5UtTAg+xg=;
 b=ow74Zaf81j82eprQk73L2Lcvn51TE1IwEoDu+rjbdAjMQ8SnP47Lz+Uhuy8n4Nfo9L
 4i9rcwVZTIy56Oq5j/GxwrYoN4BPDiVAUWjv/TQ7nUcH5MUYIWVqC1w9kKzmeJr0brux
 zk5/0MOXMeup9IgKysl/ReXLKpeY2ghZeKH3/6ckjqvT8NZbHG6MjdP8YJWVVJjcJezp
 VFqfsw6d1U7xYG4q0a2sOnaOm+LDQnlb4+ko1pGDCcgDf/y8/YUxt5L+by+dioBDXjFP
 TzgKLQVIk6tuW7zULhs6Y+27zHQJcPGn6k/7v8wWVWPlofg47Iwv9vlAstVzjlVMe/NS
 Lxfw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkTw739oLUg1N1ZTgNEaSFVkNNEIi3Ta017mDYycIM71hg2VshFWX+pXGTbH4rb+YBZyBC38LF+tkx@nongnu.org
X-Gm-Message-State: AOJu0Yyv8NrKYzXh5yBp0l2xM+JDIjzLLjd+kV0Dkysq0RdquXSBeF1T
 6eUe3AzppH3w/skdK3oX5Q9kSj9faeoPoj9k4k+u49uZk3aQxbi0MhQg
X-Gm-Gg: AfdE7cmh0xAWx6ZqBiHWRJUZLNklpIun7Oa3FzDQ/q4C/Qciug0qvcKJILhZ80AFLKu
 C2/2jc+XUg8Ym+Ch+02Z8TqU/m3q4w3Zi39A18yEtFHQ5YdR8jJbEKQw/1P5H+FCzJnxaejWuBK
 jytXOSDIGn/ZH89Vwq9Ym0GBrrI53oF4ilhcvpfRVNFuF5YyYvpoMYFPWAXNNeVUixZOu5r9pAf
 J+xgwh96FdnsWp48XzUV9+/dHAgBhyLD2h6ITmLmGEjfWqC10DgDsKk+0dEOH/+Z0l71OXShJCl
 dPWtU46jcS/BYy+/vZsiC+5xgpDYQYCSZfsZ7HwHiNwxWMYQx921JHPMYLU6rq8X39zF1+js/xH
 YE68kFFu3vB+ZSFyIMlUDL0PA84JTX49qLuotdhqf2YEBan+RhKiy04N5tDYGCH2bhimtRf9Wlu
 E=
X-Received: by 2002:a05:600c:c0d9:b0:495:4f5b:f354 with SMTP id
 5b1f17b1804b1-4954f5bf442mr16509335e9.3.1784397132889; 
 Sat, 18 Jul 2026 10:52:12 -0700 (PDT)
Received: from AtiePC ([79.117.54.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e52aa4sm15220181f8f.10.2026.07.18.10.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 10:52:12 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 0/2] amd_iommu: Honor DTE[IR] and DTE[IW] when DTE[Mode] is 0
Date: Sat, 18 Jul 2026 19:52:05 +0200
Message-ID: <20260718175208.118721-1-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch implements honoring of the IR and IW bits, which determine whether
reads and writes are allowed, respectively, when passthrough mode (Mode = 0) is
enabled for a device.

A testcase is also provided, which tests different settings of these bits.
Moreover, I have tested that there are no problems with the existing page table
walking and IOTLB code, by running a virtual machine Arch Linux instance with
an AMD IOMMU and watching the trace_amdvi_translation_result tracepoint for the
storage device, and compiling QEMU and the test with UBSAN and ASAN.

Daniel Paziyski (2):
  amd_iommu: Honor DTE[IR] and DTE[IW] when DTE[Mode] is 0
  tests/qtest: Add amd-iommu passthrough mode test

 hw/i386/amd_iommu.c          | 136 ++++++++++++++-------
 hw/i386/trace-events         |   2 +-
 tests/qtest/amd-iommu-test.c | 230 +++++++++++++++++++++++++++++++++++
 3 files changed, 322 insertions(+), 46 deletions(-)

-- 
2.55.0



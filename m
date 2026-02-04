Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AC5E8B397
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 18:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnhbB-0002Zl-1a; Wed, 04 Feb 2026 13:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhb7-0002Yu-PD
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:27:29 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhb5-00013L-BM
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:27:29 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-480142406b3so693475e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 10:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770229645; x=1770834445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SJIT+3+wV0o3T3tnPDcN3HBgg/nOM7wdx8hlvU9MXgs=;
 b=pexAmXHF+4RwtDmxToODSTVNTIBvrkQy5S9Zdi6R07uLYpwhjmoIJEgpx6T8XMnPmM
 zlOh6UiVZ2cAlOEA8n5eOw7FJ8xT9OqEHiSL/PQfp267CDU233wE6rY9gUp/6cF49ZDQ
 jUblX4XDAgsGRYBimzDzRjy44tbsuDwzCrLwgHQDKt4UkgK3K0Dg0nQGerQxb6AipjoY
 yZBnsG3IEtezBkcbKYGU1sA14/az4+4GBTVuWf2oTrktxLzB7Da/qSwqjJWWZgKDJAR2
 UfhG5sRqyCPrZyCemVrRLxbXbWF5nw+A/HELCzunAz+COPGeB7P0+dQJBsoHsdu56QGP
 KjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770229645; x=1770834445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJIT+3+wV0o3T3tnPDcN3HBgg/nOM7wdx8hlvU9MXgs=;
 b=DoVOVI+Er4oEbndvkdNcrN60jAKY1FpC29YYRSKhv8MPDC48FxSIu7qa0y4otwRg3n
 LcMT/88Bf81uZTjr0/sHdq++Ghj5VHmizOnT9E0vJMTgTPXW8uNYGt8iTxZGDV4DHH2X
 YuL2f35GQAiqQyfhaYlGEnP8Kfi/QO1L6DAlwcXTHDzTrCV6LxxaOyLsQZtCF8Pbamls
 yNHrd6uaAaLVhcsuDySV1qcVY+nEJQS2+iu5ASj/zi/RQP625LZ2q1LE5GKdroGFoqYD
 OZYny+dEEvL0WZRVK/d4P+rmFCyCz5o57p6D/7vo7pc8YP1okzHuW/s0eXxTOGKsi4Wi
 lOOg==
X-Gm-Message-State: AOJu0YyXE3+tKecB09GygHJ7hZpARqP5GAgptYqHKLBV4/1hYF64SxLD
 NTX6mJddPA24YFiT4jXPdrRvqekWwkhLjEtI/Wsr1haRR0UFla6gMYO0Dr7nOEBBrZ0TVXsO1X0
 /KlIVXjg=
X-Gm-Gg: AZuq6aJOYNOvKKvyiro036Z//46OcHnpnBL/NSoRUfQohCLF/Ga/HhiE65Na4x91XA6
 OzkyLMAviGy8A1NPBfZei5caM4O5kL6KwKaMUmlFP1Z+6vGcjvAn+DoJ80MoaGdVmEU8AIpdxbM
 dK2yoa2Us1QXKNIUoFQXEsJPZLZfTa9eC7eMddmgPpBt9fqkvCw7e9RsJLGiXz+vX3HynLdOfM3
 RXkrKRmDIuU/tp4H5ZOLseBUv8mYk8LiWi6uNz9ihNZW32+CYd3b1/VSI7dvrQLkHUs+FTP7ni5
 Wc9XMduxcB5rwg4tSnhV86NCRm4cKQWkOnCt/e1nmS0XvgkaVKzfkB6gGzgnHo7xEgU/I5Sl58G
 uiZrg1j9DNuZHRUt7mqi9f5lNHW0q5vSljulZTE07GBCMXGqOKRBT4twk0kMBZY7VFfVJw2WSLc
 bOZFe/2DmEzNGCmk3nU9zOk56ScWsxuDES4rGrn5o7dvtdozmB18tDP5mv5tbCRcgG4opcBOY=
X-Received: by 2002:a05:600c:630a:b0:47e:e8de:7420 with SMTP id
 5b1f17b1804b1-4830e988f19mr56387845e9.22.1770229645495; 
 Wed, 04 Feb 2026 10:27:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d3e245sm1663455e9.8.2026.02.04.10.27.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 10:27:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/9] target/s390x: Prohibit target_ulong and
 TARGET_PAGE_SIZE uses
Date: Wed,  4 Feb 2026 19:27:13 +0100
Message-ID: <20260204182722.44062-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since v1:
- Drop merged patches
- Added R-b/A-b tags
- Use address_space_ldQ_be() in read_table_entry()
- One patch for vaddr replacement and another for hwaddr
- Do not remove the TARGET_PAGE_SIZE use in ioinst.c
- Expand TCG definitions for fixed 64-bit target

v1 cover:
- Restrict WatchPoint API to TCG
- Replace target_ulong uses by vaddr / hwaddr / uint64_t
- Remove the single TARGET_PAGE_SIZE
- Remove CONFIG_KVM from headers
- Compiles objects as target_common_system_arch, effectively
  forbidding further target_ulong / TARGET_PAGE_SIZE uses.

Philippe Mathieu-Daudé (9):
  target/s390x: Use address_space_ldl_be() in read_table_entry()
  target/s390x: Rename get_phys_page_debug() @vaddr argument as @v_addr
  target/s390x: Replace %target_ulong -> %vaddr where appropriate
  target/s390x: Replace %target_ulong -> %hwaddr where appropriate
  target/s390x: Un-inline KVM Protected Virtualization stubs
  target/s390x: Add more unreachable KVM stubs
  target/s390x: Build system units in common source set
  target/s390x: Expand TCGv type as 64-bit target
  target/s390x: Expand TCGv type as 64-bit target

 target/s390x/kvm/pv.h          |  27 ------
 target/s390x/s390x-internal.h  |  14 +--
 target/s390x/helper.c          |  10 +-
 target/s390x/kvm/stubs.c       | 170 ++++++++++++++++++++++++++++++++-
 target/s390x/mmu_helper.c      |  33 +++----
 target/s390x/tcg/excp_helper.c |   3 +-
 target/s390x/tcg/translate.c   |  60 ++++++------
 target/s390x/meson.build       |   7 +-
 target/s390x/tcg/meson.build   |   2 +-
 9 files changed, 236 insertions(+), 90 deletions(-)

-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1627AC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 04:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpKif-0000Sw-QB; Wed, 27 Mar 2024 00:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rpKid-0000Qs-CD
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 00:16:55 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rpKia-0000VP-Jr
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 00:16:55 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-429f53f0b0bso41709521cf.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 21:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1711513010; x=1712117810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wMdVp0KhU9BZV6tV0/g9FLJmEvDvjHVVK/qsvqbWJ7I=;
 b=IKuWiFrDaqDvFgiVswC8lXClxl1avj0rZveRlwZ1FhE3O6Y7pMKl+eIUkP5PwNDl+G
 S9lxRIScStl0jhPAEBGkW/UEbHEKQEGgt97FB5gsXTYMvX5W4zm4UCYxL3Imiws83RNJ
 ec3H2KMmMnPJqoRNnZYJi9XI3AhBE6uOCipQhp1ue3nr/HwjUrVsmC5jw2qkAH7gBwnn
 BGpxZHL1Pxn+iPzqmoSI+7+2hC1jl2xH4Z145nkRI+1RPGZ1RKX+Dk5uiip5+XAWgjr0
 REeTQKZ6eqAgSUHrpDZ6OsYHZ123lOAYJcYVsso8KDLX1a0GD0PrWo5/5aMOyMO4cbTZ
 F/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711513010; x=1712117810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wMdVp0KhU9BZV6tV0/g9FLJmEvDvjHVVK/qsvqbWJ7I=;
 b=e2h2Wmpmln7YMfvtuNPRG1mH7DkKq9ArLIaOcUIvMA55bMmEhp1hF4fHEwfUz89HBx
 AvHmi0DjUZAIGwyvni1Vc7ePNjghbgnfLywBEvKotvLuT52d2tc11xTdb1eN/oixh402
 luRQ4HiKF2lIshLq1V5YAXmKLL1p1j+YuANL8xXG5EQwUzAYnC432n1ZBa0T27hJqb+f
 ljJvJOHEFiX2rXWr1dHU9QiJJFKjd0WYrqEhsW7aCa0o4M8V30vcBL0fLH0wWdhxAMcq
 ff7goekZbLdVdI8J0tSEzef1ysbVWYeisLFzMhOsdvjYqWLJBghVU2yfl04p+rpxD/+b
 yPNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyuNowAHNvEGAF/8tN5g0KXny+9uQLsAGikus+h+1P0jdaSaQ0plSkoC8sqTKdW1sGQPaxZXr/G0sY/NKb/MVpdLVmuAk=
X-Gm-Message-State: AOJu0YxO7NjzjxPvf5YFr4uaUm1T6gBvpCS2kbx4oi+GHG+/trtulL1T
 /2r9FjbNjTHbRa3wDliHtsyC7ZuWuwsRhp0dIc27cUsbtK2zP9cTUGD4j++o/uI=
X-Google-Smtp-Source: AGHT+IFPKIzBXhDWX0vwwecPPOx0TLesoDld5lggWtVvDT+Jl49ZpjG37mTEKqJH3a4f9GmGUE7nhA==
X-Received: by 2002:a05:622a:407:b0:430:f228:5f87 with SMTP id
 n7-20020a05622a040700b00430f2285f87mr3797120qtx.31.1711513010098; 
 Tue, 26 Mar 2024 21:16:50 -0700 (PDT)
Received: from n231-228-171.byted.org ([147.160.184.93])
 by smtp.gmail.com with ESMTPSA id
 hb11-20020a05622a2b4b00b0043123c8b6a6sm4370696qtb.4.2024.03.26.21.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 21:16:49 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Huang, Ying" <ying.huang@intel.com>,
 "Gregory Price" <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, tj@kernel.org, john@jagalactic.com,
 "Eishan Mirakhur" <emirakhur@micron.com>,
 "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
 "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
 "Alistair Popple" <apopple@nvidia.com>,
 "Srinivasulu Thanneeru" <sthanneeru@micron.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 0/2] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Wed, 27 Mar 2024 04:16:44 +0000
Message-Id: <20240327041646.3258110-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=horenchuang@bytedance.com; helo=mail-qt1-x833.google.com
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

When a memory device, such as CXL1.1 type3 memory, is emulated as
normal memory (E820_TYPE_RAM), the memory device is indistinguishable
from normal DRAM in terms of memory tiering with the current implementation.
The current memory tiering assigns all detected normal memory nodes
to the same DRAM tier. This results in normal memory devices with
different attributions being unable to be assigned to the correct memory tier,
leading to the inability to migrate pages between different types of memory.
https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/

This patchset automatically resolves the issues. It delays the initialization
of memory tiers for CPUless NUMA nodes until they obtain HMAT information
and after all devices are initialized at boot time, eliminating the need
for user intervention. If no HMAT is specified, it falls back to
using `default_dram_type`.

Example usecase:
We have CXL memory on the host, and we create VMs with a new system memory
device backed by host CXL memory. We inject CXL memory performance attributes
through QEMU, and the guest now sees memory nodes with performance attributes
in HMAT. With this change, we enable the guest kernel to construct
the correct memory tiering for the memory nodes.

-v5:
 Thanks to Ying's comments,
 * Add comments about what is protected by `default_dram_perf_lock`
 * Fix an uninitialized pointer mtype
 * Slightly shorten the time holding `default_dram_perf_lock`
 * Fix a deadlock bug in `mt_perf_to_adistance`
-v4:
 Thanks to Ying's comments,
 * Remove redundant code
 * Reorganize patches accordingly
 * https://lore.kernel.org/lkml/20240322070356.315922-1-horenchuang@bytedance.com/T/#u
-v3:
 Thanks to Ying's comments,
 * Make the newly added code independent of HMAT
 * Upgrade set_node_memory_tier to support more cases
 * Put all non-driver-initialized memory types into default_memory_types
   instead of using hmat_memory_types
 * find_alloc_memory_type -> mt_find_alloc_memory_type
 * https://lore.kernel.org/lkml/20240320061041.3246828-1-horenchuang@bytedance.com/T/#u
-v2:
 Thanks to Ying's comments,
 * Rewrite cover letter & patch description
 * Rename functions, don't use _hmat
 * Abstract common functions into find_alloc_memory_type()
 * Use the expected way to use set_node_memory_tier instead of modifying it
 * https://lore.kernel.org/lkml/20240312061729.1997111-1-horenchuang@bytedance.com/T/#u
-v1:
 * https://lore.kernel.org/lkml/20240301082248.3456086-1-horenchuang@bytedance.com/T/#u


Ho-Ren (Jack) Chuang (2):
  memory tier: dax/kmem: introduce an abstract layer for finding,
    allocating, and putting memory types
  memory tier: create CPUless memory tiers after obtaining HMAT info

 drivers/dax/kmem.c           |  20 +-----
 include/linux/memory-tiers.h |  13 ++++
 mm/memory-tiers.c            | 117 +++++++++++++++++++++++++++++++----
 3 files changed, 119 insertions(+), 31 deletions(-)

-- 
Ho-Ren (Jack) Chuang



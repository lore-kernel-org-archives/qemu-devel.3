Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EE8CD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 05:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq4sW-00064m-6K; Fri, 29 Mar 2024 01:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rq4sS-00064O-6v
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 01:34:09 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rq4sO-0000Kh-9u
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 01:34:07 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-430a0d6c876so10415351cf.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 22:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1711690440; x=1712295240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kzD9bp4lfPKjq881EZTr8X35H33UpZ0U2oJTGnZVwgs=;
 b=NQ9Mx9bYSAxCHOxIeuAvaEigD30jKGSrG3f1zvuRTYKnfRgKzZoVhoeQd0Z5mDeuk7
 r6zkhrcV408CFGpeOwd1mw+WM0sZsotlKVVbxk+2w34nwaX1oY285y0KakujivE4AKtI
 qYecML3fHZZQt1/2LUFHU2oShX8RyOMHNyoBduP3wT8eAXcgKMqCGX3xotSINSOoBAE+
 N4N3YxO2BMHtuiFzTn+QPu6zIwPQFjkWfi4Lbeg4Xx0dc3wfPfXbPuzmOA7xG5n+wjhw
 252+TaYt3CI8tMUo3kfMXS2NAQlR1dUbv/DN826qQxmy7Vjwq7fGj6hUYdDMjOGLCMCA
 oAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711690440; x=1712295240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kzD9bp4lfPKjq881EZTr8X35H33UpZ0U2oJTGnZVwgs=;
 b=RsIrjxXQSt8WhqOM5yMC5E2o/Lklt7QlI2UXHOEu4q2k3Ue+KoNnJLyAUCxfl4+WWv
 Mm8aI4EZ0Abl3kqDQ+Yow/SEk+nouX0Is6w4pPFkmcDHdXCLL7JtGPZiCtUFt1DRb6ot
 ftNksg+aGcIpy+KUOXSq4J/nR2BtX7PEHOse6rbHGfrL++vbtUvPdo+g4C7eOB1LuQUI
 KVDNi2Y8l4UjreiHDKtbfo1wA6fZ5npD2Jb2FUr8TttdlhGO9FnOKVA9/W1hfB8AVRR1
 +46MCt+oxfMmCxTd863ODRaRlNUYwzRDGeEGUFi9RvBqjMlm2rE5Q+ytQqRl1LDfqhQc
 GBLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLl1+rn1PzNAhe/2N6ZqR6ol4zZmmOuBk+J09Ueswm2DZBlPW0Z7IyDtxNgjwJArwLmarL/FDQZ5KURYasfoClg4wHlk4=
X-Gm-Message-State: AOJu0Yz+mw+vIFlpLprOM17Oqkkc3dTrqSu6zCqQjLxMKnCYvmCUJdjh
 QADEvi2ozhpWMQzm01arSdCEJdpRM113R7jL5c9I0ePwTbE5FGb6KwJdVBogoxs=
X-Google-Smtp-Source: AGHT+IEPCB5hxd4bBd3zlijyd5nzuuMHJJeNzrT0TX98AmIg0/OG0kaxC+8voIkqbdWtPzxYHjpC/A==
X-Received: by 2002:a05:622a:40e:b0:432:c50a:3d65 with SMTP id
 n14-20020a05622a040e00b00432c50a3d65mr152679qtx.36.1711690440563; 
 Thu, 28 Mar 2024 22:34:00 -0700 (PDT)
Received: from n231-228-171.byted.org ([147.160.184.85])
 by smtp.gmail.com with ESMTPSA id
 jd25-20020a05622a719900b00430bf59ebccsm1293700qtb.11.2024.03.28.22.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 22:34:00 -0700 (PDT)
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
Subject: [PATCH v9 0/2] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Fri, 29 Mar 2024 05:33:51 +0000
Message-Id: <20240329053353.309557-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=horenchuang@bytedance.com; helo=mail-qt1-x835.google.com
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

-v9:
 * Address corner cases in `memory_tier_late_init`. Thank Ying's comments.
-v8:
 * Fix email format
 * https://lore.kernel.org/lkml/20240329004815.195476-1-horenchuang@bytedance.com/T/#u
-v7:
 * Add Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
-v6:
 Thanks to Ying's comments,
 * Move `default_dram_perf_lock` to the function's beginning for clarity
 * Fix double unlocking at v5
 * https://lore.kernel.org/lkml/20240327072729.3381685-1-horenchuang@bytedance.com/T/#u
-v5:
 Thanks to Ying's comments,
 * Add comments about what is protected by `default_dram_perf_lock`
 * Fix an uninitialized pointer mtype
 * Slightly shorten the time holding `default_dram_perf_lock`
 * Fix a deadlock bug in `mt_perf_to_adistance`
 * https://lore.kernel.org/lkml/20240327041646.3258110-1-horenchuang@bytedance.com/T/#u
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
 mm/memory-tiers.c            | 125 ++++++++++++++++++++++++++++++-----
 3 files changed, 124 insertions(+), 34 deletions(-)

-- 
Ho-Ren (Jack) Chuang



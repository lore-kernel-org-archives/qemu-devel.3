Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A49C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 04:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVEU-0003Ai-SE; Mon, 10 Mar 2025 00:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEG-0002mb-VD
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:05 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEF-0008E5-Aq
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:04 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2243803b776so52191105ad.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 21:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741582742; x=1742187542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcOq/B0qkF7oBYEuLqTVXYwaTmG9K1DoxB38gebkidU=;
 b=MmAje4LwQBE2I1ZMIg8wQsLaVTq+sBbZfC4bNlM/JcEAPe0dqg3IaOO502cq8Qz2E/
 uRexT1Neu2vw6vS/0ZKGMfJLG2POAHFRjeBSxHK9HD3y2Lt+zGFgtO3LJ2WkitirgTro
 6Lavx7SHQe5V9ycv1dYH3otkngjF4Jh6alAF0n/zV6RY5mr1FrNfMPNJC4YEHV8iXSFZ
 x4oC+nolMNUNYMserNjQAB8vdAyadFiOwikpQZhaYJ/k5/3OD+wn2jG35Rr+jPbvhStY
 Al52QVCeMMU6WaxhoDAT0rcRkUyaIq+ullAs3Ep13rXunxp2CRKVymsKdsOmOsc9nMdz
 /DhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741582742; x=1742187542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pcOq/B0qkF7oBYEuLqTVXYwaTmG9K1DoxB38gebkidU=;
 b=o304f6QxLkBtxC2z+X/7ADs0wQ+4RdfyKYi1qPcmbo8fWidW5Dwy2gCbpyGao96mMc
 3p+mFScAAfv0uiVo745fhWtWmZwConlgWhbvQUsP7zd3nirnjDARR5EaD/rNxVTbBAHw
 Qp1SrrlRkTxykOsm5ZFEHnEY7f67VwGqp4RM0qvh8GmUWbYwZ1735HHA4TuaopbqvHSh
 qUT7vDjeVHxmC/+23uvHfRonbdoucKpQayi3t2KXfMU5ho/hpGLZR4hikdkSrkbd1gt+
 wfhQRr5OVminDoJK5TOrr2WVOuAvJ5CLAyn4TA6dANlMSAa0xQAwpv+EcAJutDJYwUhJ
 8fAw==
X-Gm-Message-State: AOJu0YwRRVINzI1H8CrDurXsKEH3aHnlnSiPkNav79ZPv7GaL72iD5Xt
 0bdkuoR09QBls36eYtyMEFzTZYA8M3NlkZY4fW74AMKRZi+Hy8u+koKgiKpPUEQ1DprE4Y6T9Jm
 R4Wo=
X-Gm-Gg: ASbGnctyzXP1lQmRc2a/Ox9iVwa9yRJ4pErYZ1+3EZ98bpoqvooWzj4IaURNRic7d7L
 ytogVJYaiJmy+V9GSpQlucGHzzxQN7S0Goc/J5psDhCl9GktypJ6eayU2M4gULPwanW3ki7yDSr
 k8w8Rr+QuHAquK56lWbixjw0Ftv2FC4bvDTZ2LvszApOnmoD7UiByyyIYFnqdsT5d/5Prne6ttw
 mz059Z7IciCOUb3VYZFXOSqFPJOC6dzw1QerTX+ThKfXTUeergGRdzrrmhJRvvxelNPdF+Z5T6q
 nNyLUiEW+ponrrvYrxoDN0jiq+pbD48J2KFY2j1cJall
X-Google-Smtp-Source: AGHT+IEEpEpujiC2fwj7VGkMO+uHTookE/oxRvy3WzoSDUTK3dbiUUraMl3feFU8Mr38LhiryglRJw==
X-Received: by 2002:a05:6a21:8dc2:b0:1ee:c1b2:76d4 with SMTP id
 adf61e73a8af0-1f544f67b54mr22292031637.40.1741582742058; 
 Sun, 09 Mar 2025 21:59:02 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d2ae318csm1708308b3a.53.2025.03.09.21.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 21:59:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 manos.pitsidianakis@linaro.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 10/16] exec/ram_addr: remove dependency on cpu.h
Date: Sun,  9 Mar 2025 21:58:36 -0700
Message-Id: <20250310045842.2650784-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/ram_addr.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 3d8df4edf15..7c011fadd11 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -20,13 +20,14 @@
 #define RAM_ADDR_H
 
 #ifndef CONFIG_USER_ONLY
-#include "cpu.h"
 #include "system/xen.h"
 #include "system/tcg.h"
 #include "exec/cputlb.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
 #include "exec/exec-all.h"
+#include "exec/memory.h"
+#include "exec/target_page.h"
 #include "qemu/rcu.h"
 
 #include "exec/hwaddr.h"
-- 
2.39.5



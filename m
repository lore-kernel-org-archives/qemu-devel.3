Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD899CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 17:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4138-0001x3-EF; Wed, 01 Oct 2025 13:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4136-0001vQ-Fw
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:55:32 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v412r-0000zR-4T
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:55:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso660145e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341307; x=1759946107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBaAfw5JT6Gi3iih06puN0jNUode/oUz6CEGsKdvDCs=;
 b=zbYSgqF38ggQ7cWRetyaDuJpE+itlpDQ4BzB3wskiNeT9f795u2H+Fbv+M3tXyDlD2
 eM7pJZMIJ0UZ/G60+gTF6A8E42jZn5304tdlajJ4BaN5k3c6d7R1uTXgySjtGQ+hm9zX
 7STAX2moZKHPSl/evfEkqT9BcdVIRZeyVar2ic19SLVcHj7gCmVh4HE9v9G9Yim0rFbk
 vg6BbMgzIsg/jHZWOiC+MTb56/bXxsFWMfPPPqWHTeouLVqdACIVH7Ch/S3djAhVKbGU
 pmtfLqkDpIIbnKJuf7DwAwFAQevwXZTVh1XdpLNTuiJR7gtr7urSiRj/zC9VUOKkKmlU
 d9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341307; x=1759946107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NBaAfw5JT6Gi3iih06puN0jNUode/oUz6CEGsKdvDCs=;
 b=xI/BTJKqDfWTDFsxzCPPQUOQ5CUiGmYrlUouy3eMR3WplT9+iZFuinGKcSIwVhGFCP
 /O0N/sLkZd0hQHsYUHvVoTBn0NQzCgaHschZ66HrdO1rS3dD6Q7idkekQtnnaWNbZG0P
 Dnhc6/xh2TtaBhAmMnzDPbI8DO8Pho63C9FLD5jJQ6huSy4mygQwEkcWYm+Z3bGrPzbR
 UMuUCu3KWdW+UW7t/PPBgqFayRAou6iWRKoXVnZjUN6nj5fLEMbPS+oQg+kLc0FbLALg
 5Ekb5s69o/rZU782by/+xSSbYA1UMaPluJsuoFSlRVXy76QaaJenmI19syWAEffJWobT
 FEcQ==
X-Gm-Message-State: AOJu0YxLBsxKZSCmMwwZBPHAzZepEPSEnzWsUmxHixkd2wNJAA95QCm/
 1ctWqktWqtx6mL+47PVrWLsoJOp6CIfTq7qlV6TOTZxaEjaE0uLyfXMuufWlnoh7FgaEsNh/b/B
 LRBfORjYAcQ==
X-Gm-Gg: ASbGncvqrhFugx45MMknKV9R7srUxu1QSqiYw+5PeKhPkzvaJl4rZ/YQCDkY9SR98FU
 1abd7XgBGe6bibWKfmhlMiLlpbLWtfVb1Ws+FvCb78RUBMqhfWYifno6v5UewBXhMtwcDqlWi4u
 rnUkOdQR4fE14SOmWvtL1RtaKSM2k8h0wMTkVUXz3cSYRwzhJ8eet4EIRygblGvklHU0eKDwi7N
 OpdtWLZgqiD6ea++STCgU3Lht/KDgMBgK6/5MZqy6W/xWPe5EXRhxkafTmsgkJdgIdscySsuNhw
 UZW8t2KBw+DEAWEZQFitjFS50wUQvXiseWL6DexW5dxP+ZK1qzWZjf0tiyzrWPdrq4s5XQDrkYu
 zv5hEUpIulYgzVkXyWC4E+xxHtyfIfln+yhm3Vuq4uChdFIGCSuZPw4q3Ngg627sRgnSo73itif
 LMpAFPLtsoMzwWUjRgxmlA0UvSgA==
X-Google-Smtp-Source: AGHT+IEWsWi+Nsho5T807TNBGq094dWdLWwTbwGMWBB4+ICpcy+vDMYvY+ZqTgbYOdjGB4etexOrFQ==
X-Received: by 2002:a05:600c:198b:b0:45b:80ff:58f7 with SMTP id
 5b1f17b1804b1-46e612e57c3mr39612865e9.36.1759341307382; 
 Wed, 01 Oct 2025 10:55:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abf38sm130150f8f.20.2025.10.01.10.55.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:55:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 03/18] hw/s390x/s390-stattrib: Include missing
 'exec/target_page.h' header
Date: Wed,  1 Oct 2025 19:54:32 +0200
Message-ID: <20251001175448.18933-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001175448.18933-1-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The "exec/target_page.h" header is indirectly pulled from
"system/ram_addr.h". Include it explicitly, in order to
avoid unrelated issues when refactoring "system/ram_addr.h":

  hw/s390x/s390-stattrib-kvm.c: In function ‘kvm_s390_stattrib_set_stattr’:
  hw/s390x/s390-stattrib-kvm.c:89:57: error: ‘TARGET_PAGE_SIZE’ undeclared (first use in this function); did you mean ‘TARGET_PAGE_BITS’?
     89 |     unsigned long max = s390_get_memory_limit(s390ms) / TARGET_PAGE_SIZE;
        |                                                         ^~~~~~~~~~~~~~~~
        |                                                         TARGET_PAGE_BITS

Since "system/ram_addr.h" is actually not needed, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/s390x/s390-stattrib-kvm.c | 2 +-
 hw/s390x/s390-stattrib.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index e1fee361dc3..73df1f600b9 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -10,13 +10,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/target_page.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "migration/qemu-file.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
 #include "system/memory_mapping.h"
-#include "system/ram_addr.h"
 #include "kvm/kvm_s390x.h"
 #include "qapi/error.h"
 
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 13a678a8037..aa185372914 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -11,12 +11,12 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "exec/target_page.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
 #include "hw/qdev-properties.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
-#include "system/ram_addr.h"
 #include "qapi/error.h"
 #include "qobject/qdict.h"
 #include "cpu.h"
-- 
2.51.0



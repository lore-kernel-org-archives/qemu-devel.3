Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27081CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s6X-0000f4-6l; Wed, 01 Oct 2025 04:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s6Q-0000dn-NV
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:22:22 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s69-0005Xk-7b
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:22:22 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-421851bca51so1897771f8f.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759306917; x=1759911717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SiAF+xKMY/ZjdE56BR2SJrHQNq0qMD7rf4hlNCZkp34=;
 b=aeO5ogdk/cXUoGYsbqgHA1HbZHTqgRQnFQoqWPV/8ZnXCy2/eGIl4/Y1KBiCXZJzgh
 94Qd4dJ91G1JLmt583n22kKn3TDkWTOJ0CxAIZeAhPqwpmNxiC6hQ3zZcFwqiR9dT3bG
 raA/ON0+UIropGj9VhTTxqj3HpznujFsMw3KI9mux5pQ297XUkmPwhNDzcqeHqL+K6XO
 WMOovZALJiRCeAfyHMpFziDW8KvvxGergBcQ6RJgySvIAZHA4m+D60/KhurD7lmtYVoq
 E7YRPWSkgnC/t0oTgdxrRJsSyNWE6G+N23+5qG/IRmOu1HicScPcj/kQ2uDZYoqT6mkV
 j1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759306917; x=1759911717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SiAF+xKMY/ZjdE56BR2SJrHQNq0qMD7rf4hlNCZkp34=;
 b=SbLdsMnlwGZGnqmIFFsl3O2fozH2ue5z5E+pQV7m+IKIterjr3j11pMO0evWSRXCBD
 tdenxx/89e2zAiez0KDTNNmZX6aNMMHyM52FaaBhdRbUguYgXIl+Qa8pmzSG/bTah5bC
 PkFCRAfLscq3sc3j0c+zlyaRJ2f0qJ5nPUJDAX54G5LX6Fw51vFFhHyNNl7c1cWLC94r
 bSM9q7ii1YQ2o8oavPBSw/iXxeBqPWSoHNeur4Iax/cuq2rzljVJQ20WWEtk4phifSnu
 Ic9IVeZU0SbrYmAHtQdoii+yJPlNTCeSaqO2B4Pa9RtBpHHA2L1EEDOWG7KewgCU0Kdd
 PVOA==
X-Gm-Message-State: AOJu0YwME5m4bJj4OpRGln2GTS+Fmn7+V01dxMK0gNRZLVo9gbjZQv1r
 1spHHnPPpVIw4JhCJeq0S5fCia4CHaw2kF8UbFCUttxSErtye1UY/aHHWfLQZSKH/FM1pHNSFqw
 TrfIAFSZF0g==
X-Gm-Gg: ASbGnctyNYa5ppUDrzuINY27yOUTqZkEpQWwp6anbX/8S8dmTiIRcDSwLe6Y8Bdn1Bg
 F8ieLyj95NGyCi7y2UYZB9kPQ20cc8MFM5pv9BkRjOedP7fXw3SJyBdNj1FyG9EDwQhR+rWFjIP
 QJ5wu1C7eGu3Fkt66L/EjwixXdXCVWY5BpHBn5mnM2bu8kg7ANYjybUyn/EPDKEX03XgtkaGOD1
 SElB/rf452jyzcrZAzt4JKnpQYqmjcTBVFhtuT8PO3MSNh0sj4pOQ0PN6mt7a08DfAiBv8JExBp
 nccf7LspY2EIU09HFvAha8rtlUXN8b0w1eo/c59YKEwn3/xsi0dMKa+nHoHnaGBPX8/tXBGYg1k
 GU/aGT3utkcSq+vn6rflh04xEHddWNmKWefvX8XANNQZ92Ma513hdfTRt0ppo+mP6CZfZH6ccFe
 p5a+BEOv+QUN8kCK1ztVva
X-Google-Smtp-Source: AGHT+IG2c0fzOsFiKbrvJ6/AoYIm/GgfiCoe/atI67XIMJvAlpgbgwgfqiNLjcER0nZiKAK5YPtzGQ==
X-Received: by 2002:a05:6000:220b:b0:3ee:1357:e191 with SMTP id
 ffacd0b85a97d-4255780b78bmr1411077f8f.30.1759306916617; 
 Wed, 01 Oct 2025 01:21:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc7e2c6b3sm27728732f8f.54.2025.10.01.01.21.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:21:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-arm@nongnu.org,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 05/25] target/arm/tcg/mte: Include missing
 'exec/target_page.h' header
Date: Wed,  1 Oct 2025 10:21:05 +0200
Message-ID: <20251001082127.65741-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
References: <20251001082127.65741-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

  target/arm/tcg/mte_helper.c:815:23: error: use of undeclared identifier 'TARGET_PAGE_MASK'
    815 |     prev_page = ptr & TARGET_PAGE_MASK;
        |                       ^
  target/arm/tcg/mte_helper.c:816:29: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
    816 |     next_page = prev_page + TARGET_PAGE_SIZE;
        |                             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/mte_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 302e899287c..7d80244788e 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "internals.h"
+#include "exec/target_page.h"
 #include "exec/page-protection.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/cpu_loop.h"
-- 
2.51.0



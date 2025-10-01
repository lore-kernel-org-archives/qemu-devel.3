Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498D7CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 17:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4137-0001vk-65; Wed, 01 Oct 2025 13:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v412y-0001pl-Qw
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:55:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v412k-0000nB-IT
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:55:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e501a9034so385265e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341302; x=1759946102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0oYtvp1Jy05y+cs5OqqW4cigIw/Evuwzbdyi31MB4Sw=;
 b=LWZdqDNPE4DXTYy/ohCZBp8K8X8XzWEu/DuKa9DjpcgXXh/VxLf8s03btlru560e9r
 uBchJ8cRTPJmk8NPUwUOvlG3E07pQi9W0SwD+uxk/snda28ArsRbr7oRyfZxXTKFs5Xk
 RhQ6MpU52gfaaMMi1TSsb3PWRj3hmY29SXGIGosHSCkX+KBwyJcTNoD17etj8EL/C7tE
 jPzlAH029rFB5zFxldSPa6/qT71sXsrcw+lmw+23sP6KBAZagQKh3t9f/xrauZ+0UUwY
 TES2mNjZpHoo1fQc0/RnxeuVZenyNidBHVTi3Xy8Usndyx1V2vOdar7m5XSimjwEuS6i
 diJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341302; x=1759946102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0oYtvp1Jy05y+cs5OqqW4cigIw/Evuwzbdyi31MB4Sw=;
 b=ZsSXyuo4aNoY5sEVi8TZFL4dBalEq9yngd2a7dUjMT2GogJYhf9WICn08pOyZ7HO31
 pHwp8eoyC2srxqTFT59+b4m+2Ky9y1fdxA8hYi1n51MZpWW4VSUqiz7s8fYgRi+CcY6C
 6DNsfMSI97PNGdPgkCQeag09vfwJuL6DhPSt2sw9IdnwqRd8YCx/uRD9IBToGDE7PQzC
 mBWpQoVl5qxwefWVEKMKxSalN8tOR9QuEwrGdXPa8kbB5NgejXlHJTcULeykxT9Ed+1X
 Hb2g0Xybc15BKQvgSyrn0O3CRUWdIyNu7SrX1Ggnsz9Y/Yx+zOGlfJ/8jVwjVKY+V8/7
 ACXA==
X-Gm-Message-State: AOJu0Yw1tLFWVlTL4v1s8EVRt1XSQ3xfLSmm7HBc9JVzEBLiNbzBYT0L
 FeVoqATETrw8sQ00T58Hf9rQTTsp9qNbX1ntKkPBuhTE7/qfY4flTfIMVjYX+HCOZCpBEGtKtKg
 ILaAXyVL7bQ==
X-Gm-Gg: ASbGncsy9H7sR9SjF2Hqco/KUGe5+w6p0Xm2XJenLkEIe5C802FAZaygxvYU9/87TTK
 0FI/VoMUETNiSjtDsrbz/+//SVlXMfi35yLBJIGzjPo/d8oKdI/gyVI4GABr1jgp1e+PA7Z6R6J
 rGX1Ew8+msyWtAuYu9bNtDeZGzEG0rKADdlDxQG6FrpVoEWMvBN5C56Ho24APEzB6L2B2Rfc9Xr
 BUHIGtnPDVmRfYKGVKAn3WUpUTBJnpevrpdeSjc7dv/sSH2qbRW3ddRBIk3ATiKANIinSkcO7OT
 oIvjmwEjJu74hX8HO+SCanOzMfkEiY4aNwyROTW78In3QUAmuPUTF/YqccZi/veDi42Rv4ijgwX
 wb8HHDj79kvfJKoYx1bQIPe/PjZYe9zYWmZREl+bNWPc17hRF0HjmudhOPpMzvJf/9q3OaLDgp0
 VtfpG+zqfyrScGFoSo9a+Hkqk4bw==
X-Google-Smtp-Source: AGHT+IEE+JOgdQcWDCLTXQOhks4UvOy7ZMILGVzu3gYLgsHV3P63UTkJyw5YOjk/WtC4nRuVfjLM/A==
X-Received: by 2002:a05:6000:2f83:b0:3ee:2ae2:3f34 with SMTP id
 ffacd0b85a97d-42557803ac5mr3634173f8f.13.1759341301952; 
 Wed, 01 Oct 2025 10:55:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f027csm94114f8f.40.2025.10.01.10.55.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:55:01 -0700 (PDT)
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
Subject: [PATCH v2 02/18] accel/kvm: Include missing 'exec/target_page.h'
 header
Date: Wed,  1 Oct 2025 19:54:31 +0200
Message-ID: <20251001175448.18933-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001175448.18933-1-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

  accel/kvm/kvm-all.c: In function ‘kvm_init’:
  accel/kvm/kvm-all.c:2636:12: error: ‘TARGET_PAGE_SIZE’ undeclared (first use in this function); did you mean ‘TARGET_PAGE_BITS’?
   2636 |     assert(TARGET_PAGE_SIZE <= qemu_real_host_page_size());
        |            ^~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e3c84723406..08b2b5a371c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -36,6 +36,7 @@
 #include "accel/accel-ops.h"
 #include "qemu/bswap.h"
 #include "exec/tswap.h"
+#include "exec/target_page.h"
 #include "system/memory.h"
 #include "system/ram_addr.h"
 #include "qemu/event_notifier.h"
-- 
2.51.0



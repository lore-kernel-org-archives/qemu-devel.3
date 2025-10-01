Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A888CCA471
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 18:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v413j-0002LS-0A; Wed, 01 Oct 2025 13:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v413R-00028M-Dz
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:55:53 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v412z-00011w-R7
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:55:53 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so56751f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341318; x=1759946118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkQiV8/WxMAsAF/tO7oGNDf2WwINp6DCDeDQzDnnWeY=;
 b=VzO/E1T8FAsD0ZDX9WjZNJC58hO34Up7m3i3vCaF22TV3+NRfQMsiIOuiJcyuMi6Xy
 L6r5s0YLKDGiszz7wU0fEtgV8dDZxZx3FQYWX1UFvGNaWHHXo8//+qdqp6vvGgqgdDH7
 kaZPjkjX/FhWhW6IFSzLY+FjfnVX0jUq6/cPxqD+lAxNUDu11FE/WD+M4phzv7gqrYEP
 oBUQk+kCXDPngSUUjofx1HRC7ZhsE0lRuJSV6Ciypg316FZtq3JqnJeJC18rnOONab4j
 Lec0sxwg9dcK9mkmGqnSD3/yYUwbaRt7eKFgXNDtcOmc/jZaDCrhOAySIWGy7QTX+9vu
 lIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341318; x=1759946118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkQiV8/WxMAsAF/tO7oGNDf2WwINp6DCDeDQzDnnWeY=;
 b=WPOfONOcTs5jNJAUHVd7XqLmfjnDdvvt5jj4GTjC5ZViFP1nU296oyB1Ogdo0+VQr6
 VMD873whNLV4ocGh0EbYFKtM26x9xh4aZAG4M/26nLBosn5GRbRGhINF1s8FlpUsUur/
 QUJMvM94+cSx7cjg4J0K41o0EaJa8o78WJpsgJwbIBD7J1hbdIbA3cseIPfZ1TbVwi9F
 7Gzd2tVWdLLdK8jxzipEqkCVFVMvbg1XfaAGs8oKi4pIInp+dBRH0puoTl5FD5rfYwhp
 WjvQXncwKHYKtZp5McjByQGt6QesPx+YzoASftLzLDvP8/PIUZR2d+XahEfPH33w5Ri6
 QJsw==
X-Gm-Message-State: AOJu0YwEqBWxCJ7JcNSUzRm6FVOyTrFPiMsXDZK/EgOWj+fuSFKW1mya
 WQiuN1iES4arkJbataW7eCKM00+fGli5+c0LEwrrLhK2k7pvCCRYcJ0XmKzLLE8wgusQD8FzJHq
 2pvRpWmfb7g==
X-Gm-Gg: ASbGnct9kdn40azxg0yXy4IsyOxQjlvpEYnMQGw81R5pjUxylsB31eytgvF9I4yPcO0
 rAKT/nuRSxKfmR4aFukCo6ER9oiEfii2Ho2CQRmyGt82bp4Ztn2wm0lHiPMf4d06Ro+IhkA5OjD
 0bzp6ArbFurfagtwTJLU1tEhwqJqpmFZ0wCzPkcHdLyTvZVbF1xaFDfTxH0AQldsMVvIJYxYKa/
 EbZcUHBFKmrnrP+55RpCYaqYp1ofrb0r7uZa+4+0TMwA9A1NglKgO9G7MMgLkbW6GcqrVaLTp4j
 nobW8MvBsvvzKYSwSw484Iuj9xeK0+vXrEoIAfRYQcjnKYr9w154h0bV5tkKKqYAa7s+bO5gxex
 lynePtWPbcjjuIo1OXDe8z+YI6araG9fypMSSgRtTdQE7QUy99tRZCxwcQ9i3HPJrgMXlxqOuCA
 9h4XwxsjxgF5Mc+WwEsOZA9RQOnQ==
X-Google-Smtp-Source: AGHT+IHHgUi4fwM6+XTet857QFCrk3UGmPYPPJoZifC7y5X6DWSEAq4/DeuzncR1cjyeDBGduhFF9g==
X-Received: by 2002:a5d:64e6:0:b0:3ec:e152:e2ce with SMTP id
 ffacd0b85a97d-4255780b3bfmr3329278f8f.32.1759341318066; 
 Wed, 01 Oct 2025 10:55:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f02a8sm90075f8f.39.2025.10.01.10.55.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:55:17 -0700 (PDT)
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
Subject: [PATCH v2 05/18] target/arm/tcg/mte: Include missing
 'exec/target_page.h' header
Date: Wed,  1 Oct 2025 19:54:34 +0200
Message-ID: <20251001175448.18933-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001175448.18933-1-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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



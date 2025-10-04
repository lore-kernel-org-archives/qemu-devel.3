Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20558CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wU6-0000UI-Ks; Sat, 04 Oct 2025 03:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wU4-0000MD-6v
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wU2-0005Hd-3C
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so30664325e9.0
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562107; x=1760166907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MRb1CrkXqCRPOQq7qY8ZuPxTdIwhUD1x8dMSTBlsPBM=;
 b=KMD5MBMJrVUatHoM5jixG8f46+wJHqKNXZEkRq+fACCdKqy68wY6DBfuCnUiIfiaBx
 x4e2bVwxVCLjBcqZA3f3Wi3OaVJtQ37lb6plro1TeyXRkxXyElZ6+7s9q4MZW5aAoG3A
 wBLBrD0dyPWuLaWin0VS7zAFr/nxX0Efd8+qa9Uc/HskG7Yz7NXgTJPEtWtUTf9u8/NP
 ouT2yErsW4SgsPDfesesWgi6ymw6Yz22mi0bQitZR+dtCDYncgPTxI2b0y6KRkHMpv0M
 Dv1qLid6CY4RH5bk/1a+rTGlp8TBiY54oCnv3EvIOZc8lmsqAEWzFLD9Mgo/nmMJtcCM
 kswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562107; x=1760166907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MRb1CrkXqCRPOQq7qY8ZuPxTdIwhUD1x8dMSTBlsPBM=;
 b=H4jjPEkQwhu2ZilvOUeEYIqxy9Ek0NGuUYUuAtQo60VTonyL8N/mdhIKWMhSZA380S
 L+b6IvbRWlQ90PL6GkpfufQ9CM0GSTnvwJ+uMAyHuJRhei+juyGTM1TlDXsGtNONlPSd
 HVVRtivDBixC4moxIed33a0UfBh8DJraJLMFRuEXg0uG4+Hy8bc+ZXT3TcSYzMvek2o/
 O37LAaxW3lUir7LyC5h6EHuAuWG8osqHTxLu5JJvSE3/gwxhR6ZFTGLg8645Ra2vYVM7
 gZ85NFiWvEWdnzJwLzhCv830mtfJN5EJ56T7XY+Ec7uPoAo4GQPJ4C15/TrI0m6As0Ye
 /1tw==
X-Gm-Message-State: AOJu0Yz+GivH0qI6nR3D20EK0P5PCfaeMWtjCWsFgOH6KEctAJdVqMit
 eRJn0PRUWKrJyvZDm7LH0obJNTNIyLgcQIfog3gbqF3p1n79t8L9cLAXLDEF95zA5hf+V/JA2ZJ
 pmjI7Ca2c2w==
X-Gm-Gg: ASbGncu/HNILexDDjt/R4AFWokz3k2PXtrOJkHOmdemexhIWBBecVY4EA7FzOAMBkSk
 +YNEufO57ogmK1RqtrFcSJneut0j0DfXyA1UL+7pwNYWvgVwfF6+gnZRFB/dVg7UoNC+8f7JR6C
 NJTz7b2a9vY/A0I+JWmweiiI9YbYbaHS6piK4pqDAiq25zHb178rr954zx5PfHdSgk+jibKj7Rr
 l1v98esRusrPEhO6b/I+2IbAgAIFPdKnp65jWhXWoOL8wMisyVg9dFavjHGw5oLYVySu2jz32K/
 hph7dY/E7gXuC99H5CoXyB38NgtuIJsmJ5hZ47fZzEtBdyKwxX29dqvpl+BXmoG/bnoYu63aOA3
 I3Kqxk6gs/mX23ZF6+fj0jjDYlqSIiI3C/atOXMSz+j4u0ZGnhB+6I85AmiMj+ydlKhgLEJgJ+m
 lPgtJ3KakyJ43gKmim1zuzw3b9NB4fDnKcO70=
X-Google-Smtp-Source: AGHT+IFaF3aSloGEKekgriE1iuAf62q+qFx5UKnvCVtpC2tx1dVITt6/1+n5KVzQCWdgWvGWg6H0RA==
X-Received: by 2002:a5d:5f87:0:b0:3e7:46bf:f89d with SMTP id
 ffacd0b85a97d-425671c0ca9mr3803902f8f.44.1759562107276; 
 Sat, 04 Oct 2025 00:15:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d869d50sm11452794f8f.0.2025.10.04.00.15.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:15:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/41] accel/kvm: Include missing 'exec/target_page.h' header
Date: Sat,  4 Oct 2025 09:12:51 +0200
Message-ID: <20251004071307.37521-26-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The "exec/target_page.h" header is indirectly pulled from
"system/ram_addr.h". Include it explicitly, in order to
avoid unrelated issues when refactoring "system/ram_addr.h":

  accel/kvm/kvm-all.c: In function ‘kvm_init’:
  accel/kvm/kvm-all.c:2636:12: error: ‘TARGET_PAGE_SIZE’ undeclared (first use in this function); did you mean ‘TARGET_PAGE_BITS’?
   2636 |     assert(TARGET_PAGE_SIZE <= qemu_real_host_page_size());
        |            ^~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251001175448.18933-3-philmd@linaro.org>
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



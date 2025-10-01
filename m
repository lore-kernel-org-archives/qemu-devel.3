Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B53CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 17:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v412v-0001o7-Sn; Wed, 01 Oct 2025 13:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v412s-0001nV-Oa
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:55:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v412k-0000mL-Db
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:55:18 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so1050065e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341298; x=1759946098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XkYjpkGwROToQk/2WbGPU7KxLpYxvDufJjy5PE3aYU=;
 b=gkg5PkMNV80T69QzR+lCXevOervSj4B292vlCOAS1ScqfLYkG6dRW47DrPPGT8+UMY
 7YLVEf63zKjkD/sLekrj7tmUY4vSIwv5ItcJ6T1ecfDXP57R1rGSrNgiIl0PdtUE/aZn
 vkH1k1iRkEHO05/4/bfU00WzEN2qsFcBw9MW0fW1423u3hcD1fZn9NyMwqKotNM059de
 LJwNsllfvB1l76Q8VmLW4BqexCozNaOzd+tfANDekpFZDLrTodIocaSRpaV2StWfQIvf
 2lDM90FccuVitVw7nh1a47zT4bKRxOdWMMf9QC5axnA9THD/BIi7jLvFp1z9i6IyUuIz
 cyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341298; x=1759946098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XkYjpkGwROToQk/2WbGPU7KxLpYxvDufJjy5PE3aYU=;
 b=An7Ac9XwJKZPIjSCD/fQf6KKuSAiP/ujEJ6uMBbjY8skx0NDJ+aHci2Jeiwd2WT3tw
 JYO/aKsH7K+JzXabt8cKHteYhfFmsYMWSXbfxv3kdMM9B/0A3X8iLrYL+/xdwLhqSqRM
 +q9ZujTqhhaSVIut9SwJHd1W6dfLLRll7n/3n/dIRGUhP9aq3o8Yq0c+htyIiKmIPIX6
 a+oFa2zG0tu1/AsLQLKKvlrWuAljqlR4rPJN3JrxDEEnS3vR+6v0wGtWX9Lz3GNI2sX7
 0F5mwYSW6pVgATbLkYuMeeJ93Vy/XGygImk+r2TCvTNDc6zJpKtzJDnVOJtw+C2t/vGJ
 nuXg==
X-Gm-Message-State: AOJu0YxH6OQ97QpIHwjxcQlgd1AGJDlBNkqvCDhEPOZTbT4aQPXPIQ75
 aITz9LZ7ju3A0NZN/2adEUApd/VSyAbtbHm9WarPqK0M2wgM2R+gMbNY18bAAoDhyMzXU70Qelw
 ubRCoAO94lw==
X-Gm-Gg: ASbGnct5J1SjvCWu143oqTRbiKnillEV6W3DKfF3/ShHPxoASxld0Zue0itp7XFaBic
 pJnYlZmbl4uf7BCUjuTS1PFcULk6BAwNGWXlTiuUfo6/ToFW6/UmrlDnT+yerTNAV3sGsMx5Dle
 84Swz6yoyvmCEfr3+hGo+K5sdMbZL7I2zJ2Cy5XDsJvCkhoe2njkf5kk+z6dzIFoM6m8+kovwrC
 J6eNpQRTmN8zB8nzlTeJ6BDtsesS5p4kzy60SAewb9HahyUGbO/GUiJ8Si6Q1+Yh3hH2nX00DRS
 FJvqh+lQJCCEs+bCk+YZaiIMtYj8Xk7XmAEAmU5KASg3NaNJBBjNGdDo2hh1FCQBVc0QRNuNH3S
 6jIHPuo+GEJHs2edSqV7oREen5tnF2SAxBp11pVWDDdIMbpJ8FCsmMvrPA3rzsDqhwMR6U1NZZ2
 ULT72MoNeaGq8pVXVHXGBdLPT9Q8LAZb4pWIt5
X-Google-Smtp-Source: AGHT+IG+6A4w+oZ2nzHqr3/j+TRguh1ZpSriyILzNvAQJTaQHCMqI3mPsO36a1m6OS4BIGT2UtInzQ==
X-Received: by 2002:a05:600c:8b24:b0:45b:7a93:f108 with SMTP id
 5b1f17b1804b1-46e6125cf2amr37605675e9.3.1759341296396; 
 Wed, 01 Oct 2025 10:54:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e980dsm119278f8f.36.2025.10.01.10.54.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:54:55 -0700 (PDT)
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
Subject: [PATCH v2 01/18] system/ram_addr: Remove unnecessary
 'exec/cpu-common.h' header
Date: Wed,  1 Oct 2025 19:54:30 +0200
Message-ID: <20251001175448.18933-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001175448.18933-1-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Nothing in "system/ram_addr.h" requires definitions from
"exec/cpu-common.h", remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/ram_addr.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 6b528338efc..f74a0ecee56 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -29,7 +29,6 @@
 #include "qemu/rcu.h"
 
 #include "exec/hwaddr.h"
-#include "exec/cpu-common.h"
 
 extern uint64_t total_dirty_pages;
 
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D63CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3IkB-00005d-QQ; Mon, 29 Sep 2025 14:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IhT-0005XQ-07
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:34:20 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IhG-0003Vh-9u
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:34:13 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3fc36b99e92so3648409f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170832; x=1759775632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QtU1C0M8U0OTbHcI2E95ZD2Zrsmz5/OESKETD6NudSM=;
 b=W0R7SWcTBwwQYVbia6+lkifzJdlhq+le3xmTFxDvUZU/fnrXYhUI4ilCmFf9juOJb9
 cTMmRGfUuIh0mOqhqWZjH+T2/bHlfyX1snqQNptYErJQ0CXd1UYKY5an6kj3EGy2PuMR
 NqmIl+bDm0IbfPWjTHykesOPdt1VDupx17h2S3oHL1Yqsf6GbOgEXXey5gzMg+XrJozz
 4BTUvCMfPG/Bgli//0hA61rDArVRuyu7pK5ebnI3XVKSEUcouKkH/ecInixkQercN7fr
 x4j0z5CFnRwF6FDjAWpPh+9Mkk4yt7pVumQq0c6eEqA9xgMXqaMNlQWbxE1B+p3zskGg
 MvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170832; x=1759775632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QtU1C0M8U0OTbHcI2E95ZD2Zrsmz5/OESKETD6NudSM=;
 b=NO+A7hBApVAqfuBMeA5sNId6wBQa5zREC/V8xdpxK0gRHC103F63/4RBywsXji4qnI
 lirWQVXgAOC6dxgDD7OycU7m0sdSWXUunTwpaYux91mD78t35Owic1Lkfj4ykZuPeLLa
 22u7iXg5V9vzLZJW9TUDcXMFPVA4NWtQvV0OT9MabmHVXyXWkAauT1/Du2e1icXNV9ZT
 NzlbCfVkq4KJ+pDo+E91Q5pzU1MEI67LuJv6TouQWgJiUoro0HCGln/HhzklpAcwTPoQ
 UFpSCV59xvxoTNQTacbvQcDMw65YVscnLnpexG/r3uoQM6e+U7ro7WnCzbfXqKBNY5gq
 2WZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURrdYnN20bVc886UZ6hsjDm5DiEY2K0kkyN6xY6JY8pT/eZeMobEnNf69pnO8kXPrHCDHPtlQb3x1r@nongnu.org
X-Gm-Message-State: AOJu0YyrHjaORnz58Wqn1d8UmBNNDOpsxOMKtNNYHPMSqWc6ssOaubYM
 +QEOxWIjn6GyJwizznZ8aE5FrBcqDl273ufuAYWECDdjN6rfCPFNIYeMx4FaDj4m2TY=
X-Gm-Gg: ASbGnctM5Jsx2+wCSabBIC0E6WiQsZldlAIsGom/6n5fbhnnTMerJuT0yTi90jD1TvK
 eRekobKuUT7oE/ZXULm2I4lW6ZjB9nNScxjwO7l0kJ+KUeIWl3Jq7VKE1g1J2tSHV7u1HqTsH+t
 /Wva1KMPq0C8V8kbP/vPJEW90zq6wGV0YBeaaeqIfwGYej5e2PH3u9XXe4LkJsVWSBrFkl/ei+O
 4JDZzN24ceo+N53Rlj97QEYddeYm3FBqFoKpozQWZisB1fufdOTSJYXU5iutMWEW6D5mNCoHTJz
 BM+2auLriUQLFT1Tx/2NgkMWpMBwU8YTjZbW8UQN+x7cMhrLIkUyFNzju+Ye7CWcl3QXvHFgNs5
 08CReakb4QPybCAhkh1I5uu/bwazSe2+EDXmPa0tKuCi1ljEqBYEfMENX4PKqB/2G/ioJuJ3N
X-Google-Smtp-Source: AGHT+IGjnZG6/qjEBZy5PcjHjXj9r7KBUUors89ckyudEmcNpuheEZ9krTQTynjT1eMge8vskVxhUA==
X-Received: by 2002:a5d:5f83:0:b0:3ea:fb3d:c4d1 with SMTP id
 ffacd0b85a97d-4241111f6d1mr1595433f8f.18.1759170831738; 
 Mon, 29 Sep 2025 11:33:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e59af1975sm3031215e9.3.2025.09.29.11.33.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:33:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 10/15] target/i386/nvmm: Inline cpu_physical_memory_rw() in
 nvmm_mem_callback
Date: Mon, 29 Sep 2025 20:32:49 +0200
Message-ID: <20250929183254.85478-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929183254.85478-1-philmd@linaro.org>
References: <20250929183254.85478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/nvmm/nvmm-all.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index ed424251673..2e442baf4b7 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -15,6 +15,7 @@
 #include "accel/accel-ops.h"
 #include "system/nvmm.h"
 #include "system/cpus.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
@@ -516,7 +517,9 @@ nvmm_io_callback(struct nvmm_io *io)
 static void
 nvmm_mem_callback(struct nvmm_mem *mem)
 {
-    cpu_physical_memory_rw(mem->gpa, mem->data, mem->size, mem->write);
+    /* TODO: Get CPUState via mem->vcpu? */
+    address_space_rw(&address_space_memory, mem->gpa, MEMTXATTRS_UNSPECIFIED,
+                     mem->data, mem->size, mem->write);
 
     /* Needed, otherwise infinite loop. */
     current_cpu->vcpu_dirty = false;
-- 
2.51.0



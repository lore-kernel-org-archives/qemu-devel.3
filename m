Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0010ACAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RlQ-00023j-VH; Tue, 30 Sep 2025 00:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RlN-00020O-83
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:53 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RlJ-00013a-TJ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e30ef74b0so37706055e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205681; x=1759810481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QtU1C0M8U0OTbHcI2E95ZD2Zrsmz5/OESKETD6NudSM=;
 b=z2B7yiHln37aClp2bGkqESsXoKLWWnrzwDJtaUjneo2v1YiLk6/xEmokAxxCS1sHSO
 P1juIOxgWJGx07p7c/6hdl42fs1OmFMBlVcQ4nR6Bg0dIwxtNfH3sqBjWU8h2qS4N7xa
 2DmOfeV5gyU1swg5ma9U3kthuaiGw++4lZk/VC6tjzOe8g7GPmmEyFiFNorM0v3GT+Zs
 bJ8xT2uLHqPJRvEX7HwaQdKNYxoiJ3P+Eaz2CEeXcZRe5heT4/PeJ/iZ/GJk+4c9jPzq
 kLmh6X73i+wfUykpVvKik7TjDSZ8xtz/3JADMIBajqd37RMxL5vO+DMWY5kLMIN8Qyfp
 GZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205681; x=1759810481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QtU1C0M8U0OTbHcI2E95ZD2Zrsmz5/OESKETD6NudSM=;
 b=HAP7QVwQIcG49bGpMu1SaAyNlhPBcpuywvt4a7LdRIkFJHfRspnnB6fV4b7BRgaazn
 QnkxcI6g+yJwGnjPDJtUhc9oGx4TmEAjzKKZGXi5869WMlaczfznGU5C28sSZbj/OkdJ
 Kg+FtvW2oJzi8hcYgpLOOxhpB/tEx8hLVsmR+s+zOaqntd4EvuSz7dSLt00miB5XLy8e
 +dEpBJgGxw+zNcZhw5jjX+rl5VL3CmjXh86TdVog6/FLz0s/LHHUSXI9KTcusZAaQPYO
 Ba0BHMTN+iKZd4lbvtyGNbB4jzGbzbiLXAYM/Ro752b3ML3bfWa3AmTX8nuZ6tQfctGG
 6dWA==
X-Gm-Message-State: AOJu0YzP/YZOKcJZ/CXmSln73PekXlImpr9GMQ3YsexRPaosbImMBA5d
 lb7HDVUSdfGi4sfX5xCFpYEGFMVrfDM2S4zzyMrZqEXgJyvXncJz/JVMxAxncNNfBHUmnToAchJ
 klsbwxfCTgw==
X-Gm-Gg: ASbGncsKLdU6TL8IyrBH8dbOwPwq3rh6DxTdc0rqD87yC59KLNP7Q2tciQUMBlcwxqV
 ulkuYa0TMdbC3+6QVvonjCt2qKB2kl5me+C7fPJYb3hmlYFUuLGnrfr9QhZpfFes6lwlWjNL8jS
 Xwj35XbGjCUgobgZJyU7bJTkenYx47SQ2UOL32AA0Y/dlfk2xlPHglpgTHXlYyjAFRPXdjV6DLP
 4acG7XqVNo4QTIl8c4DgAUpHNRzE1wx4SPOjxA3vreCh95O1aCB/yhrtYadHUXFyqYmpUyhJqZ2
 vYCs82lfhNwh1CQBHmlykIsAweRD9jKISD88RfjQYy73Ksx6k9tPOdg26DFFM3BqTamFkbyBACN
 weS1Uil20m3NICC874ge4asq35XdvnNJRV6CEguKxFA+f76/0FAO8mLSjWJ1psDQzRna8SmoJQd
 orkyIpjIBLIjXw8QZN79js
X-Google-Smtp-Source: AGHT+IGUG79kearmVn7+9qugGuIF+Iaatq5RHrgppUdDi9qlZIXdMZGH9YdXisC+M3CCPhGM+TJyoQ==
X-Received: by 2002:a05:600c:a00c:b0:46e:41b0:f0cb with SMTP id
 5b1f17b1804b1-46e41b0f464mr152474875e9.25.1759205681405; 
 Mon, 29 Sep 2025 21:14:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e4ab0bf62sm98607665e9.9.2025.09.29.21.14.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:14:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 12/17] target/i386/nvmm: Inline cpu_physical_memory_rw() in
 nvmm_mem_callback
Date: Tue, 30 Sep 2025 06:13:20 +0200
Message-ID: <20250930041326.6448-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
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



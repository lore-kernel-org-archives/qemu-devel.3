Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6A7C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 09:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2SO7-0008FB-SK; Thu, 02 May 2024 05:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2SO6-0008EV-Fz
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:05:58 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2SO0-0000gO-Tv
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:05:58 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41dc9f98e8dso3472515e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 02:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714640751; x=1715245551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m6hdX/QShEyoevdHWJVmo9TQTgWa7HYlW/pBH8IIc94=;
 b=r3RrTnZvmNDhxCi9Vuee2lmDPFzvN2uex91lm+Ssmk2ROrcZR0MAemPuLo1gKDiz2t
 +lhqK7zzLWRlWMWYfFkc88h+OC5119HAB/jPTeTCMD9sCWh5cxkW/XFAMGXDWWIFBzIR
 sf+Qj7L6mQ5aWAlpAuk1BJRom3f4DERCEt2aHZNRHmlt/ExYvFwi8MAglKf0CuqKqZDh
 JvG5YRWBdqdd0YVe4EXLMwF8OnnR1kjaobpEeJG1PUcTF4orWfSHQnyNEATejd3gkO2/
 Ol9UdVnOGxyVUrjf7id7ZPnuGwrTPO9rtFhbIGcrqYFL+SkVF/rHAqqdi426Xbv03lTE
 KrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714640751; x=1715245551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m6hdX/QShEyoevdHWJVmo9TQTgWa7HYlW/pBH8IIc94=;
 b=N8Nll2QcdYmf7RqsP9DO8FHmmL5O5yfGToiCr9oiwfnp2izHO4SShx7K/IxQfUmqRK
 9uaO2wl+bpXPm5bX+h3fCELLdgwNqthHl/kzZ1luuzwEmkMhHsj+rR/rIvFS1YZwUSqK
 2kbHDi0TvZHaoTYs0V5yAbSrgFs97wNNHqPKo7H1TILklQD4Nb49W5HSKONYGjEK5H76
 tUDimX1uxxdu+/D1fZhaWhFqo01Lz8pVeiza+jmOIXuN+6+yD1cnTyKytyJHRukOMfpi
 eQUFEG+489E4WIozSszaQ5Oz7rzR1zU0MWxkA5h18dlyga7D+yjFiY5hqVkSY2/QHq9j
 UoWw==
X-Gm-Message-State: AOJu0YwXoRCTnlZEHASHX8h51ItpFoGH6Pdv/AeC0oV+p/zudXLv9pei
 L2yeY1yqv8xE1/05YUFZ4MZcZgHcs1fuYY1kZT3Dd6/qvCQQ9xZLoZG8tsVlpyIIn3J+qzoDVHg
 O
X-Google-Smtp-Source: AGHT+IF9e3B4t4KUsaF9I1B+VX4Qg01xgoSe06CGyBo5WLah5E8ZZBY/F7M2OIVhPwbXePh6WffstA==
X-Received: by 2002:a5d:4b83:0:b0:34d:9b4d:2a43 with SMTP id
 b3-20020a5d4b83000000b0034d9b4d2a43mr1748734wrt.0.1714640750205; 
 Thu, 02 May 2024 02:05:50 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.215.106])
 by smtp.gmail.com with ESMTPSA id
 y10-20020a5d620a000000b0034ddb760da2sm753549wru.79.2024.05.02.02.05.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 May 2024 02:05:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Yu Zhang <yu.zhang@ionos.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jack Wang <jack.wang@ionos.com>, Li Zhijian <lizhijian@fujitsu.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Galaxy <mgalaxy@akamai.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] migration/rdma: Allow building without on-demand paging
 support
Date: Thu,  2 May 2024 11:05:47 +0200
Message-ID: <20240502090547.87824-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On-demand paging support was added in libibverbs v1.2.0 in
commit https://github.com/linux-rdma/rdma-core/commit/e500adc7b1

We don't check the libibverbs, so add a meson check on the
IBV_ACCESS_ON_DEMAND symbol, and define HAVE_IBV_ACCESS_ON_DEMAND
if found. Restrict rdma_support_odp() so it returns %false when
on-demand paging is not supported.

This fixes:

  migration/rdma.c: In function 'rdma_support_odp':
  migration/rdma.c:1133:12: error: variable 'attr' has initializer but incomplete type
   1133 |     struct ibv_device_attr_ex attr = {0};
        |            ^~~~~~~~~~~~~~~~~~
  migration/rdma.c:1135:9: warning: implicit declaration of function 'ibv_query_device_ex'; did you mean 'ibv_query_device'? [-Wimplicit-function-declaration]
   1135 |     if (ibv_query_device_ex(dev, NULL, &attr)) {
        |         ^~~~~~~~~~~~~~~~~~~
        |         ibv_query_device
  migration/rdma.c:1135:9: warning: nested extern declaration of 'ibv_query_device_ex' [-Wnested-externs]
  migration/rdma.c:1139:38: error: 'IBV_ODP_SUPPORT' undeclared (first use in this function); did you mean 'IBV_QP_PORT'?
   1139 |     if (attr.odp_caps.general_caps & IBV_ODP_SUPPORT) {
        |                                      ^~~~~~~~~~~~~~~
        |                                      IBV_QP_PORT
  migration/rdma.c: In function 'qemu_rdma_reg_whole_ram_blocks':
  migration/rdma.c:1189:27: error: 'IBV_ACCESS_ON_DEMAND' undeclared (first use in this function); did you mean 'IBV_ACCESS_MW_BIND'?
   1189 |                 access |= IBV_ACCESS_ON_DEMAND;
        |                           ^~~~~~~~~~~~~~~~~~~~
        |                           IBV_ACCESS_MW_BIND
  ninja: build stopped: subcommand failed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build      | 3 +++
 migration/rdma.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/meson.build b/meson.build
index 837a2bdb56..7c6436ac9e 100644
--- a/meson.build
+++ b/meson.build
@@ -2410,6 +2410,9 @@ if rdma.found()
                        cc.has_function('ibv_advise_mr',
                                        dependencies: rdma,
                                        prefix: '#include <infiniband/verbs.h>'))
+  config_host_data.set('HAVE_IBV_ACCESS_ON_DEMAND',
+                       cc.has_header_symbol('infiniband/verbs.h',
+                                            'IBV_ACCESS_ON_DEMAND'))
 endif
 
 have_asan_fiber = false
diff --git a/migration/rdma.c b/migration/rdma.c
index 855753c671..4717fb3143 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1127,9 +1127,14 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
     return 0;
 }
 
+#ifndef HAVE_IBV_ACCESS_ON_DEMAND
+#define IBV_ACCESS_ON_DEMAND 0
+#endif
+
 /* Check whether On-Demand Paging is supported by RDAM device */
 static bool rdma_support_odp(struct ibv_context *dev)
 {
+#ifdef HAVE_IBV_ACCESS_ON_DEMAND
     struct ibv_device_attr_ex attr = {0};
 
     if (ibv_query_device_ex(dev, NULL, &attr)) {
@@ -1139,6 +1144,7 @@ static bool rdma_support_odp(struct ibv_context *dev)
     if (attr.odp_caps.general_caps & IBV_ODP_SUPPORT) {
         return true;
     }
+#endif
 
     return false;
 }
-- 
2.41.0



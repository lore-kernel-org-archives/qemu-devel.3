Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC0CCD11DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPdt-0006EO-In; Wed, 27 Mar 2024 05:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPdr-0006DS-Ln
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:20 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPdj-0007pk-VZ
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:19 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e74bd85f26so5215526b3a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711531930; x=1712136730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqrZPMitGEHrImvOZFbV4c6XxRh57v1JSDYD00D/pSY=;
 b=jWX0aJtmQLP2ACDFhr55Dk91O/OdwXSc7NBChxQICDWhcvwoKHCw47fUJ7L5MLXMrM
 pSG9Ai+LzyylNJNbGDoYIsK/eIRZeD5w1ZG+Kaxoy6MXaps90MlETn66PV8vmSA9Zo/0
 NXW5u/62WsJF7+0S6IfEhzwID/Qh3j0RE5VCFq53okdf2UmhuoRDf8jb/m4cSOnkEgcy
 zYS1x+MYTkKuok771Bp09DACAQsszz+cxdYwg5kot6u3F2aAny5iXrfkjHD80x2hUa4i
 TBO8rX/QnANsnWQvXwWwuTA1e77G1Tp0kMhy/f2DASxox6i/Bu7SeEz2vSid0X9hHaTH
 MJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711531930; x=1712136730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqrZPMitGEHrImvOZFbV4c6XxRh57v1JSDYD00D/pSY=;
 b=RcO6qQN7h0XZR6FdJX1VvRuZLVHK49RuagTZWpBSc79CdKqki7txNhXErxa3rLc5Vw
 zcJGSkDXPwzs8eC5Jl1lH+otZEmjzaY8CkAdokX7E1IRRCOuicQFYPc72d0HcN6dmWHM
 l3GddxtjKailByr2HJvpQ+IIxI8QUPNG6fCEzWur3Z7n5l0FX8j6Waate3YNKRHAfKeg
 EPkYrhlFZFmcWnoB+F/41QEYRNcT2hufF7Qkt40NjW0+xtHurZ8QxU9phLtFmoOzbJkM
 DeNrYgSJxm2/ARBW0V62uz4as3AimQehOrmNwHnS65QfyXN0zLV5DhhYN0OUh/Fl8nj3
 z+iw==
X-Gm-Message-State: AOJu0Yz+6XvDLzfeZN6ujUyD86mtmdHpuRSLZGkLxhKCLAKhT0WZRHys
 GRQyEwSFGk3FifQmrPagYeeon+kTVnfBrC+r0C/usVCffRWpA5cG8BBeRnrfNb12qKKJDL6UCAx
 j
X-Google-Smtp-Source: AGHT+IEnRUpiCmLDAaY/pT87GTpS76y4rQhAOYHwK8GAKX+Ipbo4DTsNWbS+KeFOdO3kEc9wwmIP3w==
X-Received: by 2002:a05:6a00:2349:b0:6ea:950f:7d29 with SMTP id
 j9-20020a056a00234900b006ea950f7d29mr2317095pfj.20.1711531929893; 
 Wed, 27 Mar 2024 02:32:09 -0700 (PDT)
Received: from grind.. ([177.45.186.241]) by smtp.gmail.com with ESMTPSA id
 fm23-20020a056a002f9700b006e6b41511fdsm7628760pfb.94.2024.03.27.02.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 02:32:09 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v2 7/7] qtest/virtio-9p-test.c: remove g_test_slow()
 gate
Date: Wed, 27 Mar 2024 06:31:44 -0300
Message-ID: <20240327093144.781701-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327093144.781701-1-dbarboza@ventanamicro.com>
References: <20240327093144.781701-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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

Commit 558f5c42ef gated the local tests with g_test_slow() to skip them
in 'make check'. The reported issue back then was this following CI
problem:

https://lists.nongnu.org/archive/html/qemu-devel/2020-11/msg05510.html

This problem ended up being fixed when the recently added risc-v machine
nodes faced the same issue [1]. We're now able to run these tests with
'make check' in the CI.

This reverts commit 558f5c42efded3e0d0b20a90bce2a9a14580d824.

[1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/virtio-9p-test.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index f85f4ef407..8d8a7578b7 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -710,15 +710,6 @@ static void register_virtio_9p_test(void)
 
 
     /* 9pfs test cases using the 'local' filesystem driver */
-
-    /*
-     * XXX: Until we are sure that these tests can run everywhere,
-     * keep them as "slow" so that they aren't run with "make check".
-     */
-    if (!g_test_slow()) {
-        return;
-    }
-
     opts.before = assign_9p_local_driver;
     qos_add_test("local/config", "virtio-9p", pci_config,  &opts);
     qos_add_test("local/create_unlinkat_dir", "virtio-9p",
-- 
2.44.0



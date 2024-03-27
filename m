Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75F1C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 14:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpU8i-0004r0-Na; Wed, 27 Mar 2024 10:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpU8g-0004qR-Dg
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:20:26 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpU8e-000130-M4
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:20:26 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so3454813b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711549223; x=1712154023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=madbT/BaQjt9l0NAIRCdz4iExhKI7w/5+Gn0wJFqL2Y=;
 b=Z1jlY+EY4o+6cSCNlA+gv8rcHEXbk6squr7gomEfjpxZJnVZ/wGxUVvU5TTN3wtSnK
 reRSS095EC5CmPwU2CGfv2ULT6XmAryPDigFJmLoeAYmZInsm0IHLwk5bkyJpe9vIQOM
 GKoYXA+xdiHIefnh0QLAblElYe5Fn8RvHCqLPmA/aVhncNVwuyt9OY1/T4Oaao1AWQuW
 ZGuAbR5yahLNC5/KNDZVDOqhTtZJodfujgeCwABqEBLN3tMpNtxHtS9mMt7Xt5IJmWS1
 kywGr8jM7815ISeVvlqpsKdSVNTO7EmXq/yEkf5hIx0+c48PyBYmUQd4FkCfXEKPV8Vl
 x/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711549223; x=1712154023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=madbT/BaQjt9l0NAIRCdz4iExhKI7w/5+Gn0wJFqL2Y=;
 b=eMaUSLyjolCryQ1KYh6ybATCQ4TzO4t/Er39oHmn6kRLk8lColnpU++sqqQ3haG/65
 f1RmaaPxub+z++6aUOF9r+VQhMy7QMbsqS4dVTQDcCDU0dEDkIxsgViYZnGLQ3WMj4xF
 Xc9RSLKEgg2XCqz16TmtGvaG6VtP1XcY7Qg+rCXDgzgsP/yWXF9j8DBkislX2XadKQGR
 Oxwb5yOCDIJZfryx7ARjuga8ydAOGoPz2h5ur9Zh3Vw/mSS1DYs1DPhQf0/F5oSuXJGM
 MEGb6WtwL8Jbms13d7Y15iu9Y1dsLrhf0dqYXNAH3OgukZ/cKpZ1NWAL18vIRavwH2RV
 aoPQ==
X-Gm-Message-State: AOJu0YwHB5IlfA7bmvTpe6ZVNntO0+OuiWgCs1ioeiHCZVdQWPNc6it6
 x6D2jCvT1Q6Yfuhon/Dx8mpFuvGHcoZdsFcW/A514k1256JvVNhn6JVrDBDpf+rcu7t19VSwXJv
 8
X-Google-Smtp-Source: AGHT+IFVGNvmJBwhi+KNNR4XYUVaSsL2CWJJO3Tg7N8UrmSXSEvaQCSy1/bGq8FMprjdooOhAej4OQ==
X-Received: by 2002:a05:6a00:6711:b0:6ea:c7eb:59ff with SMTP id
 hm17-20020a056a00671100b006eac7eb59ffmr2030081pfb.28.1711549222988; 
 Wed, 27 Mar 2024 07:20:22 -0700 (PDT)
Received: from grind.. ([177.45.186.241]) by smtp.gmail.com with ESMTPSA id
 fa26-20020a056a002d1a00b006ea7b343877sm7891809pfb.9.2024.03.27.07.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 07:20:22 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v3 2/2] qtest/virtio-9p-test.c: remove g_test_slow()
 gate
Date: Wed, 27 Mar 2024 11:20:11 -0300
Message-ID: <20240327142011.805728-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327142011.805728-1-dbarboza@ventanamicro.com>
References: <20240327142011.805728-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42b.google.com
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

This problem ended up being fixed after it was detected with the
recently added risc-v machine nodes [1]. virtio-9p-test.c is now
creating and removing temporary dirs for each test run, instead of
creating a single dir for the entire qos-test scope.

We're now able to run these tests with 'make check' in the CI, so let's
go ahead and re-enable them.

This reverts commit 558f5c42efded3e0d0b20a90bce2a9a14580d824.

[1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/virtio-9p-test.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 0179b3a394..3c8cd235cf 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -746,15 +746,6 @@ static void register_virtio_9p_test(void)
 
 
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
     qos_add_test("local/create_dir", "virtio-9p", fs_create_dir, &opts);
-- 
2.44.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70DEC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6p2-00072H-Fn; Tue, 26 Mar 2024 09:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rp6ou-0006oT-Lk
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:26:29 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rp6os-0002XJ-3v
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:26:28 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e6082eab17so4203546b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711459580; x=1712064380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ka9NFSE33sd7QQnfjGucwwKtF99pg+u3ePlh0bct3o=;
 b=nsa00xZ9GLKZ9L5lSflrB8ke+VXCwmp/mRVwVDPiLZK2v3yXjRa0+BzV+fISKf4z3N
 zWs7mCriLx4ew9gZorzceB5TaDhkP4t/JepnvKK5fJBXs0x/RlIhJ4T8/nlqoZJhsw4t
 V8YgwgB/9OzU4SAVatvE/XkSvDT25b8ZDLeDUrPSTP++k8c9yg+sE9apajlaPVAiCGjG
 HULQDbqUbIVXRniNIVrHQNeHvAk4rLEk6lU67icAZ8OAMIwUOHih/SUSxkGnAoi5cSug
 Ezvj+4tTHB7XxEsDzEi3ELmLtk9okB03zlDME50VwCeLpRSEo14BJcUWYiyXmJawTdj5
 Zq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711459580; x=1712064380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ka9NFSE33sd7QQnfjGucwwKtF99pg+u3ePlh0bct3o=;
 b=k2+IHqpc6oZIbdS9n1BBnGNg0KSAykVVFbZ4p669Ksmp6e7fv4oI+L+1vZFgL8Vjng
 pu4yJaPqK4wnP7Z0pjvOH56KPY7TGMcpQhwu0UhxKB670i0W6v6cf/kkXQusCyQJo7H1
 b9rPUduW/Bb5JA7lh8QCl36k6jIvxeWKSkd8aP1dugB52P7a+dQ3xCnP/xfcCV34SrQH
 jVDBZy6QJQhbIM63V19THBoxVdlyoyZldFqqOmaMPXXE2l6WyGQ6mhRyXfTCDCYoebqq
 C/0W8513MsTV40imYypmIFL8ksZUFn19F76KDoAPZwqZtz9h0gvgJn8rWgITdw9dQfsa
 V4wA==
X-Gm-Message-State: AOJu0Yylvlgr164ZcJFRLZxsZ3BSY/tIylYZOFA7nSnYxY2CyCLin2a2
 qm6DCmK9Nw6zq40qLUoi7x4fJ3gmTsOjZbnN59gTWUfW84aMW4XVUBikY28ML3d1ND1q0NJ60rm
 q
X-Google-Smtp-Source: AGHT+IE2HgR9h3t4HmYyKYy19r4QOLfZ0ZPPV7Le0gye8GzUlo7vWfa6ROezPls2iKH7uRDu99dNUQ==
X-Received: by 2002:a05:6a00:2394:b0:6e7:1d01:334c with SMTP id
 f20-20020a056a00239400b006e71d01334cmr2669370pfc.2.1711459579899; 
 Tue, 26 Mar 2024 06:26:19 -0700 (PDT)
Received: from grind.. ([177.45.186.241]) by smtp.gmail.com with ESMTPSA id
 v10-20020aa799ca000000b006e9afb31e4bsm6080236pfi.12.2024.03.26.06.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 06:26:19 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 3/3] qtest/virtio-9p-test.c: remove g_test_slow() gate
Date: Tue, 26 Mar 2024 10:26:06 -0300
Message-ID: <20240326132606.686025-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326132606.686025-1-dbarboza@ventanamicro.com>
References: <20240326132606.686025-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
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
index 9938516fe7..ff69eb334a 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -687,15 +687,6 @@ static void register_virtio_9p_test(void)
 
 
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



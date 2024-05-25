Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D865CC25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 03:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAhqv-0006g4-5S; Fri, 24 May 2024 23:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAhqt-0006fR-Gn; Fri, 24 May 2024 23:13:47 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAhqr-0004pZ-Vm; Fri, 24 May 2024 23:13:47 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f6911d16b4so4538830b3a.3; 
 Fri, 24 May 2024 20:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716606824; x=1717211624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwPEk5rL1N4IcIYFt16Y4N39BZIy4DXLe+XVJQA7nDE=;
 b=H3cDOdCSGxT3UuadpwY8FXsvMgh1gu/+WH++jZ9W9QpAv6Mmlw1n81ModmMihm8VHk
 6w5qWFsFbBSCevk7W1H/PqgETw9FJS7PrTs/6vA96/L+uNJdEcT4LKsBWgsQGsxse/RJ
 afRJib6m4Pb19efHkiogkF08j1u+TW+BRGT9xm+F+1xCSF29HCdumK4cPrlClaDBPGnK
 v3dbp+jcjAsAJW6NsWGf637ciInRDex6Pc0hd7VcWybHHm9lEFrmzd/UJyRD+K33QjL8
 H+BiGjcbjspM+2NbEI1rVEx7nVKS4FEnSzVTOCQOyMPMDe0IYZyoraEKm94BQrZpxy5C
 Tp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716606824; x=1717211624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xwPEk5rL1N4IcIYFt16Y4N39BZIy4DXLe+XVJQA7nDE=;
 b=VurnTnpXtXiNfzUqRd+OiUvQi1kEsAz7A949lgUY81ZySQgy9cPS9ns+Yn0T+L986H
 WyoY2z57uk9ioYkbgE+mRfb255XReVDTUcrYK0r8JnBDrizYyO6YK5ueEdDD3wPd+CDX
 IKZ+ejGd4BOivIxAvH35KMA0UdoHZfGp3abW68Jcv42VNDP5TmrIy0c/+1pgSELu+EKU
 zJOKJbauJK3Hq+J9qyA8Cba3W+3IvNgl93C8JqfgYMaKqY/z068QitNmIEq2ZvBUN/1q
 E/+8SGjUiuYcoWBZMgDcgm+kWc1jV5xMBO+D2wGYu8B5VoSA0XAWyHcZo8n29PeB7VnW
 s7oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlbkydTZ9p8D0ibToBWLBu20lt2KLlf0/8TwZAmaN2P9UWeHabznv/i9a4X7VNTMGI3LGwk5Ojl6Hcz6lFXYBeRaPqPHrFBZrnaJb6ft2+gWXUX9X6Onld67E=
X-Gm-Message-State: AOJu0Yy1cBFbqTsRN7aSojQKXzlh4bv1p6Jsft+05s1ANOVy6DbWsu9h
 a8RCDxFCtOvN5Z0DprbqzlGN+nWUSxYfq0DiInGRR1ewVYUGCJyxozCJgg==
X-Google-Smtp-Source: AGHT+IGyyx7xYnqwGP45J/4F0tefpC2y8EA5HL5zKKwmbdbC6uG6S3LRQIC/EvEyA5QFprFmWXn2fg==
X-Received: by 2002:a05:6a00:8013:b0:6f3:f5e8:31f7 with SMTP id
 d2e1a72fcca58-6f8f2c71745mr4058477b3a.7.1716606824228; 
 Fri, 24 May 2024 20:13:44 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fc05a363sm1744306b3a.64.2024.05.24.20.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 20:13:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 2/3] tests/qtest/migration-test: Enable on ppc64
Date: Sat, 25 May 2024 13:13:28 +1000
Message-ID: <20240525031330.196609-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240525031330.196609-1-npiggin@gmail.com>
References: <20240525031330.196609-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

ppc64 with TCG seems to no longer be failing this test. Let's try to
enable it. s390x is still hanging about 1 in 10 runs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/migration-test.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index c13535c37d..b8617cc843 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3454,19 +3454,9 @@ int main(int argc, char **argv)
 #endif
 
     /*
-     * On ppc64, the test only works with kvm-hv, but not with kvm-pr and TCG
-     * is touchy due to race conditions on dirty bits (especially on PPC for
-     * some reason)
-     */
-    if (g_str_equal(arch, "ppc64") &&
-        (!has_kvm || access("/sys/module/kvm_hv", F_OK))) {
-        g_test_message("Skipping tests: kvm_hv not available");
-        goto test_add_done;
-    }
-
-    /*
-     * Similar to ppc64, s390x seems to be touchy with TCG, so disable it
-     * there until the problems are resolved
+     * On s390x, the test seems to be touchy with TCG, perhaps due to race
+     * conditions on dirty bits, so disable it there until the problems are
+     * resolved.
      */
     if (g_str_equal(arch, "s390x") && !has_kvm) {
         g_test_message("Skipping tests: s390x host with KVM is required");
-- 
2.43.0



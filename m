Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E61C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 23:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWOtK-0001u7-OX; Tue, 23 Jul 2024 19:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWOtG-0001tJ-8p
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:25:55 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWOtE-00073T-4M
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:25:53 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fc611a0f8cso3649175ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 16:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721777150; x=1722381950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TrboRlYsOao0nujSfq684rYB4Yz0DhtTuq11rQRcUno=;
 b=wNEuINhQJ8L1lQrWf+7UmqUe9a2UE4B4uTZ1VP2GKInum3LjF1BBtqFYf1AIlaRTeS
 upw0ES9v34vMT19BVtxJoAZH2EAoP217VKXSYdc3tLAuEGFDARBKPWKf4fta+Srnta+f
 ZzFfnpoPQPh5IpCOgmfcmER7fqY0PLs40Urde5RcgopbwfkVYEF7+5QGyF9OxHecSTao
 RTvziB1S8Pbn59rt33GRBFU0KKLYxLE8uCH59tValLyw509y6ZWpHbb2h1/Wqs7evU5H
 cSuXOCMikGnnRnfNI+ErHpiD3Ucbg6T0tP6KbYYPVn6ejZ17KuS4Ofw6Ev+dhDi9p/48
 fJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721777150; x=1722381950;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TrboRlYsOao0nujSfq684rYB4Yz0DhtTuq11rQRcUno=;
 b=d2jyV3ffNwfW7PYHtP1083S5W3KUfC7+ym+/aY79tI9NmnR4x4X66MlMGTqxrgx9gy
 A1/cfxDlMiEcRl4cGWHaQvMoYAMUyta6sfVpmqYTF3aPusCWW6LPr//aFsYOqusi7S4j
 MMABHWowanvv59SWOC9poMUhC8Mg3j4Q0J7KKOzIZRO7Ox2G7OB4sOll9NxeWLtjHUZV
 Q2Jicpkn7FyyUb0KvqQ2KMSLEYqm1GtNGOvZVq83/fyEhdXGZPpYZDdR8zeYJQaBwDoK
 bt3DqiQoRfmKQ8niSQVZLrrcUajMrim9mHcZ7BihHVmUe+xwWwRIvWT5qyRjlP9Gmiae
 OU9A==
X-Gm-Message-State: AOJu0YyOyljOci98Jnb0rK7s455iPWqq/DYpJBXnN2aPILeO0E7wFl0R
 4mo/cVHTfNefoew35zuVELjmx6O5rDcy98d14DDSgwxrIPdB6hb7ljj+rXerurmSCq2jPmWb4nG
 TY665CA==
X-Google-Smtp-Source: AGHT+IFeeawvA79X7kbN0qoQjZ8B9jeENRGVen5fGhsngBZlK/mwlbCF7+XunUEDToLsrnCccoDS3w==
X-Received: by 2002:a17:903:40c2:b0:1fd:510a:3096 with SMTP id
 d9443c01a7336-1fd74676cb6mr82694315ad.62.1721777149964; 
 Tue, 23 Jul 2024 16:25:49 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f31a3ecsm80799405ad.177.2024.07.23.16.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 16:25:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH] gitlab-ci: Use -fno-sanitize=function in the clang-user job
Date: Wed, 24 Jul 2024 09:25:42 +1000
Message-ID: <20240723232543.18093-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

With -fsanitize=undefined, which implies -fsanitize=function,
clang will add a "type signature" before functions.
It accesses funcptr-8 and funcptr-4 to do so.

The generated TCG prologue is directly on a page boundary,
so these accesses segfault.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Does anyone know why we're using --extra-cflags for the clang-user
and clang-system jobs, as opposed to --enable-sanitizers?  It
certainly seems like regular users who use the normal configure
flag are going to run into this as well.

Anyway, this is why the clang-user job is failing at the momemnt.
I can only assume that changes to our docker file, or upstream
distro updates have pulled in a new compiler version, because this
wasn't failing in this way last week.


r~

---
 .gitlab-ci.d/buildtest.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index e3a0758bd9..aa32782405 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -444,6 +444,7 @@ clang-user:
     CONFIGURE_ARGS: --cc=clang --cxx=clang++ --disable-system
       --target-list-exclude=alpha-linux-user,microblazeel-linux-user,aarch64_be-linux-user,i386-linux-user,m68k-linux-user,mipsn32el-linux-user,xtensaeb-linux-user
       --extra-cflags=-fsanitize=undefined --extra-cflags=-fno-sanitize-recover=undefined
+      --extra-cflags=-fno-sanitize=function
     MAKE_CHECK_ARGS: check-unit check-tcg
 
 # Set LD_JOBS=1 because this requires LTO and ld consumes a large amount of memory.
-- 
2.43.0



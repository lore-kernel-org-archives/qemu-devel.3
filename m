Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B3FEDE9B0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4pb-0004mH-IN; Tue, 10 Sep 2024 13:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pW-0004iD-DM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:06 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pU-0004Yu-LO
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:06 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c26852aff1so6797927a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725989943; x=1726594743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nL+5j3KYtdxOCvyuGBLquGt4laEVHE2D17hxCL7BaSA=;
 b=wgbl8zWfQ2ip0louKbCujN541fUQhMapdwR42a8xVkI1RmKH0ax9DigyBSvKg8oCDS
 Ez60UQExM4xsaUSGxM0oNtig6lHePv9cZG0THV30QuZtFOON4c/UyARWYJr8mVq4TqiP
 gVVmQ/FA/rmBM2pnDEPyW8LHrUljUcj4O5//k17gTL7ujFbYjkTRQvIrP4bP8+KyfR6m
 6i86Oq5nzm6ejo+QNYpOY7uOKYmOoO1Jvyx4AZgwlV23f89lHBGpZZO8WrVa1GD9iZyW
 vDuhdLiUa2HYiB2tKPLBL+8OZua7BfFyqd7ijI33eenUaMx8QTXdEey9wooFo3nPNhqp
 9ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725989943; x=1726594743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nL+5j3KYtdxOCvyuGBLquGt4laEVHE2D17hxCL7BaSA=;
 b=MuAXQnw7y+z4Fuw12cEGCJWTq3HA6Vs8zyRLS2As4ZJ9p8JL8pGj4UCcqPDT6dkbWK
 b1Eu2xpMF0chlOm7fyMhVM6mwR+ga8YYjAm/OfzZlv7m7ZH5ZvMiaSalVlykUg3FnQfZ
 6n0rCF1shABiXS5Lc9ageNmR+JyNxeV7rM6OLgtI446QqM+AGpB1z8ZPY3TK9HrfzG3x
 GQt58pc+/fuFhdy9KgkCj6YPae7zb05ppXepORJ+uHiABCP5ooQIUzYGs8ai2G3vt6hP
 75VzrlRdsZFSuGNe5ZDZnie5C2thQbT5tHObh1msCl0i68Eo3m1ugj6Bu1/SwzGoijel
 q6Jg==
X-Gm-Message-State: AOJu0YxcUYvQnUK3ClGdjYe5s/LOVR72QLrrk4zmiBzaUS9MXjfonxyv
 z5UUyKSJ1OtDK4qmkVh5wtZ93i+90gcBqUdyjMi+eIeleeaf6wAVGxY3hKAVDss=
X-Google-Smtp-Source: AGHT+IFb5qWQFky2KBuxH+J7nhBtTftWNhiPNJhITTQsDLJazgFRriqeBjGZzCFoWs/APZW6aaPb+g==
X-Received: by 2002:a17:907:268e:b0:a86:8953:e1fe with SMTP id
 a640c23a62f3a-a8ffadf3c37mr155638566b.47.1725989941865; 
 Tue, 10 Sep 2024 10:39:01 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ced20csm510791366b.172.2024.09.10.10.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:39:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B33C05F86D;
 Tue, 10 Sep 2024 18:39:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v2 03/10] tests/docker: use debian-all-test-cross for mips64el
 tests
Date: Tue, 10 Sep 2024 18:38:53 +0100
Message-Id: <20240910173900.4154726-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910173900.4154726-1-alex.bennee@linaro.org>
References: <20240910173900.4154726-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

While the mips64el cross compilation environment is busted in Debian
we can use the debian-all-test-cross image for building TCG tests like
we do in the CI.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index d08b71f14b..39a284ddfe 100755
--- a/configure
+++ b/configure
@@ -1328,7 +1328,7 @@ probe_target_compiler() {
         container_cross_prefix=microblaze-linux-musl-
         ;;
       mips64el)
-        container_image=debian-mips64el-cross
+        container_image=debian-all-test-cross
         container_cross_prefix=mips64el-linux-gnuabi64-
         ;;
       tricore)
-- 
2.39.2



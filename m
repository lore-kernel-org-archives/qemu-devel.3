Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92099CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8SR-0004aL-L2; Wed, 29 Oct 2025 11:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8SG-0004MC-Rs
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:21 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S0-0002uD-Gg
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:20 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6399328ff1fso12650467a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753060; x=1762357860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0oKZMPUxXOHcd3Nkbe0wu3ZFt70OnkgenyYFKHZZPE=;
 b=D0b30bfyGZ9u9jcGTfetc123EXHvmdcoc8O+OfNus57q6Le80A/HOdj/s/wH2gBlDC
 5gEhZkNUXjre/wJJgxZplnl9xqedZaTCXlfGUbaHd9N/NUxHMOJVgui8AKSZyfOFQxM8
 NFIpE0PZShhMJ4UIC87rtvsiGadARDHy/GY5NktqEwJhxOSuNJYfWZrzQVj5dRmGo1lp
 MMnGC68F5cDe8edx01Dy5zJwo0o6V6hzXsXaErVIQuZDR3awLdz4mxosgddFDBuCowyu
 0ZiUsJ9gYbdlYIBfErRIkNJHje9jfsW9f34wKCYQQO9pDgTO+pBQTwnNUz93DEJ5dx7q
 1W3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753060; x=1762357860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p0oKZMPUxXOHcd3Nkbe0wu3ZFt70OnkgenyYFKHZZPE=;
 b=CYvf6LBXt6Ux0vdjjtUUx/jvX9tnf4c0JSv0xbpj0nkbWosaMVvwbV5lXWDLLm31WX
 ukxvItOv/FcjzCstGU5aP/1eHFGa5Jb+R/4XWsje/Udw3N9YudjNDZRXKS7llt0EjtW3
 YomgUJOhVvUVZ5QPUX/666zsh0nsSdNHs8jxsf7XhiNNB1whLGnN/nsiQ4Flu82e/oGE
 U8hZF5GFAk7DkxuzXRSb9uHtTKNDKc4LIhQnxqXK7bvliGHItrlam/k+3cWoLWBSvn4C
 Z5Hr2fXzb80EkYmgo1dEX+j7c1yL9lDVN2etwkLLPWPnZSETwbC1i7amMDHs/5eeXsbq
 5cGA==
X-Gm-Message-State: AOJu0YwVGqkOv7AqnnWGaQzQnuEhrZULciuJKhNL3HOKJMFUJUYzVtnm
 CHfAMapToboaLS7n/KfbecW873VTeVBe3mN8qyN93kygyxKs/4bFjZhPO6pc9b+nJ+Y=
X-Gm-Gg: ASbGncupB2ELqCDVkhCh3nkwF1VnDrSn9Lq2YB4W3cLphcQCTSQiBorOiU2PnKnxfBA
 cwaQmFlIkfyuM+bqcMN+56ieT0NZKG4dwNqNXv/FM1FJIoo9rQRKf7eR8OQBNAhtl8IAnpaYLy3
 dU96DU6iJ+zNG385NL9fl7t22hCS2y9u3s6Rd8yMSi6dbMVJfbUuaiITDLYKd4lqsLDElgSPpOl
 C56JBWlfW9fvHiDCTfj9sUR79ckbUTq7qJovnKBtGMWJ1IvJ2fyd3vn63PQvU9WOOT7wnzN5C/R
 hVIjdjT4ibww+/xTFo6sIkAcZTRack3xx6VO3YXsEPgah3jQTwpGpF9trn7zdT+pxwaj5+Zwi4q
 7bbgF3H+DiGTeSH+QZzybexPOXN08mYOJBj+Sjx+N7SV47iwb0Xaop96bKYKt9BuBI6vI3rUjkk
 xF
X-Google-Smtp-Source: AGHT+IGKuvBhEy79VuHblpKUso6vTyb7NAr8KP1H2BIiVsfZaD/Sv0DWtN6XfpJUP4uskjc0ivVjEg==
X-Received: by 2002:a17:907:94c9:b0:b3e:babd:f257 with SMTP id
 a640c23a62f3a-b703d2e3f5amr385537866b.10.1761753059621; 
 Wed, 29 Oct 2025 08:50:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85445d48sm1452505566b.65.2025.10.29.08.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2319E6150B;
 Wed, 29 Oct 2025 15:50:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 33/35] configs: drop SBSA_REF from minimal specification
Date: Wed, 29 Oct 2025 15:50:42 +0000
Message-ID: <20251029155045.257802-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

The whole point of SBSA_REF is for testing firmware which by
definition requires TCG. This means the configuration of:

  --disable-tcg --with-devices-aarch64=minimal

makes no sense (and indeed is broken for the
ubuntu-24.04-aarch64-notcg) test. Drop it from minimal and remove the
allow_failure from the test case.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251027110344.2289945-34-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/configs/devices/aarch64-softmmu/minimal.mak b/configs/devices/aarch64-softmmu/minimal.mak
index 0ebc1dca561..3c8582e12cc 100644
--- a/configs/devices/aarch64-softmmu/minimal.mak
+++ b/configs/devices/aarch64-softmmu/minimal.mak
@@ -6,4 +6,3 @@
 #
 
 CONFIG_ARM_VIRT=y
-CONFIG_SBSA_REF=y
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
index 46db9ae0138..ee13587d99e 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
@@ -107,7 +107,5 @@ ubuntu-24.04-aarch64-notcg:
   rules:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
       when: manual
-      allow_failure: true
     - if: "$AARCH64_RUNNER_AVAILABLE"
       when: manual
-      allow_failure: true
-- 
2.47.3



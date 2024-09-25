Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DD0CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 17:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stVYT-0000MP-Tr; Wed, 25 Sep 2024 13:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYL-0000Ix-7W
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYJ-0000bG-9W
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:48 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42e7b7bef42so146135e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727284303; x=1727889103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nULHsaLuBuujYUxGLl/yUjxpzYZCDveoFrPVw941m7Y=;
 b=dzRGTvWcNv9RjcdRDMFMPAsy48smb0H9FKAPk9C1Y28uFsjSdbMFUOdZC1k9Z+HKx5
 0efMBKjBjjrlxp9w5qSWAs/wH3GNS7BXvv1NH6t8jlLIDuYv+ENeJtoS1ivnrbJ9lcwf
 2BuwzEEw+wI9Ma+vCXbJMvxwspSfxfkSQqaXJuyYqQFepR/TL3IlF3ApMi55tuPB8jIV
 i9SeQymripEtxv9C09Lw5Uma7gQSYHrFWGgsD1gZuZyM9ZJJbERoSvtmdQg8XEVoK/6h
 1Z9Rf+Aqp0Ni3VlEKJyqmwtDkmX7GT2hTKtEgh55FGQ/PyhlNX387wNgyX3WsGLmYFCN
 btIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727284303; x=1727889103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nULHsaLuBuujYUxGLl/yUjxpzYZCDveoFrPVw941m7Y=;
 b=hPpbCnZRu7WQHkbO1i7EyCFFPMKO+hx+uJPBba8eaATF4tBIdB8iXw/nYr5m8I7sKv
 0V0STVA/LZpTdMwYmOfUykjxqzYK+rCGRQPqNJwUtpaj/hbpCfdpZ5Cr4q8pRGFozH/h
 TUUsTqBj1Ygw9Vc5ZKdF/jo36eZtw1BVGrI/ZlXwAv69S8pNtP0Ssj4IELSqggrxdK/N
 3O0tz4Pm46rtm3YPU4u20omx/EX9m92aZjoM9cTU3AFlFDvgZfF/Y/zPbPaiwsl9cf36
 zJNgn09EpTtZ9tmDLl4P5gVKtgsAOlAGsQjMNWhyGbqM/0IyTb/FQTSkATFgtFpszQAn
 56Hg==
X-Gm-Message-State: AOJu0YzcUN/m17fOZJILEY/B/WmTREb/YGn8MdwdBwNiqUr2uNbS3e4I
 iXbLS2nqBqs5dlnK6MUAGvkViSepUt48rsJsawz+X6wypYTQkJpFaKNwcCSJB9g=
X-Google-Smtp-Source: AGHT+IEORzqVBB16eZ00Qj5TJ8YpgmN6tE1vpCu+cktnO6IgKyCPHtWZVud/qUVLpXrUdIz4Dy+68Q==
X-Received: by 2002:adf:fa41:0:b0:368:4910:8f49 with SMTP id
 ffacd0b85a97d-37cc246b405mr2347263f8f.12.1727284303257; 
 Wed, 25 Sep 2024 10:11:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc3187a4sm4466876f8f.90.2024.09.25.10.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:11:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B47BE5FA12;
 Wed, 25 Sep 2024 18:11:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, kvm@vger.kernel.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 04/10] MAINTAINERS: mention my testing/next tree
Date: Wed, 25 Sep 2024 18:11:34 +0100
Message-Id: <20240925171140.1307033-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240925171140.1307033-1-alex.bennee@linaro.org>
References: <20240925171140.1307033-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

I put it under my name as there may be other maintainer testing trees
as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffacd60f40..7ac2252303 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4114,6 +4114,7 @@ Build and test automation
 -------------------------
 Build and test automation, general continuous integration
 M: Alex Bennée <alex.bennee@linaro.org>
+T: git https://gitlab.com/stsquad/qemu testing/next
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 M: Thomas Huth <thuth@redhat.com>
 R: Wainer dos Santos Moschetta <wainersm@redhat.com>
-- 
2.39.5



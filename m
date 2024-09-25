Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C829CCF9E7
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 17:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stVYp-0001pM-RJ; Wed, 25 Sep 2024 13:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYR-0000L0-Vi
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:57 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYO-0000dZ-3n
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42e748f78d6so333865e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727284310; x=1727889110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nfK3IifqQwqKch4WY/r8cAsLiv59o8B10mtnbYAB2U8=;
 b=KVVNeOwTG5nJvIwPe+i4B/RCcHej5+x8ao0myo7jDLfe01eFTxXrC4HJxExiRC+fEe
 EuXY/09zvfMc2IIconhlcegMqUFJMMtNNGma8y0D3oMs6RmWZg//ooh7kfMrTSy0Z6le
 JXUu5eEiljh1g1tFIb8RU1Y2J3M11BrMcuf+Ix1J3hQYNy5/yRh1UJr3KyGC0DVSekaf
 pn9u65wrv2vJEmJ5/hekWhwJ4vOqzUrqgcs5LQX5Tm02BXdhNjKt6326dMYBZLkHyxgO
 WUfCUTO7SOi91DypG7jZnT+gEPWS38/JHnY2+Q8j4QKtKzhB9A/s3NUpCqz2vrTtfmEs
 fE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727284310; x=1727889110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfK3IifqQwqKch4WY/r8cAsLiv59o8B10mtnbYAB2U8=;
 b=OydAXuWDTwO6LD8t9XzB7WicYsRz2CF9EU8YGz4GYTXZr7D5nTONRuTLyTmzWWvp+6
 3gsU0Qe889EMg5TldMKSCzE5n9WpSeNqsuvfNW+pttXwjzOOKeJSvT8HEc5AscFs2+/4
 lWMrwbtK1S4C/gtpb0YMPndz5/Nd2KsxFwtqZUao6WZFrz3cenPZj80gjiJiZe/uEqao
 UCOIj8DooPTp0ODCLdMesbOSTxPTELd4MAgrR1tcnMyXMnXk9f/QhEO2JcBU4L7UwtRD
 6VY+N770Wnd98wTJbjI2OChF7E8axfFz9H3W/HHD6hMcS1dmcJK4f1MeDkfU219wmL1r
 +hmQ==
X-Gm-Message-State: AOJu0YwyW36NNvinWpofEKHjrgVvhncpQz2QuK3LIwqxMR4AyLnpkUkw
 sAuZWlmQIlWKYj+/t3qIE2H8QsaPGvjgFmeknEufkHJmfSpQR6VheAc81Mm8HUs=
X-Google-Smtp-Source: AGHT+IGD3jF88KfAngOylDc8CVhYjnNX1NcQOwwW95cwuwuTfBIj06W2PgowxTm83aXeaqFntp0hUQ==
X-Received: by 2002:a05:600c:45ce:b0:42b:af1c:66e with SMTP id
 5b1f17b1804b1-42e9610c1c6mr23225565e9.9.1727284310137; 
 Wed, 25 Sep 2024 10:11:50 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969feb45sm23955035e9.20.2024.09.25.10.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:11:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 345F15FA8E;
 Wed, 25 Sep 2024 18:11:41 +0100 (BST)
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
Subject: [PATCH 09/10] config/targets: update aarch64_be-linux-user gdb XML
 list
Date: Wed, 25 Sep 2024 18:11:39 +0100
Message-Id: <20240925171140.1307033-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240925171140.1307033-1-alex.bennee@linaro.org>
References: <20240925171140.1307033-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Attempting to run the binary asserts when it can't find the XML entry.
We can fix it so we don't although I suspect other stuff is broken.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2580
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configs/targets/aarch64_be-linux-user.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/targets/aarch64_be-linux-user.mak b/configs/targets/aarch64_be-linux-user.mak
index acb5620cdb..14623ac076 100644
--- a/configs/targets/aarch64_be-linux-user.mak
+++ b/configs/targets/aarch64_be-linux-user.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
-- 
2.39.5



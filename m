Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAF4CDDE70
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 11:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Zd9-0007Ia-O0; Wed, 23 Oct 2024 07:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Zd7-0007Fu-FS
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:34:21 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Zd4-00037u-B5
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:34:21 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a0c40849cso1027401766b.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 04:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729683256; x=1730288056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F14s2fuGgke3fc+cUXWbJXkLt5Skh4xTYd/t6sQdYbY=;
 b=opO1NYF75BCF5psXILq+pIVtZdfMuPaNRwfMnc4fVpT6O4lwn84I1yeNp7HKzm0UK2
 Z14F94YppJjB1zBZ3i8jk87B0rUnvYGS5GxpjP6Ev3ra2q2BXOTJJy0DT0NOlRme0RLt
 eVs3gO1BoTibUG5IAb3kUGUCk68x6fBu/9XmmYAC+E+iY6ABvBPbPm7KasTxEletmL/9
 lXO7/Nd07KdPv/iPN2rhs1EXlFEhQyKyRnnDL96XBbVPgarBP6R+VOuyV2e3R2SSOEk8
 Pss37qfaXGvcS9PtouDwx41Xl6sB/RU34DVOkO28CVyJ9O6SqS2jCc8kDjTH+9w6LTMd
 r18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729683256; x=1730288056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F14s2fuGgke3fc+cUXWbJXkLt5Skh4xTYd/t6sQdYbY=;
 b=ef6gEdLGLBt5we/R8QE2/25Q+/D/Abb55QhJTsp7MnsTE0+k4CfMJOjMVAdRSue/Ku
 M/Ms4LQ/yxiZ07ozmCl85PLVBgWhLzcuj0R8A0Bm0hgJU5V8ZtT/H/Tr42hgVymCt6hC
 NyX2FKvMEQGdrkNF8t7XH/O/6K0rngeW2I8j1VBVL47rOCwxwjMK1LbU5I/bmG5+VOSM
 EcWCf9WyWIA7loWNCUaBclO4gN7ud+ICq3zPaQQepyyDJwu7pCWpuEefwvp7ig6yQBaZ
 9FCyxyX33RF3g6WUozI4yFx+II0hqfD7XPug6Iru9Qtv+2GDgKWJokGBr49sMQdZCEcZ
 EC0A==
X-Gm-Message-State: AOJu0YzHGUK7hLYjKgMX++yFuv60VK9GaQmICZQVFRfna0ra9X/QWCv5
 ckwqHfawi3zcp2kcqYtqiE5yDSwl5WE2xWRuO30uB+YJolgmno5I3zdwuc+YW7Q=
X-Google-Smtp-Source: AGHT+IGGBc55QM3qFCMBExtGsk6ICJf3Ug5DueFxLCCWUUU5RTVe6iZgYe//4a3K0VY6A0U2IduvZw==
X-Received: by 2002:a17:907:97cb:b0:a99:fff3:2eb0 with SMTP id
 a640c23a62f3a-a9abf92cf40mr200716666b.40.1729683256020; 
 Wed, 23 Oct 2024 04:34:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91559f15sm463603866b.133.2024.10.23.04.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 04:34:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 84B6C5F925;
 Wed, 23 Oct 2024 12:34:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 06/18] scripts/ci: remove architecture checks for
 build-environment updates
Date: Wed, 23 Oct 2024 12:33:54 +0100
Message-Id: <20241023113406.1284676-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023113406.1284676-1-alex.bennee@linaro.org>
References: <20241023113406.1284676-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

We were missing s390x here. There isn't much point testing for the
architecture here as we will fail anyway if the appropriate package
list is missing.

Message-Id: <20241022105614.839199-7-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/ci/setup/ubuntu/build-environment.yml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/ci/setup/ubuntu/build-environment.yml b/scripts/ci/setup/ubuntu/build-environment.yml
index edf1900b3e..56b51609e3 100644
--- a/scripts/ci/setup/ubuntu/build-environment.yml
+++ b/scripts/ci/setup/ubuntu/build-environment.yml
@@ -39,7 +39,6 @@
       when:
         - ansible_facts['distribution'] == 'Ubuntu'
         - ansible_facts['distribution_version'] == '22.04'
-        - ansible_facts['architecture'] == 'aarch64' or ansible_facts['architecture'] == 'x86_64'
 
     - name: Install packages for QEMU on Ubuntu 22.04
       package:
@@ -47,7 +46,6 @@
       when:
         - ansible_facts['distribution'] == 'Ubuntu'
         - ansible_facts['distribution_version'] == '22.04'
-        - ansible_facts['architecture'] == 'aarch64' or ansible_facts['architecture'] == 'x86_64'
 
     - name: Install armhf cross-compile packages to build QEMU on AArch64 Ubuntu 22.04
       package:
-- 
2.39.5



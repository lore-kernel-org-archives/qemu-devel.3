Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1678D1CDDC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CYu-0001ko-AZ; Tue, 22 Oct 2024 06:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYr-0001iu-9x
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYn-0001zD-Mp
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:23 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so5282435f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729594580; x=1730199380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=COTB8IX9EL+KvqwMSRlZ5WoxH3jy7uQtMVM8wKCP4/g=;
 b=p5QDVz2phnPTmjsR8vP3N8UTNsE13QMvswISY9BpX1bQaDAblHt4BCdZtT6Cv2WQ7A
 oTPI8I01negcTy0m+2Tc1qsp4LRw5vRYMutdmZWaTtoA8KpSJV1ccdG/xx2nXvjY8MQ8
 mn23sgJtJO+VNEhTp3927ksS0ecs2Fw7ZXCKJh88KYFWfm3iaGHAJVC6n3GAFAWCufVc
 LDqOMeo5Rd64qynMPDK1xVf8sHQpA9xy5VOUVhoXvLZeBcckOPfiPLqX5qXKcudkGpkS
 Ib1IFjJngGgK7uixVsVeFfVz28t+xNmealp9UyzdiqyooljmXx+ZKjaeUuhKPPIDbpFK
 zP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729594580; x=1730199380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=COTB8IX9EL+KvqwMSRlZ5WoxH3jy7uQtMVM8wKCP4/g=;
 b=QetDPlQXhfNs7S6O4CaR8azXG0eT0WjbfbUrF45j0avnJH8RaoTV8uT7g50b94gRpj
 rMvWorJm+nO9IPVlvGE+sOKfC7jtYGlMPIBkjHDfwStxtMdvoWf3ZQvChfGK5IygoD57
 3R3xG03nmxVjTC+HI76H5j5WAe2Leh804l1Q5g954MuyQ2/cJ9yH38XbGDlfElKNMO7G
 PUgZPQ9dpJJVCX4Jfv9y8VYBHKT6GekfU4HqSg/mr3fBmjethU3eDFB1PB3hZOWIozwa
 aOzABYwAqbO+nisCJgB8r7MqqBrv1lYp5qYclQaNyFdpMjJ+q9zvGw6k14AFlLR03YSh
 DsUQ==
X-Gm-Message-State: AOJu0YwPR/2txG3QkdQWRnSvN63LGOchU/tdNAPurh+BOCelPD6R9rus
 yS5KNfLBWOSEFBRP80DUf6mgrUysKxMQTja6BEHzSr7ibw74Hxo0MV4AZH2PgX8=
X-Google-Smtp-Source: AGHT+IF8gTYNUNEInBLeGzU/PWN6iK1a20tMenTDraAJtih3b9OaMANLgGCpLzqKTnRdNaK+s8hEig==
X-Received: by 2002:a5d:424c:0:b0:37d:51b7:5e08 with SMTP id
 ffacd0b85a97d-37ea21d8fbdmr11273338f8f.18.1729594580178; 
 Tue, 22 Oct 2024 03:56:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91307874sm323980966b.94.2024.10.22.03.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:56:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2F1E35F92E;
 Tue, 22 Oct 2024 11:56:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, devel@lists.libvirt.org,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 06/20] scripts/ci: remove architecture checks for
 build-environment updates
Date: Tue, 22 Oct 2024 11:56:00 +0100
Message-Id: <20241022105614.839199-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022105614.839199-1-alex.bennee@linaro.org>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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



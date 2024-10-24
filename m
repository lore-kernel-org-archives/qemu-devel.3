Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AD1CDDE6A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3uZq-0001AW-7h; Thu, 24 Oct 2024 05:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZh-00017q-BP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:15 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZf-0003mr-Pr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:13 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9a628b68a7so104777366b.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729763768; x=1730368568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1eumqy3h/5b4LE5b3DAzQ7GuSzOPVfRg6wnoYa9yiE=;
 b=L3mPNGEbQYtJmA4WvyeWfTc30HYhrNzmr45+we6l4UB25MbKbsL/wbKxtHhjSlOcEi
 hKgZiIS6YiOGrl3PHssFrn+8L1b8YiXu41PT1ilMzavv1nsmptusilJgI4P5VWlV629d
 T1jaM+N6xVng/B/yOfJyVagls3CEx7NTlWPCbSmhHNWShNiALKpHHLLjgShHukHtFZg7
 uIv4QSR9y2k+Uepxf4WUzDu8aUu8bnpY3RSzPf55EqEK4tQ9MLodUqxFc6bYeNea2vaH
 73gC5oNpKOJHXdsu03Kf7o/l3Dt5mgOModRAj1gje71ZxlOasEQ73SNZnyljXQO75Tqn
 u9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729763768; x=1730368568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1eumqy3h/5b4LE5b3DAzQ7GuSzOPVfRg6wnoYa9yiE=;
 b=Ui5BXfgAmjlokoUq6plXps4YzcJDkXIKXj9kCYN3ivxuOinenvWkZES33Z/8St8Xrz
 dd0M9UjZj60JyCUUaZ3Kgt540cZYjYqYBlGslrla13/K4GVYBYM06pnm4/6jZf7/Il5j
 8Jn0lWG+H+D+UokLaDKAluzoGxaTEmeKiFl+9e+PUbSoz1P5KSd1c9EWlphJ2/x8Ia32
 +C3quVhEQY2edHEeDc5H70Rj8uJOnPF3Tjqjv0LHijLgjsVbo8xeZaZpwL72pItVbfPl
 av0TEDluw/OmrOz+Pe7NIoYPH73ZRdEWDev7x5D7gnoqkSU8+DYXJgnb6auBdvMOm15o
 NOfA==
X-Gm-Message-State: AOJu0YwZqFZGBHNr2x3XPkA85RdmkS93/BCaFsyDTT/IPDj+94l51iCy
 OViDm2WA4t6xVJuJu0ciDXLgkwsjM6GdCXOvMXDnlG8FAt8Bf9vsN1NEBiFcbZE=
X-Google-Smtp-Source: AGHT+IF+lY7005x5dQ/iX9CFmRlF58PSCa65ez4p6JHJVbueoM5TIursVEXyTNthXx5cdVwyQvl1Xg==
X-Received: by 2002:a17:907:869f:b0:a9a:4ff6:44c0 with SMTP id
 a640c23a62f3a-a9abf94d4f7mr548883466b.49.1729763768557; 
 Thu, 24 Oct 2024 02:56:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a9159a214sm596616066b.213.2024.10.24.02.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 02:56:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 89CF75F925;
 Thu, 24 Oct 2024 10:56:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PULL 06/17] scripts/ci: remove architecture checks for
 build-environment updates
Date: Thu, 24 Oct 2024 10:55:52 +0100
Message-Id: <20241024095603.1813285-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-7-alex.bennee@linaro.org>

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



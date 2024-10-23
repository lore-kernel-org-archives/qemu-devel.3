Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2DACDDE70
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 11:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ZdC-0007Kd-Aw; Wed, 23 Oct 2024 07:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Zd2-0007DK-Qo
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:34:16 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Zcy-00034J-3H
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:34:16 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cb72918bddso3627071a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729683249; x=1730288049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFUfe3R/gzmi/FEpNAJD4C8KljhahEoI2QawPam7H0s=;
 b=reHHUfyacE0ijQhkTPS/sYb4u2eEui30zOQBkWbcmAEylOthzA3oCTKoT4MwKMoZN1
 0wJ3JFYhxNxYfIpjzLiQBvikXMbuHHWLunM29ewGXqhmV70c6aX+yqxwBIb2ZfcFwTcb
 eFpNUSYP841CRz8Zxt7eNWQAsxLNgtS4HYAhYq3jHHUTxxZe4oOCI4V6KXFZ08KPllRl
 i4TpH/KcmeQHEiWLGJXVI4x+D4yrEm08ksEAuUQ06z99CGUnfKOn/n2+hPZPraTK5jwJ
 j2y5BR3+BUCQ3s+uS5x7pxk7StmxGXhcVllKdOlcG6YMKLjGeFZsNmlF5+eiXGFzEqxy
 8fHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729683249; x=1730288049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFUfe3R/gzmi/FEpNAJD4C8KljhahEoI2QawPam7H0s=;
 b=bmWSozZJUN1xV34tnJ585aDa141kF/yY4Ut+qvzLdVjSUWUDMDr3sId4fqrxSSLrRY
 yvBp+y/GZqzCFMutx7Pf4/SVogmbA9Df/JG9BTVEcBnoKc3J/Phdmpv2Xb4E6mPEN48q
 Wfw2cGoxGR1lEipdiBZACMOtye4bSlpIaxEGpIza3QQJVurcFnKKOJyRNHF7NAmZHqAE
 63im/8/AEAaIZ1wj7zYoIdUKRKrIlouT1ecE6uN4SEev2Enkj7Cex7JPzmu4ObW5+a6t
 tzIHonHfjZ9+haEzbmK9eOBZou0Q3Vh7PHS/bIEaYgtTmMa1ZfbTQuyRYynlP8hS7zCm
 Lu8Q==
X-Gm-Message-State: AOJu0Yxty4i5sab/TMT3V8YZyAWudu5osMPDYrdzzZWPy3BqQKaLWEEu
 aRGeDMJDFWRC/Z07lg3qWTBkzOCVWhSangJFnj/ZQi5EB8cgUwFzL+w491usSpY=
X-Google-Smtp-Source: AGHT+IEqCO9Z86Wc/aD7cMGoDZdsv2MH3Z+EHGDa18MN1P+gR4QtHe2kA90fKoFdnetpV6XOEyKMNg==
X-Received: by 2002:a05:6402:2791:b0:5cb:666e:9f8c with SMTP id
 4fb4d7f45d1cf-5cb8af97d8bmr1943092a12.32.1729683248995; 
 Wed, 23 Oct 2024 04:34:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a65451sm4275667a12.27.2024.10.23.04.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 04:34:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3EC7A5F8CC;
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
Subject: [PATCH v3 03/18] MAINTAINERS: mention my testing/next tree
Date: Wed, 23 Oct 2024 12:33:51 +0100
Message-Id: <20241023113406.1284676-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023113406.1284676-1-alex.bennee@linaro.org>
References: <20241023113406.1284676-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Message-Id: <20241022105614.839199-4-alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3bfa132fd..ef1678a1a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4080,6 +4080,7 @@ Build and test automation
 -------------------------
 Build and test automation, general continuous integration
 M: Alex Bennée <alex.bennee@linaro.org>
+T: git https://gitlab.com/stsquad/qemu testing/next
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 M: Thomas Huth <thuth@redhat.com>
 R: Wainer dos Santos Moschetta <wainersm@redhat.com>
-- 
2.39.5



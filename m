Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CB4C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 20:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7LAI-0001CJ-60; Wed, 15 May 2024 16:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LA8-00013Q-NG
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:45 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LA4-0004Ey-0E
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:43 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-51f12ccff5eso10104825e87.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715804618; x=1716409418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbcgIcqXtk7G1PsTV4EtZsTodpxwHHHpdRJmOVPcreo=;
 b=vvZ8+zPbaKqUTBUezqYfgZNYEEw4lCGRn//NcUSqqRC8FSY3VWhqm+9+bTHXMHeS4c
 N49QLDtAhf7CvWzreH8NS3JJdeuCfXEU0gOunYb31SlG9k6Bdq/SzC0lUDaqcmybLkL2
 bExhzdclEuMlkqvJy/JRpLGrtEmPUvWGaP+t0A0tTPrfIFGVC35j4D5H0OgG8H39HuEW
 8chD73/zA/oC20YPlLPz/MewZ1Jmo173BZZnTl+WpyBMt1PHPlUzeBsatBnaf/f2z9nP
 fLUdDK93MagI6MmstPjlbr0SrZcTxibfIktdb5nyYMm4nSFukTY7ZkZdN9Jup2mAyA92
 w4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715804618; x=1716409418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbcgIcqXtk7G1PsTV4EtZsTodpxwHHHpdRJmOVPcreo=;
 b=OnuNU6YhfnbyWo3vRUdhA8VinZ2mssaJqdKCx6z4zOw6u5sNWERWKufWduNMqp18Jb
 5KCkjDswgKWyqDHB0J2P8NXmcTaCL7VIpx18yLvVpBK8+82Ux/3wOHuCMR3BvjrwkUfn
 QB5lGs5AnHSfePD7H+J33u6Cb32NxWE2EaAhhhy+2pY0xm9HqAc38UVxaFoBArGVQ20i
 k1jubDIHbKGnlSs28ad91g0NLph7viPZGqI7OgvgeMQnX3p/IRWstz6nHEp8WSs1VK3t
 NxY+WJqUAScG0SzgW9oGFhs/ozuy3k/FPhUQzGQqcbnlPgx3GyHcI8aqVSCwhTOqk8I4
 QVCA==
X-Gm-Message-State: AOJu0YwDNZcfT5oBy5GHr6gdSpwgAmt9jj4yWqYe/Vaju9+CrouYshF+
 iMxl8b/GVPl2XzkzFpprjRu+xSdppFjP3dbVMnT4jF0vN2IKE7uC93j5lPKm44Y=
X-Google-Smtp-Source: AGHT+IFsK21lx6y4aJrzQdx1fF0tGccxUFaIYERjO/yQOT5l8iAyUdXuLQ4SgC7JgqUQxH/1833lqg==
X-Received: by 2002:a05:6512:3117:b0:51e:1bed:13b3 with SMTP id
 2adb3069b0e04-52210174834mr11563924e87.32.1715804617184; 
 Wed, 15 May 2024 13:23:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781cf91sm900672366b.1.2024.05.15.13.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 13:23:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AFA105F8D3;
 Wed, 15 May 2024 21:23:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 01/11] tests/tcg: don't append QEMU_OPTS for armv6m-undef test
Date: Wed, 15 May 2024 21:23:24 +0100
Message-Id: <20240515202334.710324-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515202334.710324-1-alex.bennee@linaro.org>
References: <20240515202334.710324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12f.google.com
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

We don't want to build on the default machine setup here but define a
custom one for the microbit.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240514174253.694591-2-alex.bennee@linaro.org>

diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 4c9264057f..39e01ce49d 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -16,7 +16,7 @@ test-armv6m-undef: test-armv6m-undef.S
 		$< -o $@ -nostdlib -N -static \
 		-T $(ARM_SRC)/$@.ld
 
-run-test-armv6m-undef: QEMU_OPTS+=-semihosting -M microbit -kernel
+run-test-armv6m-undef: QEMU_OPTS=-semihosting-config enable=on,target=native,chardev=output -M microbit -kernel
 
 ARM_TESTS+=test-armv6m-undef
 
-- 
2.39.2



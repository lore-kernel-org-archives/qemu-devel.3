Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E779DF5545B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 05:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv7DR-00071J-1j; Wed, 25 Feb 2026 00:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7DO-00070l-OW
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:13:38 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7DN-00047E-4j
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:13:38 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-483487335c2so55862295e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 21:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771996415; x=1772601215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Fom4TdZ27OaWdE48V/WCmqpd1vRN9dFVw46MQX66F4=;
 b=SzUj1ZOdysSEqa03R+mse1JYG3/R2vcetUQDBNSE4/AlIHye8BXknbUHH3cdWFe3kI
 jUO73Jv+x3J0YfYf53S5Oi8a/fwkeRfrGvWvcUXyRKqkpmHBJt+VXZK142lgWbA0+GhX
 +94Upc9gJOSFa/uJhw9ezLd+tkN6tRhRZssIhi10T2caz7/xOblDJQXE7auW+eTHxFhc
 A6Dk1a8dWPheGPHEFwIlbGJ+VPWsQQ/fMEqQKLuTX+5XERlV7ISUDlWOSerpGguVqLsF
 6kOaSKG+tx3P/HE7I8l6rvBY3XY/yygXHysEMP2uG1Nr43HtiKWpgyOx+v3hcYBbVW+x
 O7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771996415; x=1772601215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Fom4TdZ27OaWdE48V/WCmqpd1vRN9dFVw46MQX66F4=;
 b=UVuhqfGaNgpgsZ1E6AD/tfux1khs4j+j3xfIPIu1npjBNYZEsJFkxQyVtvqpHEt2W8
 Ddk0k2qx9TD20r9nM2W7nqjjaw+tfbIskJr4wC0eO/3Hcd30dIpWy6yr4s/6D1psb/Pi
 Vcwl6gxnjiJih8c9b88pri5HnPGcf4j/UpGR2jT+cwqMLkHt+7yhggwLA8boaNS+8uGg
 D0H+O1GueJGl/dqBN1deCweJvmmZxrrlqHbIJftuC/EE/y+OuWubxGyI84zIH5XBhJQO
 rRjPTSlweZWCsxNrY4dGVRPV//q4zMMT9lTnFCoqBmzdcLvd+vZyBfSMHjOasS2xxaaS
 LCiw==
X-Gm-Message-State: AOJu0YwKXWnJLHBooZFJnNq3pIfuD2oqk/aNaiKv4lNbDSjS89FLarrv
 3URStRnzRDqMJ+7gTeu4nEozGhWVa96WQuasSSTLQy2Ervyogd/CyCbURmozHBEIYs65YvkAxp2
 247Wtywc=
X-Gm-Gg: ATEYQzzdYapTDnApkNJhbTkQ85kANXqxM9ZbBuEsxfjQ+tybI+Fqi0V7eGm/QqX3U3C
 eTKJ+l1uMeRckeZF+Y3ww5NRY7QXPpbEB4OfGACGUiuxea2atbEAJ1vuD19UVO22TpVXQ6M8AQV
 Cm+TvM61dYFe8hU0xTneRbpM+aRrgcqLWMfHT2e/YpiGnsCw1zCZxRf1umXuVLrcqUf69Pcp+8i
 2WmgNNANt4Go3bSkZGlKnBpGoNTh7pLIqndFPWywCDxByzS89i+duSYlPIleZcCWEaBU5s8U4IG
 COU+NyHI51RTlQMEaxJHKg36hJZjdGebiS6WXXS1Zdm55I8uOUo7xXGsNBj0xn5rzB5rJFL5v6z
 z6C3URJxjeBSi8sm3EeS1JL8rf/EC9Qb4TeXkvExoUUfJP29dro2N9uwFbWeCb5C3oyoY70BFAR
 Mqy8qGpwAZse9nMh0xHwWRESx5dica0JnuneTqYLRS+nkIzOVPI9vSc+70TFpqf/ZaJ26sL3rH
X-Received: by 2002:a05:6000:2406:b0:436:1872:63d0 with SMTP id
 ffacd0b85a97d-4396f15ce72mr27807237f8f.2.1771996415096; 
 Tue, 24 Feb 2026 21:13:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d401aasm30576270f8f.23.2026.02.24.21.13.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 21:13:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 4/5] accel/hvf: Build without target-specific knowledge
Date: Wed, 25 Feb 2026 06:13:02 +0100
Message-ID: <20260225051303.91614-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225051303.91614-1-philmd@linaro.org>
References: <20260225051303.91614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Code in accel/ aims to be target-agnostic. Enforce that
by moving the MSHV file units to system_ss[], which is
target-agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/meson.build | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/accel/hvf/meson.build b/accel/hvf/meson.build
index fc52cb78433..6e2dcc4a5f0 100644
--- a/accel/hvf/meson.build
+++ b/accel/hvf/meson.build
@@ -1,7 +1,4 @@
-hvf_ss = ss.source_set()
-hvf_ss.add(files(
+system_ss.add(when: 'CONFIG_HVF', if_true: files(
   'hvf-all.c',
   'hvf-accel-ops.c',
 ))
-
-specific_ss.add_all(when: 'CONFIG_HVF', if_true: hvf_ss)
-- 
2.52.0



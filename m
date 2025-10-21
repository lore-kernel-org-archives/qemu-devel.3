Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC5CCCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 21:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJZR-0001Qn-1V; Tue, 21 Oct 2025 17:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJZO-0001Qb-Ux
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:07:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJZM-0003Pm-5L
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:07:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4710683a644so2656155e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 14:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761080818; x=1761685618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LoAB3dp+YFOpUFb+CMAQLT6lLdWoV7loZBds5Fzk15c=;
 b=BxQ1ASKN+CKM9U8Up0aC2nYiHEuc9BZR0sdrQ+OyO+yzv+Gm7t+niHTofNG19U+EH+
 EXO947GXLHO3GSX0MMqs+mJRhtxKEgSTD3Wh9KDZDOtXpAJyYbEIEqRdFFaf2j2I8fu3
 ofpzYcNXrTE4RpOwJNs5U+ur4fPBpOW5mntacOeKvaG0472yly06FLqoTR+PybAAnff6
 ifrkfFwh5CGnvZgwxL0LVD5rC5e1VHkCJStfvAczQHrEqJh0OponAH6WSmn/5qSNRybf
 jxb7sgJrtq+oIa2B4kkAll0CValCe6WsBW5ikcw1e/JI4LRzZvdWP12xksR5tcL130md
 zyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761080818; x=1761685618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LoAB3dp+YFOpUFb+CMAQLT6lLdWoV7loZBds5Fzk15c=;
 b=kgpg2AWUO+rfbg5b8IZFmeLQw4UnHdMO7DcVoPHORyUFQ5P0q1su+FKKiJWoYDzsCn
 rVunidKdgbbv3GDLSSDLJCBtoNt9tnz9wG3aG1XHI+Sv9k4xikTZUxIEM2rb8Y1zMdj2
 I4Mi4K8ylm5PngQw0MYOZdjzDhjM8ETd2JJVBcOZ9LfHGCZaX7juZlY6VEpEdMLEVaY2
 YQuFSE/CcSJHEDL/2ubsTtsoojfQW2eA8OExPCvZ4tmuFD0iPoEoQrsOdLm3nlpVWWkv
 epu4pH6D3ocScSO9WDl/dvmbeKfeysw0Ea+kZl4yn/A6Eyvl7wKM/pemZO63jyGJCh2j
 rhBQ==
X-Gm-Message-State: AOJu0Yz7z4mPfIINd055b95GQxEXse9CtW5mjUBOadtAZX9kqEn0jFAq
 vflb4N2ZXtR4soI0F3I2Mh77vXDqIzYoMOPuZKXfgYCmChkzeKUYh6Dk1LlJTItInsjW9QDd+CB
 Z0Kze7lM=
X-Gm-Gg: ASbGnctozs7qfLUZ5GlQ79wPrvPi95EBO906sAe0JQ9iXSnc8BPcUO4hdNyA09F9+nx
 cG/Q4EahUUfH6J5Vbw+qEfKFM5SF7iHpzV4jrN3928oycQjMOIpWjJEA6pXZNeNB3/Ctk3AcNZq
 Ty/c0EKAWGv+t2ALm7SGgxAaJ4FbqlocTkOV3ayYgPzamjICDOZOIngxB24VZ/Ydv232ZRunvIx
 3lebWpCKg6s5v0jCFMMTlhXG2m/BbyorhupLUsJlQFdeBK8DG7XRQF6ms9yf6653eJP124BGo9w
 uarY6uzp0AiF0L6imEle0n+LEKjGJcZ1qL9qc6wTn0DVw8TKZxomj2mffC/7b2MOsTEsnknc2vc
 Memy9pykjk078wF3qkYhG7cYuO7mYJfXtvqVnD/jH/J+5CWqdtJGemc0wi/hH5tNEzyNYN3fNxX
 QDWe2JkHUdSK3MsmUxOJ7aXHK6uczOVByHHn1nURDlmvSwml3GgwXyPfPCErbF
X-Google-Smtp-Source: AGHT+IFbQhL7Weww0w8Jt7c8f3WqscQNJNNrfx5pccSBZZfKZiRzyJYa57M2yntYSzOJ/VAVCUewLQ==
X-Received: by 2002:a7b:cb17:0:b0:46e:24a4:c247 with SMTP id
 5b1f17b1804b1-475c3ea4383mr6896415e9.5.1761080818342; 
 Tue, 21 Oct 2025 14:06:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce08asm21879566f8f.44.2025.10.21.14.06.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 14:06:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 19/19] hw/arm/meson: Move Xen files to arm_common_ss[]
Date: Tue, 21 Oct 2025 23:06:55 +0200
Message-ID: <20251021210655.59278-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021205741.57109-1-philmd@linaro.org>
References: <20251021205741.57109-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 9fbbbc9a6fe..61c66ee2d0b 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -65,7 +65,7 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
-arm_ss.add(when: 'CONFIG_XEN', if_true: files(
+arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
   'xen-stubs.c',
   'xen-pvh.c',
 ))
-- 
2.51.0



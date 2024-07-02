Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971A6C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCQ-0008Eh-Uy; Tue, 02 Jul 2024 10:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOeCG-0006aB-0t
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOeBv-0008Hk-4g
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4255fc43f1cso29599965e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719929341; x=1720534141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x5n/UUecZqva2u2ersebHsP4O+vyf81j9dlx/AwZ1Sc=;
 b=o0cs7IZenV28NQslm2YVS016/oOUO8yoanKqHD9OPNL6h0rLWaZ3dJEplrTtaTXTW8
 diYEwhau56TzbR4TT5t56zdbHTG1MDu5NMkTolL/olgrtyCPb5urN/i2sbAP5amYlEAw
 ikmzHLnX7H41fVz1+99TtUzLy2v4EiOgIrZfap93oVemN01kn0Bz+avMlDV9tA0hzn/v
 nmLNBsh8rk9+OkzIBWFrupSSLTAdVx66n8Dg3tWIJnRPUMhMqVJIp+3jAWun1X5mUdRC
 zR3H+ujVrLStKtrjMZJnuy+7+Gykxszc8k3x3u4KuqbgZDX9QYqhYpYuK3Av7f4UOmOU
 84Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929341; x=1720534141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x5n/UUecZqva2u2ersebHsP4O+vyf81j9dlx/AwZ1Sc=;
 b=k2gdmHp1/yMfF0NsF+/YqJOOnY7vb/s97bWfnoHbksxBq8+TLjpWcBBkzlcywCtwib
 m3aX+23wU3GiynGOELlrjL/5MbsmhBtXd2Hvj0tvbgZ+8VJ/ICN1X8D1ssPWcOnvNmpL
 rdwJ6887jx1VfsAJumf3ePNIryub5q28NYbiM0OSVTk0AZQ5zvGXmOkupGYH9Qpp5ICJ
 bZxsfq/yiG7n81nDaA9r7V+LRGH7Q2k8bZJEjtavs+tMVttlZXG96CkBVorXXfQMgVfP
 6ZgE2TRLmD82ojVvrmaH6weMwikv+r4KhO6ywixKb/s746HMq4rvlAbLLOr88FsMRTAY
 ecuQ==
X-Gm-Message-State: AOJu0YwgBi7qYe867bSCND6BVB+CMaEoUMudfmhw7IfRNhIE8POkuTnT
 J+Xsid6kMaEn4qKH/1PhL6d8cERd5aonPDBt0ao74DTGE5F3sWjCsg5CaXvfOqbyDu7Dg4arxc0
 r
X-Google-Smtp-Source: AGHT+IHCu0fqEvu51d+e8aT6IH25ou2O1uaKHFB/oFow7q5yfcls7V1JlLFmBRCofJjeAGyrEe4okw==
X-Received: by 2002:a05:600c:1793:b0:425:7ac6:9709 with SMTP id
 5b1f17b1804b1-4257ac698c2mr64240385e9.3.1719929340986; 
 Tue, 02 Jul 2024 07:09:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af37828sm205816585e9.9.2024.07.02.07.08.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 07:09:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, Thomas Huth <thuth@redhat.com>,
 Shengtan Mao <stmao@google.com>, Chris Rauer <crauer@google.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Laurent Vivier <lvivier@redhat.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Patrick Venture <venture@google.com>
Subject: [PATCH 2/4] hw/sd/sdhci: Log non-sequencial access as GUEST_ERROR
Date: Tue,  2 Jul 2024 16:08:40 +0200
Message-ID: <20240702140842.54242-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702140842.54242-1-philmd@linaro.org>
References: <20240702140842.54242-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 27673e1c70..d02c3e3963 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -983,8 +983,9 @@ static inline bool
 sdhci_buff_access_is_sequential(SDHCIState *s, unsigned byte_num)
 {
     if ((s->data_count & 0x3) != byte_num) {
-        trace_sdhci_error("Non-sequential access to Buffer Data Port register"
-                          "is prohibited\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SDHCI: Non-sequential access to Buffer Data Port"
+                      " register is prohibited\n");
         return false;
     }
     return true;
-- 
2.41.0



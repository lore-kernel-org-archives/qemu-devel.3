Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7BFE9A056
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7fZ-0005Tl-LX; Thu, 19 Feb 2026 12:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fR-0005Nm-Bx
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:21 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fP-0000Ru-L5
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:21 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8845cb5862so201757266b.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771521498; x=1772126298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpcVusHH4ds43Bv7hqrg9C8PwOPYIZ9SdTqnEeifYvk=;
 b=tR4/yVx7frvxu6x3G4jWWCpIBZF7XAmxeLGJVvFxFquiWMUcR5HlcX+Ia4VXDst3Aq
 pkhhj6W0/HfQYkPK7Vf8Q43fATKw50nkznFPrs1QNNUDSghEHGkLGGd5xjhQqp8nMreY
 1lcrZdR1fHaCf110685jp60K0AGm1nF++Tbysd9a5jpq3V4xK3cY7aVw21RuwmTroww5
 7EOvoW2K4jc9m1TGIcCVRCkre1YD+2jg+79VVdOQTefsBGF4TkrRu6Y7sPEDASe+b2eW
 cYawi3c/es+y1GDTM9/wbnGBxomQTzhUIHY4BK0oo2nLRuNViMbL1q8hGGFpxQDi/TXl
 h8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771521498; x=1772126298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TpcVusHH4ds43Bv7hqrg9C8PwOPYIZ9SdTqnEeifYvk=;
 b=kK0XNAX0nwZWjlHo0HU41sC4JroOCtWDjPU+xjaq/H/4aqpqIPE2neztOmTcKaYdSY
 jcmVM3/PKL1R/ihvGeLQXQ/21tnAOAgOQJWkRlex8ObR3WX1Dp/B3Kfow/ifJS22OjVV
 B/22m3gJGXu3a3fShUhnPEdjHcjXzSwE+fNWDvG02O2BeX/tI3k40wXAa2JsyhIVIIi8
 Ui28Q5MLqlZaom7A188huRRYPRF8PGL/5L7vtFwpWs4OuBuh/6X9kyPIA52D2dOqWIT5
 ljpVwwnRWJ5kqjByhR63UCU53YqTedKHLH8y49E+7uPxeM1ayQfocSLcYfoYPAkzeQir
 9iCg==
X-Gm-Message-State: AOJu0YwJwo8d3skjanZvYR10q6bUEkvkpefU8hHehyR25nZrPzMzM8nD
 M0cP9VWEn6vCN+LfhmYm9U8WQei2m63XhqBNYMzzREIWnGvu5EuiuTcMvjhPATj9VYc=
X-Gm-Gg: AZuq6aJDPsw5cb/i6JGbKlo8Wq68kW2bte4CrDfMMaeSlx98H0zjUNFal+1WVC43W52
 Ki51E4FYzNWCWmW+oWFmUW6kpqqv8CRSpQ5iPzq2P0Ss8jt9pMi2nLNneVOs8sf/W4Kx8cj/brD
 kM/MRgt8QU9fh4ySL/l0oGHMCF8wofQ1vRmNC4hxgbNrHc7UfPmJItFlmEIcRHPvuW65bC9oiW6
 rfN4s7CMAtybQv6kTj3V6m/PyM8XzCcRQ1CUV/V6+VwmztVbjVAZU1cUXfMi4a9J9zU87j7dhIj
 LjgYxUOGdDR2WLmx/YYOpwEU6gsAYADPgC+tNpXXcqLT4SnrSN5F9KLOFCVsRb5wcOQfKfk9rQg
 eWNXsJbQuy/ggYluw78H0WCsPLdgJybEblJ9mywio0HjEjaRu9nLq5D+VwkLzcKOG2K9b0keyPv
 Wywn8DSFKIEvG51mtDepHuZr9iVFb9r1yXJw==
X-Received: by 2002:a17:906:d552:b0:b87:368a:2bf7 with SMTP id
 a640c23a62f3a-b903da48f1amr458184266b.13.1771521497915; 
 Thu, 19 Feb 2026 09:18:17 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9048d96bb0sm131339366b.18.2026.02.19.09.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:18:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 679685F8D5;
 Thu, 19 Feb 2026 17:18:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2 10/14] target/arm: remove extraneous cpu_reset from
 realizefn
Date: Thu, 19 Feb 2026 17:18:06 +0000
Message-ID: <20260219171810.602667-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219171810.602667-1-alex.bennee@linaro.org>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

We already have do_cpu_reset called when the system is reset so there
is no need to do it here.

By removing this we now only do (smp*2)-1 calls to cpu_reset. Once per
core as part of qemu_system_reset and then once per secondary core as
PSCI calls are made to reset them.

Message-ID: <20260108143423.1378674-12-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10f8280eef2..dadc48e06e5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2198,7 +2198,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     qemu_init_vcpu(cs);
-    cpu_reset(cs);
 
     acc->parent_realize(dev, errp);
 }
-- 
2.47.3



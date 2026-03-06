Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB8FF0182E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyTwo-00015p-W8; Fri, 06 Mar 2026 07:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTwU-00011N-LV
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:06:11 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTwQ-0005N8-H8
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:06:04 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso99847365e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 04:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772798761; x=1773403561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m3xIp+E+qbUxJ8IChHNC4F29fYKjGNq+BCC4mKGFUUc=;
 b=BnExEIqUXDLozpIIxo0FlDqUfeL1S1jilOEwwoBlz5MJ7ZoP2ky2zzhQsNOVS3aEe2
 DzmQaElQaT5XLfqKX+vMokvm5zUMF6vqSBmn/XHMRqKkao1SGAl18GTmGUxN+gxgk3Lz
 YBY5SVEMCqCQxLuGek9zFHaLRZ+eiUtkO7Q06rmpxgefODYcgz2IuWfNSdiu7zWZ/40/
 b3S3l6uyAOtNqaBISTiTkseCxM2tmLOyQTG0OikvFFc18Dn8qn9B/CJxMPIDXzgzlzOZ
 dmO/eZWfaKcZYgbiZ5WLEC6l45ZFc4404Ty8XEo1iTe3sJjgiG+51u3ommaI+kvOzCvi
 mFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772798761; x=1773403561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m3xIp+E+qbUxJ8IChHNC4F29fYKjGNq+BCC4mKGFUUc=;
 b=E9Kadd3CEReHpzML4QOU/7zls6ZhiguCfjLXfU7Oaw3y2h/THXMEdy/DYlOapBNFpd
 hssHEgEdkuNkxRWhBz2rNXtWAIbJ9QM/JnhupLMZwFWgtfePRmJi11pzitcVYdJJaUV8
 RWy5ffgGQ35TodS+2mfZDdoY0qaJbLQid/dyVmZ8ejoWwFlG3VBLaCWDWAumdJ91p32b
 duuQ4YtExcxh44GpN2uWJMMUm5eULE89lO4hSqxnxiPgkqEUNB2SqXbTHQPKEb6tV+Ep
 yEtO487YKFCYKap+68+L1j41M8N8BAtDIBV90Qfiu9Ez3pjLhRakexVBVWMl4+8rMf2P
 sELg==
X-Gm-Message-State: AOJu0YwrhYLQMdnKVU44dmGFfmqlF2Bl09IFUJQk//+MCVpgFnG4lAZd
 4kEWJaQmOSwzRECqrvbjUO1ErobNQX26dw3tQoAAqmBoyTycv36UH0bFCfjmJNcVUTh5DuyILEl
 5XoiS
X-Gm-Gg: ATEYQzwRSQ4qZMA8fx25qMEFF0mAgiFAnguJgnx/IHIwDQUXtlzvx3CLXJuEGSwP5fl
 ZXYygCQ4XOF4nMv7p9oSKPsWYlHqzs83eggO0t4O/6q3SGVrlYKfF67YejQNOhUrgdmeqg3N12Z
 ctVECox8dn1gv+T82g6YEf3qxAFTgUeaxHRy1twjV3jZDr6kHW5n8+zUWuM/6fgBjX5OlpWoNjN
 zyoSKUBE0zF6lasAHvSa7Y//Tn/7ilLpleo8ovQNml18xDf+gVv7egvx9jj3jn3zIKWuvQ9+2Op
 ayO1bZQABF3IlmW01Xqrb7qpnLK9zi048ScSO4y39O1bsEWzR1+0b7VtyxhdEWZeQZcUWBW2vkm
 Yq9OS0kWFPpZ/CDiLYGzoKZUbiGEgIDhwsvRfoFcnzl8qdFo7je2zcrwg85+y7EQMdFLyUj154C
 wTK+DDBjhr6ixdze6giDfRqTLvcFrdVLgp0YVFVUTuLMa3n79bhMESKP/dz2/GIua9T9ChYDFH9
 wGBJ46woDi3yHeu8nQsEfdTV+5gpBM=
X-Received: by 2002:a05:600c:c8f:b0:483:703e:4ad9 with SMTP id
 5b1f17b1804b1-4852695b63emr30549595e9.19.1772798760656; 
 Fri, 06 Mar 2026 04:06:00 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e2bsm32841945e9.5.2026.03.06.04.05.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 04:06:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] MAINTAINERS: Remove Radoslaw Biernacki
Date: Fri,  6 Mar 2026 12:05:53 +0000
Message-ID: <20260306120555.2035421-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306120555.2035421-1-peter.maydell@linaro.org>
References: <20260306120555.2035421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Radoslaw Biernacki doesn't wish to be listed in MAINTAINERS any more;
remove his email from the relevant sections.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5aa369e6e4..a8f68781df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1046,7 +1046,6 @@ F: include/hw/misc/imx6_*.h
 F: include/hw/ssi/imx_spi.h
 
 SBSA-REF
-M: Radoslaw Biernacki <rad@semihalf.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
 L: qemu-arm@nongnu.org
-- 
2.43.0



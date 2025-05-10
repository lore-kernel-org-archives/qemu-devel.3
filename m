Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7F2C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 06:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDdWP-0002k1-UI; Sat, 10 May 2025 02:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDdWN-0002eC-AA
 for qemu-devel@nongnu.org; Sat, 10 May 2025 02:17:15 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDdWL-0007pz-MY
 for qemu-devel@nongnu.org; Sat, 10 May 2025 02:17:15 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-afc857702d1so2398030a12.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 23:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746857832; x=1747462632;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lQnJNkvK3K2yzADBnJzSykcynBAmHOzuYLLnyoCCgJg=;
 b=zTh8DGczl4Tr6VR1BmolTbe6o0hyYFM9v9CAfYg5qkBTE7V2wC1nH/o/PtspMfh41y
 +BmlwDM1SbR1PmJjM1x/NVDz8mROERPcL6y2wZiLbkBnd/lr34L1+FxiB5aj311hjwpR
 QmAw+fqlfbIIot4xik0VmOyyx2OD2onl3/km08msJZ9JixqFrhOAXPIoqv8Dem692c/g
 HO+Tr4308w5UMfDCn6FPTTwhk9Pf3fWPDf9rbnQgX2xvIgAT5bFu5yPMmiMogxc8zRbi
 ZkfSXHT1A879Wt3f48fZZouKVwCw7dN3iXGWGD6mocrGgvE04x0yVvEk8NamJLGnBXTN
 dUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746857832; x=1747462632;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lQnJNkvK3K2yzADBnJzSykcynBAmHOzuYLLnyoCCgJg=;
 b=puvMLl9/Y0xlqhNwPZiYFlCmWUf9V+GWCiOlRyunaUtSVS1CkYnkHTJ8EYz+0TtYTJ
 wNnRR4yE2MLPVt3ZqIS9rR2MBDFhZNnZl4qx8d/CLdWdIwj3Dhg8squ1vV5qV8136d/a
 gq6bWCDz6byIaPPyDAF2yWfOccIqyvqLdz3n1K1Pa8B9DV5ke2lXmpz00lF2x395DIec
 qzhakIniqHhvQtBVxzO14YkuarKuIp6vJCEnnSyu2S5JgvnCa2IJQu7yKgFHf1rpus4J
 vyTgew25MtXIrxREU69aS8QZIxh0DmoOiKerjrGVY84FkGPAYPGntCTWDY3GZMp1xIdX
 e0Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOITGLM4VqabpV5SePbuwHKzrpLtXawRZyzgvP3dOx/vqetaIIhDxJbkXtEOO5UDMuYYqTxA6W4Pb9@nongnu.org
X-Gm-Message-State: AOJu0YxCQS9rWMqc3w8uf2ij7o2qo6hDqL0fFONJ/ibc1VeQRPyz3Wv4
 bLm7UEIyOGbrKcxyX149Z5Xu/T8KwgR0U2w1oVcECZxrdk/w7CMhkZOUAEzKPMA=
X-Gm-Gg: ASbGncufrrbcPQTWrc/SJ57Mrp+CQqIFjs2WX9bM2en6Lntb1MSDbrCbsTOfbIdPL7Y
 walbnbR7OspedJEyJpkBkoNYvyhi15E+Veli40qePtCExqxCPTkjP2RzeZjQHn0JZ+mXIceCTZc
 /SDeuPq0MleyOefF4WZaBNxdGv6hF4qn/kfiPhfriCVlWCiRAflHLBLTddt9W4yXaZeCY2oJclZ
 qA9zrJudMYAaRw9uJzEI/GPbYxGxXMQ9o7EWxfivv6AmHk12Lh2rxlJK42SsRGFU1vx5LWjiFXs
 8mMk8sPGIJcaz3AHYE7+1wotKM86jtDCEHz8wS1Ymii30QaXakUB
X-Google-Smtp-Source: AGHT+IGrHRpDnOixzNCeipOiAXPshnrDlP3ai50VmzQanLN5AWc+SDEXXDrcSYm3BDdUG0Pfhy64wA==
X-Received: by 2002:a17:903:41c1:b0:22e:62c3:6990 with SMTP id
 d9443c01a7336-22fc8b33517mr77900155ad.16.1746857831000; 
 Fri, 09 May 2025 23:17:11 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22fc828b491sm26871225ad.184.2025.05.09.23.17.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 23:17:10 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 May 2025 15:16:56 +0900
Subject: [PATCH 3/3] MAINTAINERS: Add docs/requirements.txt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-sphinx72-v1-3-2358e0c68bbe@daynix.com>
References: <20250510-sphinx72-v1-0-2358e0c68bbe@daynix.com>
In-Reply-To: <20250510-sphinx72-v1-0-2358e0c68bbe@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: devel@daynix.com, John Snow <jsnow@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add docs/requirements.txt to
"Sphinx documentation configuration and build machinery".

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d54b5578f883..6ae5d2665e16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4328,6 +4328,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: docs/conf.py
 F: docs/*/conf.py
+F: docs/requirements.txt
 F: docs/sphinx/
 F: docs/_templates/
 F: docs/devel/docs.rst

-- 
2.49.0



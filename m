Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEB4CFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTJI-0007NK-D5; Mon, 24 Nov 2025 04:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNTGW-0004nZ-7W
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:53:53 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNTGT-0001q7-RB
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:53:47 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47755de027eso21297265e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763978023; x=1764582823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WdfPVNcsgxdSChKlyDoSG2k2BbOIKuM3AGHYELIYuS0=;
 b=aIrfKzGs981KW+C0uEPOzBaFQ9JgdVUTtcL7v4W2KkY+kotOAd41XLG/7jfWbpo66U
 58O99JbCou7tBWOe8PL2zDWS/pMJXtBJVTmcD304b0huL8hRXiCZlNFs8HlHgUE5u+Q2
 WdGXVuOLUg1wOIvwT45bbDJnQYWPsaU4ft4aaqSMXijK1XC1V+4fwqrcGmW4sH3gbNYx
 xvSEUwp/JHClyxkWxgRmWdvwDZq9wvCI43D1qBymexcLN5KXWU7IUfYRGCkKQDOX09mp
 tOSOxCxzc8vK/3j6h2qLh+UKfcGZGkkSczDmiIUsd10YWX7CGGvM0tIYi09wUFQAuRg0
 LEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763978023; x=1764582823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WdfPVNcsgxdSChKlyDoSG2k2BbOIKuM3AGHYELIYuS0=;
 b=pY3zGCg1izy8cYW1nboswx1WxuOP/nKnAEM/+dcZ8bBmXdQUcoihVUbNKSuspdznwA
 EKMHhRHWSWoXNjPbDgr3vZnXGpaZjRGTNyzz3k7mhBbfvgDQBQmu9fMrHcV64zbHB6Si
 RRvxzYdOi1cl4gb1ghjumUay2sROpY54+1EaINM7vL35acmniqlV0w5LIduEhQojh3Dh
 rtPm57FlqxS7QqmEZZXr3EmNqJ6bMOBUaakWhB5pAl8vxIBZyY2KXc6fGuLl3wCuiTOL
 i4kvg+p4KUhrUrQAc0wP39hwOxJf8+7qVGOtpxyId4XOgvdByEeRbMqmRmdFlcYyf2hM
 yNFQ==
X-Gm-Message-State: AOJu0YyIDumLfxpo81zUPaThyCgXluCfAlxBAbPOArFbQOMvFtacm2Tv
 jFXB0zq/84Utxs+SIiBJAZil9a8FT7oSvsos7o7XfcJaeIxZYyJOfBMcv7RBvaqXrLY=
X-Gm-Gg: ASbGncuSRQQb9xys5qR159opuHxC3FZ+CBZDSl6GSN1GVJUqUBEPQksy34eXyukY5mK
 Bd6snuQ0ha/zcK3Mm2HYmf8+y8k9GCAiQHUkFcjPkG7BhHGItf0829oA2J2xGu6JAwOJSh+7PRI
 CZfF7VFoHDQtUDRBtRuMilu4B6B7EqewLnA4Lmz/RoHPwyY+KS8uUg1z7CmGhdP/sJ5RhqXAX3X
 I8Q6FN52OxuP7tyl2COogTXUxARSeyVvVVymVuTCbA5tIK7DlA7aj+TV8GXeqE2vkV3nwrXr2gJ
 0upIE9WbtDfAITM/GnMomKZlnXqtPMwk73KBRc7+gueBlhe5qvd9D2Z6fjZGvZBQAirvfyE7C04
 z1iNJe+MIWB6upHU7jRt9quBjx+7Y1RpJiZ08ntyyee3V1P2ebaYtdDy3OUKK+pxbOMJFJSHtph
 POZbof/NZ3qSA=
X-Google-Smtp-Source: AGHT+IGDiUllR6FHjmW6loypK9poFMHRpO1CPKAf83mskE6rAcitiMmioEq2jhisVfyFbi+mHpa8Gg==
X-Received: by 2002:a05:600c:4f49:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-477c01dfe16mr121960425e9.27.1763978023324; 
 Mon, 24 Nov 2025 01:53:43 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf35f976sm191750455e9.4.2025.11.24.01.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 01:53:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 130066021C;
 Mon, 24 Nov 2025 09:53:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jon Kohler <jon@nutanix.com>, John Levon <john.levon@nutanix.com>
Subject: [PULL 5/6] contrib/gitdm: add mapping for Nutanix
Date: Mon, 24 Nov 2025 09:53:36 +0000
Message-ID: <20251124095337.537277-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251124095337.537277-1-alex.bennee@linaro.org>
References: <20251124095337.537277-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

We have a number of hackers from Nutanix, make sure they are grouped
together.

Reviewed-by: Jon Kohler <jon@nutanix.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Message-ID: <20251119113953.1432303-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 4e67c3e484d..c07dffc51bd 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -35,6 +35,7 @@ lwn.net         LWN
 microsoft.com   Microsoft
 mvista.com      MontaVista
 nokia.com       Nokia
+nutanix.com     Nutanix
 nuviainc.com    NUVIA
 nvidia.com      NVIDIA
 oracle.com      Oracle
-- 
2.47.3



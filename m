Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B41CCCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 00:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIz55-0004Qn-M8; Tue, 11 Nov 2025 19:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vIz53-0004P9-3A
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:51:25 -0500
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vIz51-0005pC-Ja
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:51:24 -0500
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-88246676008so3513956d6.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 16:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762908682; x=1763513482; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rVrVdypkmr3E/RiyYnlF3XIe+i5PDhK0NolgWCoGEMM=;
 b=Uq3j8TucwtgP5rvUay6c2vL9ooed741bdY/X4mnyKNie6/IrnOa6do2E1EHy3r1Qjl
 BQZfK7UmY36KK+zb7cT03lFieyjFmUycZa2JXeFkRkYlE9xXo9XPQr75fNyBMiY2oLoY
 ebmlghAv++YQfP4u2nT3/1F3M7KKmVFsrwP5CMjITWybnsoBXjX7dz1qc9+QOAhhGXr8
 YT5OTxbg37L1i8H8k0mvVo/pblyw/MlU1qCpWLIyQ163Fg8pCBNDLBTxcWPUIaTd6T9C
 zBOvutblkxa6XVa4fVkeWX43uUpcZv1OpSlKozP9uU84iltSvjUWaI/VQ2LTJXIHZkCl
 Ffiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762908682; x=1763513482;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rVrVdypkmr3E/RiyYnlF3XIe+i5PDhK0NolgWCoGEMM=;
 b=P9IUedm8fgRuSnjF7DP73L7e+rFFaL736IdaNSb6RIe/A1OU9rwU9Imgoj1V8O4kin
 upkPLHQEEs8yEL0xzwrDPP5qzX8mGkbCIZEU53nleP7kzS09ZLmD9qX4//aFgdOxx9vK
 drw9DZRkCg/UbYBW3v2jG38pLIm11RA4Xn7fV05WO1CP6vQYWKpx3kwDoOt3w3szpH1r
 k7kugBIoYoX/kPYb1AIGcphwt+jxvf7aG3KYI1CV+yUSCh6GXUGnfLoOI6xIqiSYokTs
 icP7QNE5IbL3pn4f3w9TjM84gD/RoIvZyDIox6oK9XR0HwPky0DFmtW8JMM8cjp9u/DH
 lzFQ==
X-Gm-Message-State: AOJu0Ywnzqqk/VN8t9KymSHj5E9ImjCDJVo8yEyBd3XY84CcP1/frYJ2
 Gn8WxD5drBHmA2RvIkvrWg10XB1V205TrT4MSeIDBkmJ637LB3kRKCuC
X-Gm-Gg: ASbGnctIZs43nxATJPMp9meVEukXWy8M86XMwRgPFrqt/BgQdTKLZ1jK0/Q4kZwdXHm
 3jHOLslw0d8r83QG1b95mIGOo4MzbyC83SiA/SQObiBYJBm/XH+KYxh43M4mpLOWN7PC97qtAU6
 tsiK4sF8KyxInUILhIx1BrV/jrHvWQrmd3eayafD7aED6W/wEXbcJdNj0XYxpwEkbthqQILoSKM
 yGWiyj7H9m1kfoi3pLmQLrNvNsuQroGXhhfPMCb6T5F2tc5f7e33pjeGvaQEpJcoxMHLxV0XhGG
 75mwkUS+lpShxvbEPl3TOnuCOBMe7PScSO1KgyGVK7/Ea0qLH4/qU2MgU7rv5WZi7J1OSZTFGYH
 wycaNolpzZ5idGpVLbog8/Mn1yLKayMcg74Eqd3H9PEzSKmZXq5c78zeZ9BToGerwQvPuNUGm+U
 cqWKWGph0Y
X-Google-Smtp-Source: AGHT+IHR4+2wsvWMJ2uexni3JJo6oV4CQ39Ih4GxApgCORsMnAdc3C0jeteLKykvcxXvemvFxxIKwQ==
X-Received: by 2002:a05:6214:2a4c:b0:882:3afa:74 with SMTP id
 6a1803df08f44-8827193ddc9mr19904556d6.29.1762908682575; 
 Tue, 11 Nov 2025 16:51:22 -0800 (PST)
Received: from [10.0.0.22] ([185.213.193.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8823892a79fsm81445096d6.4.2025.11.11.16.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 16:51:22 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Tue, 11 Nov 2025 19:50:54 -0500
Subject: [PATCH RFC 5/5] docs: added MTE4 features to docs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-feat-mte4-v1-5-72ef5cf276f9@gmail.com>
References: <20251111-feat-mte4-v1-0-72ef5cf276f9@gmail.com>
In-Reply-To: <20251111-feat-mte4-v1-0-72ef5cf276f9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762908676; l=900;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=yMYVdAhFPzUk+dj5yY7HVAqBXvYMOye3T8cT36hK3K8=;
 b=Omlvu1wD6ymvmau/bEIFPE1YuQ1TuofHTJxinh/K8gU7BILZTwfivVqgkQmT1vErD+CJ6UfxU
 TdPhckojQUhCjiKCg1q9GGPK8M5zbt3lddS1MJF/a3gGwIHAqmN1KeF
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qv1-xf36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The implemented MTE4 features are now present in
docs/system/arm/emulation.rst

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 docs/system/arm/emulation.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 31a5878a8f..1bf99c77bb 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -106,6 +106,8 @@ the following architecture extensions:
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
 - FEAT_MTE_ASYM_FAULT (Memory tagging asymmetric faults)
 - FEAT_MTE_ASYNC (Asynchronous reporting of Tag Check Fault)
+- FEAT_MTE_TAGGED_FAR (Full address reporting of Tag Check Fault)
+- FEAT_MTE_STORE_ONLY (Store-only tag checking)
 - FEAT_NMI (Non-maskable Interrupt)
 - FEAT_NV (Nested Virtualization)
 - FEAT_NV2 (Enhanced nested virtualization support)

-- 
2.51.2



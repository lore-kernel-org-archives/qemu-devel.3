Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E4CE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB4G-0006r5-10; Fri, 13 Dec 2024 14:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3i-0005v9-18
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:42 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3c-00074m-Mk
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:41 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f31e8c2bfaso459675eaf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117035; x=1734721835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QrrJ4RvuuoGOGZrV9FD04T9DsliVJZ1San+rsea4fSw=;
 b=j79VYs2XZz+S9zc+GSIzSnErTkcQLxL7dPXRMPeQFCu49SVRcW49sU3J2Uwq4jR6T8
 /Llj/Tatyz7KOK/oI1oCzy+CjKH68zcNCTRnUhrXWl+s3tGNRC3U7H4WVQndRmsFLPc7
 xjgY67X/f+a9OLNifn/IIeJ5vjtaKlnJRsQXmFrnbfgiEgRuNw/PEPFJFwr1ssk2xP3p
 uPGIUsUSvNc/FUvpyYsewHOF0Oiqv3Jq0zplr3ypRM5kfSTVQ8442aI8gBcJuJT4e8Gg
 neJv8uHjww7QSmN/WoB5iloWN/sEB7Zklg4Hn1OujKeC5LFVo2+gWjNkQik71D7qZtmL
 ItjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117035; x=1734721835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QrrJ4RvuuoGOGZrV9FD04T9DsliVJZ1San+rsea4fSw=;
 b=pOChcrGlJtzDefrpEZ26T1KbY5MXPovFiHPB82tUWcvqH3nizoUUc39a8ZYEikw7N2
 wVDI+0EUd+s2eOeSWgJVG60Q+s/3oYGUCxz5h8U5zqTG80lEqIuHXn+PArSuLihjUM7U
 VZWNhQdKGs4CK3ES+Zod3lEiPkgiuVmVkM3TRD75Nw08ZuwC8U01zpYYiwx6o8dnQ1Gm
 QREUOKto23ls39gY5c1lCnbV0/4gCI1qIBUA6xBrWv0wGGfQawSzs6pDEmeAxuihKLEu
 HuJnJ9UNcBCCmigqXgsahLX3Dl5ShBm71s2wuJ43hNbf9VdHqWKZstQArnoluH2FtUsO
 15jA==
X-Gm-Message-State: AOJu0YyVQBfD/2t73dZUO9k0epG64+WvvEU+ru8fDWycWeRnwyhBHOxD
 ciDnux//ZXF+lHJY739lYKiYWc+Uw63RArN9wA1NyhzhwydbkX7g4fGV5on3hngyU2Vk2SIQroY
 VaINw0kUW
X-Gm-Gg: ASbGncuPgY5JNKDUqHfZ4YBJehAelo2uR+KLNXhfPPDrcS/M0uZ8lCVVdWPHIspl3+d
 udoVehBJhBncr8jZxU9MG5gvnhCrEjl5oGiyk56WQe/bVKWZwbMMBEIiraCXn+DPumenJOrdaa1
 HZ8C1VlmPWrQP9FWJqPKmCc5YMHmPnVsJVePLdLU04rKIF6Mtb0CztZkvA5em24KxPPdj3Ug0Fk
 XAja7RDt5PIqaSfaRQGWOIeAJnDJWXXDsGHOFkyGwhHT4Kg4D91G5GQ3wII3kyz
X-Google-Smtp-Source: AGHT+IHJpabkeuL6yrDgrDN/ajkCZGzilCGU06O1k7F+CDZ952vsakF6CLuYiA6pmiHRNUhk0qnBWg==
X-Received: by 2002:a05:6820:221d:b0:5f2:bb17:f072 with SMTP id
 006d021491bc7-5f32948bd92mr2094280eaf.5.1734117035626; 
 Fri, 13 Dec 2024 11:10:35 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:10:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>
Subject: [PATCH 33/71] hw/ipack: Constify all Property
Date: Fri, 13 Dec 2024 13:07:07 -0600
Message-ID: <20241213190750.2513964-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ipack/ipack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index c39dbb481f..7ffc4ffe6f 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -73,7 +73,7 @@ static void ipack_device_unrealize(DeviceState *dev)
     qemu_free_irqs(idev->irq, 2);
 }
 
-static Property ipack_device_props[] = {
+static const Property ipack_device_props[] = {
     DEFINE_PROP_INT32("slot", IPackDevice, slot, -1),
     DEFINE_PROP_END_OF_LIST()
 };
-- 
2.43.0



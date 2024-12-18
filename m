Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9B3E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuKR-0001HW-3r; Wed, 18 Dec 2024 08:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKM-0001DO-Fd
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:03 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKH-0005dc-SH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:02 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3eb880e5ac2so3044348b6e.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529376; x=1735134176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdtTPZpqJYrYZ2U0t9zjMkgAW2wWgCEM7k+fI21YU4Y=;
 b=I5OttRtNnvtp7W4CUgRoEAMqfDus5EfFvlI2Ukls31SyaFTjx7fqz/Z2bLSrllHegl
 yY+MDjFkD78WDSvXVszKQ6BRXLSKM4Bn2DVC3XnSBp1umULlhSYeSx/pdlxid2j2bM7X
 //GvFkrscAFO8zjLLwyauhtiGsFqiDBFJBshbaWM/6T2vhSztWaKyCddX3nHlmh+Uegw
 NthbxpBUgd80XNnE9jpnzdm/TqgGK8RtVfJ1im0pwGIifVO+mgT1IrDSBahiynnXataa
 oxagMfRk7Xp55SuGypW8wKMZF23fV+5H+W4JHokwORWu9OQEgXbExq+47y0kUlxymaAb
 YuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529376; x=1735134176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AdtTPZpqJYrYZ2U0t9zjMkgAW2wWgCEM7k+fI21YU4Y=;
 b=jatVBrYwserMA77o4mwAEaRl7zc6BQweQGuTPUzOj1Wsd11BT3NAMevF0dOrFQsPaj
 OGeLKUxuujulw1AV9Im6qHETEE38R0OlUS9TQ7OWjXZtdpG0V5YTjVsKzkHTsHZPW9U0
 IA4jYNrcMg2Pl81hQVYYOdTGYqDwuyRuKmHGzgHsHU5gyRT9FtlStu1SBPXZGgIzJXW0
 r290KPKzpOPqyXR/3LHEbLGF8alVESjk3w2zmuYspmngbjevxi+PylHlgTrfSyL2mPh9
 NYuLVSv6HOLKZmBrWlRf4cBJZ0gFkI9X6fEC/ssOHT3lyXxoh1iLnhHSL46otGOBQGLG
 3k1g==
X-Gm-Message-State: AOJu0YxFoAcRfF7Wal2GotDj6oa8+c2Uu8CRp8uZEHcsT4IBjhzHFDcD
 pm0kg0NTPgx5MdKrH2HQi7d12u1t8MARmNhCNEhFardHGsgrBSiTQVBb5TTIvyr1G2hLO5KIXtp
 S6chKgIpX
X-Gm-Gg: ASbGncsBSZxhRnKZ2nizjTwL0OhJEOBxZ5ew0nL+wo9MgOwWaE+cdmykQewK8FTvC+J
 WVNvAQvO086sRsjBmjdDAD/YJ4TwXnZHZ/d/o2mhp2pYEkqLCNSUZfVOnuQKJiMpm4xQ1uj7YCV
 KAdUh3q40M5/bA480qG5UuR/wL/4twfaCNxXxseJ2vuZk1cqjCG2rMtjPvtBra58y8f/NlviC7B
 DecK1f/8/IujjaRPOtyiaUQf8CKekgMDeojiZXDKi1/kpq1xv/6sKcFR55nc09a
X-Google-Smtp-Source: AGHT+IEL81V+Nbdz1y8VHQvlK1DJYQDH7NGjPpANfDg9x2DqWq1MX6+Zzg/HpMmh7NXfJuB8cdP3aw==
X-Received: by 2002:a05:6808:2dcb:b0:3eb:5d3a:5b20 with SMTP id
 5614622812f47-3eccbf2e62fmr2185933b6e.4.1734529376659; 
 Wed, 18 Dec 2024 05:42:56 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:42:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 02/24] hw/ide: Constify sysbus_ahci_properties
Date: Wed, 18 Dec 2024 07:42:29 -0600
Message-ID: <20241218134251.4724-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ide/ahci-sysbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/ahci-sysbus.c b/hw/ide/ahci-sysbus.c
index d43db0923f..2432039290 100644
--- a/hw/ide/ahci-sysbus.c
+++ b/hw/ide/ahci-sysbus.c
@@ -62,7 +62,7 @@ static void sysbus_ahci_realize(DeviceState *dev, Error **errp)
     ahci_realize(&s->ahci, dev, &address_space_memory);
 }
 
-static Property sysbus_ahci_properties[] = {
+static const Property sysbus_ahci_properties[] = {
     DEFINE_PROP_UINT32("num-ports", SysbusAHCIState, ahci.ports, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0



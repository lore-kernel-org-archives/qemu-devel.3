Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D09E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB1Z-0002Ul-9O; Fri, 13 Dec 2024 14:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1X-0002UN-H2
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:27 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1O-0006UJ-Db
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:27 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-71ddc7325beso207997a34.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116897; x=1734721697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2FaMYSRpXTA1aFa03SbQJetzuGw4zyxlsXPWwQbGKI=;
 b=S6WxsRBRS4xzn1nHaaS9ic2cz/TceRnRcLpefvc3gycLm++U3wEXOU7ms6iql1WhrN
 SEEukUjFz6ydcHfps7cG6D2eRvh8PM1mATdWjl6cZ6IXccP56YSfdMOzay/FtU+bPUFL
 Z9Vjve1NwhwFwn2uS8g1LqXGRaTRlnHErJESkRFjuusnXgewIeXdRgCI7HfvOyPVtBL5
 1LiwV5SlnkD4z6OBVZbogtG7hWVBsnDQIoVZlqggsgREsHTauqzY0B+8F/7kR/Dg0ppC
 iRgQs4NZEzBf+rO0XzD2FdwXwt8pUSCQfTFzXw0BRU3rSuPedgWwaADqsQnWgFlIPb9o
 OeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116897; x=1734721697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e2FaMYSRpXTA1aFa03SbQJetzuGw4zyxlsXPWwQbGKI=;
 b=riDtFc03S+psHi3t/beN36vjj7PWJLDLW63Hxkn3q5YzyHZo0qPM9LUauP3Om0cN0h
 xoYPlEcOh1/K/55YVxJOIr1ak7FLw+PtjZbvtFq59/nwA6KnU3ykG6SH3nHYiOsk128n
 2i8nCr/j+ZHQbNDI70QrCJkg3OLH0xD6LI8tJgyT6zb8GXkmvOOUyi0Vb5P3+F+vIMp5
 kQGTKD3fdHWJhElNFpwn8zGQRXZS+B1SU3AUcx/gSfGnz3WsHZ+ZWS9i4LdXoZoEyPkl
 sSPQWohVmRr4BH/keizzvdr1ch1Ly/xetX7vGUicN0bbro2L2a6XUi1toeusKIXYCAkN
 0O+Q==
X-Gm-Message-State: AOJu0YyABWAhu1vEA8993STcNIettfJop6J4pb51MSiyLIXURYy1Lkvj
 ApCZ0yUwfxuVySTo9pMn003AWIKurnr61G3PVCuF+VX75Bfg/n3HEwPcqmd51RWFYht0zl6HsZ0
 wqNbLAlDS
X-Gm-Gg: ASbGncuYCjFh3FrRS+iDHxsVv2DVUO9InH7fP228A6HN6x0D+Z/YeWv9XxTErfeARzz
 KEogTZmHZhEv+eBG6GfiPeC9Yn6iPHNB39nfAlrHGFShX8Q/wRk6xuJwElyDkn6DQAxDOPBJTqQ
 VpssCJNZ4nxNmLrDcfReBhnfY3OjBQFez4X3N+MeusVEsMhiwWtwroZOoUTGgFomFWImfp/uPoa
 +GkTIvU2r8t50DHhZdmxuQolFj231mKjKbO4bbVAFnFzb5aX3wLJG2EJJhkZbiI
X-Google-Smtp-Source: AGHT+IHvPaIqzi9nsQgAqlbVMpPUgAtYJed7d7TChM7R3MvZA2BHTevmR9LxRrfzM3OF+EtKjRCBLg==
X-Received: by 2002:a05:6830:6a13:b0:71e:1fbe:db2a with SMTP id
 46e09a7af769-71e3b8683dcmr2304738a34.12.1734116897208; 
 Fri, 13 Dec 2024 11:08:17 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 06/71] target/mips: Constify all Property
Date: Fri, 13 Dec 2024 13:06:40 -0600
Message-ID: <20241213190750.2513964-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 4feacc88c0..02c0e1b0f9 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -539,7 +539,7 @@ static const struct SysemuCPUOps mips_sysemu_ops = {
 };
 #endif
 
-static Property mips_cpu_properties[] = {
+static const Property mips_cpu_properties[] = {
     DEFINE_PROP_BOOL("big-endian", MIPSCPU, is_big_endian, TARGET_BIG_ENDIAN),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0



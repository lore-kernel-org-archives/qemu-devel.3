Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9063C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmSyW-000596-Et; Tue, 19 Mar 2024 02:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSyU-00058R-7N
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSyQ-0005dh-MC
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:25 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41461c256c4so5249425e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 23:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710829760; x=1711434560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUMu/SnjGuIrmF5U5VN8reZH7HV2LtE5n6DxI3xZ0h0=;
 b=plwc0dqHA3AAP69WtK89dB9Fxl5671UXEgvyOfgBFEuM0sSHjjO6kydLN/MTb7/a/X
 0ir43r0E7gUd1AE7+rb8cykUPLCD2uFq3Osqtt8MDpy7pUOb7EbV6KRXR8MlsIpcVlq0
 X4k87UCgvJUf1xMhudJDZ/kuK9UuAIV7UnBYPkt3nA9aUiH0FfVl92B3hSjf3c6Gp5+H
 VfFnW+b6nUfbKCQu3YVv9xXCp1WtM2gOUfYSCdcMTQ+Ut+wkW1T2M3cT0MbHtqPRcwok
 U+NONCg1rZS0QtFk2alGozJV599qc/Dsx+eHv2+apNM9DcJ7gCbMQ71SC0lyHXo7oWA8
 NlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710829760; x=1711434560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OUMu/SnjGuIrmF5U5VN8reZH7HV2LtE5n6DxI3xZ0h0=;
 b=nJ2Cxc3UT3ABm8JAqQiy7636BR4ikjJGJ71BpJorZVsjhKo6htWxvIodDfKtzAdKYl
 peoeTqMcZEqHXCcFT+BGQvMcT+FkRTWT290OC25lvNCfxuUj9kxitGAZtnkVczcf+BxF
 Y9ZIZdSXgIfDzxSnEidZW19QEiVKpLF1msmF82khYL347Zext9QkD4jTcBoiU76017xZ
 ZGcxhGbBPoGCZNANZNfEh1FfBWBvHB+6HxuiMUqf1y/QssUa5xyN1tJPEICoeX8Qtrid
 Upb5Yrh8WPLDhcVMCYJw28DcUS/GMgj4s+EQ0XVXXOpHwNG4UOUJuK3Uu3lzieMGmkCm
 s92w==
X-Gm-Message-State: AOJu0YxkaPKkX0mU5Jna9y42nTpyPVFS0cjkJr+nTh3pdhLFGCH0KkNI
 wJYMidIS5cA+zyKS/oBjWuD/+h5YUXcgcGO+cXquvxqX1cAcFm7PdBXSmpyfzs8Hp/KTO9m0Moc
 A
X-Google-Smtp-Source: AGHT+IHP//CRIEiNinf9+UhocTaax5slUcGi81qSrKwN1DEZtshK6yksOSk63XTSyfk7Dol9GWtjlA==
X-Received: by 2002:a05:600c:5494:b0:414:624c:aaf with SMTP id
 iv20-20020a05600c549400b00414624c0aafmr866477wmb.35.1710829760636; 
 Mon, 18 Mar 2024 23:29:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a05600c450600b004133365bbc6sm20189118wmo.19.2024.03.18.23.29.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 23:29:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 4/8] target/microblaze: Use 32-bit destination in
 gen_goto_tb()
Date: Tue, 19 Mar 2024 07:28:51 +0100
Message-ID: <20240319062855.8025-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319062855.8025-1-philmd@linaro.org>
References: <20240319062855.8025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

cpu_pc and jmp_dest are 32-bit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4e52ef32db..d6a42381bb 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -121,7 +121,7 @@ static void gen_raise_hw_excp(DisasContext *dc, uint32_t esr_ec)
     gen_raise_exception_sync(dc, EXCP_HW_EXCP);
 }
 
-static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
+static void gen_goto_tb(DisasContext *dc, int n, uint32_t dest)
 {
     if (translator_use_goto_tb(&dc->base, dest)) {
         tcg_gen_goto_tb(n);
-- 
2.41.0



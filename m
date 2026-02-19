Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D120BE9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt57j-0000PV-Lm; Thu, 19 Feb 2026 09:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt57f-0000Nh-JJ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:35:20 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt57c-00038V-Bb
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:35:19 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-436263e31abso952006f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771511702; x=1772116502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52Rc446xe2dQaFht4UOxDu+6HVWFzHT4d7x+yDo+hRs=;
 b=PaBeCJeAwKUCuByZcsVmOrrvpXLslSybGu6GW402Krdy5eQiNEaZfOWDvU94+3xUYA
 sYDIrxBKqVvu6lteVqCREq2taTx27uVQM0iQPRf5AzYfNlvf3GLhszfQ5vrrvK15csPY
 k1C1w7VR0DxkalGbJUfqLF3Za1LtWpip5SjSjkWEJ9j0DwtQ2BHrqjvrPCa6q8cBxlXt
 5UdyEjUULy2PtVhMGogLaz5mIWtpd0FSklJfnip+/yvcgznqKaG2LemNm4t8j24gLTaY
 JyepHV2Np/KRf95MvpqaZtmcALwZi+Islp2afpul/YyTpSvVfxNI9ym0/3Et1GSfNIbd
 OajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771511702; x=1772116502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=52Rc446xe2dQaFht4UOxDu+6HVWFzHT4d7x+yDo+hRs=;
 b=mN0WRTU0mfrFu05apv6V+38o0e2Hd0UwiMLM4BhYGXmYs5InEG40aW6aUN2QOIumTn
 eptXcptBG/l89HkogaZhy7hoVCVabipNiKJf3ewnpZYHfCfZxjf8meIKD4njogk28yb6
 rkB6aBlbiV45YJRdPOxRfhlvEmlE18qC85vKBGBSU1f25bAkdFVhpWo5mwmG4wEbQ+Zv
 KkJc96WTrgJZIn3OPxBYvREunBztzzMR7Zkvt0X/XIdYNl7dSU2Ks+mk30qckR9Ldv4C
 SGA+A7IKs1irEQE0NWq6IUMY6ju9cV1SPqRhZtKEMYs9guyUrmL6nFz9FgtdEPyDqj9z
 rLZw==
X-Gm-Message-State: AOJu0YxyxMXLlEPmLAYUeKwx3bqAkgecEC8/HN4zcE9GXiCV1ILuhBiO
 S28cejaSDnQb8fHTDup8MO+RpIOyTeO3zI5kF1ByFk91vsqcBBQcSxY7nPErzK+8
X-Gm-Gg: AZuq6aLqtr5ETeFQSMMjq6GvOjM7rCk7JlP+vKmsJ7dJgiVbRTG94F5d8U3zrTO/gbd
 Utckfljbk1iPR4087nCW8Qo11EO9XPdcQWJomm74R7gOhKZyb65JmloQRaPyr5IxNtfAxY++cR6
 +mypEinK5TSf7I+y8Opnw10sVlzX9/U4hZojmdTAVojnMqOIgEUAPz3sogOnnOxG+tnKwIwrpJ3
 XT6MV1G0qJJ2iRfG4KYeXIHhBlf1kOeUT7mr+O4+Cvu3PTbeoo2DkopM0rSar8er9vrf534K/Cv
 9vQSMatogDzkIh+W8cP7YlJsD2zNvxXaeCkanXvoe/35IEWig7UWf+f4Zoey7WWoCDYQ+G+5Qu4
 7bddgJcLzGPJrtO0GJ+rcSTR5T4wt6Ti1RJhAFQHcd31ka/zT7PGfPiZ5TbR5gKq3Q6eJZu6SxK
 AhYQXT43IZeC1PHAAuVvHC0ywMuU4/zCdkS3jYkXJqvC64He1g4Zbsy8MR0k7I71bQc2fw1BVh8
 Q/Ibl0=
X-Received: by 2002:a05:6000:40cd:b0:42b:55a1:2158 with SMTP id
 ffacd0b85a97d-437978d4f1emr35148042f8f.17.1771511702220; 
 Thu, 19 Feb 2026 06:35:02 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796abd259sm52022770f8f.24.2026.02.19.06.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:35:01 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 18/33] hw/core: add fdt_generic to the build
Date: Thu, 19 Feb 2026 15:33:17 +0100
Message-ID: <20260219143332.3316679-19-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42c.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Add `fdt_generic.c` and `fdt_generic_util.c` to build
by default.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/core/meson.build b/hw/core/meson.build
index 8a96567de8..b5ba8160e6 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -29,6 +29,8 @@ system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutl
 
 system_ss.add(files(
   'cpu-system.c',
+  'fdt_generic.c',
+  'fdt_generic_util.c',
   'fw-path-provider.c',
   'hotplug.c',
   'loader.c',
-- 
2.43.0



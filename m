Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B915C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 20:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9qIQ-0007mK-LX; Thu, 24 Sep 2026 16:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x9qI9-0007lo-QS
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:43:44 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x9qI8-0004hS-1U
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:43:41 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b91369d18so1803415e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790282617; x=1790887417; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GLcrGbVrwqcZ+0w7gtR4KVTA9WShm+jfyHLCcUeJcAE=;
 b=BNnfs5DX9+sh4e7jjgsrwjJxVnwUy7tLlll68bOpXtZkYGE3aB6E9MP5UWVF/38u/F
 5/3q5yq2U+P930/UPi7BGkrDO8W9ztBjJKcJboqw4UB58e5t3prYmAaRtrq9Kpq83gI4
 FPt9TiVXOPVFI/EKrXw3Pa75aKR+/EyxvFhcx62Vhqmt5yYzW7xWZlnJUuzhuCTO7mQX
 XFSRLZxJiLpJCpfb2Tj3dOnWIqtJgaUfNr1F6+QhUXZelYaFVyoDuxQPX90bMVFoStRL
 8RTVSSVyZU/7ftIYJKjzE2k/CT4CPI1xCqSb+Hy/VRx/8C5K02UyvHvjoqAgxRQ4591K
 kgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790282617; x=1790887417;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GLcrGbVrwqcZ+0w7gtR4KVTA9WShm+jfyHLCcUeJcAE=;
 b=X40K4gzsLAWhoL9RqitwjYlzi53EdjqWmz1v8Rs+LgnMEglJiSt/F8igltbs4TT8kY
 U8pOmVwhbpQJp+IMkUCtgMPNlW1Du5BpVVHKRJvzrAhLrHPqTk4jaEmOm7YyVgdtnyOb
 vgtj82x82/g5YI7K5thEvyMgxrFlOE8VBdK9MUHVJO2xmKC5+vXEE3kNO54FurLiYoIg
 koxLEgljrjVia8DZQmKxHVsX8vgn/dmvF6daFoW+nClq4W8V5dkJQJFjzqU1bWCr3hbq
 VNOwW3BvVqfW89boyZam+0PoJB6QK8YEDxkz9/5hUSSGHKyf5AfFS0veUcAvERiyd6kf
 JVQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJJqbEjX14b7RIh65HZFN2+MJJUp1z0CdT6GdgAAUUOC+UhiuKgvJjWuAzccOZb5fTHNFa2GeUQHPp@nongnu.org
X-Gm-Message-State: AFuF++nCabL2t1/+mFcz3wFFHy67sVzzteWkbDanwIccNYmrPkZZOgvH
 fIVq0HmKLy38N4i0DKIJIfrtK41a5QUag2bhl2AMj4OCWkKL6TBr4ujO
X-Gm-Gg: AYBFou2to/qRbggvtAdP+FD+5J7IhgO7rs/g8QGNNpT2GIFAl3Re1Z0oszKbm9/SBuL
 aL0Q1cU91On9RtjQjZGS5Gf6QerB0k/Cev0KJHpCmS+IUo3jDx8jJ2nhZpUJDbatNUOWMTeRpN9
 VcuXF9Ll7EcsWs0R76P+Xz02YKGREfxQTvxhtQnLxvkAJuffd+4Ps7zR0au4hGRXipq59z/OzDc
 Q53GQdYuFHUxTBw0IAERbtTwtH0WiX+OtlLGa5X/fEdfqeeu20KhEJh/MfdNJ0KSOQ8lIcCDXox
 jmcmSfSpdWEPVt68O9dvcDiM37nA4PG3zbwdkC2visrvtNpxgnzmGz5NXk4vA7BD7XDIyYsZnIz
 CpfcqnbXGAxG0CPj675S0t1X1NL2LiBKu4tO4zf02o4Ib38WNf+XWnFVvh+xvFcW6IhCVG8IkKx
 q3xPtCXIsWOmXUrYqfzoreA8jVeVZqkJ1DOKD4ESWIEsXuWpzJWfgx3iNt+vC3kMvIhWk9PnHBb
 ETOyStgQNjXtCrkEVKJyECPV/q7BkzQ8zIKkbG4c17Pp4OAIcFs1MlbXEc=
X-Received: by 2002:a05:600c:310b:b0:49e:7862:c09e with SMTP id
 5b1f17b1804b1-49fe66c6289mr65705575e9.14.1790282616696; 
 Thu, 24 Sep 2026 13:43:36 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-077-191-033-034.77.191.pool.telefonica.de. [77.191.33.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fef4fc959sm8107815e9.2.2026.09.24.13.43.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 13:43:35 -0700 (PDT)
Date: Thu, 24 Sep 2026 20:43:33 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_tests/tcg/meson=2Ebuild=3A_compile?=
 =?US-ASCII?Q?_test_with_-fno-stack-protector_by_default?=
In-Reply-To: <20260924202012.2465-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260924202012.2465-1-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <018A9A4D-629A-4849-8654-F23944AE6E4E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
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



Am 24=2E September 2026 20:20:12 UTC schrieb Pierrick Bouvier <pierrick=2E=
bouvier@oss=2Equalcomm=2Ecom>:
>Some compilers enable stack protection by default (for instance, on
>archlinux)=2E This produce a compilation error on some of our tests:
>
>/usr/sbin/x86_64-linux-gnu-gcc tests/tcg/multiarch/system/interrupt=2Ec -=
o tests/tcg/x86_64-softmmu-interrupt=2Etest -static -MMD -MF tests/tcg/x86_=
64-softmmu-interrupt=2Ed -Wall -Werror -O0 -g -fno-strict-aliasing -nostdli=
b -ffreestanding -Wa,--noexecstack -I tests/tcg/x86_64/system/=2E=2E/=2E=2E=
/minilib tests/tcg/x86_64/system/=2E=2E/=2E=2E/minilib/printf=2Ec =2E=2E/te=
sts/tcg/x86_64/system/boot=2ES -Wl,-T =2E=2E/tests/tcg/x86_64/system/kernel=
=2Eld -Wl,-melf_x86_64 -Wl,--no-warn-rwx-segments -Wl,--build-id=3Dnone -lg=
cc
>/usr/bin/ld: /tmp/ccs11W6S=2Eo: in function `print_num':
>tests/tcg/x86_64/system/=2E=2E/=2E=2E/minilib/printf=2Ec:45:(=2Etext+0xec=
): undefined reference to `__stack_chk_fail'
>/usr/bin/ld: /tmp/ccs11W6S=2Eo: in function `ml_printf':
>tests/tcg/x86_64/system/=2E=2E/=2E=2E/minilib/printf=2Ec:136:(=2Etext+0x5=
49): undefined reference to `__stack_chk_fail'
>collect2: error: ld returned 1 exit status
>
>This flag has been previously added, but was removed when moving tcg
>tests to meson, with the goal to identify which systems require it=2E
>https://gitlab=2Ecom/qemu-project/qemu/-/commit/580731dcc87eb27a2b0dc20ec=
331f1ce51864c97
>One of these system is archlinux=2E
>
>Thus, disable stack protection by default=2E It has no impact on tests
>results=2E

Thanks for providing the working patch so blazingly fast!

Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>

>
>Signed-off-by: Pierrick Bouvier <pierrick=2Ebouvier@oss=2Equalcomm=2Ecom>
>---
> tests/tcg/meson=2Ebuild | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/tests/tcg/meson=2Ebuild b/tests/tcg/meson=2Ebuild
>index 75f0a52fd22=2E=2E35b3dff4ef2 100644
>--- a/tests/tcg/meson=2Ebuild
>+++ b/tests/tcg/meson=2Ebuild
>@@ -426,6 +426,12 @@ foreach target, plan: tcg_tests
>                                       '-MMD', '-MF', '@DEPFILE@',
>                                       '-Wall', '-Werror',
>                                       '-O0', '-g', '-fno-strict-aliasing=
',
>+                                      # Some host compilers (like archli=
nux)
>+                                      # have stack protection enabled by=
 default=2E
>+                                      # This results in a linking error =
for some
>+                                      # of our tests due to missing symb=
ol
>+                                      # __stack_chk_fail=2E Thus, disabl=
e it=2E
>+                                      '-fno-stack-protector',
>                                       cflags],
>                             depfile: exe_name + '=2Ed',
>                             output: exe_name + '=2Etest',


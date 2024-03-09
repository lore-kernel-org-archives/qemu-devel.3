Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92632C54E66
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2I3-0000lC-Ss; Sat, 09 Mar 2024 14:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2I1-0000i4-D2
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:26 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Hz-0002ad-Mj
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:25 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5654f700705so3903087a12.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012202; x=1710617002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A3YPWAKLFpXy74v59/y9ZVQ7mfzqWdCePg5o0rXQJdU=;
 b=uZcIsl1r4tAg3Mgcng1cPmj08G+ID/2Ui1lNuGzmdKBAf3ALX45pAO25aamLHzIXAE
 YH5rYaBbW4Mv33yiM+kSVRdwCiaoKMig+DGmrswWOAknup6EgZBHxSeDnEUUkr50ovro
 KQru4+CFjGWfW4/Racgq2EaP4tuCBqzVD0dvKT4l/uJMsd1XaOpdILd9p0i1Q7bQr+9Q
 /F5tXjjzy/f0MUfo4zQi3w5itJQPpE0e57NPzUzu1uFnHWCS+pesefSpnsag4ISd2VOH
 DEY91iKfRytemyNqiUnn/akCzK7GTDWtozH2xKmpRNHMn8MMvQIbIxHMo2ZyCrO4drXt
 2UQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012202; x=1710617002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A3YPWAKLFpXy74v59/y9ZVQ7mfzqWdCePg5o0rXQJdU=;
 b=jaJvpz3fNQJRVl7y7wtFfBPQ6jQN0JKwSx79M8O6of5x9SxiaI+8SZotfmOy9UHAH1
 uv5c2DRZdwXu62zSQkhqubkXmezO6nbdGtoYAEXUcdV8L4So5WVO8+Mlavvdh7IRylAq
 Axs2Cbr0OXMdtnUoFTMpMMde6pFB6sHV/pRgw9szsPqwAOIyh4GrYlOVhoaTKGzjP5D7
 KgEO1hq3ulrRGoEOxFWXrKr5OItjn9n7ZY31kyGlhMtlRHtLOYgxe1K1xQtLXHGZzQXR
 SHF030FKojg02Bo71p3p2Uvu/Jk1azj5IEeZkMV51kivEqyqeMwbC4xESvLmGKZ9gnEG
 GeFg==
X-Gm-Message-State: AOJu0Yyb1TDxkzZ9/+uKPx/Zxa9wCFHwek6Ny0fEPyQ/WlAoze8nqJju
 KCGm1eTfkqvNh9e3GqHu1m4Z3JSzYIji33FUApbssh4uJNmVyMegwCUmG1QkkDUWCn3XNyx/DbW
 A
X-Google-Smtp-Source: AGHT+IESzjyaLuyggJlbtw/UU7wtPA1UXBAfVV9w8oQeEuaTMGyVqGqT6YAp9h+VrsWLnSESfaBeNA==
X-Received: by 2002:a17:906:b110:b0:a45:c9fb:86d7 with SMTP id
 u16-20020a170906b11000b00a45c9fb86d7mr1387127ejy.54.1710012201803; 
 Sat, 09 Mar 2024 11:23:21 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 g21-20020a170906595500b00a45a96a9c37sm1182786ejr.65.2024.03.09.11.23.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:23:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, xen-devel@lists.xenproject.org
Subject: [PULL 11/43] hw/i386/xen: Compile 'xen-hvm.c' with Xen CPPFLAGS
Date: Sat,  9 Mar 2024 20:21:38 +0100
Message-ID: <20240309192213.23420-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

xen-hvm.c calls xc_set_hvm_param() from <xenctrl.h>,
so better compile it with Xen CPPFLAGS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <20231114143816.71079-19-philmd@linaro.org>
---
 hw/i386/xen/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/xen/meson.build b/hw/i386/xen/meson.build
index 3dc4c4f106..3f0df8bc07 100644
--- a/hw/i386/xen/meson.build
+++ b/hw/i386/xen/meson.build
@@ -1,8 +1,10 @@
 i386_ss.add(when: 'CONFIG_XEN', if_true: files(
-  'xen-hvm.c',
   'xen_apic.c',
   'xen_pvdevice.c',
 ))
+i386_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
+  'xen-hvm.c',
+))
 
 i386_ss.add(when: 'CONFIG_XEN_BUS', if_true: files(
   'xen_platform.c',
-- 
2.41.0



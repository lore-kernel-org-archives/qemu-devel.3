Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A69EFF885D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 09:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGZTF-00058i-Kr; Sat, 25 Apr 2026 05:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGZTB-00058L-Bm
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 05:38:39 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGZT9-0005y8-QB
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 05:38:37 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so6960495f8f.0
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777109913; x=1777714713; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/SOftPWfgTVcpYSKddW04EAimM0BgrwjcI4dSfJiO9w=;
 b=VRYsrPuLHfLV6dW09laGu6koa0Ft3ohGm7HKmrZaNL2EeKzcT70nCUvofm21Npso9w
 btH4odgHUvNPob1c8EhRh+ERSKayeu6/G22WWOnGs+GvgYFo5uqY4Iq6GRWxb2maOKUN
 Kp52BRvLyb2jNh+PpzWEAvMKET6evNNd0AkC1uYfYRTH8E/bXL9CtQ8XW8LrgtAvjuz4
 Rja6mMkQUH552spvTYgxKh3wnUdqWXFn015ZNpfYnrnYax6AHW5ZoGDue+RaGXF9sMQY
 0onU7sXqmuH16zzaEh34kZjC/3eYochi42FBEgeCmJEBVQ9/589IZnfX7LB8T4hKBx7S
 wgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777109913; x=1777714713;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SOftPWfgTVcpYSKddW04EAimM0BgrwjcI4dSfJiO9w=;
 b=kUfUuHscWCLn5ZniQJx6o2W1eVCsE6i7ME0lPV8f4+2hnOOrD/KuvC9Lc/aJ07A0rz
 EPkVV9utm2SD1/VyDEkjEjheJbCjAkxouzPI13A/x+4/Vs/gELyfe3eeW+z0T7LsyxcA
 bGULm6TagoBpDk2MqCSoYk+UQwaHFWWicgbCYbooRAkg8oU1Z7uYpTdsSEv1O9OGGoel
 54md8B78+gWfa1X1OM8KSVLRZl6EvXSoOwZxEzhvjY0855P+KDM4JPxmERnhri52uIF2
 crE6TbWTVZmgNxetXMvJ8PmzF9Wsf7nPA+f05OAqgXBrL7CFVQU5/7F3kC/MBoWeotii
 VN+Q==
X-Gm-Message-State: AOJu0YzvXDLDyNoNc9st1pA6WbZPIiLb37ZNlXtrEA8UMNTzkcsEKEvT
 GxFXip0Of3TNRzCjVDK6SGLlYDjqZ0mbQbRtAAIafc9qNPVOYoUxbXhgKnS9eJO7evk=
X-Gm-Gg: AeBDiesxMdBV+Ma/mFoZn7JZyxpIoBbI8ddYXLGbiBJL/gt1tCebCr0LjmyuMc2A0Ou
 zKuHgaF14DxA9pMOb4yen+rgUWocDxae42BoStMub6GK3vP/dTYaO427YgDvrZtiMXtFD2/pOaH
 oK7WO5TkQMzVM2qXAEgqqcVErXpNj7W+d+C84zucHb6eH4hoCn3jLwvQ/afTIe4Joypw81wH8/N
 C3Ew/rFV1apMWq0x96Tb9zGbVQxKdBn+cfgqMBy2jpLXFsCJGI7Yk7EYEoyHPXMS7uRn7ya4te6
 ukRvmuEvwf+LQC7D+BpGZjht67H5miS1irjZM01u/tBjgNbJDDa9pFTJgbcEDUBhhqdy9ODaxGy
 N3+sXBcewCfq06l+0yMnXy+US3xBNSD7fjSy57tuVz3D3wzshpFTyRTHTUcuGm+wpwCcTl4bsPP
 8jDf5oKmEo4WCk1DCS2XwixVOASdy0a1NxG2KlPPrtDopaeap/+g==
X-Received: by 2002:a05:6000:24ca:b0:43d:c2bc:21b0 with SMTP id
 ffacd0b85a97d-43fe3e0c647mr52296583f8f.46.1777109913228; 
 Sat, 25 Apr 2026 02:38:33 -0700 (PDT)
Received: from [192.168.0.10] ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a18csm74965992f8f.20.2026.04.25.02.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 02:38:31 -0700 (PDT)
From: =?utf-8?q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Subject: [PATCH 0/2] Fix and re-enable GTK clipboard
Date: Sat, 25 Apr 2026 11:38:30 +0200
Message-Id: <20260425-gtk-clipboard-v1-0-6bd99e708e14@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJaL7GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNT3fSSbN3knMyCpPzEohTdtJQ0S8uUJEPjxGQDJaCegqLUtMwKsHn
 RsbW1ADznxtBfAAAA
X-Change-ID: 20260425-gtk-clipboard-fdf99db13ac0
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jindrich Makovicka <makovick@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=makovick@gmail.com; helo=mail-wr1-x42d.google.com
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

The following patches change blocking clipboard retrieval function
calls in gtk-clipboard.c to non-blocking variants using callbacks to
avoid UI lockup. It is a follow-up to the patch proposed in the GitLab
issue

https://gitlab.com/qemu-project/qemu/-/work_items/1150

This version adds a similar change to gd_clipboard_request that also
uses the blocking clipboard API.

The second patch removes the gtk-clipboard flag, keeping the GTK
clipboard always enabled.

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
Jindřich Makovička (2):
      ui/gtk: Use non-blocking clipboard retrieval
      ui/gtk: Keep GTK clipboard enabled

 meson.build        |  4 ----
 meson_options.txt  |  2 --
 ui/gtk-clipboard.c | 47 ++++++++++++++++++++++++++++++++++-------------
 ui/gtk.c           |  2 --
 ui/meson.build     |  4 +---
 5 files changed, 35 insertions(+), 24 deletions(-)
---
base-commit: 4bde339ecb41b16e90810233ba5ee2fa87bd443f
change-id: 20260425-gtk-clipboard-fdf99db13ac0

Best regards,
-- 
Jindrich Makovicka



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CA9FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOBJ-0007hZ-Bi; Wed, 25 Feb 2026 18:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBG-0007gd-Db
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:35 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBE-0004Aj-HD
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:34 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43988056dc3so218698f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061629; x=1772666429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wObpQvjJPZ+6lXm//YEoiVHwjB+uhySEVUFPC6AyumA=;
 b=cogkrhsWRuw/s18WgPIF9V0Y6kzeLHPyYgII7GosXzHrcoHodR2Xv2DiV1+zQ/aNxk
 1GR6697y33bbH366zyXl9pBMWq3bBVT5b2Ur/RkusbhvRRFQpc69nWdcSruifKmXDwJt
 92p9DDVsNjdA4BOAqf+aRF0jQd6UX6KC8GN1WqRBosnh9lkJsjksD89bBR0UfPhZ5Vcj
 n5+C/f2Wt9E5CzhNXIdPhAxSz3kV7iaguKm02qYSRLbmzU0OycX3fWQ0KJQbPJgXhG2N
 wAFk2MJNNHjEzNdB/dM/PeeDUHvV5pg+K5vY039uifopMKCM00VExvm/cqQRgQ6aC5Tt
 MfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061629; x=1772666429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wObpQvjJPZ+6lXm//YEoiVHwjB+uhySEVUFPC6AyumA=;
 b=pBGrR9c1BJ310b9Q42T50tjWvojL/Kq1o30+2HV9oyrw9fRxQlurgM3UA/1LvxvQRx
 3jbN2OwV7kYe3fhKSpq1WtY2XzDqBrcxRaBgo+H5+XysjzPcuB02hPQxg63v+dID2KcL
 9AvezK+TADLkgfrIz+EP1r8UPTnap2wBOidFYhii4kWAXzmprqT25QzpcScgsrm6BFIb
 NAsAGbIgeSuxc5Y4sHmC2cXVZh722Tl+MMQRCTRHRlKR+MZv9VKF4SHPcYrxKzJ/+OkY
 zm2EkOVcpoiS+shAkvGj5jqT4tNlbdld48Zp/E29GerMPgQhQOhJWGixJ9Em+EjFswwF
 /JEw==
X-Gm-Message-State: AOJu0YyS37Cj7TcPy140MK2XwW7D1ZEJilw+HCrKow02qQIRQ/UukTTa
 O2HCglELoe4Psl33NF8bDp8xSIuy/DRfb+da5OS5qAakDsDt5tYY0pCzzcVNfJTOZF05PDmIG3u
 O+WWxhDM=
X-Gm-Gg: ATEYQzw7HgHdZWq374MHNDDE7jISe73mpMrPBAX+5ybzEH2jQFPIX9AK9jyNTvmvS/A
 JUFFGv4rcKTAQVd7DgZPURc4tL7af/KRSZPQo02IRU63LGirwR4AuaW6MO73YEejB8usi+1gAZB
 lLeMvVdt5rLF1VIlwS11jk6n9CB0eTkNmqamUIKgcJcXwOz6oPrYzTIvKZ/ob755gJ/+FHWBudU
 pRl56WmZHvphmdviHBNuTdD5T4RKWBZo/Jaw4LSTB1B44QHhj9M3RgcEVbjHNWKlnsbQ4peVxkA
 xT04nT8adqQq68dOqrAOqyqNS+ytmpo+NK2ADgYxnm/q6BIW6b8BJAglPs9PB1ZZhYJaL7FYzfi
 iqb4qjV/7iKnYCjg2R2HJweHQ7GqJ8lhA58+DH0bZRFp4y6OGrqcnUYDxDc/4GpGFb1kePPJECj
 J0d1ybhENM6bndouMja1dZxx63OdhdXytya/wB++KaR9WEJF0jIqplAVQRbGFfGEGp7dC8jt0W
X-Received: by 2002:a5d:5f50:0:b0:436:216:98d8 with SMTP id
 ffacd0b85a97d-43997ed6f02mr586825f8f.12.1772061628929; 
 Wed, 25 Feb 2026 15:20:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398a292babsm13320021f8f.37.2026.02.25.15.20.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:20:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/70] target/rx: Build 'gdbstub.c' once for system single
 binary
Date: Thu, 26 Feb 2026 00:13:55 +0100
Message-ID: <20260225231411.96482-56-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

There is a single qemu-system-rx binary, but by moving
'gdbstub.c' in the target_common_system_arch[] source set
the resulting object can be linked into a single qemu-sytem
binary.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-48-philmd@linaro.org>
---
 target/rx/meson.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/rx/meson.build b/target/rx/meson.build
index 86dc231eb0a..d80ced11e2f 100644
--- a/target/rx/meson.build
+++ b/target/rx/meson.build
@@ -9,8 +9,10 @@ rx_ss.add(files(
   'op_helper.c',
   'helper.c',
   'cpu.c',
-  'gdbstub.c',
   'disas.c'))
 
+rx_common_system_ss = ss.source_set()
+rx_common_system_ss.add(files('gdbstub.c'))
+
 target_arch += {'rx': rx_ss}
-target_common_system_arch += {'rx': ss.source_set()}
+target_common_system_arch += {'rx': rx_common_system_ss}
-- 
2.52.0



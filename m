Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493B2E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Kl-0005D2-Gg; Sun, 12 Jan 2025 17:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Ki-00056o-Nr
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:21:24 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Kh-0006ug-52
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:21:24 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43626213fffso28747015e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720481; x=1737325281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jplKRfSDPgYgS9ZhmEN8q4tNBprQ5haG9I8GfDv4PBI=;
 b=mnBERZIia2KueuTYtHRRsPReAtumPCWCRydYTqSKnJeLaItHg353D3ef2oTcuG+iS3
 7akIQQDIn4+FhVbRvu0auQgGvyjfJPDZa2RFfMd9qom9Dt25DOFLM+YM0O65zSMkrY7S
 PyTOxFdUKasfOKhKTBXqu2UMmFgdQgK5Sh4CrnCtRmVCxDwoNU9dPzZLFTI1PU3Oc6Th
 LgpLPyrlUB/8Ty6zuMjc13HmX0703QcF03NUH5JIo9wZZV9TPdS7QQWJV6o1EH0HmCP9
 5SHx59nUbSbLZJagpHV+fpgHAAITDzpzFuAhVaa0jr8jd4sKvsw1HqE4u2SvIkqWj5wN
 g2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720481; x=1737325281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jplKRfSDPgYgS9ZhmEN8q4tNBprQ5haG9I8GfDv4PBI=;
 b=bJFEdZI0dQYnM+K+X75Vxvrc7obrlmNO93GsJeV9Si/gSIklHr5guneXrFmt3dA+bZ
 dfiM3hN8lOWHwu91xp0/Nh/mjfIMReKAuehXarkIuLu2bp+K/4cOgRzpPriMy7kGqBAI
 zWpLg46LKceJ+MeTNRAE5U9Gmmd6di85mM6GY3Ik9mQ5n0Ylm7ycuftBvFcvA+oOfrZR
 026lVkhh0676T9BIErFU8OOteSKjk6Qh/1XQREOYb9ZNmA+JWVPIxohCp0/0jHKnBtXX
 KYxCts+UTCspBzlGMLCgv+I/QQRrOJHoHXB50m0CmLe8ekIjMo9ugTV8OWyg7jocDYBt
 LTuw==
X-Gm-Message-State: AOJu0Yxgc221PUXzJkqu+DC31K1Qq2URLd5+2B6cAqrPAMycNeqE5oIw
 85PT9TuYho4PWbj5uJ9EyiUvj6AI8YI9plT4wTiNRzflm+MK4Rd+W0aV7L3X9e5owjeXS2Rmaka
 V7Sk=
X-Gm-Gg: ASbGnctzKQOsf2QVvgbxBY8MwP+I1wz7ogex/gGQwheMyChf0bkIcSLHHQFvSKKreJA
 m6d8CcHgBEN3NxFd27gOMxIIMhxhMvnvWEugD53Lcy+m0Q3HNSbBEhSUUOeAOKo9WqKCazX9NvN
 gGRLu/nYuB64PhC6MRfKdILWXHLrgwcP2Br7kt2omOTyl5htFY7WRDXtWflekFbSDOAXMp1qBP7
 Xj7EU+0pSnKx1lVyy6M6PuvbyMj/Jd/T3zfI9ui+zdgIZZhZnU70N1HNeEeMg6rIxZJ840HxjsO
 sCZgqLMb6RGCqxll64uk3PGGp7Jayzw=
X-Google-Smtp-Source: AGHT+IFDY6x2zHEwuTF6+izd0Sy6HNF+LGvaZPh7dKFk00hjtX9gtteXDt7/hdXWa+0LCBhjb5S/qg==
X-Received: by 2002:a05:600c:1d02:b0:434:e69c:d338 with SMTP id
 5b1f17b1804b1-436e9d6ff89mr105295795e9.5.1736720480817; 
 Sun, 12 Jan 2025 14:21:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38f0eesm10778429f8f.61.2025.01.12.14.21.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:21:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 47/49] MAINTAINERS: Add me as the maintainer for ivshmem-flat
Date: Sun, 12 Jan 2025 23:17:23 +0100
Message-ID: <20250112221726.30206-48-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add me as the maintainer for the ivshmem-flat device.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250107015639.27648-1-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ca3981dd25..0727579cdec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2785,6 +2785,13 @@ F: hw/hyperv/hv-balloon*.h
 F: include/hw/hyperv/dynmem-proto.h
 F: include/hw/hyperv/hv-balloon.h
 
+ivshmem-flat
+M: Gustavo Romero <gustavo.romero@linaro.org>
+S: Maintained
+F: hw/misc/ivshmem-flat.c
+F: include/hw/misc/ivshmem-flat.h
+F: docs/system/devices/ivshmem-flat.rst
+
 Subsystems
 ----------
 Overall Audio backends
-- 
2.47.1



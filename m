Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00471E7718D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJHB-00058a-O3; Thu, 19 Dec 2024 11:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOI2d-0005t4-AJ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:02:19 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOI2b-0005kO-LT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:02:19 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38634c35129so678859f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734620535; x=1735225335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPqPkmRu06PLtD07PG3Rk588BhAhOdUz1634l2fW0GY=;
 b=HWVeSetfFUiiaGFShKJ7nQq6n/5+r9gwKz1nTF0+8ZRbKq4iTn1/37l0YXtpDgRwI8
 0NzoPGkfWwoCQYpHBajN3PPEcBO83Ywzg5H8YePBp6zQdbmvyiLlv6CVfX2442vKWiXA
 eB9HqJWI773z5ROP/rZPT2TTJv/l66IP/zLbetJUjMnAQDFjAwJSZ7Z1uJpMaq1NCMPF
 Za4WXmOI79P3T4UIikMAi/x3+s4a2iQ2YaMytzQtdDyEpxfZzweFHkWb/yQfosIvrbLu
 UG293jcxESo5CYOV+L5XmproxvgQ9W78OLItmeM1jV8qU6GSjhigM35Qdy96MKdAjjYk
 kmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734620535; x=1735225335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VPqPkmRu06PLtD07PG3Rk588BhAhOdUz1634l2fW0GY=;
 b=owvHU67I2JZa8mavBWD7KC6IYgmsjDLMBDjHfds3CmWTODCTCgZu0MX5qe2xjngpwR
 VA37qnm9+VgpP9VZswmQtZDK0Nel6sLIICBBIyPffoEYS0mjlNVVSVWjog60KrfelprZ
 jGvLzZRZ7EtwqYFKBZ328h9HkQsB8zmGgutwdLOiTxB4mjsM/Awh76R4QzGpKyhM3AxH
 xSwJUat3DBcSSKcQTr8SmZJJ3qjj5GwqCy4+0HrUHAHEGRAPBdoU9idOzWq3iEwH7vsy
 3I9C+pUM02IjZt6PTOkW9M2Zfx+IIrjEoizyiAO79OSdLqE0wTrYn8WaaOHUoYyBVrdv
 aeVA==
X-Gm-Message-State: AOJu0YyZDG3Sl9dVVwvmDSPVl4OO//oSlFF6Dt+grrIg3p2dKIrRuKB7
 vdpaKSv+yuCr8BHCMHzFbwWOcfOLIBYYec112/n+bnBD8j69jlbAEP7/2XItixq2D0xFe6p5cLT
 Y
X-Gm-Gg: ASbGncubeuxBzvS8UK+15PVIbFtKrZpDmz3QWUrLfQMFiKnj2Z/+WU7/CzJX87hzF7a
 bxKXokL6jMINDCdQq4hoUTd1OOSwNvw9jE+iYHm6mlgeJz7cAoTo0DX2XnH5A85CZPqnAg6E0vY
 F4eQTvZOZ90oUqkQJsPSqea+1ppgGYHGMohMo5YCuig/qOsgFRIr2C5KOV1dE+1Dn3OQvvFgyCr
 JBt2NltG/spK0Zb/j7Ebvrrn+fVNamuFhsU8HkXGM++YKrObcoxibUjF2fwoiYD66NlbEyvdCW5
 1N7u
X-Google-Smtp-Source: AGHT+IGLoCDAI7+7/qRP8XJ1Hp27f6ADvI/B9bhtUf3E7A2xeNPLoE1KMGzGhPOyBtMhXVXNSi2cew==
X-Received: by 2002:a5d:64a7:0:b0:385:f560:7924 with SMTP id
 ffacd0b85a97d-388e4d30f16mr5741383f8f.4.1734620535409; 
 Thu, 19 Dec 2024 07:02:15 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c493sm19969735e9.28.2024.12.19.07.02.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Dec 2024 07:02:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] docs: Correct release of TCG trace-events removal
Date: Thu, 19 Dec 2024 16:02:02 +0100
Message-ID: <20241219150203.55212-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219150203.55212-1-philmd@linaro.org>
References: <20241219150203.55212-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

TCG trace-events were deprecated before the v6.2 release,
and removed for v7.0.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 68fe0b47f9f..e3a87f3f555 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1087,8 +1087,8 @@ processor IP (see `Intel discontinuance notification`_).
 TCG introspection features
 --------------------------
 
-TCG trace-events (since 6.2)
-''''''''''''''''''''''''''''
+TCG trace-events (removed in 7.0)
+'''''''''''''''''''''''''''''''''
 
 The ability to add new TCG trace points had bit rotted and as the
 feature can be replicated with TCG plugins it was removed. If
-- 
2.47.1



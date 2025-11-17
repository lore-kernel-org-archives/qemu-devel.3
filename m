Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE43CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2k8-0002in-Dh; Mon, 17 Nov 2025 12:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL2jT-0002KV-BH
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:09:40 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL2jR-0005kM-0B
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:09:39 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso37823165e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 09:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763399375; x=1764004175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fo3m93QgAfXweZgvBwggdTWa4sBOV4sqi1XMrWrnlhU=;
 b=kmUBohKiizZuRDK7aEwdKACuaUj67jogs6dLt0jvLw+Z9HfmWaye4zkxS1V7OlKWRX
 dnOJ4/+T09Yg7EudrUFfBIQqcSv/JoEeB1FJC9qgJJkxs/mJWBeo/nGDXuorImWXe0Jd
 CIaGhDOY/yufyelenpNlJz1vgyw9n29qZm5Oa0Bre/ojdETtyrO6g+0VDkxDM6josvJh
 OfpYyuCgSIZ/hEuLTcLEK1UMhsY4GVt16ve+LGWgLb2kx/3MGD/ydvR9NgUQQXFJ2iVo
 q92RFpdrbEHYGuhKENjxAwSCHdnh/ixOrm/tmwYvSy44jYjpS2wKj8/txa6xFapjigXI
 +R0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763399375; x=1764004175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fo3m93QgAfXweZgvBwggdTWa4sBOV4sqi1XMrWrnlhU=;
 b=utUpXU/AtB0N+QSzGzrWUS84z8SB4suinO/ACyDg2jBZZxiDk3zXfSNI7YU4HiLWfJ
 7WJao07wbq0KwRQCyY9tgabddSCUfIM2zbbGVrg6yhwJ7yR0M6ep4Xh0OG0yxyOlMkb2
 Vq6vdS0dt0pF/OsLLFCiyaUHeKYloZrEPO+awDnO8GhmQ0QSmPNRG4QTK/sN+eDmD1Vr
 SsMedP01lQdbhTo/fReRf9GcPh0iJtm7fyH9GzKPwKjIrScaAaG7VAGjP1hKjbsuL1Os
 CCKdFsje6svHMmXkinnIqNVx8mot0GNlUyn+S02Ob52pZseFnVFSkQET5PxaDFMI3p5I
 XGNw==
X-Gm-Message-State: AOJu0Yzh0CpTYZy6aHGOWfXVgsyzbSyV3n8++ZVe21nhGXnQSDIWBn5c
 nPYqX51BREDaB90fc8xhG62P4ghsl9X/iwk1M7jN7KPgL3UrvJfBkFCdbKHt6/GCOjphyn5+i/y
 Xd1d+KEMTlA==
X-Gm-Gg: ASbGncvu0RUOTqDsCpehjDHnZuKNJn2a01cPMyOiyubt4dEFWX2EIP3qnm3SCYNGGKz
 +cc+BaEOhxYGQNoQIQkXjSoVrTU21fbfxNv9edmf+jTha1lZmKfB9ytielt7zD8uGXmyDgvWa/o
 kUG9vXfAWeV/nhGzgatsHH5/dSZNuoClZgiyVa8/9+TVnioTY/wkW1tsYpYDhhkZ8sjWdmb7ivb
 wxp0JJ/0eERyK2qGYkCtSt1NFtMBHD982iHbMNE90d4rs6V4rEZvOH+zvbBtEfwrW2KEQ4MSiK+
 mvyyyOEcLHUJQqZLDseeDN4T0jKzH9GAoDacI+dK+IDay++ST/RKCd7wGB5nzo1MjNmqfnxEDP9
 I626Q/SOizNU+aUpC2P63SkVpld3GyfOixGFKWQGM+gEp7To24w7S8u7BAE4PHNZdOKcaAUrd8F
 lTK0GI5l97An9r5CwAFyX+d/0HRsf7+JLQYaXks+iZyJ9bzMAYgXSBXFAPqWciPOpHTNsC0dA=
X-Google-Smtp-Source: AGHT+IGIk4Z8raCNRRax10NzPiOtzcWZsfFqovZxOEC0O6EAwuDa9OGLqy3618E2lq6SY5Z/RIvTOw==
X-Received: by 2002:a05:600c:474e:b0:477:9d88:2da6 with SMTP id
 5b1f17b1804b1-477a945e522mr1642955e9.0.1763399375257; 
 Mon, 17 Nov 2025 09:09:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477988060e8sm65079275e9.5.2025.11.17.09.09.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Nov 2025 09:09:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-10.2 v2 2/2] docs: Mention 32-bit PPC host as removed
Date: Mon, 17 Nov 2025 18:09:18 +0100
Message-ID: <20251117170918.80248-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117170918.80248-1-philmd@linaro.org>
References: <20251117170918.80248-1-philmd@linaro.org>
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

We removed support for 32-bit PPC hosts in commit 5c1ec5a1ee0
("tcg/ppc: Remove support for 32-bit hosts").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index a72df26dd24..e4eb3da4c22 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -902,6 +902,12 @@ From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
 Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
 maintain our cross-compilation CI tests of the architecture.
 
+32-bit PPC (since 10.2)
+'''''''''''''''''''''''
+
+Keeping 32-bit host support alive is a substantial burden for the
+QEMU project.
+
 Guest Emulator ISAs
 -------------------
 
-- 
2.51.0



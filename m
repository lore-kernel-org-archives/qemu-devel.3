Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57069CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpxC-00023L-7O; Fri, 29 May 2026 01:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwi-0001rM-1D
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwg-00026R-Cs
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:47 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4909def6a21so539535e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780033185; x=1780637985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=so43OU3znuMODu9rTwi9yPpK+I9Mk6+YYaqhGDXRE3E=;
 b=I57vjCN9sOD9I3ObfDjeLrgO4X8KSlqTtOHvoHN0XhDfENGhzdQk2GMSd9uYJsQ+pC
 mseqlSu2D0NFgJP7Kjakj7FqyBSadHerr4ppwYpwov6/0iN7+0ExSFTTpAcSE0cC/MK6
 9U6F3/vga8dhi6kN5Y11bbChtueM7wN6QpB6gyEgttty9S2DAygGmphQbBxBD3kseX3w
 Lyqo/OgZDXtEs1kA1dB1pC9bDkiRwohdn4/NEgFjF33eHM6MD/f1y3RNMicwWWCHH2Mf
 hyrlikILoJeyzu8qhjFpAb/B81KbNv63wnDK/CzRS46/E4pzAns2W/5Ow/maPCGwFktr
 ZW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780033185; x=1780637985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=so43OU3znuMODu9rTwi9yPpK+I9Mk6+YYaqhGDXRE3E=;
 b=PL2fsM9ecoKQqQCrCfqGXB5grDWi465j7Op6LpKrhjB82ZP2GzkiqSusrbu6U8Afs2
 h0FNwrKGcH3d+1jwPRsrTc/6KDBzH0XWkTYw7Ib/0cLUzh09/vVBlpmNy0fRmp88Tzoc
 AsM4X69rm6isymXx78Xe/uLxWVPYbEevdeUX0cTguQXJSzsN/7KHagT9/mXkDxQ8FSDv
 6q1xRnM4H1EiqenXVhOye2Lrriqdb7W5fWsUJOoANA/11Zj0TK/2scmMk+rpflVFmuDC
 mP4AaeGIEIGaVnogFI8XpXv7kwBjd+zGFSzaCQjnezqU9FrnMSFsesQRrUls4a8tCrvm
 G0Ew==
X-Gm-Message-State: AOJu0Yz1K+Us/6C1p/gYVsqROb144F3wCj9HCzmo7m8q825gIPAc6PSs
 AA82hvC/M6ThZRRZ3WztlcQW30zrBbRAz8Fwfjckpr5yT8nJQCbiVMMY8J2Ut4AdRVE=
X-Gm-Gg: Acq92OEz926Hn80HJvsjbJqQQKgAiY9OWWHkYXRHIRGtWiFnXWuVgKzvZ8Q/KOY2inM
 f6Ix4+wzmHdQvCoBIYZbovHecziglvYTM52s3gtvzR0yLbrgE1wuUac37q7XdwNYg7ERrsfbNLF
 cA40fP3+0gucejWCCJ3IPQIqaQL0ANJMF7Un0BpyL1EJ/L8c5MoxRe7i18w/J0757pHrAKg1kx4
 K5oBwWBRx0qhiaxEx7T0M4JJDPcp0stk8jQQfUxVdoQ3gtJ7JYHUhv1NAqfsdR1qIqaGLlq3wbM
 qiFAXj2F/QTJXQkcLHcNwmMuNRMY+xiPIqEo8tOf3qkzoKXng3j5T5MV2IV2TgzfjG5MoWdHMgx
 rx6HeUFncvp9uU5r7G1FjQ1czBMxF/vDrjsUkTUtisprI1X7JPRSQWE5GbApiEG9cPRFFf0ef8f
 d++G/4P4tv2gNJXT0qA/6NhWPRJfB0ekzuvg==
X-Received: by 2002:a05:600c:5298:b0:490:59cc:999f with SMTP id
 5b1f17b1804b1-4909c072254mr23076175e9.4.1780033184991; 
 Thu, 28 May 2026 22:39:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6a0e42sm14683265e9.8.2026.05.28.22.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:39:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D387C60E87;
 Fri, 29 May 2026 06:39:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 10/13] MAINTAINERS: Cover debian-loongarch-cross.docker with
 LoongArch section
Date: Fri, 29 May 2026 06:39:28 +0100
Message-ID: <20260529053931.283970-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529053931.283970-1-alex.bennee@linaro.org>
References: <20260529053931.283970-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260518102222.80735-3-philmd@linaro.org>
Message-ID: <20260526110243.470002-12-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d7050f4b6b..2dc6559c414 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -280,6 +280,7 @@ LoongArch TCG CPUs
 M: Song Gao <gaosong@loongson.cn>
 S: Maintained
 F: target/loongarch/
+F: tests/docker/dockerfiles/debian-loongarch-cross.docker
 F: tests/tcg/loongarch64/
 F: tests/functional/loongarch64/meson.build
 F: tests/functional/loongarch64/test_virt.py
-- 
2.47.3



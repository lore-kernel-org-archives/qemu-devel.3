Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4DCE7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwA-0001Ep-Dw; Sun, 15 Dec 2024 14:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw8-0001ED-1P
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:52 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw6-0000yj-BL
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:51 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5f2dcfc426bso713488eaf.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289549; x=1734894349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JD4Ly1fGe+tG79ysPVZO91OamGy1FVFI1FilJt7wv18=;
 b=tyfJVL0v9hy2Eb3F8zkGjF/BfE40glg5/8GuXTNO1bpMUOSvB9zW5YIWqUXbBOxXPx
 YkuMTMKMrHXIQNv6i7qQQrbcWvqsWq9EExvTt5dASH5YXdhQa5IGWu2fmabGMGORlA95
 E9cmCsyEPBvdN/2ZjTGzWpZAdPSWBdtf3d4S+Brw+cUgN+0xXlkUwuI6bltRxOiflHIl
 XEitOGo0D5WQj1FO1ncItmzhYHQNQD/C7tN0MO3dgf+VY+NjR501cSemhxS5t6d7mvls
 8GoOqjUUhe9EQUYzpCd5/GnXwQIJrEQ7dAWb59LVRPm8FsdOWsqKQhRPLB9NzAq7P6Gu
 xEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289549; x=1734894349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JD4Ly1fGe+tG79ysPVZO91OamGy1FVFI1FilJt7wv18=;
 b=qbeKyEtkicaQVupCTqDnaBUIsfEVV9eMz1sYDS0EzFCbJqQ5BRbQXXpXA+70UxvtUH
 1IYFOpsee06u1i54G4RxSeYkdtw9tH7vXHmngOEqFxig3G5zMnf1dvQzBo+wF2anGvZG
 FiN5IicS5C6QCbmF2wvXd81ITFIZaC8+fErlgoUg6paWGU+wyW/V5YtE04slMvZMIfNi
 +hMdP9u+LMi2thC1VSqeYrUJyCmG5Dv9m0zn2MCKpUZhoajHVvAZOT507zLFVpksROtR
 MpG2YsWYeMAciYI3HWDDouBYAnKipHmLCBy8TJ6JVxiPOdDtiLn02j3kAZeQyJnewbmQ
 yovQ==
X-Gm-Message-State: AOJu0YyZ+SVi6v4ib+vxj0IJWrYHoBH++cUh3iq1efs2lW4XbOvaT9Ja
 r6HVrK/zmDzjIIn/vobaCvL8tltA9US0wLGFrfHUXS2sRl2Gc7SwI8yHd1fOM7tiEoXlIzlMOp8
 b/u9AqRdB
X-Gm-Gg: ASbGnctu/+qKhVPuzzLa3QGlWN9wN2aiSikQ44puPf+CqK+k4KfGt1USOEC2yS4Xw6i
 nyzAIvrWxpwVR4orjl+gPx1qGktvZ5PV/+reviSETzQRXEq1Z7Zz4uMsof0ULngTgAvZQXcV+an
 0j1jhxvQwAv5VtKIvj2NhIS8Hx2VU0w1cUWJGQwBW0Y/mTe2pNJEKmcNuDCImsJ0zgtutInNVXG
 r1mlvp3s2nfRvtDCdntb0J6ZYFRBaGykGTHfIBgkgtt7iq2+xBc9ONvKqSGqvhU9HhZtbKgigHR
 xf1iLOcwlpkrIZoPKuej48Z4HrYaL6y9dAIO0IwZKn8=
X-Google-Smtp-Source: AGHT+IHg2TZqM1wUEyaWXJ0bhSQoBYMa61yLKlwxxwXYWd9b3OWf1PZHKcpvTgiEXuAZ0eir67YCmA==
X-Received: by 2002:a05:6870:e87:b0:29e:7603:be65 with SMTP id
 586e51a60fabf-2a3ac49607emr4487815fac.1.1734289549183; 
 Sun, 15 Dec 2024 11:05:49 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:05:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/67] target/mips: Constify all Property
Date: Sun, 15 Dec 2024 13:04:32 -0600
Message-ID: <20241215190533.3222854-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 4feacc88c0..02c0e1b0f9 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -539,7 +539,7 @@ static const struct SysemuCPUOps mips_sysemu_ops = {
 };
 #endif
 
-static Property mips_cpu_properties[] = {
+static const Property mips_cpu_properties[] = {
     DEFINE_PROP_BOOL("big-endian", MIPSCPU, is_big_endian, TARGET_BIG_ENDIAN),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0



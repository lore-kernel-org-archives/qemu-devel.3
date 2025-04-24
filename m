Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEED2C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7krU-0004N6-LQ; Wed, 23 Apr 2025 20:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqU-00011y-W6
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:43 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kq4-0004hY-GB
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:18 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736b34a71a1so462575b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455995; x=1746060795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xdo84E1iLP/XqDwQy8oaphr3JsZ2BPpRKXEovDmduLc=;
 b=AztDn4zXSQ8i/ZeYfirkWfuuMTT9JbcXRegxZo8F+yVIyLj2hVPia4S61SFiXejiMk
 rIaWkcOOmuCn1wLEcBZOJB5xKdQZgfL4vFDwBo1/QkO3FjWQp63WzJDBXKlfLaFcc+Qq
 0PpVQvHpQUm2nipWF58qsrb3HsXSFTcTKMf4mLtM+ooXGOEEFGUn9SfmQkfUcOZC/NXB
 IDJkLf2sTw9iUSe3uXkZWdV5OiB8ALOXzHmmrNSRg/ooUJOV/320a1kq8z03mRhuNveQ
 u6BnjntuOuXez8ATMmHmNWkKkbqRmnjcdMcHXV/NxfKR1E8aaxcqKg4Nu7AUbhO5/Tj7
 Hpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455995; x=1746060795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xdo84E1iLP/XqDwQy8oaphr3JsZ2BPpRKXEovDmduLc=;
 b=YfHpwPwmsfyoWTNbG8s3Re41qTU4rrU5irM1gMFGmjhBLmzUjvcxG+zD7bWqPuxYYG
 uD1ZeEJVII+9oTg0jKVzr27fYQLYSUOZvBdFDbqd0gOji5Vo90Vdfd7EAilfMfbmFECM
 aYz8a6e8TBMD+C1RQzWS6y0w42whk14vfJhfl/JjTA/JyutWp7ZgD3u3vKCvBz1T72et
 kp3vdGHjmUfJdqJIGxBa4JgZ2xdLhpDHeMDDcvCAyH+14qKu5XIdRy6Pq7huFbBUXABV
 WSostB16IzIFnfEOlNvSNDk01M05oO3iJ5UaixofKZtg41Rr/8/Hi5YLICKyHccKUtOR
 Lo1A==
X-Gm-Message-State: AOJu0YwPqVeT1Oj3UxTjn5CLufign+2GlrpHJwYfbHS3G2LUTxrBuZzW
 YTOb324KioeuG4VJFG5nFzRUxin9yTd/B7IMBS9/c980o7LSVSoeqfBrUt2nr1+2BNKN5N/pt2Y
 a
X-Gm-Gg: ASbGncuxyM913qEVsBeWC4HHRNvpzK5SIjAWGl5UJnviwaZmcNuECf6CnqMfSdYKOna
 /l6Tsx5aB5mzG4WvVT3vYA83qH+Z/WtLzWgXsHDklgDIoqDzcBVAI6TvKPR21o6InrkEBzSXRAm
 kRCJsJxcJy33Pmz9y1Jo6/0yQtEuVUMwsiwsgxDycvSy7T+49+ja2TOkgLvuo8/ac58tSR124rx
 ow3sUuNPyLnqlegW9N98XLuzfIHfpan3F83IKkp/l1eJxcocH6Shd698If4s7f7RDxpulzoqgDL
 tFv1rkuX02rmlEVjeUBCQnX8r8XBc87cmZEwrHMWqnbacIECLH0l8Yk+txfZWizFwcIvbiRgKMI
 =
X-Google-Smtp-Source: AGHT+IE4vHM23hYJQfMKpDYB4Fewf1y7s5ebLIBUuKUcXAzqdo1PlRbs4wHJ3PfXm2shZ17CY/WvLQ==
X-Received: by 2002:a05:6a00:278f:b0:736:31cf:2590 with SMTP id
 d2e1a72fcca58-73e247d82e6mr985967b3a.16.1745455995047; 
 Wed, 23 Apr 2025 17:53:15 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 050/148] system: Move most files to libsystem_ss
Date: Wed, 23 Apr 2025 17:47:55 -0700
Message-ID: <20250424004934.598783-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Some of the headers used require CONFIG_USER_ONLY.
Do not move vl.c, because it has other include dependencies
that are present in system_ss.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/meson.build | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/system/meson.build b/system/meson.build
index 063301c3ad..c2f0082766 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -4,6 +4,10 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
 )])
 
 system_ss.add(files(
+  'vl.c',
+), sdl, libpmem, libdaxctl)
+
+libsystem_ss.add(files(
   'balloon.c',
   'bootdevice.c',
   'cpus.c',
@@ -23,9 +27,8 @@ system_ss.add(files(
   'runstate-hmp-cmds.c',
   'runstate.c',
   'tpm-hmp-cmds.c',
-  'vl.c',
   'watchpoint.c',
-), sdl, libpmem, libdaxctl)
+))
 
 if have_tpm
   system_ss.add(files('tpm.c'))
-- 
2.43.0



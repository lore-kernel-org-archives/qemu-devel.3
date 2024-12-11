Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE89DE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVlO-0003be-Dk; Wed, 11 Dec 2024 18:05:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVlH-0003Sd-I9
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:57 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVlA-0002GV-IV
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:53 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso15706435e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733958287; x=1734563087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mtq+tz8nJw6Nv1owIoGgw4Z1D4TMY45KGCnnPE+QKMo=;
 b=e69AEBB2j0CM1riQyst3VbzaBHFRmMXwAoSEUbAWzwSa3T1+aThqoerH802ElCuxgt
 jRnu7/TtE61Zad+tCwt3iS8BPinKKyyPj/jgUtnQJ+GJU9ZuKAtVbdHWSb/K2QqlgpAf
 ydeTkrqACOHG6Z2lrDRFsT7H8RVFYmHuasDjelkLb2e/b9m5efPFph2i677PsJocJzO8
 0LL+TT+g95ulagZo3rX6ICzTkv56hjMR3lot0s5jxjlDkmdU/R4o53JpGPXqFWjf3zlw
 z5sTA0ifUFXqoCPc3OY1mtr+SgbcU8W/zfMdB+tKyk+QulH3/ZVQieDc0i0TPhrqxvFl
 bekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733958287; x=1734563087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mtq+tz8nJw6Nv1owIoGgw4Z1D4TMY45KGCnnPE+QKMo=;
 b=OZL/VuLuHaOKpFmL/86RqK1rO9lEWH0Xv+cOX8IwT8UcSxPZvBBJRVAhS1PXm0F78C
 sZSCoRAN04Z2/UixPPD8lsCO2/bNC3Ns2wRuaJXAC9rptdxADcuO6TrP2ZcXes7CHP9J
 OfJKBCvZqyqH3YzPiY8F5A+tcSmbyEbi2215Md/5yHRv9RBlzpfLgBlDANciLE7pVpdQ
 tn9KnqAHBXBKEvSfG3eRDRdhKnOju8q+NKAIWBEl9OQXCWtfI4OKjL6fez27SinpQ/qQ
 PSR5qHca8K1s9EzrwLH2JouWPzboSih7xNEBkSzRLoeNRFeOB0EtB9eUvPpq/5vHkCvr
 Z4JA==
X-Gm-Message-State: AOJu0YwFeFP9HfLWbvRZWoBs6raMxvx1u+/OcS+YL4Rky83mYOdAOp+2
 8YFcnSleYDzMoM9DFz9OzEjZxVrLxTzFMi8WAe9Qe+za9zFI4STlXnx0HpaFoi0VXRJbeDFqaER
 9
X-Gm-Gg: ASbGnctgOMWousvydIvgGG36TM5YTj5MlfkTlBev89hZYvAHSYFpQukq+g63c1U4v3T
 +qXdnim+9Nwv2cDNU/q1oRqHHRK9hf/9zZJxRRtD1G8RlAew3D0pRL6Uf8nocKOZZuOKlzeibWG
 0Sa/L8Em0vp0iNEaK6R3eVd7uVz8Y1bN8Af7gvB8hssUw8tJq/Sq9vAT64th/9Nh3neyaIqgQdz
 HUxsVzWZ08jqHNehMKpwo5t0kvfGYF3sRXPPkZZD9YoUtLs763Vbl1FOkywEpQf2+BgPflB6Vx9
 qDunwEFYitB7RIGBd8adROgsI8+qfr2ECw==
X-Google-Smtp-Source: AGHT+IHNxoMS7H787UzGLl1ddjWHHJT87JIsbwguE/8eCzKLWmLYd0do9HUUbufvmwY4IUU4fI9C9w==
X-Received: by 2002:a05:600c:4e50:b0:431:44f6:566f with SMTP id
 5b1f17b1804b1-4362282e1d9mr11425275e9.13.1733958286646; 
 Wed, 11 Dec 2024 15:04:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362429d2b7sm2433615e9.32.2024.12.11.15.04.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Dec 2024 15:04:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 9/9] exec/cpu-all: Do not include 'exec/tswap.h' header
Date: Thu, 12 Dec 2024 00:03:57 +0100
Message-ID: <20241211230357.97036-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211230357.97036-1-philmd@linaro.org>
References: <20241211230357.97036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Nothing in "exec/cpu-all.h" requires "exec/tswap.h" declarations.
Remove it to reduce headers preprocessing and poisonned target
definitions polution.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-all.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 45e66769380..b45defdbf43 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -22,7 +22,6 @@
 #include "exec/page-protection.h"
 #include "exec/cpu-common.h"
 #include "exec/memory.h"
-#include "exec/tswap.h"
 #include "hw/core/cpu.h"
 
 /* some important defines:
-- 
2.45.2



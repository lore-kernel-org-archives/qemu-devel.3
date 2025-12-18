Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB76D711C8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLmD-0001Vc-UG; Thu, 18 Dec 2025 16:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLmC-0001VD-44
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:43:12 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLmA-0004ay-GE
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:43:11 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso8626135e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766094189; x=1766698989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dv6+54i5o9W7fEBlVIR7xgeqZTrtUt7SWeNnerBEFxM=;
 b=nxLI2SOM1xltg6ve/q6/EyLDQDsmqYJI1/ITNMxFI5IxqMjJAQDBtjxYHZgSq+P+O0
 T2fnzOvDUc7iRfF4q+Qw7oQZLZyJ4ZIov1Ik5UsntNEXGgyWpOecXb0JsZgHDtp2Xtix
 W8wRX0m3sx26yB6kzjEGLX+xeqLV1YoClANW28LXirn6utE1V9CuOJdxJBH9yqgOdUqQ
 BpkL2kvREk1/Lkdgtq3SrR83qvNfadCNiWkqiHYkwgtTkLDqfZilzduMus0D9yRI+9ke
 vUb2Drs+o1UwrkE288X+0ujCeF4yO5dej6RkDUNWQMKxdb8jHcm3asR6luUdApTqcoNP
 n11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766094189; x=1766698989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dv6+54i5o9W7fEBlVIR7xgeqZTrtUt7SWeNnerBEFxM=;
 b=qhVQ8RrvtYeFxyLfBaDVNUwRGHqW4GEyXe0nok0PH13CXm9BxbihdIebiXcbkr+KNx
 ftDQkw3NYvPbJ49XXPWkBj/j2+Xys3CMzBMaCGeoUtGJ78fg5zVzkiB7QPVhIUMfL5ne
 Q7KK9WF9yg9//84e/FmrjM76+udFXAINNXTTT+zL8GvSNHYiQvnbLmShwgzayrx1wlfB
 YPovrOJKcn3+0vreAhNY8COpzWoguto9sMLi3sRCx5cuOm+Cf4qXkz5nv5njBiYM4EpR
 HGewYnYdKCzV73CiB5+6XX7VeUuLsfy+hj9Gfuw7gY47RlPwFksnAymi94fEuJCq0TqR
 AE1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlnFV5GZLrVUNZuJIF03SViJvtBoT9SAZd5uLyV4iYnzPGiUL2C7P0+ubQLnu87RxofQ+te6fa1l1m@nongnu.org
X-Gm-Message-State: AOJu0Yyu9WsPw774P+hUGOXgiT5wNX455hux+Ef+MBPCsaZfNwv9Na/g
 4NH26kxfMaYXVVkTJ0f8vJh1IWcVl/3uijoS0n/8TOx0mvaVClXebcaAN2yGZE/4wGM=
X-Gm-Gg: AY/fxX4zQvgDBV1MtnlZzpP+AAEzgObrLKu9v9xKBBaZ1DV+Hu6ORkPnXeJrwvMoBIZ
 jKB/HuNqsg9ZVJiu8XU4FNBPfKy5cX2Bvbl2Q+zyzow2JPeI5xWk1LIvypeH2XoAH3MA6ernwZQ
 TyfTdi/OzU8ySMBhXbXrTWURtBx3Q8/0SItTbhEG1SsOO0Q0Svr2VncfQu7q/vX6emotXEpO8WI
 f+UW2ZXFoCqZjXo6swzfGZHr0Iodkxxy2hifkPKO3b4GFn+TGrW/BuarcxK4RrwfIsWTtvtPwM6
 ajDGXIKaSJSc8NXmpANy5SrFnAmhZvEGsMDq+pLkJKM9u7YIqDAdu8PpQcFY9pocEsd+8twz+M5
 P2e9tNksb+be3V/WfnDdsjVzVT5wbnBSohsz17aLi4xc29JRVeeP6PcbyoSJfwxODvIy9xe50y1
 x2HmqCIBqwTVQNcFJZl8J8OWpJstg8hHK9E/phhD5XgahftrFowVCD6fT+pe+r
X-Google-Smtp-Source: AGHT+IHFg0qyqXlh//InsWVKBNF8SuSLH0wvq2KvmaFVtMgjMSHteCf/DVOE74UXCv1H4hQirC2Cvw==
X-Received: by 2002:a05:600c:628d:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-47d1954a11dmr5879945e9.14.1766094188773; 
 Thu, 18 Dec 2025 13:43:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3acdb87sm20961785e9.16.2025.12.18.13.43.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 13:43:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Jackson Donaldson <jcksn@duck.com>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] hw/arm: Re-enable the MAX78000FTHR machine in
 qemu-system-arm/aarch64
Date: Thu, 18 Dec 2025 22:43:06 +0100
Message-ID: <20251218214306.63667-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

Unfortunately while rebasing the series registering the
ARM/Aarch64 machine interfaces and getting it merged as
commit 38c5ab40031 ("hw/arm: Filter machine types for
qemu-system-arm/aarch64 binaries") we missed the recent
addition of the MAX78000FTHR machine in commit 51eb283dd0e.
Correct that.

Reported-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3248
Fixes: 38c5ab40031 ("hw/arm: Filter machine types for single binary")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/max78000fthr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index c4f6b5b1b04..ccef85e456f 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -12,6 +12,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
 #include "qemu/error-report.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/arm/max78000_soc.h"
 #include "hw/arm/boot.h"
 
@@ -47,4 +48,4 @@ static void max78000_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("max78000fthr", max78000_machine_init)
+DEFINE_MACHINE_ARM("max78000fthr", max78000_machine_init)
-- 
2.52.0



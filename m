Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C34FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO5Q-0004hB-4b; Wed, 25 Feb 2026 18:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO5N-0004ge-UF
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:14:29 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO5M-0002Yw-G4
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:14:29 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4833115090dso2886975e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061266; x=1772666066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+EFWR+yGZeveVEqBfwc2eMPoR02jwfsAg8piyqcFPQc=;
 b=xc5UEMfJ1RqDcikC8PVmCBe9DlD/8bVoTOIvJVfxtwJ9OZlcTn9uvSvUTahHs9Klu/
 sLLgvR0R2+yhA5TZY00mkxfrgjihJlfj2FZNj9bnpLd20Fhk6EybrwllW8NDgAiy8UsK
 jIKOBHen/x8pihd5JYBXUUam5t32gW7izwwccQt3HP98YMRIEyyL1By9fyJqplazT/xI
 R6m6j1erYSxbOQLvABs9YxJY8yM0bEyFDTS/EKxzINxFKIXPleF7EC0amUOk/XW6092z
 yQGH0/RfS9ZMHzd3eH4cWAcrRmet6X6MuC4v6XzFb5CxWQ8CT0hmKcc0lXaxt+fmd11h
 egBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061266; x=1772666066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+EFWR+yGZeveVEqBfwc2eMPoR02jwfsAg8piyqcFPQc=;
 b=P5/tsZHJ7r4sw1cV3oxZX7nOmuOGsBwYJXacId+vLhTVyDTaKuKienfwNXW3Oev7GU
 l9wXjnaNUMfLur4mxXWFnpRSIGvz8XMcrvfwL2dDF++J0fllrJzqfepYKxkbvbQ2Hk76
 Tr34Qgnh3gIOl6t1GsXO9v0lzGEEN6UMiy4iNVzF8eBRA78CqcD7xkoj3txQFYLzgIdZ
 1ONI6EFrPPZvIAMvzsNL4kCK5np1Wh7e036zgBHZhm7D/jHL0hKlWVO2MBl3BXX3uZM5
 vhpl/orOUbnKmV0m2LNXZtbDxdpUeF3V0R3SkRuVmba5S0wE3fow3GaHHgXuk37+V4/C
 R0WA==
X-Gm-Message-State: AOJu0Yy8jyuY5FxFR1Dafpb8NEK+Df9Nwjde6t7BZ420Uz5auH3uXoTV
 2HJbRoTb0rXeIPvc+Ua8QtMPXfnU/TaT5vxXGQZVT9zon10s/dn7Ut4/6XH12+br3+4tGDxZeto
 U0xUXKfE=
X-Gm-Gg: ATEYQzwZDOfcEoEuaB7M5udJIYr0OD2Km87pQD85tITnZWgcyh4GkgGUtJAzDpTo/4+
 s5qgjYZDWch8JezjwcOWe0wwqxNIZ94BRRPbH8C8BFnSa1fgvsvisu5tiOhavB7p2uRBZpINodf
 QwEN4Ax6UfMkfv+7efnmXSTumXG1nYWXC9TVcik1eaSCnw1VwRJcKSZksy+yBSTxaqKRRB2/n1Q
 8aNh/on7K1oWDp+juuUuKrkOLUL6ryQBpH8zh0vPB55Bb515jZ16hx9PHBxvrjLyYdi5h3Zjtz9
 a0Wkic0JG4YPfyGVZ6YOVXYjBoP3UPWQYq6Jb6H+kgu9N1g2FkIq9Uru2RC64rokmH3MU0/R9M1
 IZw7vK8f1w/cggRFCa90PndgmhK7HGFlGbhFeH3zr+8ANQs3stJF0wpSc+9l4tG8ChKnbmQ+sIn
 gNx30LU7Cfm6TtjIxG9fQWIArS6YHjnmCw8gOljsWy8q8NKHk9l/EuhmEOWbX3kuf+VJEkJUUP
X-Received: by 2002:a05:600c:34d2:b0:47a:935f:61a0 with SMTP id
 5b1f17b1804b1-483c3c70913mr2098465e9.0.1772061266322; 
 Wed, 25 Feb 2026 15:14:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b84023sm3783345e9.12.2026.02.25.15.14.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:14:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/70] hw/hppa: Use hppa_abs_to_phys_pa1x()
Date: Thu, 26 Feb 2026 00:13:02 +0100
Message-ID: <20260225231411.96482-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
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

From: Anton Johansson <anjo@rev.ng>

Makes the physical address space conversion for 32 bit machines more
explicit, using the translation function defined in mem_helper.c.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20260218-phys_addr-v6-2-a603bf363218@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 2cf4239a430..f55e84529f6 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -181,7 +181,7 @@ static uint64_t linux_kernel_virt_to_phys(void *opaque, uint64_t addr)
 
 static uint64_t translate_pa10(void *dummy, uint64_t addr)
 {
-    return (uint32_t)addr;
+    return hppa_abs_to_phys_pa1x(addr);
 }
 
 static uint64_t translate_pa20(void *dummy, uint64_t addr)
-- 
2.52.0



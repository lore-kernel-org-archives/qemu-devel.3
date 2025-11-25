Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88455D10366
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0v6-0003ED-2R; Tue, 25 Nov 2025 16:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0uL-0002jc-II
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:49:14 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0uJ-0005KJ-GA
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:49:09 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso39811595e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107345; x=1764712145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dl6LvASd0O/JG4z7ogldG5dWvUV97lajqPubCgwHmSU=;
 b=iy6fYnVqTlQJXoMj6hQBDV48svu43bNL4AcHUi8Kiei/v+ggvZ00042sx1qFB1yfBB
 LMoFaPamlyYJa2CO9qKPrHyqsU+r/Sz3FNQwWlUTObnRp3YAMTpqc3p4Zum6eB2f7FiI
 r4MJsqVlY5rQtTmD55/mHGPXSDRQXTr3IIl+W/0Zrk7lSw4XA40DiSrlE8z4x4/cdtw2
 3UNkWXQPvYuYM4xPaQXNnBsiQMJm7K3bMmAORQ0gcdg46xzE9pJ/mltzNzSdsqzE6e7H
 dj/2eeSwPC+CdNLR6m6YOKXlDeAghEt1MU95pEYimvQ2vi/NfD+TX4C2bF3pU09XzZJo
 tW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107345; x=1764712145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Dl6LvASd0O/JG4z7ogldG5dWvUV97lajqPubCgwHmSU=;
 b=pu25msZCXVXbtgFhWxAz5eraKElv9Eszuq472FcxinzkzstaMQh3ZL+YF81kwiN/Cd
 PghyUMcbS2GRIFJ4xZ0yMkMBuzK+YY/HJwyPMmtEJMXMRQc9YIoXtDt+hzfBCpW6zMOM
 2vpk3Vcv4zVkm8OZgnl+m91XQBl/ryzBebs7m0ZxiZeLeiIRfnWQ9J3MIawRWgp044K/
 cNpSWUj87/helkqqjWPnKUmjNvut267Saz9ZDuh8SpFJhMVTYJvJ9Ey4rvZopegU1Hz6
 n7JdzrftzEHjiRW7//64xciYifA0qxx8GjbE34DPGXLItPFJmiW0Fv5ZGLXdLCRN49Wc
 bmSg==
X-Gm-Message-State: AOJu0YxBrCVg+R9uQ3j7bzqDN8G5lZ3UQShsm6pzhZMziGvUEe1HZVc3
 L6FD2yJ4OzQ0VNn0BBM/H3DBQ/QAPDf6SwQ/1ZjoPp98fB0rLYLI/JvRXApV2/1tQMlI+luG79q
 bE8l6oxlAzQ==
X-Gm-Gg: ASbGnctukc+hdqO5jgluWslfKaRzdG05u4axvPaEkK3/taW77UEYhuGIHJzDW3c2cbe
 298WOEVrbPOi4zjlecWT1jtF0d6gsGytAFlNQ4k9HbyiTTCqqYnkZus01jGRcVMN+riTc0lPaLi
 exsHFHr9iTtEx6J4BnuJyKnb+fPMmSXeqRoBZprh4xJl7GCkCcKFZUfUwohVbDvHTPuIWJ5ouhV
 JFkJRMLJnAa1TE+UHThLYMdmJrHMbRH3dMbV6rP3cqR48CCxFqu2aNyErRiJ4+YDXB5H23wcdnC
 mkGM56jTW7I2X0xLWfhpX6dKUPbcJj9rRHT0t/FU9WFb1f73mPNQAihpG3ZfNxXu105lCtA7zFz
 PSorhz8M0fDiNLYIE/ccJeMUN7tvlTRxAoIOgkewHWNI4D4L1DeNwKcWy3aZYb/0qn710mGUUgX
 dQdAL7RCwyQwJ0rsWQeJNzXgg/omNfBd+J/ndg6xMAST9ISIw3i/beNx7L0RN/
X-Google-Smtp-Source: AGHT+IHSxZ4NHwdixRTVfgseIeGCnr1FG+U7hfQc/zezWkEgnJxI0FVNoMJgbJIMEIhhmVoCmORvqw==
X-Received: by 2002:a05:6000:400f:b0:42b:3c3e:5d53 with SMTP id
 ffacd0b85a97d-42cc1cedbf7mr19533973f8f.16.1764107345087; 
 Tue, 25 Nov 2025 13:49:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fba201sm36636378f8f.32.2025.11.25.13.49.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 13:49:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] hw/core/machine: Provide a description for aux-ram-share
 property
Date: Tue, 25 Nov 2025 22:48:00 +0100
Message-ID: <20251125214802.1929-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125214802.1929-1-philmd@linaro.org>
References: <20251125214802.1929-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Peter Xu <peterx@redhat.com>

It was forgotten when being introduced in commit 91792807d1 ("machine:
aux-ram-share option").

Cc: qemu-stable@nongnu.org
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20251124191408.783473-1-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 06e0c9a179b..27372bb01ef 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1204,6 +1204,8 @@ static void machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "aux-ram-share",
                                    machine_get_aux_ram_share,
                                    machine_set_aux_ram_share);
+    object_class_property_set_description(oc, "aux-ram-share",
+        "Use anonymous shared memory for auxiliary guest RAMs");
 #endif
 
     object_class_property_add_bool(oc, "usb",
-- 
2.51.0



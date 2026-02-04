Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CF5EA7943
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 21:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnkoC-0004UR-BP; Wed, 04 Feb 2026 16:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnkoB-0004U4-Gl
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:53:11 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnko8-0000K9-Vm
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:53:11 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso204503f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 13:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770241986; x=1770846786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cAJ4YWHoTQO6/ZNRCZwdywMvg4KrPH+won3t7TnAW6s=;
 b=eKf/9FdQ/p12S9eeysEfnuYL53iM67hjIWVTCKQR1aCp+hA5HoKHqEpdGTzwea1bo/
 wpFN1hGzzG8q2NBdM4RhqlGijCWmwNrbfyVy6bq5J4w1LSbXwIzURDhV11gusA7XfeWE
 zG5ZkUCb6AN9p/y9k5xptp5D9pYn0nVvRB22jUiS3JRql2/DxgV2M6UCWy7tYqv81pCq
 Gh7AusOyLyFLaFHtz+E96+bbF9jfzcn6ipG7GI0UvIzFUJZBDWA+mXIKx5HoIc9Lg6bi
 +QmVKjcNx8SRwV+3qmQMEuIGA/Fw87KCv/oaYMgTbi7ZnYCzWIJvQbgiMIEKe7mBUPhj
 KL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770241986; x=1770846786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cAJ4YWHoTQO6/ZNRCZwdywMvg4KrPH+won3t7TnAW6s=;
 b=H4FwIVMDnzbYtF2vUCU6eK3pO64rRBB6QLHU5zyVsy7RuibjHNG3K90N018VIrKx+d
 BAX8sAX5tH/7JeL8ASHxl8v6dglJjaEZli0wGAPczTa3QouJJxs+a7vZcsRK4qHUWfpH
 UZ8rhgokyIGEaaWjWdO7z7Lp1Irb8VA1eyuEeVro1J9k1Y4dLu7hfCA1HXa7swMR87mr
 BVpijLtWT4JfjmgkQOx0ZXqQtuTqyHSoSCi2DJyTTyigjAxpSw83At5lJ+FuBkQbpkF8
 S6Vps6uLJx4U2wrdrBn1wKVNikaTpd5bjK02dac/uZC4VKDJvmH9ntqVq5OeNS43PgX1
 u6TA==
X-Gm-Message-State: AOJu0Yx4ncDcVGgdRs2f+Qlwt84fsebppQByzCXMP6mhayc2GAWfaXgs
 3pTGnA3GJAf01sQtwgzbgB4bApOv+RTAtpWtATMn1t//quGZpSsFlCWIEV0W9yA35OTlIBc4Cc7
 kjyUkEew=
X-Gm-Gg: AZuq6aK3lqk3UwFLWvh80MCS9OX5fi8skXQXjGiiWBcAOYMeORWiF9wbVhCK/Bz+JvC
 Z0sc0UFkUjHrbESQfzmJ/lJQJfv6upNLphKphUHBC94N4l030IpMH9U3TnWh8ZO7lPjt+AHFDBm
 LsHJ1hxLl50EkODr6Gj0v3zQAUZeMN4mFBzveLA4Xxn//YXeYzcMWzILv8SKUSOkfK+W3iw2/Vm
 LWYqmVsRV1aDy6sGWE3dLWR2QKWZTIVtd033HEWsOg1HvXasYxjW3HE2ZG0oH3OQuCGBtV2tcWx
 WN/XFFOWpEIdVriFDvzxa/8o6Tr9ijJQvp/x8eceQXgtSNAaEQzVFqd+7oxZgN6BgVUPc2jY5/B
 550oBnVoeMerkApMR+KWGS+PABRMeMMDfbEgPJiaWfuaPjr5XW1/5kp3Nthj1c9o/OQmCSkCE6O
 T++pC8OT4QxPGDLDgm1RSUehdx/CRukJOiS5OZD/9RcZuHtIGEZTUQvb9QGCxi
X-Received: by 2002:a05:6000:4021:b0:435:729b:c390 with SMTP id
 ffacd0b85a97d-43618059b2cmr6081734f8f.47.1770241986446; 
 Wed, 04 Feb 2026 13:53:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e38e38sm9434623f8f.11.2026.02.04.13.53.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 13:53:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] target/sparc: Stop using the legacy ldst_phys() API
Date: Wed,  4 Feb 2026 22:53:02 +0100
Message-ID: <20260204215304.52757-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Remove the last ldst_phys() API call on SPARC.

Philippe Mathieu-Daudé (2):
  target/sparc: Replace legacy st_phys() -> address_space_st()
  configs/targets: Restrict legacy ldst_phys() API on 32-bit SPARC
    target

 configs/targets/sparc-softmmu.mak | 1 +
 target/sparc/mmu_helper.c         | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.52.0



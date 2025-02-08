Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02736C021A0
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 20:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgrtR-0001uS-LD; Sat, 08 Feb 2025 15:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtM-0001sR-3c
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:32 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtK-00057U-FJ
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:31 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f78b1fb7dso4824165ad.3
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 12:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739048249; x=1739653049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+e3NmMpDYxhMb26080aeO1z+Gh7xEdjEvCdFDBVM7k=;
 b=NbdpL+oMJB5T22EhZxUtSiq5QjvyfVV0DtAaHhMIy11/HaNSdAovWjHV8RnTNz3E1P
 bV6eLAFJdqxC1D1/M//FFvVREkSv5ICTT5geXlX7DWE1Xrq2IZ2adJucYgI266yLxlRm
 HzXpYcVFtq6+fVTo7nB7GEoGiJp4XcPDnLMo+JwtKDeufQTtTBclGsBvw1SY6Mtm1VpR
 mVyZW6eCYiKQlYNMay3RLofy+UKRvEkmyNk52ahxL+A7YMUgGIQ/AeS3zbzWP4KjJytk
 OnCX7dMfMWiZrzDuL23lhcmZY+VSmsh+xcTVsyEgAgeUyXvW6/A8osMk/ib3R1ohvuXl
 Jhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739048249; x=1739653049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U+e3NmMpDYxhMb26080aeO1z+Gh7xEdjEvCdFDBVM7k=;
 b=l7pZlVS5EnDdg7aqy1kcAbzRRqsJrxq8KG87zgGi283ncaEYkJj9Q0Sg2WZz21EjGz
 3c3pe12pbQMmIaLNGKgHMWLzlXmwwu0gIDqHlFgmEFpmpVdHAJKAMfa3/IPocHg2iY2Y
 W1LfXGnXWw8cFGGdLpphfL1WrCAzTTDOTsyZr8XugDS5fp2OMlIByGNkzoS3f8uw1stw
 uwRlK9dlSgROe0IwwQudV938q5wea+ExoLVRqhwF4+a4fQnzbIP/ugfY9akvHWJL8w12
 mHvgwAFUOK7C5OBmpszuWxS6l6t9mOqm2glGRwZR/NPuGGEmDeAp+1Q+ejvdXRwSIdkn
 n36A==
X-Gm-Message-State: AOJu0YxL2gk5UEQeNl3CQ5Na1w4t/rHKD5yAxOKpd/H4EtcBoc4xng42
 so0EAkyTIzPZjX5APJsT9VvIK9YULuVwz3bMudGuPDzQwPp0P5is5G/ytEtp0vDKLLe/opw2EZe
 Q
X-Gm-Gg: ASbGncvVMN+SSshTHDAWUsPkSCg8kHHUHXC6PGhvyls0/DRB3OpFJB5ClZdN8JSqQ0j
 7rn0RMG7LqWi2QuGHG1/MaZj0IfR10P2B7FLzvDB1FvvHiIw59RiRb05gk5/a96jgWksYVlloMk
 qg9qAcfkG6tTN005ggbXTt0ify0Y3kJorRlE+zXAtbMNFFSvhbortSNK5sYy694nwdeo3AZviZc
 n8gf6YTl8dtdNVSKpYMMY1/zWlEknNmO/lMpCMLipIJJARpp1ECARu485i2sOwrhNrweuq5TEuB
 3/2fbHgUMB2aaFxXnMTnPtjI2zrVm2vjZC32AGzxJD/FmVk=
X-Google-Smtp-Source: AGHT+IF7utxRzvlgzmcC0OXBEZFDclZK3/iC5bZ8Yj3+W/0IealyWxqP4xTk4Sl2/4GVII3GwcBTXQ==
X-Received: by 2002:a17:903:2311:b0:215:b5c6:9ee8 with SMTP id
 d9443c01a7336-21f4e6a028cmr118157045ad.7.1739048249079; 
 Sat, 08 Feb 2025 12:57:29 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683d58fsm50852685ad.122.2025.02.08.12.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:57:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/9] meson: Disallow 64-bit on 32-bit HVF/NVMM/WHPX emulation
Date: Sat,  8 Feb 2025 12:57:19 -0800
Message-ID: <20250208205725.568631-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208205725.568631-1-richard.henderson@linaro.org>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Require a 64-bit host binary to spawn a 64-bit guest.

For HVF this is trivially true because macOS 11 dropped
support for 32-bit applications entirely.

For NVMM, NetBSD only enables nvmm on x86_64:
  http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/nvmm/Makefile?rev=1.1.6.2;content-type=text%2Fplain

For WHPX, we have already dropped support for 32-bit Windows.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 911955cfa8..85317cd63f 100644
--- a/meson.build
+++ b/meson.build
@@ -319,13 +319,11 @@ else
 endif
 accelerator_targets += { 'CONFIG_XEN': xen_targets }
 
-if cpu in ['aarch64']
+if cpu == 'aarch64'
   accelerator_targets += {
     'CONFIG_HVF': ['aarch64-softmmu']
   }
-endif
-
-if cpu in ['x86', 'x86_64']
+elif cpu == 'x86_64'
   accelerator_targets += {
     'CONFIG_HVF': ['x86_64-softmmu'],
     'CONFIG_NVMM': ['i386-softmmu', 'x86_64-softmmu'],
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E5CC28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr271-0003IK-N3; Sat, 08 Mar 2025 16:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr271-0003HZ-05
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:39 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26z-0000w5-08
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:38 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso17090525e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470815; x=1742075615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYdAFb3oBG7virE8Cpyn2nDjunons5iAGCOvHRbnYbk=;
 b=FaoMS/3Oti2cpOdA1UO1jWZcenJODHr9pxR6CnAlbued7b/CswKFDmmr8ED11YvJtQ
 6YKB9JzFOPGK1kigoVQKZfw5kKpMM1LBeoIka5sfbQ/AGsZUFsYMgmPcLNcHz2k1d97M
 DTv7NkG+KJKhgybAGnVa8GZ0lynttlft1KFbEn6oTo3x6zTWYFnRZd3To+yyvn69G4XT
 YGzqDKKP9RjWHl5zw9SG0uOk2SPMdZkpmxmztrYa2IHANSd8JizlCQoMPOO5xp1KG+XQ
 FKrytDQGiiU+Hk+48vW345UJftSys66cniA2fW/sG3aXfDAfvNzZoUNiMrrPjoKRK/rZ
 82cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470815; x=1742075615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYdAFb3oBG7virE8Cpyn2nDjunons5iAGCOvHRbnYbk=;
 b=fkoRVXSImjPwQsxAJouctZYrv9mVyO1M4swV4brC1b4kggHhsCycbKX4BJdMk9obJk
 I4XKZLHIfS9AJQewVriRfVmht9CVRjGoP5FHEY3BPGxOcCBV2Ykok8k85FBpukV9cNNm
 cBoR35bvK+5WM2kYN34VsuONya49zfBPCvwVmxa5hNx8qnp5qFbm0ehYi5y2SMs+TRKp
 YGlDjCIxQnRpfKuqLRghgy2Dp9e4QawtERqRLJcoSmigeWtH7E8S9Mblq63d6096UA9i
 4cZkx64z++BeagfrOXe9Ve1XW/anWNOfJIjVgIeeLM0Z81Dzs66ZlzxShBXbW5p6k4NO
 B9Ew==
X-Gm-Message-State: AOJu0YxTrrfefKwRtW2kKSwZ7UEEn3Q/sfA4dHZIyLNm0tXVdBoRAIk8
 bYd0AcPyBgs1d63/epvoGmB0BccOxep+/L36asPPd//ZGAEQqZzsSIbRxptj4pAO7/thxsYczSJ
 f
X-Gm-Gg: ASbGnctHKdcmUE5uDeOWZPEyp6TCEKoE4a/NbOKoP6DLk7IYRV5GqxGs/OZyCAxQwTU
 9i02mOFPAwzsUQ1JVLR6f3TBdTID5/tKClKfl0P39mjfrHrj/Dq2HfII7KwgsyxCOGVPuufDU79
 xiTH0zQCNusyWvBKR5vJMjymc0dLMQBeKYmsx4D9nawV6f6e7ctsOJrte9HKR1n/8Xe9jnP0PZB
 Beu2nT0pp7nsPu/9t00gA5OvjRMpWxOFXs3v7vsqEXlIf/0s1EbAwbEXqb3I4hcgaUL3pj2txQ/
 wSNvO67ptSKs5YbwG0nwWPXxz5NCHMS4aUd6V4pUdtRhxcuQpaY3jY8nsg==
X-Google-Smtp-Source: AGHT+IFa70Hc6xpg//9nyqzQicUcQ3XVqlcrBYnrhsxxYYrmN/ej7dBx+uC/ns+6az0DfunmnRkRCw==
X-Received: by 2002:a05:600c:3545:b0:43b:c5a3:2e1a with SMTP id
 5b1f17b1804b1-43c601cdb15mr55280295e9.2.1741470815480; 
 Sat, 08 Mar 2025 13:53:35 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8b03cesm95263825e9.7.2025.03.08.13.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D2DF3604B6;
 Sat,  8 Mar 2025 21:53:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/31] tests/tcg: mark test-vma as a linux-only test
Date: Sat,  8 Mar 2025 21:53:08 +0000
Message-Id: <20250308215326.2907828-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

The main multiarch tests should compile for any POSIX system, however
test-vma's usage of MAP_NORESERVE makes it a linux-only test. Simply
moving the source file is enough for the build logic to skip on BSD's.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-14-alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/test-vma.c b/tests/tcg/multiarch/linux/test-vma.c
similarity index 100%
rename from tests/tcg/multiarch/test-vma.c
rename to tests/tcg/multiarch/linux/test-vma.c
-- 
2.39.5



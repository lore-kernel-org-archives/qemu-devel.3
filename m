Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7C0CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9nNM-0004mw-EC; Fri, 17 Oct 2025 12:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9nNH-0004lj-H1
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:32:15 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9nNF-0001Bg-4Q
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:32:15 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-279e2554c8fso20774585ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760718729; x=1761323529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAYhbIEVnqIpv3UM3lZTlnJP6T433ZQvfgE/KFwrBAE=;
 b=NqXgEVL+KNzvxNFCX738fWd6Xr9OJvN7Qv3kN7SWMpv8qkngG1l16ga5iZNsXzFBoX
 wxOxjZ1HtxMTHUOenDp4nVlJpj+uX8syAS9gg1puzWibVoj/J3qYUBdUmXr/HORj93eG
 nWufDbYFRaAVR8Vgt94UgueisTB0Nk9CE00Jn9P9Buu10jpU8ZlaRasOG88Y000dnYdF
 deEv7V9Nlc6yXT4jLouHNaOvrFEyiFgY3Dzf+DgqFZrWMEZXSPC7Qfp3UUI2gG5ZypOr
 6UfDRVHCNoNIPyCvAlUeQfdbFhzDlTL7oqjmWOzad/ZqaeUXInM5UIp891/b5Jsgb5Gw
 JpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760718729; x=1761323529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAYhbIEVnqIpv3UM3lZTlnJP6T433ZQvfgE/KFwrBAE=;
 b=OG0ex/ovKeE2nOh7q2+kpZ/Y6l6EOwT5Ce+iXiQ46F+4KdKbfwM/lx67/aZfgZrZSb
 gghzXvbOTxVlDd2f7/q76Z6iszGnbhxZpj4aSRc9cmSjaaT8TfyB5cQzal5Fxa3Fgd56
 gDj1OmosIODdSYtu7s74ETVy4uqenXk4cI1WLCrDBc2iPj7nNbmFnae9aKk94oHqDDy2
 Kc3asuwEVZAszDz4j2u9E6u/wPZggEZFN5sAo6rECPGUElLgKbN5F2w6ESirikAZNpne
 uIn+2t48MUmImpqMfDw06EqaAuTvhi0D2v7ZZNu3ieAJlfnMHUtN+aVJfccCvo+KNzO0
 O3Pg==
X-Gm-Message-State: AOJu0Yy654hI4X/lqjTtQkzhr6nsAwhRYBqmVNKKKs1JTbHAkbpfWb7V
 0/QNZi8kONSHfXJVJFriOvyu6PMBTYanCi/Y66/fiv2rL+SSg0AqObcORfFUSYsaumUlyokfjMg
 BF59W8EA=
X-Gm-Gg: ASbGncvIGSB8RkPlaGYpUw8+L/tFJfm3SAUSmGmPCgpi4bMU/PUO6ADL+xGP5HPU9bC
 bg4KUgJQ5RAeLBowIHytKTE5X7rLCuZhrxFfXDCoPtNMpH3/HKp/IX00RRXlXXjHavhPs99hYnc
 lQprTOlEN+aPU9oueO9eu1PlPEeDncCDqIFKEmxS6J79DF8E5QSSLX7CN4I3sKddBDy5oVNUpRx
 TmgDZ2Zqxar5Hv+dqGtmko2d5waGDruV+rpUYhLqNYumHVtrqlnetH0GVOqUC+RQ4BcgQpac3nR
 aqd2aY/Uc7XcW6FSNhTKg2yRHFjzA2e3oJEni6Qtir7MbnX9GcGPXwN/dEgyF1T7/K05oKlRa8S
 Z591MxtLtEM8micgVwGXD+/OfPSkNqq0M8t+apP+LVhkD59BbRhuWUW99T636Lo1V9sOpGc5PCR
 DoUcXH8Q==
X-Google-Smtp-Source: AGHT+IGncTkqFvTDR+3AtItiCzSirQciXtQkwSwnIMJmL4NGuW9hHSQ7whyxFZyI8zO6JyvkVqMBqA==
X-Received: by 2002:a17:903:1111:b0:269:82a5:f9e9 with SMTP id
 d9443c01a7336-290ca1214d6mr52898605ad.29.1760718729279; 
 Fri, 17 Oct 2025 09:32:09 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm68667715ad.65.2025.10.17.09.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 09:32:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 2/9] buildsys: Remove support for 32-bit MIPS hosts
Date: Fri, 17 Oct 2025 09:31:59 -0700
Message-ID: <20251017163206.344542-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017163206.344542-1-richard.henderson@linaro.org>
References: <20251017163206.344542-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Stop detecting 32-bit MIPS host as supported, update the
deprecation document. See previous commit for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251009195210.33161-8-philmd@linaro.org>
---
 configure                       |  7 -------
 docs/about/deprecated.rst       | 13 +++++--------
 docs/about/removed-features.rst |  6 ++++++
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/configure b/configure
index 461b53dd60..8263f81370 100755
--- a/configure
+++ b/configure
@@ -404,8 +404,6 @@ elif check_define _ARCH_PPC ; then
 elif check_define __mips__ ; then
   if check_define __mips64 ; then
     cpu="mips64"
-  else
-    cpu="mips"
   fi
 elif check_define __s390__ ; then
   if check_define __s390x__ ; then
@@ -473,11 +471,6 @@ case "$cpu" in
     host_arch=mips
     linux_arch=mips
     ;;
-  mips*)
-    cpu=mips
-    host_arch=mips
-    linux_arch=mips
-    ;;
 
   ppc)
     host_arch=ppc
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 98361f5832..dacf2882e4 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -172,17 +172,14 @@ This argument has always been ignored.
 Host Architectures
 ------------------
 
-Big endian MIPS since 7.2; 32-bit little endian MIPS since 9.2, MIPS since 11.0
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+MIPS (since 11.0)
+'''''''''''''''''
 
-As Debian 10 ("Buster") moved into LTS the big endian 32 bit version of
-MIPS moved out of support making it hard to maintain our
-cross-compilation CI tests of the architecture. As we no longer have
-CI coverage support may bitrot away before the deprecation process
+MIPS is not supported by Debian 13 ("Trixie") and newer, making it hard to
+maintain our cross-compilation CI tests of the architecture. As we no longer
+have CI coverage support may bitrot away before the deprecation process
 completes.
 
-Likewise, MIPS is not supported by Debian 13 ("Trixie") and newer.
-
 System emulation on 32-bit x86 hosts (since 8.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index a5338e44c2..53829f59e6 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -896,6 +896,12 @@ work around the atomicity issues in system mode by running all vCPUs
 in a single thread context; in user mode atomicity was simply broken.
 From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
 
+32-bit MIPS (since 11.0)
+''''''''''''''''''''''''
+
+Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
+maintain our cross-compilation CI tests of the architecture.
+
 Guest Emulator ISAs
 -------------------
 
-- 
2.43.0



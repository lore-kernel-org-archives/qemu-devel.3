Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1122CFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 09:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxkDu-0004wW-HG; Mon, 07 Oct 2024 05:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sxkDr-0004vI-BX
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:40:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sxkDo-000535-QX
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:40:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cb806623eso37876765e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 02:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728294007; x=1728898807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0bvmJJ+8246gH4K3TL1jO3GW/p257TZ4N0EkExiJyKo=;
 b=RADl143HKhFGmcJdyht4bWK94WivhBmiDvtKttl1VaoxtuGgOkEFjX7x7ab+9l3cmh
 8WpxQ7eKCoj8iqz0lDw2SWpTc28jitlw7Vfhxkm1uMHTTErGhytVBWEKLBGW1SmUxgJj
 1SF1F8YZK5SN92gPiQQ+SzBSp+BhYEl+ppHbrVGgzic5OqTAm+UcyHBvup2DW67Rt1fM
 NPT+e4ohGU37XTbjvmH3XE4QCwKuBGgsaI4eEdPKutwwuuFkr/xzx2T4T3CQ/6vD9vwF
 o0Juba/Hg+50RYiW12aIVlpF5vgUqGqkiQQSZzBK9irzvcitHlv54hbI6Km/+R7ILfUe
 w4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728294007; x=1728898807;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0bvmJJ+8246gH4K3TL1jO3GW/p257TZ4N0EkExiJyKo=;
 b=gdpEKcSJk5zNoYke+XF/a6Kgb/UHGW34+rJivNRAzf8D8+k0bDalB1qad/tel85C4N
 HuRfZz0S//f/9r4jYVtBfRl1qAO52vZx107iH4RQXsT84VfPM7LM6ZoeZ85MTYRIWld1
 fmR+mSROoLQGAn2064XTnP/VSQc8nnZLpg4ufo0mhRsb/pBTOwOnRvTjRLkCkTDnBUCe
 jgRj1zIxD1vikdwq47GTCo/o4xKVm+wbsaOxqr5BlKZ22gLjSnqHaRkKd2FHz/a6yQiY
 0cENIlN4M9UeTtDt/NuTw3Y//NAXucuDQaTWXRHwCkVENFX2hoW0MJeUBNOTXjQLjehB
 ZmJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH6/3413ODW6DlmBposPdhLoP+N7QJm9+a5nuuObD0nKrtFZd/BEkfTeTxVy+zXfgqUmAiNeqvPM6I@nongnu.org
X-Gm-Message-State: AOJu0YxWbkLkbOxyHgf3U5e5xQgYlyN4HF9MagpmzLwj5dpNmGTfyg+k
 qqo7LjnNrZnBZpC6LVr/XDabE4R2I1AkyBg22zbAmf+PI8+My4tETb07VFxMboBDNysnQzRuK/Q
 NuoM=
X-Google-Smtp-Source: AGHT+IGd9px8ux63YIt5qESYU109u7AzkASThaIzTP2XLH16zpBUjtII4NGGFMdJKErd5uVxeE61DA==
X-Received: by 2002:a05:600c:190b:b0:42c:be90:fa2f with SMTP id
 5b1f17b1804b1-42f85af4582mr80485315e9.25.1728294007091; 
 Mon, 07 Oct 2024 02:40:07 -0700 (PDT)
Received: from meli-email.org (adsl-122.37.6.160.tellas.gr. [37.6.160.122])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f89e89624sm69109265e9.12.2024.10.07.02.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 02:40:06 -0700 (PDT)
Date: Mon, 07 Oct 2024 12:39:12 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2] tests/functional: Switch back to the gitlab URLs for
 the advent calendar tests
User-Agent: meli 0.8.7
References: <20241007083649.204886-1-thuth@redhat.com>
In-Reply-To: <20241007083649.204886-1-thuth@redhat.com>
Message-ID: <kzc6t.omlco5eeifu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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

On Mon, 07 Oct 2024 11:36, Thomas Huth <thuth@redhat.com> wrote:
>Shortly after we switched to the original URLs on qemu-advent-calendar.org,
>the server went offline - looks like we are better off using the gitlab
>URLs again instead.
>
>Signed-off-by: Thomas Huth <thuth@redhat.com>
>---
> v2: Drop the wrong change to the test_microblazeel_s3adsp1800.py file
>
> tests/functional/test_arm_vexpress.py    | 2 +-
> tests/functional/test_m68k_mcf5208evb.py | 2 +-
> tests/functional/test_or1k_sim.py        | 2 +-
> tests/functional/test_ppc64_e500.py      | 2 +-
> tests/functional/test_ppc_mac.py         | 2 +-
> tests/functional/test_sh4_r2d.py         | 2 +-
> tests/functional/test_sparc_sun4m.py     | 2 +-
> tests/functional/test_xtensa_lx60.py     | 2 +-
> 8 files changed, 8 insertions(+), 8 deletions(-)
>
>diff --git a/tests/functional/test_arm_vexpress.py b/tests/functional/test_arm_vexpress.py
>index cc6015112b..6bd6290030 100755
>--- a/tests/functional/test_arm_vexpress.py
>+++ b/tests/functional/test_arm_vexpress.py
>@@ -11,7 +11,7 @@
> class VExpressTest(LinuxKernelTest):
> 
>     ASSET_DAY16 = Asset(
>-        'https://www.qemu-advent-calendar.org/2018/download/day16.tar.xz',
>+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day16.tar.xz',
>         '63311adb2d4c4e7a73214a86d29988add87266a909719c56acfadd026b4110a7')
> 
>     def test_arm_vexpressa9(self):
>diff --git a/tests/functional/test_m68k_mcf5208evb.py b/tests/functional/test_m68k_mcf5208evb.py
>index 869ccc88df..00c59590c3 100755
>--- a/tests/functional/test_m68k_mcf5208evb.py
>+++ b/tests/functional/test_m68k_mcf5208evb.py
>@@ -13,7 +13,7 @@
> class Mcf5208EvbTest(LinuxKernelTest):
> 
>     ASSET_DAY07 = Asset(
>-        'https://www.qemu-advent-calendar.org/2018/download/day07.tar.xz',
>+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day07.tar.xz',
>         '753c2f3837126b7c6ba92d0b1e0b156e8a2c5131d2d576bb0b9a763fae73c08a')
> 
>     def test_m68k_mcf5208evb(self):
>diff --git a/tests/functional/test_or1k_sim.py b/tests/functional/test_or1k_sim.py
>index aa2a1f08d2..10e0437c50 100755
>--- a/tests/functional/test_or1k_sim.py
>+++ b/tests/functional/test_or1k_sim.py
>@@ -13,7 +13,7 @@
> class OpenRISC1kSimTest(LinuxKernelTest):
> 
>     ASSET_DAY20 = Asset(
>-        'https://www.qemu-advent-calendar.org/2018/download/day20.tar.xz',
>+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day20.tar.xz',
>         'ff9d7dd7c6bdba325bd85ee85c02db61ff653e129558aeffe6aff55bffb6763a')
> 
>     def test_or1k_sim(self):
>diff --git a/tests/functional/test_ppc64_e500.py b/tests/functional/test_ppc64_e500.py
>index 3558ae0c8c..f1af92373e 100755
>--- a/tests/functional/test_ppc64_e500.py
>+++ b/tests/functional/test_ppc64_e500.py
>@@ -10,7 +10,7 @@
> class E500Test(LinuxKernelTest):
> 
>     ASSET_DAY19 = Asset(
>-        'https://www.qemu-advent-calendar.org/2018/download/day19.tar.xz',
>+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day19.tar.xz',
>         '20b1bb5a8488c664defbb5d283addc91a05335a936c63b3f5ff7eee74b725755')
> 
>     def test_ppc64_e500(self):
>diff --git a/tests/functional/test_ppc_mac.py b/tests/functional/test_ppc_mac.py
>index a6b1ca2d4c..3f45e37a45 100755
>--- a/tests/functional/test_ppc_mac.py
>+++ b/tests/functional/test_ppc_mac.py
>@@ -10,7 +10,7 @@
> class MacTest(LinuxKernelTest):
> 
>     ASSET_DAY15 = Asset(
>-        'https://www.qemu-advent-calendar.org/2018/download/day15.tar.xz',
>+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day15.tar.xz',
>         '03e0757c131d2959decf293a3572d3b96c5a53587165bf05ce41b2818a2bccd5')
> 
>     def do_day15_test(self):
>diff --git a/tests/functional/test_sh4_r2d.py b/tests/functional/test_sh4_r2d.py
>index 5fe8cf9f8d..c3cfff79ad 100755
>--- a/tests/functional/test_sh4_r2d.py
>+++ b/tests/functional/test_sh4_r2d.py
>@@ -13,7 +13,7 @@
> class R2dTest(LinuxKernelTest):
> 
>     ASSET_DAY09 = Asset(
>-        'https://www.qemu-advent-calendar.org/2018/download/day09.tar.xz',
>+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day09.tar.xz',
>         'a61b44d2630a739d1380cc4ff4b80981d47ccfd5992f1484ccf48322c35f09ac')
> 
>     # This test has a 6-10% failure rate on various hosts that look
>diff --git a/tests/functional/test_sparc_sun4m.py b/tests/functional/test_sparc_sun4m.py
>index b334375820..573f85222a 100755
>--- a/tests/functional/test_sparc_sun4m.py
>+++ b/tests/functional/test_sparc_sun4m.py
>@@ -11,7 +11,7 @@
> class Sun4mTest(LinuxKernelTest):
> 
>     ASSET_DAY11 = Asset(
>-        'https://www.qemu-advent-calendar.org/2018/download/day11.tar.xz',
>+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day11.tar.xz',
>         'c776533ba756bf4dd3f1fc4c024fb50ef0d853e05c5f5ddf0900a32d1eaa49e0')
> 
>     def test_sparc_ss20(self):
>diff --git a/tests/functional/test_xtensa_lx60.py b/tests/functional/test_xtensa_lx60.py
>index 8ce5206a4f..d4ad92dc6c 100755
>--- a/tests/functional/test_xtensa_lx60.py
>+++ b/tests/functional/test_xtensa_lx60.py
>@@ -11,7 +11,7 @@
> class XTensaLX60Test(LinuxKernelTest):
> 
>     ASSET_DAY02 = Asset(
>-        'https://www.qemu-advent-calendar.org/2018/download/day02.tar.xz',
>+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day02.tar.xz',
>         '68ff07f9b3fd3df36d015eb46299ba44748e94bfbb2d5295fddc1a8d4a9fd324')
> 
>     def test_xtensa_lx60(self):
>-- 
>2.46.1
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


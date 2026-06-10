Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30C8CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDBj-0004q4-SG; Wed, 10 Jun 2026 03:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDBU-0004li-6y
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:17:10 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDBS-0001WY-O0
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:17:07 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45ee5cdbd28so4347952f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 00:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781075825; x=1781680625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wdU1404k+TxR02ItnBlHj6oYFXSCi4F+DlqFcTTJ4j0=;
 b=VcphJb5NTHn2MqfzEz+oly90a062xMms37ZVEGY+02f/Dq4N2LjpgwAqVV6ehNdedA
 qDD95O7wKP1IydhMKxOViS/mtsD4Eu3Cs5mlja1aPoWmRXvCfKUD0ISig2lWMayaGIo3
 FTHJn+IUgE+BYXyoUIW2MMH7wmyq/VF31ZCYn19EWljuW9PIaLQV/hLYw4EMdrj4ZOBT
 awia7x2jcbWRRoBKGbwGORtvGwgXKTE0PGJKlFyc0yvS34BFWM8/n/kxPU9CnMT87hbC
 q6MdTqv3IZONpw2Wl+nDqCbw5BaQNl58sHUDdwiFQNxG2eMAfZUR1w1nnawAbecnfHgC
 67/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781075825; x=1781680625;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wdU1404k+TxR02ItnBlHj6oYFXSCi4F+DlqFcTTJ4j0=;
 b=p5iim8wEfZpsAlzuxSRdVBDDTEjhEC+8cszICCekrAKGnTLI0Guf86KNiLTkltbwpt
 pBx6KYanTi1I4YxGsWhg52hxfKYZQMcl5mzlVz8Cc/mjD1sofMf7hh+ORaDz2pez9Q0j
 4cKQB0715H0KbMRnfcGdEmxO7mOSEZayvHIvqqU4MKXrAzUImGXNlaLeYUxTcEqY6TPF
 FrzS0nUbaDwvubnVvlVLk2AvxBRiM67Gx4d2ReGgKFI37wgqkOcIowXV/BU2vlM9Q2PS
 Rqr9dSmVqHwpP63N62vpMl9xXl17L2Y6V2C9AtaCTK92FJ45w/MM13Nyh8vjyBpZOYJm
 zT+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JzXrAJ+sVlFuiSVLIV/9k5efA3kWd0Oq+zhdWWc/mqZggDfflS9pz192N0PhyvjS7KQM+BhtEwxQk@nongnu.org
X-Gm-Message-State: AOJu0Yx11Xu+zDcjgvnTn43YsVZTyvQoxUf0CFuArDxtyNgON72a7Ygv
 zA8wUCyp4KP7KV886YkHQcgzMo8ZLr90eKnm+snecCrZaCFp6VxH68hltBgqPBc1CVE=
X-Gm-Gg: Acq92OHX9VsUva4lO7leJKBQfZBLmKGQ+vs/4FCzsRGWDAiGcYf/Ws3RcYd0CqJNZG4
 /yEvxQpCgLw9V6AzeyMWOewBhONSoLRuQ2u+HypRG4qV8S8D/xR1i4gTk4DWm0eOcfxug02izMV
 sG4xMQGi9/hAH9Vi79i9cTw0Yh0Sfv6I0IcWpHOG9V2vwXjVSMCSFv2vtdUSLx28Uc4eVcn4Xl8
 2OwuACko1cDiExZbpiROjrZbJ9EBu66ND7XWs/eI6v2NtWXqpDNgJup2lLNf3IzsxRg6fXZvNuu
 FGJC03XbPVt7DK9vjvw384EnmdChidivFvXz4gka30Ujwdalytwkuhw2C9qaMe6NP936LVkzGD7
 6+HDXIEz+qq5SzYjf03TBEx5+yumA+4ih3LBzghVLW1fatRodPXlIZa5sCxsEKLZtJol2Ton/km
 U0fLQQ11yuAM/Qu5iWdcXA/ZCDcjbqpFtjbBtLIte516M9X0fK+aX6L0yz0jDViVcJmmQTrskHR
 GYhVw3KZwKLR27Y1i3L/miaF0nrclgwr1ap/23x/JwDCFMUEXXT4xjhCirulqiE
X-Received: by 2002:a05:6000:400e:b0:460:18cf:d49b with SMTP id
 ffacd0b85a97d-46032dabbc0mr31051349f8f.15.1781075824696; 
 Wed, 10 Jun 2026 00:17:04 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-144-251.home.otenet.gr. [2.86.144.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4602cda3651sm57712647f8f.32.2026.06.10.00.17.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 00:17:04 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:15:50 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 10/27] tests/tcg/plugins: build list of test_plugins
User-Agent: meli/0.8.13
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-11-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260609214745.772536-11-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgemwf.258tji04enkpa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

On Wed, 10 Jun 2026 00:47, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>We previously had list of test_plugins sources, but not the target
>themselves. Create this list, so tests can then reference a plugin by
>its name from there.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> tests/tcg/meson.build         |  1 +
> tests/tcg/plugins/meson.build | 11 +++++++----
> 2 files changed, 8 insertions(+), 4 deletions(-)
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index b6a375e9eee..5cd80f3c030 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -30,6 +30,7 @@ tcg_tests = {}
> # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
> 
> # plugins come first, as we need to build the list
>+test_plugins = {}
> subdir('plugins')
> 
> # Finally, we can create all test executables and test targets
>diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
>index d7f8f0ae0ad..2abc317d1e7 100644
>--- a/tests/tcg/plugins/meson.build
>+++ b/tests/tcg/plugins/meson.build
>@@ -1,4 +1,4 @@
>-test_plugins = [
>+test_plugins_src = [
> 'bb.c',
> 'discons.c',
> 'empty.c',
>@@ -14,9 +14,12 @@ test_plugins = [
> 
> t = []
> if get_option('plugins')
>-  foreach i : test_plugins
>-    t += shared_module(fs.stem(i), files(i),
>-                       dependencies: plugins_deps)
>+  foreach i : test_plugins_src
>+    name = fs.stem(i)
>+    plugin = shared_module(name, files(i),
>+                           dependencies: plugins_deps)
>+    t += plugin
>+    test_plugins += {name: plugin}
>   endforeach
> endif
> if t.length() > 0
>-- 
>2.43.0
>


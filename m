Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BBDC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVfg-00050W-MW; Tue, 02 Jul 2024 01:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVff-0004oV-D8
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:03:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVfZ-0007fi-9N
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:03:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42578fe58a6so17745495e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896587; x=1720501387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mkxj1rf41yYS/L7V0n38PLpXQTaW+pjDKubAqykoIKI=;
 b=geV+eAD0RLpWBUkU8Evm1ve4vkBOwLy3P7G13J+g0ZX1vZa9sB4bzMVX7lRV6jWg2c
 5AQIlJv8sSh5Jxjs94SCaLwo8JYRCVrvoUV4G8Dro3dv7il8xSvf8A0+eDYuh97e1m/Z
 wCDBLbeAlAM2m99yKmu6amQ2GPiTkcgdvffCK3SKl3OQu942kwE8vJBuPwVShkaE+uYY
 NMTEXIekPKqA9Z+rcUZ/LG7Iz3odGCxJhjeUdcN3MQpHQeJyu0wNzXUqbUpbxcrYaUiJ
 9qsPuSn0oeUJlzjhGwnFFjuzBUKgUGinuz5i1dceU8F5/Y+GNAgcPd4SlkzvAGAT/7xq
 bydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896587; x=1720501387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mkxj1rf41yYS/L7V0n38PLpXQTaW+pjDKubAqykoIKI=;
 b=l9e4yVMf92A5/gbOappSxNHVYZKvfS3hvB9wAYcMGU1R71fzaC+jFR+eKp8fY+LFG+
 6jWhP9jM5VnEYHwQbbFrq/NY3JT7jWIwS6W+Qy73iuJcJzI+dSJsC25opxWX3BeSb2a6
 IUQESIP7ptCI5D3ZV3IX0oW8ld+Bd1mj+2UB7CSqBUSO09OXg9itDUcVcjcYCnOiYlat
 W1D5hNrACB2Q9FxIK9vqTacOXlC21s9Mk96BebZ0mjt5oIkskaOUDA24l8hdxOqUURly
 eeWTWivQJWz7BNxCgTKq+uC/89S942qdxzBvQEXmqypj+d1+oQtC5GBmxDqlkIOJ0A08
 +4cg==
X-Gm-Message-State: AOJu0Yykoij7fzImrbPMFUtcr5zd5R/NXDypiUGL98iAoEXsrg0EzxzS
 FwcePNpIwd944MDJlObrPHolIc/uX5lrilylTuV0sCMRt+5k2B2KKz8WwaaFjUBJee+3dwiKpQ0
 h
X-Google-Smtp-Source: AGHT+IH5kUcA4G4IbzV3uaFl63nOwY9ynZtozkwdklUl4h+B+mqduwp2A/7zkmwE/YXXfcyOJcAXPg==
X-Received: by 2002:a05:600c:2157:b0:425:5ea7:1f7e with SMTP id
 5b1f17b1804b1-4257a034e49mr59240875e9.10.1719896587370; 
 Mon, 01 Jul 2024 22:03:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b068d1fsm180045105e9.23.2024.07.01.22.03.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:03:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/22] hvf: Drop ifdef for macOS versions older than 12.0
Date: Tue,  2 Jul 2024 07:01:08 +0200
Message-ID: <20240702050112.35907-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

macOS versions older than 12.0 are no longer supported.

docs/about/build-platforms.rst says:
> Support for the previous major version will be dropped 2 years after
> the new major version is released or when the vendor itself drops
> support, whichever comes first.

macOS 12.0 was released 2021:
https://www.apple.com/newsroom/2021/10/macos-monterey-is-now-available/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240629-macos-v1-1-6e70a6b700a0@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c   |  3 ---
 target/i386/hvf/hvf.c | 23 +----------------------
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index c008dc2f1e..6ca0850b20 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -23,10 +23,7 @@ const char *hvf_return_string(hv_return_t ret)
     case HV_NO_RESOURCES: return "HV_NO_RESOURCES";
     case HV_NO_DEVICE:    return "HV_NO_DEVICE";
     case HV_UNSUPPORTED:  return "HV_UNSUPPORTED";
-#if defined(MAC_OS_VERSION_11_0) && \
-    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
     case HV_DENIED:       return "HV_DENIED";
-#endif
     default:              return "[unknown hv_return value]";
     }
 }
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 2d0eef6cd9..c9c64e2978 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -427,27 +427,6 @@ static void hvf_cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     }
 }
 
-static hv_return_t hvf_vcpu_run(hv_vcpuid_t vcpu_id)
-{
-    /*
-     * hv_vcpu_run_until is available and recommended from macOS 10.15+,
-     * HV_DEADLINE_FOREVER from 11.0. Test for availability at runtime and fall
-     * back to hv_vcpu_run() only where necessary.
-     */
-#ifndef MAC_OS_VERSION_11_0
-    return hv_vcpu_run(vcpu_id);
-#elif MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
-    return hv_vcpu_run_until(vcpu_id, HV_DEADLINE_FOREVER);
-#else /* MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_VERSION_11_0 */
-    /* 11.0 SDK or newer, but could be < 11 at runtime */
-    if (__builtin_available(macOS 11.0, *)) {
-        return hv_vcpu_run_until(vcpu_id, HV_DEADLINE_FOREVER);
-    } else {
-        return hv_vcpu_run(vcpu_id);
-    }
-#endif
-}
-
 int hvf_vcpu_exec(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -476,7 +455,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             return EXCP_HLT;
         }
 
-        hv_return_t r = hvf_vcpu_run(cpu->accel->fd);
+        hv_return_t r = hv_vcpu_run_until(cpu->accel->fd, HV_DEADLINE_FOREVER);
         assert_hvf_ok(r);
 
         /* handle VMEXIT */
-- 
2.41.0



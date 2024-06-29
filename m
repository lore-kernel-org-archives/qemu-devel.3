Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589C4C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 06:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNRWA-0001Bi-NX; Sat, 29 Jun 2024 02:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNRW9-0001As-1D
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 02:25:01 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNRW7-00007b-45
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 02:25:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f64ecb1766so8538015ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 23:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719642298; x=1720247098;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vo26IrThPfuGb/nchx9eA6X0lLnZnVTJoMHfHfP7SzQ=;
 b=fAHPk5HminvPP+zadRqRMiehkG5mao84jC7/TUHSJf9CQhtZ9k+ik9x09etVFQn1kP
 W1fTayt2dmoinL1Pai7kVi2+vZ1Tn4pwy2eAUBKhCJzp4tuY0+gc0zZ3NC3y1yiXwUCz
 ZadykZ7gCfUIkzG4P8hC+7BAbABxdy+J2qsG1VwNyjm9/ZY2N4N1t3lUnbAMkIvs35gb
 eeyF7n9fXffTmJzoNRUqymE91XLzNm7uvYJydiyaxpQd0738aFluDoaeLImkPQBxEpp9
 zHAzIldw51JfKQ30QG2o8f9y+ylzAbnMyeCgWivfwFas8kayVOglmJk+JsnPWMoWXY8V
 4B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719642298; x=1720247098;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vo26IrThPfuGb/nchx9eA6X0lLnZnVTJoMHfHfP7SzQ=;
 b=Qfvbadjk544JvsLjNr5CcRFUDpdIY0X+krS4oRZDuOh8sOxh7pc0XbrJS+MxX3204l
 pdVf2GpJt34z0/dyzjMPGJcyF1GaLwa4oW+LmegODCzsEtVlR6ZDTCl9UgSOaLid4nDX
 gnFbuiFbcYPKu3fxZ+8qhRDN4eJBRlxY99SaGD3bmPtttyRPzVw9DMiIrQQfP7Ymqo+2
 RWD5534I4J08l+goAJ2WelGhhSMacu4TjpQmgDcpHABnfk7I2z5buhsd6a+WsIBEAZGc
 or6kThIw/wB6T9Twuym5Frf2de9kxcK27bZPK5h2yx/dWORZgulwbf80amA3znbmyilJ
 zoPA==
X-Gm-Message-State: AOJu0YwgYvI8+xrZXObw3vFF5ppQ7HhlLr2nQM/3eAb5PcnU9ogECDxa
 ppB0WxWhW5yJXdqGY/CWNyL3J4ZXUqILQ7M3wyF4qRnb4rUJeSYZtmWYYIdkoSU=
X-Google-Smtp-Source: AGHT+IF+WBuJaBRtam+e2QoBIdSw5sLol3x/crGxDWkttwqFlXt2yWwdBKGnNhk2s2/IMd/4CsbdzQ==
X-Received: by 2002:a17:902:6841:b0:1fa:304a:ac35 with SMTP id
 d9443c01a7336-1fadbce650emr937145ad.50.1719642297974; 
 Fri, 28 Jun 2024 23:24:57 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fac15991d1sm25237425ad.269.2024.06.28.23.24.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 23:24:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 29 Jun 2024 15:24:44 +0900
Subject: [PATCH 1/4] hvf: Drop ifdef for macOS versions older than 12.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240629-macos-v1-1-6e70a6b700a0@daynix.com>
References: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
In-Reply-To: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
To: Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

macOS versions older than 12.0 are no longer supported.

docs/about/build-platforms.rst says:
> Support for the previous major version will be dropped 2 years after
> the new major version is released or when the vendor itself drops
> support, whichever comes first.

macOS 12.0 was released 2021:
https://www.apple.com/newsroom/2021/10/macos-monterey-is-now-available/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 accel/hvf/hvf-all.c   |  3 ---
 target/i386/hvf/hvf.c | 23 +----------------------
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index c008dc2f1ea6..6ca0850b20ed 100644
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
index 2d0eef6cd977..c9c64e29781d 100644
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
2.45.2



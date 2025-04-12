Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59325C369A1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Apr 2025 05:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3TSM-0000gR-Ur; Sat, 12 Apr 2025 01:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u3TSL-0000gF-Nv
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 01:31:05 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u3TSJ-0003l6-V0
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 01:31:05 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so2221782b3a.3
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 22:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744435862; x=1745040662; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogO7i7TIXqsMEIrsP3iL8iXk/h44a8/7WuiRvUfkpEw=;
 b=NVUpNxSoYgne61Bc+tYGlFCGWuy8vDBLUD2qefK5VUlb18rq7mtxP0mt8LC+HN2Jk1
 /Gn372PPFWXOF+hfDhqCgLXfu5Xx2qJJVtlBig1l2y0XM7gZUroCuzbC5FqupNJBUJCJ
 ulDY19h+qAenuvk6zMLTFLNwo4HQrQH2LLrUlzDS2t+VLO3/K8tLWJt8z0WnGJ4R3eFq
 pi7UDoPq5XyiGUtfS6CT/xD9yxvopfPWbQMzO5eMpY6PwdAKK9FU6PYXDv2ZwcvlsaLr
 P1/o87vbDDEg0VjS80PKkmEYmokehxauiFB8AX0eGFfIAyE/4DNdUKDCoDGg1KDowcca
 jpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744435862; x=1745040662;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ogO7i7TIXqsMEIrsP3iL8iXk/h44a8/7WuiRvUfkpEw=;
 b=Czd4QEACfrDnNXoq7EZCfV43ThiufMTOqnDIQnn5EyPqU73k5+vgNdTXfTsdMq1DCa
 groPvgAr1mPgyI9VxPssQ1KQEpYYNUvSa9iqnl+GOl8b2DeAZltD+HWna5XtM3CxxPbb
 UNo6/UZiaTUhLGsVnFyDw1WASqZ3K2iAjU78AsZFDNe4DjcNV4MsUxfncbtkTuTd18KF
 TPcV4MrwWfEs+GMDrPy/Z3NLWItwzEFin5HMScQaeA3ApdAW89EPZr2jkwidU9GNOmel
 V0vHR0cswD3pGd/GQOY/nFTrVmvqVCY5kAkbaxAtChuQ83GDPEv0/ZDmPAYhrZVpn84X
 HnAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVEWE2HS4WQSUgs16raiKWNnwOt0oymbv2R5S7Wrs1IqZsf04j77JzzypSOFAHpuAoAVrLFww4tqyg@nongnu.org
X-Gm-Message-State: AOJu0Yx3OYZ3P/NNqOsKoT/PIW3ORmm+H56h0M0zlHpokLMHQN7Z9pds
 AHNcSW7rz9LBMwDBnsIC3aYDFxzC2YCxLY5XQa+dPbtA9veuyPBpVhtHiw==
X-Gm-Gg: ASbGnctnACZLms36fZTnDYwUhGe/DJNgRMGc+AZqNxnJEyrmPDBldP934xc9qf6/G/w
 eVjTMu0lOmXh4AJ0sXo1NQb4qwzrkiVRz0Hd2OgsokTRUt6/VNQXovgkETTVX1Bmlw1dXh78hVO
 DKwQQA6AwRQGbyLxi3gSyW+iSGWfFz77FZYs6hsxgMiqWg9eJfouuAOTmwLiBIbcjltbiAptMe/
 +6MF66u4LZVkliS1N3FVpYsqv9XWnZtJbc8uvRk/+f+Y0tZhH8YT3k5K1Q3fn26VWH3TQYg3g83
 IPu4RApB7aeJlfqicARBxDhI4vLb31HHTjWwbyzHGiLp
X-Google-Smtp-Source: AGHT+IGUBacOXX40mGBzVzr9rLKZHIGPlGikhL5iv/c3zi0XdsxK7aQC4WIaWcTE86Zt3abiMk7h3w==
X-Received: by 2002:a05:6a00:3901:b0:730:7600:aeab with SMTP id
 d2e1a72fcca58-73bd120319amr6787161b3a.13.1744435859732; 
 Fri, 11 Apr 2025 22:30:59 -0700 (PDT)
Received: from localhost ([220.253.99.94]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd2336ea1sm2740675b3a.179.2025.04.11.22.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 22:30:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Apr 2025 15:30:54 +1000
Message-Id: <D94EWG4QRMFP.123EPDW889YVC@gmail.com>
Cc: <philmd@linaro.org>, "Stefan Hajnoczi" <stefanha@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "Phil Dennis-Jordan" <phil@philjordan.eu>
Subject: Re: [PATCH 1/2] system/main: transfer replay mutex ownership from
 main thread to main loop thread
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
 <20250410225550.46807-2-pierrick.bouvier@linaro.org>
In-Reply-To: <20250410225550.46807-2-pierrick.bouvier@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Apr 11, 2025 at 8:55 AM AEST, Pierrick Bouvier wrote:
> On MacOS, UI event loop has to be ran in the main thread of a process.
> Because of that restriction, on this platform, qemu main event loop is
> ran on another thread [1].
>
> This breaks record/replay feature, which expects thread running qemu_init
> to initialize hold this lock, breaking associated functional tests on
> MacOS.
>
> Thus, as a generalization, and similar to how BQL is handled, we release
> it after init, and reacquire the lock before entering main event loop,
> avoiding a special case if a separate thread is used.
>
> Tested on MacOS with:
> $ meson test -C build --setup thorough --print-errorlogs \
> func-x86_64-x86_64_replay func-arm-arm_replay func-aarch64-aarch64_replay
> $ ./build/qemu-system-x86_64 -nographic -icount shift=3Dauto,rr=3Drecord,=
rrfile=3Dreplay.log
> $ ./build/qemu-system-x86_64 -nographic -icount shift=3Dauto,rr=3Dreplay,=
rrfile=3Dreplay.log
>
> [1] https://gitlab.com/qemu-project/qemu/-/commit/f5ab12caba4f1656479c1fe=
b5248beac1c833243
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2907
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  system/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/system/main.c b/system/main.c
> index ecb12fd397c..1c022067349 100644
> --- a/system/main.c
> +++ b/system/main.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu-main.h"
>  #include "qemu/main-loop.h"
> +#include "system/replay.h"
>  #include "system/system.h"
> =20
>  #ifdef CONFIG_SDL
> @@ -44,10 +45,12 @@ static void *qemu_default_main(void *opaque)
>  {
>      int status;
> =20
> +    replay_mutex_lock();
>      bql_lock();
>      status =3D qemu_main_loop();
>      qemu_cleanup(status);
>      bql_unlock();
> +    replay_mutex_unlock();
> =20
>      exit(status);
>  }
> @@ -67,6 +70,7 @@ int main(int argc, char **argv)
>  {
>      qemu_init(argc, argv);
>      bql_unlock();
> +    replay_mutex_unlock();
>      if (qemu_main) {
>          QemuThread main_loop_thread;
>          qemu_thread_create(&main_loop_thread, "qemu_main",

Do we actually need to hold replay mutex (or even bql) over qemu_init()?
Both should get dropped before we return here. But as a simple fix, I
guess this is okay.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


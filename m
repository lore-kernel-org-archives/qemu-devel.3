Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE7CC369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 08:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA2rh-0004TP-Ky; Wed, 30 Apr 2025 04:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA2re-0004Rb-Rg
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:32:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA2rd-0004JH-4N
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:32:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso66469735e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 01:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746001939; x=1746606739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2qvonH+2UdIFy8nw1UMPJbLg1oAPPZJBDd5LZzjkU1c=;
 b=GgrpCZZAr1dqX/QWNL8DylU0R7z8V3z5g+Lrv/jcxZZtPfuXZ29MKlKvUd20oJHhjt
 4MGVOkUNKMPwzy9pV4I3Y+B+rqOk9iAtitID347gYsW9rpIPtk7U3xSRsb8h0W6wRanx
 p5jeli4WTcyf3+c3jsckKCvLopGsiwXrSve0OljF7v5Gko0dYDGWD+y7JT2xxBnwloyk
 B89beJNz41xrBoJFgpD8cyCdeH4NCHjLbU1Oxav04sBBforDFR5LeXewBU045lxiQtOl
 ILjbBzScMBnfFuaLVWa8Um7SUGOLgRWZTIHITw7J/YGIxMm7WBiqMCWTzpxE0B0MHmVm
 VhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746001939; x=1746606739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2qvonH+2UdIFy8nw1UMPJbLg1oAPPZJBDd5LZzjkU1c=;
 b=VSYlI+H+FNLSS5bQzZxoc6Ae+F3zCkmVEfMJaWlk6w0rIe5LBUc43Cgg24ZDKjqznH
 IVR0kmgr9XqPsMiEP4Du5w4wANbGi2FqL9tj8nksum8EOuq0VlsrDF8D+HhCiGjB6Dqz
 ewFU4R+tCy1CYKwtOqSkTOL2WWWXnhXRofl4bIoGNwt+5oCpDcwliPkak3KWMkXP5DuS
 RfPF+5GB6AdAVx5HuoVw+1iyNu7gaku6TiraQbEuKYs8ouEfbCzbZc32TD7IciKwowlm
 5HG/8JDQ2FiXlnyVAzkBUo3ILXymF9MNnE2djUvM6vxIThWbU6HCZeTxb0urjn4QUwxM
 e8fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6J+e8sODWpIlf9HWL4OhEyPppvZrUWQ0vWNpoZ/+6kmWSPsk1Su89vgu2O83sHxgRRKD9oYwWoGJh@nongnu.org
X-Gm-Message-State: AOJu0YzVBe40Ib+TQjp8giHa8sInmMzQUkH/H/eYAPPEfQ6JTjvEIe8I
 Zf+feg8CK32Tvt8hzBdyXPIqx3S85QxWGAbMhk+4ZNYK1zmzE4ADSa5dSfa4+1c=
X-Gm-Gg: ASbGncsPVHqvc80a6pLXwZvsh6bb2L4jB720ryiS9qzwjp+fCyw+vXtcFtpIckaYse5
 ZiRLOZKuhJVd6q/Q8FMcpDUEKcY4ExiVmzy84Hwp3/ybdSH+WU+UsMvA4Vfm3vx+CoERnF035aq
 EoqdGebn2DTLBsj4eqKJxYV1FEV+nUNu9abUyNq7PXeQyAXovMr1naYPnCkuqHtf/JyDNFWTSuh
 JrWlYsDZprNmNXzVlcey2WrJrrGo2i0k4r0ryuaLhp/6mKna82zvRmsS9YWSRGVHnDXM6MOmIZG
 laTzOSlV147QAjPzrXdjAcKnUWecRl1wQmpJjkB/wHHT/1Mjl2koY3J6IH24tIZtsMn1yrAMEGY
 nC28ZOkpuiVIcH1qCdXhUBltX
X-Google-Smtp-Source: AGHT+IERAra2NjcLKE4jV51pt8p4zQVzESu3IBG3Q1PyFrG6gIshOZrE95suQGiFVeUO2wpirjpSCg==
X-Received: by 2002:a05:600c:1385:b0:43c:e8a5:87a with SMTP id
 5b1f17b1804b1-441b1f3a597mr21245755e9.16.1746001938912; 
 Wed, 30 Apr 2025 01:32:18 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2bbc0a2sm15637755e9.30.2025.04.30.01.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 01:32:18 -0700 (PDT)
Message-ID: <dbc62384-b05e-4f30-b82a-395a82812f65@linaro.org>
Date: Wed, 30 Apr 2025 10:32:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] target/arm/cpu: compile file twice (user, system)
 only
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
 <20250429050010.971128-13-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250429050010.971128-13-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 29/4/25 07:00, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index c39ddc4427b..89e305eb56a 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -1,6 +1,6 @@
>   arm_ss = ss.source_set()
> +arm_common_ss = ss.source_set()

Unused AFAICT.

>   arm_ss.add(files(
> -  'cpu.c',
>     'debug_helper.c',
>     'gdbstub.c',
>     'helper.c',
> @@ -20,6 +20,7 @@ arm_ss.add(when: 'TARGET_AARCH64',
>   )
>   
>   arm_system_ss = ss.source_set()
> +arm_common_system_ss = ss.source_set()
>   arm_system_ss.add(files(
>     'arch_dump.c',
>     'arm-powerctl.c',
> @@ -30,6 +31,9 @@ arm_system_ss.add(files(
>   ))
>   
>   arm_user_ss = ss.source_set()
> +arm_user_ss.add(files('cpu.c'))
> +
> +arm_common_system_ss.add(files('cpu.c'), capstone)
>   
>   subdir('hvf')
>   
> @@ -42,3 +46,5 @@ endif
>   target_arch += {'arm': arm_ss}
>   target_system_arch += {'arm': arm_system_ss}
>   target_user_arch += {'arm': arm_user_ss}
> +target_common_arch += {'arm': arm_common_ss}
> +target_common_system_arch += {'arm': arm_common_system_ss}



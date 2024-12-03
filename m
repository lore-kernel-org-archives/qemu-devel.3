Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8C4E74AC1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIVDl-00038o-Pl; Tue, 03 Dec 2024 10:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIVDV-00037p-8V
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:53:38 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIVDT-0002eB-Of
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:53:37 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa545dc7105so892067266b.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 07:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733241214; x=1733846014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CDqrEJs5OhNeWJiBb9sU9ED27wZyZSyw4yGh+delQvg=;
 b=YvlM548cYvUQEt+v/Rh8f5UadXU5Iv2CqhgFtX6KlUPo8OByHvq2LMxYji+htufUqZ
 TMFAX69f7br3vj2kdsa40MzjsokJIFC5GOWw/bqZE7dcVG0Dj7jxdKu40yT5+c9ocHWB
 7sLgP9wfORDuodaGFqDurHftw+rL6wlYDqdc3yJBfIlV5hZoBbPt/17yhm1NekKB7vhv
 hcaVl9WED2DnDS29GThxT3qMr0BN+WaRmzTBmsrReRBG657J1s3fzxt1a5j7Tz4Z8+kZ
 lO74AMIUjx1OIwXmAZt7saa3fVzfUBVnrt0wdr60gVpMYtoBS3l7DlPGEo/d5aDA0y0g
 iVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733241214; x=1733846014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CDqrEJs5OhNeWJiBb9sU9ED27wZyZSyw4yGh+delQvg=;
 b=cjAgEr6VpkOBQxeD0hRnjXgnHgiHRpB0/TTb+bVMdmXQtRwIX9607GiE/B5IA4CQJn
 YASGtv8LJqPBKkDxdg5KXxL0UyOYqNKiPCLt72RAYRQX/lfm4+Uc8WxpSUTL7ewXtwyT
 +31ghNbLWd4P2A0kEbpn/y3SmovQOfv/FebxrcQWjuM7+X8ZAAjlWWbtEMFdtmROlqhU
 V453I/FndJYhfERphqWfbhJibRYDKrzIFgOWmGsuLc/eFdnbRC56rqbZXtuxrs95Pb5H
 Gi/Q1oPlf+QtCdeyE8SqpX09ZpTzSRnFj8kK+1XRaG+B8+2HmF44OhllC1r5cx8UwF3f
 gB3A==
X-Gm-Message-State: AOJu0YwpQCqT1tFUpCLt+AazDHBHhf4L7gXu17tVyHCD/gYmuIfuzBKe
 v+ys0xJEyaA3zssgyHQJk2rYnk1k8EP4RkyMYm7E61ir+djcHd5bpF6nIiOheKvRvtMwo4sG+ex
 ppHM=
X-Gm-Gg: ASbGnctKKMjNERynOg4fTSsRmTya24aa+/8RkjsUy+hxgppCmuuhYVJQXGV6LksKtcE
 yqd6tjwugtooX/fSsTcvpHNukRS9J2We3ZflA8lxit8qbGV9MBwKzP2ucRgVob5/gCqkJjkAeGI
 hoD2k8vaS3Jr+sqiOwaGRKYt5zkOUB++jFI7WmI3pQoYrMq48v7Xe3XVHEs0lnK3hDC+QqrvY9h
 HawChNtAu5RmS4UTZp3ln+Hi8+cw0BSpBKsHq8Mw+fbl5jxyNuCYtMLo6fO2cnH+Q==
X-Google-Smtp-Source: AGHT+IG3c9b2k3ackyoL47hmqGNY0K+1IrKO4aic6XfSainBKk7w6lyhZxKNK4ZdNufmG1I5GSTWSg==
X-Received: by 2002:a17:906:3150:b0:a99:5f16:3539 with SMTP id
 a640c23a62f3a-aa5f7ab68ebmr259380266b.0.1733241213709; 
 Tue, 03 Dec 2024 07:53:33 -0800 (PST)
Received: from [192.168.69.223] ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5998e64d0sm627641966b.93.2024.12.03.07.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 07:53:33 -0800 (PST)
Message-ID: <06569135-161a-483b-8677-36bb55a26679@linaro.org>
Date: Tue, 3 Dec 2024 16:53:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] system: Select HVF by default when no other
 accelerator is available
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20241203094232.62232-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241203094232.62232-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 3/12/24 10:42, Philippe Mathieu-Daudé wrote:
> When testing with a HVF-only binary, we get:
> 
>     3/12 qemu:func-quick+func-aarch64 / func-aarch64-version                                      ERROR            0.29s   exit status 1
>    stderr:
>    Traceback (most recent call last):
>      File "tests/functional/test_version.py", line 22, in test_qmp_human_info_version
>        self.vm.launch()
>      File "machine/machine.py", line 461, in launch
>        raise VMLaunchFailure(
>    qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to establish session: EOFError
>        Exit code: 1
>        Command: build/qemu-system-aarch64 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -machine none -nodefaults
>        Output: qemu-system-aarch64: No accelerator selected and no default accelerator available
> 
> Fix by checking for HVF in configure_accelerators() and using
> it by default when no other accelerator is available.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v2 was https://lore.kernel.org/qemu-devel/20241203091036.59898-1-philmd@linaro.org/
> ---
>   system/vl.c | 3 +++
>   1 file changed, 3 insertions(+)

Patch queued.


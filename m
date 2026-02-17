Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37271E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 06:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsxXn-0005Hl-VR; Thu, 19 Feb 2026 01:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vsxXm-0005HM-BB
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 01:29:46 -0500
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vsxXk-0005j4-Rf
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 01:29:46 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 879c39f581bb9d2849409937659e857fb5e1b098b8c85e062cc7c158ca25d770 with SMTP id
 6996adce9ac41031d6c36e40; Thu, 19 Feb 2026 06:29:34 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1771364373;
 bh=h7fHlbAlIf/6pxZaA5zCsfFpjO5mV8oH1n8QQ9WSqX4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=YlZ+g+3BjUA0MT7J4hEV4PWoiIepxOqPNQX9my0qN0Hnx+r3tAU2/30+N2PYdhsBh
 +MYPSuxB70tH8GIzIq8bfqr4J6Me+fZ6gCACt4izFDlIrKQe94so6b9HU0iNg4HvfA
 2jKh6KeUEXwHah1CsgROp+HxUII3ag9w0XIltvhprlwrIH4+n195aSLUJsb35gVEcA
 1peVHXQ7VpHDWX0cGEbkv7hxD27Uq/SrAcMnr8jIXl6vDK83G+aSqXidOkMbIkpQZQ
 ZBPGNZ7jQnvUWLxGIZAipsHVYWUWvET03x9Oq+014p3K3owgLI33fkJwKshzmAzKFj
 /vW9DRaE+kVoQ==
Message-ID: <1362c33d-5a78-4777-b0b3-2794e90fc856@yodel.dev>
Date: Tue, 17 Feb 2026 15:39:32 -0600
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] target/alpha: Reset CPU
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <20260217-alpha-v1-1-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <68c6ced9-dcbc-4981-b2be-65cdf7e2de9c@linaro.org>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <68c6ced9-dcbc-4981-b2be-65cdf7e2de9c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi, Philippe

On 17/02/2026 11:01, Philippe Mathieu-Daudé wrote:
> Hi Akihiko,
> 
> On 17/2/26 07:34, Akihiko Odaki wrote:
>> alpha_cpu_realizefn() did not properly call cpu_reset(), which

...skipping...

>>
> 
> We ought to rework the CPU reset paths, it is too confuse.
> Peter / Alex / myself have been there. I started some work in the
> area, fixing few inconsistencies, but it isn't a priority so never
> got over it.
> 
> We really shouldn't manually call cpu_reset() in DeviceRealize
> handlers, thus not add more calls, rather remove. I appreciate this
> is a temporary kludge until we sort the cpu reset logic.
> 
> At a glance, since this is an icount issue, instead of adding
> cpu_reset() all over, I wonder about this surgical kludge instead
> (untested):
> 
> -- >8 --
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index ad94f96b252..0577c25e3e8 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -1071,2 +1071,3 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
>       tcg_iommu_init_notifier_list(cpu);
> +    cpu->cc->tcg_ops->cpu_exec_reset(cpu);
>   #endif /* !CONFIG_USER_ONLY */
> ---
> 

I'm getting a regression in mips64el malta with the above; not sure why:

     meson test --setup qemu:thorough -t 1 \
         --num-processes 1 func-mips64el-malta

ERRORs out.

I like the idea of reworking the CPU reset paths; please Cc me on
related work you submit so that I may test it out (though, I'll keep an
eye out for it anyway even if you forget :))

Thanks,
Yodel



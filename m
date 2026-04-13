Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FD4F531DB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCPQL-0000i9-8H; Mon, 13 Apr 2026 18:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCPQJ-0000hy-7e
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:06:27 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCPQH-0008Bz-HG
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:06:26 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d7badbd7dso660856f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 15:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776117982; x=1776722782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i4RsorHF0acEAVG7guZevG7EEg75GuFR2NltetW7cXw=;
 b=moUYgEDZIWO77hRHiWnF67/qHhVhUrOdAZKk01kwu9lmdlJjGq8gTZiRx5GV1L9q2g
 sffRv/D+UrR3KSwMdNAzjHzzoRgfGqbAbxQyPV3W1n4F1g/DE6E9lwLNMdvTScpvVo/O
 HWfpIXdyN5cLI60quLoibB4q4ykFeIfF04/vaN5MnAUI8oKRPA/UX2aKkL+TcIyoNdVo
 3c4eoMRkNTSYGyJm6WzVtmJ1heCWMGAJm2NUXx9ehJhZ7KeO2VYIhuvWsyDU7biOacdW
 qm0xnyAto7jl1eVtoLxt8d33LXNIR8iLEt21cgdy+D7+UeM+dONZub4NQ9jvPoSDoQxc
 +gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776117982; x=1776722782;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i4RsorHF0acEAVG7guZevG7EEg75GuFR2NltetW7cXw=;
 b=R7yIiO3dmNpd48dG+lvOqcnS43ADwusRsjKza5f59WyD+ox6Or331kNxm61qXsDuiO
 nq5rXPzKTvwpk4HUcWPRpWiKhiH7Dq3L7iEDQhNBntA2V/UfILhpYNmnXGSSUBILeiyJ
 l2irzJowO2T32sYquyBiNpGroVqVccqNOSpR27NkeFDk6CQHAwDO+exH9P5QIVN6w6T3
 hTZB/yc77cIokI//o7byfnGhZdp0JoyxzkbEiwwC2ugRcFkWlKHVivuyzTH33MvfHhU2
 0sF+v874azth71+ZXueUy3N2yltJ5pBqW4R3kYLkwaDBioEqsPH/3lKfowwJ6H4U12Ok
 ueFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DfYlJowvKFp28EVSRkIO4qgVrKH28lTinDRDHpwzkIJbO8CqqkY9xS+uiAyX+MhTAB4h3LIHACmeY@nongnu.org
X-Gm-Message-State: AOJu0YxK+DpBLDYQXsInqOExDNVlJDgiaXhryYTj5EoBnjUxEezWkQTu
 OugiR0qOPokA/iylXkupUxlCsg2vFHXMu5Z3vJmnWmBPySostqzzfMmfN3GHEER+WeU=
X-Gm-Gg: AeBDietfTZ5BrPnad/Iz8PLgMzSQbMySinuDD3C/o8s4QxEuUr+Yx6mdiplreCk3elO
 5Qt4P27jhDHFtOYh2ZOLF1A1A6OkdcbQuqEFG3HWu8FzvS48iNEP7oNCNUnAhfFwxl8BsRJE8Vx
 wHb5/mI3Bu6h8c1Bt3XKeeyDBXhnf4JJ4XfIGDyjYvf/ayAYoZjyov2yqhsPPDAx0/WRGh/7umJ
 xwAMWe6+cZs4O09yG1O2pLcqfas2K4VqaeNqosP35TGGWvtf4Xla1pAWLNb/VY2gO/x++fc+u63
 +aw2rB1DIgQZWnoUgeDR7WYivziYZAdmYAYI1qRdgZzTkde1lj5CWVOumW1w/wm/Rapjj3g9K5M
 POmSxBBFsFub8ikEc+BvKcOwfIszac9I/WuBWN8PjJ//R6BtiQXWbzENyg2S7bxNmcxSAtmQRqt
 5zCznFTUXzimtKQxOC4Hp3dQAgf3/+UEu7DxsbY9nZStojHLMc7XrabBZYJ34Q2JhNYw==
X-Received: by 2002:a05:6000:144e:b0:43d:c95b:c46f with SMTP id
 ffacd0b85a97d-43dc95bc595mr1647876f8f.38.1776117982447; 
 Mon, 13 Apr 2026 15:06:22 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63dec28asm39519258f8f.15.2026.04.13.15.06.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 15:06:21 -0700 (PDT)
Message-ID: <79b575cb-5d7d-4e3a-80f1-5b67ac7cad9f@linaro.org>
Date: Tue, 14 Apr 2026 00:06:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/hvf: fix double hv_vcpu_destroy() causing teardown
 error
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: agraf@csgraf.de, slp@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, mads@ynddal.dk, brian.cain@oss.qualcomm.com,
 mark.burton@oss.qualcomm.com, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <70cca2a5cdde3e6531e5c8f1e399e0b584d51ad6.1776096073.git.matheus.bernardino@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <70cca2a5cdde3e6531e5c8f1e399e0b584d51ad6.1776096073.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi Matheus,

On 13/4/26 18:01, Matheus Tavares Bernardino wrote:
> The following callstack causes hv_vcpu_destroy() to be called twice,
> producing HV_BAD_ARGUMENT on the already-destroyed handler:
> 
> hvf_vcpu_destroy
>   |
>   |_ hv_vcpu_destroy
>   |
>   |_ hvf_arch_vcpu_destroy
>       |
>       |_ hv_vcpu_destroy
> 
> Let's remove the redundant call at first function.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>   accel/hvf/hvf-accel-ops.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index b74a5779c3..d1c532f7e0 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -113,9 +113,6 @@ static void do_hvf_get_vcpu_exec_time(CPUState *cpu, run_on_cpu_data arg)
>   
>   static void hvf_vcpu_destroy(CPUState *cpu)
>   {
> -    hv_return_t ret = hv_vcpu_destroy(cpu->accel->fd);
> -    assert_hvf_ok(ret);

That would break x86. I suppose I screwed something in commit
feee55d36a1 ("accel/hvf: Implement hvf_arch_vcpu_destroy"). This
was part of my split-accel work which as of today I flushed out
of my head so don't recall well.

At any rate, better to remove the duplicate call in ARM's
hvf_arch_vcpu_destroy(), WDYT?

>       hvf_arch_vcpu_destroy(cpu);
>       g_free(cpu->accel);
>       cpu->accel = NULL;



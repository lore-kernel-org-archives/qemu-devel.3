Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B721E64AA6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tITJv-0003Ca-KQ; Tue, 03 Dec 2024 08:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tITJs-0003C6-LI
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:52:04 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tITJq-0003Cg-Oo
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:52:04 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2965e10da1bso2808891fac.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 05:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733233921; x=1733838721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pBZIPH1CTruDNLFOIuJwEzfgWekcIy2V33xrRcaucGQ=;
 b=bwlrI4iqoEmV+r2rocQaNhzaP8Fy3J67u6n3PPU9pymWHwQIIkLzYY/Z8Y3WGW1GqP
 FhfFm0bgD5tVwNdUiJ6V1TGV/lD6oqNM7bgiRhGiPIorjmOV5NFDD8TuxpTZ5IQkkjX+
 uuoHYyQutbNdCQ+Vy5giomzIg6OhJVHBC+t23vJe1x0MBmYXgaOGM6Y+y/2jvzSskkN0
 vwedPo6keycReYTWAiFomNx8grSUKZKyY3b3yIH+fYXadMnJjH2FaQZiz/H9S09S4/p6
 tJ5XVY8ng8VaBcbzmMGyRjAKNJCPU4yuChnXqY7T3ju9UHK/umPeSpLM6gGIhAoyoxd3
 S+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733233921; x=1733838721;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pBZIPH1CTruDNLFOIuJwEzfgWekcIy2V33xrRcaucGQ=;
 b=sCGx1heENRCdTThab60YIQU2RS57TTTxXd8+tiDM0wPatH7LfOruIpgfN3iSMBesFd
 OSUGizTF6cPMd3z4u/BngQDvuCPTe7DWHUNA5xCLOjjAO9dKgwEC6R8liWR1gzF719Vo
 tMGy7Jvk8eV2INzJFTPGe1wFAb4E3HPeiB5wV5egQkchhafTU4SQ8msp6s+oOpKxdOfV
 Stzy1Z+tcvQ8HAL/oEwLvapw6ZeNR8u7jSMTuh+clOCiFjSIoX6/frBCxWqrJgwWJamr
 MWo6OQGRBenp+bhmCD/T/E+3kcnJaMrvaFnTRhxHPgtAPHzQk7WZ4RubY+srSYUZHTvC
 F2tQ==
X-Gm-Message-State: AOJu0Yz3ds3G4LbUPHxjVa/TweWwSW324ry1bmmf0e8Ft69ywI8t4DbM
 xAcckfDrwxHStqe6SF7mYhGh2oTIGNuk6xcLdvSJeZx4xSXPHjBCKQ9uMY3QJCTBHZb6Bek0xDX
 zssg=
X-Gm-Gg: ASbGncvoj226nTF/+UzzfywJZxRZpR5d6/sR3daUkew4MjCIslhJ/PGvPr1eHqcrLpW
 BuAWmfQtcACswTXxSt+qT8xp76BXUmuvMqIFzC5YeOPxXPSj35ikNeoham7wcts96aMgZxlF6wZ
 RIlnHjaOd9ziN+1sgKDnZ+RPQdVfg8KcJ2aV6LgNEHiI7JPW0Q+yVoFbcfw3JnbUt5lgd/p38EL
 Q2K0NFSkQu/w9ANHn2W5SvsuV475UfPW1Fp/LXInEOmgHTkEbJIkcVZMuW9hW2pFcDQ2NQG/zXg
 jJ88o+mSEkPaU3irJ0il0Hpt8w6o
X-Google-Smtp-Source: AGHT+IHeuI5zPi2jkDAAdNAI9rvhOMn36MUGEqcrhaVLJEDicA3+U3HKC9SsQIhpG8OP1Ofhn4k48g==
X-Received: by 2002:a05:6870:b07:b0:297:27b5:4d30 with SMTP id
 586e51a60fabf-29e885ed433mr3063921fac.2.1733233920918; 
 Tue, 03 Dec 2024 05:52:00 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e5035d5e4sm1961307fac.45.2024.12.03.05.52.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 05:52:00 -0800 (PST)
Message-ID: <da5ade71-89dd-408a-a84a-6d661ddd8282@linaro.org>
Date: Tue, 3 Dec 2024 07:51:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] system: Select HVF by default when no other
 accelerator is available
To: qemu-devel@nongnu.org
References: <20241203094232.62232-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241203094232.62232-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 12/3/24 03:42, Philippe Mathieu-Daudé wrote:
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>



> v2 was https://lore.kernel.org/qemu-devel/20241203091036.59898-1-philmd@linaro.org/
> ---
>   system/vl.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/system/vl.c b/system/vl.c
> index 54998fdbc7e..2f855d83fbb 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2362,6 +2362,7 @@ static void configure_accelerators(const char *progname)
>               /* Select the default accelerator */
>               bool have_tcg = accel_find("tcg");
>               bool have_kvm = accel_find("kvm");
> +            bool have_hvf = accel_find("hvf");
>   
>               if (have_tcg && have_kvm) {
>                   if (g_str_has_suffix(progname, "kvm")) {
> @@ -2374,6 +2375,8 @@ static void configure_accelerators(const char *progname)
>                   accelerators = "kvm";
>               } else if (have_tcg) {
>                   accelerators = "tcg";
> +            } else if (have_hvf) {
> +                accelerators = "hvf";

Nit, drop the variable and do if (accel_find("hvf")),
so that accel_find is not called unless the tcg test fails.


r~


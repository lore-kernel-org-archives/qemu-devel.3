Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677D2E7718B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2025 16:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tT1W5-00041n-Fo; Wed, 01 Jan 2025 11:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tT1W4-00041e-4x
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 11:24:16 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tT1W1-0002vz-Uj
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 11:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735748651; x=1736353451; i=deller@gmx.de;
 bh=iihY5CVQP0fSYvtg7e2gDoLrGpoUK69iCsjPogcdg4E=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RRnQ9kd9xunk5FjaxG+iCXRMoWIb5/Rr09eFXC7VZ5ElXsuDTJ/EHn7TdJf+vnFU
 ASBanQTQKzW4SN5zRiwizREDdsEH5/pKCC+NsAJ63IfXNIr/6jfKNNcL/jKoRkE99
 uC3uCtgJy4JFLLQQZjiPdQzkH4t8SaopEYd6ixGUrpNg2Jj1B6wKCKYAW9sxoeCd7
 qJhQaKN28Lw8tfQJSx+qQr1nTJq3+M4axK6mxHsHb1eGpX0ANZR5kMIyD0xWc3KDW
 CJ370nFTCmhE9enxAxZA5fdxCu2XxmVEVMRd4ngt3lSuKr46SS1DqEshuXCa6z6Uz
 //nPqct7N5OacTajhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.155]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNcG-1u2MKh1Y48-00alYX; Wed, 01
 Jan 2025 17:24:11 +0100
Message-ID: <f3f6e456-92ca-46ef-8939-57addc953565@gmx.de>
Date: Wed, 1 Jan 2025 17:24:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] target/hppa: Only set PSW 'M' bit on reset
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241231190620.24442-1-philmd@linaro.org>
 <20241231190620.24442-5-philmd@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241231190620.24442-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Huc8QPm3w/0xERroKa5AYPYBrrman/w7bH6WEfpRgQCuvFtWwZQ
 3OLPJpy0WZ8Zwe2I9GnAYLQBdYGbi8ddnCSwD9ZAk6Xh0fsZ2vg921pbLFLsl1XzWSoDrgJ
 JHvVcwnL0FEhaLGQd66lAN4JSWJZEFbSmxDVU04g3GYIJiQwDEQgjy5jLd69F6GBeKUF8BB
 Rw9p/00RedPTKYNkhaGFw==
UI-OutboundReport: notjunk:1;M01:P0:IgiYhnSfTPQ=;QcgPD5btIl6ao0HqC71vzkLcajD
 IDVvhZooSQPWlOUhTKhBvxZQIC2/4H/EATh7IBeNY8QHIQvnza8o16fbTgCMzNd9emVRsylj5
 Y9SUJf/TV+gUeDtw+ejGEyqQboE6/4MxhA0TdPg44J4ftc3wxuO6XCT6rZ8fReoW3OyZpVbx4
 vJA62LV8aTGvAo4fbf6nNQAtu/Wy8q7HScAUiO+zfWtOHyIQM5+ztIzxkHYGWII/F3YR25UDH
 yXKkMM8P4biz+V3qZmGt3J4M7m0lsNeSWcwwcnYGaICKsWHh1l0NkV+RfGSEl03ijfcAFG4dB
 lhU/qHfZGR4eRRD1IgJoXWQiLU1ApVR1uCIrR9kKn3915xxWkqw8jHkMendEQFDrkIrnK1muv
 ZXi/mVNGh0L7a7Tsb0TBXH5E8ClLsfP8BDrAC1rArFgh3rPMZ0S97qD48YQ7m5niIoEAiK3y1
 Xp7i40UJmHPnZqe5YTKkows8UA27glY/wrWWau0DSl5foPnhMG4vKnoGVtGtRKR8G8GgiG4eE
 QiNr2hdkJxlWgOtYPoiXhRvJJz0CFrtMrjE7pK/UMmh7pfn8L/EXWH7YkvHCHSvOQQhdjrl9V
 wsr8vo1KK2lZzkfgJKrpMt+ZWcp+JklWuBRHk9L6jtERkU47DG1LSp2qMadwEHax3Mc/jN24R
 Q61aL0mvLewibN8/122KKtWZg3Zbp0OKnDbQ77CgWx7v/G1JltN5D5RfGktzowRMmqd9HYUtL
 XXPao2dSIHYdLRckH1hLRxcDDAOMPFFDOltW2Uel+SnJqAp80GLpgKRjFAAsyhiVIaWzDRJeN
 RJnF8274rI3YmyDz+gsY2b1yXgjB4fnTJ8annYInCrLrDszybeeUazJBjDWzUdRke+z9K3/Wq
 +7X6TP/UVPa2Yi+vayaML50D5eJA9Llu2trGrWc+7duseI2h3315n7yYKMfGpSiuGwQG6SUG+
 lMTTfPz3F1zfheK8a9iIsoJVSunnqWohHyMhaot8KvTuq7XRvraDj0sgjSks/cwZB1eyKfi3/
 YNlYUgIqbBgyvC3R1fEyIgSlP68KPrpKzIj6El2omuFiuLMjumYG0dzxwbay+sjKminhTyObr
 c89dwQf8PzsZ7ho4coP9/6KsxIUkXl
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/31/24 20:06, Philippe Mathieu-Daud=C3=A9 wrote:
> On reset:
>
>    "All PSW bits except the M bit is reset. The M bit is set."
>
> Commit 1a19da0da44 ("target/hppa: Fill in hppa_cpu_do_interrupt /
> hppa_cpu_exec_interrupt") inadvertently set the W bit at RESET,
> remove it and set the M bit.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Helge Deller <deller@gmx.de>



> ---
>   target/hppa/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 41538d39d62..dbd46842841 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -209,7 +209,7 @@ static void hppa_cpu_reset_hold(Object *obj, ResetTy=
pe type)
>       memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
>
>       cpu_hppa_loaded_fr0(env);
> -    cpu_hppa_put_psw(env, PSW_W);
> +    cpu_hppa_put_psw(env, PSW_M);
>   }
>
>   static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)



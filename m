Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFDB103FFAC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5vj-0001E2-LG; Fri, 27 Feb 2026 17:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5vd-0001A7-M9
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:03:22 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5vc-0005Yi-6J
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:03:21 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4837907f535so22146065e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772229798; x=1772834598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OQu2JvJcGPM4znj0jBebao6VRWtqbLw79zMXv6AcLkU=;
 b=hb4cr6ieMWGbxo4OqfNMvpPz4MmkasJl5FhEJPYKaKrLMsdDez35k7AG0omRsbV+1f
 6+Eeo5SU88814Jf8U6C4ft/FGpPMEM8+cyUZnIu6GFnWUWA0xKoCTvRB65NJwlk7lWG4
 xW+v/2ADNViCniba4Q1pfsJL0z6qO5JaDWV+dulaP4ySbsL+pqS/Nzcx8zsEzHixhhHz
 NU2I1wDW4UKl7E97wqhDdM328wgruZG4ACVFFt2EOsAT+Su/bL7/oxlkWCX5Bfk7svp0
 hbrX4FpEVD1fPq9+8BrtRAb94YdJRMCTizNInW7kwpeHkEqshPccBOKQ2hNiI9N/Bi4A
 r/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772229798; x=1772834598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OQu2JvJcGPM4znj0jBebao6VRWtqbLw79zMXv6AcLkU=;
 b=COZpV8Oaf9DaW/LvU0HTysgMAyzHUK+IxLSiTVlXZ0HjeVRr5zCaG/+zuhC30Vfv/S
 tJ5dwSnSSayY3W/bNWQyVsklQKw4mRytK62l6/zSlDgIrbMUG10MCIxQPXqqsq2XgQ4K
 RRqLTLmWK3uyehdwXMRSNxL8d+dP1wCycTGpX1WMBXgE7tEjm01zVQMysXDS51y3OrLs
 F+S8t0FWUvnBKWPpe+06pVBfnxf6p9Bc6O8XjmCoqGu5v/KfD2ONu9gCubppO2gxONA/
 Vi05oI2/eWrmdvxvCoSyjMbz0mRMES23WmyKKak/eWVE+hQupJEupZzk3YO8DhaPnIDT
 S1rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS8xZsJuGNjyfcS0fiXeEuB16E32r/Tw+arMr8+q5H126LGmuJXQY6aMVW1diieKBtMRw2m1Hs8MNK@nongnu.org
X-Gm-Message-State: AOJu0YxJ4tJF8B7SVbemn8jHzU4eAvmVrZRibFxtWikpA+bGec40glKi
 yRX1rEWyZn7YbWQeSXrvOL5/YLHCIdvOBYZaemZx8RfUvxP3UA74UiYFpAjrEaCqM+E=
X-Gm-Gg: ATEYQzyn3A6rEb3kkA/eM7cpYc9qU7dNIUh11M0VrrXspZKISpWokurQPBL9TnZd+pM
 +D4Og3klvNAjhCOi6Mhbi7ngaeUwrTp9qD7uimMnhVFQ41ZX03JaX49mKwHkIv5yKkb13GzzyI2
 n+bbAGUc2VUlkg9eMDVmYuif+tFAtpPaHA9y4L9yVvh2kBKjjEnprl/ZFUhZ8+Rq7Zvgx4VH9UD
 ugztcpt2L1GATW/u230yQ2T6ok5DL0umvLGJFEoT1w5tP+QVyYuokOa2mGpHLYLkun6n7DzwjAX
 KDNPEZ0Q9NGeE72Hn2KIlUVNl7KEtxxNQSKg6uJf7+jWODsbQ3pprpcYyOFluHZt3TUT0n+DDo2
 nW/QCh+3RxjQw4oJjVF0msXptCglObZ6/1Oq7bcpSbivj2JJIQYwrNBM8FZc8jsoFbFsr30VkVa
 SsIVkrKPr5wqgYpoKiXLSFDe5OU5Uf2YheqX2lNpHm58AJ57T8oQFMFdsizUFDIr1u3A==
X-Received: by 2002:a05:600c:1d12:b0:483:9cdc:8ac1 with SMTP id
 5b1f17b1804b1-483c9b9eb7amr63158905e9.11.1772229798165; 
 Fri, 27 Feb 2026 14:03:18 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb29715sm172792645e9.0.2026.02.27.14.03.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:03:16 -0800 (PST)
Message-ID: <58c170e3-93e5-4685-8f9b-4c4b01274770@linaro.org>
Date: Fri, 27 Feb 2026 23:03:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/37] target/hexagon: Add guest, system reg number
 state
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-14-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260227203627.932864-14-brian.cain@oss.qualcomm.com>
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

On 27/2/26 21:36, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.h | 7 +++++++
>   target/hexagon/cpu.c | 4 ++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 3619eaa1a52..057a5f20a67 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -97,6 +97,13 @@ typedef struct CPUArchState {
>       target_ulong stack_start;
>   
>       uint8_t slot_cancelled;
> +
> +#ifndef CONFIG_USER_ONLY
> +    /* Some system registers are per thread and some are global. */
> +    target_ulong t_sreg[NUM_SREGS];
> +
> +    target_ulong greg[NUM_GREGS];

Please do not add more target_ulong uses. Hexagon register size
is 32-bit, so use uint32_t for unsigned register type.



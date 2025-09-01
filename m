Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2E4CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 15:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut63m-0000mf-Ih; Mon, 01 Sep 2025 11:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut63k-0000lw-43
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 11:03:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut63h-0002TO-Er
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 11:03:03 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b873a2092so16546995e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756738979; x=1757343779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qf/vhKkl1l05e1/c3h3MVJAzQHcQsxoqiO0s3a8MXxQ=;
 b=mHPV8J/pDr8TVfAvfW5tIQ615zz6pnNcBp2IKsrV5i9i8btMg7pYw2s25N3WhCDuda
 DIOzwVv28GWWAloHaIebQmAFnHg4SGdinwrk9Hz9OdGbLKjBMciWiuvgm1ziW0ike6BX
 jv3+xp9FpXxHa4H/28VCdfgQJkKsWpbItHyq6aALCQD4iLlIykFoQ5p1ZToIOAC8jlAl
 zcYwdtMktFJ92jJvVuVuXDtd12wOYf8DZMk6pknc4PIkR2jSCkbgfdCvUUbPvv509X+U
 PQaCM1SjkmGiFat0p7x7MYNikP0E5Fzv4TmS9IzluyCWhGdLlGyyuoWLvU+byryo6DXK
 CZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756738980; x=1757343780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qf/vhKkl1l05e1/c3h3MVJAzQHcQsxoqiO0s3a8MXxQ=;
 b=Fvf9BsLy/Mf5mQCHK8RkV5m5lrg49bLE5lTY4M+uhsLDJUYXMpoqYx84ff2jiTkwWa
 F5kXxMcfFOtOvy8mzb1mnTH9Zr0yunUb2bofo5NwYpWZ1xaXVcOabWKJLZemcF5goNuo
 Pk2O+XvbTN4LpZSPE96eepCW6aDkWrbG3Y+4uaTiNPYHT6rlvIdZ1hdtVsUcJ4TuqaF3
 3kcqWH6MAImu8FkPXQmRuY3hnCWN2O89N2bMqtWXrEP7928Tr8nbjewnjcHbBo+TELSU
 npWdUPHt6nM28CSGEXuvUzDEukyv4iyC7q9hBHScJ+UKU/7p+C/nqTrf+L39vsET7k+6
 7l3Q==
X-Gm-Message-State: AOJu0YwEEAV3RrhL6finizSDM6BFf5e8tTc+HsbPciCVbERzvF0CzEI/
 +o9cfCUu33HNPxpPlT8+h/lZ6K76KRs7FCpic2XAcLeI7nR3NdCUbx/hz74Zxdq3e3RFkiyS9Fx
 sehi1
X-Gm-Gg: ASbGncvWj8yYbzt+JpoiaOHb6tHe9X6X15FO+dm6GzQlm/V0cA6Q7QTu7cqPXHx8hVJ
 QsMGGX7B9eR/jI6V132pBe3+UlIhFk1hp/42AmBaoloXtYOVNiw9ggA8ka1A6IyrurgIyUgPx2x
 ozW9tUmKzOdzvUOF+CHvT2BZrwFTKC9nNLFa01HlvFecLKaSPf0TAHSbiDiOFf4SNLw+AGaAsoe
 ETKQsMQ2h7SQX05D4u2wygGFFa6sJy0iPDuetZUyj+Pu6l6aNrALd4oketi4T3qApphxJ6ZKfDg
 mvLvv3HaRlRuUT28qH63GAcsfM51udjZNhKplLLC76t0mwl6IXKo2zViej8atYvGMw0KcugWepK
 Rm1+kruhZvkF0UXv8gv+Ld541ga0j/jWQpFbIVNP4YIbRjAUmrIJ6zopb2DJ/DD+/LS0SpmyhEC
 pv
X-Google-Smtp-Source: AGHT+IELCixSWh6rPhEkei2SFs3LlF00V62oNEQxL6UIYEpPFPj19iCs4JZJK/86otFRCImzcbsdbg==
X-Received: by 2002:a05:6000:2f86:b0:3cb:168b:dda7 with SMTP id
 ffacd0b85a97d-3d1de5b0dbfmr5718976f8f.22.1756738979425; 
 Mon, 01 Sep 2025 08:02:59 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d1007c0dc8sm13949809f8f.53.2025.09.01.08.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 08:02:58 -0700 (PDT)
Message-ID: <65617771-37ce-457e-aa2f-f59bf524bcca@linaro.org>
Date: Mon, 1 Sep 2025 17:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mads@ynddal.dk, agraf@csgraf.de,
 Danny Canter <danny_canter@apple.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Akihiko Odaki <akihiko.odaki@gmail.com>
References: <20250818041354.2393041-1-richard.henderson@linaro.org>
 <20250818041354.2393041-5-richard.henderson@linaro.org>
 <4312974c-9b7e-48c2-a190-071ea72da33f@linaro.org>
 <5b9e5f5a-b434-479c-8840-dbb4cda1365c@linaro.org>
 <a4a4c7a8-df35-4bd3-9de1-b22ca7bcca22@linaro.org>
 <BCCED674-EAEF-4755-9BE1-116FB36FB5C9@apple.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <BCCED674-EAEF-4755-9BE1-116FB36FB5C9@apple.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 18/8/25 20:37, Danny Canter wrote:
> Howdy,
> 
> On macOS versions/SDKs before 26 you are correct, we had an invalid enum 
> value for HV_SYS_REG_MDCR_EL2 in the API, but the hv_vcpu_get/ 
> set_sys_reg APIs work with this value even though the
> encoding is incorrect. The enum value has been remedied in 26+ (0xe089 
> as you pointed out) and has been done in a backwards compatible way 
> internally in the framework.

Thanks Danny!

Richard, should we guard the QEMU_BUILD_BUG_ON() macro with:

   #if defined(MAC_OS_VERSION_26_0) && \
       MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_26_0

?

> 
>> On Aug 18, 2025, at 8:46 AM, Philippe Mathieu-Daudé 
>> <philmd@linaro.org> wrote:
>>
>> Cc'ing Apple folks hoping they can forward or directly help :)
>>
>> On 18/8/25 15:21, Richard Henderson wrote:
>>> On 8/18/25 22:41, Philippe Mathieu-Daudé wrote:
>>>> Rebasing Mohamed's work I'm getting:
>>>>
>>>> In file included from ../../target/arm/hvf/hvf.c:413:
>>>> ../../target/arm/hvf/sysreg.c.inc:156:1: error: static assertion 
>>>> failed due to requirement '!(HV_SYS_REG_MDCR_EL2 != (((((1 << 28) | 
>>>> (19 << 16) | ((3) << 14) | ((4) << 11) | ((1) << 7) | ((1) << 3) | 
>>>> ((1) << 0)) | 13510798882111488ULL)) & 65535))': not expecting: 
>>>> HV_SYS_REG_MDCR_EL2 != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(1, 1, 3, 4, 1))
>>>>    156 | DEF_SYSREG(HV_SYS_REG_MDCR_EL2, 1, 1, 3, 4, 1)
>>>>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>      HV_SYS_REG_MDCR_EL2 = 0xe019,   <----
>>> How odd.  It should be e089, if it were encoded like all the others.
>>> I wonder if this is a manual typo that's now baked into the api, or 
>>> if it's an OS bug.
>>> r~
>>
> 



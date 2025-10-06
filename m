Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEDACCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 03:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5cHq-0000M2-Iv; Sun, 05 Oct 2025 23:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5cHo-0000Lm-GD
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 23:53:20 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5cHm-0002uT-GO
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 23:53:20 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so46620675e9.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 20:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759722796; x=1760327596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M9HFfvr1lRR7zn+Fnu8ze3WuyI+6Bb+CR7jUUpH0frg=;
 b=DeODO+370taTqwmngbgp34J1afVTthikH7dr10njHzuEp67NyRIUwaxBCw5OuPXg81
 0l+t9EG460y9zve6/vNvj7XxR9OKKV3Rvh/Siiq5J/1DOx0ZoCKY7FiROjsRKuCtxV4/
 3ewT5S9zFba1pal6zf4kc+fxw+8DQeh+QN3DU9POKuUC7ry/1z8X7yf8F0GKKZREXT58
 DoWJ2cADyybXUc7xTCNWITsaxMV3bIMgdlOy/eneNt5IgeDFuq6tbf0y4oJ++ME5zdPx
 9NX50tlPMTL72RORgse7WOqsk5CohjbkJPARmmMDjEmG68iSDatSjv+kc89sW7p7cyxH
 LSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759722796; x=1760327596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M9HFfvr1lRR7zn+Fnu8ze3WuyI+6Bb+CR7jUUpH0frg=;
 b=AImQHiUUXQzMdu4xtxdNb9x93HoF4ZzXAef5kC2TaAkH8ekmtZBfgxUtO7XI4U3to0
 blzFbE8RxPZ+86ozWT2wXG0DsIYAL11DTfhFGblxh1mPIxevGXM1G5jS/eV2RO6bpADu
 a9FnuZr2lXgaESImTlkuTjFWUuQTGwJCKbB01h3iEccqYHp3AH56z382rFCVKU3afp2y
 Lax1MY2eDwgy/3QVli8TLUOMSwkXNFNJrBiTzzS2e2H/x7HB4unoRh/FoBwemHufxv6u
 iaD8CKf900Xav+gtPoY8Iz3vB/r4zIvYB54W0q4OW7jfvOXmPABC8fnTZb2edp7Ctoaf
 pK7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsS296W6zcmT7gMtQmcOIf+qDGq7Jix6HjF8kj754rBTqmrHa6swlA0vJ07zbB+Rro6KHjkDrVEKDO@nongnu.org
X-Gm-Message-State: AOJu0YzxPZFpBDgy5aU1wbaR0iV94AyoUWm+vOGim1XMrJKkyvF/c09u
 jLzlu6ZLL5vWW11bqybyP756JL4ZWnYQ0NIRLtRSzB3ENi5r3IZa2y0W/eyqQ15dPHo=
X-Gm-Gg: ASbGnctTCWt7I4KvZJr8fzobWj5kyRURm2ImvpW8itSnwfsj3FBwCCc4ZIO+n1B09w8
 Z4DeJJuuW5DruFVSR7HsEjhAf/VxLkyeOl2n1KtcEdHTqWN33NZbEkrwmFtgXgiH6ucvugjjAlx
 BlOg6w1wyYTsol102iRB9WgVuB0UfdfG8PbAeQdUqzVhatIodtZ2tejszjPCozznlUBJ0ckDIbZ
 YTQuNZZb5gNTegxVvEaBk6Jc7YfhziNP13Xwep+V09441UhZ5Xqu8B2hzrZlF655eNh6XTIWCjr
 w56JMy2e9h2v+hWW5v7aHiT+DA1w+a8NwpvvlyQLDSPx7SFue0gi3EtfUZWeeYb2NlNitnldFVA
 F/ujuT9ybfoytGDy3WXTuwPPn4i6ZraeC9pXD2qgf6JxaxhHOAn7VREBtXemI/iohRkE/Ex+nEQ
 tj9ozvt8sZm5MnmNu4DuPB4G0Vl9J4
X-Google-Smtp-Source: AGHT+IGBeAao/ekAW+0vccEb1gV5VeeJ9LgKiE2sMCzrJgDoTScb5y/tb4zRFZz8/V1SBC42sj2zBw==
X-Received: by 2002:a05:600c:6208:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-46e711535dbmr69295045e9.27.1759722796140; 
 Sun, 05 Oct 2025 20:53:16 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7236267bsm148422305e9.16.2025.10.05.20.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Oct 2025 20:53:15 -0700 (PDT)
Message-ID: <9975a852-e5dd-420a-8288-4fbcaf77a1c7@linaro.org>
Date: Mon, 6 Oct 2025 05:53:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/41] target/i386/whpx: Replace legacy
 cpu_physical_memory_rw() call
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251004071307.37521-1-philmd@linaro.org>
 <20251004071307.37521-16-philmd@linaro.org>
 <8066242e-853e-476b-8ce0-7b303ca67aa8@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8066242e-853e-476b-8ce0-7b303ca67aa8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

On 4/10/25 19:51, Richard Henderson wrote:
> On 10/4/25 00:12, Philippe Mathieu-Daudé wrote:
>> Get the vCPU address space and convert the legacy
>> cpu_physical_memory_rw() by address_space_rw().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-Id: <20251002084203.63899-10-philmd@linaro.org>
>> ---
>>   target/i386/whpx/whpx-all.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
>> index 2a85168ed51..82ba177c4a5 100644
>> --- a/target/i386/whpx/whpx-all.c
>> +++ b/target/i386/whpx/whpx-all.c
>> @@ -788,8 +788,11 @@ static HRESULT CALLBACK whpx_emu_mmio_callback(
>>       void *ctx,
>>       WHV_EMULATOR_MEMORY_ACCESS_INFO *ma)
>>   {
>> -    cpu_physical_memory_rw(ma->GpaAddress, ma->Data, ma->AccessSize,
>> -                           ma->Direction);
>> +    CPUState *cpu = (CPUState *)ctx;
>> +    AddressSpace *as = cpu_addressspace(cs, MEMTXATTRS_UNSPECIFIED);
>> +
>> +    address_space_rw(as, ma->GpaAddress, MEMTXATTRS_UNSPECIFIED,
>> +                     ma->Data, ma->AccessSize, ma->Direction);
>>       return S_OK;
>>   }
> 
> Build fails: https://gitlab.com/qemu-project/qemu/-/jobs/11605808806
> Mismatch cs/cpu in there.

Eh I noticed a failure in the win64 job but interpreted as the usual
timeout I get with it, sorry.


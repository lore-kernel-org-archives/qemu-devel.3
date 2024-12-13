Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93154E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9q1-0002Hq-QH; Fri, 13 Dec 2024 12:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tM9px-0002Gw-F9
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:52:25 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tM9pv-0005Jp-AB
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:52:24 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-71e35be77b5so438563a34.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734112341; x=1734717141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=70v0qJMzwA29O3M4+dK8r7dFa6p+GP+1xrZaRYW8aKw=;
 b=zJbIvYDb2tYkAK2RF7h4v471FEO8rFhlRtrV68OHprVoxtSn4Rx4V1k+pymKIFyNOl
 +luSt0sUwTXC3f6ssHSx5RgqN/WoV2o0etmjUf3z+3Vb5E+VxWTNYComHGMFWilKMCaZ
 TnJ6MUNhIUsscIeewdG2jiB4FPyFIaLSrNAvsOIE8h0qYG92yRq2K8fohn/2eXPAD4Ie
 eChaEhYbiqfbJwnBNhbx1CQ7GpM8XGDqJgmiKkYZftZt6e1HXsjglCxce2BEUlZFmXAA
 92OtNT+Jy2wNeTj3kbWChf3XBVHZPvAT4P3JWpm2w3zkeM/1ClN8mEQzvkFo5YYZ3Ev3
 Hxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734112341; x=1734717141;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=70v0qJMzwA29O3M4+dK8r7dFa6p+GP+1xrZaRYW8aKw=;
 b=Yp/uTWBVY+b23PCLl1EVmxCte6HIpfGx0dGfW9b2fdHH/bl8vDLkq0ygRtL4pyaeKJ
 T+mqn4/EQCDGDczJ/kBjbvFUrRioGYsrKCsGw14BUBmj+gPMNQ1p4gPaZObtbyzfy0X9
 T+j5QMpsWyrJGvg2gFoLZJT2+1HnGP+vGr0d5P94X+YUjiJuyOWPSvLz0zHbfbzwRQHe
 mBMAcZUbcr7knHkRvDTN5pOUrfqNmQIiKFhFlcWDjHKLCr6Q0bjoogCpu68rX89e2wzz
 G7nUMboqINb2j+Oce9IpSscBnzMoh/z09CD8YKa23DZu6edsRlsqDYZvsGEkxLL1AsV2
 k8MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEd8G1cBYgNSOS4xG4N8rihbTdrUUhOqTck3qz6n6/T5o3rh3/Vg8tcplKmb4IcWmM8RfoF14Eef+G@nongnu.org
X-Gm-Message-State: AOJu0YwzBEWdtUTEAAocZ093hKLQqtQ1kiyJprxgmKfbI08vl2AGOw2F
 JH60RMpo+cSIU/nMmKyBJbDa/zfigPYrejfJhbTuGLeUy+pJWUxIqJXLp/dsqvo=
X-Gm-Gg: ASbGncuzZn/y50B2RQhY1msahWbDobPknDHb+ipuG5aUvXWivG6I8ne+imAwpoJtoC9
 78UwePEwzvW5+YMeGeA7k9Qw8qdcbnYTNeUEMdHsJdyEkAuADLxYIEECRAOjH9JfX6ZThrPVzaM
 8US9mp6XznXw0r+UpOgNB5y0KS9N1hHhs/dLJXm1YWymKmaKFLT9ZZLl+ytNgzcqR3V8q69PiEc
 U1dxNu58HDxEjcPqW2mjjbA4+tJI/YfDWZ07x9gwNKk9VJ3hs/Cql+XlvI18qyFbKwXa6F2Uw==
X-Google-Smtp-Source: AGHT+IFNkY1oN+rpuCkcXz9s1Ef5Xt7oFZrdjTFCDDaf7J6eaVeA6n9SgI2oDVfF3LW8p5IZ32O4nw==
X-Received: by 2002:a05:6830:3496:b0:71d:f068:1ff3 with SMTP id
 46e09a7af769-71e3b85711amr1969401a34.8.1734112340980; 
 Fri, 13 Dec 2024 09:52:20 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e36eecef4sm607139a34.27.2024.12.13.09.52.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 09:52:20 -0800 (PST)
Message-ID: <68a58b93-8075-46d6-8db1-b4f1282237db@linaro.org>
Date: Fri, 13 Dec 2024 11:52:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/riscv: fix the trap generation for conditional
 store
To: "Konrad, Frederic" <Frederic.Konrad@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "Michel, Luc" <Luc.Michel@amd.com>,
 "Iglesias, Francisco" <francisco.iglesias@amd.com>
References: <20241211211933.198792-1-fkonrad@amd.com>
 <20241211211933.198792-4-fkonrad@amd.com>
 <b16c4644-04df-41d1-bc6e-f14d706ab4b7@linaro.org>
 <CY8PR12MB84111EF6057B4862D7BC1DC8E6382@CY8PR12MB8411.namprd12.prod.outlook.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CY8PR12MB84111EF6057B4862D7BC1DC8E6382@CY8PR12MB8411.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

On 12/13/24 10:31, Konrad, Frederic wrote:
> +CC maintainers
> 
>> -----Original Message-----
>> From: qemu-devel-bounces+fkonrad=amd.com@nongnu.org <qemu-devel-bounces+fkonrad=amd.com@nongnu.org> On
>> Behalf Of Richard Henderson
>> Sent: 11 December 2024 22:43
>> To: qemu-devel@nongnu.org
>> Subject: Re: [PATCH 3/3] target/riscv: fix the trap generation for conditional store
>>
>> On 12/11/24 15:19, Frederic Konrad wrote:
>>> +    /*
>>> +     * A misaligned store trap should be triggered even if the store should
>>> +     * fail due to the reservation.
>>> +     */
>>> +    tcg_gen_andi_tl(tmp, src1, ~((uint64_t)0) << memop_alignment_bits(mop));
>>
>> The constant is incorrect for testing the low bits.
> 
> Hmm, I don't get it, basically with that I'm trying to do:
>    MO_8: src1 == (src1 & 0xFFFFFFFF)
>    MO_16: src1 == (src1 & 0xFFFFFFFE)
>    MO_32: src1 == (src1 & 0xFFFFFFFC)
>    etc
> 
> what am I missing?
> 
>>
>>> +    tcg_gen_brcond_tl(TCG_COND_EQ, tmp, src1, l3);

Ah, I missed the form of the equality.  I had been expecting

     tmp = src1 & 1
     brcond tmp != 0

and so mis-read the mask.

> About making the fallthrough path be the common case, If I do it I'll need to jump anyway and the
> end of this instruction ie:
> 
>      if not aligned go to misaligned label:
>      ...
>      do the normal operation
>      ...
>      go to done label
>      misaligned label
>      ...
>      trigger the exception
>      ...
>      done label
> 
> Is that what you had in mind?

There is another code block in there.  We can sort as

	if not aligned goto misaligned;
         if reservation mismatch goto mismatch

	normal operation
	goto done

	misaligned:
	raise exception

	mismatch:
	mb, set failure

	done:
	clear reservation

so that we save adding a branch on the mismatch path.


r~


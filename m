Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3F5C55822
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqwQn-0006Nz-IH; Mon, 03 Aug 2026 13:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wqwQl-0006Nf-Rk
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 13:26:27 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wqwQk-0005Sw-Ae
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 13:26:27 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8485ef63b68so3957774b3a.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 10:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785777984; x=1786382784; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WR3cPdbg8+sBxb7TO+E7ye8EiCIdgZwJ1HnxFT0EfJQ=;
 b=Mg6rdR+qXD9G1DR+YXMFnZ24a8+Oyee4QRiIrZYdzjHtZFYG1Ey2u848MFDZoEUJ2/
 MZX+UESBYXTfcoaiVV0h8i+fkqzWlb4KHqVies8wALdp4v23484MmW8OowztjMslqFHn
 ZlYBfAW2mmPEDgmoZSd130z/XFx4xrW8dzg+p3gclyfkxO8YzHZGlNypHyb3qn4rTeRY
 7XZxRoziJhzOPSf7IU4QF/KttvlNhMrd9Fo8mj2rsnMamOUVK/vDGpVnBOcjoMACstE1
 PjpR+GpDcsdx9QAwiXsWhAfaFIhBOpvEyjuD4w/i5m8Y4E4oUGoVHoD2+1g5AgK/9WBu
 YOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785777984; x=1786382784;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WR3cPdbg8+sBxb7TO+E7ye8EiCIdgZwJ1HnxFT0EfJQ=;
 b=XfFTf+1t4qDRoI7SvriusNJMlpqVf/6DF3VG330Yuq5JOvptC4KaWhdNd5QNjArK0u
 5S3ncAJqf5eLsBvtMAC1aJDs2OSsc1o7vI3vLchfMLs2iuhAjMxE7984dlfnR0HYPybb
 1NnxuRLAsjZv9CdOCZ5Qy+Qh+oC03THTQZZAbGGjKIdbSUocl/CXu1mFezPia0lFnsSM
 +LnLjGwdOjiTkk1G4E5pl6sAEKwyVkimFWEm8kF0enPMAKckIxIOtMoaZPOIvLTvKt8J
 5CShiJa73hDvLItK42kOAUIfbadXRI5l1r/9bVGVcnWfEnaj5isZRpRdxSTQ7gx1hDjE
 HMCw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKUPPaVDSiBa8mEjBRTe8doJquKBRrElOqn8KvDkoQdpBld9BSx6mXwWgOSyhcsIub7kLS906eTiti@nongnu.org
X-Gm-Message-State: AOJu0YyhjZBkiND91NI4Ofejfl8uBWxhuxXUNY+KXcbBfR8SD/Fwlw7B
 1dwgnwBt3FnOko2DiVlh/APQ/czTyygrg6zSHybOrhnTpKXPQ6Nj7g88gY9hiKt+JTg=
X-Gm-Gg: AR+sD10YNb88ft4TPINSPbHHwPQzhEv3Rs2vOli3cU/YNKN43J41qGRLvCnXeG5pRdq
 aPtPHDqJOP9M3oXgz+Ri0Sv+c2Z4ao48zXBXNly3KfouuYgSi4/vopKaWqG6jcm9T9FcbD46xYh
 GT1+O2IgTRnPXvbTxyQL1Js/Ah4fSWiCRAVSgl2IUjcDL/EG4CEyIRLZOAVW3BldoBFFJaG3phn
 KBg05XhOegcTjzaBohYZK1aKQd+FbK6G2l3wtH5zNBo7JGNwQmdx1pCSyqyUXM3oWmZCYyzgy0+
 XU9n7nXxMYM5WeMKf3KX7Cjxapfv02G/sVawKWErDBgBT6GiIbCUygwb0Obbh7qkxq8CeSuZmtx
 ryx13RRDcsVzbYdLUjNaRH9A/PKO8PbOatD0gimrabaNZRaWRjZ1e/v5cRH3GdmRSxNyWQO0Sij
 Fp6mpKUd9h+1JLD0pNDe0W6fOtTRtWdFirSBxvHvfmeM8H99gCjtrkl2ygafwVPb9BFg2h4KVW1
 PeTQUJQx6FhIb/JcPT7v6j4TUDL
X-Received: by 2002:a05:6a00:3c85:b0:848:2f6e:e538 with SMTP id
 d2e1a72fcca58-84ee49217d3mr10004831b3a.76.1785777984424; 
 Mon, 03 Aug 2026 10:26:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84edbe7da67sm4127794b3a.25.2026.08.03.10.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 10:26:24 -0700 (PDT)
Message-ID: <a2b68ee9-861f-4511-a2e8-13889d08c151@linaro.org>
Date: Mon, 3 Aug 2026 10:26:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] tcg/loongarch64: Import REVBIT insns
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 git@xen0n.name, qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260731000503.170446-1-richard.henderson@linaro.org>
 <20260731000503.170446-11-richard.henderson@linaro.org>
 <4b5db4f0-bad1-48e0-bde6-f72ae4681f39@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <4b5db4f0-bad1-48e0-bde6-f72ae4681f39@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 8/3/26 08:06, Philippe Mathieu-Daudé wrote:
>>    * This file is auto-generated by genqemutcgdefs from
>>    * https://github.com/loongson-community/loongarch-opcodes,
>> - * from commit 7f353fb69bd99ce6edfad7ad63948c4bb526f0bf.
>> + * from commit 40ea52087699392ad911387b666541891d33da31.
> 
> I couldn't find it then noticed your
> https://github.com/loongson-community/loongarch-opcodes/pull/10,
> so pending it to be merged?

Yes.

>> -static int32_t __attribute__((unused))
>> -encode_d_slot(LoongArchInsn opc, uint32_t d)
>> +static int32_t __attribute__((unused)) encode_d_slot(LoongArchInsn opc,
>> +                                                     uint32_t d)
> 
> What triggered this code churn? Could we commit before generating for
> REVBIT opcodes?

It looks like the program passes off to clang-format.  Perhaps a version change in the 
year since last regenerated?


r~


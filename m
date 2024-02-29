Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95F2C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 21:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfo5u-0005AZ-G9; Thu, 29 Feb 2024 16:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfo5s-0005AJ-LJ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 16:37:32 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfo5r-0005nv-4K
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 16:37:32 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dc09556599so13241385ad.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 13:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709242649; x=1709847449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZWJTFI90UfE25LdpQG6TSbOwe27NKeoirmtHq4Y1/UA=;
 b=OOpWfmK/ZE+jUxk6dN0l/TSD40FCvVvsce81/+IXZ7epFha+CNTFak94mxiMjIMPWv
 a2BJDVbB3AWovi/rN5Zp3w/ZTFxabRGO8ZevTfNCuhUdacmgYWRF7IrufRWHH6iUBodh
 b56pVFPPel/6QAHq727j1MQcIaPtiXwRI/a3ntvb/WSoTTSFJWefg4NdAALbNXJ2F9wQ
 CVMbfNq3DsYR5N8PZYPqxg/ddEk7GndgEPpBnc4l5cRFZeLZl/IAqcho5DLq2MW9+Cz4
 RC9qUTca9NZex6dgvBk64a133ImeIebma5LERuqsDa+hpoh96BDroEwB8PlBhhvxb5yH
 SBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709242649; x=1709847449;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZWJTFI90UfE25LdpQG6TSbOwe27NKeoirmtHq4Y1/UA=;
 b=jn2V6dz2Cy0mWuGvs/RT/BpASrpwS9Bt/3cljX2+34L5OsPrPiFzas0RdSvz4q0ZHT
 +6UCnXIrcm3E/5re4SptoxaNyk8DHUFqXVahoBtT3FpPlbwRMa6kn/GcfG0uW84cPVFS
 cJ7ywKs1PBX3Koq60xfCaloMLEOCqU6CwBz6+Uy3aER2kbYOYtDHitt2VE+dMaiZNBDf
 is77uCnyINzXgFGrVnLqWEFBp7P7e6GJ/s6L7tj5zoFuJT/0E12qcx9K5Vh/Pjs6zrNF
 kyA3rMEQCR3z1i6estt54f+JqW0R+Hw1HRo/BvZDIXcVOz34PxmNpPSoqKOKVtKp9yM7
 wArg==
X-Gm-Message-State: AOJu0YwpY3+DjyHOqd6i3zsR5AodpdlqcF5u6qVzBOKji3QU+mRploPW
 SlhByaqLU+TV2F+8uJsHsCl43fn/oNUb5hq9Vgw0LiXH+jkKYRh4VuBPwiyjJLeH6Urzy6u/5S2
 S
X-Google-Smtp-Source: AGHT+IF6ejUJSL6c0h6gcHoV0aKMbJ4gvuXTTjguNnVD6HWOT2ziI+ATbN4C4+S+3CnCQVmnmq20qA==
X-Received: by 2002:a17:902:dac6:b0:1db:fa84:9be3 with SMTP id
 q6-20020a170902dac600b001dbfa849be3mr4355598plx.8.1709242649002; 
 Thu, 29 Feb 2024 13:37:29 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 u2-20020a17090341c200b001dcb560d7f0sm1986310ple.11.2024.02.29.13.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 13:37:28 -0800 (PST)
Message-ID: <98cfbdca-96d4-4d7a-838e-f71684d4cbae@linaro.org>
Date: Thu, 29 Feb 2024 11:37:25 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/optimize: fix uninitialized variable
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240228110641.287205-1-pbonzini@redhat.com>
 <1f179ee4-cab6-49c8-a625-2ac9dbe4e3d2@linaro.org>
 <CABgObfaZPp_wAE4u70+_ShmtFpEf69RjyRyqZEQ8TjDkue_Q-g@mail.gmail.com>
 <86e5043a-ec20-4e8c-84bc-e63ecb982bff@linaro.org>
In-Reply-To: <86e5043a-ec20-4e8c-84bc-e63ecb982bff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/28/24 09:29, Richard Henderson wrote:
> On 2/28/24 02:20, Paolo Bonzini wrote:
>> On Wed, Feb 28, 2024 at 12:19 PM Philippe Mathieu-Daudé
>> <philmd@linaro.org> wrote:
>>>
>>> On 28/2/24 12:06, Paolo Bonzini wrote:
>>>> The variables uext_opc and sext_opc are used without initialization if
>>>> TCG_TARGET_extract_i{32,64}_valid returns false.  The result, depending
>>>> on the compiler, might be the generation of extract and sextract opcodes
>>>
>>> Shouldn't compilers bark?
>>
>> I expected that too...
> 
> Weird.  Anyhoo,
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued, thanks.

r~


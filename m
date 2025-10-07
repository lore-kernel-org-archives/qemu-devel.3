Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EEBCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 13:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v683e-0007GC-3b; Tue, 07 Oct 2025 09:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v683b-0007FR-PL
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:48:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v683U-0007af-GA
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:48:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ee12a63af1so4126779f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 06:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759844912; x=1760449712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k6ZG6KtDpB1f5Isb6p40/VGcJa3rDHywmdw6TLwXJEE=;
 b=JJRj3mwuJxgEEM9mBK8B2Tdy8VXajeY4SDGtIzfc5y8Z//t09AIU6tufdMgDUoAblt
 WJxNVjfkRFATH0cSBLyDjdy70bTK4f4O+t9cX0tFzjUv/Vxyd6fiJr7ZNC6kxjl9gaE6
 pLSDS3LeCwVG7IkQ5HkgX1h8pdUBcop3C25tYndg6n3fzdNc/ukIOP62WFXV5+4WtsQh
 zEiYGCUjqtEvoNchcZh1vaYqbfySGeZhIWayDQ+2ld5wa0bnvRBpC6ILc2NGf21puKhN
 Ek1yAWZNX2njABYOLmSshCzfvUDiz/4iGCN+b7UiglZMyUlVUP7b0ZvijNRLB+3I/Hud
 KUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759844912; x=1760449712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k6ZG6KtDpB1f5Isb6p40/VGcJa3rDHywmdw6TLwXJEE=;
 b=ee+lif141xgIUFjvDZRHVERvQTxZ8foRcL9WGIfdFkJkuceMf9QunQVARvHytlczdE
 FMCMN3B9vNtRxoGAp1I7Zze7Wourn9Xwv9e6RFEtqyhWED8PnvvwfpowxwBmsiW7Ypu3
 rffJ3XArqIaEmB46U6slRuZ37Fkhp+xM80KnDR3ppYd1vh0oWPvzYl4lDueci6JJkLSk
 RWKZ9mFIJwet1NVGvZNfR06Kusj9GbTb+2c/oAb4FeeOYkrUtaaO9zgFV0+P2Y2hCQMg
 7/lor5hREszAvq3dtorF8+qByiCPpCFWE3wXYcNF9MGgsxXHD3XuHqrGJSLgGZMrunAs
 OJ0Q==
X-Gm-Message-State: AOJu0YxvN22jc0W3HYG5IIi/tzXSlo4yN6al0qM7t6P/41UE9HpiAaoO
 iXmLihPVZ9lZI3BlmrmUy/O3+pcXgqscBQ8khgF4XDKsIjFHma6cTEosRPSo2uXTqC8=
X-Gm-Gg: ASbGncuOCVR9mrCSCtLHYVrQzPU4Ohx3N53mqMnC3+lVtWfbZUYGVnkrQn3vJVX3rQ6
 Lifhi963U6QnuHoIiSTFSWGqhbx2t5f6ci4HzVakcbJmPJkeaVhMvt0hzNvRFGT94rRdmf2SSYK
 gAaX91vtAUqqfBKpC/tek4lVd1j5UX4dOJiCEzdKqoDjM+7+W8aqBJmGuRjI8LCRzR1zVGrZe4z
 nDrTSqYFI92O4HoFOTwzs3TA7qIREyono3lCPMgacxbWKFJkhN7RiN2m5RlhYN0pAJovakOgQM1
 GrL+RpsAFPP4q1NfOPJ1IJoMvucpwzyPC0zgbh4K50ztn4CGZWedOykwc4EiSDJiBoei7NlVAkq
 pcFXuVx3f6iAWA7umbZetoV1M9eCisUiAmJKX5gmdqwjw/zlc6lTfXzSsS5Qhyw5ZP9/DgoTHs3
 cOR9wDtJ1pgYIrIbgsaQ==
X-Google-Smtp-Source: AGHT+IE+BWHDJYUOxUycI32bKtFoxGHlKeZV6KEvzq5EFqba3o48Z9/K80tz4ThEwbmbAtCgQYwjNg==
X-Received: by 2002:a05:6000:1acb:b0:3fd:eb15:77a with SMTP id
 ffacd0b85a97d-42567137c93mr9628290f8f.6.1759844911866; 
 Tue, 07 Oct 2025 06:48:31 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abe49sm25800014f8f.21.2025.10.07.06.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 06:48:31 -0700 (PDT)
Message-ID: <66dbc389-4c83-4552-b447-87c0e1ada48a@linaro.org>
Date: Tue, 7 Oct 2025 15:48:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/max78000_gcr: Do not ignore address_space_write()
 errors
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jackson Donaldson <jcksn@duck.com>,
 Jackson Donaldson <jackson88044@gmail.com>
References: <20251007024006.43166-1-philmd@linaro.org>
 <CAFEAcA_ytH+AwTr9LAZBP2nbSTod0FkfuexbewW=T7Pbb3nkmw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_ytH+AwTr9LAZBP2nbSTod0FkfuexbewW=T7Pbb3nkmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/10/25 10:27, Peter Maydell wrote:
> On Tue, 7 Oct 2025 at 03:40, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Convert max78000_gcr_ops[] to take MemTxAttrs and return MemTxResult,
>> allowing the write() path to return error on failure.
> 
> *Should* it return a MEMTX error on this failure, though?
> This is a question of what the hardware behaviour is,
> and there's no reference to the datasheet in this
> commit message...

Right. Thanks!

> 
> thanks
> -- PMM



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313A7D5E38D
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 14:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA8Xg-0002h5-R9; Sun, 10 Nov 2024 09:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tA8Xf-0002gZ-Cz
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 09:03:51 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tA8Xd-0001Fm-TQ
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 09:03:51 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20caccadbeeso39846215ad.2
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 06:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731247428; x=1731852228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7t8XK0j/sjGRGokMZU8V5Gp0m13efuWjV/DsVFeZVmQ=;
 b=TEy7S6OTscW3v2fQ0bA12BMOn7y7Vt+QKppF2jv8djrs0Y3FoyTy/GsLPOdVondCsd
 hw7rmBLg4NJ5NCQAr7Owru247RLuNh9GQ9dZMWyHTYJXwJrwFrn8WOz+uimnQGeuHzEo
 VOroAcCPp1SttADlwf6glupH2iDoe3dpUlhc+nD347710aj1qtw8PPZe26D2RO5Z+HRw
 NEZ0BR+QnATBmcOGBpyIefvv5nqF1Y3diQqsXGTJVuXOJTMvuxmdBktemhnxGTk6k1/a
 6QMBWkooC6b4Gmznf/+wM9hEzUq4MdCHQayva8L7a+/rtpjCtAvp7/djZHro1ywxD0IS
 voCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731247428; x=1731852228;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7t8XK0j/sjGRGokMZU8V5Gp0m13efuWjV/DsVFeZVmQ=;
 b=d0mM3DKBoOTp+YF1ac55LnmmRUmTZVakqlNc4AkF1hp6RyRif6/KhCvky8WanA513N
 cimuv+jKMvzMo7JvviGEh5uDHG9BpSi8TN0+J27qMKejcXuJEcJhs4jgV1cav9EEum1u
 rzYyAvK/sXYtCmwItIwP5MMDk90I4DuMgqt3wGaWi1EAsodPaF1SkZpEGUCXiVzlvPoU
 Lzz7tz5oYUk760UyBIVvezpVjQAYRgj6tCl5j2xuoH42sMxiRdhERcEHtJ77wIfa9K2Y
 /uRi8nX+6m8GR5inFPTA8bDqe7ms93GPXsL7yIqSONxIRGKi903W6Stp6bPXcjmadcU/
 hxxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTfIDO6wmoQIF/S1p6z1L6ftYfJMm0PSuRKVvgQ/A02SwfMelQRlSePQ80FeTc0DOnZvHUC6HpCsoj@nongnu.org
X-Gm-Message-State: AOJu0Yz1+MvGt3JCNxbC1MVLCMHKvI04Zt4+dNeQSBs83qNwfOiD1bYN
 brFDJIM2yUk2eC4XS/fBuQoI/nexKXZYCtPzHNs1qI+uYxyBOpT/5BDVYV1aCW8=
X-Google-Smtp-Source: AGHT+IGUrrce6zXrxEKQB4uK+oZyuNFFV3aq8ZMfLLsotNTatrflyx43dRq5VKRvjAhEBAxKH5TL6w==
X-Received: by 2002:a17:902:cec7:b0:20b:b7b2:b6c5 with SMTP id
 d9443c01a7336-211835cd1a9mr119107755ad.54.1731247428436; 
 Sun, 10 Nov 2024 06:03:48 -0800 (PST)
Received: from [192.168.68.110] ([189.79.22.174])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f5e1576sm6763474a12.40.2024.11.10.06.03.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 06:03:48 -0800 (PST)
Message-ID: <8c38c37f-2c86-498c-96fb-1999f546a497@ventanamicro.com>
Date: Sun, 10 Nov 2024 11:03:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [CAUTION - External Sender] Re: [PATCH] target/riscv: Add
 Tenstorrent Ascalon CPU
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241108230709.1466634-1-antonb@tenstorrent.com>
 <4e7a4a10-bea3-4f43-b091-6a30c400b8bd@linaro.org>
 <CAN7m+mCqXz1YaBZpA-TFWz_TX0HiRorzXbaadn+L3fnigWBR1g@mail.gmail.com>
 <1dc240cd-c35e-46da-959d-cf93783ee87e@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <1dc240cd-c35e-46da-959d-cf93783ee87e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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



On 11/10/24 10:54 AM, Philippe Mathieu-Daudé wrote:
> On 9/11/24 22:46, Anton Blanchard wrote:
>> Hi Philippe,
>>
>> On Sun, Nov 10, 2024 at 5:21 AM Philippe Mathieu-Daudé
>> <philmd@linaro.org> wrote:
>>> Generally speaking (I'm not objecting to this patch as is), for
>>> DEFINE_VENDOR_CPU() it would be nice to have reference to some
>>> documentation -- at least to review whether the cpu features
>>> announced make sense or not --.
>>>
>>> For this particular IP I'm not finding anything on the company
>>> website...:
>>> https://docs.tenstorrent.com/search.html?q=Ascalon
>>
>> This has some more details, including a 1 page PDF. Should I add the URL to
>> the commit message?
>>
>> https://tenstorrent.com/ip/tt-ascalon
> 
> This seems a sales presentation, not very useful technically, so better
> no IMHO.


The link has a 'Download One-Pager' button where you can download a PDF.

The PDF is a bit more technical and it mentions that the CPU is RVA23 compliant,
which give us an idea of the extensions that the CPU provides. I think this is
enough.

Alistair, what do you think?


Daniel


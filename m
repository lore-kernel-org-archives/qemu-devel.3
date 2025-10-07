Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB2ACCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 15:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v69ZN-0001kh-3f; Tue, 07 Oct 2025 11:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v69ZK-0001jk-LY
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 11:25:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v69Z8-0002ey-Ra
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 11:25:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so64367855e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 08:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759850719; x=1760455519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bNW5WBJgpaZ6TYDjKTfJuER7o1gxFNx6674cxiGpQ3w=;
 b=GELY0SUDqX+WAQAhkscsp+bxaFG2pPQ/mtn+KnPD7OOmPqroFkY3Tk+mV7ks85odl0
 IuMgiA8dCPAaHLJ3QCAqVYJ4QpZNwEIUM5NUNT2Utqx+NKazuVb8dxhFg81M4akTMI2K
 +RlSk5qrmNBxZ5sQ9hmPhFV8XGJHwfQtErNrVXfRLMmUbggq8EZ684nz63UD5DjQfVA7
 F17tgJ/xnu3VeMzpyrrizefr31bLN1GsYT3i3olwCic0+z02AqhPXP8chEZ5M5xvWly/
 MSQT6JS4UxbLE+thArlFIFlisQjkHNxA3IXD79tift0ToC9lRNi+c5hD21MEkz8K/K3B
 NJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759850719; x=1760455519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bNW5WBJgpaZ6TYDjKTfJuER7o1gxFNx6674cxiGpQ3w=;
 b=iP0pG+H5W269r9HY2NHXqsARPdSAe7HeYidMfT2X3rUqq8wf289M/jCuOVISF1gAiz
 phqkAMSX2E3xwfljrc9OXSNB6q1aAllimppQcsPHQDmTbwe0BSIsVGYT4nN2cElQLZfw
 OVGM+5G3VnfHY+QyX0Yx4YVWaLAMcOrIKrCLRrLJsRDlnkyHy70zK2NjAdGEkfVW486s
 MHD5gvrlf0xraOLIgkF1lUKBGJInkF2LP8wivl9kDFWem3rS7YihYC2clTEU0mhS2sZY
 Mk8W0Zj/8FKNRbgux4kPiFOVz4cjYHH4CNY/gIRQHJLroSobOpaLwcDDuGNjSFe8+FGC
 jm9w==
X-Gm-Message-State: AOJu0YyfIehJKYyQCjL2Rxg0UvDYFHr08foQQiJi/jZTWJlvY2zqu+eD
 bF/n6Z/UiT/pIPQW/ghEao+S40Ooj9U6hQwZmNDnqppijqAdsApHRR6+UlP1EVKHYJY=
X-Gm-Gg: ASbGncufWf8xmAMo2VPAi2FVufdv6MqHxAwUwVpXTWEKcewgDX7Lsoe/7qy3y9X/uq0
 P0KIy3nKH5qPBF2Y++7wiPHAjLXbIG2NzrcVoq/wLVGpXAsES+H4W6alWl+/2jDAgvRQpLbvOkK
 7AkN+PAeBJluPdyAZP+qOsidaj0gc0pODlm4ToU3tYnxYHKqos5cqNAt7D6sgwyK3zIijsQ8JTH
 0eeYLaoCSsO/h3/lnBob17VP80WKKr9SD6jCwSEQNkXolFqyUOMmz5nTbI7RyQZ2xwHVlRpwOfX
 KeuC9UyK7rbdCAzzhzSZDy22Z2OE6RhS0jrfXhWCrC9PinvBR1/JxDNcN/lAlbJGml/nM4R31+U
 cLIJITL3wpq4Q5fIS/3+2Z97DHe7DTJuG3Ui4zV5b0IoqNZkcDoFHux6ixnlUc7UlkNP+foddkw
 YJM4XgjcoduhRyZa+O2g==
X-Google-Smtp-Source: AGHT+IGTxNRwCtJGzUjgblJHUXZ4hnQOLmMf086tzY1s8Rorqw3yn/7IRrZPFpPanwEKo/IcgoFofA==
X-Received: by 2002:a05:600c:64c4:b0:46d:45e:3514 with SMTP id
 5b1f17b1804b1-46e7114310amr134690375e9.17.1759850719015; 
 Tue, 07 Oct 2025 08:25:19 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6c3esm26173764f8f.1.2025.10.07.08.25.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 08:25:18 -0700 (PDT)
Message-ID: <5bba6470-0f06-4e52-8d19-f45ef6758388@linaro.org>
Date: Tue, 7 Oct 2025 17:25:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/max78000_gcr: Do not ignore address_space_write()
 errors
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jackson Donaldson <jcksn@duck.com>,
 Jackson Donaldson <jackson88044@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <20251007024006.43166-1-philmd@linaro.org>
 <CAFEAcA_ytH+AwTr9LAZBP2nbSTod0FkfuexbewW=T7Pbb3nkmw@mail.gmail.com>
 <66dbc389-4c83-4552-b447-87c0e1ada48a@linaro.org>
 <a7e21714-e19f-4465-96f1-dc27bd484cdf@linaro.org>
 <CAFEAcA_TWXGCSE4y6wgQJosDBGGvWF6wGr=8Br3ivdQx+MxOig@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_TWXGCSE4y6wgQJosDBGGvWF6wGr=8Br3ivdQx+MxOig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 7/10/25 16:55, Peter Maydell wrote:
> On Tue, 7 Oct 2025 at 15:47, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 7/10/25 15:48, Philippe Mathieu-Daudé wrote:
>>> On 7/10/25 10:27, Peter Maydell wrote:
>>>> On Tue, 7 Oct 2025 at 03:40, Philippe Mathieu-Daudé
>>>> <philmd@linaro.org> wrote:
>>>>>
>>>>> Convert max78000_gcr_ops[] to take MemTxAttrs and return MemTxResult,
>>>>> allowing the write() path to return error on failure.
>>>>
>>>> *Should* it return a MEMTX error on this failure, though?
>>>> This is a question of what the hardware behaviour is,
>>>> and there's no reference to the datasheet in this
>>>> commit message...
>>>
>>> Right. Thanks!
>>
>> Looking at "MAX78000 User Guide (UG7456; Rev 1; 3/2024)",
>> chapter "4.7.2 RAM Zeroization" and table "4-67: Memory
>> Zeroize Control Register", IIUC failure can not happen.
>>
>> Would that change be OK?
>>
>> -      address_space_write(&s->sram_as, SYSRAM0_START,
>> -                          MEMTXATTRS_UNSPECIFIED, zero, 0x8000);
>> +      /* RAM Zeroization can not fail */
>> +      (void)address_space_write(&s->sram_as, SYSRAM0_START,
>> +                                MEMTXATTRS_UNSPECIFIED, zero, 0x8000);
> 
> We don't generally use the void cast like that. Just
> don't do anything with the return value.

That would allow to use the helpful __attribute__((warn_unused_result)).



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA5EC71130
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP29k-0008D4-Ct; Tue, 10 Jun 2025 12:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uP0T3-0006UX-F2
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:00:49 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uP0T1-0000p5-J1
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:00:49 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a54836cb7fso1583328f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749567645; x=1750172445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=etkACMaH6okwnINcTnrxnSS/kK+PzIFfBrEYmbMGJdw=;
 b=Af0ikxGPDPqE9AZayJbdNuVB/W7ygDlAw6GvfkAlpAkd0eHdrOepH9+GtIcDezqv7z
 QEL+q1SryysNREpvc9vsTAy+2BdMnv9KqDh0y8WuTATYL6ptDmhqBztPZro04jO7qO7C
 83puBaCgm4pHB3LCyg9RVFtBjFPJlJLSOgTsLUzDwBXVydbMZLFT4myOi6U0XebQh8td
 g0RAtoP7ofwLvnjflcTpzbO1QJibdZeozPB8fZU38ZoG9A+5sT9gE0F76REI2UGbcJZv
 J6AVnqrWOVd4547kpw5KPetfKGXOqrpm1pn/nB/9NBl70DPSsJOOaosTlby2vamJ9VEP
 5lCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749567645; x=1750172445;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=etkACMaH6okwnINcTnrxnSS/kK+PzIFfBrEYmbMGJdw=;
 b=SyR7FO3Lw1tQM6dID0TPbiHcmMTkD1IMROjuq0ya6A6YtSxq8y2JmxJsolcUdkuKUF
 7r109F6okIsy5DtZpQf52DBNKmeOE/k9IBsI/lMyjaDYDAtyU5+BI7gx19K9+nlKxK8U
 A1OWOJKpaY32OiqTFrpDlrISxGJT87QR9YtgpJgdgHseGtT5qTSV74r1Xk6MhWlIzi0x
 g4MCdi3KX/LZu19EzcmoRRN6mqN4VZY3hcE4FCpWeef0ykmq+fnKuut6zfCsbj81cSL7
 4toorpEEwDjKydsMXMdWWxE1MCJkqZK5IXBA1xMYvqzh4H55i2Wlb3V06VWDQ10neJOh
 J6KA==
X-Gm-Message-State: AOJu0YxTYfKD+AP213v2+DY0OgaYhR/q+auOyOtXvSWutfo4IL2FsW5N
 jT0mwhlBVVJZcS3Q42qZTIxIw2aGgKnWzLWH1ELGtcJFs7NtZdvodwNvWi6jC+/HdWo=
X-Gm-Gg: ASbGncvw9nydI3VGt7wBX8V+l3pUlYmJoPYCvdwNqDpXgj7fO21f8Oq/VHn0HdjGz+M
 pvSzcB5qpUiqhd+MJifOOWp/dzbtfUyvkGzP56Cx2117qQUa48VSTfck5QeMYNQgR2n0F/N21Yl
 Ju6n7HHuwYjOQH0LYjte2SzNlzpZhmCwaDdx22Iflp2289h2OX7NtJTF2NMfMJ18AWNcIIMHA+7
 4fzc6J4kxWIQusUfibagn1Rg5dA5/wHR2jnanp4jblWFV638n5/XZbGPuZu5mZaDMVOU6yvYmMb
 8lPrlT1W2MR28zzf4EIgsodKovHFwEo3hj+e1/dCdm+UHYKG7y4h8mgfLV7Lrm19fqoPNDmqs27
 nFiL+DJ9EvoSSdLPBx1az3xx1NbNoamhRaFT9j6rS
X-Google-Smtp-Source: AGHT+IEH6pMoIfv5xpLrMPTt3Sgm1EM3PuT8uCmTvSReuZtz6usq25kRVq7GMQU8Jw3q7SSnSm0KmA==
X-Received: by 2002:a5d:5f8f:0:b0:3a3:7bad:29cb with SMTP id
 ffacd0b85a97d-3a531cba7afmr13643772f8f.52.1749567644965; 
 Tue, 10 Jun 2025 08:00:44 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730b9b33sm140470095e9.26.2025.06.10.08.00.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 08:00:44 -0700 (PDT)
Message-ID: <4d03fe23-86a1-4030-b5fc-8de8be461770@linaro.org>
Date: Tue, 10 Jun 2025 17:00:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/31] Skip automatic zero-init of large arrays / structs
 in I/O paths
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20250610123709.835102-1-berrange@redhat.com>
 <50405e77-e665-4772-9715-3901730d00fd@linaro.org>
 <aEgri00LXfeRQRJ2@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aEgri00LXfeRQRJ2@redhat.com>
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

On 10/6/25 14:56, Daniel P. Berrangé wrote:
> On Tue, Jun 10, 2025 at 02:49:02PM +0200, Philippe Mathieu-Daudé wrote:
>> On 10/6/25 14:36, Daniel P. Berrangé wrote:
>>> This series is an extension of Stefan's proposal:
>>>
>>>     https://lists.nongnu.org/archive/html/qemu-devel/2025-06/msg00736.html
>>>
>>> It used '-Wframe-larger-than=4096' to identify all code locations
>>> with more than 4k on the stack. Any locations in the I/O paths
>>> were chosen to avoid automatic zero-init, to eliminate the performance
>>> overhead of the automatic initialization.
>>
>> Should we eventually add it to our default CFLAGS?
> 
> You mean as a way to impose a hard limit on stack frame size ?

Yes, we could use -Wframe-larger-than=50000 for this release, then
aim to reduce by 5/10k every release until some reasonable limit...

> FWIW, the VNC server is biggest at 100kb, but we have a large
> number of other big frames - here's a sorted list of frame
> sizes vs frequency
> 
>        1 103696
>        2 69664
>       46 49184
>        4 42608
>       23 32880
>       23 32864



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B99CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwcn-0003nf-59; Fri, 29 May 2026 08:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSwcj-0003nG-OR
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:47:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSwci-0005Xo-6B
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:47:37 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-49050ff7cbdso64780925e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780058854; x=1780663654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UWgHi5bNyPqeMGaDJN+5A8NHRbB6GxpYJrrlcTQqehA=;
 b=irYbPqcSt7wGoo8+iZt5uqXoq8FoYroqpPvJM23VumdG12/ow8IQcdZ5PM4gMu0sb4
 CPp0qzkOFHTxB21q67VZovpduC17ZSVWsSdAXMt9z+2SolIEJWlrsc+Ybw3ye3A1H9HP
 hBtXQvhqT3YOCeKsCGxmJqZiI5whoLUeeE/3x5NYVGtgmJwG9X9VQOJYkoQToAQ4xQOE
 bJwTExQFguUm0bJnzcYcIkoLe5tDnhKFN+NSLmwqQSpcuKP+WR6yC77Dj/n8FjbjfaPT
 PyTfpElP7tnqCv67yfPS0dgzSgddR1VmBr71mpMQliw4Jlt5eDP8Dol1kIYU/bj7vW0u
 HtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780058854; x=1780663654;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UWgHi5bNyPqeMGaDJN+5A8NHRbB6GxpYJrrlcTQqehA=;
 b=KU+kylsLTo1OMlD8GIFY8+WXjqnuu20qHF4cytt/2yYm9+QM8sgzmTr+GJJCGfnxWQ
 BBOGNm6Pq2ZPiCl/bDQF88nz/RagV3K2POKHA8lks9iSyak2/mtaICmxbwg2jxsKlvuO
 uOQkmMAiGMcR16kBEwP9Nf1xnChHaZYJgrselWkBultfZq7jhVyNVQ0aQttei5FldYv+
 l3lFktbLrDItr2rZOS8U6ZmxMfknOCJGFcqbqSex0Zmk3rXRIvXmMVWgJex0arZpydXq
 WIIlmWvaHX0gvRAWn0PkpIS5ipain+PY/T6lccm9mT6VjWHh1mq/InDFXKFTsDW3muC9
 5bwg==
X-Gm-Message-State: AOJu0YwTdSRrLXviCJvfb0Zhex5nprSOjmktKOlJuAcrlZ+zhbTZDhUv
 pucENPUoJtohvrmns7C3th+sJ6cICeaLH4OGSryl7ipj8rZqC6PkUReSLVgMU63VVMU=
X-Gm-Gg: Acq92OEKlXq+duR1vII39SpQAyKx+SxtXywx2Cux3L1ZdN4Nub1zGWh41Z9L46qF/aW
 +Rvub72IXOX9otJgnUc0aJJaxG2Vtwm6YONFfM0lqg4unYXp5RGQ/LuGEciBIcoAgGfgsnUIKd7
 ViHbdviS117tKqXvyDwfT7z7wyWebZC6YND7KEeIcTOcxMYLoJmbT76RYkuMHIEJHUK+KoSwLrZ
 zFsGXgAXtfTQu9C4kQbAjUlDktdhTpWyNhL90QgkgnLq9zJxVfBmQLM8jDBit0IWbOySJ3v9h23
 HigFpWeA0LZyXjAqOCRwPK2UJfxSPz2ypd2Sfn81ihypbpnWGBGHVl0ynTVjkfDxtxJZdbyRwP0
 bl00hUycqkD4AjDvfOes3HCuvUBoKp+i6Yeox44kddPg8n4DGisW8JFJWcZiH1SjF4AdsgZdBdv
 cJhJ/6Z8VfCCxjZPkn9NpKJmvrbgFtyAtxOymNimA7KGUF4U0Xna86mpCMx+BD8cWquByxMmOmo
 YsVkIVe7G8Tp3w=
X-Received: by 2002:a05:600d:848c:10b0:490:48e2:5618 with SMTP id
 5b1f17b1804b1-4909c0affedmr38369855e9.22.1780058854167; 
 Fri, 29 May 2026 05:47:34 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6f35f8sm33252805e9.13.2026.05.29.05.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 05:47:33 -0700 (PDT)
Message-ID: <dfef365a-4ff6-4276-ad5c-1b1abda84822@linaro.org>
Date: Fri, 29 May 2026 14:47:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] MAINTAINERS: Merge PCIe DOE section within SPDM
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260417110550.70068-1-philmd@linaro.org>
 <20260417110550.70068-4-philmd@linaro.org>
 <20260529130319.1e9b2144@jic23-huawei>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260529130319.1e9b2144@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 29/5/26 14:03, Jonathan Cameron wrote:
> On Fri, 17 Apr 2026 13:05:45 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> SPDM depends on PCIe DOE, so it makes sense to cover
>> these files there. Cover the spdm.rst document. Add
>> Tao Tang who volunteered to be designated reviewer:
>> https://lore.kernel.org/qemu-devel/44abaece-6a6f-43c6-b29a-53d6eb08033c@phytium.com.cn/
> 
> Other things depend on PCIe DOE - for instance the table
> access stuff in CXL (that basically retrieves ACPI like tables from
> devices) and they have no connection to the security use cases.
> So from a logical structure point of view I'm not sure this makes
> sense.
> 
> Mind you I'm fine with be being Alistair and Tao's problem!

We could split this entry again in the future. At least SPDM
is not orphan anymore :)

> 
> Jonathan
> 
> 
> 
>>
>> Cc: Tao Tang <tangtao1634@phytium.com.cn>
>> Cc: Gustavo Romero <gustavo.romero@linaro.org>
>> Cc: Alistair Francis <alistair.francis@wdc.com>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   MAINTAINERS | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)



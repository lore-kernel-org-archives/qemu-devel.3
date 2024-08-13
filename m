Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22893C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 08:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdmtM-0005tT-HH; Tue, 13 Aug 2024 04:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdmtK-0005sU-V6
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:28:30 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdmtJ-0005jW-B4
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:28:30 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52efdf02d13so8639444e87.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 01:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723537707; x=1724142507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C2dcd/MnpZ8v72aLdJKBRsWw+8Ha1UH03gZIJXyjOrE=;
 b=geHdFlrC/FK5pFkFs/OKOH5VjJTG55XBbYAypecQTPZHFjVAn7kjYDXlctmCGu6xgY
 CBms+WDlLGOsoz83qy/N/Rclt4W6Gh5Owo91QixDLtJrrJBI6ta0B/RmE9h3TcfSfB0Y
 zU5jpXqyz2QkM+5g8vEjEsxNYWU8cW6FPJDtAfXSI89GcM2IQDVmqAQOso96egpFzed8
 FF+jkZMsF5xu4rdxcyPvCbec4OJmoFxdcCC5mnYpZHG0A3PkgCzOEAhUGO/GJXZpPPJT
 ShkpuVk/pyfMlEN+lfR28VNBCKCe7Cs9sNfNy1FtSa42hqA5R9MNonZjGo/Uod6FoMJU
 FKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723537707; x=1724142507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C2dcd/MnpZ8v72aLdJKBRsWw+8Ha1UH03gZIJXyjOrE=;
 b=gLYCORw3WoI5f5AJHdvrqgehM80pgXtwAqtwjN3OdPKSe96BfZdW/g6uyRB1N+6dLD
 wbUMV0HZgjLCctfkeh+WxqLkEu91g7JZfNczMWRXE0rv6eNg8IA3lJg1BZTdL6j8HqVy
 BSrlKaswmwmlqQcMRMx1HL4AStaNZGgKWQjgA5Jyfg5cblhSHHtyNpEQDUwRaQs2lN+0
 RpRdJuHNf7pkozPQE+FRlDPDF7Khca4wKbJ6MHhCIzpw95gi7gYNvyNz1mjDnG+ZO/bq
 NWXyKI8VeX0z6SxJAOLsU0OEJVwKVPHodJPT41In1D6BLvQ5lpKlL5SVyf4f96u5LjaR
 gdcw==
X-Gm-Message-State: AOJu0Yw+JwuVYiA6Zm8dCgH7FSabdnSLx957NMdZkSEvKz1C66OJ69h1
 go3CY5lpzpl0XMwp/d70r9GR2AK43L7iV0iJKGDLnIozORSrjLJYZ6JvpEWc8zY=
X-Google-Smtp-Source: AGHT+IF/l4mdJJu2qUMw2X287dHk4ueEfrtIEPOlvh/7mXBDEJ2k2XFEd1/fDllwwXRsIbvpBVMsYQ==
X-Received: by 2002:a05:6512:3c8b:b0:530:d334:e0f1 with SMTP id
 2adb3069b0e04-53213681798mr2406447e87.41.1723537707022; 
 Tue, 13 Aug 2024 01:28:27 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.129.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f4183aa5sm49026966b.211.2024.08.13.01.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 01:28:26 -0700 (PDT)
Message-ID: <b7f837dd-a58a-4912-9400-514fd5cdac4d@linaro.org>
Date: Tue, 13 Aug 2024 10:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/23] hw: add register access utility functions
To: Octavian Purdila <tavip@google.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com,
 pbonzini@redhat.com, alex.bennee@linaro.org, thuth@redhat.com,
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-6-tavip@google.com>
 <CAFEAcA8w47gZYV8GBQa3fNf1cBWNtm_k4DAdnOVt4RWBdSrghg@mail.gmail.com>
 <CAGWr4cSwJPMngzA7DAHRHu7eJkWGhzxuAMB2fbGRnNAx-7AR7g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAGWr4cSwJPMngzA7DAHRHu7eJkWGhzxuAMB2fbGRnNAx-7AR7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

On 12/8/24 23:14, Octavian Purdila wrote:
> On Mon, Aug 12, 2024 at 8:33 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Mon, 5 Aug 2024 at 21:17, Octavian Purdila <tavip@google.com> wrote:
>>>
>>> Add register access utility functions for device models, like checking
>>> aligned access and reading and writing to a register backstore.
>>
>>
>>> Signed-off-by: Octavian Purdila <tavip@google.com>
>>> ---
>>>   include/hw/regs.h | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 89 insertions(+)
>>>   create mode 100644 include/hw/regs.h


>>> +/*
>>> + * reg32_read
>>> + * @base: base address
>>> + * @addr: register offset in bytes
>>> + *
>>> + * Returns: 32bit value from register backstore
>>> + */
>>> +static inline uint32_t reg32_read(void *base, uint32_t addr)
>>> +{
>>> +    return *(uint32_t *)(base + addr);
>>> +}
>>
>> Pointer type handling looks suspicious here -- if
>> the thing we're accessing is really a uint32_t* then
>> we should take that; if it isn't then casting it to
>> one and dereferencing might be reading unaligned memory.
>>
> 
> It is used for performing generic accesses to generated structs (patch
> 3/23) which should be aligned in the way that are used in the patch
> set. If we decide to keep it, I'll add a note regarding alignment.

Could we use ldl_he_p() instead?



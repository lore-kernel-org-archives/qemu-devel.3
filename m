Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E390C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAjd-0000j7-Fj; Wed, 12 Aug 2026 11:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuAjb-0000gr-AK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:19:15 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuAjZ-0007oL-Ep
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:19:15 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84a652535dcso835819b3a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786547952; x=1787152752; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S3BpsElPE3ybFLvEH9dH2lOhj/5kYOv9gvb7uP+6PnE=;
 b=CiSWr4jgXUoTmtnXpgNfndd+/dkiEyEwEAWMpKLcPOpiQyebisTFRTOhPwMjCyxghW
 LX4fiTPaHCZtmYbRY6HaJ1H0oWryAV1fXwoNJBtDc3aZfA5yGiYswGMQ2ON6xhGPeBUk
 ZX/pix0Pw6Izd5GaGP8bi2V4zfRuHQxm9MqIt9KhG1bT8gTGyoBFPzhfGH1d04HX2qiv
 SihiOkRDUhlAlukk95NiiMDU824ThrKRGDDF1yaSjltofMizGchWcZw2rrHg62MGQo8t
 3TFuP2vHyBkhXL5atd0ukYtaguLlVHAU6oYNz4KCxVNQ9cMnmuVw/+8nUJeDxkjAX+si
 3V+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786547952; x=1787152752;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S3BpsElPE3ybFLvEH9dH2lOhj/5kYOv9gvb7uP+6PnE=;
 b=punECQ+j5LuEG0WqtL9hvl2eEVrGtIWK7vJyPxh2NRxvc46WypuBOACDE9qZMbi7Vp
 xUx9r2bCdg/2zZ//AAkihSkjlsL8Zt66XAzuVw1dAgf2F4cQ/IW/IdBXIAU3GhHFBdtI
 iE5Wv6UQu8fSHZy4jXsCJhrWm60gB/5ucCTfIbAwl9Ml/b3TqBH1riX49YR6xLhbEE7X
 ogGMv8RzzEyo6875+iHoM6K1c3sWnhCw1c5FRxfAhKyl2lWyXyEB6RGldFcr+K9HN/Os
 Q0QnBPEFPn205o6Q8raNJTcHhaLHNZhS/lC9lM7KeMNLJD3VreJi8Os7GcAZ2UXQMo06
 2pqQ==
X-Gm-Message-State: AOJu0YwPQ98z85DmpXnRYcCqihUjc59fvGHz97BMBROf1JjrTgMKo0CP
 Qh4TMAeHVuL7Bp2qxa9fwW6mgY1+iYiZw8lOJLXuYjzxiwzoA6yRWYRlomSKeBJwG5qpWSI/qhW
 JGg0n
X-Gm-Gg: AR+sD11FU3aS3RVOcm2XGTFoS7AwtABoIeeTCc33e69PaOoWoXEiWX642pVUv+of8Px
 bZ9xeHaFctSQuGL+TDLBel9KTMstvwbQRHREOlgT5fLxJxvXoLKJ67y6g1HYYGEIcvf5X/WPzGB
 yrmsaIPWC+dCDpOxbBnibzBWWiRqPhS/jye1EXsF/w3FiukvehSsqmedSAMszSdmKcaZHGG/oyr
 Ogo5ISgbOPUX1snrq1d2U2ctNoRaauhXp1mfJK5zW+D/xW7Y89xBFmNqzidnCqVmwJeYVJKXyYc
 o4947gEpPyK2UKXpbc9GQPPBEU//lZXBwfj/bM1UKWDZrrccd6e6e+Np4rev7K5s+5jzjbqJtPP
 f9Vx6jxDlFglT4TlwZphgQVGnQUWgYNxQLpxbVLd/VALVP5W5HXjPU9tQm0k0BkymqirkOc+2hy
 HeZRrVR/bg2UTZpSpQn7C8TII93/UeE1qpCSYk50ivTTRMLdE4UVzByimGqqmXQufC7ii5+i31O
 vTU8T7B21lm5w3VzMXkCdOEOEag
X-Received: by 2002:a05:6a00:288e:b0:847:9aa8:d3bb with SMTP id
 d2e1a72fcca58-84fb540aa72mr6531826b3a.12.1786547951482; 
 Wed, 12 Aug 2026 08:19:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fb1f715f1sm1162437b3a.60.2026.08.12.08.19.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 08:19:11 -0700 (PDT)
Message-ID: <90facdbb-3936-41ec-af2a-b9396a353f58@linaro.org>
Date: Wed, 12 Aug 2026 08:19:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/elf_ops: defend against weird elf headers
To: qemu-devel@nongnu.org
References: <20260812081405.3811787-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260812081405.3811787-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/12/26 01:14, Alex Bennée wrote:
> According to the ELF spec:
> 
>    PT_LOAD
> 
>    The array element specifies a loadable segment, described by
>    p_filesz and p_memsz. The bytes from the file are mapped to the
>    beginning of the memory segment. If the segment's memory
>    size (p_memsz) is larger than the file size (p_filesz), the
>    ``extra'' bytes are defined to hold the value 0 and to follow the
>    segment's initialized area. The file size may not be larger than the
>    memory size. Loadable segment entries in the program header table
>    appear in ascending order, sorted on the p_vaddr member.
> 
> which implies while both p_filesz and p_memsz can be zero we should
> never see a case where p_filesz is greater than the in memory size.
> Indeed it has been reported such a hand crafted ELF can blow up, for
> example during rom_reset():
> 
>    address_space_set(rom->as, rom->addr + rom->datasize, 0,
>                      rom->romsize - rom->datasize,
>                      MEMTXATTRS_UNSPECIFIED);
> 
> which could trigger and underflow leaving QEMU slowly filling a very
> large buffer.
> 
> Fixes:https://gitlab.com/qemu-project/qemu/-/work_items/4056
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Cc:qemu-stable@nongnu.org
> 
> ---
> v2
>    - ret = ELF_LOAD_TOO_BIG
>    - tweak subject
> ---
>   include/hw/elf_ops.h.inc | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


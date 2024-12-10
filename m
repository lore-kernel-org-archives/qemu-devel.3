Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1485E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL1tI-000222-1G; Tue, 10 Dec 2024 10:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tL1tD-00021c-Rf
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:11:08 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tL1t6-000727-Kl
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:11:05 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434f3d934fcso16934855e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733843459; x=1734448259; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jnw5Z196BQbznVmDrUNOIgt+8+x2CvSsDYfyNS2KGW0=;
 b=Uxcbln1y0cE3UjHkFjwZxvh/J86kn6hsvKM4MBmfGq9SHtJerQ12O5GZ7wcKXuWWD4
 tmEk+JNp4M3UpDFugzrtyEgm4vG3y7Fpj8D9z6KA3m6ZzlYyM7MY4UyQWy/si7ys5CWd
 3CcLHYzGsPCjFjsSO1z3MprlBBlZCw4wBJquDx7NiHyeTrkZ8TvGaQQzO4cWebC0f65i
 NGMXxD1F94RUvPI6X2JBxUMlHm6DB3pYIMe2g7Ocr0VzlkY5teEae7XDWC53j6IIVbtO
 RkEleOml841tUwmWyITcb2AMdWjGiWE6s5TDUkYwchDsn7dxenfMHUEUXjTwFNrInkiA
 XHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733843459; x=1734448259;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jnw5Z196BQbznVmDrUNOIgt+8+x2CvSsDYfyNS2KGW0=;
 b=g/rDzTn+r+QJKdOkv9dbWHD3RvGfi9vMjWcuVp4obSjqL8umtfFQxgH1SHZ7vLa4uv
 fpDUoV26rCznNgMUt9n/bh5DvJhGJBbyA0+v/C41bf0FtfgYL3AMsNnoFtWMOd1UyDNM
 HxCHZfyp5khhh3CSqscYQ0b2TOXAvt+mX7Aw59uUyyxi++tch2or9ZWD0ByTKb9hj3Mb
 XU28OAISGncFGwx++Wz5LK34wtdFbPFZwlAsla/9LGqEZ6qYtf2FZNJKiWumPcFcezhT
 GoNnTYHULgm9fXktrdgr7dQf6c5RGSWCCyyeHFZM6LwFLMlf8GWaQ8cYZ5wstWNdeCqP
 pFWw==
X-Gm-Message-State: AOJu0YxdMi/Pb70+rNpXe4+MS5Bmz1YYWM5clEiPJqEeoEeu45yNSSpr
 60jyVdrGJZi9rt6nNzjs6DzWGX5b2AgC5V4a6rKrUxc09lOND5CNvx/FBaLQBkXCUCELRO2G82p
 Yk6s=
X-Gm-Gg: ASbGncvtisyxmO+AhONBx1I6d4l/6d4isVxHaoq7BhxFeO12dS0Fdi9lJGk+jmwIbQW
 gNbrMW8f9EMFwWRcHpECl5QUxF8fB+ElBiRK6JvSbzrutao2BHtmDX3XlgRcAdO2FYjxMtzBhHo
 O+7ZarlxMWf1bfXeUxP4y8Ztkr+WSshPaHkjJlBcSo5rQsi08zQXuFC/4uoQA+Q7Ai6F/J7j5H8
 sLr686SfPpJV3M3srKhU7STie2/An/gVCVAA6breLJon5YCUqWpMHyE9fe/bDX4CzPJW8JiDCQu
 2Tl54eVPBvIQMJ9kamspBczt
X-Google-Smtp-Source: AGHT+IGKvZ3EdWyc+98n1uvBcxqy3HszofDa64Aaal+lneb3crViPBjW0VgRtiM0YsLXPoBoHnUxIQ==
X-Received: by 2002:a05:600c:1e04:b0:434:ea21:e14f with SMTP id
 5b1f17b1804b1-434fff70131mr46665525e9.13.1733843458628; 
 Tue, 10 Dec 2024 07:10:58 -0800 (PST)
Received: from [192.168.224.213] (223.132.22.93.rev.sfr.net. [93.22.132.223])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f3d89b75sm93945475e9.15.2024.12.10.07.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 07:10:58 -0800 (PST)
Message-ID: <0e9b0ee2-4928-4cb4-b7d5-a78c9a2f3096@linaro.org>
Date: Tue, 10 Dec 2024 16:10:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] bulk: Remove legacy cpu_physical_memory_rw() API
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241210140112.43313-1-philmd@linaro.org>
 <CAFEAcA_ZpeLop95ELDHn696cN-6OL3pC95Dwea934RLH3SpSAw@mail.gmail.com>
 <CAFEAcA8qNrsViuQrCeCeh=2s-2GF2yXOc9d1qFxAcc+Knw0PDQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8qNrsViuQrCeCeh=2s-2GF2yXOc9d1qFxAcc+Knw0PDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 10/12/24 16:03, Peter Maydell wrote:
> On Tue, 10 Dec 2024 at 15:00, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Tue, 10 Dec 2024 at 14:01, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>
>>> cpu_physical_memory_rw() API is documented as legacy
>>> since 2017 (commit b7ecba0f6f6). Replace it by a more
>>> recent API. Noticed while discussing with Peter:
>>> https://lore.kernel.org/qemu-devel/e979b3ba-e701-4ac6-962a-19e4598ba947@linaro.org
>>
>> I'm not sure we want to do this as a bulk automated
>> transformation, because in each case there is likely
>> a better thing we can do with the call than to use
>> address_space_memory. For example most of the uses in
>> devices probably want to have the device have an
>> AddressSpace property that the board wires up.
> 
> Also, examining each use gives us an opportunity to
> consider the error handling (cpu_physical_memory_*()
> drop errors silently) and whether there's an appropriate
> MemTxAttrs we want to use.

Yes I noticed that and agree, but do we really want to improve
these devices? They have been using the legacy API for 7 years
without caring much.

I can repost split in 50 patches, hoping a dozen get merged
directly. But then I expect discussions requiring too much
unimportant work to happen, and the series being abandoned,
giving this legacy API 10 more years...

I'm being a bit negative so I'll post a v2, and then we can
open GitLab issues for devices needing to be improved.

Regards,

Phil.


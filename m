Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E20E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLn1S-0005QT-9y; Thu, 12 Dec 2024 12:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLn1I-0005Pl-Qo
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:30:44 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLn1C-000196-8A
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:30:36 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2a383315d96so402033fac.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 09:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734024628; x=1734629428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AGHk13l6Jwt15hcQLQWbSgDYmtOf1knRtZSVlDilOXc=;
 b=JutgubSQAB0pccDVr1yxYh2LsBhWt4wz/e70+9es4r02cHD7umndjLt8U9rhsBiAph
 CTSOalY2qwq8UIq6Nwx7Cd1zi5iaV4qImnejYJkwZyp89ZLIUVZeqqgPn1OtIJxWnhTV
 yEnyCsxMdQo+apd6HQBwNKh4zS6AA6hC0O12VO3H9OxA4kjeuvszQSyq82u+aFBvL33X
 7RIqV/uu3y+HHKvU1Z0xFw+dxpHYjUhEQ7wtLB0rMJhd1RStDoKFQ3LUTUahI7zzxwqQ
 WRuVq+xgCRmLtpF7c8HUVgKIdMdl7HB9hbbBuNTa50VTF3VBE4S7jKSZ2dY8QQfiVP4v
 xT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734024628; x=1734629428;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AGHk13l6Jwt15hcQLQWbSgDYmtOf1knRtZSVlDilOXc=;
 b=EOHGZy6EM6sf6piQGQ1evFpArCaGBliQkxaH48Cu1VY8GtbV2GFo6FFlN6z2cYqZc+
 xek1+Z4nbGQY54VsTk1H0rqbaPAzAZHl8Xdi53J9OZUkUA/5TFEzcg3mBSIDv/ikeT5n
 1HdZJ28A+VHgyrh/khfCG47yBdk9WgbxNVvOZ8rCVXuOM4Kfi3qgro8RzysgKzJZ+gCD
 dWX0bChDYIrYqbu8JPkbS+XRAkWXswdvuf87WQwg2eyDQA3eAwjmxqD36C5GFHnA9Eyq
 f0+04ebTF6ttZqqgFPu+FWTuNhPUXLPTBHWMkDdjCW86Jbs7sU2gj+ENfDvLT+Kt7Rob
 McAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgpBerPOjp6BZSw5Ua0XoxJL0ejl2CQ0eZlwreKtn0lOYEInwIWnhDYBbquAC530WBlfvcMOseKacR@nongnu.org
X-Gm-Message-State: AOJu0YzgGE26pc97lLR+rFtmSqbdSiI9DEn6bR5t4OtOTKpHDoQk5ayZ
 bpoTT3J2RTUA3LADaV92Ul/SJ5f0Qa6BJpVcrEypfm4XIJ///qc/txjD+vJotm0=
X-Gm-Gg: ASbGncsWIGAC3X1wkBlACUto45S228HUgyt6egOgQhLwlxOUTWNf4rETOlId9+tdH7g
 cDsOCwa4D0wJPnBOAUlt06ILJaCy+IzvlAayfJDyf5TCp9t49foqFxwIEPga1FDxkLk2zJnN8D4
 ekV/L0mgdI4VCrcCfyGWZVu1TT5O9jwztYUTzAyXKAkrptCxd95aNEBu4mj3W5IQf9iCknfgyaY
 fMpBV1L3he0GE0KGvGLmxdNE4+lLEpdWqyvNvq7Cgrs9ZOD1QJ9cZz/jWeiqQhYI1Pzu0S2qQ==
X-Google-Smtp-Source: AGHT+IEOXO5Xt1HaRmJt9NKvhhg+JuKLVfFCLLUzEAv94bNY/ppyxEtNU+z18kDGuubIbLH1QGmXOg==
X-Received: by 2002:a05:6870:5254:b0:284:ff51:58ad with SMTP id
 586e51a60fabf-2a012dba01dmr4930958fac.27.1734024626593; 
 Thu, 12 Dec 2024 09:30:26 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f567c4a77sm4482621fac.32.2024.12.12.09.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 09:30:26 -0800 (PST)
Message-ID: <9e598fb1-bba6-41d7-a13a-ec4d18112921@linaro.org>
Date: Thu, 12 Dec 2024 11:30:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/display: refine upper limit for offset value in
 assert check
To: gerben@altlinux.org, fred.konrad@greensocs.com, qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org, David Meliksetyan <d.meliksetyan@fobos-nt.ru>
References: <20241212160158.527246-1-gerben@altlinux.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212160158.527246-1-gerben@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

On 12/12/24 10:01, gerben@altlinux.org wrote:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> Accessing an element of the s->core_registers array,
> which has a size of 236 (0x3AC), may lead to a buffer overflow
> if the 'offset' index exceeds the valid range, potentially
> reaching values up to 5139 (0x504C >> 2). Therefore, the bounds
> check has been extended to DP_CORE_REG_ARRAY_SIZE (0x3B0 >> 2).
> This change addresses a potential vulnerability by ensuring
> the offset stays within the valid range before writing data.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Reported-by: David Meliksetyan <d.meliksetyan@fobos-nt.ru>
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>   hw/display/xlnx_dp.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 6ab2335499..3f1f5d81bd 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -896,7 +896,11 @@ static void xlnx_dp_write(void *opaque, hwaddr offset, uint64_t value,
>           xlnx_dp_update_irq(s);
>           break;
>       default:
> -        assert(offset <= (0x504C >> 2));
> +        /*
> +         * Check to ensure the offset is within the bounds of
> +         * the core_registers[] array.
> +        */
> +        assert(offset < DP_CORE_REG_ARRAY_SIZE);

More accurately,

   The memory region is registered to match the size of
   the core_registers array. The guest cannot issue an
   out-of-bounds write.

And that's why this can be an assertion instead of needing
to issue an error to the guest.


r~


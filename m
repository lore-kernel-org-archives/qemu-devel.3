Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39C6D148B9
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdkhp-0003YP-TM; Thu, 08 Jan 2026 02:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdkhh-0003TF-R7
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:45:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdkhf-0005ls-Nu
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767858306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Arc9OqZYV1kmolfDGOLeJdt2I7NpTxtyycIcRG4+aJ0=;
 b=O9lvC7Rs6CTmRBhX0RKXOYBtPwHIiudFFuUG6GezcoDFGO8UVJdBb46zBQRGuFV7pQzoOm
 cLtARxmmcvZdwx9UciYXzgJgs/iPKr+akI3rRVFNjdDJ7VkIxM7Mf3/SycYM3dKXkOHCKh
 udrxgXvzo92+aqOjFjBRHG9mGo2HaAw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-SCqq8EyqNougvkDFY7kmbA-1; Thu, 08 Jan 2026 02:45:03 -0500
X-MC-Unique: SCqq8EyqNougvkDFY7kmbA-1
X-Mimecast-MFC-AGG-ID: SCqq8EyqNougvkDFY7kmbA_1767858302
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso29405725e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 23:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767858302; x=1768463102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Arc9OqZYV1kmolfDGOLeJdt2I7NpTxtyycIcRG4+aJ0=;
 b=FtII0Rx77wsWnwYMdOGmPHYk4paENEcwiWA7QaARty/AuZBodOBaUk2XM/eciw6ulY
 mmthUDWO2BMBkH0rwyYki4Ml8rPo3ye0Wz6rRKyanH4zVpJTyXIM702jPTG5JmzRXhg/
 5FRfNh3wQwA+8PVxgDHhBKEwjgng9N66M06gqWtWrqrQqhWsvf1CcyPB8kvu+IsG9nq/
 GO/x9hhLSXdwwoVvsK3Q+0Tda5W8oXBXIX7yFhqwfMFFXTXX0KCIsTFJA0cW8F3E5Ycy
 8gFIRLPkQrBvpnn7pNmbFpg9XPCSo7nXKwu38l+r2Tpn0kcrGpxb6lm/98wh7GeS2Awb
 fgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767858302; x=1768463102;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Arc9OqZYV1kmolfDGOLeJdt2I7NpTxtyycIcRG4+aJ0=;
 b=WwhGtGS7UrS3gu4y7Kmdm9F1xxUyCjgQ3xXWhddwbqU/Z2dzWdnRosGJuH7Cbc4BB9
 76yeZZXUZ9P1nJjREueILJXMYPYP5Uk6r+o1dzU6OjRWCbs6pgC2ScG96L4mTpwBFcbG
 vIbgnae8iq8Ot786LzVSXoRBocB3jxBTz2DXcnxSW6QJkZtI5wLyFq9kNOBb5y5hE+JZ
 wqnDy3wgLHjlwmoMRNOoZk790/A8QvIvOVJQXWXB+Uci1pT++CundzI2xN8mNKg0Je6i
 vFl0gGLjeBV8IHZHBlOG3xA8azlvHvPpwBJMmYhaNQpCqzsYwsMYIVLPyXZPl8c42Y8I
 vwOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeOaqz29sxK0VSUNT/xMzJnaHKYsdf5Vr7fm1YYyTdFh940zMpYX5BaGh87aAMRLfkDNEf44CIGiwa@nongnu.org
X-Gm-Message-State: AOJu0YxNm8b1qsCjam4adq6piVmo6JsGC4j/ZQf7tmh4zrLlCxlpPiYH
 OHyqaEpC5lgIh+SGOgMH6+ob6eHT1YFZ0wZF9W7pMFGD7wRk1EayNQqdXz6iIWBLCdap4xnmARk
 m8Kylqpm8gNsXlrDvvPJqdJFx9zAjdjdASUrZm47DHsFGNenTAqhZB0WG
X-Gm-Gg: AY/fxX7xs5QvKdGsH2gNxJ1cVvULnt/QxTzxKl/fcJXDrAkv3p3D36XQWDY0cowOi2E
 Vx2dR5quA2kV0rUF1WrKndLtmCDynp9D8y0CMecSxpyZti2XlignZeu/UdxVoG1y0+o2Xsaue/6
 xudAGSozNVBUL2lL/3cHiNW5oqDdYNIq8nXyyogKwenDLUI4RxacLT/1UCh6xCqELYscnFTLjpc
 o8DUecfcb7KahIQKbRw/YvtulLRKNfXCWqdkgJXMFFWa52bUw6JKKjM8hgANoGHeNUI7VFNQpPR
 bdnbqpSvq0/6MyiIpd0c6q6R0kMBb1XyZ4ZYq/CXSi88DVlC/d8sH0A5884YEjH8JKrBxarxp4N
 6qHygsck=
X-Received: by 2002:a05:600c:3e8e:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-47d84b18596mr60434675e9.10.1767858301981; 
 Wed, 07 Jan 2026 23:45:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElAVRC0wuzQpOhyeuCSDAm5MHtoC6I/vvFnX92wDTyPHDHlhH9+wz6HnwhH8FmGywv0CElHg==
X-Received: by 2002:a05:600c:3e8e:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-47d84b18596mr60434455e9.10.1767858301543; 
 Wed, 07 Jan 2026 23:45:01 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee5e3sm14798301f8f.35.2026.01.07.23.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 23:45:01 -0800 (PST)
Message-ID: <376b1e90-c31d-44bf-b0bd-1c6382cd743d@redhat.com>
Date: Thu, 8 Jan 2026 08:44:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] target/s390x: Replace target_ulong -> vaddr in
 get_phys_addr_debug()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-11-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260107130807.69870-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 07/01/2026 14.07, Philippe Mathieu-Daudé wrote:
> cpu_get_phys_page_debug() takes a vaddr argument.
> Rename the @vaddr argument to avoid confusing the compiler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/helper.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 59e1fd0c4fe..f124b16d1b3 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -68,14 +68,14 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
>       return raddr;
>   }
>   
> -hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr vaddr)
> +hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)

I'd maybe rather go with "v_addr" or "virt_addr" to avoid confusion with 
physical addresses here.

  Thomas



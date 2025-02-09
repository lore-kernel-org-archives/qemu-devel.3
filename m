Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57877C021A1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 22:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thFf3-0005Av-Fh; Sun, 09 Feb 2025 17:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thFf1-0005AM-3K
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 17:20:19 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thFez-0002jb-Iy
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 17:20:18 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so24564785e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 14:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739139615; x=1739744415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XULnDBemY60SI5BH52KV7cjdbp+0A+rZk9J+Im2sq5A=;
 b=iir3NXfocbDHp9oZ/ZBuBU01uzy1EVG4y2AgV8rt/WeBZ/ocjUx+zWNeB+k2gZHxUG
 GET46fuoHkcwH9WnWKupdkrGSGBpAKa6V+/BkMQ+zRBD8kTVqPx6vzR07/l7t0q63dIA
 +lPjR0BQX4lULiJJj4f6PFtUfEom3F7cG1i8KcwJapMuvwhOUrm0k3nYSk5AKasRlgUh
 C6EflN0WCkPD6C6Sn5Mtv/L4Jn6YfCiKbPI2Q2bQ/fmLtvzTXy+UMmgILDQxHuwJYz9A
 qpeoTV77uYlIM9utuAXvf2W2fAgHNaV6krZtkWDGPm47/3FtrEhitzrNuoRF+NWLjRyB
 QORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739139615; x=1739744415;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XULnDBemY60SI5BH52KV7cjdbp+0A+rZk9J+Im2sq5A=;
 b=CJtMwOitR2PUtqD98hbaRsu9mM/WhpDys0qBRthSOlyZWbBFC8JDAHbYZzPX3uWtfP
 RWuu6LyohdbIqkxvl3MxJWTFS1pP1d1+TJ1PHhGciIl7rGkQZbeW157haPmJQBI9AnWm
 9eI4JtboQBjrJP4f2l5yvT1bW5ejCFwo13UMrZ/CHZYU4dnTi2m0TlT13BJVUgv50eQR
 vVUshZTgTgQYdOah++3AmlreTgRl2PYwEUrraVQyyO+poRP1+t2AgN6wVdHh+zN06ayW
 rV/pM9s9cXxBmCkp6N7ufk01HDcpzmBqqTv1dG3KztUwtLJF8WF+syHA46yCRsZk877v
 1SsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkATPFQK373mYavS4gvMasbZxhph/3lvEVFfkIbDzs6Zz2hL6zU/ythlLa3GpDRScn8RnYLn5bJRoU@nongnu.org
X-Gm-Message-State: AOJu0YydLnAhUQ8VDEQ2m14PHyMxFlMPwPJw4pw4V9/yySNPOXTtyCOz
 o8XRVKWGonzfpQt1AYOAyic1iyGK0s2xKnDx07Cq9N3SrYF5ROZq4RsUn9L3v6k=
X-Gm-Gg: ASbGncs0SNrzY8aEDh9Gaga9yMYbBWmJDiWt+JiluP06rel1vjStVa8wazjCXJd+5cg
 OxdNI++YKTl10EUqePVXMpghO9p1ljMVin04Bc8eXeAgvOEubxKxRYXoTkjFxcgPOMzD+XtKpqI
 rTeoPKFoz6LnpSD7JxX5Z5EdxJLpZeUi6DzDPTBNgeCKGBjdhmw7LHpeYfBmsH4FZEmyNkucuI2
 MyliWFAwzXNe7VoH5VllNE31m3pNVU7xlcKk3ZYnPQRJP8zWmgk78/ZScFus4xZGvGGDYfmMW9S
 WgI8q82w/tjhqFcdLGQjm0TOSvbiLcunYsWQ+H4ro9jOA7Q+F7+cV5EfhwRLYoC8
X-Google-Smtp-Source: AGHT+IGaK16XPn9EPpXs9/486PPjpVUyq974W1ipnouCTv5UoT4XJDXr6GURwbQru2bQhAdLP8FO6w==
X-Received: by 2002:a5d:4286:0:b0:38b:da6a:8a02 with SMTP id
 ffacd0b85a97d-38dc94914bemr6291661f8f.47.1739139615416; 
 Sun, 09 Feb 2025 14:20:15 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d802sm166274085e9.12.2025.02.09.14.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2025 14:20:14 -0800 (PST)
Message-ID: <74ed0984-061b-4523-b479-e85d3c008e7c@linaro.org>
Date: Sun, 9 Feb 2025 23:20:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/22] target/riscv: introduce RISCVCPUDef
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
 <20250206182711.2420505-3-pbonzini@redhat.com>
 <f4ec871d-e759-44bc-a10b-872322330a3f@linaro.org>
 <d375a630-d136-4e0e-9103-fd4dcb1e03d7@linaro.org>
 <60d03735-35ae-4f96-8914-0049216eaa13@linaro.org>
Content-Language: en-US
In-Reply-To: <60d03735-35ae-4f96-8914-0049216eaa13@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 9/2/25 19:53, Philippe Mathieu-Daudé wrote:
> On 9/2/25 19:44, Philippe Mathieu-Daudé wrote:
>> On 6/2/25 22:16, Richard Henderson wrote:
>>
>>> It would be nice if this were const, i.e.
>>>
>>>    .class_data = (void *) &(const RISCVCPUDef){
>>>        ...
>>>    },
>>>
>>> This will in fact create an anonymous object in .rodata.
>>>
>>> We have other uses that do the extra casting away const,
>>> e.g. armsse_variants in hw/arm/armsse.c.  Although I suspect
>>> *all* usage of .class_init can and should be with const data.
>>
>> The only non-const use I noticed is Xtensa:

Also the object_class_foreach() callbacks update 'data':

static void object_class_get_list_tramp(ObjectClass *klass, void *opaque)
{
     GSList **list = opaque;

     *list = g_slist_prepend(*list, klass);
}

GSList *object_class_get_list(const char *implements_type,
                               bool include_abstract)
{
     GSList *list = NULL;

     object_class_foreach(object_class_get_list_tramp,
                          implements_type, include_abstract, &list);
     return list;
}



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973C7C54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 23:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHsiH-00058b-Fo; Wed, 21 May 2025 19:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHsiD-00058J-AN
 for qemu-devel@nongnu.org; Wed, 21 May 2025 19:19:01 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHsiB-0005vb-2L
 for qemu-devel@nongnu.org; Wed, 21 May 2025 19:19:00 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3081fe5987eso6131184a91.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 16:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747869537; x=1748474337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=han5mAq9peLkkq96lZ2kfDJ/b8dVTXZnv+Q9rCe1zqg=;
 b=JM6OyEJ6boRcUAjJKCo1ME1RQ4dGIdB7kSJ4jAYlCJCN4z3zR2tUMWOqK2C6MdapuQ
 JkUeelk7Jd5lwODcCqIv4KxKQI6uWheXIRsXoSKNSMjI0P0Y7KlQL9uFMetTsPP9Jmid
 2cmQucY/HIrFnB6gs7M9SQY55QQZi+Aj90QnJBckn/2lH9VAMqGJI+AvjYtynWRRFI2h
 bJZdswVDSQIKVUn95ZL79lc78keDZ1WNKDzqvVZavbl7vwwtV2kil3GyFFqLyIJsmhdb
 0/39LfxBdv/gHPzTbAwRmEGty4Ny7xvjQ2DNO4nQodR6Ue8ZA/EovAi1ngkGd70aUsZr
 oYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747869537; x=1748474337;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=han5mAq9peLkkq96lZ2kfDJ/b8dVTXZnv+Q9rCe1zqg=;
 b=BV0uG4v+RZ27l8xaXyeprOJHiKOOeHO20qcyGgU8XI24ZUma8vfLI/HuyUgKDPPlU2
 oSkKV3BvViuRFMyDQyUUa3/+RmK4WDHn2DLXj31Ai6niDJkeI1IR/r8ry5m8RkIkJQT+
 ae4pICKq3zWLYKtM5VIqnnfDoGiLxI8rWKmghDCz0eun/wQrB1owm5V6QoSO+fQ/0pqQ
 lovzWJc+8MXNZyRHHs9WRQqhV39b8JVNfr3vi+AqWPLYox4k4GgwcOgTwRNGsL57jm+g
 n/iZO+4ykN1h2Q4PhopLBhAxysZ8CcmZu0IuYJeYaUz8pz2zFE9oqJNmByKDvueiBui/
 UnIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYCBRvpoY+qVLsjz4tXTJ3k8W/U2ez1bSIn4n3FnNNiybITWNDeC9s0G3ppFLmJDVvlyD6kYwZTb4X@nongnu.org
X-Gm-Message-State: AOJu0YwxiU+yiKoZ5INV3MBVYqbACWlUT5rp35pNT5snL06L6MWAEtZ9
 vzEBYJYXD6tWAZEnXVrIu8bf12yKNXI8XdKdE6qHjyELJby1xznuUS6T/ceNx4sMvn8=
X-Gm-Gg: ASbGncvSMuvc5/Mq0uar2p74ArFzu90Vtch6lzKA/eYIod99HJ8rAcE85hp782+6KTs
 brNUd+9xbfvtjpLyYO5Xc5afjNryPsdnzrQM3x2E1iYnoq9VBaouNvYIdYHNodLqWPh481GUo+a
 EbGBO1AMMz15Z2oY3FdUlnwMF0KZqmKixpAIYe2rc/u67ZPXgGIZz1opYnaP6Jfxv5N6RS5djTE
 FJhiGoi2WL6frJ+iAFnnnwXgpwoFs50S7+MqK/reoAMOICg9y/eaeKXW5fMgH71m+TqnBMQOMj6
 iQhSejIMleoOx9vddQg8urQrSMUK3+nFAQc2qR/vpmPDDkiBrV0sVAmsXnza/QKo
X-Google-Smtp-Source: AGHT+IH+0RI0wKCkbeiYaZ/FLmNKF7O3lvKIW2AlT1XtsgCiTrXRz1dYg2UmObV4qUV0QRnPAqUPAA==
X-Received: by 2002:a17:90b:35ca:b0:2ee:f440:53ed with SMTP id
 98e67ed59e1d1-30e83228de0mr28651399a91.31.1747869536822; 
 Wed, 21 May 2025 16:18:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36368e44sm4247530a91.1.2025.05.21.16.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 16:18:56 -0700 (PDT)
Message-ID: <348a6c09-3c8d-471f-af6c-e8201760614e@linaro.org>
Date: Wed, 21 May 2025 16:18:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] Add memory hardware address read/write API
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-6-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250521094333.4075796-6-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 5/21/25 2:43 AM, Rowan Hart wrote:
> From: novafacing <rowanbhart@gmail.com>
> 
> Signed-off-by: novafacing <rowanbhart@gmail.com>
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   include/qemu/qemu-plugin.h |  96 +++++++++++++++++++++++++++++++++++
>   plugins/api.c              | 100 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 196 insertions(+)

Reading this patch, and patch 3 (Add address space API), I am not sure 
AddressSpace is something we want to leak in plugins interface.
It is a concept *very* internal to QEMU, and not reflecting directly 
something concerning the emulated architecture (it is related, but not 
officially described for it).

The same way qemu_plugin_write_memory_vaddr is only valid in the current 
page table setup, we could assume the same for current address space, 
and return an error if memory is not mapped with current AS.
Eventually, we could read/write a given hwaddr in all existing address 
spaces (starting with current mapped one), if it makes sense to do this, 
which I'm not sure about.

What are your thoughts on this?

qemu_plugin_translate_vaddr is fine for me.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FF8CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 05:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZM1h-00021h-55; Tue, 16 Jun 2026 01:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZM1Y-00021D-Pd
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZM1W-0005iL-78
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781586459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMf+7nOvXxJ1YOS6cY2m1xAw88ArXEKf8kJ0h9MZvYY=;
 b=LMY0ENNwgiriFhYxaCfgOn8BYLscWRX71iuQQixjabVksn4PE20r8ggS2SJyPTegq245d8
 oioey+k3phIQ/RS3XWY2X9JDOlSJwn5GWsV811v2pNtL/rv2qhudcQTdryckO9w/za2sS7
 GE+r6KVLRRt+2MgxyFj/efV/wSeJqbw=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-Et--Tmv-Pwq_qNqhAbGBjA-1; Tue, 16 Jun 2026 01:07:37 -0400
X-MC-Unique: Et--Tmv-Pwq_qNqhAbGBjA-1
X-Mimecast-MFC-AGG-ID: Et--Tmv-Pwq_qNqhAbGBjA_1781586456
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-307625ee07fso14530509eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 22:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781586456; x=1782191256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zMf+7nOvXxJ1YOS6cY2m1xAw88ArXEKf8kJ0h9MZvYY=;
 b=rAv5F0VEiG+C2R+/gFD674XRTPbWAqtwjgbgrVxjOXYocoFZFNFIMJ5xh0zCi05ZEe
 OqeazShjzwlqBv3mqJDD0mfxYBnz0Qhb7kvaEbrd21o6i2v8gfloFze0Crbiljj0MfHm
 iZ0874tmaAY/xtkAxVBTdfB78avpz+KI4+L9e+wcnOTthqYjafMnyc2UgetgAv1lzYnh
 jdet0jF3cLU3GUZkXA9hq0yMb5sq7m4CGq8vkKT++kXz5lgx47tguGjlSJByH9aqqjXx
 i0egVnzp/EF8DUPCQe/rEyoCiERkuAStxxvq40b0ykyjRGLSNA+kf7VxdE9RURnUnPvN
 Jk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781586456; x=1782191256;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zMf+7nOvXxJ1YOS6cY2m1xAw88ArXEKf8kJ0h9MZvYY=;
 b=SUh0tHIyJ43NjdwqIMXp0QnskqiBm2C+vkHovNoIoRBJJax8xRHY92Ls53jCin55AJ
 Z1ZipjtKIVuyUAjl0EPaHJza4zJotRJAw1baNmoASW44/eeVdVhzGjnq38hzMLeF5TMF
 92pcwgkQ+fQuhgjCjy4uAYtCygVYfuDQpJZNOv8EMUaAGGNffp+lCcSYtRBEh4TLCz04
 8Mui4gQeAa3m4LjTQQWhgZfPCyGOkSBNXy2xUUQDC4usb9i+wd/Av/MSb3z7vV6jidov
 yTyLRTYX4eannZlHm65JaIX/lRBOYhfnEx41HV6xuX1MYTmGqZty1j0qW5xFjTmBad0Z
 D6Sw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/w6jhmtGQqPXclNKLgbHo6fNihzGiSeccBt9sFbkIQLP+pTKy1SYLZoTZCGuBWuop5Ihn63VMuv8DC@nongnu.org
X-Gm-Message-State: AOJu0YwofIUECxpC8EDBWCt7ZeZMJwB03WST0PQeuehkUWl5Ha78GQ98
 jkqb60WUDOWDvW0zYwME6oEYE3/++0TTzwMAD/pfLOt6ayOu77Skfn+r4olhWBGfIKGVoQSvMVM
 ayTbwkWLhnvRnBnhec7hnG/2dthLyQObF9S4E19i4+XCLYStgGcgS7Q/p
X-Gm-Gg: Acq92OGXEkPRpfKcre97Z+tvIqyWfze2pR2m1e7JwTJSzJiggtH2TYOD8YdArHYqaAK
 45rt1wq++2ze1phmW16FN/538xdeMAkplGNBNgdbwEZMxgA4mK6cZHp8ZLc+qNjZ+xDofEKT4AO
 iXyOm9P+v6gVA+euuKs2qGwV2gZ7EcxtfJ8pCi6ZtVSTyMoVbCbKNQ6Su8pg/0mte0mj5ynRTja
 xOK7X3CKe1YDgIhCU4bx27iXSHwuA8T5ue9rE/BgO8hnA/3Yg8DoI5xwCJAc28jkhaav0i7YuXQ
 Z+Kcxh/RsGghHrteVdZrU9Y80yQ8sLTwOd9zgONxr08eYRVtx9se4xbhVCazZpIuZRVy81Q19NW
 b6M0EPARExGcSP/v6M3NDhB0eTl63K4ogUaERwlIHIKB7p/itQnrjVvfhc/XVo7l0
X-Received: by 2002:a05:7300:e78a:b0:307:3a6c:ecf4 with SMTP id
 5a478bee46e88-3081ff9598amr10151675eec.9.1781586456324; 
 Mon, 15 Jun 2026 22:07:36 -0700 (PDT)
X-Received: by 2002:a05:7300:e78a:b0:307:3a6c:ecf4 with SMTP id
 5a478bee46e88-3081ff9598amr10151652eec.9.1781586455802; 
 Mon, 15 Jun 2026 22:07:35 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e91fb97sm18446590eec.14.2026.06.15.22.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 22:07:35 -0700 (PDT)
Message-ID: <081a9e18-6504-4a13-a3c6-47e94be63f7c@redhat.com>
Date: Tue, 16 Jun 2026 15:07:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <CAFEAcA9CT6E8dhEV7Ek6ruT_o2dKUf==2V+U-1WFDOLtYbgeeQ@mail.gmail.com>
 <20260615105556-mutt-send-email-mst@kernel.org>
 <CAFEAcA9Gi43qNZoZcGtq8ioffGwOc_XuhoFAjGx7-bt4U8qfxw@mail.gmail.com>
 <e399ceb9-bc4a-4ba6-8efd-ed2742d0853b@redhat.com>
 <20260615154054-mutt-send-email-mst@kernel.org>
 <22d55870-b521-4002-add7-791bce8ea96a@redhat.com>
 <20260615224658-mutt-send-email-mst@kernel.org>
 <0038f601-7647-4547-a67a-c6a17fae26ca@linaro.org>
 <20260616005429-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260616005429-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/16/26 2:59 PM, Michael S. Tsirkin wrote:
> On Mon, Jun 15, 2026 at 09:48:00PM -0700, Richard Henderson wrote:
>> On 6/15/26 21:23, Michael S. Tsirkin wrote:
>>> B. Also on x86, I do not see why we should not use memcpy for large
>>> accesses if we can. Better perf.
>>
>> We have an example where memcpy writes to the same location 3 times.
>> This is not appropriate for any host.
>>
>>
>> r~
> 
> Ah, checked libc and sure enough, it does it. E.g. it uses 2 overlapping SSE
> stores to do a 17 byte write. Not sure how we get 3 but whatevs.
> 
> 
> But just to clarify, I am talking about DMA accesses, that are not
> initiated by the VCPU.  I am not so sure we care about multiple stores
> in this instance? Do we? We do care about speed, for sure.
> 

In current implementation, qemu_ram_copy/move are differentiated on x86
and other architectures. Do we need to unify the implementations (qemu_ram_copy/move)
on all architectures to avoid using memcpy() and memmove()?

Maybe it's time for me to post (v3) for a new round of discussions.

Thanks,
Gavin




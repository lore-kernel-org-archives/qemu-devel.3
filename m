Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD45C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whih2-0007NQ-Ox; Thu, 09 Jul 2026 02:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1whih0-0007Ix-Ro
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 02:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1whigy-0005vC-3m
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 02:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783580221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=d6gs/XHoX4ZDqwwPH6tbgexahTbPCxNiIrl3M0bs+Ls=;
 b=bNdNmxVTCzd0vFKPMQvVqXt2b0+ZbGkWpFdgRW9c/NS1+6r/bM8D/vLAgA3/HFSRuwPLwt
 iz9vZA9bbE+ArcqBZIwQJBD3UuDugbD3BCgmEslGikrnRkzXPu70++FD57S2vwn5ZhhCpI
 HaivESAubsYd7ZLspf8+muTTTrwB3UQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-yI-z97viPgG4F4Y9EsKUQA-1; Thu, 09 Jul 2026 02:56:58 -0400
X-MC-Unique: yI-z97viPgG4F4Y9EsKUQA-1
X-Mimecast-MFC-AGG-ID: yI-z97viPgG4F4Y9EsKUQA_1783580218
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493c55d5ce5so9067755e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 23:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783580217; x=1784185017; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d6gs/XHoX4ZDqwwPH6tbgexahTbPCxNiIrl3M0bs+Ls=;
 b=kfk6GjtFAMijFDACXvOf9y7MjPrgZ6Qqak8apy2c1rf/B3iRkW9+Qq+wPR8bmBys1h
 NMoQ1WWN5Tz5DFAeT+8/IjEMWgZcKAb4hkbPI+HnBhv+DNBcU4W2xEL/dA6DxMx24EVb
 OeXaKAypvSr2Asmhn1tYYAoJInlwa0VTYskeeQuYzDf+7q0FvAri+AVMuJkvcvHHPzU3
 P14qrfjsq+JonXVNokNfZPcnsH9DQXubQgTFOEAWueO3oZZhDnAyFD4mdYyGUOT5m2jw
 788JWzANm7o1PiUmbVzjkpiIzqqNchiBGeZMt7JfuK3Lr1X8y0+1l/8jFwSOw1JVzDcd
 sClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783580217; x=1784185017;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d6gs/XHoX4ZDqwwPH6tbgexahTbPCxNiIrl3M0bs+Ls=;
 b=RqDEknuaUkGTQ3xgygq2da7NPVd+HwPhvxfizAjJ5KerpsI+WQZpPxIZJfX3dDML6Z
 KK12uxC1vdMRo5ZteMwAGzMiXX35Gb6GNgG11RFquwXns3lN/+4l9yt65gyJe/M3QEMb
 SY4iDUJ23F0psgkg1VmMll5iOY7a1w+LQRmDPwL2KthRX7Onc2Tfyidj1oRL41Q7KFxW
 292a6vT5xFG1vOW2JFMBN+w8e5LfirAGr/WHgCPzifnodyrhOIWSxWAqJ5brdaco94pd
 9RFMsZcKfcTBr3V65OgSEd0C8D/eOaJ9kO1HiGBKQ37Eci6bD7kZ65cYXQ+mAwVL0XQG
 Yf6Q==
X-Gm-Message-State: AOJu0YwAVbJTGlY3o1krQQ5FISVnX3hGde95v5XxFc8msozIR/n0UEe6
 48E6sHVvtnfODNdTKJ0fVccgdSNZ/S5//3Bq4l2A1EnHi59nCp2VH8e5asYFxefzqqxnj/dC0c/
 gqag16gVJhaw8JRlMDXVKYD7FgmcuGKQGXvnGFGU55tXoAoJYIzfJCq1c
X-Gm-Gg: AfdE7claDeVs6VSfc4tT73d7CHlv1fQ/8D2KcI6GkfmUU25fkS9ww+U4UUG7Qyh5nUp
 c5wrv1sb3DnxN7A6E7TNHpOBk+3r1mYl+TGYQhbpQEZhXYAiBy4S1g1JAj/XAfmvnPFHgFSc2n8
 mIWHlA97Cp9+qgYeuatQLCRC2ywksfzHW5100lvzbB8YcJOL39KBXxCY2wuWwecgVA56mN3Xm61
 tubHK+yj8WS1ThHhhqmF9Y5PAg+kRo0NuMgKxDrJhA/MHW/bTmLhNMXfCgKsC0ixR4XvPY8XOY4
 Mfb1bIumseqNWLqrmw3MzLSxjyyc/zinkWcx4LvaZslc4VAA7Ft0GvKFYPVXh6VmnX6VJIc882M
 xRyYPL2JaXzSH1BXYPzSfRDJp/yTRdWsVKwZcoJcxXu7GLO4wrQ==
X-Received: by 2002:a05:600c:4753:b0:493:b307:6777 with SMTP id
 5b1f17b1804b1-493e6892718mr53025845e9.22.1783580217637; 
 Wed, 08 Jul 2026 23:56:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4753:b0:493:b307:6777 with SMTP id
 5b1f17b1804b1-493e6892718mr53025685e9.22.1783580217215; 
 Wed, 08 Jul 2026 23:56:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f2e56sm42907875e9.13.2026.07.08.23.56.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 23:56:56 -0700 (PDT)
Message-ID: <b41c008c-dd9a-4401-b422-f7b041f34117@redhat.com>
Date: Thu, 9 Jul 2026 08:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/virtio-serial-bus: validate nr_active_ports from
 migration stream
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, qemu-stable@nongnu.org
References: <20260708144112.1830881-1-lvivier@redhat.com>
 <20260709015451-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20260709015451-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/9/26 07:55, Michael S. Tsirkin wrote:
> On Wed, Jul 08, 2026 at 04:41:12PM +0200, Laurent Vivier wrote:
>> The migration restore path reads nr_active_ports from the incoming
>> stream and passes it directly to fetch_active_ports_list(), which
>> uses it to size a heap allocation. A crafted migration stream can set
>> this field to a very large value, causing QEMU to attempt a
>> multi-gigabyte allocation and abort.
>>
>> Fix this by checking nr_active_ports against the configured
>> max_virtserial_ports before calling fetch_active_ports_list().
>>
>> Cc: qemu-stable@nongnu.org
> 
> Can you add a Fixes tag pls?

Fixes: 6663a1956eb6 ("virtio-serial-bus: Maintain guest and host port open/close state")

> 
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3801
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> to make sure who is merging this me?

Yes, please merge it through your tree

Thanks,
Laurent

> 
>> ---
>>   hw/char/virtio-serial-bus.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
>> index c1973f0248fc..80f1b308aa53 100644
>> --- a/hw/char/virtio-serial-bus.c
>> +++ b/hw/char/virtio-serial-bus.c
>> @@ -804,6 +804,10 @@ static int virtio_serial_load_device(VirtIODevice *vdev, QEMUFile *f,
>>   
>>       qemu_get_be32s(f, &nr_active_ports);
>>   
>> +    if (nr_active_ports > max_nr_ports) {
>> +        return -EINVAL;
>> +    }
>> +
>>       if (nr_active_ports) {
>>           ret = fetch_active_ports_list(f, s, nr_active_ports);
>>           if (ret) {
>> -- 
>> 2.54.0
> 



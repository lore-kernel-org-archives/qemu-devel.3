Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A2F112584F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0M8O-0007bW-Ez; Wed, 11 Mar 2026 12:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0M7r-0007NM-Sc
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0M7l-0007J1-Bz
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773245364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eNYl66/sX5PXSdpPVO3VmjseY7fWHNBDNjGXIdxS88Y=;
 b=JUgCJqnHXD/uwKR6etLqVuSf4M390srwK3zjsAMaxvJxw5n2y1DumI0WGm8OyHueiGpU0E
 bnCJZr6WJIPaNEIRTgfBXBJdqJCo83rTfdi98asGYAjc3c79IVnsM6T1TzDZO7EnayXItl
 lPOuxsQqt62RB92JUA5xeP/Slp5Fj0c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-HkEF3jqJMimzniXt7lKKRA-1; Wed, 11 Mar 2026 12:09:22 -0400
X-MC-Unique: HkEF3jqJMimzniXt7lKKRA-1
X-Mimecast-MFC-AGG-ID: HkEF3jqJMimzniXt7lKKRA_1773245361
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so203655e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773245361; x=1773850161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=eNYl66/sX5PXSdpPVO3VmjseY7fWHNBDNjGXIdxS88Y=;
 b=bVgFso1stsC5iEghlJBHzqskY0FbncaS61LuR8PFHKoodIGk+30Ycn2bpOqXdmDPdn
 kjvTLSJTfe3bs0h41DPGBSiz3fT0XMoFM3uIduxoW+3BNJucrqNQxY0ZwJGVv1muQ9Ki
 0/klpybl/Kyp0JLjd4bAM9alxKbFqroUyQWzxDV4/UMgXC/tEIjIj4OYfqtWPk0+IKVf
 ZJa5tmsrEekdI1sCHO3Xlqpmmz7+Cx7hiuCQPPzU7qme+TG47G0zxHQ2zIYnkeoxGrf7
 t47HLhAQZ5FcRi/TZfYzlcBig4HebbI3hshdBfxGWbD5ESbfEzSLOTEdBqK+Ir5yJPfE
 T9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245361; x=1773850161;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eNYl66/sX5PXSdpPVO3VmjseY7fWHNBDNjGXIdxS88Y=;
 b=OPST+ebQfjniatmipEspxh98f7j7reDuzu7IPcwDYDW5C/vVhOVt39wxZIWB/fHqjm
 JqlRQsI8z5Lg3c8SzsAcPxy54ZpBiEe5M6c/Ix6XOWJH7zvxVTu1PMy1y17Icz/WdJlr
 8utDN1waj/M5vj2sgcnbFenrp2IiWFII20MXYFnpncewsxB+si9SicLbJ56skHWeOfQC
 HXJzLPJ7qo+srmvUXNZfI/tWCSH4oVqmf9yYWtXL6jPHuXT+Hi9QoTGI74nntT7Vx513
 HKKGtd/EaVaavSkMcU5zhRHmORX5umnqKKXBWr1gVu6tq3X/0q1qS9YOiHo4b3TVeN7w
 cSWQ==
X-Gm-Message-State: AOJu0YyYm+EiHMEzwBgE+qVVQ1taSg1MOq+aZrd69XDLzn4rdjgOxYh9
 E4eICsvXE4jySv9p+vhEumMLFgustuBMWVsNCvZ1nKQK9x2U5s7HNgwCLq6qqBTVvi68uy+xknS
 9SRSVtDNqiF8s5laQoJn3HhRPufqZy4emr1yBA+NNaqLRrAsxxv9Om1IU
X-Gm-Gg: ATEYQzwxYbUz12VqT43u/p7k1oxU5Teje0sOd472P8S3Y+D3jbB1BX5qDOkaMgbwj+C
 WOsFgNx1cfVGzxuuXLYzIi4omXYMmvTTkg2iGRrkghCmMCszvKpNe6dZ3ipIfU36q2x14l6A/ry
 U5brNXVc5mOR87cAeXsH4TBIyBXhbb5WA+9q8E8jUuluJ+c2WZMdyUTPY3cmjLwRIIetDmTHZqU
 syTdU/NqiyV3XuglQzuZ5qhoCkOWdCNkxM5Wv2hx0dporoLnZ5bKm4m02wxqYhPAhF+4UKWOhb1
 3Mywf6piYQ7X8aR6XuaVA0J1tu4Ev6aaMfaY8wJYd3KC5X7jzzT0waEDpyWc0pZPAjdVVtPoGn7
 BJZPVmQUvLaWJZwuLwVjs8BBUmwvzMioIFbbzgLPjtgwvnbWzUlcgjaMk4cUB
X-Received: by 2002:a05:600c:8b0a:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-4854b12cf85mr51950215e9.31.1773245360973; 
 Wed, 11 Mar 2026 09:09:20 -0700 (PDT)
X-Received: by 2002:a05:600c:8b0a:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-4854b12cf85mr51949395e9.31.1773245360478; 
 Wed, 11 Mar 2026 09:09:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b66dedfsm63953835e9.12.2026.03.11.09.09.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 09:09:19 -0700 (PDT)
Message-ID: <99f0a899-a19c-4534-a0bb-042d7c530f38@redhat.com>
Date: Wed, 11 Mar 2026 17:09:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Deprecate Multi-process QEMU (Re: [PATCH 3/4] util/event_notifier:
 fix error handling for event_notifier_init callers)
To: Jag Raman <jag.raman@oracle.com>, Trieu Huynh <vikingtc4@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maciej Szmigiero <maciej.szmigiero@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Thomas Huth
 <thuth@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 John Levon <john.levon@nutanix.com>
References: <20260310182801.196443-1-viking4@gmail.com>
 <20260310182801.196443-4-viking4@gmail.com>
 <E1A0FC83-8A41-4ACF-A786-CDBCBF314F68@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <E1A0FC83-8A41-4ACF-A786-CDBCBF314F68@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello Jag,

+ John

>> diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
>> index 5081d67e7f..e91566509f 100644
>> --- a/hw/remote/proxy.c
>> +++ b/hw/remote/proxy.c
>> @@ -52,9 +52,20 @@ static void setup_irqfd(PCIProxyDev *dev)
>>      PCIDevice *pci_dev = PCI_DEVICE(dev);
>>      MPQemuMsg msg;
>>      Error *local_err = NULL;
>> +    int ret = 0;
>>
>> -    event_notifier_init(&dev->intr, 0);
>> -    event_notifier_init(&dev->resample, 0);
>> +    ret = event_notifier_init(&dev->intr, 0);
>> +    if (ret < 0) {
>> +        error_report("Failed to init intr notifier: %s", strerror(-ret));
> 
> setup_irqfd() should ideally propagate the error up the stack.
> But hw/remote/proxy.c is planned for removal as it is superseded
> by vfio-user, so we don’t need to do it.

In that case, could you please send an update of docs/about/deprecated.rst
to deprecate Multi-process QEMU ?

Thanks,

C.



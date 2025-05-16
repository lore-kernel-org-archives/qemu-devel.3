Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A76C3ABDD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 07:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFpO7-0003bH-Kt; Fri, 16 May 2025 03:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFpO3-0003aO-1D
 for qemu-devel@nongnu.org; Fri, 16 May 2025 03:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFpO0-00066t-Io
 for qemu-devel@nongnu.org; Fri, 16 May 2025 03:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747380097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U/C21OTWciIvl2Rb2L+gEytf1UagDO81HkPYQ7SQwzg=;
 b=USyo+buUUY7F59XuQFAVU6FWTpqpzO8ZrZBb2590Qy74CZrqNh2oLYQYkHrB7ANgrhhH7d
 NwC4LhNLFA0Q/5XqYfG/vYKk+yl6uC8JFs9/Ji1q5p3cDOxWJWQB/h5Okr12CfpGIXnUJl
 lhnJQ5pUHPAbg41fX/N22A3JXLqBre0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-JjZ4wZabNs6Uex5Y7BKgdQ-1; Fri, 16 May 2025 03:21:35 -0400
X-MC-Unique: JjZ4wZabNs6Uex5Y7BKgdQ-1
X-Mimecast-MFC-AGG-ID: JjZ4wZabNs6Uex5Y7BKgdQ_1747380094
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so10552495e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 00:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747380094; x=1747984894;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U/C21OTWciIvl2Rb2L+gEytf1UagDO81HkPYQ7SQwzg=;
 b=Yin9wUh66ggXJrceaqpVQmwxVEf9/GuhtpuqkNBRqgFuPVYuTtQIzN6DYQ0GXu+jGd
 JwJ5tdaZ8MjDyWpEAsoj1XoytBwz3I06lI73uVPQbz047os1FoJuAIacxqoL7xQFu467
 Onysd0WNfinuJ2+qjg+X3tqCZXISrcCoZ3hHZ8q0T03RFPUgiK6dWKUbfSJ8MINLKHSD
 1BQOTR/v2rFoHBbWRRV8Mu0HeNw4K77h0yJ2EBq0LlLC6BOGiS/ZKmGu3aHeLuTKQ+/Q
 WSQJti6KIxLKDX40QUEcIInHrkcUTKhe7oxNl8tcRktfgaOFo4VblZ8xpUQwvzZJuv22
 6FmQ==
X-Gm-Message-State: AOJu0YyJMDA5rSTdcSAm0j+ql2NKDq5RZTGh8WHMf2jWHUNMhWjHnAch
 shFb6nRaucYuDYvGx487O4mOHXDEGDajlXYYH27ThuVj/TxSP+ipgxMPqNF+VUh+jSG22YGattC
 ORjR4iMAJgtiy3YjqQwDq3aau29E9DUGoduypGK/QhtxmpajasdX2Du20
X-Gm-Gg: ASbGnctF+C7JWWrLDhTlK6OspwP11zii9U/Fyct6ap/CK01TitxXs426DCXXDdhB+mX
 jiX4WwNen05aQ3jw7GFMVkzu7QkcSMjO52ldyvS8PrqYcCvnUY3qxi1o1W2FSk8lPkiMkTIhbGz
 Jn3RRM39BmfrZberRKl3x4p0PNWWvPZQcLwWZnaua3nh4ANBGDVpJ46wClLC0j2UWLZXBXHTiaS
 +UMFCOVrhnQId7MjAn999LvV/oMlsrO2Hw5sB8B591ZrGeR07TsHLRhDdzbckenkhZmlZvtKjSg
 /bLMlPyZoa3gz8Worx0e/UA+Dn8Ioy2uoxMK0Yfg1jk=
X-Received: by 2002:a05:600c:4e42:b0:43c:e70d:4504 with SMTP id
 5b1f17b1804b1-442fd64dfccmr20950905e9.19.1747380094374; 
 Fri, 16 May 2025 00:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlg+zlEZz+UqvcHOpJrj5NtADRjGE92C88PCrlAeLRmlvZu6HXOOSEbCZ8eea58DhVPtBOhw==
X-Received: by 2002:a05:600c:4e42:b0:43c:e70d:4504 with SMTP id
 5b1f17b1804b1-442fd64dfccmr20950635e9.19.1747380093951; 
 Fri, 16 May 2025 00:21:33 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-129.web.vodafone.de.
 [109.42.48.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f33691fdsm99826425e9.5.2025.05.16.00.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 00:21:33 -0700 (PDT)
Message-ID: <a0d4dd1b-19e8-4b18-85c3-57f867993d69@redhat.com>
Date: Fri, 16 May 2025 09:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iotest 240 is failing
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org, stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>
References: <20250311160021.349761-1-kwolf@redhat.com>
 <20250311160021.349761-21-kwolf@redhat.com>
 <a6b01ce7-e1a0-46bc-8c12-f3e439486f82@redhat.com>
 <8cb149ee-57fe-4e67-8ab9-f95244ebcb33@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <8cb149ee-57fe-4e67-8ab9-f95244ebcb33@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/04/2025 11.39, Thomas Huth wrote:
> On 26/03/2025 11.43, Thomas Huth wrote:
>> On 11/03/2025 17.00, Kevin Wolf wrote:
>>> From: Stefan Hajnoczi <stefanha@redhat.com>
>>>
>>> Allow virtio-scsi virtqueues to be assigned to different IOThreads. This
>>> makes it possible to take advantage of host multi-queue block layer
>>> scalability by assigning virtqueues that have affinity with vCPUs to
>>> different IOThreads that have affinity with host CPUs. The same feature
>>> was introduced for virtio-blk in the past:
>>> https://developers.redhat.com/articles/2024/09/05/scaling-virtio-blk- 
>>> disk- io-iothread-virtqueue-mapping
>>
>>   Hi Stefan!
>>
>> This patch seems to cause some troubles with iotest 240 in raw (and some 
>> other) mode:
>>
>> 240   fail       [11:41:33] [11:41:34]   0.8s   (last: 0.8s)  output 
>> mismatch (see tests/qemu-iotests/scratch/raw-file-240/240.out.bad)
>> --- tests/qemu-iotests/240.out
>> +++ tests/qemu-iotests/scratch/raw-file-240/240.out.bad
>> @@ -46,11 +46,11 @@
>>   {"execute": "device_add", "arguments": {"bus": "scsi0.0", "drive": 
>> "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>>   {"return": {}}
>>   {"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": 
>> "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
>> -{"error": {"class": "GenericError", "desc": "Cannot change iothread of 
>> active block backend"}}
>> +{"return": {}}
>>   {"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>>   {"return": {}}
>>   {"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": 
>> "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
>> -{"return": {}}
>> +{"error": {"class": "GenericError", "desc": "Duplicate device ID 'scsi- 
>> hd1'"}}
>>   {"execute": "device_del", "arguments": {"id": "scsi-hd1"}}
>>   {"return": {}}
>>   {"execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
>> Failures: 240
>> Failed 1 of 1 iotests
>>
>> Could you please have a look?
> 
> Ping!
> 
> The problem still persists in QEMU 10.0 :-(

Ping^2 !

It's still failing. Could anybody please have a look?

  Thomas



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F0CC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprmM-0006qs-6p; Wed, 05 Mar 2025 11:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tprmI-0006jL-ON
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:39:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tprmF-0003iE-G5
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741192762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U83kUuPKGdqh1tq6HeBUeBNw3dpwVcwemkzikWsnT7g=;
 b=HHDiLgxBPXySoVOLt3mYR5RgpjAwngHRRbiSYtiWg6zOqX4BJx/C5Uv+ogE8JupleMsr/s
 GED/ZP0wNQ/iWIRY3Iyi03G9fZfMWKe+/PWCWxMnGr0m3ejfAb5TbWB/2JDtYHbHVj/YQA
 Lw5j+9WBynXFNf4w5mtmuf5GrLcBSRU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-jS-BQ9CiPIyIY6GnHULWNA-1; Wed, 05 Mar 2025 11:39:12 -0500
X-MC-Unique: jS-BQ9CiPIyIY6GnHULWNA-1
X-Mimecast-MFC-AGG-ID: jS-BQ9CiPIyIY6GnHULWNA_1741192752
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4394c0a58e7so49212585e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741192751; x=1741797551;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U83kUuPKGdqh1tq6HeBUeBNw3dpwVcwemkzikWsnT7g=;
 b=WUGL/WZqS5Gk9kL8wyUhc3iT6KSo3DoLH1//lHpADJO61OjEOvuzAJ0bHNEKGlX1Yu
 j0/qBzCVziJD/2nM9x9clWUP+LHLvXz3R5HEthGChglNAmFgupoGJPOfkKu71qSRmAG6
 AXWq0/1TI8Ms43QlqtJAIf6lp0qe3QgYVT3VDUvgveTNLY89GedpKfqlGcVYsNGITzDo
 d0EolgvoQIn/YapBkiWeGh/3lzLgi5wfo8jEboHX3nQ4o09NcxEkx7lS6SsiWlZ8FMA2
 3YzkY9Q1Ic+nb1/gkUOoHvx6pdK1Dxl5h37Sm5fj3h/cnuz03Ne1dbuKFgl3fuUt/1/C
 bNTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU0mCdl75+qoq/jRiVwl3JpwmXWK90frulIp7ox/7+G7jiIMIZwl0uoGeFLJw8ncxeN837OJ/h17Mu@nongnu.org
X-Gm-Message-State: AOJu0YwQcqdize/W0an0UVlTV63riN+a7zsHvhgAQ1Y1GQ6pwFIHFCgo
 GJj2/8RR2QF1DVwd8GHl4gCEzEFHrU3H7o6KLV1RW7Lkk+/9sMA2xFPLjTk3YKJcRo5Pv5JKByE
 Sjxawqw7aifzO7hJUWFYh2NoiQQdBKBPUmFx0g75istJ2kzZ/Za3g
X-Gm-Gg: ASbGncuL2SL5l2s9NwO46GxlHzuH1yeUUIh3YsnNOmMn/nxPYaHbN4N7O/Og1FPX03c
 Hz9ckJ/fiyDnQo2gnxuC2nEEJRhPE2l3ivLeohvrylhJANxhEEIP0bibr5yjuNxn3T6+bHcqC2L
 8OmCsiZyTOBOGQJmwsb6g8mmOCvPyy47KVdBEbhb2wH+lQfyVq0lfbuNoEM5vubtg1togcbS0YO
 owT0lJU9ofNJX1r7dOO8S39fr+oJsiKQW3GdqDINhAbGGdHjQpazmr7cpXl4jCDMNOSJcy2ZdK3
 cDa/qzLbZXkdJfj0aIn3Wi6luoTENYdJe6ZlMdmw/pElAXEUM7pXDA==
X-Received: by 2002:a05:600c:3ba8:b0:43b:cd0d:944f with SMTP id
 5b1f17b1804b1-43bd2945f10mr36634895e9.5.1741192751560; 
 Wed, 05 Mar 2025 08:39:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3zRoI2EtqDa5Dl6Fb1QFwuP2inPqKjnYsTt+iRc4SSN8VDbv/EuRezizaDy0WLv2BU8+e7w==
X-Received: by 2002:a05:600c:3ba8:b0:43b:cd0d:944f with SMTP id
 5b1f17b1804b1-43bd2945f10mr36634635e9.5.1741192751122; 
 Wed, 05 Mar 2025 08:39:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4848252sm21711972f8f.69.2025.03.05.08.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 08:39:10 -0800 (PST)
Message-ID: <a7a72358-ba42-41fd-b602-4db9a2d033b7@redhat.com>
Date: Wed, 5 Mar 2025 17:39:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 34/36] vfio/migration: Max in-flight VFIO device state
 buffer count limit
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <09463235e0aa30e48e40bd6c89d07f56f4140a93.1741124640.git.maciej.szmigiero@oracle.com>
 <3f7bc3ad-20eb-447c-ae1c-14d6e2072206@redhat.com>
 <4a97d4dc-4fc8-4ab7-8615-1e5e8a53a7ef@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <4a97d4dc-4fc8-4ab7-8615-1e5e8a53a7ef@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/5/25 16:11, Maciej S. Szmigiero wrote:
> On 5.03.2025 10:19, Cédric Le Goater wrote:
>> On 3/4/25 23:04, Maciej S. Szmigiero wrote:
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Allow capping the maximum count of in-flight VFIO device state buffers
>>> queued at the destination, otherwise a malicious QEMU source could
>>> theoretically cause the target QEMU to allocate unlimited amounts of memory
>>> for buffers-in-flight.
>>>
>>> Since this is not expected to be a realistic threat in most of VFIO live
>>> migration use cases and the right value depends on the particular setup
>>> disable the limit by default by setting it to UINT64_MAX.
>>
>> I agree with Avihai that a limit on bytes would make more sense.
>> -rc0 is in ~2w. We have time to prepare a patch for this.
> 
> According to https://wiki.qemu.org/Planning/10.0 "Soft feature freeze"
> is next Tuesday.
> 
> Do you still want to have that patch with a new byte limit applied
> after that?

yes. It has been discussed and we can still merge stuff until the
hard freeze. After that, it's fixes only.

Thanks,

C.


> 
>>
>> Should there be a correlation with :
>>
>>      /*
>>       * This is an arbitrary size based on migration of mlx5 devices, where typically
>>       * total device migration size is on the order of 100s of MB. Testing with
>>       * larger values, e.g. 128MB and 1GB, did not show a performance improvement.
>>       */
>>      #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
> 
> I think we could simply have a counter of queued bytes up to this point
> and then abort/error out if the set amount of bytes is exceeded.
> 
>> Thanks,
>>
>> C.
> 
> Thanks,
> Maciej
> 



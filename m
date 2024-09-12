Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E7AEEB568
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofS2-0004BK-1L; Thu, 12 Sep 2024 04:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sofRy-0003zs-Jm
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sofRw-00006T-Pg
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726130710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3WFsN7BdyZD94mCabIaBbNndUsJGhzs3uYZypOATNQ=;
 b=TPOaiCCUPCUUn9mTeOiIZxhEE+2XFjcWPyaZDwlJHk0AkFbALgbvpJ22/ztEE+jPZD0e1w
 jS6gia3cKKFiB8z1HWqVSgpU9Kitv0EEfK1MgqSyJgYO5YE2fy6Uzfyq7Gr18josRizXCF
 i7Oa//fDTZSiJfyAr6J2rsMMcXIrfnc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-n4gGSBv1OjenPh3p2x0cBw-1; Thu, 12 Sep 2024 04:45:08 -0400
X-MC-Unique: n4gGSBv1OjenPh3p2x0cBw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cae209243so4108445e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 01:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726130707; x=1726735507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K3WFsN7BdyZD94mCabIaBbNndUsJGhzs3uYZypOATNQ=;
 b=HmPP4hhePwt2znSwoV69B9RVEo6vrYdZw+VOw76t60/viJlutPe1G9z1Zy5ZAdrJ1T
 AP6Gw7/9uCE9CUEUFHAZHcufUTc68/tj42RQIYn6TPY5vFw11HcswtqJ7Bw0Z1dHWYnO
 QuWYugIESSQkv+ukOppizfJObWKlmHZ61UerK24HSpjG/8nbTV6XJ/CQ/vh7BuvFBejV
 WB8g5eT3GDJMIwOlEOImSKj9n2DWktEv8p70T155j7ED/JS2Pi6HhDMbzp03/1zFKnbY
 NcWCVQJmkhUjnqGR465uuy730dBiNGOR3yrfrLjw/rV/d3TcJRmhYqFnNe1+Oi60b5uN
 0jOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUN2Lo1sf7bRNJJ5d8zvNWHwZrT9/IOdbMf7sWq7lLVWPdpjNP9emZ05EjyGieBUvzLz+E4ahpgzFq@nongnu.org
X-Gm-Message-State: AOJu0YyL0fx/GDLD4iSDavJXaDaazUZl+Mzq1ELhfPRT6dNoIzYnZVmk
 17/7aAMmvEKgvdXeklWqO+O1NDIFvasYJ/FRsKMfRDJg1dNR5340FkkOke7SfTtq0jE6NfS6tY/
 QdDU7wot3yiNSbhIprJYp5KEUYfIMLQyaD/oHoh6LvXNgpGowMS+o
X-Received: by 2002:a05:600c:3556:b0:426:6a53:e54f with SMTP id
 5b1f17b1804b1-42cdb576a8fmr13687745e9.33.1726130707355; 
 Thu, 12 Sep 2024 01:45:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFRimdVkY8cOeeZWyGV1P/Fwk4MS1PFpCYKw4bsc4y5O9CdAaLXkGPswv62RV0BQvWrAiZlg==
X-Received: by 2002:a05:600c:3556:b0:426:6a53:e54f with SMTP id
 5b1f17b1804b1-42cdb576a8fmr13687515e9.33.1726130706873; 
 Thu, 12 Sep 2024 01:45:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cc01a8ee7sm86671455e9.0.2024.09.12.01.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 01:45:06 -0700 (PDT)
Message-ID: <f25c5dc5-fdd2-45a6-b110-04ad8b0bf5d2@redhat.com>
Date: Thu, 12 Sep 2024 10:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/17] vfio/migration: Multifd device state transfer
 support - receive side
To: Avihai Horon <avihaih@nvidia.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <4133ce80174fa3b81070adaeeb068554beba2854.1724701542.git.maciej.szmigiero@oracle.com>
 <12ebbb56-c2a7-42d0-8dad-9b459a490c39@nvidia.com>
 <ad637771-3eff-4492-b3a8-e72bb1e91551@maciej.szmigiero.name>
 <5a9dba27-96e5-4404-b429-c36d9b1c5707@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <5a9dba27-96e5-4404-b429-c36d9b1c5707@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

>>>>
>>>> -    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>>>> - vbasedev->migration->device_state, errp);
>>>> +    migration->load_bufs_thread_finished = false;
>>>> +    migration->load_bufs_thread_want_exit = false;
>>>> +    qemu_thread_create(&migration->load_bufs_thread, "vfio-load-bufs",
>>>> +                       vfio_load_bufs_thread, opaque, QEMU_THREAD_JOINABLE);
>>>
>>> The device state save threads are manged by migration core thread pool. Don't we want to apply the same thread management scheme for the load flow as well?
>>
>> I think that (in contrast with the device state saving threads)
>> the buffer loading / reordering thread is an implementation detail
>> of the VFIO driver, so I don't think it really makes sense for multifd code
>> to manage it.

Is it an optimisation then ? In that case, could the implementation not
use threads ?

VFIO is complex, migration is complex, VFIO migration is even more. TBH,
the idea of doing thread management in the VFIO subsystem makes me feel
uncomfortable.

Thanks,

C.





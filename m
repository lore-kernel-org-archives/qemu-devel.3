Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28182C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 09:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdlNv-0007lM-DR; Sun, 28 Jun 2026 05:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdlNU-0007g6-Up
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 05:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdlNT-0001zL-0q
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 05:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782637231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UPuE6AevBEldyQbodcx80pcPqJwO4+gY3H7+t0u//k0=;
 b=Lzw52LSo1b2JcLqQ2d05r2C9HwcqMnz6o2gzkYhkepxolUTahNPCMNv2yxme+oPTzp8u93
 5lu9EfhETrOZ3ckaHV2c3Yuesw5X7F7I6I72EYaM9E+tQJ8wUS3Y6/i+sfuDW86Thejlbl
 bedCPRQspwFz4YiNVQuyIXDBkde8zu0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-bt-LjJ_cO8Ku5iPrZbDLuw-1; Sun, 28 Jun 2026 05:00:27 -0400
X-MC-Unique: bt-LjJ_cO8Ku5iPrZbDLuw-1
X-Mimecast-MFC-AGG-ID: bt-LjJ_cO8Ku5iPrZbDLuw_1782637226
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46d46a6d8d9so1086802f8f.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 02:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782637226; x=1783242026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UPuE6AevBEldyQbodcx80pcPqJwO4+gY3H7+t0u//k0=;
 b=jdZ+87CypEE9EoTSDh5qtDyYeTspYo/UjpYPV3OMiWwh9PmJD4kjaO90Z/b08eeEyq
 Hp+EYtQMfvUKD7yFf2bWpuV9WLFtawnaWTTxzuhVfRo+g5bOTqNGjVPiO4U0REoSLExq
 q785wWGmkGZxzWzhPnDL9wyO2CLnj9WTUbhShzwBkCH1PWFD4Gu0CTRHDAm49vFyQYCu
 DOUCJc8Vnk1DWjCKbX2JErUI+Jghfj9ez43WkIifuEsVZRtBv8YJaUcrUyC6BmPay2vN
 5LtbitS4TUNkp3zqvF+9QBVY/8G3m3OduxL72pmsbJX20A3uYvLOczMyit9wRxF7KG6M
 Om3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782637226; x=1783242026;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPuE6AevBEldyQbodcx80pcPqJwO4+gY3H7+t0u//k0=;
 b=MBJcUEX5CPSRb+ndY7rBw/hjExEeq+g4fzCkrgVO+Q0v1xW7Tj1tb9KEdIx+PNSmkl
 AZTjDLGQv9BrM2amB32Yub5tLTV1iQnHL+bd5wEoiBmru9eqb7t0e6gR22i3uYRpT4pJ
 Y9nexR6Ac6moFWvf7Jmda55fUj0ck7EWO0CRqKNMR/xoujT6/5XSO2nlZsiJBHwwFCfe
 J8EDw3RbvlDh3zVNgMoO/9DGoGDyrqiyKnhy8do7r0DxRGqWC3yovvHlfIgYG060lBb6
 l+WgdWU/VpjV4HXF2L1inxB2HPeoRXFlgz+LLLrSYhcS9HlUMZtbmq40a24VGKlQ99C4
 aADQ==
X-Gm-Message-State: AOJu0YxA0EBPWPxkvFJhIZprxKVNnbFZUGC5usFDzuXw6oA6YtX8FJyL
 0a11MvaUOqU3VLrz51Mn99FayabiQPQAUS+ZE12vr1schgFBn0RzsxYwQcAOOASmbtEGbYKK4x6
 sqF6JTcb5NohNX/Y61cuATIbF1i/ZG7Q0rVYCe98o6HLMjY5mWVwsaQNL
X-Gm-Gg: AfdE7clRWb00IIfQGBmxfc1uyCFQiDpZ2BJNXn74MMh7p5rwoX0pwF0HnmIF/7+dNTy
 RRY8wDkDEf/n25iYAZ4QCBsPuvupb2+4k2kJj05btbQ++LXbTnKrWvGi0D3Bgu5KbPMLq23eRO1
 yeBdTXfpeb4GM9X3MsECWcG/WDRkvNY9ZTKBw0oq4iDpYFHyPDajJ3WIZPbNqHqWNaUAJTcNxG2
 YBYliK1XBIDemjfajGv3yaVlBADuY/qSyETvOitC1TogVfyWRhdqWJsXAB0LOiKiJNsqwk6q3bI
 m0d7lVj6TJP0SLTFT+y/uR2+lNXvH8G0gLvUIBxJK9gH4FCOICe3P4fFJ/7rKmIUgYyQpGFCV1J
 0dklX/yxSHAZ4xfN3AriFsEOjKMEkthXfReYA4UHy74lZF0g6yQ==
X-Received: by 2002:a05:6000:4210:b0:468:7ca1:2368 with SMTP id
 ffacd0b85a97d-46dc2a17107mr23054620f8f.29.1782637225968; 
 Sun, 28 Jun 2026 02:00:25 -0700 (PDT)
X-Received: by 2002:a05:6000:4210:b0:468:7ca1:2368 with SMTP id
 ffacd0b85a97d-46dc2a17107mr23054577f8f.29.1782637225527; 
 Sun, 28 Jun 2026 02:00:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4728072188fsm6305282f8f.29.2026.06.28.02.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2026 02:00:24 -0700 (PDT)
Message-ID: <9fa2038d-f75b-4d6a-a2fc-1bc871878b74@redhat.com>
Date: Sun, 28 Jun 2026 11:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] migration: Make switchover-ack re-usable
To: Avihai Horon <avihaih@nvidia.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
 <20260622101214.25770-8-avihaih@nvidia.com> <87v7b520uo.fsf@pond.sub.org>
 <b997b3f7-0a95-4c21-bf18-c19bf8754936@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <b997b3f7-0a95-4c21-bf18-c19bf8754936@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/28/26 10:16, Avihai Horon wrote:
> 
> On 6/26/2026 10:54 AM, Markus Armbruster wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Just spelling nitpickery this time.
>>
>> Avihai Horon <avihaih@nvidia.com> writes:
>>
>>> Switchover-ack is a mechanism to synchronize between source and
>>> destination QEMU during migration to prevent the source from switching
>>> over prematurely.
>>>
>>> VFIO uses switchover-ack to ensure switchover happens only after
>>> destination side has loaded the precopy initial bytes. This is important
>>> for VFIO, as otherwise downtime could be impacted and be higher.
>>>
>>> In its current state, switchover-ack is a one-time mechanism, meaning
>>> that switchover is acked only once and past that another ACK cannot be
>>> requested again. This was sufficient until now, as VFIO precopy initial
>>> bytes was defined to be monotonically decreasing. Thus, when precopy
>>> initial bytes reached zero for all VFIO devices, a single ACK would be
>>> sent and its validity would hold.
>>>
>>> However, now the new VFIO_PRECOPY_INFO_REINIT feature allows precopy
>>> initial bytes to be re-initialized during precopy. Specifically, it
>>> means that initial bytes can grow after reaching zero, which would
>>> invalidate a previously sent switchover ACK.
>>>
>>> To solve this, make switchover-ack reusable and allow devices to request
>>> switchover ACKs when needed via the save_query_pending SaveVMHandler.
>>>
>>> Since now switchover ACK can be requested for a specific device and in
>>> different times, make switchover ACK per-device (instead of a single ACK
>>> for all devices) and let source side do the pending ACKs accounting.
>>>
>>> Keep the legacy switchover-ack mechanism for backward compatibility and
>>> turn it on by a compatibility property for older machines. Enable the
>>> property until VFIO implements the new switchover-ack.
>>>
>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> ---
>>>   qapi/migration.json                | 14 ++++----
>>>   include/migration/client-options.h |  1 +
>>>   include/migration/register.h       |  2 ++
>>>   migration/migration.h              | 32 ++++++++++++++++--
>>>   migration/savevm.h                 |  6 ++--
>>>   migration/migration.c              | 37 ++++++++++++++-------
>>>   migration/options.c                | 10 ++++++
>>>   migration/savevm.c                 | 53 +++++++++++++++++++++++-------
>>>   migration/trace-events             |  5 +--
>>>   9 files changed, 123 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 27a7970556..9b3070e494 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -508,14 +508,12 @@
>>>   #     (since 7.1)
>>>   #
>>>   # @switchover-ack: If enabled, migration will not stop the source VM
>>> -#     and complete the migration until an ACK is received from the
>>> -#     destination that it's OK to do so.  Exactly when this ACK is
>>> -#     sent depends on the migrated devices that use this feature.  For
>>> -#     example, a device can use it to make sure some of its data is
>>> -#     sent and loaded in the destination before doing switchover.
>> Here, "switchover" is used as noun.  My dictionary is happy with that.
>>
>>> -#     This can reduce downtime if devices that support this capability
>>> -#     are present.  'return-path' capability must be enabled to use
>>> -#     it.  (since 8.1)
>>> +#     and complete the migration until the destination has
>>> +#     acknowledged that it is OK to switchover.  The acknowledgement
>>
>> Here, it's used as verb.  I think it needs to be spelled "to switch
>> over".
>>
>> Same for code comments etc.
> 
> Sure, I can send a patch to fix those.

Can you please send the update as a follow up patch ?

Thanks,

C.

> 
> Thanks.
> 
>>
>>> +#     may depend, for example, on some device's data being loaded in
>>> +#     the destination before doing switchover.  This can reduce
>>> +#     downtime if devices that support this capability are present.
>>> +#     Capability @return-path must be enabled to use it.  (since 8.1)
>>>   #
>>>   # @dirty-limit: If enabled, migration will throttle vCPUs as needed to
>>>   #     keep their dirty page rate within @vcpu-dirty-limit.  This can
>> [...]
>>
> 



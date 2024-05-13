Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6313C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 16:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Ytn-0000u9-Ru; Mon, 13 May 2024 12:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6Ytm-0000tu-4I
 for qemu-devel@nongnu.org; Mon, 13 May 2024 12:51:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6Ytk-0005Ua-BZ
 for qemu-devel@nongnu.org; Mon, 13 May 2024 12:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715619095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1M9ss6/g2SAEQbLLSenOBW8fFb8kZLxDJWIIONLiZHE=;
 b=PlkKhjxuYZc0SNlcmDG5OTlNjFXB0OzGn7lcfL7mxE0+lYQqsIfuV+yuZQxPJkHoaexctG
 H+xR4XGmWdHq19iRRd63StLYYQWdVQiwN0E7R6D8VR0W1mDxwIFgRnp0IRgwbPwtWmXteE
 8l+MPLEEnIKqNXyG5LXhQ7dOsSZoXYQ=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-embhmNPNN1Ct8gBzNopFug-1; Mon, 13 May 2024 12:51:31 -0400
X-MC-Unique: embhmNPNN1Ct8gBzNopFug-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c9a22a71ecso3216830b6e.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 09:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715619091; x=1716223891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1M9ss6/g2SAEQbLLSenOBW8fFb8kZLxDJWIIONLiZHE=;
 b=vZ31+nLJf3yPwDgAdCfEHa1UFb9lB81q/Cm8P33AgMrq9KuIEwrVH2MIrgiJ+cmumk
 d8QY6Z8U8BjKwzoO2fiesQk/D54iBDAeBtBTTQBmdL+RHDsvYsiRH72OIk7ol1M/oR1x
 ubEJvfVCSF2KSdzmlC/IERhovL69heDhH+3h/8SDKj6kJTNfq2Wn7LFXesasT/sKEYHk
 fapMEBWHBLHdwPZXzkzuXPKUCO106SFlDZS55cZp5pGmPAavUrS+1R2s2DDN4ErFHdKv
 tZtdTvec0v+u3bUx8bdext1jvb+qou6MPjEG7OlfK6d2WHGqARiV1uV15G0iB/0RzlNk
 +5hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeSsCWYMRzV0RgHwJX9vLb4HLvApiuEfZzpGzWOqA0CuAl8WxAXdQ8hC3LkTlNIssDLgA1jjwKKTSiPDR29T4P4q7cFz8=
X-Gm-Message-State: AOJu0Ywano8XqnpDa57MgmcVzKPUt1isynzTBxOZ1Cb1yhdQ6TNoTXQX
 s81iPuZsWF2eqdKKz06EnNjsrdMTIQFhc8EypH6wLp51y72wTks+7OTriknI/1ynl2pNdNj5vtk
 SUhoxI8SMoqaiiYT+1sMNs4eSJ33A3JgEOVJB2sWttjpIVwFC/UeB
X-Received: by 2002:a54:4086:0:b0:3c9:9424:9318 with SMTP id
 5614622812f47-3c9970cdb18mr10163715b6e.45.1715619091109; 
 Mon, 13 May 2024 09:51:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExMwq5df+dqwEICVKIHT3uuP84dRw8meS0BnDsMxqNBIH/J7q7qbVGvisdw/7P0l8q2YJEmA==
X-Received: by 2002:a54:4086:0:b0:3c9:9424:9318 with SMTP id
 5614622812f47-3c9970cdb18mr10163700b6e.45.1715619090759; 
 Mon, 13 May 2024 09:51:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1797c8sm44814516d6.22.2024.05.13.09.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 09:51:30 -0700 (PDT)
Message-ID: <71da5125-5eb8-4b98-85fa-1e21ab4decf6@redhat.com>
Date: Mon, 13 May 2024 18:51:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] vfio: Extend migration_file_set_error() with
 Error** argument
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-4-clg@redhat.com>
 <ddce202a-9d98-460d-acd8-e89aeaf61b6f@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ddce202a-9d98-460d-acd8-e89aeaf61b6f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/13/24 15:14, Avihai Horon wrote:
> 
> On 06/05/2024 12:20, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
> 
> Change commit title:
> 
> vfio: Extend migration_file_set_error() with Error** argument
> 
> to:
> 
> migration: Extend migration_file_set_error() with Error* argument
> 
> ?

yes.
  
> Other than that,
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>


Thanks,

C.



> 
>>
>> Use it to update the current error of the migration stream if
>> available and if not, simply print out the error. Next changes will
>> update with an error to report.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/migration/misc.h | 2 +-
>>   hw/vfio/common.c         | 2 +-
>>   hw/vfio/migration.c      | 4 ++--
>>   migration/migration.c    | 6 ++++--
>>   4 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index c9e200f4eb8f8a8ab2c8b8d0e0dbf871817b94fc..8da2f6454d82046c449f034eb978e1247a9be682 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -103,7 +103,7 @@ void migration_add_notifier_mode(NotifierWithReturn *notify,
>>
>>   void migration_remove_notifier(NotifierWithReturn *notify);
>>   bool migration_is_running(void);
>> -void migration_file_set_error(int err);
>> +void migration_file_set_error(int ret, Error *err);
>>
>>   /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
>>   bool migration_in_incoming_postcopy(void);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index b5102f54a6474a50c6366e8fbce23812d55e384e..ed5ee6349ced78b3bde68d2ee506f78ba1a9dd9c 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -150,7 +150,7 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
>>   static void vfio_set_migration_error(int err)
>>   {
>>       if (migration_is_setup_or_active()) {
>> -        migration_file_set_error(err);
>> +        migration_file_set_error(err, NULL);
>>       }
>>   }
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 06ae40969b6c19037e190008e14f28be646278cd..bf2fd0759ba6e4fb103cc5c1a43edb180a3d0de4 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -726,7 +726,7 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
>>            * Migration should be aborted in this case, but vm_state_notify()
>>            * currently does not support reporting failures.
>>            */
>> -        migration_file_set_error(ret);
>> +        migration_file_set_error(ret, NULL);
>>       }
>>
>>       trace_vfio_vmstate_change_prepare(vbasedev->name, running,
>> @@ -756,7 +756,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>>            * Migration should be aborted in this case, but vm_state_notify()
>>            * currently does not support reporting failures.
>>            */
>> -        migration_file_set_error(ret);
>> +        migration_file_set_error(ret, NULL);
>>       }
>>
>>       trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
>> diff --git a/migration/migration.c b/migration/migration.c
>> index b5af6b5105d58f358f6d4d31694e21debd8eb81d..9c648f5ba1c0104088e37baf90d9f94fbdc21570 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -3033,13 +3033,15 @@ static MigThrError postcopy_pause(MigrationState *s)
>>       }
>>   }
>>
>> -void migration_file_set_error(int err)
>> +void migration_file_set_error(int ret, Error *err)
>>   {
>>       MigrationState *s = current_migration;
>>
>>       WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
>>           if (s->to_dst_file) {
>> -            qemu_file_set_error(s->to_dst_file, err);
>> +            qemu_file_set_error_obj(s->to_dst_file, ret, err);
>> +        } else if (err) {
>> +            error_report_err(err);
>>           }
>>       }
>>   }
>> -- 
>> 2.45.0
>>
> 



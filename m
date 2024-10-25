Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3893BD0C61F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Lyt-0007jS-2f; Fri, 25 Oct 2024 11:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Lyr-0007jI-BL
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:12:01 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Lyp-0006oi-Bx
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:12:01 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20c7ee8fe6bso18012595ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 08:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729869117; x=1730473917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YkuAV7BFhd4FkhYyQUKNQ2ghG0dPfm50ribO8YQldV8=;
 b=i7m6bxtRE38pzPqyfoEvpDRicR1yraCplj5zf9HNUEz7I7KXQU5Uu10iQ+Zny0ysyL
 gD2bJWjidxVgeXam0PLW2oECaIqLPsIl0ebA9ZWBQC66919L93eL7Z1W64mqEvt70FLo
 rRfdaeJIXFThRPnvWyjwR3u2BrnhdGDuW1on1jJKOJANC/FQpEqQkNaH7an2X8qgu35x
 d4Tgp9EokUzWAPvDI1x+WSNhQtz/0pzesqZ7tCYd3qUlZWrAsawBftKdQcz0DWzjL4O0
 Mdt/ngQAZJ5iIK/La9Sxts+gA36QuPPvPlTKOYWkCFh0o2WVupoSI/HI6wyr01g1FMf9
 ftHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729869117; x=1730473917;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YkuAV7BFhd4FkhYyQUKNQ2ghG0dPfm50ribO8YQldV8=;
 b=tdNyHWsURoA+dvvoZc0D4PG0SXn/UynORtUIfOh9EPmzzX40yXXHjwxVaugsPS/imx
 684wcH4ikdQMCvosUUWY7HK7A/d+6wx3uO+3OpihV3p7If+d33ReKI/FWBbrRiolroy5
 946jMhyCkzSYq1f+zkuiYu712W3Lt2lnJH4TTI+W6PEt/SU1VqZN1dL5uIFCuOBmHs6f
 itN5t+cXQZCUfTz915swlvgtXVP36HGL5Yxx2EceQi9prvXHDAwP/d7cD0LmrInDmilZ
 KU9JB4R5fuLbZirGP/v5IZ5iSBbb77u33w3RSDKNVJnccsG9R6t5kPlUsz+9fOc/4tCO
 lu6Q==
X-Gm-Message-State: AOJu0YzPBcTLVrOsqCG3x8zIVx5EN/CNR5NbzQgr1GqjCm5ptk3vBzr6
 YbyrVVNnnHqwKc1lG0P15xq+1W4QDJKXwPhQxpY3Hfk2lqbjFhKCIbOtQ3o5pnI=
X-Google-Smtp-Source: AGHT+IGr8ky4BaqOfFi87Q/N1cCogYCARQ7n4Mf1RIUyEjyD+8IsGvO1ge+wRGPnOas4EouYtTfibA==
X-Received: by 2002:a17:902:e5c6:b0:20c:5bf8:bd6e with SMTP id
 d9443c01a7336-20fb9aca160mr64263075ad.48.1729869116984; 
 Fri, 25 Oct 2024 08:11:56 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bbf4348csm10415025ad.4.2024.10.25.08.11.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 08:11:56 -0700 (PDT)
Message-ID: <69eef5ad-93e3-4e6f-82c0-e8ee627128d4@linaro.org>
Date: Fri, 25 Oct 2024 12:11:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] qom: TYPE_SINGLETON interface
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-2-peterx@redhat.com>
 <20dec12b-69e0-4996-9962-6aac9d40fc07@linaro.org> <ZxqztLdfV__sGuDZ@x1n>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZxqztLdfV__sGuDZ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 24/10/24 17:53, Peter Xu wrote:
> On Thu, Oct 24, 2024 at 05:02:19PM -0300, Philippe Mathieu-Daudé wrote:
>> Hi Peter,
> 
> Hi, Phil,
> 
> Thanks for the quick reviews!
> 
>>
>> (Cc'ing Mark)
>>
>> On 24/10/24 13:56, Peter Xu wrote:
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    include/qom/object_interfaces.h | 47 +++++++++++++++++++++++++++++++++
>>>    qom/object.c                    |  3 +++
>>>    qom/object_interfaces.c         | 24 +++++++++++++++++
>>>    qom/qom-qmp-cmds.c              | 22 ++++++++++++---
>>>    system/qdev-monitor.c           |  7 +++++
>>>    5 files changed, 100 insertions(+), 3 deletions(-)
>>
>>
>>> +/**
>>> + * SingletonClass:
>>> + *
>>> + * @parent_class: the base class
>>> + * @get_instance: fetch the singleton instance if it is created,
>>> + *                NULL otherwise.
>>> + *
>>> + * Singleton class describes the type of object classes that can only
>>> + * provide one instance for the whole lifecycle of QEMU.  It will fail the
>>> + * operation if one attemps to create more than one instance.
>>> + *
>>> + * One can fetch the single object using class's get_instance() callback if
>>> + * it was created before.  This can be useful for operations like QMP
>>> + * qom-list-properties, where dynamically creating an object might not be
>>> + * feasible.
>>> + */
>>> +struct SingletonClass {
>>> +    /* <private> */
>>> +    InterfaceClass parent_class;
>>> +    /* <public> */
>>> +    Object *(*get_instance)(Error **errp);
>>
>> IMHO asking get_instance() is overkill ...
>>
>>> +};
>>> +
>>> +/**
>>> + * object_class_is_singleton:
>>> + *
>>> + * @class: the class to detect singleton
>>> + *
>>> + * Returns: true if it's a singleton class, false otherwise.
>>> + */
>>> +bool object_class_is_singleton(ObjectClass *class);
>>> +
>>> +/**
>>> + * singleton_get_instance:
>>> + *
>>> + * @class: the class to fetch singleton instance
>>> + *
>>> + * Returns: the object* if the class is a singleton class and the singleton
>>> + *          object is created, NULL otherwise.
>>> + */
>>> +Object *singleton_get_instance(ObjectClass *class);
>>> +
>>>    #endif
>>
>>> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
>>> index e0833c8bfe..6766060d0a 100644
>>> --- a/qom/object_interfaces.c
>>> +++ b/qom/object_interfaces.c
>>> @@ -354,6 +354,23 @@ void user_creatable_cleanup(void)
>>>        object_unparent(object_get_objects_root());
>>>    }
>>> +bool object_class_is_singleton(ObjectClass *class)
>>> +{
>>> +    return !!object_class_dynamic_cast(class, TYPE_SINGLETON);
>>> +}
>>> +
>>> +Object *singleton_get_instance(ObjectClass *class)
>>> +{
>>
>> ... when we can use object_resolve_type_unambiguous:
>>
>>        return object_resolve_type_unambiguous(object_class_get_name(class,
>> NULL));
> 
> I think an issue is migration object is nowhere to be find under
> object_get_root(), so it won't work there.  A side benefit is, it's also
> faster..

Maybe a simpler alternative is to add a field in ObjectClass, maintain
a single GHashTable to store TypeName -> Instance and retrieve as:

Object *singleton_get_instance(ObjectClass *class)
{
     return g_hash_table_lookup(&singletons,
                                object_class_get_name(class));
}

TBH the TYPE_SINGLETON interface seems a bit over-engineered and its
implementation error prone.

> How about I use object_resolve_type_unambiguous() as a fallback?  Then it's
> used only if get_instance() is not provided.
> 
>>
>> BTW should we pass Error** argument to singleton_get_instance()?
> 
> I didn't expect it to fail, hence I didn't even add it to make it more like
> "this will always success or it asserts" kind of things.  I left Error** in
> the hook just to be slightly flexible, but I always pass in error_abort()
> in this patch.
> 
> I can either add Error** if anyone thinks it useful, or even drop Error**
> in ->get_instance() since it's mostly not used at least for now.
> 
> Let me know!
> 
>>
>>> +    SingletonClass *singleton =
>>> +        (SingletonClass *)object_class_dynamic_cast(class, TYPE_SINGLETON);
>>> +
>>> +    if (!singleton) {
>>> +        return NULL;
>>> +    }
>>> +
>>> +    return singleton->get_instance(&error_abort);
>>> +}
>>
>> Alternatively call object_resolve_type_unambiguous() in instance_init()?
> 
> Thanks,
> 



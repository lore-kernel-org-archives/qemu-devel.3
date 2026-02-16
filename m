Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7E4E7BDBB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 13:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrya4-0007gw-RQ; Mon, 16 Feb 2026 08:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vrya3-0007ft-BK
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 08:24:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vryZz-00077v-Vq
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 08:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771248238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XokGw1y0ZCZrVqU1DyUNYF459tK7oAlfsiuZUS61oaQ=;
 b=eLuE3UGci2M/DYVtkzFiJIA6lZl99Px2z6cDBqhSrs1EBkD0Wu3rm+GySXbQ/rBs02eLZn
 91dDibYUWsUOYgc8y5JRAIrNk+3Pdgjd2OuWRUQES0rNH2pOPCqpgG/8jhbYMDdaU8G+vT
 1Ifss2ESL6JsNKasdHKmcqLrs9yCfuk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-RHaRDQnHMJmkx4LnYd_dZg-1; Mon, 16 Feb 2026 08:23:37 -0500
X-MC-Unique: RHaRDQnHMJmkx4LnYd_dZg-1
X-Mimecast-MFC-AGG-ID: RHaRDQnHMJmkx4LnYd_dZg_1771248216
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so22143105e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 05:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771248216; x=1771853016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XokGw1y0ZCZrVqU1DyUNYF459tK7oAlfsiuZUS61oaQ=;
 b=T3IFLtmilhzeNMOFU0fCM6YZIY7GqC3vHefG+dYE+zEb5VOSmQAews5XFXLW4Mngk6
 4aOVzzBDb+wwckZIS/bg1yZoLyqTgZnFCXkaXV0UXD51jGi2GtmyAAvJDaPWGorjEF6m
 dmEXq3zlw+lBBD0sgY1JdPs7/Hq330MS/2BAvN/PD7KOsdKi7b+ERvpjJJnDD7ymjTCN
 q2z7ieUWdpEZR7lHK9DPpSGTlkYmyZZtcKWtdZmrxgrio8xX100YZNT56bfTo2p1t4hv
 +zMvFrE1QWjOt3fVpaXuJwjOWLu0FkXPLZ66iHr53mFzrG/4TatkIbSqwBYtHBxm/t2/
 As/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771248216; x=1771853016;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XokGw1y0ZCZrVqU1DyUNYF459tK7oAlfsiuZUS61oaQ=;
 b=AmYLQwgmXUecUuLiBTwjJ2du5yXc2YMCmbVfvX3W49VO2kU6veq7ANQS40HzmRl7t+
 9PIiEzGdZe1+2SpTo1xIvsEwY1l66mbXobDKNKYXup5kS8n65zm4FVmcT+jf//H2kF8b
 PPEWF6ryavnTZlzZ1SSdpt7db22RNziP4mtkwQ7mxiN5og01OioPHhE9gIey7x/nTJtd
 HgUvcPZamDYU6ZhabLImmUTvTLP2j33FQjbYFrAxddv1CKjuF8/tG6u1ktFiHMxbxaUb
 rhnsB4UUggwufvVsbC0Jiuc9jcb31UIcIy6YkNZgFrwswPv5grp0f/ZZBQmM5thOxvtu
 eIog==
X-Gm-Message-State: AOJu0YybCn9GPetZqp7y25HLfzWvdRoX65qpKdOT0QX2Fj6O5jON15Iq
 POogqTUmocIoEpqd4EUsZ7+7calXCsRmfoiaSed08ADwKVTB6yljILxTNVM1z0MSrpD+4eXJ6ZC
 JWGEP+S1XfDFn9d2dTGxCTJ/hQjok+ZNqagEB6McrYGsjA/n7I8+1vbmP
X-Gm-Gg: AZuq6aLvaPQZVVU3Jo7qFX+e0y2EfOp4yW9eibAIqSmsyrRPlyMNEvxV5LgakxPNU01
 BcnPm+inOJ3ptMnr8hjMoxwjv707Nd34QzC1wfbd9p12Zdg2q8EBm8vOPEMVzxtcWEippK6j0go
 KiZKEJWnTJj8L1xNSWNsyWU77rHHGrrmLoEchM4xmnm3AZVco05sRjCpQsw0K+DgVuTFJpSR+rN
 aOr0TNKWYrIeZGT1jc3fqlp6dVFjcrgbu0gofFdjaoCX/pNPQDGF1NkX5zf5gaQUaUvl6voYeTt
 NsbIGqviKoigKC860krVVHs6wnoMEg6j5pF4eModfgit/HGAVh+2bY2Nub88NRvxiFLajjXJ9bv
 w5GVDEi6QKMSvQF6eeqm7ycDhfIRa6yFt4z2d9vCU4qWsGq4NY1XfXYYTKYce
X-Received: by 2002:a05:600c:444f:b0:475:de14:db1e with SMTP id
 5b1f17b1804b1-48379bd742amr120239105e9.24.1771248215987; 
 Mon, 16 Feb 2026 05:23:35 -0800 (PST)
X-Received: by 2002:a05:600c:444f:b0:475:de14:db1e with SMTP id
 5b1f17b1804b1-48379bd742amr120238655e9.24.1771248215454; 
 Mon, 16 Feb 2026 05:23:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371998777sm305245975e9.1.2026.02.16.05.23.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 05:23:34 -0800 (PST)
Message-ID: <e0ce7028-6036-44b0-ac41-ffc72d91e7ef@redhat.com>
Date: Mon, 16 Feb 2026 14:23:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration/cpr: Include vfio-cpr.h instead of vfio-device.h
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
References: <20260211171532.1556719-1-clg@redhat.com>
 <aYzTTrgqWTlY76m_@x1.local> <4689305f-84bb-4423-8b7a-d66e6f77f6c0@redhat.com>
 <aY9S2EIjP6tqPss0@x1.local>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aY9S2EIjP6tqPss0@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/13/26 17:35, Peter Xu wrote:
> On Fri, Feb 13, 2026 at 10:05:06AM +0100, Cédric Le Goater wrote:
>> On 2/11/26 20:06, Peter Xu wrote:
>>> On Wed, Feb 11, 2026 at 06:15:32PM +0100, Cédric Le Goater wrote:
>>>> The file migration/cpr.c uses vmstate_cpr_vfio_devices which is
>>>> declared in hw/vfio/vfio-cpr.h, not in hw/vfio/vfio-device.h.
>>>>
>>>> Replace the include with the correct header file to avoid pulling in
>>>> unnecessary VFIO device declarations.
>>>>
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>>    migration/cpr.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/migration/cpr.c b/migration/cpr.c
>>>> index adee2a919a364244867ef190fdf29bd1fe7e20e2..a0b37007f55d6dac32bd6220ffe65d32c4e6b52e 100644
>>>> --- a/migration/cpr.c
>>>> +++ b/migration/cpr.c
>>>> @@ -9,7 +9,7 @@
>>>>    #include "qemu/error-report.h"
>>>>    #include "qapi/error.h"
>>>>    #include "qemu/error-report.h"
>>>> -#include "hw/vfio/vfio-device.h"
>>>> +#include "hw/vfio/vfio-cpr.h"
>>>>    #include "migration/cpr.h"
>>>>    #include "migration/misc.h"
>>>>    #include "migration/options.h"
>>>> -- 
>>>> 2.53.0
>>>>
>>>
>>> This should be better as a standalone change, thanks.
>>>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>
>>> Some thoughts beyond this patch alone.
>>>
>>> When looking at this, it's a layer violation.  Logically migration/cpr.c
>>> shouldn't include a vfio header, otherwise it means when new devices added
>>> to support cpr then migration needs to include headers to every single of
>>> these devices..
>>>
>>> Logically it should be the other way round where migration/cpr.c should
>>> provide a helper allowing devices to opt-in for cpr-states to register
>>> instead.
>>
>> with vmstate_un/register() ?
> 
> Likely not, because the vmstate_register() API only put things onto the
> global default savevm_state.handlers.  Those are "normal" VMSDs that will
> be migrated within the normal migration framework / channel, not the CPR
> special channel at earlier stage.
> 
> CPR channel currently saves only the special VMSD, which is currently
> vmstate_cpr_state.  That should also be why the vfio early sub-section is
> attached.
> 
> Logically it can be another similar vmstate_register_cpr(), then that'll
> put the VFIO speical VMSD to be one of the subsections registered to the
> CPR vmstate_cpr_state global VMSD.  Here subsections can be a good API
> between CPR core and CPR submodules (like VFIO) because when we send a
> subsection the dest QEMU will be able to lookup the subsections based on
> the name of subsection.
> 
> Then I believe it means when there're >1 consumers we don't need to worry
> on which got registered first, so the order of subsections to be registered
> shouldn't be part of ABI, however the name of the subsection VMSD will (see
> vmstate_get_subsection() on how we do the lookup when loadvm, that applies
> too when loading CPR state).
> 
> I don't know any existing use case of such dynamically registering
> subsections, but I think it sounds doable and maybe one simple solution for
> CPR's use to make registrations dynamic.
> 
>>> Now it's also awkward that vmstate_cpr_state always have a subsection
>>> called vmstate_cpr_vfio_devices.. it means we will migrate this subsection
>>> even if there's no vfio device..  that's also another point that I think it
>>> should be done the other way round..
>>>
>>> I do not know whether we must persist CPR ABI now.. if we need, we can't
>>> change this anymore without a machine type compat entry (as we will expect
>>> vmstate_cpr_vfio_devices to come from an older binary that does a cpr
>>> migration).  But that'll be sad..
>>
>> vmstate_cpr_state was introduced in 10.0
>> vmstate_cpr_vfio_devices in 10.1
>>
>> commit a6f2f9c42f3a ("migration: vfio cpr state hook") already
>> broke migration compatibility. May be this is something we can
>> still fix without a machine compat.
>>
>> I have no idea how cpr is used today, in which product ? Can the
>> maintainers tell us more ?
> 
> Yep.
> 
> I didn't pay much attention when reading the series when being reviewed,
> but IMHO we could have marked cpr features unstable from the start until
> it's relatively solid and in serious production deployments.
It's quite invasive currently and I wish it could simply be compiled out.
It would make it easier to catch design issues like this one and save us
time when investigating problems.


C.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAF4E6BF17
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlodl-0003hn-GT; Fri, 30 Jan 2026 08:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vlodj-0003hf-Q0
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 08:34:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vlodh-0002OC-Um
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 08:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769780060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vhnqGNuHFa55sMHRgm5JfaYcnTRH5M4m85cmPSCz4Ls=;
 b=DhsUC14B9cGqgOzC/GI31d/3jdccqwFpyPPlK/C8qI/8lQ4q7GbI1nrwpSedKCQjCOuKWG
 oHjpACm63mxq7IqTT9tjeyiBFDDP0cZxv0aIQoYWrVxO+kRGD1bs42yzr9HjClfvNrJ3WO
 TOOQl0KznyvS36YzZKWVnjyeP7eacxk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-N2ffVajlN0KsC3oVM2W-xA-1; Fri, 30 Jan 2026 08:34:18 -0500
X-MC-Unique: N2ffVajlN0KsC3oVM2W-xA-1
X-Mimecast-MFC-AGG-ID: N2ffVajlN0KsC3oVM2W-xA_1769780058
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430ffc4dc83so2501867f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 05:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769780057; x=1770384857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vhnqGNuHFa55sMHRgm5JfaYcnTRH5M4m85cmPSCz4Ls=;
 b=FNqM0b0y5A5QvKuUDUT9Sat9aU6SNS5Rlg2YyW854Rrx87QKSHNis8xglGs7Xm0NNq
 opqd3QtwgDwpbwd4NiJbtWXSWKZp+PX+jJ+lXllKAVrLZuWVhPN15bZEy7pjKIj9ix+P
 zLep4VaI/QXbwUqVE2eW/Fs3noKGEBXZmuEu0REn2h5lQIvznaQI8qQlqfXz5XuzJZqJ
 LjRpLjb3XEfkDpa0cJUyWqiYFj8EiwVgEXtLv4dSYpf+u00mmt+13kmMx5uD4k0AhRn1
 aUBunXHSeEkoZbNCRCc6ULVOZjFv2zerXn2R2B5WujijQ2iFgT/bVXi/zLYiK1SgZDSh
 30xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769780057; x=1770384857;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhnqGNuHFa55sMHRgm5JfaYcnTRH5M4m85cmPSCz4Ls=;
 b=t8XpuZSeEBi/TE75ZQQds70y9zAYr7wGDs4X18PvW8a7R619tWI+mbSX9aOrYcPRWj
 R3MT6PagrBXQjjSd+nDP5rhaULLw0u702qo4tEckRoHtAaFMS77EUYIAaRx/IFSPlaDm
 Bb5mOtU5NLKjDq6/F7rJ5JWsUpn8SB9j81Zh6LdW5A8l2BoZcqHfnwxPXDUu3C6UNXhv
 R+gk7bMDBhCZha3FOHAMvFLJLNHmUYeHulLIq47/rU/VgyhPgKQRx3Vg49gooQO6xpth
 8T9BTpl4wylmbOryAYRYqRkQwe/sPa+4j9WSFKxZMF9W5vQeP6AkGjj4aXyRoZgMECKu
 5FjA==
X-Gm-Message-State: AOJu0YzHmACEOb/dywfMfZ3Eg5BKc9VS5Qwy8uk60mm9uDkPFkrh46jI
 vkowLdWttj6mcudO1J01NH3BbKpM/IZFlhdmJTNDFQS7/GKcgj7ZlzJVP7E8hCipFfbKNMCG7sO
 kqLV9tSlPkahuRAPx2zSYIPTS0+vr8oSAqweiSt0EI+UrlTp3QB1HWHHq
X-Gm-Gg: AZuq6aIsNr5s+30BGE/6b+CVvb3suVhOGXzk5HvHO/Z1++ebGPPEjA9VUozg+2S9/7p
 yzk2AXrMN+f1tEH5F9eqd6D6UJKhhEkNo9ILfoVYwBH4i9/Ipbk90Det855mTps6SN5K7ex4ruw
 1LWXO7tl2n8Cgia66PIjk/bgwSHHIa5Ny6uHQDcuiav09kmcyWdU/XKrWjy4L6n6VlYzP/30gnZ
 4Yr4Xo97t+TxlBaGwSW2JOr1JdcxkPvBrrUiuWywfXOeAOHhBAdzV9MCEdnZ5543vmrXgzEmiWG
 YIHhroO1rCd0iyN6LVi/012Xd8GM2Wt98x9n2sZkp7P3npLQ0MkPehc0km674Zhjdjx4l+IOSbY
 k4aL1GQbv+odxATH/6R5T7KMBXcYxWm/dMEtbsIAMznyvrTJu
X-Received: by 2002:a05:6000:4285:b0:435:add0:3d77 with SMTP id
 ffacd0b85a97d-435f3abb2d8mr4255169f8f.55.1769780057528; 
 Fri, 30 Jan 2026 05:34:17 -0800 (PST)
X-Received: by 2002:a05:6000:4285:b0:435:add0:3d77 with SMTP id
 ffacd0b85a97d-435f3abb2d8mr4255134f8f.55.1769780057068; 
 Fri, 30 Jan 2026 05:34:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e135422csm22951186f8f.40.2026.01.30.05.34.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jan 2026 05:34:16 -0800 (PST)
Message-ID: <5a9057e3-dd78-4bfb-b91e-ee881f5f47cf@redhat.com>
Date: Fri, 30 Jan 2026 14:34:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/migration: Send migration event before device state
 transition
To: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260128105159.10282-1-avihaih@nvidia.com>
 <36062a37-0af5-49fc-ac06-212096fb2c30@redhat.com> <aXoiAsGCWRv1nwW-@x1.local>
 <cb677add-ef2b-4ec6-9ba5-13aa2a50ec90@nvidia.com> <aXo3mcseNxP9bJ15@x1.local>
 <591f4e36-11a8-4310-a74a-6166698d7b23@nvidia.com> <aXpJpwLvHTAXfpon@x1.local>
 <8c5920ce-45b6-4436-a019-222643f573ea@nvidia.com>
 <f9ee96b7-022d-4520-a58c-d77afe57bea6@redhat.com>
 <821de605-20b8-436a-aac7-158a24929ed1@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <821de605-20b8-436a-aac7-158a24929ed1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/29/26 22:18, Avihai Horon wrote:
> 
> On 1/29/2026 4:31 PM, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 1/29/26 06:11, Avihai Horon wrote:
>>>
>>> On 1/28/2026 7:38 PM, Peter Xu wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On Wed, Jan 28, 2026 at 07:13:43PM +0200, Avihai Horon wrote:
>>>>> In our case we only use the PRE_COPY_P2P prepare event. The prepare events
>>>>> for the other states are ignored.
>>>>> For re-enabling the timeout mechanism we indeed use the "regular" (not
>>>>> prepare) events.
>>>>>
>>>>> However, this new event can be used by anyone for any purpose, so I didn't
>>>>> want to limit it only for my use case.
>>>> I see your point.
>>>>
>>>> Said that, in this specific case, my worry is nobody will consume the rest
>>>> events, and then after a few years nobody can even tell why it ever
>>>> existed. Then QEMU needs to emits some never-used events forever, worrying
>>>> about breaking anyone, even if in reality they're always ignored.
>>>>
>>>> Personally I think it makes more sense to add one explicit message as you
>>>> explicitly need.  Then, that message can be as generic as possible on its
>>>> own.  But I'll leave that to you and VFIO maintainers to decide.
>>>
>>> So you suggest adding the prepare event only for the PRE_COPY_P2P state (which is used in my use case)?
>>>
>>> Cedric, any opinion from your side?
>>
>> I agree with Peter. Let's not over specify the feature for the first
>> use case. Let's keep it simple and well documented.
>>
>> It is not a problem if the mgmt layer is not libvirt. Diversity is a
>> good thing anyway. Just mention it.
>>
>> Let's see v2.
>>
> Sure.
> 
> So I'm planning to send v2 that only adds a new PRE_COPY_P2P_PREPARE state to the existing event.
> Please tell me if you had something else in mind.

That's fine.

Thanks,

C.



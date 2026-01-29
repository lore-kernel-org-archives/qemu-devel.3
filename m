Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1A7D6101C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 14:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlT3g-0001UC-ST; Thu, 29 Jan 2026 09:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vlT3f-0001U4-Pm
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:31:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vlT3d-0001ZC-KG
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769697099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g2nI1XaKZAnXih3IDSs8Ahh1DpI2/EWCfviR4HtpIHQ=;
 b=e7JDUWpxCTLj1CYUjTrw662mngwiINkjD+vqFrXwpFHcWrm1XOhd6EkZMrwboPFRvUfv/1
 rltNIPgjKzuCrJxUFuys4CWSHtNYTFSeKGt5oKNglU1LCvuGcZAUB+7yaCOTE2lLoS94VE
 bAIsHha9x969QwSpMEjiOn9K9VGbp+8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-53yAOGDDM6CNqRzMvqWiQw-1; Thu, 29 Jan 2026 09:31:37 -0500
X-MC-Unique: 53yAOGDDM6CNqRzMvqWiQw-1
X-Mimecast-MFC-AGG-ID: 53yAOGDDM6CNqRzMvqWiQw_1769697096
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4806fa4a180so8598235e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 06:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769697096; x=1770301896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=g2nI1XaKZAnXih3IDSs8Ahh1DpI2/EWCfviR4HtpIHQ=;
 b=CdCoHVO+zwufmDpakpCl2FQQtrkk0ZQde+QaEZt3Ce7whDZc7z1huoneGld0XoVhlF
 EnJFA09OhUskA3dNGiUPTB10BBcXHnManRMyuoAZRQTC1H50bI0sGaf4WeQIzw4Cql7g
 45QEEbaDU8udkqmw4yHjDEshpHaiYkU41P6PiFx8A4hifjaiBzuWdSQNz+5hrsIAB3zP
 3bSwiVrFqyq91a/AoETI8Z6fP0FmaRzQU2iP6PP4zPtFjXOPk8Ok2dF4FOU02H671tqg
 D3O3dKnIqv/zUQTcyyNwE1XSUhKhe5YsBd08y0jf29flj6KlirHa94aFBbGK/aO6OhM8
 KJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769697096; x=1770301896;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g2nI1XaKZAnXih3IDSs8Ahh1DpI2/EWCfviR4HtpIHQ=;
 b=JHwh99GjjZbqVogVkZJ464tIk698SCYkuQkZcSk6YvkgSb6t5PYXwndX7SRe0hpOkH
 h6Awh+AArOoTJzVlzwrV1lTzLVVjDR4jOp8sFDoJQniWRIje7Byc9DnhrIOvGK+X4it3
 jUqXxJ9nGifvJfBerZeIzCf++Z51Zx80d6IBta5E/iI/T7arsFyAXE7ycJsajcDZQsN5
 uzS7+esUvpOh2MsYIUtA8QsNv5JgvDSNdWW1hQ5OTIFa9twoVTzgMbyyP0wPB+fOsSDK
 d6B7kkJNo8yBPSwk3An0Zy7WjKdQNK3LjTSVF96t5OBN9xNiIpOFUZOXVPFMhrXnwaad
 FRZw==
X-Gm-Message-State: AOJu0Yz4oXyYe7PnftmoO9wY9zgNYG/od6YT/IXSXWsf9ZXZitzJO9pf
 LHrhk/7ri7UkMRGKzBlGVJUK7QSft1N5eMgZ7bxPVX+fRsaNsXgFPQHFetjqFuD/jb+7HgghPYA
 jA8qIrUJJXx1NVr8qfmFaEeuWPptXBBzdVJ3rbaWPt1xglIpcDm/wJSqs3UZeDwTl
X-Gm-Gg: AZuq6aKrRPm9wlSX3AVijQUkVkkIqNxb9eYsrTCqYVl9C2AUcCD19MoCX9XW+xXPzCe
 EF2VELqvUjRJSYnVUWiVndmeqeHDmB2Sm7bw1nLeAfl2fJ+srHjEoA9OgbLwIPHz4uHbqFQpnRP
 /CV8JWdn52W6W8+ce/wF254SM3YzXW71VGsaMnQlXAyXPUrbshu3SsHf5ote1IsU/2X7fIruK1u
 oUhbhr7bjC7F4KQrluYs+qsVU/1QPMTSH8FjjIWq9ShAUql4zmW0MKQTN4lF6DL5/kGwfNyS4DO
 X/TnS+mtGvLZWCpX94GsaYxDhnxg7UluDxgy6IBZoblfCNzx4H/kRSN90muK1laP5JprU3ZeY/L
 L14tR0ABFWsFRV8pW76OkGWMTkzwgyFAFPq8UDxIKNYfEARR6
X-Received: by 2002:a05:600c:820d:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-48069c3fa76mr111059465e9.3.1769697095853; 
 Thu, 29 Jan 2026 06:31:35 -0800 (PST)
X-Received: by 2002:a05:600c:820d:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-48069c3fa76mr111058905e9.3.1769697095136; 
 Thu, 29 Jan 2026 06:31:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066be7404sm221678415e9.1.2026.01.29.06.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 06:31:34 -0800 (PST)
Message-ID: <f9ee96b7-022d-4520-a58c-d77afe57bea6@redhat.com>
Date: Thu, 29 Jan 2026 15:31:33 +0100
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
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <8c5920ce-45b6-4436-a019-222643f573ea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 1/29/26 06:11, Avihai Horon wrote:
> 
> On 1/28/2026 7:38 PM, Peter Xu wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Wed, Jan 28, 2026 at 07:13:43PM +0200, Avihai Horon wrote:
>>> In our case we only use the PRE_COPY_P2P prepare event. The prepare events
>>> for the other states are ignored.
>>> For re-enabling the timeout mechanism we indeed use the "regular" (not
>>> prepare) events.
>>>
>>> However, this new event can be used by anyone for any purpose, so I didn't
>>> want to limit it only for my use case.
>> I see your point.
>>
>> Said that, in this specific case, my worry is nobody will consume the rest
>> events, and then after a few years nobody can even tell why it ever
>> existed. Then QEMU needs to emits some never-used events forever, worrying
>> about breaking anyone, even if in reality they're always ignored.
>>
>> Personally I think it makes more sense to add one explicit message as you
>> explicitly need.  Then, that message can be as generic as possible on its
>> own.  But I'll leave that to you and VFIO maintainers to decide.
> 
> So you suggest adding the prepare event only for the PRE_COPY_P2P state (which is used in my use case)?
> 
> Cedric, any opinion from your side?

I agree with Peter. Let's not over specify the feature for the first
use case. Let's keep it simple and well documented.

It is not a problem if the mgmt layer is not libvirt. Diversity is a
good thing anyway. Just mention it.

Let's see v2.

Thanks,

C.




> 
> Thanks.
> 
>>
>>>> I do not know VFIO state machine well, also not familiar with this specific
>>>> problem.  So please treat them as pure questions. Anyway, it'll be always
>>>> nice to attach some more information into the commit log IMHO.
>>> Sure.
>>> As I said earlier, I didn't want to tie this new event to my specific use
>>> case, but rather wanted to describe the general problem it can solve.
>>> But if that helps, I can add some more details in the commit message in next
>>> version.
>> That'll always be very helpful, thank you!
>>
>> -- 
>> Peter Xu
>>
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B212D1038C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 08:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOAkf-0000Mx-GX; Wed, 26 Nov 2025 03:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOAkX-0000H2-6o
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 03:19:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOAkR-0004mS-Hp
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 03:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764145169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R/uiKq498VQh0MKYlrgZIZoVCw5OmxwrGTUKnAqBTSU=;
 b=RPZZboNEK0DtEMZ0TOInn1eSut8NN3YKvegbYJeV2Ht3/+9hM8k3+gR712WDd38yuBUfTX
 Z8LDtXQtwIqSlXzLgTE4iAO62c5mZWNLcwbuMzv74Nvw9RdR+wTPDJwKP91oUxObuHo3Qn
 PcxmoRb2VaV2SnXWyW8uJoznpUlhSiA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-QMWHR3JSMIycMTW013lmfw-1; Wed, 26 Nov 2025 03:19:27 -0500
X-MC-Unique: QMWHR3JSMIycMTW013lmfw-1
X-Mimecast-MFC-AGG-ID: QMWHR3JSMIycMTW013lmfw_1764145166
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429c5f1e9faso6190278f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 00:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764145166; x=1764749966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=R/uiKq498VQh0MKYlrgZIZoVCw5OmxwrGTUKnAqBTSU=;
 b=K+dhZSNFsqvBz+ZmidAxKXLGhbsKU6EdCSfR53G5X6rrMwwR3tpWxC0YyJe/dbncci
 fv3zxXFdoviAhtlZ3A9zqkXFHLq0BafJiaowPc5JE6FNL9lgh1w3g5I5I/ddLF0u51y2
 zER7HlOKNsG1NO7uL99zSvX4OH6cUSOqw2/buIy4MVj9y99dqLmaPxVYOhixbuecCUsE
 WKR4PON7u9z1pJDwWVdf6ZBS5tm+XEKVHZOV+faQR912EfvEvOqZWkVB4Unx5qwSInrV
 PuYVm4zdWvv4flRwjmI/wFEmdYKpiS6BCgQwtD5mHpQfC3g6qEqlTr7CNjoXvVwkHtcM
 Z4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764145166; x=1764749966;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/uiKq498VQh0MKYlrgZIZoVCw5OmxwrGTUKnAqBTSU=;
 b=SQ8iPfdatg8m8PrKKCx0fyOUcj4R+MXYjTer+n3WC9iIvgdfUOdFc9+hEWwj+ZWzOa
 PiIrXSz0o82ctnWSEOwbVsEI/NbkHEouvaLYsJsTxTgpfe05VhGopnjk/8oQFWRTlEmN
 zJaqRi1/g15wswCGs6IAEtrxnl2UnmhzgoCyXuBBBLl07oLDW62mMbsKcPa0Ux7nqjxt
 64FcTFLqI/XG03XaXA3TPiQQLLtwMzBOGlgJ2Byeh9F6CEJowSUEdsdiqQtHmgkXP6Pj
 KKJaneNk6VGyYR3KsdqLtLqZtGHiegnYrTSpbqHZYTmF7Fd8wF2rKnBN8KVA/pC6vJpg
 nAtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2d/QSnWspQ3q73eOQo1lhOqYysgUMpSi9TaG4HR230tfMAcG5VXjQuFijg5zgn8yV6CEdPolsJYic@nongnu.org
X-Gm-Message-State: AOJu0YynspZDoNVx95JfrIK53rOCAdPVpeP37phWeVVjzdvSfmub//X3
 7IT0Y90R9ueDv4P6qyBNHSGjH6B2aPAYg7TFKO+5iqcbkdM1wO8jKZLk90n6/MR5Hw19mSn023p
 gkWPqYerFi8UjremLJW1c/X3rD5LDKlj78n0Fs+xzx2Lz3u5v3xYAxvTW
X-Gm-Gg: ASbGncspOk/SJ4yje+aBybOqsdtiaKSx5u9klkuBe1jXzqn+KxSPE09Ug4oE0+x11uh
 vhiehKCVHv8nZAAvhip1/Alhkvui7JrlBHE7PjN72uxtWeA2V7Z1fEAgLJeWxZTAKJer5SYzMlQ
 gZGpKP0P0rAHxb4Uv9K4gxUhZmJZFJF6097Bz0AFXzkfiy32R46uPfYOD31tBVA+owo08h1jswe
 OAkFWYQaIUcD9X9i0WlqE56UzHof1vvKw4FMHhokWTFSnEN65FoUdH7PIAvySTVaw/CfPHYNIFj
 bMyST3cS/kOZa8iMGT+7t22AAB3E434JEYmwZb4EyuCl0r1bomBQJtWiRrIUbLSUjTjusQJc/8j
 LtDf0vAja4F9xt0be5KIyTIP2MOoI8dKTEMTd3ycpo5FznIKU
X-Received: by 2002:a05:6000:240b:b0:42b:43b4:2870 with SMTP id
 ffacd0b85a97d-42cc1d0897cmr19986168f8f.26.1764145165902; 
 Wed, 26 Nov 2025 00:19:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyXQ9CfiOAIjGU1txOnVf7cDWq9OljHp4Pyh5Ydjf6I2ka/MMyUBoHQQbRKYOjbDWqFJPy0w==
X-Received: by 2002:a05:6000:240b:b0:42b:43b4:2870 with SMTP id
 ffacd0b85a97d-42cc1d0897cmr19986135f8f.26.1764145165452; 
 Wed, 26 Nov 2025 00:19:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa3a6bsm38592066f8f.28.2025.11.26.00.19.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 00:19:25 -0800 (PST)
Message-ID: <769f5a57-7006-4cef-a5cb-12d53b7c30a5@redhat.com>
Date: Wed, 26 Nov 2025 09:19:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: g_autoptr(Error)
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, farosas@suse.de, peter.maydell@linaro.org
References: <20251125070554.2256181-1-armbru@redhat.com>
 <871plmk1bc.fsf@pond.sub.org> <aSWSLMi6ZhTCS_p2@redhat.com>
 <87jyzexrly.fsf@pond.sub.org> <aSXWKcjoIBK4LW59@x1.local>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aSXWKcjoIBK4LW59@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/25/25 17:15, Peter Xu wrote:
> On Tue, Nov 25, 2025 at 12:46:01PM +0100, Markus Armbruster wrote:
>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>
>>> On Tue, Nov 25, 2025 at 08:40:07AM +0100, Markus Armbruster wrote:
>>>> g_autoptr(T) is quite useful when the object's extent matches the
>>>> function's.
>>>>
>>>> This isn't the case for an Error object the function propagates to its
>>>> caller.  It is the case for an Error object the function reports or
>>>> handles itself.  However, the functions to report Error also free it.
> 
> I'd confess I didn't pay enough attention on how the error API was designed
> deliberately to always free the Error objects before almost whenever
> possible.  But I see now, thanks for the write up.
> 
>>>>
>>>> Thus, g_autoptr(Error) is rarely applicable.  We have just three
>>>> instances out of >1100 local Error variables, all in migration code.
>>>>
>>>> Two want to move the error to the MigrationState for later handling /
>>>> reporting.  Since migrate_set_error() doesn't move, but stores a copy,
>>>> the original needs to be freed, and g_autoptr() is correct there.  We
>>>> have 17 more that instead manually free with error_free() or
>>>> error_report_err() right after migrate_set_error().
>>>>
>>>> We recently discussed storing a copy vs. move the original:
>>>>
>>>>      From: Peter Xu <peterx@redhat.com>
>>>>      Subject: Re: [PATCH 0/3] migration: Error fixes and improvements
>>>>      Date: Mon, 17 Nov 2025 11:03:37 -0500
>>>>      Message-ID: <aRtHWbWcTh3OF2wY@x1.local>
>>>>
>>>> The two g_autoptr() gave me pause when I investigated this topic, simply
>>>> because they deviate from the common pattern migrate_set_error(s, err)
>>>> followed by error_free() or error_report_err().
>>>>
>>>> The third one became wrong when I cleaned up the reporting (missed in
>>>> the cleanup patch, fixed in the patch I'm replying to).  I suspect my
>>>> mistake escaped review for the same reason I made it: g_autoptr(Error)
>>>> is unusual and not visible in the patch hunk.
>>>>
>>>> Would you like me to replace the two correct uses of g_autoptr(Error) by
>>>> more common usage?
> 
> Works for me.
> 
> Now I also think it should be good migrate_set_error() follow QEMU's Error
> API design if we decide to stick with it freeing errors in such APIs.
> 
> Said that, I wonder if you think we could still consider passing Error**
> into migrate_set_error(), though, which will be a merged solution of
> current Error API and what Marc-Andre proposed on resetting pointers to
> avoid any possible UAF, which I would still slightly prefer personally.
> 
> If we rework migrate_set_error() to take ownership first, then we can
> naturally drop the two use cases, and remove the cleanup function.
> 
> Markus, please also let me know if you want me to do it.
> 
>>>
>>> I had previously proposed g_autoptr(Error) a year or two back and you
>>> rejected it then, so I'm surprised to see that it got into the code,
>>> because it requires explicit opt-in via a G_DEFINE_AUTOPTR_CLEANUP_FUNC.
>>>
>>> Unfortunately it appears exactly that was added earlier this year in
>>>
>>>    commit 18eb55546a54e443d94a4c49286348176ad4b00a
>>>    Author: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>    Date:   Tue Mar 4 23:03:35 2025 +0100
>>>
>>>      error: define g_autoptr() cleanup function for the Error type
>>>      
>>>      Automatic memory management helps avoid memory safety issues.
>>>      
>>>      Reviewed-by: Peter Xu <peterx@redhat.com>
>>>      Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>      Link: https://lore.kernel.org/qemu-devel/a5843c5fa64d7e5239a4316092ec0ef0d10c2320.1741124640.git.maciej.szmigiero@oracle.com
>>>      Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>
>> I missed it.  Not he submitter's fault; it was cc'ed to me.
> 
> If someone to blame, it's the reviewer.
At end, I was the one who merged this stuff. My bad.

I felt confident at the time, as it was only a single-line change reviewed
by a subsystem maintainer and the patch was large enough that this didn't
raise my attention.

But it should have been treated with greater caution, global features must
be introduced together with concrete usage proposals. I think this would
have raised some unconscious red flags.

Thanks,

C.








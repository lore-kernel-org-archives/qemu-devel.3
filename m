Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF844D1038C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 08:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOAmZ-00035x-De; Wed, 26 Nov 2025 03:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOAmX-0002zC-Qy
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 03:21:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOAmV-0005GI-Pa
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 03:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764145302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=H+VA6Pg1eEjV5FHvHC64VYelZeiqkfschI+tgUuYGM4=;
 b=gZNL8kGaa5APuUGkhlv9G4SLn66UWiEf1aIVomwuTCRTpJBZUqKzQtkhPhB5lza0JLxtBP
 JIchKx6MfMtNorAOOXNj6lqAUubEv4L0Whp46tJA506ZobznBTElU43Nw5D0m9Ev3wDC9d
 R7U+7ydWktKVKcTS7V+uiPt6e4MLPQM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-cbcF74HwP4WApDfm3z2nSA-1; Wed, 26 Nov 2025 03:21:41 -0500
X-MC-Unique: cbcF74HwP4WApDfm3z2nSA-1
X-Mimecast-MFC-AGG-ID: cbcF74HwP4WApDfm3z2nSA_1764145300
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b2c8fb84fso3395059f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 00:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764145300; x=1764750100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=H+VA6Pg1eEjV5FHvHC64VYelZeiqkfschI+tgUuYGM4=;
 b=BCJNskefpLk7dhB0p9eTnNL+hl3/9F9r0UcqIAFS/edvBHiAPUuenRkIWZZCkKE6TK
 Ag9DOoRxFmHE8ESPYhqbGq2nTwGdOH7YDKWiQENw78ua9M0qBAhVr9qla4k2sGofxXAK
 hCjYeYAVykyPlxqo+z1ygYxy6y0Pa/NEWy+9zvqBXTDvz0uGVwXp6NIyfjvWYv92maU5
 ZvNhvhhO45ZxzsdFDmaCSeqzeuaHo6X6uUWJuSKXPkeo69G0kk2X4+NlYEDFDUVFUmkO
 nXy2vvO5dFaICTJul5ZUxHYDDEH/whcyiwHPAwHQFIE04VYIy9ZX/y+DUN+rm1+iolhk
 WLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764145300; x=1764750100;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+VA6Pg1eEjV5FHvHC64VYelZeiqkfschI+tgUuYGM4=;
 b=sKj3P0DNzHehnEchvtRLydwGgzkc5ah8c4WdyzIqvANVQCIWdxqvQ/u5jXGhYHW0dJ
 J5oX+cEXlek7o1jRqVE83q60Ti6w8GQqdpBIdu2lF4CZErs5xvpmjGglwgbzgrpRYfXy
 60UtGVuXdWCMY+YtydB3fMeH8NQ6M+nl/lPXK8S/mKQarqN2dT1taH42UIl1aX+nQl4q
 xCx2U+sLy49GI06NHEAaI4N3ebI0igudXuk2/UNZ6LdENZCjpCimHbwpJg3QTEQKElhm
 SCSZ4LE16vb66gANX6zisHTFi96qqdXM7X8XWhFbHXrhVhv6i6LC6e3QYSyAiH6avNaJ
 Ww4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl0h2vXxa/qf7HKHkx8S08+CqZd0DoUj8qeNaGn9Q/JdNHq+uiehmgO2f3YXONSrxpmY1qtUcGLuEG@nongnu.org
X-Gm-Message-State: AOJu0YxqWoiJlMYzwguGuvAPZTXE0EaeWnU3DihyEQQT6k68K7VtVQ4z
 qZ5zN/xutd7PTqDDHojcINj2iXOEIq0zXcPJwWNTiwTnTgRHJxKzLZhrGEu2RYHrgrfikbzmNP1
 FipqUs/gcG1IgBuPej5jiwS+dgZ86pYDkXv/989bfY6qhbBKFHcd5LZhM
X-Gm-Gg: ASbGncvuR7SpGy8RYA7YIHQOPBPwTmB38H7bTktzBW/PtlLaBelLoImeDmeiEmsF139
 7wkkxnDlotVtzp5zKk7tYOUUjkG5SJ+lHEKh9CW3JByEVRP6UFNlJe4P9Mj+FSUtBSeKYQnLCso
 vYEbjN3XypgbZrREK6BgKGIXfAZv7L2GraBTRZEPjkwOKODsDDfhLvQ8Kx5KQ4S3/upImQ5fhkU
 mPhUYljiB1Qdxkrcd7OuzHH2NQdZp92s4m1huoqDrf2E4f58fDMF4GpfsrDaKGbC0Ss6qzx5N9m
 sYiTbRc3iz0OWhsLpk4LX/Pt+RAXNDzCWkrkuEmyADUUoluxY4ZChJAUKFrGYMzEmBkML0oIfzz
 OKhIjUa+bwMXMCn0xZ5wrnsL+u8W/aamZEc130sSsEv1KNCwP
X-Received: by 2002:a05:6000:2f85:b0:42b:4247:b077 with SMTP id
 ffacd0b85a97d-42e0f34fa15mr5961070f8f.41.1764145299635; 
 Wed, 26 Nov 2025 00:21:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Yz0QCUwDsEhB8h2mzBZ7LDhY3jJAmL3rMCF6nqYdT4RsvdEMZAl+KPCaL21fLEeT4Y6g/g==
X-Received: by 2002:a05:6000:2f85:b0:42b:4247:b077 with SMTP id
 ffacd0b85a97d-42e0f34fa15mr5961038f8f.41.1764145299240; 
 Wed, 26 Nov 2025 00:21:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f363c0sm39808837f8f.18.2025.11.26.00.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 00:21:38 -0800 (PST)
Message-ID: <df1498e6-70ea-4122-867f-9ccd574f65ec@redhat.com>
Date: Wed, 26 Nov 2025 09:21:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should functions that free memory clear the pointer?
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org, farosas@suse.de, peter.maydell@linaro.org
References: <20251125070554.2256181-1-armbru@redhat.com>
 <CAJ+F1CJ918Y9e=yTHFSqZo0QGmmD3aT6Zq+zxQ81t-gjKkUJPw@mail.gmail.com>
 <875xayxo6t.fsf@pond.sub.org> <aSXPhOV86fyaY53_@x1.local>
 <87ikeygd83.fsf@pond.sub.org> <aSYEO_S7FfAeZyHG@x1.local>
 <87wm3dfhk9.fsf_-_@pond.sub.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <87wm3dfhk9.fsf_-_@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/26/25 07:12, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Tue, Nov 25, 2025 at 07:48:44PM +0100, Markus Armbruster wrote:
>>> My main argument remains this one: our deallocating functions don't work
>>> that way.  For better or worse.
>>>
>>> I don't want the Error API free differently.
>>
>> Yes, it's fair.
>>
>> IMHO, it's a matter of taste,
> 
> Depends on context.
> 
> Modula-2's DISPOSE takes the pointer by reference and clears it.  C's
> free() takes it by value.  Matter of taste when these were designed.
> 
> But when one style has become overwhelmingly prevalent, it's no longer a
> matter of taste.  This is arguably the case in C.
> 
>>                                and maybe that's also why I liked
>> g_clear_pointer() but not everyone likes it.. said that, when we have
>> g_clear_pointer() it also makes the current form more flexible, because we
>> can apply g_clear_pointer() on top when we need a reset..
> 
> I'm no friend of g_clear_pointer().  I find
> 
>      g_clear_pointer(&ptr, free_frob);
> 
> a rather roundabout way to say
> 
>      free_frob(ptr);
>      ptr = NULL;
> 
> Any C programmer will immediately understand the latter.  For the
> former, you need to know one more little thing.  Yes, we can all get
> used to these little things, but it's one more little thing new people
> have to learn and internalize.  Even little things add up.
> 
> If an entire project gets into the habit of using it religiously, it may
> reduce "forgot to zap the reference" bugs some.  Until then, it feels
> like a net negative to me.

I'm not a big fan of g_clear_pointer() either; I prefer being explicit,
even if it means a bit of redundancy.


Thanks,

C.



> 
>> I'll follow your advise on error reporting for migration.
> 
> Thank you!
> 
> 



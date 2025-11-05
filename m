Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18CCCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 11:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGblR-0002gf-9z; Wed, 05 Nov 2025 06:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vGblO-0002gB-9u
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:33:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vGblL-0004Xb-1D
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762342393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/UMw9nswHEb4maATm3SJYi5gYDjZ2TkJAPA+qlGlTwY=;
 b=VWBY9MfqJ7wOYq1UFgYvMbOgaslXMA1KugUVgP4DugaKxDH87eKXzWikWC6zuYlnT/SjjN
 hQvjF4O/x8mYnYNGR16ssPWxhit5aUTGm1woQnN4JrFgNGbXjZH6vEUxEENHcHgIDoOgCK
 XnGgYfSK7Kv6wQaRyaAx6SBJfmLjONI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-kHJU6hBAOhqZYzZXXmAxhw-1; Wed, 05 Nov 2025 06:33:12 -0500
X-MC-Unique: kHJU6hBAOhqZYzZXXmAxhw-1
X-Mimecast-MFC-AGG-ID: kHJU6hBAOhqZYzZXXmAxhw_1762342391
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477563e531cso17936655e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762342391; x=1762947191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/UMw9nswHEb4maATm3SJYi5gYDjZ2TkJAPA+qlGlTwY=;
 b=UtPp540h48kBpwQyko4rBKgNdE3CPK19mW16ytwPythIhiYjH49TkqODgxGq3yQHWk
 ibNfVil0RukF1p1YdVmFVjCohQrewmFsAkd/7HcFsF6RwmfHSKKIP5eplIRA9yA6a05G
 PjtR8ZWQhKV1vHnxY1tXdZqH8ch7DzSyPbzA8/0GhPhuDLIZIsMRn9McP8ww65UVEnYK
 c+fbDl7UvPiKVoM3y+NbjiCVDXk5FZtXYD8d2hKLOHRI6XPp/SeXPPxeQ8MTKU1lz2X9
 rl40EAtZ0+E/NFpEk8KsdrrxOONUOUgnwgOcjRYky53aFYMBULUQ2Eb3uoNQMpIuWERc
 ajUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762342391; x=1762947191;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/UMw9nswHEb4maATm3SJYi5gYDjZ2TkJAPA+qlGlTwY=;
 b=eMbk5Vv0O23kv1oF1m/zzvGSlnTZYddh0BJhExooGXgfaTb88XNpTj6m8DVQEc0TbU
 1i29VoUp6k2H8mO00ducQ7IaLT4tSjHXOiEZZH4Bj1CG7idT3LW6OqF9z7FMkYQTfmW2
 27b0MFcbAM1FNwXF2c9bkPyxaLKcqHPjDrZ8PJkzulZU/IPfSoFyKG50txAWNSuvhAg7
 GEyfno8GHBX9QXEUBQyup2jqkNrNWKu1xOslYxuuCO6hYvytnoLrcDAtwtCxkBfdYId2
 wjs5CE0evIY0lndw3z0PPUJosAYeaclrqb1VbQ0WNi89maXu6NSQZakaOQzAJPftuq/6
 U3SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrgWncYcaJd1MDhIAB60lhpdvtNWJewFv6k23HIUniTbVc6kyvG/6ofZ7myfcFQCam+/yUiaKAhkYx@nongnu.org
X-Gm-Message-State: AOJu0YyaWVA0gXBw8ywdBaMFsMezNj0QZwmACQh8c1BLpyQM9Yv8ttRk
 o41gDEettIy57EDTPw7bud0l10gYECvW388QuxlbgwcyV8WgAhnPetA8Qi11+psWa8FTthNvlQn
 HAtrHgQ/uphXotm3UFoamuM8BTKqjgSFWJ/2+CNKCsdLlDF+0NCa7N9eV
X-Gm-Gg: ASbGncvVHKt23BcKFkUxD1dlMlJibqc99FtEiMaj92Heo2KCTdxWFH+tzuQDB/82ZeF
 BzDtFL1ARWkws3117R4Fr+wbZjjnpam9WdR5EkAKo3d1DY34Rc9KBXyCnh3n/vI4tj+C6BTc5IG
 TOI/PpBvwq0F2UWf4DsH4o69vkZsMbxeIugvDut2HvUKjBu6TLH1JkDjAAPRpy8o5CQJmdfTA31
 xMaH4zFBkvdqrTMKq3rrNVPsVUGQi48x98doMMPlkEsxVUYKGsyeIt8Jd8nSDSkclM5p7Gx/aUA
 ToCag8pHn6p4+JzVou5kE6fazcPX8QzVBSz3rbzMuCleVp8iKBmNoT43mjHCXnebrwpFtp1E5pz
 39U0tkIQ3Qh94VY0ZF4RISamImQmQfq6zgkIv7XA=
X-Received: by 2002:a05:600c:348f:b0:477:4345:7c59 with SMTP id
 5b1f17b1804b1-4775ce52355mr25184435e9.40.1762342390967; 
 Wed, 05 Nov 2025 03:33:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFBOfuPPGIty97KiLNatjfhIeG6CmPAjo/k8tuG9j4+onNNOvEicP9awECT7uMCaNj+iwvBw==
X-Received: by 2002:a05:600c:348f:b0:477:4345:7c59 with SMTP id
 5b1f17b1804b1-4775ce52355mr25184245e9.40.1762342390599; 
 Wed, 05 Nov 2025 03:33:10 -0800 (PST)
Received: from [192.168.42.203] (tmo-083-103.customers.d1-online.com.
 [80.187.83.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775ce2cde0sm45283105e9.15.2025.11.05.03.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 03:33:10 -0800 (PST)
Message-ID: <c0e39e96-c2c6-4cf6-b614-f54a3f9c7bb8@redhat.com>
Date: Wed, 5 Nov 2025 12:33:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/mips64el: Silence issues reported by
 pylint
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-trivial@nongnu.org
References: <20251103192430.63278-1-thuth@redhat.com>
 <5dfe6daf-b8d6-4371-a4a4-6cf98977349f@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5dfe6daf-b8d6-4371-a4a4-6cf98977349f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/11/2025 16.02, Philippe Mathieu-Daudé wrote:
> On 3/11/25 20:24, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Drop unused imports, annotate imports that are not at the top, but done
>> on purpose in other locations, use f-strings where it makes sense, etc.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/mips64el/test_malta.py  | 15 ++++++++-------
>>   tests/functional/mips64el/test_replay.py |  4 ++--
>>   2 files changed, 10 insertions(+), 9 deletions(-)
> 
> 
>> -    def test_mips64el_malta_5KEc_cpio(self):
>> +    def test_mips64el_malta_5kec_cpio(self):
> 
> I don't see how helpful this warning is... Can't we disable it too?

It's the preferred Python coding style:

  https://peps.python.org/pep-0008/#function-and-variable-names

Question is whether we want to follow/enforce it in QEMU or not?

> Otherwise:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

  Thanks,
   Thomas



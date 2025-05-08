Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05579C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 07:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCvOH-0002WH-4d; Thu, 08 May 2025 03:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uCvOD-0002Vt-IN
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:09:54 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uCvO9-0006WR-Li
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:09:52 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so19638715ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 00:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746688187; x=1747292987;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iZDeGnd6sM0XsFkq2yurnDraL5fk7VZiMFbMNmeet04=;
 b=YgU5EZcla5z2aRUu9LkgjYPS6GSPdFHWSM6Sqdxf+fu2FMZnaFkZX8E26VbjZQaMFE
 WtgkDzgBCtX6Y6D/0Rvmbh+UHGaeiU5xEwcD+rMr75OcsoCjHnOVtyUGoT8h+BzVVAxU
 2XHUcCfBFwfzkhvGHMm2+VN0cURR/XcGJBbp7DAGS/3G1YSm/sfBuBXuXDZ7yn/6kNmZ
 /Fp1aSOhnfrX14LSUXj2EM45VC8PWE7GJVjq92w3cI0tcrCF/j4kHx9LlRj5b2nnhMho
 SOaJsTu11heRcxdr4r9cjtfAO2raljmASFFle6Mtuf1fNzgaRt5MmDxI2LXyMCj2xqCZ
 pYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746688187; x=1747292987;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iZDeGnd6sM0XsFkq2yurnDraL5fk7VZiMFbMNmeet04=;
 b=LGvQYxgT/16UyzVphk3dv7gC7mI0vKYn5glGyPwTHGuFdtNtj9bDkdrm5cIFb4T2+u
 zn4wmkMw5vSK4zZvP+nQbw0ty+AeROMnmm0Uy+KNYneKa2lvI0FYkUnYzSYqwkUIGH7J
 YORKoYVpqf5wBkA7sCV2hogzpteGusfXchYIeHLsG+AlyJTqkluu+JQYvzen5B7zwcge
 JVoypsyyv/AuseNwYZ+u80p0hSctuVSY9N9waDFYj5EhahvdF7M2z9XBMGaaOjEGtchu
 VO+ca42KnSxDGNbhBzD6Qm9oVGmOC19djIk0bKD8QHYTJEmQVa871xo5zr9o+sNRRHv7
 BQZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTVOAkgOQyGQ6F/boi6yxib92e/Axbk+46/Wje7wVb52TGo23nJcpjcClLWbTLvqPI0gWnSil8OpFk@nongnu.org
X-Gm-Message-State: AOJu0YyffJBvyqUOil8tDvcEU47S8/Q0eaYXx40arjBU2efWmAfvxwhB
 fqFNPgkC4d1AsO8ni3HSgMb1VG4GWvDDXSnBArabbp0Ctj0HBof6GK3Y4uGYQo8=
X-Gm-Gg: ASbGnct3lgYcttxjgrqn7rWnS8EivRNxjupEyyT2NN3ETKYxo+pvgtS3kzOIZqJqufL
 rX2wVmwdI6WwfqiwjzGWAbZ4kZO0RAMGyk0Y+5dcoqrDagbiWOLPjwofVsw+51zN3vSk6vAc2cG
 edp5HveSRNmw/B2Is6yvhQh4dnW727uAoOnhMeQaBN8Anu9Ve0m/Gf4wbSi0MgfRnysCgYX/Uqi
 3EL4Fns5evRnbQGOnQgfotB2uRu+4glgEYJ4phoxZ2DMwbQC4iViqj8hhmXFqaazvhdnDtr8lwX
 ii8WL2cjI3G2b4iuWFvsVC0umwWKMS6Qv77AxsbTtfZpAE82mUg=
X-Google-Smtp-Source: AGHT+IG8ybqGQI2TcOAeREFT8PGDUwHd9TPC1UmWktwYWYuZoLmSaFD96slPLCAnHdynA2KjXPcVvA==
X-Received: by 2002:a17:903:1744:b0:224:3994:8a8c with SMTP id
 d9443c01a7336-22e8470d946mr33796325ad.8.1746688187502; 
 Thu, 08 May 2025 00:09:47 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522a77dsm105111775ad.177.2025.05.08.00.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 00:09:47 -0700 (PDT)
Message-ID: <3e001528-aa22-4823-82b4-685bbf819628@daynix.com>
Date: Thu, 8 May 2025 16:09:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] qdev-properties: Accept bool for OnOffAuto
To: Markus Armbruster <armbru@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, qemu-devel@nongnu.org
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-2-cbf0aa04c9f9@daynix.com> <87cyfwxveo.fsf@pond.sub.org>
 <44b21e4c-b076-41bb-9564-1e7a8cf4a450@daynix.com>
 <87r04bs8sj.fsf@pond.sub.org>
 <6e6935dd-fae7-4cce-acad-69609eba9b6e@daynix.com>
 <87r011rbqy.fsf@pond.sub.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87r011rbqy.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/05/07 0:37, Markus Armbruster wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2025/02/06 18:48, Markus Armbruster wrote:
>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
> [...]
> 
>>> I understand we have something like this:
>>>
>>> * true: on if possible, else off
>>>
>>> * false: off (always possible)
>>>
>>> Which one is the default?
>>
>> It depends. Some properties have true by default. The others have false.
>>
>>>
>>> There is no way to reliably configure "on", i.e. fail if it's not
>>> possible.  I agree that's a problem.
>>>
>>>>                                               This problem can be solved
>>>> using an existing mechanism, OnOffAuto, which differentiates the "auto"
>>>> state and explicit the "on" state.
>>>
>>> I guess you're proposing something like this:
>>>
>>> * auto: on if possible, else off
>>>
>>> * on: on if possible, else error
>>>
>>> * off: off (always possible)
>>>
>>> Which one is the default?
>>
>> I converted on to auto and off to false in a following patch.
>>
>>>
>>>> However, converting bool to OnOffAuto surfaces another problem: they
>>>> disagree how "on" and "off" should be written. Please note that the
>>>> disagreement already exists and so it is nice to solve anyway.
>>>
>>> Yes, converting bool to OnOffAuto is an incompatible change.
>>
>> Not just about conversion, but this inconsistency require users to know
>> whether a property is bool or OnOffAuto and change how the values are
>> written in JSON accordingly. This somewhat hurts usability.
>>
>>>
>>>> This patch tries to solve it by tolerating bool values for OnOffAuto. As
>>>> you pointed out, this approach has a downside: it makes OnOffAuto more
>>>> complicated by having multiple ways to express the same thing.
>>>
>>> It also affects existing uses of OnOffAuto, where such a change is
>>> unnecessary and undesirable.
> 
> To be clear: this is pretty much a deal-breaker for me.
> 
> We established above that you need certain boolean properties to take a
> third state.  I'm willing to discuss patches that change exactly these
> properties.  I'm going to reject patches that affect properties that do
> not need such a change.

I also want to change the existing OnOffAuto properties while I do want 
to change certain boolean properties as you read.

For my reasoning to change the existing OnOffAuto properties, please 
refer to:
https://lore.kernel.org/qemu-devel/d166d6c2-2b52-4c70-8fcf-a12f34a2347e@daynix.com/


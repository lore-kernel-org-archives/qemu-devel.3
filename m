Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E138C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 06:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBpX4-0003xu-JD; Mon, 05 May 2025 02:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBpX0-0003wi-IT
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:42:27 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBpWw-0007IG-OV
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:42:26 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ff694d2d4dso3609610a91.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746427341; x=1747032141;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tPfbwmgSAwzM8+8PnhmQ8SOvTRGxpayIc60gKPEwKNw=;
 b=nYwoQvUip62aLQSgfkrG+uYvPHKtaQ8S6YeoM5ObhoKZb+d0G5jS15lrZWskrhPu9b
 8yPx8ES5OTjrsXds1KJEzyMZWdrpIBoGaPwW0wtykJ8BWOFISDLeflcET/H2PZOOmIQC
 XFO0hZhKUKfjGPlAKc6qwtX7H4nxCdwb3KvVd+cnarEZQfsZiz3ZDlsYhkI3PoLxbffr
 Fvx6DtmjYCJlXwbNhGgCzgn4Bw1mmHMWgXZLEiW3yaeMAgtTXMwiL4kydJKY0sOOZiNz
 Y3n5Us25y0voS6HwVnj1D/oBd5ExW21gkrc36r/012OjxEh8ZJReQW+LNw27nJN9y+Td
 vJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746427341; x=1747032141;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tPfbwmgSAwzM8+8PnhmQ8SOvTRGxpayIc60gKPEwKNw=;
 b=SM5IsiDQ0dI6VIRblzLsLlAzVKBDhv//Ag/UE/AQaiodM6wOIDxiDE5QMY5NDlQm/e
 d3CGq/baWV9vXzDIXsFoxz0uBbHAvQyFI6rZe+ipVIsOHQhsNbrsZi/yc0GsxZGrwyOs
 IXNPxmXKXRx3B7c3rVZhtQU4XSOCa2yh0JiHUnvj7Hoh5cXHPO16sFq4BNWlcwuBSF+x
 3OCFFerF5HFi4jquR4WNSwr4lp6Fd/SiVJa3Mou3X5H4s64xyV7LxwSzDpTKcbzcrNas
 m2NjvvolkuGu9XhhUB7kGEewuzG6sTKzBZ0O8uh0qmaAu2q9XeHGwAzJhlBij5ALn4O/
 XTUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqL330sHy2XzSQPRNteyTgsw1SPHjS4ngZTtNdpCqNtIOzD8FNC/IHtRSy3xKd3mXI7Eabo3ua4FeJ@nongnu.org
X-Gm-Message-State: AOJu0YwcctGV0f85mlpZ3v8a1LcDTPqKs4yoMtv5kIprLNI010irFm7y
 so9Dblch+YHp16zPoE1bW+ZxAFJV3bM2AidyccReFdTAaS0bffvOTGJtdsJDGSg=
X-Gm-Gg: ASbGncuAxF8wRIopBl9Ah3XGEQ8htKKoSUmX+JTa7nmRlCOyyeumkeCzyeBIBIoQxeo
 820VoW539WU8jijaRH/AdwTEFKRVPwojB6H/ctM3998AJr0iFEW5ZYnshE+PfueWfiLSS8zFvHp
 dsqs5Q3bmOYDMBg+rqFCVneTKJgoOXXjwscjZDJamrgskaFrtovX/6Mnq4T6ms1bBtjXlKrTlqe
 xj9r6BOh0PDkw/hdJBIRvD67aTPslui7J44db8cd+K6ORZuWH+WBYGKyRQpMvKRdQvAQ/7FyF6D
 0c8OcQQDJpzD6z/zaKjamm+GYg0Qjp7mFTfggb2Yx6kUt/wWjqw=
X-Google-Smtp-Source: AGHT+IE6S7OIRvJiS4IxQBNxHVlbXvPxAk8IT5Vl5kAdbkVnpsPkBq1yrSzOu7FuzGn5/rNrun1QbA==
X-Received: by 2002:a17:90b:1d4c:b0:2fc:ec7c:d371 with SMTP id
 98e67ed59e1d1-30a6196ed10mr8328536a91.3.1746427341160; 
 Sun, 04 May 2025 23:42:21 -0700 (PDT)
Received: from [157.82.207.61] ([157.82.207.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34826677sm10710880a91.40.2025.05.04.23.42.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 23:42:20 -0700 (PDT)
Message-ID: <d166d6c2-2b52-4c70-8fcf-a12f34a2347e@daynix.com>
Date: Mon, 5 May 2025 15:42:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] qdev-properties: Accept bool for OnOffAuto
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
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
 <4363863f-3ba3-95b3-61ec-6fade162218f@eik.bme.hu>
 <79fea08e-21d0-46ba-923d-8892eef3ce8e@daynix.com>
 <878qqihr64.fsf@pond.sub.org> <Z6YAiQ_Rz82IMYu0@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z6YAiQ_Rz82IMYu0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102d.google.com
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

On 2025/02/07 21:46, Daniel P. Berrangé wrote:
> On Fri, Feb 07, 2025 at 01:31:47PM +0100, Markus Armbruster wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>
>> [...]
>>
>>> Let me go back to the discussion of the bool/OnOffAuto problem below:
>>>
>>> The values the command line syntax accepts are on/yes/true/y and off/no/false/n.
>>>
>>> For the command line syntax, you can always use on/off whether the type is bool or OnOffAuto. In my opinion, it is still not good to reject yes/true/y and no/false/n for OnOffAuto; why do we suddenly reject them when the property gets the "auto" value? As you pointed out, the usage of enum is our internal concern and should not bother users.
>>
>> The command line is a different mess.
>>
>> For better or worse (worse if you ask me), we added code to accept
>> additional syntax for bool values.
>>
>> Doing the same for enums that happen to have some values that look
>> boolean at a glance is in my opinion a terrible idea.  We have at least
>> two: OnOffAuto and OnOffSplit.

I agree that we shouldn't have additional syntax for on/off in the first 
place.

However, we do have the additional syntax when the property is typed as 
bool, and treating it differently for OnOffAuto is even more confusing. 
The argument made by BALATON Zoltan still stands whether the additional 
syntax is ugly or not:

 > For bools it says on/off yet expects true/false. Wasn't originally
 > true/ on/1 and false/off/0 accepted for bools? Where that got lost?
 > I think getting back that behaviour would be easiest for users. Users
 > don't care if OnOffAuto is an enum internally and can't (or don't want
 > to) remember if bools are written on/off or true/false so accepting
 > these as synonyms would help users.

This also applies whether it's in the JSON syntax, whether the client is 
a machine. Users will be freed from the mess by us dealing with it with 
40 additional lines (the number of lines are of v6).

>>
>> But let's get back to QMP.
> 
> Before we get back to QMP I should point out that our current HMP bool /
> OnOffAuto properties are a significant developer foot-gun in terms of
> back compat.
> 
> Though I'm struggling to find the examples, I'm pretty sure I've seen
> patches where we converted a property from bool to OnOffAuto, with the
> developer (likely) thinking it was back-compatible.
> 
> It does have the illusion of being compatible given that the HMP bool
> syntax is accepting 'on/off' (especially when our usage examples often
> on/off rather than yes/no/true/false) values ... very much not the
> case for QMP though.
> 
> This does make me really want the idea of an "alternate" in QMP that
> can be made to work for scalars.

I argued that "alternate" will not work well to solve problems with 
existing types, OnOffAuto and OnOffSplit at:
https://lore.kernel.org/qemu-devel/2299cb79-f03e-45e6-b536-66dab16830d1@daynix.com/

Regards,
Akihiko Odaki


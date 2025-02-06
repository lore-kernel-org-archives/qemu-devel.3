Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1663FC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 10:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfywP-00031y-5c; Thu, 06 Feb 2025 05:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tfywL-00031f-D1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 05:16:57 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tfywH-0003kt-56
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 05:16:55 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21ddab8800bso10828885ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 02:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738837011; x=1739441811;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ii3OHCBkJAsZfnlbYoaOegdRE7V0hdpARMHhtxMZ6r4=;
 b=E5y26rOBg+b8dGPZbiLPcxcHcTB0GWJxHdPOrZE9wxyeB6RBhyWm5VdOFGOFZ5bsE/
 Keq24ie/4tmGAlM9E/9GH76++e8d7GAqojVJ+8Ub0NwTW2Q+zmMUEnFoxPWg6BbdfFYV
 bBRRmptZ7Xfbfsj5+q5BDWVuty/7wPdVCxUSNtXcxGUpyljXPYuxfkHkaxL5YyukwITC
 DR9bVJ5bkrYQ9f/drULFBw3zN4fhMGxxvQs1Oja6kFlAI2DFWgPVigsARn0E9fPLZHLo
 Z9e0du1j0vvb3r1KfbSGKUMTgilYUxzyoM3LDS+QmxwSCtfUyJFDNoTJoaSYTc4gCrIp
 eHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738837011; x=1739441811;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ii3OHCBkJAsZfnlbYoaOegdRE7V0hdpARMHhtxMZ6r4=;
 b=Q75qDMMWYwTzBFB2yEfLpX962MoeNLuy+Vc9xh30c28qY5632TfG5X05tp3OD2dLe+
 3rsGO3PeccZczYfKHymCK5nV5Yf42JJ6WGud7tYMPM0cvv1pm1hwolFIn7S7pizE7TlF
 Yi5R+9QhlTcm5TqjmyrGq81rU0a9i/dXC3Gutf87j5zdqEe9AcXc+BihSW7o+JkcNu7v
 M9K18yViOYOj/o7jE2iCc/wLtB0b4msHBc5VGczu4w9CjYN2xdlZGeHsEA7RshwI3LvR
 pmNn4fBXcykURcc7mp/HID7oT+kAgIVspFpm3zXqZMjimvVK6nsk0V9+nWSdfoY7gL1u
 LeaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaSP+e4/E8TjkdGFTxJS9F3ID9W0iobIdJ5VSubKzcXcGtffDBkVzp18jdSmLL1j50ApgMVTKAcUJU@nongnu.org
X-Gm-Message-State: AOJu0Yz5VqLxclLrbLePdxCdmkIbi+n5g922lT30Cnu89c+3CIMAeDtD
 BSnI3BMVb7fPhM3HLpyHoQIA/45ZvCwTyxLgeAUjQ8DajR/YtJOLzsJ54NiV18U=
X-Gm-Gg: ASbGncszyT0wyJMGyvIFYaQDxrtpHhw/ZrCd/6m6yHFoCF9ODKmtySzLTvwRogK2C/E
 ObwtCnp8F7vKIHlY9y0suLRQX/aRG2JjF2jGFgj2dpWzHDVeOLQoBK4h9aW4Y2xJp7NiH2cBF85
 VvvIPN30FWXJ9l+ZemdYbPyAapDZa+ijC5fJpgp1GoN8cdja71xlFzmle5toOrxSWEMyBe4juug
 zdju2OSIKtd5p3XtbonX4uK/NPMFp6flHXt/mg+QTplhj17tez27NN0UBg/Dw8SAK4zkup+LFs+
 /SBaCgwyB/gxSbvQhNkF98DpdAGH2QwEsTPqoHuLEImO0R6Rft3q4ooQQ+iub5O9VILOAw==
X-Google-Smtp-Source: AGHT+IETKSl3MXKp+EV+6A96dtEcisiBRjAINi84atvWYLh8oeXk0wodihMSCgzNMkIW5ZXsEoFZ+g==
X-Received: by 2002:a17:902:e848:b0:212:4c82:e3d4 with SMTP id
 d9443c01a7336-21f17f01d0cmr99523805ad.46.1738837011188; 
 Thu, 06 Feb 2025 02:16:51 -0800 (PST)
Received: from ?IPV6:2400:4050:b783:b00:4952:3c52:120a:27e9?
 ([2400:4050:b783:b00:4952:3c52:120a:27e9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f368da40asm9005245ad.257.2025.02.06.02.16.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 02:16:50 -0800 (PST)
Message-ID: <6e6935dd-fae7-4cce-acad-69609eba9b6e@daynix.com>
Date: Thu, 6 Feb 2025 19:16:44 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87r04bs8sj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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

On 2025/02/06 18:48, Markus Armbruster wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2025/02/06 0:29, Markus Armbruster wrote:
>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>
>>>> Accept bool literals for OnOffAuto properties for consistency with bool
>>>> properties. This enables users to set the "on" or "off" value in a
>>>> uniform syntax without knowing whether the "auto" value is accepted.
>>>> This behavior is especially useful when converting an existing bool
>>>> property to OnOffAuto or vice versa.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    hw/core/qdev-properties.c | 17 ++++++++++++++++-
>>>>    1 file changed, 16 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>>>> index 434a76f5036e..0081d79f9b7b 100644
>>>> --- a/hw/core/qdev-properties.c
>>>> +++ b/hw/core/qdev-properties.c
>>>> @@ -491,6 +491,21 @@ const PropertyInfo qdev_prop_string = {
>>>>        .set   = set_string,
>>>>    };
>>>>    
>>>> +static void set_on_off_auto(Object *obj, Visitor *v, const char *name,
>>>> +                            void *opaque, Error **errp)
>>>> +{
>>>> +    Property *prop = opaque;
>>>> +    int *ptr = object_field_prop_ptr(obj, prop);
>>>> +    bool value;
>>>> +
>>>> +    if (visit_type_bool(v, name, &value, NULL)) {
>>>> +        *ptr = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    qdev_propinfo_set_enum(obj, v, name, opaque, errp);
>>>> +}
>>>> +
>>>>    /* --- on/off/auto --- */
>>>>    
>>>>    const PropertyInfo qdev_prop_on_off_auto = {
>>>> @@ -498,7 +513,7 @@ const PropertyInfo qdev_prop_on_off_auto = {
>>>>        .description = "on/off/auto",
>>>>        .enum_table = &OnOffAuto_lookup,
>>>>        .get = qdev_propinfo_get_enum,
>>>> -    .set = qdev_propinfo_set_enum,
>>>> +    .set = set_on_off_auto,
>>>>        .set_default_value = qdev_propinfo_set_default_value_enum,
>>>>    };
>>>
>>> The qdev properties defined with DEFINE_PROP_ON_OFF_AUTO() now
>>> additionally accept bool.
>>>
>>> The commit message tries to explain why this change is useful, but it
>>> leaves me confused.
>>>
>>> Does this solve a problem with existing properties?  If yes, what
>>> exactly is the problem?
>>>
>>> Or does this enable new uses of DEFINE_PROP_ON_OFF_AUTO()?
>>>
>>> I'm trying to understand, but my gut feeling is "bad idea".
>>>
>>> Having multiple ways to express the same thing is generally undesirable.
>>> In this case, "foo": "on" and "foo": true, as well as "foo": "off" and
>>> "foo": false.
>>>
>>> Moreover, OnOffAuto then has two meanings: straightfoward enum as
>>> defined in the QAPI schema, and the funny qdev property.  This is
>>> definitely a bad idea.  DEFINE_PROP_T(), where T is some QAPI type,
>>> should accept *exactly* the values of T.  If these properties need to
>>> accept something else, use another name to not invite confusion.
>>>
>>> If I understand the cover letter correctly, you want to make certain
>>> bool properties tri-state for some reason.  I haven't looked closely
>>> enough to judge whether that makes sense.  But do you really have to
>>> change a whole bunch of unrelated properties to solve your problem?
>>> This is going to be a very hard sell.
>>>
>>
>> I change various virtio properties because they all have a common
>> problem. The problem is, when the host does not support a virtio
>> capability, virtio devices automatically set capability properties false
>> even if the user explicitly sets them true.

First, I'd like to thank you for your detailed reply.

> 
> I understand we have something like this:
> 
> * true: on if possible, else off
> 
> * false: off (always possible)
> 
> Which one is the default?

It depends. Some properties have true by default. The others have false.

> 
> There is no way to reliably configure "on", i.e. fail if it's not
> possible.  I agree that's a problem.
> 
>>                                              This problem can be solved
>> using an existing mechanism, OnOffAuto, which differentiates the "auto"
>> state and explicit the "on" state.
> 
> I guess you're proposing something like this:
> 
> * auto: on if possible, else off
> 
> * on: on if possible, else error
> 
> * off: off (always possible)
> 
> Which one is the default?

I converted on to auto and off to false in a following patch.

> 
>> However, converting bool to OnOffAuto surfaces another problem: they
>> disagree how "on" and "off" should be written. Please note that the
>> disagreement already exists and so it is nice to solve anyway.
> 
> Yes, converting bool to OnOffAuto is an incompatible change.

Not just about conversion, but this inconsistency require users to know 
whether a property is bool or OnOffAuto and change how the values are 
written in JSON accordingly. This somewhat hurts usability.

> 
>> This patch tries to solve it by tolerating bool values for OnOffAuto. As
>> you pointed out, this approach has a downside: it makes OnOffAuto more
>> complicated by having multiple ways to express the same thing.
> 
> It also affects existing uses of OnOffAuto, where such a change is
> unnecessary and undesirable.
> 
>> Another approach is to have one unified way to express "on"/"off" for
>> bool and OnOffAuto. This will give three options in total:
>>
>> 1. Let OnOffAuto accept JSON bool and "on"/"off" (what this patch does)
> 
> The parenthesis is inaccurate.  This patch only affects qdev properties.
> It does not affect use of OnOffAuto elsewhere, e.g. QOM object
> "sev-guest" property "legacy-vm-type", or QMP command blockdev-add
> argument "locking" with driver "file".
> 
>> 2. Let OnOffAuto and bool accept JSON bool and deprecate "on"/"off"
>> 3. Let OnOffAuto and bool accept "on"/"off" and deprecate JSON bool
> 
> For each of these options:
> 
> (a) Change exactly the uses of OnOffAuto that need to become tri-state
> 
> (b) Change all qdev properties (currently a superset of (a); what this
>     patch does)
> 
> (c) Change all uses of OnOffAuto
> 
> I dislike (c) and especially (b).
> 
>> I'm fine with either of these approaches; they are at least better than
>> the current situation where users need to care if the value is OnOffAuto
>> or bool when they just want to express on/off. Please tell me what you
>> prefer.
> 
> We managed to maneuver ourselves into a bit of a corner in just a few
> simple steps:
> 
> * The obvious type for a flag is bool.
> 
> * The obvious type for a small set of values is enum.
> 
> * Thus, the obvious type for a tri-state is enum.
> 
> * But this prevents growing a flag into a tri-state compatibly.  Which
>    is what you want to do.
> 
> However, we actually have a second way to do a tri-state: optional bool,
> i.e. present and true, present and false, absent.
> 
> Permit me a digression...  I'm not a fan of assigning "absent" a meaning
> different from any present value.  But it's a design choice QAPI made.

It's a new insight I didn't know. Properties in qdev have a default 
value instead of special "absent". But if QAPI does have special 
"absent", perhaps qdev may be modified to align with.

> 
> Using optional that way can occasionally lead to trouble.  Consider
> migrate-set-parameters.  Its arguments are all optional.  For each
> argument present, the respective migration parameter is set to the
> argument value.  You cannot use this to reset a migration parameter from
> present to absent.  Matters for parameters where "absent" has a meaning
> different from any "present" value.
> 
> End of digression.
> 
> Start of next digression :)
> 
> Note that qdev properties are generally optional.  The only way to make
> them mandatory is to reject their default value in .realize().  When
> users set this default value explicitly, the error message will almost
> certainly be confusing.
> 
> End of digression.
> 
> Optional bool may enable a fourth solution:
> 
> 4. Make "absent" mean on if possible, else off, "present and true" mean
>     on if possible, else error, and "present and false" mean off (always
>     possible).
> 
>     This changes the meaning of "present and true", but it's precisely
>     the change you want, isn't it?

We have "false by default" properties so it unfortunately does not work.

> 
> Yet another solutions:
> 
> 5. Alternate of bool and an enum with a single value "auto".
> 
>     Falls apart with the keyval visitor used for the command line.
>     Fixable, I believe, but a good chunk of work and complexity.

I may have missed something, but I think that will break JSON string 
literals "on" and "off".

Regards,
Akihiko Odaki

> 
> My gut feeling: explore 4. first.
> 




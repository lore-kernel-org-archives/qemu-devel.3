Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E85BC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 15:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Qoi-0004kI-NX; Mon, 28 Apr 2025 11:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9QoU-0004c4-73
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:54:34 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9QoP-0005Cf-6q
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:54:33 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-225477548e1so52818115ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745855667; x=1746460467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WLgNM24oE8JmYOvmumG7fHdb/by6PACQ5IWUN8ph6Ec=;
 b=ctlDmyqNDtFocaR/kdtYr5HR2on314aN/icyLAp1gDE8FnM1qUMXeSjzPFaNE1jPFe
 ArRx5A+EKnyXG5zweMBHVQu8hn5GH9Gxzh14+sn0n3JdGIVSgwMzhuc/1ehYiG+EwUJ1
 1cQQyZStXlK1oDpWoMojucVH497Z0t8Knsl8O3vW/NJqncBCQBLAlsJjxJYaovQZclUM
 TKeuYqQ0qAuT+DxzOV+OeMdO4wL9BVXD+O4xSvd7JiTXXSmkyfHzEuMtYbhLJ503az47
 eoyjs6Ivz/ctx/D4o3uBw6TX9uAkKf7OSZGXRU58JbaAwH9Ufr/gDsHvY6oI0l3xPB5O
 ZeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745855667; x=1746460467;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WLgNM24oE8JmYOvmumG7fHdb/by6PACQ5IWUN8ph6Ec=;
 b=guaN5tGrwa/ENfCOf/tmz/zkROln9/EJgVxR4bxRVYh3SzNORlxMHa3uOZVLzeni3/
 mL4bCsUTKbyNwccuJaTb4UPeYpsaeQGOW6P8NI99Mgk55lsQRI4hpDuHDRIO10EudNH2
 /fR55kDSrJ/QgKnJm0swaDkVe/q0Nl6ur0aQ6ApIFWmo/UfAsoYb1NkacXOxQpXxx+Aj
 sZ5tJ+jHPfneKSkXWpHgj02BO45ZmyQe4B1W/b/UxToCQvUBcL9vb5EBXenQjiNmnpWt
 lTol07rgFN8EcZaGixLzmVzAe6RXLzmELsGRsjJD7wv+06rDbcBbu0mJxYEW7EFkVghz
 +LGQ==
X-Gm-Message-State: AOJu0Yzrrh55UArTBq4Pdlb17uFDss4laTyBzfhanI2p0C7O7guezaJD
 Y+cO9TElhCzi4VawFPDG941lVVU06O/xv5qmeqo4FTer3RM62ZBBh6ZcmXcePdQ=
X-Gm-Gg: ASbGncsQe9YUZV8kmQj+CjX1O/w6obrv58XHSibNwRNPz2Ko7niakpFidh4mvtyBkz/
 PU5eHb4cXwswFGo23HWinqfmS5OSdqNsmQN/wYMwR4oxrfR1QISlF8q5Z+KobYWySK8rN+R6Psf
 FMChjJImYrr1FZpc1G45uHxrIlPt21V4ITszMN5RGE9yUdd62UvU80Oqs7bfmpH/Wvk7SvPa1FD
 uTYUmR68y69HFYrX/2slIg2cuoQNgNfX3QLMXzC7Ooe32JRFqJ78AQcjk6CvGzCdnAChNsrhZkK
 XYrUU3IKT+YTzy6Asiv31yinR0AlUDZ3scI38S9KZ8l9T6fcS4SVZg==
X-Google-Smtp-Source: AGHT+IFWmpd25z64+80HJ2mg4NMlGTmYsykQ+pPkkcobYVy0g4RP5ROnKHGdEUkUirlKR3meBiZ2tg==
X-Received: by 2002:a17:902:db02:b0:223:fabd:4f99 with SMTP id
 d9443c01a7336-22de5ec17aamr2294405ad.5.1745855667007; 
 Mon, 28 Apr 2025 08:54:27 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52214fdsm84327345ad.251.2025.04.28.08.54.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 08:54:26 -0700 (PDT)
Message-ID: <1e93220e-0390-43f6-b8f7-beedacf5c65f@linaro.org>
Date: Mon, 28 Apr 2025 08:54:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com,
 philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <aAs6Q2GiBUbUCc2I@redhat.com>
 <65639a73-c6d7-472f-8788-69341f93760d@linaro.org>
 <aA8-PjcGmMrGqXGK@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <aA8-PjcGmMrGqXGK@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 4/28/25 1:37 AM, Daniel P. Berrangé wrote:
> On Fri, Apr 25, 2025 at 01:39:49PM -0700, Pierrick Bouvier wrote:
>> On 4/25/25 00:35, Daniel P. Berrangé wrote:
>>> On Thu, Apr 24, 2025 at 11:33:47AM -0700, Pierrick Bouvier wrote:
>>>> Feedback
>>>> ========
>>>>
>>>> The goal of this series is to be spark a conversation around following topics:
>>>>
>>>> - Would you be open to such an approach? (expose all code, and restrict commands
>>>>     registered at runtime only for specific targets)
>>>
>>> QMP defines a public API between QEMU and external mgmt apps, and personally I
>>> like the idea that the API exposed is identical across all binaries and thus
>>> the API becomes independent of the impl choice of combined vs separate binaries,.
>>>
>>>> - Are there unexpected consequences for libvirt or other consumers to expose
>>>>     more definitions than what we have now?
>>>
>>> QEMU used the selective hiding of commands in the QMP schema as a mechanism
>>> to allow mgmt apps to probe for supported features. We need to check usage
>>> of each QMP API feature that's behind a TARGET_* condition and identify
>>> which libvirt uses as a feature probe, then come up with a strategy for how
>>> best to handle each case in libvirt in future. We might need some additional
>>> runtime mechanism to probe for certain things, but we won't know until we
>>> look at things in more detail.
>>>
>>
>> Could we consider to hide the concerned commands from introspection related
>> commands as well? The same way we prevent those commands to be registered,
>> we can probably prevent them from being visible for libvirt.
>> The code would still be there, and compiled once, but based on runtime
>> target_X() value, it would not appear in introspected schema.
>>
>> I'm not sure how all this is implemented from QAPI code generator, maybe
>> it's hard to do something like this, if we build the schema at compile time
>> for instance.
>>
>>>> - Would you recommend another approach instead? I experimented with having per
>>>>     target generated files, but we still need to expose quite a lot in headers, so
>>>>     my opinion is that it's much more complicated for zero benefit. As well, the
>>>>     code size impact is more than negligible, so the simpler, the better.
>>>
>>> IMHO it is unfortunate that the API we currently expose has a dependency on
>>> a specific impl choice that mgmt apps are expected to rely on for feature
>>> probing. An ideal API design is not so closely coupled to impl choice
>>> (separate vs combined binaries), and would expose enough functionality
>>> such that mgmt apps continue to work regardless of the impl choices.
>>>
>>
>> At this point, do we know which kind of "feature" gets probed? Is it only
>> the list of commands available, or is there probes based on enum/struct
>> definition?
> 
> In general if it is visible from QMP it is liable to get probed - any
> and every aspect of it is in scope.
> 
> To figure this out you need to produce a list of each command/struct/field
> that has a 'if $TARGET' conditional, and check whether libvirt uses it or
> not.
>

At this point, it seems more natural to expose exactly the same 
information, instead of trying to see "potential" impact of exposing 
more. I just feel like we'll open a pandora box, and it will take a long 
time to converge anywhere.

The initial motivation is just to remove per target code in QAPI 
generated code, and not to trigger a whole refactoring in several projects.

>>> We thought the conditionals were a good thing when we first designed QMP
>>> this way. We ended up using two distinct classes of conditionals, one
>>> reflecting build time features and one reflecting which target binary is
>>> used. I don't think we fully contemplated the implications that the latter
>>> set of conditionals would have on our ability to change our impl approach
>>> in future. I think the proposal here is taking us in a good direction
>>> given what we now know.
>>>
>>
>> Thanks for considering an alternative way given the new needs, that's
>> appreciated.
>>
>> Would that possible to get some help from people from libvirt or QAPI
>> developers for this?
> 
> There challenge here is how QEMU will change this without back compat
> problems.
> 
> Our deprecation process won't work well here. There's no nice way to flag
> up that we're about to change the way conditionals work.
> 

If we expose exactly the same schema, there is no need to change 
anything. The only impact is on modifying the .json, to add new *_if 
clauses, targetting runtime, instead of compile time.

When posting my series, I was not aware of all the introspection aspect, 
and simply was focused on qemu monitor commands which are registered, so 
thanks for bringing this.

After looking at schema introspection code, I think it will not be hard 
to expose parts based on a runtime check.

> Most of the time libvirt adapts by changing the way we "probe the data",
> but in this case its about adapting to the way we "probe data about the
> data".
> 
> This kind of problem is why I liked the previous idea that Phillippe
> was trying of introducing a "qemu-system-any" - it didn't affect the
> behaviour of existing qemu-system-$TARGET commands, so apps had a
> clean line in the sand between old & new behaviour.
>

It's something we might talk about later for sure.
On this thread, if possible, I would like to avoid starting talking 
about the new binary, new command line, new monitor schema, as they are 
a different topic, and I'm sure people will have a lot of different 
opinions, which won't solve the current issue of compiling QAPI 
generated code only once.

> With regards,
> Daniel



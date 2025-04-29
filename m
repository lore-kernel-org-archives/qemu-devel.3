Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF8EC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9hNs-0008EG-NE; Tue, 29 Apr 2025 05:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9hNf-00088X-4a
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:36:01 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9hNc-0007DR-Qn
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:35:58 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso3787897f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 02:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745919354; x=1746524154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=czKdHykIUPMPVXOHxR/V1K6YtgHNE26sellefitDTlw=;
 b=JO53NcaXKU/Meu4+QKZIbaSiJocqVNILBaeUPzEVFcplNAr8upR3WLN7Lj2awWnFuh
 PKllQNa409w0UnJ7RWBJt0k0g4ojymIzhHAShWyu1MKAnFa9tZG1U5aioaT1JnS9OxpN
 lhFvTjHLcbwOfHyaOKqiPMzWRU9NnpTpu1rcXY2wjs6u5kHFg5M3FXA8WIsfddXx4ozi
 Q1kanLtQOX1jNhbeEdbKdNOiYmuDf2ox7Yfn+9yVfins+KwujnhsFrtAzqfI5r03bvIp
 Jca/PABbUTTPVozwUH2Uq/QSFcqHHhO2BDW/8kP1MB8O82p+9QXC4J7wtPm0Zw4R57/F
 9UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745919354; x=1746524154;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=czKdHykIUPMPVXOHxR/V1K6YtgHNE26sellefitDTlw=;
 b=WC3k2ytxYh8EP+aYkfhxfOAH1DDTo3kWrK8BH2iChgQO48Z0WSsKYJPHrFETb735+S
 MV0yU/ec3OMeIIKtp9HyX+PweF1PWU0rHOhXD8RXNWcbuUrJBEp+5VI0tL/wkxyUBIh2
 8fJ0SecohzMgGtSKbjeu8BISff90ZdpdPJikqegKHbOVKn8SuFsVZl0R7Qg4CmIkoOc9
 yocIiZh9O82EfT20DL0A5x8z1naGW0TfWwq0ZSSFiWwTR/CV221bHaZ/OjVCovb2hILy
 jCHQLPmyQRDDH8L8KgOtSxRPhD9XBfcLQ3SW5BJ9uosFI+GGNye46DNS6yHNzfGPDwH0
 Tlwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7c0DZG3gAfGqS9SNiQ5c3HYD0cvYWeKH9gQ46aL9qKCfkxjhLxOdKzmv6tARmM7I/q5D+AUlDTkBp@nongnu.org
X-Gm-Message-State: AOJu0YwumlrZcfSZOCK+fyFAVgAZStdkkkAppPgzI1+yRzN11r6pfABX
 h9gLzd/RvpCWwaZOzXfknnKMVwdInZfcqDh1LMWceHlDlyn9+GmgmpTKGnQpQ9A=
X-Gm-Gg: ASbGncu33uQ0ZvV75pGqs+Cz2HyR+5mvvQ0EF881R1svNlB9D5dxXRq+XrFfBUD2zLj
 ndQnv6dS/fL1bWfJAU4PRjkNgccWAllgYdUoRX//djuIYlQzPFeUEkF3Jpvx2qjFfrWVSdX0KGZ
 +fJCtXhIfuXuECMJMLTGxCKeX64lUsfLMR32nKVFXTsNPiK3Qizu1qeNqA3XRov5jhFP8PYZOSE
 Aq95ulAHZd4Ti2gp09TSwTkeGR/ity/t3D+FG8fcmD3kBvksdHJvJr4wtay54FhSSlWzuuZg77x
 lHD1w/T1EzgnALtn78GoRcZerx71q53KwRE0pCeZDYYPzGezW+GXNOWfUegbsM3Rj7qihNh42Xp
 kxXj7c2r/Umic8w==
X-Google-Smtp-Source: AGHT+IE1gJ3w5s5J11X0B67/SotMpA946SLm1aD9TQYCs/VmjypAENhrN+Obz4eZsmNDv6fUai0Uig==
X-Received: by 2002:a05:6000:18a3:b0:39c:266b:feec with SMTP id
 ffacd0b85a97d-3a08a5156acmr1816233f8f.7.1745919353856; 
 Tue, 29 Apr 2025 02:35:53 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e461bfsm13576779f8f.79.2025.04.29.02.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 02:35:53 -0700 (PDT)
Message-ID: <ae321f41-9405-4a6a-915e-969303c08d9b@linaro.org>
Date: Tue, 29 Apr 2025 11:35:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
To: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org> <aA9ChuXrkmx1Igy5@angien.pipo.sk>
 <8734dswnm3.fsf@pond.sub.org>
 <2cc27344-8cfd-4435-9d41-79b86f61d537@linaro.org>
 <875xinnzok.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <875xinnzok.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 29/4/25 10:23, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 4/28/25 4:07 AM, Markus Armbruster wrote:
>>> Peter Krempa <pkrempa@redhat.com> writes:
>>>
>>>> So what should libvirt do once multiple targets are supported?
>>>>
>>>> How do we query CPUs for each of the supported targets?
>>>>
>>
>> It's kind of a similar question we have to solve now with QEMU code.
>> What happens when a symbol is duplicated, and available only for several
>> targets?
>>
>> In this case, we found various approaches to solve this:
>> - unify this symbol for all targets (single implementation)
>> - unify all targets to provide this symbol (multiple impl, all targets)
>> - rename symbols adding {arch} suffix, so it's disambiguated by name
>> - create a proper interface which an available function (multiple impl,
>> selective targets)
>>
>> In the case of query-cpu-definitions, my intuition is that we want to
>> have a single implementation, and that we return *all* the cpus, merging
>> all architectures. In the end, we (and libvirt also) should think out of
>> the "target" box. It's an implementation detail, based on the fact QEMU
>> had 'targets' associated to various binaries for a long time and not a
>> concept that should leak into all consumers.
>>
>>>> Will the result be the same if we query them one at a time or all at
>>>> once?
>>>
>>> Pierrick's stated goal is to have no noticable differences between the
>>> single binary and the qemu-system-<target> it covers.  This is obviously
>>> impossible if we can interact with the single binary before the target
>>> is fixed.
>>>
>>
>> Right.
>> At this point, we can guarantee the target will be fixed before anything
>> else, at the start of main(). It's obviously an implementation choice,
>> but to be honest, I don't see what we would gain from having a "null"
>> default QEMU target, unable to emulate anything.
>>
>>>>> This requires fixing the target before introspection.  Unless this is
>>>>> somehow completely transparent (wrapper scripts, or awful hacks based on
>>>>> the binary's filename, perhaps), management applications may have to be
>>>>> adjusted to actually do that.
>>>>
>>>> As noted filename will not work. Users can specify any filename and
>>>> create override scripts or rename the binary.
>>>
>>> True.
>>>
>>
>> I would prefer to not open this pandora box on this thread, but don't
>> worry, the best will be done to support all those cases, including
>> renaming the binary, allowing any prefix, suffix, as long as name stays
>> unambiguous. If you rename it to qemu-ok, how can you expect anything?
>>
>> We can provide the possibility to have a "default" target set at compile
>> time, for distributors creating their own specific QEMU binaries. But in
>> the context of classical software distribution, it doesn't make any sense.
> 
> I don't wish to derail this thread, but we've been dancing around the
> question of how to best fix the target for some time.  I think we should
> talk about it for real.
> 
> Mind, this is not an objection to your larger "single binary" idea.  It
> could be only if it was an intractable problem, but I don't think it is.
> 
> You want the single binary you're trying to create to be a drop-in
> replacement for per-target binaries.
> 
> "Drop-in replacement" means existing usage continues to work.
> Additional interfaces are not a problem.
> 
> To achieve "drop-in replacement", the target needs to be fixed
> automatically, and before the management application can further
> interact with it.
> 
> If I understand you correctly, you're proposing to use argv[0] for that,
> roughly like this: assume it's qemu-system-<target>, extract <target>
> first thing in main(), done.
> 
> What if it's not named that way?  If I understand you correctly, you're
> proposing to fall back to a compiled-in default target.
> 
> I don't think this is going to fly.

Rather than using non-constant argv[0] Pierrick suggested to add a
single CLI option '-target' which selects the corresponding TargetInfo
structure to use at runtime. I.e. for ARM:

https://lore.kernel.org/qemu-devel/20250424222112.36194-12-philmd@linaro.org/

For distros qemu-system-arm could be a shell script prepending
'-target arm' while passing the arguments calling qemu-system.

If a distro wants to name a binary 'qemu-kvm' it can drop the
-target option and hard-wire its target_info() to a distro-specific
TargetInfo implementation, or &target_info_x86_64_system.

> Developers rename the binary all the time, and expect this not to change
> behavior.  For instance, I routinely rename qemu-FOO to qemu-FOO.old or
> qemu-FOO.COMMIT-HASH to let me compare behavior easily.
> 
> We could relax the assumption to support such renames.  Developers then
> need to be aware of what renames are supported.  Meh.
> 
> The more we relax the pattern, the likelier surprising behavior becomes.
> 
> We could mitigate surprises by eliminating the built-in default target.
> 
> Users invoke their binaries with their own names, too.  If Joe R. User
> finds qemu-system-<joe's-fav-target> too much to type, and creates a
> symlink named q to it, more power to him!
> 
> Distributions have packaged renamed binaries.  qemu-kvm has been used
> quite widely.
> 
> In neither of these cases, relaxing the pattern helps.
> 
> The least bad solution I can see so far is a new option -target.

Ah! Same same.

> Instead of turning the target-specific binaries into links to / copies
> of the single binary, they become wrappers that pass -target as the
> first option.  We need to make sure this option is honored in time then,
> which should be easy enough.
> 
> If you invoke the single binary directly, you need to pass -target
> yourself.  If you don't to pass it, or pass it late in the command line,
> you open up a window for interaction with indeterminate target.
> Target-specific interfaces could exhibit different behavior then, even
> fail.  That's fine under "additional interfaces are not a problem".
> 
> Thoughts?
> 



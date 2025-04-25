Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F75C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 20:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ppz-0005G2-Fg; Fri, 25 Apr 2025 16:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Ppy-0005Fd-9p
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 16:39:54 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Ppw-0007f1-H0
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 16:39:54 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so2469647b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745613591; x=1746218391; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q9u2eoLswASmcq2xubil6640JsrFqzaCMKFKNu72eC0=;
 b=rFkNAlUXMWeoA5S1rKi8NKGiSjSXPRuE8mlKNTTOX0TBP4+fDMVXNdZ6RaR7Wx6hBi
 K0xu4fZmgOd5kl269oTLr/MXh5m+V+5b51mKPPMs246DlD3WBn8r1vls1IXN6CmDXt+K
 IPW3H+OmsmewQOqMRk//5SgjSOhWA/cVpScWDMQ9z4+SfuZirApdZPMTtuPrguYNy0cJ
 uv/lTwndByjiOgYr8GUU8OkLo2bVY40XRwb25K+OxhzwM92uxm5ntf50sCxmjUeb8rGo
 THEyl5jyL0fDU7uW7a4RXkyst9j+r6QmIyzEv1V5FY7zWLImc8WdicVxq/tOkTD937Or
 mv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745613591; x=1746218391;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q9u2eoLswASmcq2xubil6640JsrFqzaCMKFKNu72eC0=;
 b=mHVu/JQEnbBZEsZf4loinoE6YFoS2XyLhuMZp4YBy5fip6E83p73Q9WFwVM0vOB1fW
 FMShgMvVZolaxcyqKJgVk8O4RGhIyIwHy5SDh3iuaU5DpMRjdgvjqu/9f0/Oxd2IUKSR
 dnqyg3ricGRHnfVBFWreloWQ2eftlxaePSsY+GFklncTF/Up6naFfEvj4VQ4xxxYBARB
 y4G53OVAMv57IqkB3NPMZV3FDTYPK5vdRvJewSSoXGmAsTfuBife8/6NE1ZS+XKpzyNP
 9wzHOByqBeXyQ49p/CYOx+1nERmw1U3EsHwcrtYR6hRYyk4n/mhk2bx4hzznrlp3GH+w
 00gg==
X-Gm-Message-State: AOJu0YwLvYXNDrwS5LOlmkBYw593eDury2xKu11s/xEASyv4oZMDgogg
 eHStAF3La71YV1HYOqB7EULUqDHQnd7QBv6+/rTOrH9n0me8mCc/ACM0AGi4Sxk=
X-Gm-Gg: ASbGnctr2QOW+bDvMBajUU5AEpcg4fTCx610X0v3mLVHJ/zA7TBOo85T+2QDVfvukBI
 bMJfZs4R2pWKzRayCgrtuIQo8XZweSmizWijrsbGPVsgf5M1aq8u+Dq3dBRcCxQWjbIkwveI1ft
 Z1wMWThQUOH+XuqMozYseiXERAS5/mbm+cXLOgzTCAoftiwuoPcD1tijiOwfW+p7AGhTRZMPgEa
 vNGdDY/QkXgN15SnUoeTlP77rlFDWqAk4CFwl0+fupKB6do1jdb0J/Q+VveKM+L8s0V+Dh8z60V
 li6YzavrnEAKrPtXK59tAgktOBx0OVHVObjqwnQqR3gZ08brWVXrgA==
X-Google-Smtp-Source: AGHT+IHK5yI/buzQOZOOJmcEQL0NHageFWvYageHRmcIsDkwuCBzYDY4l1Zoimv0F0ULiZ6pwV2gDQ==
X-Received: by 2002:a05:6a00:3e12:b0:736:32d2:aa82 with SMTP id
 d2e1a72fcca58-73fd8e548b8mr4646752b3a.23.1745613590990; 
 Fri, 25 Apr 2025 13:39:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e2593f4c4sm3660838b3a.37.2025.04.25.13.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 13:39:50 -0700 (PDT)
Message-ID: <65639a73-c6d7-472f-8788-69341f93760d@linaro.org>
Date: Fri, 25 Apr 2025 13:39:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com,
 philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <aAs6Q2GiBUbUCc2I@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aAs6Q2GiBUbUCc2I@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 4/25/25 00:35, Daniel P. Berrangé wrote:
> On Thu, Apr 24, 2025 at 11:33:47AM -0700, Pierrick Bouvier wrote:
>> Feedback
>> ========
>>
>> The goal of this series is to be spark a conversation around following topics:
>>
>> - Would you be open to such an approach? (expose all code, and restrict commands
>>    registered at runtime only for specific targets)
> 
> QMP defines a public API between QEMU and external mgmt apps, and personally I
> like the idea that the API exposed is identical across all binaries and thus
> the API becomes independent of the impl choice of combined vs separate binaries,.
>
>> - Are there unexpected consequences for libvirt or other consumers to expose
>>    more definitions than what we have now?
> 
> QEMU used the selective hiding of commands in the QMP schema as a mechanism
> to allow mgmt apps to probe for supported features. We need to check usage
> of each QMP API feature that's behind a TARGET_* condition and identify
> which libvirt uses as a feature probe, then come up with a strategy for how
> best to handle each case in libvirt in future. We might need some additional
> runtime mechanism to probe for certain things, but we won't know until we
> look at things in more detail.
>

Could we consider to hide the concerned commands from introspection 
related commands as well? The same way we prevent those commands to be 
registered, we can probably prevent them from being visible for libvirt.
The code would still be there, and compiled once, but based on runtime 
target_X() value, it would not appear in introspected schema.

I'm not sure how all this is implemented from QAPI code generator, maybe 
it's hard to do something like this, if we build the schema at compile 
time for instance.

>> - Would you recommend another approach instead? I experimented with having per
>>    target generated files, but we still need to expose quite a lot in headers, so
>>    my opinion is that it's much more complicated for zero benefit. As well, the
>>    code size impact is more than negligible, so the simpler, the better.
> 
> IMHO it is unfortunate that the API we currently expose has a dependency on
> a specific impl choice that mgmt apps are expected to rely on for feature
> probing. An ideal API design is not so closely coupled to impl choice
> (separate vs combined binaries), and would expose enough functionality
> such that mgmt apps continue to work regardless of the impl choices.
> 

At this point, do we know which kind of "feature" gets probed? Is it 
only the list of commands available, or is there probes based on 
enum/struct definition?
If yes, the latter seems to be a wrong way to identify a target, when it 
could simply use query-target.

> We thought the conditionals were a good thing when we first designed QMP
> this way. We ended up using two distinct classes of conditionals, one
> reflecting build time features and one reflecting which target binary is
> used. I don't think we fully contemplated the implications that the latter
> set of conditionals would have on our ability to change our impl approach
> in future. I think the proposal here is taking us in a good direction
> given what we now know.
>

Thanks for considering an alternative way given the new needs, that's 
appreciated.

Would that possible to get some help from people from libvirt or QAPI 
developers for this?

> With regards,
> Daniel

Thanks,
Pierrick


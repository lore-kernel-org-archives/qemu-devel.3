Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBD0E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 19:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNzbB-0004Ly-PY; Wed, 18 Dec 2024 14:20:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNzb6-0004Hx-0f
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:20:42 -0500
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNzb0-00026Z-4V
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:20:39 -0500
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d900c27af7so104376d6.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734549630; x=1735154430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nTUiuF3k2d2jxVfM6MZEHkcGik4j8tVWuN7Zhk3p8T0=;
 b=XGJ6YbA80CnVynzSIh4XgGlc0QMjfsbLNndmLyaU9TGgnM9s9g8RR3SX4b54za9Gk/
 Y/imEqqcEcHJvOF0S9l5SttwjTY4Hc5KzsyudfQF3x2Lc2TtvukV8eFvDoiAm3re5YBw
 8b7J3PDi8uowKnEzukKF3+K6go3ULbBHfo/tVBTX6G2r5EyrtHzei39PRyMhBk1JUj9s
 kZYaQcRwCZmdUq4Rg4evv1eFXoL/vD+JcQKJgEWvW7jfsNxLlKlni6JM/fzsx6drotR5
 SDsrd1P/3F+9l3wyatCyw8cNh21eiokKR9Z7vvXue6XhkzoPUUxbO3kHiSX4L5eDvqEk
 2vsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734549630; x=1735154430;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nTUiuF3k2d2jxVfM6MZEHkcGik4j8tVWuN7Zhk3p8T0=;
 b=CRZMtNoWZULl8f7wTQIqZ/czHakm0x0Uk9TtbEfeB597AGPjxka6wSLNJINd6TFOe+
 IoDczQlI+HHkVMQhwbuM8t8ItoHglKZ02z5wqAXykNlgelcpaC6JIa+q3iUR9oVSUOJ9
 9xpl+JuB0xXBDz+k4dPIIvYAmDUHSY+A12yff0VgogvLl2gheTjV5j7pB8ZKp1UrE2Q/
 qp2ghV2wZNgBpvPtDZkvxcAS8r+c6wWEdAHdprqGyZt7aki9xsDg6glN2CRSWNU4qtFM
 LsC0hYiPJHWGTS8Z25gemO4FeLZFGclsyrMkqyXkFqAtiGyOsS0KSflK/3tHHWWyEcP8
 W00g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9n0Obm7hv19RyVcF1ipDKis1SfZm1LBrM43kazU4mvh3oOVkZtvM3XfEmkI6T7GmsHvIMpjI4ls8x@nongnu.org
X-Gm-Message-State: AOJu0Yz1ss3a77H9vdMnihTCb/P3GAPXSgz5fAC/hel2VoYPJJGGa0de
 8+Q2bVwUt6hZUR0cWJ41GNqE+On7ueG4iLLh/tDv1UnD2q8IY+639T0nRzCB0GM=
X-Gm-Gg: ASbGnctC0XVulS9FfCY7hZWNWvvGYBvmLF5pa75p+JL6iimQ1qpG+aDcNnJccPOpNR5
 eBYZGmfgQtJA2Jyoly4TnzaRLe6rxgArfN1/Z34KdUkBQhKbsujUmW9B/ICe2Vsn4rA7IyujATx
 ywREhPLsuVrwu0sHp2ILSIK2ke4VsLuQ4lQela59s5BxWJ2vG7rq74BHQ0613PnqTq4pqZ0f+OK
 067nBQUh8Uvs2/zI3+Fo6GdfqYH8XaxIZsevWTL2am0H2VLdoBVFYcDWx840JGoKhFyrlVUUQ==
X-Google-Smtp-Source: AGHT+IFA02C79hInfKdrhXEk7KDC+KY+dUmLdo3XjPpyExppEQldcQ7ppDmxT5TO0bQQ2xEIY/VBYw==
X-Received: by 2002:a05:6214:1308:b0:6d8:9124:878d with SMTP id
 6a1803df08f44-6dd0918de68mr81083506d6.2.1734549629705; 
 Wed, 18 Dec 2024 11:20:29 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd363121sm53399886d6.89.2024.12.18.11.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 11:20:29 -0800 (PST)
Message-ID: <f2bdc8f2-5735-400c-b15f-06289b467826@linaro.org>
Date: Wed, 18 Dec 2024 13:20:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Change default pointer authentication algorithm on
 aarch64 to impdef
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-arm@nongnu.org
References: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
 <7cd98960-0c0d-481f-96ea-08e0578d5cad@linaro.org>
 <b0962854-65c3-47d0-8f0a-072fdf51e7b6@linaro.org>
 <6e29d9cb-1c67-4fdc-97f1-32c90bed1048@linaro.org>
 <19df9957-6653-4086-aa1f-07263efcddde@linaro.org>
 <87pllq69l6.fsf@draig.linaro.org>
 <CAFEAcA_xe5QEPsrByM8ems_rxt-KsVRAgkKhGk24X-1J0vcCDA@mail.gmail.com>
 <75ff92e0-7384-4af4-bc9f-64a6b0febc9f@linaro.org>
 <CAFEAcA8YNcft8KU8mytHv+H71L7L8d=QBgQmSAmq9J7Ny23=tA@mail.gmail.com>
 <48dd3afc-d78d-4bd9-9392-873d5a8ac26a@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <48dd3afc-d78d-4bd9-9392-873d5a8ac26a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf29.google.com
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

On 12/18/24 13:08, Pierrick Bouvier wrote:
> On 12/18/24 05:51, Peter Maydell wrote:
>> On Tue, 17 Dec 2024 at 21:08, Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>>
>>> On 12/17/24 02:38, Peter Maydell wrote:
>>>> On Tue, 17 Dec 2024 at 07:40, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>>>
>>>>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>>>>> I think this is still a change worth to do, because people can get a
>>>>>> 100% speedup with this simple change, and it's a better default than
>>>>>> the previous value.
>>>>>> In more, in case of this migration scenario, QEMU will immediately
>>>>>> abort upon accessing memory through a pointer.
>>>>>>
>>>>>> I'm not sure about what would be the best way to make this change as
>>>>>> smooth as possible for QEMU users.
>>>>>
>>>>> Surely we can only honour and apply the new default to -cpu max?
>>>>
>>>
>>> With all my respect, I think the current default is wrong, and it would
>>> be sad to keep it when people don't precise cpu max, or for other cpus
>>> enabling pointer authentication.
>>>
>>> In all our conversations, there seems to be a focus on choosing the
>>> "fastest" emulation solution that satisfies the guest (behaviour wise).
>>> And, for a reason I ignore, pointer authentication escaped this rule.
>>
>> I think the reason is just that we didn't understand how much
>> of a performance hit the architected algorithm for pointer auth
>> is in emulation. So we took our default approach of "implement
>> what the architecture says". Then later when we realised how
>> bad the effect was we added in a faster impdef authentication
>> algorithm, but we put it in as not-the-default because of our
>> usual bias towards "don't change existing behaviour".
>>
> 
> I understand the reason behind the current choice.
> For my personal knowledge, is there a QEMU policy for "breaking changes"?
> 
>>> I understand the concern regarding retro compatibility, but it would be
>>> better to ask politely (with an error message) to people to restart
>>> their virtual machines when they try to migrate, instead of being stuck
>>> with a slow default forever.
>>> In more, we are talking of a tcg scenario, for which I'm not sure people
>>> use migration feature (save/restore) heavily, but I may be wrong on this.
>>>
>>> Between the risk of breaking migration (with a polite error message),
>>> and having a default that is 100% faster, I think it would be better to
>>> favor the second one. If it would be a 5% speedup, I would not argue,
>>> but slowing down execution with a factor of 2 is really a lot.
>>
>> The point here about "breaking migration" is that we have a strong
>> set of rules:
>>   * if you say "-machine virt-8.2" you get "exactly the behaviour
>>     that the 'virt' machine type had in QEMU 8.2, and it is
>>     migration compatible
>>   * we can make changes that are not migration compatible only if we
>>     ensure that they are not applied to older versioned machine types
>>     (or if they're to devices that are only used in machines which
>>     do not have versioned machine types at all)
>>   * TCG '-cpu max' is a special case: it is not a fixed thing, and so
>>     it may acquire new non-migration-compatible changes between versions
>>     (and so if you care about VM migration compat you don't use it);
>>     but this is not true of the named CPU types that match real
>>     hardware implementations
>>
>> This patch as it stands will not preserve the migration
>> guarantees that we make. So we need to fix it by either:
>>   * only making the default change on -cpu max
>>   * making the default change be bound to versioned types
>>
> 
> I'm not sure to follow you on this second approach. The cpu is not versioned, and if 
> someone use -machine virt (non versioned), is there a guarantee it should stay possible to 
> migrate?
> 
> In other words, can we break the migration with "-machine virt -cpu model"?

Yes, because "virt" is an alias for "virt-<current>".
Folks who rely on migration compatibility must use "virt-9.2" etc.

Thus having a global property set by version 9.2 compat which says "use qarma5 as default 
pac" will work.  It's a little backward having the version on the board, not the cpu, but 
we've done it before, as Peter mentioned re cpu clock time base.


r~


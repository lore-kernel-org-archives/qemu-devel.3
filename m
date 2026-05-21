Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0799CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwxb-00065S-EO; Thu, 21 May 2026 02:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwxY-00064p-Eh
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:32:45 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwxD-0003Gl-8y
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:32:43 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b150559bso43488785e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 23:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779345001; x=1779949801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oBUirO0zba4eTftW0d+Nzlkqf068v6j5LHzC2DorEec=;
 b=DbyiSlOnGyY9XHPAW2vCCO+5fqLeFxbEnJWXN6f/3LQyp0p06e1jeKNpp5WC5JxIVu
 4QWhnhisVH1cx0XztEd0/oEvmdYTVgidp3g911+91YrONGjdYQy1YKvRkFHPY1aWxRdx
 eo5pT+h9S+tbxGzmcqRq3TPApmM9KFfmR4c7Mfj7jeTx9638fZtCrglxJmH32+/PJGhc
 xb7jcTeY1oxeO53j4rR7CQjOGlYSqCODeYi0/8EjO8WAa5zds6zmzlLzMVcY1DzB/Rv6
 IjEQkcz0QY2zKCkTxPyvrZ52lJsBjpiLkcXqa8c1+BurlGPsOVUXYdkAUaaz2VtigGFX
 WEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779345001; x=1779949801;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oBUirO0zba4eTftW0d+Nzlkqf068v6j5LHzC2DorEec=;
 b=qTA/lUMUYswLAhrZ9ErOfYN6XFwO7nLglkA+V2EZ5GbTDIdIMS1Z+tAA4DXHZdHPq/
 RCkQE1WDc8FO3ya4SMT8XssMtV3V42ayMEPrygoNc9mtdhL1Jkqo9Adc03/t5DeaqwcC
 slZXF5qvP56Ms9bRB/SEkGJYiJILcjtCB46vTbYCiUzGOrHRyDsLcap3b20Drg2n5QjB
 a8ydB66buVDDsqVUqCNzLElN9sDyTAMnv8cua1UfQznITfFTDGEmJgzrRcL7SJZJF/2I
 +hsPljKInC7CHQ6ghdXjZCBZUh2EfYST7lN6Kn6KIkzq6zh+GbpJQtVfvTMSNCjXsfl5
 YFwA==
X-Gm-Message-State: AOJu0Yzani1886fp9tVqvajCRUYie41d7hPwQiTxt9p+blAT5ZAfCdh7
 s9BqJF5xJhJExgMi4re4evqJ7nyHMDUXvi7375RY3ocJFX0QwLdAPxHSzyPkACUPyTc=
X-Gm-Gg: Acq92OHPkHdG3EfEGaBlLjyoX9bU5Mq3sCeqCgj3QluxExDmoc4yT80veJSOBIA0Mt5
 VCLiiTVI0eun30Nc7TH+8d8pbSVRFPBBryOVjsUZaHoIpieDBjd4SjJiEZDRYsvCJy70hHuHz/1
 yKDAWIA1dIEVRVt8aiN++xJFqV6oUXldNqyENEHN+O/dUAZ2oIL14YC8ylqYMrotS3SoRuZnsQy
 +tGaqlDS0w5OCN+EdhNbXIn0LIVa3xWWIeDELEwrlLOcfclRLGramAmqu2omd4qYdVCBT99JnDo
 fAvbYRev+zKoBzkaVTB+gjIFGd9aO8VWMbiYMrVBpKkGdmK8Z8BHtrR68jjgLF7oat3rGo8IPg3
 sSFmjgPuNsxm/Y+QvgBcXLePbGZczEIwye8reM71q//6gr4m0ZX3tIZqGMRJtguc/jQz66aYDlQ
 NndWx6KR9MNH2Zfh84qJg1HdDg2uuTQBJIGSMF7fANEUc43dXyGwwXet51jRtw5aex2Grq2hLn6
 aSt
X-Received: by 2002:a05:600c:c086:b0:48a:7676:30bc with SMTP id
 5b1f17b1804b1-4903606bad7mr13723165e9.14.1779345001481; 
 Wed, 20 May 2026 23:30:01 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d3514esm47283925e9.3.2026.05.20.23.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 23:30:00 -0700 (PDT)
Message-ID: <a49a5a8c-5a1b-4d1e-886c-35b3c983bfa5@linaro.org>
Date: Thu, 21 May 2026 08:29:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailmap: Remove PhilMD redirect entries
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260520195206.40679-1-philmd@linaro.org>
 <CAAjaMXZMKbah6TrvSA2qy7ofp-eVyvuVxyOLo=-T+VaKcJc7Hw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAjaMXZMKbah6TrvSA2qy7ofp-eVyvuVxyOLo=-T+VaKcJc7Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 21/5/26 08:20, Manos Pitsidianakis wrote:
> On Wed, May 20, 2026 at 10:52 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> Our ./scripts/get_maintainer.pl uses git .mailmap as a fallback:
>>
>>    $ ./scripts/get_maintainer.pl -h
>>    usage: ./scripts/get_maintainer.pl [options] patchfile
>>           ./scripts/get_maintainer.pl [options] -f file|directory
>>
>>      --git-fallback => use git when no exact MAINTAINERS pattern (default: 1)
>>      --git-since => git history to use (default: 1-year-ago)
>>      --mailmap => use .mailmap file (default: 1)
>>      ...
>>
>>    Default options:
>>      [--email --nogit --git-fallback --m --r --n --l --multiline
>>       --pattern-depth=0 --remove-duplicates --rolestats]
>>
>> (see the '--git-fallback' used as default option).
>>
>> Per gitmailmap(5) man page:
>>
>>    ... the file .mailmap [...] is used to map author and
>>    committer names and email addresses to canonical real
>>    names and email addresses.
>>
>> I added my entries in the "replace old addresses by a more recent
>> one" section for this script use case, but we have been doing a
>> good cleanup at having all files covered in MAINTAINERS, so with
>> retrospective these entries aren't needed anymore (besides, using
>> them retroactively credits all my contributions to the latest
>> employer).
>>
> 
> 
> Hey Philippe,
> 
> As I posted here
> https://lore.kernel.org/qemu-devel/3104a00e-4c13-4bf7-95a0-1f2840bec50d@linaro.org/T/#t
> 
>> People who wish to use git log for employer attribution reasons must
>> use --no-mailmap.
> 
> mailmap is for updating names/emails, not attribution. I do not think
> your patch is necessary.

Great, thank you for mentioning the --no-mailmap option.

Markus, Alex, does that option work for you?

> 
>> Simply remove my mappings of that "old -> recent" section.
>>
>> Reported-by: Markus Armbruster <armbru@redhat.com>
>> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   .mailmap | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/.mailmap b/.mailmap
>> index ce569d83f4a..82ff20b8ddb 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -104,9 +104,6 @@ Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
>>   Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
>>   Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
>>   Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
>> -Philippe Mathieu-Daudé <philmd@linaro.org> <f4bug@amsat.org>
>> -Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@redhat.com>
>> -Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@fungible.com>
>>   Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> <pierrick.bouvier@linaro.org>
>>   Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
>>   Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
>> --
>> 2.53.0
>>
>>
> 



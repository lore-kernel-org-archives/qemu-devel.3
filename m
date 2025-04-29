Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74549C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9hRb-0002Tq-2Q; Tue, 29 Apr 2025 05:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9hRW-0002Os-Ko
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:39:59 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9hRT-0007wW-KM
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:39:57 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so5232631f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 02:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745919594; x=1746524394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wvRSl08vrPkiVhfSodDNieFZmm3u7ia53uuUag83Fhc=;
 b=HM/gb29BAp5vdzh7zaK1BhLOtlV0enwIRcID45uo7d4inkx547/o6m23nZPTN0lbGo
 leGgiEmviPYXDmdrM3zIEwStYksPy84CVQ/sKGCasqP+CDzAyXSHzTuIWEcWeBDYF5ZC
 mvGsMIANSlU03pj3ZFJjZhxrC6XrQ3Wd/cz3MJk8ut1LN4hB/xx3lj/e3bEOSTnMMeHJ
 m9/ZyqRTOw0sE5It3n1N4tLSZmok1R/kROuWeW96D0bfKVcltwcun0iIeUNcLK98EHS4
 UtljSIVxWlClfJO8zu07i7AT/7t818HBblx7bVhHjDDVZu2FJ8PWs61mkaFSWbF5gNbX
 fLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745919594; x=1746524394;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wvRSl08vrPkiVhfSodDNieFZmm3u7ia53uuUag83Fhc=;
 b=D2yV24+z4Ot5V7qtdFkQ0bTujDXOaZzoazH+Yc3nQ3YaaU1iQayAxapIxLfv6Z2yQU
 0lb4E041hZ1EqmnF3mGBIWk1A0nUCvv5a9KtZw9AsUghy2KBA9/3q7gLeJRfHV3qUqwp
 pVRialY3HHm77iIs/SNwsIdIX2cia7db+LRf3YwM+2VykzM99U11QTJOnC5fnlX5LVY8
 9Bi7ylql/PSN8/T6rj27Mjl078Mno2zPByQOnEHmIwjexLfqgNHYG3UMH2fTWkkPNqQW
 7AodFWKFpJUF70bMWDCCKTq2qfnF9DO0x5NxM7EP8gKc+kEM3/GRYoWvXDLJQL4YVxAE
 jsiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjpYlWfjbWetpvYcFP2+8X5JAKEgFpl37nzMRTrZcEThF6o6Lk3KGNclcte8LvctBTJARZ2U5ycUW6@nongnu.org
X-Gm-Message-State: AOJu0YwQi9bKXF1ZH3/FntaatRLtVw+uEzIjS7aOT/SloxBULcnX5kPS
 Jit19PlY7KTdkT1WipcloCcS8CZvG9mnX0o8ANqAfTYAbOzmy8MyKHqAjjPNOGY=
X-Gm-Gg: ASbGnctwGFmca+S8l+H9FzD00DxB+JnPU9Bey02LL/AZ4XZTzYerDOAfOjLsEO82by+
 B/jL/OGCJsTykl7OQZSpj1JTh69NSIeGU5+fQpwu6CedXlrrjvV/VqA2IjqYRTGn6RPeeOXNbo8
 t/yEPm8Le6chPYf9nKv/ym+FoJ5XMgE46UDDJs8Qp9xmLKcAigXLAfR3h+YhdRgqlgduSzGVuuN
 V76UHeAA5KeQDIbyAvbGP3mdSq285Kt/2ApMO6+E1ARZsqLs3jVlP8p1tDPpRW3K8EKqbBi0LRX
 JqrsElQloyo0Fj0rmfW8tWyLqi1V9sRwyOj126iW8tzIXICjas4j2rOhtgFk+WCNHlEnOW8NPTg
 9OiPThkvmK4MwcnyTyryVOc+w
X-Google-Smtp-Source: AGHT+IE54naZ7zJclSs2Pbi4fqAx/BE4/A+nQO98LvQ/2oAsCJty9uet3kSNaSCPFdT9omFw83hHPA==
X-Received: by 2002:a5d:5110:0:b0:39e:f89b:85ce with SMTP id
 ffacd0b85a97d-3a07aa6fd2fmr7161215f8f.26.1745919592191; 
 Tue, 29 Apr 2025 02:39:52 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e4641csm13306202f8f.80.2025.04.29.02.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 02:39:51 -0700 (PDT)
Message-ID: <38743f0b-6f18-4db5-9a2f-ed0320ee3cdc@linaro.org>
Date: Tue, 29 Apr 2025 11:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, jsnow@redhat.com,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org> <aA9ChuXrkmx1Igy5@angien.pipo.sk>
 <8734dswnm3.fsf@pond.sub.org>
 <2cc27344-8cfd-4435-9d41-79b86f61d537@linaro.org>
 <875xinnzok.fsf@pond.sub.org>
 <3024f643-f4df-4342-8d9f-d5929e3ec2e5@redhat.com>
 <aBCcrJxQTOFKoeJQ@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aBCcrJxQTOFKoeJQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 29/4/25 11:32, Daniel P. Berrangé wrote:
> On Tue, Apr 29, 2025 at 11:20:59AM +0200, Thomas Huth via Devel wrote:
>> On 29/04/2025 10.23, Markus Armbruster wrote:
>> ...
>>> I don't wish to derail this thread, but we've been dancing around the
>>> question of how to best fix the target for some time.  I think we should
>>> talk about it for real.
>>>
>>> Mind, this is not an objection to your larger "single binary" idea.  It
>>> could be only if it was an intractable problem, but I don't think it is.
>>>
>>> You want the single binary you're trying to create to be a drop-in
>>> replacement for per-target binaries.
>>>
>>> "Drop-in replacement" means existing usage continues to work.
>>> Additional interfaces are not a problem.
>>>
>>> To achieve "drop-in replacement", the target needs to be fixed
>>> automatically, and before the management application can further
>>> interact with it.
>>>
>>> If I understand you correctly, you're proposing to use argv[0] for that,
>>> roughly like this: assume it's qemu-system-<target>, extract <target>
>>> first thing in main(), done.
>>>
>>> What if it's not named that way?  If I understand you correctly, you're
>>> proposing to fall back to a compiled-in default target.
>>>
>>> I don't think this is going to fly.
>>
>> I tend to disagree. For normal users that consume QEMU via the distros, the
>> check via argv[0] should be good enough. For developers, I think we can
>> assume that they are adaptive enough to use an additional "-target" option
>> in case they mis-named their binary in a bad way.
> 
>>> Developers rename the binary all the time, and expect this not to change
>>> behavior.  For instance, I routinely rename qemu-FOO to qemu-FOO.old or
>>> qemu-FOO.COMMIT-HASH to let me compare behavior easily.
>>
>> Developers should already be aware that this can cause trouble, since e.g.
>> the qtests are deriving the target architecture from the binary name
>> already. See the qtest_get_arch() function.
> 
> Even if we want to allow developers to rename binaries, we don't have to
> allow an arbitrary choice of naming. We could define an accepted pattern
> for naming that people must follow.
> 
> eg we could allow for clearly distinguished suffixes (ie append '-SUFFIX')
> so that
> 
>    qemu-system-x86_64-fishfood
> 
> is acceptable while
> 
>    qemu-system-fishfood
>    qemu-system-x86_64fishfood
> 
> would be an unsupported scenarios.

It is already a pain to parse mips[n32,64][el], microblaze[el],
sparc[32plus,64], ppc[64][le], sh4[eb], xtensa[eb], arm[eb]...


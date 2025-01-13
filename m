Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8A4C02183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 15:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXMmc-0000g6-Pg; Mon, 13 Jan 2025 10:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXMmb-0000fi-7l
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 10:55:17 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXMmZ-0006d3-8L
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 10:55:16 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so2430970f8f.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 07:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736783713; x=1737388513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a8U7m9ho64rxcVlVyworqU4xiEk/RJOayNL9o8tnAuM=;
 b=vxM8jKA897PQXNRqbmeXKeOIcgLiYEAtpApXGnJ6gv5Y7+rSxfLV/YcCNkZn3CPS7d
 s1HzoJx+y7JPM28aP22UrS17oUUgm1/A/cUK/J1DkX5cE0pejLCtUsaUuVNVcRPXbziv
 qjxtW27YMiNfxW9DagetTBeL79gWZuiByddaWmMf2HS5rJexRIZ1NK5sdwRSt67v1yHO
 R7jfi65VKlfP0wVaJ/OMHe67E6+wxY0W1qj4ij6hANcpaqLHUQ9C6tcQNFejPvEseCHl
 Eypqkr3EIo5mE7zPUkieG/bsXFBxgR4XiHff0L1i0QbJzieACgHgqfbDOFai2I84FnqQ
 FFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736783713; x=1737388513;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a8U7m9ho64rxcVlVyworqU4xiEk/RJOayNL9o8tnAuM=;
 b=bBjKa4XsHxtRYLKdGGUAlYNX7+VAixUQ74CoPQEVm31S+VNfjccLPUe/0E//FY9ZaX
 0xBBRvliQbmZEZq8qvHekpRmq50GWHpysii6hc30ud8ptWvUIFEPBWiwBlEuJm7eT53G
 T2jQdGn8c2wbJSa5VTfcEXLcmAb67cuE61XF+P+dT7FCh9lQRTLhDs1Vgr5pNylq9KGs
 SQ2WT3kD+xBhAvOPwArBZLNOIt5SLQLUTLrJCT740FooBQWunCUd7FhThrtTcgdo7r+n
 Jqigvt+VwD/P1IqfW48iZXI2pn03BPpJ2iWqYKu5W2WywhUzCe340jIQ4Xd4BeHoUq/p
 IFpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlUR40hdxMC7A1ZWjVplklk0j41rPDRbXA4bX+j+Lw370bwu6O0vBFngDi6tfT8/EGxl4+lGrmN+QT@nongnu.org
X-Gm-Message-State: AOJu0YyiH+UDvjhEZK7chId6N/w42lgQHB937sEUT1YgWrxb69RmjC6E
 4TYszOYZRHQnYT039OxzJ9y7yv+G3BqtfHiH0Q8My3HWn0wH1nSfisA0DDoC+98=
X-Gm-Gg: ASbGncuJAH4pwiLeshko+O8ZaxSg0UBXv4gi4MZnitbWK8aAhrg6EvXcDoOHL/YclZh
 gnpIayxaxFOeFGKD7bTkEilAcKnbIJu5vFEUJJcJ93Hgk4Ju20nV1vLsTwyOp9kGxP8ygrYznwK
 b+f/Yr4Kb/O5wm+StJ2ZqoRMgfZFeVkukSSd2GJo+x0UDXjDAAS34/7RW39qP/6x42+PPlPTjQL
 qwSQhnWKVz70uNf27Fi7tWU+S3AdqPRvidenAzPXqWFSZCvTewZAXqX13J+2bSZbth9xD5IEDjU
 kIXFuPi9FHbNExAX6GvXLkJr
X-Google-Smtp-Source: AGHT+IGUrbTPV+H8akaYPVBQBDc21MoTbLx7XjXtTWUgEzcDu0s8KHz1lDfM0zMP/kkEwZa5baa/mQ==
X-Received: by 2002:a05:6000:402a:b0:38b:d824:df3 with SMTP id
 ffacd0b85a97d-38bd8240fa6mr3763490f8f.24.1736783713276; 
 Mon, 13 Jan 2025 07:55:13 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1b2asm12174878f8f.89.2025.01.13.07.55.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 07:55:12 -0800 (PST)
Message-ID: <5ff4ff5d-dbba-4d5a-9cba-23f8268ce511@linaro.org>
Date: Mon, 13 Jan 2025 16:55:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Add a b4 configuration file
To: Markus Armbruster <armbru@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250102-b4-config-v2-1-cc7299e399bb@flygoat.com>
 <b7d08568-153c-4a35-9395-214cd8d0a228@linaro.org>
 <87bjwbtdae.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87bjwbtdae.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 13/1/25 07:53, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 2/1/25 23:53, Jiaxun Yang wrote:
>>> b4 [1] is a convenient tool to manage patch series with mailing list
>>> working flow.
>>> Add a project default config file to match QEMU's mailing list conventions
>>> as well as adopting differences on scripting.
>>> Examples of b4:
>>> ```
>>> $ b4 prep --check
>>> Checking patches using:
>>>     scripts/checkpatch.pl -q --terse --no-summary --mailback -
>>> ---
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>> Changes in v2:
>>> - Add lore masks (philmd) from:
>>>     https://lore.kernel.org/qemu-devel/20241224135054.10243-1-philmd@linaro.org/
>>> - Link to v1: https://lore.kernel.org/r/20241222-b4-config-v1-1-b3667beb30a4@flygoat.com
>>> ---
>>> ● cc5a4c890fed: Add a b4 configuration file
>>>     ● checkpatch.pl: 27: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>>> ---
>>> Success: 0, Warning: 1, Error: 0
>>> ```
>>> ```
>>> $ b4 prep -c
>>> Will collect To: addresses using echo
>>> Will collect Cc: addresses using get_maintainer.pl
>>> Collecting To/Cc addresses
>>>       + To: qemu-devel@nongnu.org
>>> ---
>>> You can trim/expand this list with: b4 prep --edit-cover
>>> Invoking git-filter-repo to update the cover letter.
>>> New history written in 0.02 seconds...
>>> Completely finished after 0.06 seconds
>>> ```
>>> [1]: https://b4.docs.kernel.org/
>>> Co-developed-by: Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>>    .b4-config | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>
>> Squashing in order to avoid checkpatch.pl error:
>>
>> -- >8 --
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ec898a3cbc6..0c71eb3f925 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4310,3 +4310,9 @@ Machine development tool
>>   M: Maksim Davydov <davydov-max@yandex-team.ru>
>>   S: Supported
>>   F: scripts/compare-machine-types.py
>> +
>> +b4 tool configuration
> 
> Start the title with a capital letter, please.
> 
>> +M: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> +M: Philippe Mathieu-Daudé <philmd@linaro.org>
>> +S: Odd Fixes
>> +F: .b4-config
> 
> The scope of this entry is less than clear.  What kind of tools?
> 
> It's not our own tooling (scripts/...).  Perhaps it's tools used by
> enough developers to warrant committing common configuration to Git.  We
> have such configuration files already, not covered by MAINTAINERS, e.g.:
> 
>      .dir-locals.el
>      .editorconfig
>      .exrc
>      .gdbinit
>      .gitpublish
>      .pylintrc
> 
> The path of least resistance is to add .b4-config the same way.
> 
> If we decide we want a new entry in MAINTAINERS, its scope should be
> reasonably clear, and we should add existing files, if any, to it.

OK, then I'll just ignore ./checkpatch.pl warning for this patch.

Thanks,

Phil.


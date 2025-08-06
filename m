Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123CCC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujYJn-0006GH-GG; Wed, 06 Aug 2025 03:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujYJe-0006Eg-SH
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:12:04 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujYJc-0000xA-Mm
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:12:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-459e3926cbbso7071445e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 00:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754464318; x=1755069118; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lzFkCZGYIjHS3L5541oMDJAO18gYOZvT/Mt0N8C7DHg=;
 b=UnxnDB8h8nGX8MXZOaAxgTrxsY3OYlwGaTBexaYP9mJPnPqL80qCfUZA5Cv0PyvFfR
 +7AxekCH3oFFbcWnwo+PSvo76UXLFeZKnXWidrCKs1i8cIs5/5Q1ZdA94VOMIXHzy+VP
 fy0jQYpkWAkxPCg+5iFNOZWC3CymyY9XB8Yvy6dYMr6Wv1qySmGhyhtRzQVOXN8R/Ezy
 Mwn2maWQN10tbN/+Gr/jvx1cwktGbatcL3vgBHmd2VJvGK6b09ei+RfIt6OGvf3isWmN
 E7vDbnFvP9TwNoic7SGZyrJ0adJ0mZaYBG1sT4AHuTmieZdAPplvnymySeL5DlZvvhTT
 yMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754464318; x=1755069118;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lzFkCZGYIjHS3L5541oMDJAO18gYOZvT/Mt0N8C7DHg=;
 b=C3PvYipakA6vVGP/75ElrnuhSdxixcfpiON7vkKBHmH8Sdevz83FwGRKYENS+CzYEn
 /5RTQnZa/CxYSRCWtRJBv83A755UTqC0LpGjncURPwwluiyD6kMUi5ZOfmG+AYxWIEgh
 EN7tPLL/SMQfbi85jLNhxg1x+ywxW4GF0XAfSp6IUe5vLKCyD4S1VjGyDs5tHB5SgcfR
 Sc2dJjQCRSsIRXWlsVH8JIFceha/QA1DEMFoOEJEA/UOkyrUC5c4DsyLt82rfHAuFEMS
 Q013eMB8VBpgoG5oc8zYCZjH9ytkfyxL708PBZ9TKo69B0g5kxO6EufM8Cf363xkJuYp
 UDXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1p/4QyvqzZcBXTWInbRQZ+hNFGrJrIBnOsvew8w9GdNz37v4HscAbiLKV4Q9DvRGCGB5/K1/e2U3v@nongnu.org
X-Gm-Message-State: AOJu0YwJ35PaP0CXEtqHvHxPr/HUTW8fTpvd/Pze1Lq2hmNjUd+InwEy
 iVvbCIc7fMdFpdC73QZjh2/61pbeUfXvsTyRz/OYQazoAr/d9EXigF1TYXqIj6KIOp0=
X-Gm-Gg: ASbGncsvVwM7XBO7AROituyzYYUvHokZr5zhFmp0poZjiS84ycsDOJt90ZyiRQNeQ1G
 2Sb4O/wUWUFt5fxOs2eJh5dnxCUg+/YeqIKtCuEBdukrzfoo0+WucML74BYeOZK12AL7i9kZGYR
 GeYUCxGIdgpO5MCbYgMyV/xzQRnmPjsCm28s44RsJ2c2hO03WMhHvUxDcklrHb5bV4g3MjQWo/Y
 SASUp7W8gZvvgKA6O0P4G/heBO6IwSvh+oh+2YSmEI3iKkLqtD784nUh/ZlzCku/F2pzERWdtte
 00QMoN5tmNovd5jjO8K0z94KKctZzngr1e/RgntgO/G01Q9wWZmzXQmvDAmB7dwsSach/L1wVzJ
 YnoSJcrAlsSjgYNu9G7X9LTfC+53WnPqQB4ktSJIPu4SYNWOsj4La6KqH4UP28Puahg==
X-Google-Smtp-Source: AGHT+IHnfcR46I2MiTDQVnoRQH8oZIAMlz29GVtGUSiL/baQCrEh+b/dRnfuqh0UQNwR3vD9BcysRQ==
X-Received: by 2002:a05:600c:358b:b0:458:caec:a741 with SMTP id
 5b1f17b1804b1-459e70e8173mr12481305e9.24.1754464318460; 
 Wed, 06 Aug 2025 00:11:58 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e583ff76sm34394245e9.5.2025.08.06.00.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 00:11:57 -0700 (PDT)
Message-ID: <dd9a7c52-ea6e-45a2-9910-d4c152c40a68@linaro.org>
Date: Wed, 6 Aug 2025 09:11:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/24] tests/functional: Move mips tests into
 target-specific folders
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-15-thuth@redhat.com>
 <ca897537-bbfd-47ed-b80e-66f357ef5995@linaro.org>
 <d80ee30f-e5e7-4c6c-aa63-5d13e8ba6d5f@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d80ee30f-e5e7-4c6c-aa63-5d13e8ba6d5f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 5/8/25 15:56, Thomas Huth wrote:
> On 04/08/2025 10.31, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 1/8/25 17:12, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> The tests/functional folder has become quite crowded, thus move the
>>> mips tests into a target-specific subfolder.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   MAINTAINERS                                   |  8 ++--
>>>   tests/functional/meson.build                  | 47 ++-----------------
>>>   tests/functional/mips/meson.build             | 11 +++++
>>>   .../test_malta.py}                            |  0
>>>   .../test_replay.py}                           |  0
>>>   .../test_tuxrun.py}                           |  0
>>>   tests/functional/mips64/meson.build           | 10 ++++
>>>   .../test_malta.py}                            |  2 +-
>>>   .../test_tuxrun.py}                           |  0
>>>   tests/functional/mips64el/meson.build         | 14 ++++++
>>>   .../test_fuloong2e.py}                        |  0
>>>   .../test_loongson3v.py}                       |  0
>>>   .../test_malta.py}                            |  4 +-
>>>   .../test_replay.py}                           |  0
>>>   .../test_tuxrun.py}                           |  0
>>>   tests/functional/mipsel/meson.build           | 12 +++++
>>>   .../test_malta.py}                            |  2 +-
>>>   .../test_replay.py}                           |  0
>>>   .../test_tuxrun.py}                           |  0
>>>   19 files changed, 59 insertions(+), 51 deletions(-)
>>>   create mode 100644 tests/functional/mips/meson.build
>>>   rename tests/functional/{test_mips_malta.py => mips/test_malta.py} 
>>> (100%)
>>>   rename tests/functional/{test_mips_replay.py => mips/ 
>>> test_replay.py} (100%)
>>>   rename tests/functional/{test_mips_tuxrun.py => mips/ 
>>> test_tuxrun.py} (100%)
>>>   create mode 100644 tests/functional/mips64/meson.build
>>>   rename tests/functional/{test_mips64_malta.py => mips64/ 
>>> test_malta.py} (96%)
>>>   rename tests/functional/{test_mips64_tuxrun.py => mips64/ 
>>> test_tuxrun.py} (100%)
>>>   create mode 100644 tests/functional/mips64el/meson.build
>>>   rename tests/functional/{test_mips64el_fuloong2e.py => mips64el/ 
>>> test_fuloong2e.py} (100%)
>>>   rename tests/functional/{test_mips64el_loongson3v.py => mips64el/ 
>>> test_loongson3v.py} (100%)
>>>   rename tests/functional/{test_mips64el_malta.py => mips64el/ 
>>> test_malta.py} (98%)
>>>   rename tests/functional/{test_mips64el_replay.py => mips64el/ 
>>> test_replay.py} (100%)
>>>   rename tests/functional/{test_mips64el_tuxrun.py => mips64el/ 
>>> test_tuxrun.py} (100%)
>>>   create mode 100644 tests/functional/mipsel/meson.build
>>>   rename tests/functional/{test_mipsel_malta.py => mipsel/ 
>>> test_malta.py} (98%)
>>>   rename tests/functional/{test_mipsel_replay.py => mipsel/ 
>>> test_replay.py} (100%)
>>>   mode change 100644 => 100755
>>>   rename tests/functional/{test_mipsel_tuxrun.py => mipsel/ 
>>> test_tuxrun.py} (100%)
>>
>>
>>> +subdir('mips')
>>> +subdir('mipsel')
>>> +subdir('mips64')
>>> +subdir('mips64el')
>>
>> Just one single comment here. I'd rather have a single mips/ directory
>> and keep the variants inside it, i.e.:
>>
>>    tests/functional/mips/test_mips64el_malta.py
> 
> That would make it very cumbersome to determine which qemu-system-mips* 
> binary we'd need for those tests. Currently the tests for each qemu- 
> system-xyz are simply looked up in the xyz subfolder. If we put all mips 
> targets into one folder, we'd need to add some special case logic which 
> I'd really like to avoid.
> And in case the mips targets get unified later, we still can simply move 
> the tests to one folder again, there is no hurry to do this right now 
> already.

Alright, fine then.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



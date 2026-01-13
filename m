Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38C2D2F352
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 18:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfjaS-0002s8-8O; Tue, 13 Jan 2026 13:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfjY1-0002bU-Sf
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 13:55:22 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfjY0-0005i2-4x
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 13:55:21 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4ee1939e70bso88727091cf.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 10:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1768330518; x=1768935318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iqqQKqXcxMuA0XjRXTu76+Mpnp7tyN7qyzDTcFSc2is=;
 b=PmZeDat3SZ4H4fHLB1wdZj2dt3HWrvaMfKvuYWbe2UrgnoGYCbA3IK1d/GXBwg0Swv
 hK221TM4Cv72rOBHT6ck4lesd3yKOZmYKUKQhUTIZ0VXtGiLMU7nO6JKKaS94g+mwRNE
 2I/WAjVm8LYebD0BfsWqv7F01/pQIXoXN+CB+4mplmY2B2Ario8ob39UU815YGfXk1CX
 WW8toz4JKRbrQSO03XoEwMKfjccj1/qBAcIm7LKZYdvGEFv7bnw/N8vV4FQubS0XJqSF
 6El8HFJOBvUdNMs3Fyc77lniVytTOMIdUDfzwSmlYyNtu4fghwRNKymFtZ+lWJ5IeQXs
 OyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768330518; x=1768935318;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iqqQKqXcxMuA0XjRXTu76+Mpnp7tyN7qyzDTcFSc2is=;
 b=heFsXITjvdxtbrgUeHmwNoeSP0UUGsgyznZm4jC+qRoUIBVwf8oss8wIWn4bb90lza
 G4Mp18YP3glcsSAC1Ate1UtpZavxurV8d45PzssabfEjJ07AYoXHcRSWWgFRVQtqMobX
 q+yO8/7tJR+kwK6kLK+AtBGyDUCfDMn8XW17qPfqwhLAdaSqCP9n2a319ncp30vC4GxG
 I5luaaSK0AtjSpqsMitBP+7W0ZtkDYj2Unei3+4m7yI5GGRU0F/VekG3oUNmEOBOd6lU
 b/qIOkcUdwHDYCxjLOwDwkuxhP1sBReMyxz8pdB3+fr9H/H3tmBfOkX47n4HgSffXDam
 LL8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkLgxyoBrIPWIKR+MT64mUZ2tpdBx3dUbRp5XF/8GOFs/foeKMsMXXdbgD2Q9o0DU4PBdquvslAomy@nongnu.org
X-Gm-Message-State: AOJu0Yzy4Wk4gfOgqk95JIpyX17DYVnF8c7cpuAtTN9bddi8/6jOnSAC
 J8lT+ueNJ2jNXX1XVkU5FJuKXUmpteJMEGmG43nLcHQaIuJu4GZOS1dGHIZ14WbXdVQ=
X-Gm-Gg: AY/fxX5bUronupQAAPqMSuKoyHGAXRjSdMJGhmLjPM+mfQfurim0xQ7ohw44wzDz81t
 IoaJfanOQxpYYVYyC3BK3ckxzEBBVK6ImnK9P+LkJ5D8DLJhmQ9ftw+aEMJdilJpZC0dbQAXGmo
 ttUp3dbz77t0EDqq2sRRgmuT324kxS8pMDfWrc9OVLxyau/8deACXef/NWHeaxlOvnrjRA5ncUd
 C7h+i9qE9QVP3le84/e+Yo3FTa6rJ3IGflXCzkySrkFYAJrUI02faE5eUG93ttVcrb8SUwdFmks
 7k4tCj9xjXBd6pSgAZcGkgZ4VlkKD+SNq3ajH1ZnISdJUZYdjWgtCNgyjl/2fuvKNtSaGikcUfW
 3vn54d0To+3TFX95iiOTj6Ck9coePM2A98QzhMPemCQYJDdhOFaQ3vZjtONYE6jwuSa/9ljdfHW
 aFyfSbj8rKFw33gNdJHX+gJ0vLgNhSwI2nuMSvuMEJ
X-Received: by 2002:a05:622a:4898:b0:4ee:1962:dd46 with SMTP id
 d75a77b69052e-501484c37b8mr1846861cf.79.1768330518214; 
 Tue, 13 Jan 2026 10:55:18 -0800 (PST)
Received: from [192.168.68.103] ([152.234.121.223])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8e35dbfsm143863741cf.19.2026.01.13.10.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 10:55:17 -0800 (PST)
Message-ID: <641dbb9e-302b-434b-a0a9-0a1a5499fbee@ventanamicro.com>
Date: Tue, 13 Jan 2026 15:55:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] RISC-V: Initial support versioning of debug
 specification
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "vivahavey@gmail.com" <vivahavey@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 daniel.barboza@oss.qualcomm.com, andrew.jones@oss.qualcomm.com
References: <20251201014255.230069-1-alvinga@andestech.com>
 <0e543e10-970d-4a7c-aa79-d3a0a6358e72@zevorn.cn>
 <SEYPR03MB670057426CD1F169681C54C1A8A9A@SEYPR03MB6700.apcprd03.prod.outlook.com>
 <625299d1-b04e-4c8e-8e96-8f353510ad3c@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <625299d1-b04e-4c8e-8e96-8f353510ad3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x82b.google.com
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



On 12/19/2025 6:23 AM, Chao Liu wrote:
> 
> 
> On 12/19/2025 5:10 PM, Alvin Che-Chia Chang(張哲嘉) wrote:
>> Hi Chao,
>>
>>> -----Original Message-----
>>> From: Chao Liu <chao.liu@zevorn.cn>
>>> Sent: Friday, December 19, 2025 4:09 PM
>>> To: qemu-devel@nongnu.org
>>> Cc: alistair.francis@wdc.com; Alvin Che-Chia Chang(張哲嘉)
>>> <alvinga@andestech.com>; bin.meng@windriver.com;
>>> dbarboza@ventanamicro.com; liwei1518@gmail.com;
>>> qemu-riscv@nongnu.org; vivahavey@gmail.com;
>>> zhiwei_liu@linux.alibaba.com
>>> Subject: Re: [PATCH v3 0/2] RISC-V: Initial support versioning of debug
>>> specification
>>>
>>> [EXTERNAL MAIL]
>>>
>>> On Mon, 1 Dec 2025 09:42:53 +0800, Alvin Chang via wrote:
>>>> This series try to support versioning of debug specification. The
>>>> early debug implementation supports debug specification v0.13, and
>>>> later new trigger types were added which are defined in debug
>>>> specification v1.0 version. To support both v0.13 and v1.0, we add
>>>> 'debug-1.0' as CPU property to let user choose debug specification
>>>> v1.0 by specifying "debug-1.0=true". The default version is still v0.13 if
>>> 'debug-1.0' is not provided and set.
>>>>
>>>> For example, to enable debug specification v1.0 on max CPU:
>>>> * -cpu max,debug-1.0=true
>>>>
>>>> Changes since v2:
>>>> * Improve commit message and fix typo
>>>> * Apply "Reviewed-by" tags
>>>>
>>>> Changes since v1:
>>>> * Apply suggestions from Daniel. Using boolean property instead of string.
>>>
>>> This is great work! Thanks to Alvin Chang for refining the sdext. It seems we
>>> are one step closer to merging rvsp-ref into the mainline.
>>
>> Thank you, Chao.
>> Please note that this series doesn't implement Sdext infrastructure.
>> We have some patches for Sdtrig based on Debug spec v1.0 and we want to upstream those patches.
>> We ever submitted the patches, but unfortunately the patches were blocked.
>> The maintainer told me that QEMU should support both v0.13 and v1.0 for backward compatibility, rather than eliminating v0.13.
>> That why I submitted this series, trying to resolve the version issue.
>>
>>
>> Sincerely,
>> Alvin Chang
>>
>>
> Oh, thank you for your clarification. I also noticed this when reviewing the
> main patch series — it was my misunderstanding. Still, thank you for your
> contribution!
> 
> I have done some development work on Sdext before, but I noticed that
> implementations of the DM module vary among different vendors. In addition, how
> to achieve compatibility with gdbstub is also a challenge. I will send out the
> RFC patches at an appropriate time in the future.

Hi Chao,

If I understood correctly you might have some code that implements sdext 
  in QEMU. Is that the case?

If affirmative, feel free to send it at you earliest convenience, even 
if it's rough on the edges (you can tag it as RFC). We would like to get
the Server Platform Reference Board merged, preferably for this release, 
and we need sdext to be compliant with that spec.


Cheers,

Daniel



> 
> Thanks,
> Chao



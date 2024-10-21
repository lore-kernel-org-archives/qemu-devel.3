Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B209D15DB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2v6X-0003ET-SL; Mon, 21 Oct 2024 12:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2v6W-0003E6-20
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:18:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2v6U-0003nZ-BL
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729527477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pgppa2hn3VsFnFWJLdoCWmV6Sj2QwOqGddI/+WR6r5g=;
 b=cSsVQNeLzJ6x5e5GoAq26O3vGeLTeoSm3mHbY1qqYZu4LIxU830/uwMeYJ7A/UpxjNWgRd
 utaQPXFj+g1HLt6nzkTC4kwdqQZgm0GCnOUY3hLZs3bTIbeT7ZKOTGY5mqurNlSJVhc8to
 xNpc4Dd0t9Y386VCFdcbnJ2zZBP+ytU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-BwmwIYWHPzSuHK14_amwHw-1; Mon, 21 Oct 2024 12:17:56 -0400
X-MC-Unique: BwmwIYWHPzSuHK14_amwHw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d531a19a9so2322547f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729527475; x=1730132275;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pgppa2hn3VsFnFWJLdoCWmV6Sj2QwOqGddI/+WR6r5g=;
 b=b4HfQS4Kt220NGJunFq/0YePUlceIbIIl+uJmG98ZpYvX0e+7/gQhUnN7RFiqfrFnm
 x0qPwP0dv39dhQdFrXxo6SmYV2NOgkxEEZ3pYoJiALCMkQH2PN3+GmHBPqAX5aZ0RkxQ
 RDUqYt05+Na1Ob135xFm8+SxDroSZg7K1yITSwBgwC6+dzGujISYjQgFSbpnKtgxLo3X
 5deaV5mLXtgOwvmvexW5q/6kiE7ru31eWLDGdlppBV+PZ3u4gLQY0mv4iNhZpcSeGHRy
 sFGFnHEr9qCEYzl0DpeYZDTM/uXGYTAr7VNj2zI2slXiTeQJvq1Cgyy5sSAn1ZwBF+QV
 H2iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqzu4KbWGT98DtqxcG6PC/UIQ/o3NxVR9aHJNKCh7qMFiA5Ub2MRsnGpiNeuw7rtaKaIqbIY6ilj0g@nongnu.org
X-Gm-Message-State: AOJu0YxfIyf4tnXf1hIPIzT3ddupupHTz7yGsn26DSdwPvApLdhHJHag
 tVl9/TKJU6aEn+e2vHPgmCJV/D49i3JWiKfLBB2c3j0KNVYymZXF85+Qi2q9baictbsUGqKZ5oc
 78Un9d154f3fgljBgt6vJQk2OsdwltZz+WByw7FiwRC71ojLX7tlz
X-Received: by 2002:a5d:5310:0:b0:374:c31e:9721 with SMTP id
 ffacd0b85a97d-37eab6e49d5mr7366623f8f.42.1729527474893; 
 Mon, 21 Oct 2024 09:17:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWouitDFHtg6ikZsvOSrHCJh3IRrisylknb4/2LZqc9cthn7dzYPkj0mHw6md2nOyEZ/EXaw==
X-Received: by 2002:a5d:5310:0:b0:374:c31e:9721 with SMTP id
 ffacd0b85a97d-37eab6e49d5mr7366594f8f.42.1729527474181; 
 Mon, 21 Oct 2024 09:17:54 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a37a2fsm4680996f8f.22.2024.10.21.09.17.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 09:17:53 -0700 (PDT)
Message-ID: <bd83b5b5-9e90-46f0-864e-0b157725da96@redhat.com>
Date: Mon, 21 Oct 2024 18:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/47] riscv-to-apply queue
From: Thomas Huth <thuth@redhat.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <CAFEAcA9Sb-fpNhm-6DPwss5zMpw=nEp31Wt6q1OA6DqCg3wKEg@mail.gmail.com>
 <13ee9889-b503-45ea-a074-ffafbd052c4e@ventanamicro.com>
 <CAFEAcA_nn2fUyo9Pkd8jW2NG1oJLbAJrfiC7sziuhGthqL3=4Q@mail.gmail.com>
 <096029d7-269c-44f8-88d3-6f0c52af58fa@ventanamicro.com>
 <7d60d882-3b59-428d-b63e-7d7444bd96fa@redhat.com>
 <c09f8552-7362-4fb8-a072-37dd03dbdfa5@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <c09f8552-7362-4fb8-a072-37dd03dbdfa5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/09/2024 13.35, Thomas Huth wrote:
> On 30/09/2024 12.58, Thomas Huth wrote:
>> On 29/09/2024 22.53, Daniel Henrique Barboza wrote:
>>>
>>>
>>> On 9/29/24 12:38 PM, Peter Maydell wrote:
>>>> On Sat, 28 Sept 2024 at 21:40, Daniel Henrique Barboza
>>>> <dbarboza@ventanamicro.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 9/28/24 8:34 AM, Peter Maydell wrote:
>>>>>> The assertion failure is
>>>>>> ERROR:../tests/qtest/riscv-iommu-test.c:72:test_reg_reset: assertion
>>>>>> failed (cap & RISCV_IOMMU_CAP_VERSION == 0x10): (0 == 16)
>>>>>
>>>>> The root cause is that the qtests I added aren't considering the 
>>>>> endianess of the
>>>>> host. The RISC-V IOMMU is being implemented as LE only and all regs are 
>>>>> being
>>>>> read/written in memory as LE. The qtest read/write helpers must take 
>>>>> the qtest
>>>>> endianess into account. We make this type of handling in other qtest 
>>>>> archs like
>>>>> ppc64.
>>>>>
>>>>> I have a fix for the tests but I'm unable to run the ubuntu-22.04- 
>>>>> s390x- all-system
>>>>> job to verify it, even after setting Cirrus like Thomas taught me a 
>>>>> week ago. In
>>>>> fact I have no 'ubuntu-22-*' jobs available to run.
>>>>
>>>> It's on the private s390 VM we have, so it's set up only to
>>>> be available on the main CI run (there's not enough capacity
>>>> on the machine to do any more than that). If you want to point
>>>> me at a gitlab branch I can do a quick "make check" on that
>>>> if you like.
>>>
>>> I appreciate it. This is the repo:
>>>
>>> https://gitlab.com/danielhb/qemu/-/tree/pull_fix
>>>
>>> If this is enough to fix the tests, I'll amend it in the new IOMMU version.
>>> If we still failing then I'll need to set this s390 VM.
>>>
>>> By the way, if you have any recipe/pointers to set this s390 VM to share,
>>> that would be great.
>>
>> You can also use Travis-CI for testing QEMU on a s390x host, see e.g. my 
>> runs here:
>>
>>   https://app.travis-ci.com/github/huth/qemu
> 
> ... apart from the fact, that it currently seems to be completely broken 
> again :-( ... I guess that means: Never mind, sorry for the distraction!

FWIW, it seems to be working again:

  https://app.travis-ci.com/github/huth/qemu/builds/272812225

  Thomas



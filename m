Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABAEE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNweU-0008JX-BI; Wed, 18 Dec 2024 11:11:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNweR-0008J3-M4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:11:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNweP-000228-Et
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734538311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U50nqGJcACoDyMdVZyzvlg6Dpr93yl67LRTSu4Dw3o8=;
 b=jQOH9j6Xl8rMarnMQWl6pdAnJhHABgh4YQuiueYmG6g5L1PcSPt6RKj8LPy3hqzVrdyKKC
 qYole91LsMkOFIZ8CcwnwaDVa40na0N8264CeSnkcOQa6a9gvt00EvR1myh1HHWwOtOpUG
 udphnZfkeEk2BEd6DCrxM5ellI+TDpQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-eFg1Eo4RNIyK6iCTZfQc3Q-1; Wed, 18 Dec 2024 11:11:49 -0500
X-MC-Unique: eFg1Eo4RNIyK6iCTZfQc3Q-1
X-Mimecast-MFC-AGG-ID: eFg1Eo4RNIyK6iCTZfQc3Q
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8eb5ea994so76401626d6.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538308; x=1735143108;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U50nqGJcACoDyMdVZyzvlg6Dpr93yl67LRTSu4Dw3o8=;
 b=BqHFLtncKNbXk7SoT03nbo3UzK/43bJC72ejiau787RyetWYqPp+xk5E6SlbXLGvSv
 Scmv8VtOl4VVnG/Cb9GmbnpAADVSxTw4TJnNdeMEzc8E516qODnhmqz6vCAuod4fGATX
 hR66ZprPpB8ocrhaqlIvobD/HkTTuaNm6cpJOXsIiGAsnhzoHKd9GWwZYErAyqAAa42P
 YrrANvjtNGmuK+HNS5M3zbE1IQT3/FPvXWP3YFOo2EXAo1WlyAWrP1Hzrym1tZOksAF2
 xEhXwTMPuD3xOqU0CboQsha425Z14PT1+t86jE3GwrmxXxJCcUIiQ8lNlgPtP7yvcz5v
 R/Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCDZuvIPEUam35kCbn+Pqn0wa7JjPqz63xAs7aRSebAcVN+s01+4tAYqTCEnPVdWZOS+JsP7xIfjAa@nongnu.org
X-Gm-Message-State: AOJu0Yzo7OmNF2oRFucI/SYSchtIEnFynX48bHzdU9MvrzPe0cFVCXIC
 5UlZ+jvjmceD7jBl0NjhnflHkP0QQUOKxZWm71OfjIL4oxXRCZBj42qrfgnSuuzzbO/dR6/EB/J
 R5URdGEMV8fx5fULwm6Pxsm65Sevcv4HdntGUgz4rjkrK+g+K0Glo
X-Gm-Gg: ASbGncvTfdv9BBhX/8yS6HdCDhvaPZ+KC1CDKpnVllyktUnwN9p5zcyz/i5yUY0owrn
 ofV3/Hr9sAMNC0v36plV55vNOQwOgQH9nZ4tDEsa+Pm1+Nr2KiqgQk7t5QipF3IPp0a1+EczcJZ
 dWEWbm1eN85Vd7L4h5GDITT+iP+596RN8NBcwYV6694P6d679Ro+Hq/SD2rpJwTufERMkZuScJP
 is4e/4RLUmUUNw48ukaVefhI+G7NVz/V9hfDsnvNymGuFLy18G2Mav51aRAsP4TBkqNLdYdivqc
 L9Bi1Va4hGhf
X-Received: by 2002:a05:622a:5a93:b0:46a:389d:17b1 with SMTP id
 d75a77b69052e-46a389d1992mr13182191cf.26.1734538308226; 
 Wed, 18 Dec 2024 08:11:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIIjK8G8NZOFXUDhshyTJzfk57ehROmbhjfQcnAoi0mBTT8GUxJXi/xVNxsHMFGyU7iSSXNA==
X-Received: by 2002:a05:622a:5a93:b0:46a:389d:17b1 with SMTP id
 d75a77b69052e-46a389d1992mr13181891cf.26.1734538307867; 
 Wed, 18 Dec 2024 08:11:47 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-49-186.web.vodafone.de.
 [109.42.49.186]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2e831a2sm52080241cf.64.2024.12.18.08.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 08:11:47 -0800 (PST)
Message-ID: <7a1117c0-8a07-4907-8584-d71a7bc46d3b@redhat.com>
Date: Wed, 18 Dec 2024 17:11:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] tests/functional: Convert the migration avocado
 test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
References: <20241218131439.255841-1-thuth@redhat.com>
 <20241218131439.255841-6-thuth@redhat.com> <87o719umj5.fsf@suse.de>
 <3399461b-b623-4950-a800-9e244dd10785@redhat.com>
 <Z2Lxh22H_ZcdmREg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z2Lxh22H_ZcdmREg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On 18/12/2024 17.00, Daniel P. Berrangé wrote:
> On Wed, Dec 18, 2024 at 04:51:24PM +0100, Thomas Huth wrote:
>> On 18/12/2024 14.51, Fabiano Rosas wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> Now that we've got a find_free_port() function in the functional
>>>> test framework, we can convert the migration test, too.
>>>> While the original avocado test was only meant to run on aarch64,
>>>> ppc64 and x86, we can turn this into a more generic test by now
>>>> and run it on all architectures that have a default machine that
>>>> ships with a working firmware.
>>>
>>> I'd rather drop this test. I haven't looked at it in ages and it has
>>> never been useful.
>>
>> I think I agree for the scope of the old avocado test - x86, ppc64 and
>> aarch64 certainly have better test coverage by the qtest already... but we
>> don't have any test coverage for other architectures at all yet, which is
>> bad (see below).
>>
>> So if you like I can change the patch so that the test is not run on x86,
>> ppc64 and aarch64 anymore, just on the other architectures that do not have
>> test coverage by the qtest yet?
>>
>>> I haven't been following the development of the
>>> functional suite so this might not apply this time (fingers crossed),
>>> but Python tests have always been a pain to work with.
>>
>> Well, one of the motivations with the functional test framework was to
>> simplify things. You can now run the individual tests without any test
>> runner at all, what makes debugging way easier (see
>> docs/devel/testing/functional.rst for details)!
>>
>>> About adding more architectures to the set, this is not simply enabling
>>> more testing, it is also adding workload to maintain these other arches
>>> that were never tested with migration. Is that something we want?
>>
>> I think yes. Otherwise the bugs are just dormant until someone hits the
>> issue, making bisection way more complicated later.
>> Remember this one for example:
>>
>>   https://mail.gnu.org/archive/html/qemu-commits/2023-02/msg00030.html
>>
>> ?
>>
>> It would have been good to have a migration test for alpha in the CI, then
>> we could have prevented that bug from being merged.
> 
> IIUC, we run the migration-test  qtest for *every* softmmu target.
> 
> So, assuming you're referring to alpha guest, we were already
> exercising it.

Unless I missed something, you got that wrong. Have a look at 
tests/qtest/meson.build: The migration-test is only added for i386/x86_64, 
ppc64, aarch64 and s390x (since you need a special boot / guest code for 
this test).

> Anyway, I think a true functional test for migration is relevant
> to keep, as long as we make it clearly different from the qtest.
> A simple smoke test using a real Linux guest is different enough
> from our hand crafted boot sector that I think it is valuable
> coverage. Even better if we make the functional test add *lots*
> of different devices.

Agreed, that's a good idea. But for a start, I'd first like to convert the 
avocado test so that we finally can clean the tests/avocado folder.

  Thomas



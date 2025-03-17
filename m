Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253B9C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 13:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuAZY-0005nz-Vc; Mon, 17 Mar 2025 09:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuAYs-0005aC-Qe
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 09:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuAYr-0007tq-27
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 09:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742218279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D6UthiIIyouVd7p5cIu3QGB9PkG0z50DgnwW3yQIh90=;
 b=hGoCblZcRhoaeUUfsuopXAFVR4vA5J0zYNtZmVesOIUgnsgACDrrjGvpv4MxManJaL7kLN
 J0rz8/HbCzIIX+jPZhApK/bkpuZMjFvdBrnmbMwFvxKi57ymi7jEW6DGlbw2Lzpdx+dOQr
 wJ6h+HfUIM+0hxVTCKfXTkeIQKIfqOM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-Y4rRANrqM0-0ZgIe9k0CpA-1; Mon, 17 Mar 2025 09:31:17 -0400
X-MC-Unique: Y4rRANrqM0-0ZgIe9k0CpA-1
X-Mimecast-MFC-AGG-ID: Y4rRANrqM0-0ZgIe9k0CpA_1742218276
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912fc9861cso2015697f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 06:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742218276; x=1742823076;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D6UthiIIyouVd7p5cIu3QGB9PkG0z50DgnwW3yQIh90=;
 b=aIB/aVSulStAof7Mnw56aCIkC+5tKNhcVL1EOP2tSc+ax7LSaJRirn3mNL5JXK9cMM
 q8J704BvoRi+bYAI3IASohEpiK/qGVeg5JFWnUlFV0E364EYzatv64SAeucdVjffipNA
 9VxwAbRU72uT8wK0IXjt0GjsyPiSAHxmtH583EtZGITlqLhij6l9KcpbLpMsEGIi11a8
 0HKYx0EQg1sASmcLF1TCD1nFLbnaN0ZJRVmo0mbj9ZTKg5oL97YtRw1mEmWXSOFSJJot
 D8My7Hd+W+WgHKWHVUPfdbMztszKGRVUKfGVbYvv1mpGs2lolyhdC2OD82MgGjBNBJrX
 ugcQ==
X-Gm-Message-State: AOJu0YzORSqCT49oG/PdnJOayvpFMJe4dOuvdw+22gN+eYP4JCS312fO
 w1gseq6+J3TyS+NiJCWLG9MpQ7oExQ4GGGeYMKudrN6tEVf7YF+LpDzyXf/zrDwN77EnKOANCwj
 c4CpgQbvmHmgISyHVPzeyalTU70iak3L++yEc+ajTOw9j07ecmBEz
X-Gm-Gg: ASbGnctrk1wtOnBHSXdT62/iuC9fq5beB4Czwrj5vQrJAUeMB+1yzsL1t8+bNY3y9H7
 xHj4nfDW6p2HoQcrjLBzVHCMWfvhyDb7aEf5vr8yU5u3lg1KP9YJV+3ANVkWZt7GwZtck4fgOby
 sGzA7sSfOPo98WutoN85Esx9zm4z4UPoPmLbT6BxqM42r4xzkYYrolD8hgA57bCubIScxRs3MpQ
 T+nnv8USB7t+9XXXKNIdxdTFn9bzcnagdEmEcbLRQD1+plRQs7+bfaKmEKK6+i55YvsJ+l7nt89
 VXXnS6UUy4jGrIWGT7OMCH27BAGvgSb8GUfQhZoiXaCgNbk=
X-Received: by 2002:a05:6000:1fa7:b0:391:2889:4ea4 with SMTP id
 ffacd0b85a97d-3971d133919mr12198731f8f.9.1742218276548; 
 Mon, 17 Mar 2025 06:31:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEafqAiyTHa4/aKqU9GQjIEoYf0dQAUvByQWpeA0iLqvizl1v6MHhQgnkdd8P3YlLquCU5dg==
X-Received: by 2002:a05:6000:1fa7:b0:391:2889:4ea4 with SMTP id
 ffacd0b85a97d-3971d133919mr12198708f8f.9.1742218276181; 
 Mon, 17 Mar 2025 06:31:16 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df3419sm14724162f8f.9.2025.03.17.06.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 06:31:15 -0700 (PDT)
Message-ID: <e66516bd-27d9-43ad-a1e2-be7ee75037a7@redhat.com>
Date: Mon, 17 Mar 2025 14:31:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/npcm_clk: fix buffer-overflow
To: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250224205053.104959-1-pierrick.bouvier@linaro.org>
 <CAFEAcA_sz-_6WGCQ=4kC2vtK2RUBXbAtMVzh3iZsp0xmNbgaxQ@mail.gmail.com>
 <829e9fd0-2d0f-45e6-ab89-d933d344cfe2@linaro.org>
 <CAFEAcA8BHzA_P7yX+cDMb1WiyGTzkh6xjvam4RHs5aoM1X6mkw@mail.gmail.com>
 <5c25f67a-2677-4162-9477-f51f230403b0@linaro.org>
 <CAFEAcA8jzYvCLxDTybE34K5DxQqOG4-m8_-oNwiATVBHYbEV9A@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8jzYvCLxDTybE34K5DxQqOG4-m8_-oNwiATVBHYbEV9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 26/02/2025 21.50, Peter Maydell wrote:
> (edited cc list since it's moved away from a discussion of this
> particular patch and on to a testing/ci coverage issue)
> 
> On Wed, 26 Feb 2025 at 19:03, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 2/26/25 03:50, Peter Maydell wrote:
>>> On Tue, 25 Feb 2025 at 20:57, Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org> wrote:
>>>>
>>>> On 2/25/25 05:41, Peter Maydell wrote:
>>>>> (Looking more closely at the cold_reset_values handling
>>>>> in npcm_gcr.c, that looks not quite right in a different
>>>>> way; I'll send a reply to that patch email about that.)
>>>>>
>>>>
>>>> It may be a hole in our CI right now.
>>>> Would that be interesting for CI to run all tests (check-functional +
>>>> check w/o functional) with both ubsan and asan?
>>>
>>> We do have at least some ubsan tests in our CI right now
>>> (eg the "clang-system" job). The problem with ubsan coverage
>>> is the usual one that we already have too much CI going on,
>>> and it takes forever and we don't have that much headroom
>>> for adding more jobs.
...
>> Would that hurt so much to have one configuration enabled with ubsan and
>> asan, which catches *real* bugs, and potential security issues?
>> Yes, it adds overhead, but it should not be x10. Around x2 to x3.
> 
> You'd need to have a duplicate of all of the above
> functional-system-* test jobs if you wanted
> to test all the guest architectures, I think. So it's
> 30 mins build * six configs plus 60 mins total for testing.
> Or we could convert (some of?) the existing jobs to use the
> sanitisers if we needed to economise on CI time.

I agree with Peter that having additional build jobs is currently rather a 
no-go ... but maybe we could enable ubsan and/or asan in some (more) of the 
existing pipelines?

  Thomas



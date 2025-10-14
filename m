Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C7FCCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8bh4-0004jy-Qi; Tue, 14 Oct 2025 05:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8bh1-0004jg-TS
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8bgy-0005cq-RW
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760435496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lPW5m+2VEz84FkHSSpolEi+W/zejhBH9jjUUGBhZ0vo=;
 b=aSp29HPdgsg9keO4JRBQ0IJ4Spf4vk4T1XvWXi48a52jAYY73ySWwkyCsNi6LUFHBzUMay
 iYZyxLFdUrcGCTFeCE5+HJpaJds9427v0zfleqnN+4MdXD5x9ZOlUeOaf+DZVMo1QCaVwK
 9ycVAjx4ft7a0w67E7qw5ZFpzwlnGbI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-tcq5Qvr0NLuy95iDunPEkQ-1; Tue, 14 Oct 2025 05:51:35 -0400
X-MC-Unique: tcq5Qvr0NLuy95iDunPEkQ-1
X-Mimecast-MFC-AGG-ID: tcq5Qvr0NLuy95iDunPEkQ_1760435494
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e4335fa87so896485e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 02:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760435494; x=1761040294;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lPW5m+2VEz84FkHSSpolEi+W/zejhBH9jjUUGBhZ0vo=;
 b=UKG6bJjZXg9ZyEoMf5+Hx07wob4BdUhwMa6sUi5rHSUphWftusXfg62ZOc8wmZ8Gjk
 PBK6ZypQtRY+JZhekSLakEafb++0s2fPcmPjyfp5j0r5x1PKBvN5h0P1ojJWBodBQcrp
 HkFkeMIZkd7sTQT447LIyE3sCZ1UPg7PkhQ3TovUsjk/SOlnBTsujNTZVM1GzY7GKWTI
 M/zjyaGwAM/07U4WGPp74fspotmRWVdvHggACQYKxLUs2T+X++0eSqgCo+2YjHG42px4
 yTbtrRlnKrLFTd4kfoFbncsNT+cUugYB/CnIjw/QNMSx2KIGNrcVSDV8h9b+yxeGJqgy
 8Mgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnyMuBIuddjcDgg9mQMGxJ6Go88YG8C7z85us3Gghml2NXlED2N3+oy9YDrMbuol2yVeWNW/njzzc1@nongnu.org
X-Gm-Message-State: AOJu0YwUOYpT0480V7XoJtOhT8paGwzxn2ySvdfd7wWjwUERuLH8Mc8Z
 S2uyJP5jl1XFbKTx9kaiT9bFV9okqK6vy6VFhq40AoHNhQ5og1eVRSUjZ3QJyoObQwYuBl8w0jt
 XpUxHDCtQ/DHV222U16dgEhWmPECaM8Gclf18gga7It3i5jJopOS7HDpQ
X-Gm-Gg: ASbGncu6nFYt9qmfbtg2VUkEvTHiIKRF8DSGFmvC3I6lhZUXtup1tHjKalwr2eNUbxm
 igYQ/DI9J1y3/ZkSPswRv8NqOTD3hchLT3NEQ04IRpbS9KfkFLEz3RlqmyFIecuv4zng3lGSFEw
 5FQnKXU8W64FcSwUCKxkaCaE07FjS2XpHdY4WZ8ogSLNOs8MsLMEEBKwTUB2TXakxIucmINsQWT
 9Akv/HFXMSdGL8S1AOCZbCdG/9tzh5a32UBp/7qebMeAonIabPPKafyiMQ/7YVxSJAZEpYNBJuh
 62cXk6J+ZjcW7wcfE/wC5wfQsK7Z8W8/uqlUmHPg4qvp5/oUuNmz3kPwwgF2TCiRt4GPnRAlUat
 kl5SO0g==
X-Received: by 2002:a05:600c:3f08:b0:46e:4b42:1dbe with SMTP id
 5b1f17b1804b1-46fa9b075f3mr185702785e9.32.1760435494355; 
 Tue, 14 Oct 2025 02:51:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7YUPAy1kwrG8eOdW4A6vQctatGv7jVCQF5aGs/99e/77RSQA4ybx257pSATWdph5XwCTrpQ==
X-Received: by 2002:a05:600c:3f08:b0:46e:4b42:1dbe with SMTP id
 5b1f17b1804b1-46fa9b075f3mr185702505e9.32.1760435493930; 
 Tue, 14 Oct 2025 02:51:33 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e10e8sm22716005f8f.39.2025.10.14.02.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 02:51:33 -0700 (PDT)
Message-ID: <42bcf981-9a6a-4ad6-9135-f6189cbfc733@redhat.com>
Date: Tue, 14 Oct 2025 11:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tests/qemu-iotests: Improve the dry run list to speed
 up thorough testing
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 qemu-devel@nongnu.org
References: <20250910153727.226217-1-thuth@redhat.com>
 <20250910153727.226217-3-thuth@redhat.com> <aN6GfX8js5f_nS_o@redhat.com>
 <c8e6d6c7-d261-4ede-83f3-1fd7b70d2eee@redhat.com>
 <aOz1zLV4J5Znm_M3@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aOz1zLV4J5Znm_M3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/10/2025 14.51, Kevin Wolf wrote:
> Am 02.10.2025 um 16:33 hat Thomas Huth geschrieben:
>> On 02/10/2025 16.04, Kevin Wolf wrote:
>>> Am 10.09.2025 um 17:37 hat Thomas Huth geschrieben:
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> When running the tests in thorough mode, e.g. with:
>>>>
>>>>    make -j$(nproc) check SPEED=thorough
>>>>
>>>> we currently always get a huge amount of total tests that the test
>>>> runner tries to execute (2457 in my case), but a big bunch of them are
>>>> only skipped (1099 in my case, meaning that only 1358 got executed).
>>>> This happens because we try to run the whole set of iotests for multiple
>>>> image formats while a lot of the tests can only run with one certain
>>>> format only and thus are marked as SKIP during execution. This is quite a
>>>> waste of time during each test run, and also unnecessarily blows up the
>>>> displayed list of executed tests in the console output.
>>>>
>>>> Thus let's try to be a little bit smarter: If the "check" script is run
>>>> with "-n" and an image format switch (like "-qed") at the same time (which
>>>> is what we do already for discovering the tests for the meson test runner),
>>>> only report the tests that likely support the given format instead of
>>>> providing the whole list of all tests. We can determine whether a test
>>>> supports a format or not by looking at the lines in the file that contain
>>>> a "supported_fmt" or "unsupported_fmt" statement. This is only heuristics,
>>>> of course, but it is good enough for running the iotests via "make
>>>> check-block" - I double-checked that the list of executed tests does not
>>>> get changed by this patch, it's only the tests that are skipped anyway that
>>>> are now not run anymore.
>>>>
>>>> This way the amount of total tests drops from 2457 to 1432 for me, and
>>>> the amount of skipped tests drops from 1099 to just 74 (meaning that we
>>>> still properly run 1432 - 74 = 1358 tests as we did before).
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>    tests/qemu-iotests/check | 35 ++++++++++++++++++++++++++++++++---
>>>>    1 file changed, 32 insertions(+), 3 deletions(-)
>>>
>>>> +def dry_run_list(test_dir, imgfmt, testlist):
>>>> +    for t in testlist:
>>>> +        if not imgfmt:
>>>> +            print('\n'.join([os.path.basename(t)]))
>>>> +            continue
>>>> +        # If a format has been given, we look for the "supported_fmt"
>>>> +        # and the "unsupported_fmt" lines in the test and try to find out
>>>> +        # whether the format is supported or not. This is only heuristics,
>>>> +        # but it should be good enough for "make check-block"
>>>
>>> I'm not completely sure if this is a good idea at all, but I think we
>>> should at least mention the possible surprising cases where the
>>> heuristics fails in this comment.
>>
>> Yeah, it's not perfect, but I also failed to come up with a better
>> solution... do you have any other ideas?
> 
> Maybe fixing the qcow vs. qcow2 case could be possible relatively easily
> by operating only on full words, but I don't have any fundamentally
> different solution without touching every script.

Ack, using some proper regex seems to be better, indeed.

> If touching everything is an option, maybe we could have a standardised
> comment line like we have with "# group:" today. This would be easy to
> parse and work in both bash and Python scripts. But I'm not sure if it's
> worth it.

Actually, introducing special groups for every format was my initial thought 
when I started working on this. But this is very, very cumbersome, you have 
to make sure to get the groups of each test right in addition to the 
"_supported_fmt" and "_unsupported_fmt" statements, so I quickly abandonded 
that idea again.

So I'll send a v2 with regex statements, I hope that's good enough for the 
average testing via "make check".

  Thomas



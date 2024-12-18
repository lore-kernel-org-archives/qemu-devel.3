Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4A8E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwKs-0006DY-Ro; Wed, 18 Dec 2024 10:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNwKq-00069O-Ox
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:51:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNwKk-0004PU-Sv
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734537093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=m8bl9bV5kPJoySX5GxcHuiJbUAcMKhEGAUiWNaKwv9k=;
 b=Ndx/wzCEqqqc+i9fT83tyCNKxVFqhah5GGCDBVk1/VeuG17pMo9G+86Zb6w+5eAAncZu0B
 qOEwK2zVZf5FcZenxYGDqmI+F3bM+tS4hSprWxedT6WOwF/WH4ag4/5YtkqQZItvRatYop
 iVUOuQZrNoIaQPJROfFBYVAVzlYCM1Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-qKMHawTEO4S5AHsW8GkBrg-1; Wed, 18 Dec 2024 10:51:29 -0500
X-MC-Unique: qKMHawTEO4S5AHsW8GkBrg-1
X-Mimecast-MFC-AGG-ID: qKMHawTEO4S5AHsW8GkBrg
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e7f07332so1010474285a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537089; x=1735141889;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m8bl9bV5kPJoySX5GxcHuiJbUAcMKhEGAUiWNaKwv9k=;
 b=BumARUjnz6OLV5j/w3RoCC/GdflSbcr2ddmCV0czcmkfQ4HE6gfH3wQutQ2TAottM4
 H/8lhDci/o1GDhfPi0AlNjgDSJ4FGqpDeF5NP8pUA/2e6luMLTwPrL+NIDAWFHY4+NDF
 g2Yxmy9B7PeQdKgm1jRlrm9KaeK/Iud7Xu9UmM8ZnJXcponKQTw5qeeiIsjyK6FqECGB
 7f+/LqF56L4DZQEMPRuSy3bR+k55fXZ0sPKcuO9yNCKKM8bm0hnP3MPKcqJVvcHbLYLq
 HOtpOCPRFy7uc5J2HHyQ45/uAHfGJ6unnTurnqGDRnTZeAUUq/QKCUabJzoi+6MSKXBT
 9rzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXabsXjcXvqTvkJ0DpifY4G2MLxd7rRv8TWRWbEzdFUSacjJ9xbB/s3Id7uJTrUmpk+6bMQ5GS6Ec9Z@nongnu.org
X-Gm-Message-State: AOJu0YyBQG/Cdw0P6EHGfuUasmNZZ9xJ+0t3CdEiovb5X9X5Iqo5M3vK
 RzeMoIBPWkFleNYZ4HSitBhluMizi/lqqfsFtT7Kvi58JdBueUWYHJcrnKarqsCT61PdbVMNOyr
 JFNO2HT1Zzx1R4Z0LpaKXZK+bNtWtAqdpxI1XgJ8TN5RW+Km7PQEb
X-Gm-Gg: ASbGncvZmPyCORe/vXuDN4is0NCFpjkQQ7VcPoU5ulhs9waEW+sl60UYfQXrfBJe/Qr
 cwVXTNQ5s3qsH7bDRAPSmcnGbn3u3Qk0uoxbY0ASPZwQxj2no0GyxjPa7+i4xkWPLyFqhdYDWIy
 XYgQ6su9XILZ3iw+bekKMG9+eJWDCTet/yXzUFCcbPyBrGuQUFyl/5FExiqqWqwXnH3SFnpps4E
 SSHA5+sk8nAWDWiU7BqC2HrG29sQpzuvkY3QHIT1kA7Y6hKsQ6VCU5PXQznjV6qYrQHRA46yM+Z
 i6g11Qy8mYwl
X-Received: by 2002:a05:620a:2454:b0:7b6:d1e1:a22e with SMTP id
 af79cd13be357-7b86375d4e0mr451737185a.29.1734537089190; 
 Wed, 18 Dec 2024 07:51:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGvME7NcCBZ+j2j0Xy5p/avzgHoasJTbaPTs2iz+PHmpIddLI0h8fKIGz2IeecE75kvXUdQg==
X-Received: by 2002:a05:620a:2454:b0:7b6:d1e1:a22e with SMTP id
 af79cd13be357-7b86375d4e0mr451734385a.29.1734537088893; 
 Wed, 18 Dec 2024 07:51:28 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-49-186.web.vodafone.de.
 [109.42.49.186]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048ca123sm436753085a.101.2024.12.18.07.51.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 07:51:28 -0800 (PST)
Message-ID: <3399461b-b623-4950-a800-9e244dd10785@redhat.com>
Date: Wed, 18 Dec 2024 16:51:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] tests/functional: Convert the migration avocado
 test
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
References: <20241218131439.255841-1-thuth@redhat.com>
 <20241218131439.255841-6-thuth@redhat.com> <87o719umj5.fsf@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87o719umj5.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 18/12/2024 14.51, Fabiano Rosas wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> Now that we've got a find_free_port() function in the functional
>> test framework, we can convert the migration test, too.
>> While the original avocado test was only meant to run on aarch64,
>> ppc64 and x86, we can turn this into a more generic test by now
>> and run it on all architectures that have a default machine that
>> ships with a working firmware.
> 
> I'd rather drop this test. I haven't looked at it in ages and it has
> never been useful.

I think I agree for the scope of the old avocado test - x86, ppc64 and 
aarch64 certainly have better test coverage by the qtest already... but we 
don't have any test coverage for other architectures at all yet, which is 
bad (see below).

So if you like I can change the patch so that the test is not run on x86, 
ppc64 and aarch64 anymore, just on the other architectures that do not have 
test coverage by the qtest yet?

> I haven't been following the development of the
> functional suite so this might not apply this time (fingers crossed),
> but Python tests have always been a pain to work with.

Well, one of the motivations with the functional test framework was to 
simplify things. You can now run the individual tests without any test 
runner at all, what makes debugging way easier (see 
docs/devel/testing/functional.rst for details)!

> About adding more architectures to the set, this is not simply enabling
> more testing, it is also adding workload to maintain these other arches
> that were never tested with migration. Is that something we want?

I think yes. Otherwise the bugs are just dormant until someone hits the 
issue, making bisection way more complicated later.
Remember this one for example:

  https://mail.gnu.org/archive/html/qemu-commits/2023-02/msg00030.html

?

It would have been good to have a migration test for alpha in the CI, then 
we could have prevented that bug from being merged.

> Also note that what is actually prone to break is compatibility between
> versions, which is not covered by this test.

I think it should be possible to add such a check later.

  Thomas



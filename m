Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2601ECA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNDf-00024x-4a; Sat, 30 Aug 2025 11:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urvIf-0002oL-Dn
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 05:21:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urvIb-00073D-Vu
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 05:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756459290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/Xxe1Xaza81gAWBUjiT1e9Sb/zQjZiXsE91X1yR2E/I=;
 b=bhtpQpl9nqPu63l82b6/qfRv/RxL0+H8xBvBxi+Y4TZifs2X9DWfDYqdKpFyLvk78Z/PdB
 uWhlE8tn7KoRq9WfYbmrAVHip4V6d1HMVBH+MGyuEKXSfBwsqXT++829FQFjJaYRV4wP2r
 jQe315rL9XeNA14s9HCLmjZqE35MKxk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-QqLZzQkcPbKA4CVYqwLnRw-1; Fri, 29 Aug 2025 05:21:27 -0400
X-MC-Unique: QqLZzQkcPbKA4CVYqwLnRw-1
X-Mimecast-MFC-AGG-ID: QqLZzQkcPbKA4CVYqwLnRw_1756459286
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3c6abcfd218so1311627f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 02:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756459286; x=1757064086;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Xxe1Xaza81gAWBUjiT1e9Sb/zQjZiXsE91X1yR2E/I=;
 b=wGAURHWI+v9bIAbmo7LiMUVfADRyV9J8ddPXWuyqdHjY1GSXkxNSSzVXR1IaBn9fZK
 WGBs1kLYZvqrxDIyp+mfyKV8aueoBI+JEre56SZokUl9rO4cpiuj9BR+HG9w1dwa3orT
 N9EEm4v7KA09DlNQskyM/hybCvS/wMO0EL0xYVwfvPkFBcp5U7hXOFW1IYlIpxTAmB72
 MyHO9hwwFPPXHXC74vtvUVc86u9kuud066/lSHraDZ1x6G7CsVzZIKMyGSmgLuEgGiKQ
 MqUTzC8hdJHxPe0DzJZQbxwnOPCihmKlx30R+zRKEO53m9f6DxfBlzSPMx9/HfJ5VxG9
 0rnw==
X-Gm-Message-State: AOJu0YzxxHgiWHRDEWMEjwSRrbLhHNu9eWHmZnB1erWema6t1MTH6XuX
 REgo5pz+szWWF0ga8qJnuC6Apr8plmeLpvfqUknMfd6pIa7BeJFqNFgJKUxiTUuyDAAjboZMfl4
 9/c2aOizJjyzme1fyDYhaXHnsT6s4Y6OA+U8Ktx39UfsZWAuQKNvuXdr0QcQ56Cv5
X-Gm-Gg: ASbGncvFNBJquB1ZZQ/y2VyInzS7ElCbLab/mlljFBW1SVar0xmQyhN5T+J5LRo5uh5
 uHXRyDAkpO0JsKPuh/F46W/z/3+yokHnxtqNaOFHdj/ZExq/eGlLv+uhgDGUNJ00kyQqSPMnuaE
 t5JUuDKhi8RMg7gTmrffxcS4+9DGdoWDvYRXXd2+UxYJdgjl77a5BmVxVPiwnhtYlyjoAC5lWeg
 OqhvYnlTUrmR4jctWNMh04UZVhFL2eJ5k/G9juNAYFWpXMHnJALskGKYVqwsO+LLsJboVWY9VTt
 nGduy77MLT6HPzul/cd7nPbCcZFdIcTmwOi+GgLvF/jpb5fnf9xSLy3gmZc857qnxg4C
X-Received: by 2002:a5d:5d85:0:b0:3cb:9495:6241 with SMTP id
 ffacd0b85a97d-3cb949564d5mr9874928f8f.39.1756459285974; 
 Fri, 29 Aug 2025 02:21:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5RTPeO6tJ6h0eCkp8Z+QgDzdcNAEppKSh2emYElQrkBeEVdBHevn+xKotH+52Io/5pbLKJg==
X-Received: by 2002:a5d:5d85:0:b0:3cb:9495:6241 with SMTP id
 ffacd0b85a97d-3cb949564d5mr9874907f8f.39.1756459285532; 
 Fri, 29 Aug 2025 02:21:25 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-42-48-43.web.vodafone.de. [109.42.48.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6b99sm111163835e9.4.2025.08.29.02.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 02:21:24 -0700 (PDT)
Message-ID: <8ef54407-bf82-4ede-88df-9df38d462bca@redhat.com>
Date: Fri, 29 Aug 2025 11:21:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tests/functional: enable force refresh of cached
 assets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20250829083156.2570137-1-berrange@redhat.com>
 <20250829083156.2570137-2-berrange@redhat.com>
 <5f7a13e8-3971-442d-88ac-641460d289da@redhat.com>
 <aLFtD8B9yIWapvCs@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aLFtD8B9yIWapvCs@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 29/08/2025 11.04, Daniel P. Berrangé wrote:
> On Fri, Aug 29, 2025 at 10:50:41AM +0200, Thomas Huth wrote:
>> On 29/08/2025 10.31, Daniel P. Berrangé wrote:
>>> If the 'QEMU_TEST_REFRESH_CACHE' environment variable is set, then
>>> ignore any existing cached asset and download a fresh copy.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    docs/devel/testing/functional.rst   | 3 +++
>>>    tests/functional/qemu_test/asset.py | 4 ++++
>>>    2 files changed, 7 insertions(+)
>>>
>>> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
>>> index 3728bab6c0..fdeaebaadc 100644
>>> --- a/docs/devel/testing/functional.rst
>>> +++ b/docs/devel/testing/functional.rst
>>> @@ -312,6 +312,9 @@ The cache is populated in the ``~/.cache/qemu/download`` directory by
>>>    default, but the location can be changed by setting the
>>>    ``QEMU_TEST_CACHE_DIR`` environment variable.
>>> +To force the test suite to re-download the cache, even if still valid,
>>> +set the ``QEMU_TEST_REFRESH_CACHE`` environment variable.
>>> +
>>>    Skipping tests
>>>    --------------
>>> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
>>> index 704b84d0ea..b5a6136d36 100644
>>> --- a/tests/functional/qemu_test/asset.py
>>> +++ b/tests/functional/qemu_test/asset.py
>>> @@ -72,6 +72,10 @@ def _check(self, cache_file):
>>>            return self.hash == hl.hexdigest()
>>>        def valid(self):
>>> +        if os.getenv("QEMU_TEST_REFRESH_CACHE", None) is not None:
>>> +            self.log.info("Force refresh of asset %s", self.url)
>>> +            return False
>>> +
>>
>> Do we really need this? You can also simply "rm ~/.cache/qemu/downloads"
>> instead, or click on the "Clear runner caches" in the gitlab CI.
> 
> This can selectively refresh assets from a single test
> 
>    QEMU_TEST_REFRESH_CACHE=1 ./tests/functional/test_blah.py

Ok, fair point.

Reviewed-by: Thomas Huth <thuth@redhat.com>



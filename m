Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F233C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCXs-0008Mb-Ui; Fri, 12 Jul 2024 05:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sSCXr-0008Ky-3O
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sSCXl-0005ER-On
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720776378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PCc982YZQ6p32ujTJ1ZPfZhdVQADJOr9Nge9j+VWQQY=;
 b=duS6qQAP5C3DA0bMGCEFeCgce34ZXy3/Ks5bDOsE3DIRf/DgRI806rOVHQBw3i1bVZqCMc
 qoycdq3JgPPmCQgpuSDBzb3VCh8ThzZ44Ab/rrHICeO68VLw/BvXGnSRZ/uxPXwGxiA4ZM
 p+whMdX1gBogwy5hpmkIExvMGNGrfNk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-xED0poApNEaEkQarzjB7Hg-1; Fri, 12 Jul 2024 05:26:17 -0400
X-MC-Unique: xED0poApNEaEkQarzjB7Hg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a77c8d7b120so163422666b.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 02:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720776376; x=1721381176;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PCc982YZQ6p32ujTJ1ZPfZhdVQADJOr9Nge9j+VWQQY=;
 b=jNG2s3fYzap+uSueH9pP0LnQRyOaLWr7yjT5DfNiYR5yk0pVAx43t1b1tH/RzJepe/
 0C7lEkEu2xlcu9mDVzMhYFNozAc8J5KqBzF1g2e1Vcpb5aryOnEzUoi4B8NvdCxjwmbW
 esv5fl7EDpEb5asWcg36UGMSVZmBaoJd66j3CFc7n/a5r+dhFmXskM7mxB/qsrE3h/Gz
 zcWsXVC2V3vvVI7sQJkuP9BxNsaoEqGkn/+2VVgA1FRkFp7cGBYcAUVx9KOaXNGf0Xjv
 qLA+GcgTyi8h+koukxu3cgKtxAzLnm+vimqYVRH7x+5tQKAu85VENKMl/VsvfQFlX+R9
 YJQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFNvCWZ1se6nSKyiksTf7oxpgxqbnVPc7IhvXUCxgTpDj1uSBGjc6ym91R/IN2lsDIZ3KK8UQ7L6NnijO3YkTug+BQNsI=
X-Gm-Message-State: AOJu0Yxb8MqiHmZwS28j4Dt7s41RS9pcyoVVwSjBgqbKUCz4iEGLmrXu
 qiVP4tHb97nyXeFQTCsQKODQCcFLA8g9oS8whtBLOFBtWlEBziOc1kBi1IzThOzcldaMgAdsxnw
 Os0Lhhrea5k8SXIgRQgTsOqFA6L3G+gB2WnTrXrmgVbPemxQJ8OI7
X-Received: by 2002:a17:906:c00f:b0:a6f:cf64:a5d9 with SMTP id
 a640c23a62f3a-a780b885722mr597070466b.49.1720776375891; 
 Fri, 12 Jul 2024 02:26:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnLrrhgVkRa9mCVm/dJ3ru/Ui2W3GJUadjyEWYAmYoU76Pv7OlFM8j843QSqbhj18cr901Ng==
X-Received: by 2002:a17:906:c00f:b0:a6f:cf64:a5d9 with SMTP id
 a640c23a62f3a-a780b885722mr597069266b.49.1720776375437; 
 Fri, 12 Jul 2024 02:26:15 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-50-229.web.vodafone.de.
 [109.43.50.229]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7ff722sm324511166b.123.2024.07.12.02.26.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 02:26:15 -0700 (PDT)
Message-ID: <f850a8ab-1996-4ad2-bf51-2eddfa10494b@redhat.com>
Date: Fri, 12 Jul 2024 11:26:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/8] tests_pytest: Implement fetch_asset() method for
 downloading assets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-6-thuth@redhat.com> <ZpDyy6JAqhvPgx5M@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZpDyy6JAqhvPgx5M@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/07/2024 11.09, Daniel P. Berrangé wrote:
> On Thu, Jul 11, 2024 at 01:55:43PM +0200, Thomas Huth wrote:
>> In the pytests, we cannot use the fetch_asset() function from Avocado
>> anymore, so we have to provide our own implementation now instead.
>> Thus add such a function based on the _download_with_cache() function
>> from tests/vm/basevm.py for this purpose.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/pytest/qemu_pytest/__init__.py | 40 ++++++++++++++++++++--------
>>   1 file changed, 29 insertions(+), 11 deletions(-)
>>
>> diff --git a/tests/pytest/qemu_pytest/__init__.py b/tests/pytest/qemu_pytest/__init__.py
>> index e3ed32e3de..73d80b3828 100644
>> --- a/tests/pytest/qemu_pytest/__init__.py
>> +++ b/tests/pytest/qemu_pytest/__init__.py
>> @@ -11,6 +11,7 @@
>>   # This work is licensed under the terms of the GNU GPL, version 2 or
>>   # later.  See the COPYING file in the top-level directory.
>>   
>> +import hashlib
>>   import logging
>>   import os
>>   import shutil
>> @@ -201,17 +202,34 @@ def setUp(self, bin_prefix):
>>           self.assertIsNotNone(SOURCE_DIR,'PYTEST_SOURCE_ROOT must be set')
>>           self.assertIsNotNone(self.qemu_bin, 'PYTEST_QEMU_BINARY must be set')
>>   
>> -    def fetch_asset(self, name,
>> -                    asset_hash, algorithm=None,
>> -                    locations=None, expire=None,
>> -                    find_only=False, cancel_on_missing=True):
>> -        return super().fetch_asset(name,
>> -                        asset_hash=asset_hash,
>> -                        algorithm=algorithm,
>> -                        locations=locations,
>> -                        expire=expire,
>> -                        find_only=find_only,
>> -                        cancel_on_missing=cancel_on_missing)
>> +    def check_hash(self, file_name, expected_hash):
>> +        if not expected_hash:
>> +            return True
>> +        if len(expected_hash) == 32:
>> +            sum_prog = 'md5sum'
>> +        elif len(expected_hash) == 40:
>> +            sum_prog = 'sha1sum'
>> +        elif len(expected_hash) == 64:
>> +            sum_prog = 'sha256sum'
>> +        elif len(expected_hash) == 128:
>> +            sum_prog = 'sha512sum'
>> +        else:
>> +            raise Exception("unknown hash type")
> 
> Why shouldn't we just standardize on sha256 as we convert each test
> to pytest ? sha512 is overkill, and md5/sha1 shouldn't really be used
> anymore.

I mainly added that for minimizing the changes that I need to do on the 
existing tests. Updating all the hashsums there is certainly some additional 
work... If you want to help, feel free to send patches for the existing 
avocado tests to update the md5 and sha1 sums there!

>> +        checksum = subprocess.check_output([sum_prog, file_name]).split()[0]
>> +        return expected_hash == checksum.decode("utf-8")
>> +
>> +    def fetch_asset(self, url, asset_hash):
>> +        cache_dir = os.path.expanduser("~/.cache/qemu/download")
>> +        if not os.path.exists(cache_dir):
>> +            os.makedirs(cache_dir)
>> +        fname = os.path.join(cache_dir,
>> +                             hashlib.sha1(url.encode("utf-8")).hexdigest())
>> +        if os.path.exists(fname) and self.check_hash(fname, asset_hash):
>> +            return fname
>> +        logging.debug("Downloading %s to %s...", url, fname)
>> +        subprocess.check_call(["wget", "-c", url, "-O", fname + ".download"])
>> +        os.rename(fname + ".download", fname)
>> +        return fname
> 
> To avoid a dep on an external command that may not be installed,
> I think we could replace wget with native python code:
> 
>   import urllib
...

Yes, I came across urllib after I sent out the patches, too, sounds like the 
right way to go. We should also update tests/vm/basevm.py accordingly!

  Thomas




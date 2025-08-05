Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC27FC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 14:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujIEa-0007Qz-O2; Tue, 05 Aug 2025 10:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ujI9m-00033l-6x
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ujI9k-0008Qw-3B
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754402201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7yt66P0CtyWAyIak7oD9wtjfIjt/xaFwlpHjSFUdZaU=;
 b=JZYjPv9v62doy2T9XnJBfiWvrWAlnpRtLEx2TMBL307xopDZufBOTCNTxpET/BbN9Z7bI5
 4NuPW0+YEAVtVEE2QkmiFv2ioJ4+nYV4bJpQA54IkMqAcwf8bJoGB5MR369EndKxlWdRxS
 gYg2PXR7qnYxVJgBw8Dc1qUszv1JOmU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-b3eELYIgOVa1mhYzW_W6Iw-1; Tue, 05 Aug 2025 09:56:39 -0400
X-MC-Unique: b3eELYIgOVa1mhYzW_W6Iw-1
X-Mimecast-MFC-AGG-ID: b3eELYIgOVa1mhYzW_W6Iw_1754402199
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-7074bad04efso99072156d6.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 06:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754402199; x=1755006999;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7yt66P0CtyWAyIak7oD9wtjfIjt/xaFwlpHjSFUdZaU=;
 b=Mg+rr7jo7SuILE2cLhUzqYRlf17IQPQcKvJZr+iZwL/JCrCMMTeSq2b3QE6uPYkLDr
 zsl3DgkiSLORehApNDB/n7tkcDCev2fFVQMBABkis48FstGTFArAowg3o54ixVNJD//E
 AuYWlDRpm78+7T5dfoNx9HrKhJGw88m6lp3NkfyJulj1egBHJ9P4ZzCLFeo1x+f4PEzU
 hLIuLFnhcPHEMyjRBMGLd13bCsMuaYTeCmc2lQ18fRque8zkrqctfHl+qb43aRNVhfiN
 jiggqBgsQlDcJWydKgKQ/82SMhp2p6sV++HyM4Fj6n5H6DL+wjm8sPjB1kBTKZCqfz5X
 HY/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCIlx31Jp0mbzmXYCjzHmaWN5ZIpO0UIAijazlEW4q7rxSqPoAOdCyX2C+bku6Mm3/l8TEKVnZ0wbK@nongnu.org
X-Gm-Message-State: AOJu0Yzu61uQdMt7MRwwtafS2AhsmoSe1WYNfiQ5dwOrrZQQHu2Dt0jE
 TTiEIQ7hHsUE8/Ip4F+bRZhc3IQQ6tAZRP/zVQeGF2k7CtOiLtRTSWDlTOgLIBQUqN5f09JP1kA
 cygMntUyhEgl07AGBPlWQzGdCxX4+FMxilhQQDbinkhQFm5VD8xg1EH/p
X-Gm-Gg: ASbGncvgcuZdoig5lZXDM2s2zQu6wc1maVRbTAfKkrCEMfDfc0MsZadPV2WC1/R0s67
 Ci5ZCjKrUak9EAvQNsH0dx1sx/yt+SlIAM5tgENKBAVdw4VIpzGY4E/HQp3KPwBTWEnl2qBPTHm
 /LLtC1OVNMnQy7Ga2lwM+Y98FAqsJATBYrIlwH9u3iSRs4/u0dI5sAUssH71MRF9WW0H8uOZdti
 Xan5O2Ny0OT9bPUAJSebXbxwrBji1vpRpXq6SxY0Gsv8yzkSl79NbS7aqgEUvAoEO3KMCuz3YuR
 R4vZkReHYZ4wPJ8YVoq4lZgVUqas18pY+OR5vVHVW24JocD5mm+kg6xA82a8Au+D
X-Received: by 2002:ad4:5e89:0:b0:707:844:9b with SMTP id
 6a1803df08f44-7096692a6e8mr47451106d6.5.1754402198721; 
 Tue, 05 Aug 2025 06:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnEdHDSVxQpbW5A6VeahJZ3BqZzv7mANhfsn3MHxo0DGUwY6DaEfwLXKx4jBj6A6DGSm3oDg==
X-Received: by 2002:ad4:5e89:0:b0:707:844:9b with SMTP id
 6a1803df08f44-7096692a6e8mr47450676d6.5.1754402198255; 
 Tue, 05 Aug 2025 06:56:38 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ca3621asm71463746d6.33.2025.08.05.06.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 06:56:37 -0700 (PDT)
Message-ID: <d80ee30f-e5e7-4c6c-aa63-5d13e8ba6d5f@redhat.com>
Date: Tue, 5 Aug 2025 15:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/24] tests/functional: Move mips tests into
 target-specific folders
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-15-thuth@redhat.com>
 <ca897537-bbfd-47ed-b80e-66f357ef5995@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ca897537-bbfd-47ed-b80e-66f357ef5995@linaro.org>
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

On 04/08/2025 10.31, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 1/8/25 17:12, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The tests/functional folder has become quite crowded, thus move the
>> mips tests into a target-specific subfolder.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   MAINTAINERS                                   |  8 ++--
>>   tests/functional/meson.build                  | 47 ++-----------------
>>   tests/functional/mips/meson.build             | 11 +++++
>>   .../test_malta.py}                            |  0
>>   .../test_replay.py}                           |  0
>>   .../test_tuxrun.py}                           |  0
>>   tests/functional/mips64/meson.build           | 10 ++++
>>   .../test_malta.py}                            |  2 +-
>>   .../test_tuxrun.py}                           |  0
>>   tests/functional/mips64el/meson.build         | 14 ++++++
>>   .../test_fuloong2e.py}                        |  0
>>   .../test_loongson3v.py}                       |  0
>>   .../test_malta.py}                            |  4 +-
>>   .../test_replay.py}                           |  0
>>   .../test_tuxrun.py}                           |  0
>>   tests/functional/mipsel/meson.build           | 12 +++++
>>   .../test_malta.py}                            |  2 +-
>>   .../test_replay.py}                           |  0
>>   .../test_tuxrun.py}                           |  0
>>   19 files changed, 59 insertions(+), 51 deletions(-)
>>   create mode 100644 tests/functional/mips/meson.build
>>   rename tests/functional/{test_mips_malta.py => mips/test_malta.py} (100%)
>>   rename tests/functional/{test_mips_replay.py => mips/test_replay.py} (100%)
>>   rename tests/functional/{test_mips_tuxrun.py => mips/test_tuxrun.py} (100%)
>>   create mode 100644 tests/functional/mips64/meson.build
>>   rename tests/functional/{test_mips64_malta.py => mips64/test_malta.py} 
>> (96%)
>>   rename tests/functional/{test_mips64_tuxrun.py => mips64/test_tuxrun.py} 
>> (100%)
>>   create mode 100644 tests/functional/mips64el/meson.build
>>   rename tests/functional/{test_mips64el_fuloong2e.py => mips64el/ 
>> test_fuloong2e.py} (100%)
>>   rename tests/functional/{test_mips64el_loongson3v.py => mips64el/ 
>> test_loongson3v.py} (100%)
>>   rename tests/functional/{test_mips64el_malta.py => mips64el/ 
>> test_malta.py} (98%)
>>   rename tests/functional/{test_mips64el_replay.py => mips64el/ 
>> test_replay.py} (100%)
>>   rename tests/functional/{test_mips64el_tuxrun.py => mips64el/ 
>> test_tuxrun.py} (100%)
>>   create mode 100644 tests/functional/mipsel/meson.build
>>   rename tests/functional/{test_mipsel_malta.py => mipsel/test_malta.py} 
>> (98%)
>>   rename tests/functional/{test_mipsel_replay.py => mipsel/test_replay.py} 
>> (100%)
>>   mode change 100644 => 100755
>>   rename tests/functional/{test_mipsel_tuxrun.py => mipsel/test_tuxrun.py} 
>> (100%)
> 
> 
>> +subdir('mips')
>> +subdir('mipsel')
>> +subdir('mips64')
>> +subdir('mips64el')
> 
> Just one single comment here. I'd rather have a single mips/ directory
> and keep the variants inside it, i.e.:
> 
>    tests/functional/mips/test_mips64el_malta.py

That would make it very cumbersome to determine which qemu-system-mips* 
binary we'd need for those tests. Currently the tests for each 
qemu-system-xyz are simply looked up in the xyz subfolder. If we put all 
mips targets into one folder, we'd need to add some special case logic which 
I'd really like to avoid.
And in case the mips targets get unified later, we still can simply move the 
tests to one folder again, there is no hurry to do this right now already.

  Thomas



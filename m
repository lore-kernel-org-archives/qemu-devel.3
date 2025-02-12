Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB67CC0219B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 01:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti1is-0004i6-Or; Tue, 11 Feb 2025 20:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ti1ip-0004gn-Q8
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 20:39:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ti1im-0003VO-Vz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 20:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739324363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DBDk+V2O+YxF72h9wMsHmtzA6BdM9CQ82+2NNlJUBDY=;
 b=AjUcGg0FHRdviP2gB6ICR9kFhYU+IHdjIOoUYDMi6ncIG6HYn244v2FUMxJGrkyDMMDAeA
 +K4ak1FdUDL2mcIaf9kLT1G7dVWClcRjhwgf8ue9DVviQxJNIl3UIxaFRZX20Lx86kSkVS
 s/PzIQeqZyoGtmvAR/clfnaBKpxj/e0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-S3OHBGSyNjixhf48yhG9tA-1; Tue, 11 Feb 2025 20:39:21 -0500
X-MC-Unique: S3OHBGSyNjixhf48yhG9tA-1
X-Mimecast-MFC-AGG-ID: S3OHBGSyNjixhf48yhG9tA_1739324360
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38de0201875so1287664f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 17:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739324360; x=1739929160;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DBDk+V2O+YxF72h9wMsHmtzA6BdM9CQ82+2NNlJUBDY=;
 b=Np4lMAT77TiqypD3uAHhCwMuFgMk9KDVYEEGrM4DsOB44bkYr2qHuCiNJ/jy0okzsK
 mh/VWXtd/Wrzr3TBpctvQzE+Mb+QuzuAh5WdTxc1vXYnMZneq64wzzD5NmxWDiNibRs/
 mSr9D0joqMin7pvzKMFHeNbLKUist1/PMb0ST3XSXLnsOl8OLadBE0qN/iuR/WrGpmZS
 jKAXMMxfDponRj2BndxqV8iUI6NvnbxgsBPpUvkqT1UlNL0yOdJsOecOpJ/FH3QmccRN
 A2mG2KQjfz0OUFydXdrnw0SAGDR1mqs+EaDNc4XVPPEO4ftEitAI7iZ4tWJOdRNvtwKr
 AgOw==
X-Gm-Message-State: AOJu0YxnUGC9c2w20TKG97RgjVywMkwoOxHRN+WOY+qeViupGFX3L/8Q
 gpCMr2nc8UGLdwTyx0TZEhKCyhVOncXJi8fCRLi6Ww4Lz1X5JDoYPGiOaBqZ1zpAo08ZFI71vcb
 HtO4IeVY+FZ0eMQPSzEIcXpyzsHIacA5+XVDudw+bG8E2ziK5m84/z+Isq09Z
X-Gm-Gg: ASbGncs/Yrnt1sIaVbAl+RtURR0iTlsR6Bj2aUNsGy86SwFV3L2P9zY4HZMFtOD+jgV
 NGXjMWIxUJLy0E3y5CgQGFaMXKOpD1tWxSzIreH/dwmwcMaNWKj+XLdXFqBBAc54xOELUxzpnaJ
 tk984AY9sfmg4xK7io3ZjFTemxdVQt0n9F4TVUdR2ziU9KNko4ycUe9W7LCMu7K7h0+glL0FF4R
 BIEvkMfXUUT3ys4joCfj+IHGI6w0FhDgFBUfuhBnkKpzKBmQG8YETbccOZTmSsVDL7mUwZ17bua
 mHMKDtdOp7ACEeb0mncuuqjhrRBUV5HCxg==
X-Received: by 2002:adf:f38c:0:b0:38d:dff3:b8aa with SMTP id
 ffacd0b85a97d-38dea26531bmr656706f8f.18.1739324360326; 
 Tue, 11 Feb 2025 17:39:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUDiFayAsVisc3H3eUaHzG9EExltkK5cIvsn5ZJ3eGemiV2fnSNl0xG5Fmrl0K9qS7pIQVWg==
X-Received: by 2002:adf:f38c:0:b0:38d:dff3:b8aa with SMTP id
 ffacd0b85a97d-38dea26531bmr656695f8f.18.1739324359844; 
 Tue, 11 Feb 2025 17:39:19 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-37.web.vodafone.de. [109.42.48.37])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc2f6aeafsm14911907f8f.20.2025.02.11.17.39.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 17:39:19 -0800 (PST)
Message-ID: <82b70c1e-fc21-47b1-bfcc-167399af1882@redhat.com>
Date: Wed, 12 Feb 2025 02:39:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] Misc HW patches for 2025-02-10
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250210204204.54407-1-philmd@linaro.org>
 <CAJSP0QWH2+sLaNGwwLTQr5Kud6kKLML_Y24M=Kz1GSX9yRxDQw@mail.gmail.com>
 <f28e0b87-9bb2-4bb3-8c10-1f3ff0f784c2@linaro.org>
 <1ddb567a-7261-4831-9f46-7c247969a86d@linaro.org>
 <39314f09-268f-48b8-add5-95366c254f81@linaro.org>
 <6e62808e-0fc2-4de0-a732-621e81f1937e@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <6e62808e-0fc2-4de0-a732-621e81f1937e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/02/2025 01.41, Thomas Huth wrote:
> On 11/02/2025 20.03, Philippe Mathieu-Daudé wrote:
>> On 11/2/25 19:53, Philippe Mathieu-Daudé wrote:
>>> On 11/2/25 19:48, Philippe Mathieu-Daudé wrote:
>>>> On 11/2/25 19:26, Stefan Hajnoczi wrote:
>>>>> On Mon, Feb 10, 2025 at 3:43 PM Philippe Mathieu-Daudé
>>>>> <philmd@linaro.org> wrote:
>>>>>>
>>>>>> The following changes since commit 
>>>>>> 54e91d1523b412b4cff7cb36c898fa9dc133e886:
>>>>>>
>>>>>>    Merge tag 'pull-qapi-2025-02-10-v2' of https://repo.or.cz/qemu/ 
>>>>>> armbru into staging (2025-02-10 10:47:31 -0500)
>>>>>>
>>>>>> are available in the Git repository at:
>>>>>>
>>>>>>    https://github.com/philmd/qemu.git tags/hw-misc-20250210
>>>>>>
>>>>>> for you to fetch changes up to 1078a376932cc1d1c501ee3643fef329da6a189a:
>>>>>>
>>>>>>    hw/net/smc91c111: Ignore attempt to pop from empty RX fifo 
>>>>>> (2025-02-10 21:30:44 +0100)
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> Misc HW patches
>>>>>>
>>>>>> - Use qemu_hexdump_line() in TPM backend (Philippe)
>>>>>> - Make various Xilinx devices endianness configurable (Philippe)
>>>>>> - Remove magic number in APIC (Phil)
>>>>>> - Disable thread-level cache topology (Zhao)
>>>>>> - Xen QOM style cleanups (Bernhard)
>>>>>> - Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE (Philippe)
>>>>>> - Invert logic of machine no_sdcard flag (Philippe)
>>>>>> - Housekeeping in MicroBlaze functional tests (Philippe)
>>>>>
>>>>> Please take a look at this CI failure:
>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/9106591368
>>>>
>>>> Hmm I can not reproduce locally this error:
>>>>
>>>>    Exception: Asset cache is invalid and downloads disabled
>>>
>>> OK, I could reproduce by blowing my cache away.
>>>
>>> The problem seems in the "tests/functional: Have microblaze tests
>>> inherit common parent class" patch, which does:
>>>
>>> -class MicroblazeelMachine(QemuSystemTest):
>>> +class MicroblazeLittleEndianMachine(MicroblazeMachine):
>>>
>>> I presume, since MicroblazeLittleEndianMachine is no more a direct
>>> child of QemuSystemTest, then the ASSET_IMAGE_* aren't automatically
>>> downloaded.
>>
>> Well, apparently related to network failure:
>>
>> INFO:qemu-test:Downloading http://www.qemu-advent-calendar.org/2023/ 
>> download/day13.tar.gz to /Users/philmd/.cache/qemu/download/ 
>> b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22...
>> ERROR:qemu-test:Unable to download http://www.qemu-advent- 
>> calendar.org/2023/ download/day13.tar.gz: HTTP Error 403: Forbidden
>>
>> $ curl -v http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz
>>  > GET /2023/download/day13.tar.gz HTTP/1.1
>> < HTTP/1.1 301 Moved Permanently
>> < Location: https://www.qemu-advent-calendar.org/2023/download/day13.tar.gz
>>
>> Using:
>>
>> -- >8 --
>> diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/ 
>> functional/test_microblaze_s3adsp1800.py
>> index 177c8a685bc..949e627c84a 100755
>> --- a/tests/functional/test_microblaze_s3adsp1800.py
>> +++ b/tests/functional/test_microblaze_s3adsp1800.py
>> @@ -24,3 +24,3 @@ class MicroblazeMachine(QemuSystemTest):
>>       ASSET_IMAGE_LE = Asset(
>> -        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
>> + ('https://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
>>
>> 'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
>> ---
>>
>> I still get:
>>
>> INFO:qemu-test:Downloading https://www.qemu-advent-calendar.org/2023/ 
>> download/day13.tar.gz to /Users/philmd/.cache/qemu/download/ 
>> b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22...
>>
>> However:
>>
>> $ curl --http1.0 -v https://www.qemu-advent-calendar.org/2023/download/ 
>> day13.tar.gz
>>  > GET /2023/download/day13.tar.gz HTTP/1.0
>> < HTTP/1.0 200 OK
>> < Content-Length: 4752277
>> < Content-Type: application/gzip
>>
>> So I'm confused...
> 
> Looks like this also happens in test runs without your patches:
> 
>   https://gitlab.com/qemu-project/qemu/-/jobs/9108828196#L844
> 
> The test then silently gets skipped there (since we only fail hard for a 404 
> error now).
> 
> Maybe Eldon could comment why the downloads are blocked for python scripts 
> but not for curl downloads?
> 
> I the worst case, we have to mirror the asset to another place, I guess...

Ok, I've now also put the image here:

  https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day05.tar.xz

(just had to use a different day number there since 13 was an image that I 
did not want to sacrifice in the best-of roaster).

So if the qemu-advent-calendar.org server keeps refusing the downloads, you 
should be able to use the mirrored tarball instead.

  HTH,
   Thomas



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D276C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 08:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgJqR-00013C-BW; Tue, 20 Aug 2024 04:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sgJqO-00012d-Sm
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 04:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sgJqN-0000MC-5Y
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 04:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724141031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NI81po6621g+C7AXH85dtf6lulHzrisItVETYy5pDZA=;
 b=U4K/ec2j22C0Xj9T+FKVbsOtjC2BVU/sdDCf2Ob3Dwep2VGuoZwYgt4XlLUhD+nSbEfFXr
 iN/6S0eE/SeDQMrqiUKNlFL+UozCQ10wbSg7LNR/Wwla2vXNL9n5UsRmsDfxoE5vdf3J0j
 FHsoyqWE82o6zXDSQLNWTfYdKDaVOac=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-vrDEqJBPPB6fzcRU0-vIyg-1; Tue, 20 Aug 2024 04:03:48 -0400
X-MC-Unique: vrDEqJBPPB6fzcRU0-vIyg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52efb74f550so2853245e87.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 01:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724141027; x=1724745827;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NI81po6621g+C7AXH85dtf6lulHzrisItVETYy5pDZA=;
 b=XOZbGEhM6aQ6+/NgHaHwSh6z3fSFOsbvAAp+i/brEl6eOi81h6CvMEj6XPcIwV4Opu
 btaVFLJJZsGkvvpYqHOVIhaG6K5X+v82CDDhs2If8bwxuSEshng+HOKrd7po9nM983UA
 RG/tk/6cJihN11MUagCTczvz4PE7PT4uD52HJ4XYLMomP3LyjhcTrgzP/PWvVRliFI95
 H+DpCGdX/+tT/T9Kxx7G9QOBmNpSRnhyn+DXCh8fwdxLkGepDH8IyL5YOXvLFNdNOSt1
 o8uEWoFAJhO1hxEvMAVvvSDBqwTHUkhB2u0k5hNlJwaAzdpXw0BGKY7ndDN703v4e4X3
 uevw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTBghAJf93Fl2jBZFU1PWsQLemdI3nqCc2wOyRllyUVB6bSxvvtOPzNUDy+5CEVxfFzKCAAYJ5epF7@nongnu.org
X-Gm-Message-State: AOJu0YwosNceRJAS9erYp0ZFtED37vE0FjxTgH1QdSSHXmgDuhVu4coV
 1kfrVQT6y0+ZUvXVfJ1NCqb86hfquIN1DFVWcVephHQgsnrQ6N16L7l5Gxjy0ewBddapSV+aJVo
 8AlXreiT8pU9JeK9euWDA2Hztfg/MRqwPZQkm97L63BjZsd0TDQNu
X-Received: by 2002:a05:6512:3ca6:b0:52e:6d71:e8f1 with SMTP id
 2adb3069b0e04-5331c6e5392mr7411067e87.53.1724141027250; 
 Tue, 20 Aug 2024 01:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP5LCRh9JAxtYGFGA3xYH5E+OBgHzMa2Wgaxs7FDD3DbcA5OgR1D/rt5YovdBOBk7HPJlM0g==
X-Received: by 2002:a05:6512:3ca6:b0:52e:6d71:e8f1 with SMTP id
 2adb3069b0e04-5331c6e5392mr7411034e87.53.1724141026596; 
 Tue, 20 Aug 2024 01:03:46 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-41.web.vodafone.de.
 [109.43.177.41]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c6760sm725734166b.23.2024.08.20.01.03.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 01:03:46 -0700 (PDT)
Message-ID: <8a707365-0613-4792-96e6-a494581fa368@redhat.com>
Date: Tue, 20 Aug 2024 10:03:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/5] tests/avocado: apply proper skipUnless decorator
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20240816072218.27125-1-thuth@redhat.com>
 <20240816072218.27125-4-thuth@redhat.com>
 <300b1324-a527-49af-bf62-ebd5c72368a2@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <300b1324-a527-49af-bf62-ebd5c72368a2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/08/2024 00.31, Philippe Mathieu-Daudé wrote:
> On 16/8/24 09:22, Thomas Huth wrote:
>> From: Cleber Rosa <crosa@redhat.com>
>>
>> Commit 9b45cc993 added many cases of skipUnless for the sake of
>> organizing flaky tests.  But, Python decorators *must* follow what
>> they decorate, so the newlines added should *not* exist there.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>> Message-ID: <20240806173119.582857-3-crosa@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/avocado/boot_linux_console.py | 1 -
>>   tests/avocado/intel_iommu.py        | 1 -
>>   tests/avocado/linux_initrd.py       | 1 -
>>   tests/avocado/machine_aspeed.py     | 2 --
>>   tests/avocado/machine_mips_malta.py | 2 --
>>   tests/avocado/machine_rx_gdbsim.py  | 1 -
>>   tests/avocado/reverse_debugging.py  | 4 ----
>>   tests/avocado/smmu.py               | 1 -
>>   8 files changed, 13 deletions(-)
> 
> 
>> diff --git a/tests/avocado/machine_rx_gdbsim.py 
>> b/tests/avocado/machine_rx_gdbsim.py
>> index 412a7a5089..9a0bec8a6e 100644
>> --- a/tests/avocado/machine_rx_gdbsim.py
>> +++ b/tests/avocado/machine_rx_gdbsim.py
>> @@ -49,7 +49,6 @@ def test_uboot(self):
>>           #exec_command_and_wait_for_pattern(self, 'version', gcc_version)
>>       @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on 
>> GitLab')
>> -
>>       def test_linux_sash(self):
>>           """
>>           Boots a Linux kernel and checks that the console is operational.
> 
> For some weird reason a part of this patch is missing...

I dropped it on purpose since there was another patch on the list that drops 
that decorator completely.

  Thomas



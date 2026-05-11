Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A321DCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 16:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMTcm-0001LT-3d; Mon, 11 May 2026 12:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMTcl-0001LD-0V
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMTci-0006fy-IJ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778517409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aH30WDLiOnmNkuasp1zcyp33GaTK+i4jIViESV5IzS8=;
 b=OToR+Jv8HLxITsHXZGTfyahbQKoK8nipl/t9nP7Hl3Cbju/RFDMetLKR4sZJayinOEy5oK
 ylABvcjsLvnenYManqDfzd13En7mkpTG9agpwgLqAwhmMFnx/Wl9VNOCc5YyyPbF2X/pSY
 Nfb8/U6go1oUweBzeVPVoxSTHm/fmcU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-Oqc2ij02N_mVyNchIbSUQg-1; Mon, 11 May 2026 12:36:48 -0400
X-MC-Unique: Oqc2ij02N_mVyNchIbSUQg-1
X-Mimecast-MFC-AGG-ID: Oqc2ij02N_mVyNchIbSUQg_1778517407
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d7730e9e3so2975100f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778517407; x=1779122207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=aH30WDLiOnmNkuasp1zcyp33GaTK+i4jIViESV5IzS8=;
 b=HrUcVIu68kGUqyBGiI18/WFp8BXFqaoAjBZpudqINI1fGiqHj0uaeTJx2ZB/DiLDSD
 wB81aK9q4jVTC78ASiPckuiYD5N/sMNBhtaH8gGjJJB/HchHk1vTTJ/PaxKV2+jZeGvS
 urQkqvcOvBrIYbSJum1opDANzv613OuyEAA7kjJ6VnF2gaFkxnHxo29JJXJKH7mXYBxT
 +gAfCC78cWZt4h2Y6PC+UpMCJWIJCSGpSGkkS/p7QvPJlqDjVKiYKfxaUCkY/jPgYvhP
 R5iZG1qlmGJHoA5exuIbtiK9Z0lrFkVudb5BNqF3XHmfj19SAh1WNljeCW379T0F63zn
 Q5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778517407; x=1779122207;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aH30WDLiOnmNkuasp1zcyp33GaTK+i4jIViESV5IzS8=;
 b=VHaiGuOzahfqxP8bnO2iptFZO2yRxea9OZLkBi68rznDP13W0tZdorUDLTlJVlX8Um
 WSDdEXRBcxBFlPFWYwgiL+fldeZyA72DNY7HsirzvuDwVfTEYLYMNyCeFDWBCuF382v4
 Lf79vSGUshCplEhb94DSDFti0Jk++lB3AwqHptiXqZVTm3o/r9Rz05DxGzo3kvB8jpAN
 1NfTL8KiZ1hyx00uM+eqrfWwapOk4imkdterk5rSsBwWEDqMnGs5Mz1AFzCzLaNlRVsZ
 jk70mjQbaYk1JWC6iZgvQSFjCDU9X3Qhb8WgDOex8ql3dBnh+TaEZnebtWGfoPKTyN0w
 WOvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PWV+5FUm7TlUll+qjKDryzdNMk+Apcm5RaWvASMSUPUHO+zWh9Irsq4BvcqytFjNpE7CLT+jn1uiG@nongnu.org
X-Gm-Message-State: AOJu0Yxz8LM0DLFjo7Ndk341icQJx8VM5vXjGHvwOlwZOOySVMU93thX
 aaXX2v6YZhAe2a4DQTn4jlVlrg9e1Xt8NYi+NfYg7xiKlF0+2i62+RRT9uEWNVGlLt5IAYC/KLM
 Jd2UwqDWXtPZiEj/CCWHLWIEqpXhsBVrbSp3McBFCl8zJiRWze4nJG+9P
X-Gm-Gg: Acq92OHTT9LhvHNaLJfoM24wKFoEp5QdJ78qhTIpco7q1+s5q7YhZdKEAQuWDpxtfA/
 976KazB6JtvU8+QJMx+oDRB5M/F1snAWoCJyIM4U5JwbdVmQRkmpQI2Ow9UTtRj+ZtJGc32dRCP
 MVXutonbdHVMm/CsM/3pS6GEz3suf+XaFrGpQSqFnWcKfyUeZDCbSlJEO9Vv6D3DtfKQAjVh6sZ
 XmEC8pARmCM21BQLRZU3wfLQzfV0XZ0zBsht1Ub7ABHWxm0/KoPSCEEmviEysdy7FlrYTTtCoG+
 kTwMRXvj0cWerUrzM1zWJ2tjQ3bVcQwGgi2kHGwbVG9F6Xol6bPnnN6bRV+bt4aPnjayN2sHEZB
 QXgqL/iMXKh8IwxglVm9zyPr6dS11iu5esZ5KafwEB1m8HdEkiYFazauCJmTF
X-Received: by 2002:a5d:5d84:0:b0:43c:fe66:43ec with SMTP id
 ffacd0b85a97d-4515ad7670emr43502094f8f.14.1778517406879; 
 Mon, 11 May 2026 09:36:46 -0700 (PDT)
X-Received: by 2002:a5d:5d84:0:b0:43c:fe66:43ec with SMTP id
 ffacd0b85a97d-4515ad7670emr43502034f8f.14.1778517406361; 
 Mon, 11 May 2026 09:36:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6cd75sm25488351f8f.16.2026.05.11.09.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 09:36:45 -0700 (PDT)
Message-ID: <40f3f863-04fe-4eb5-9672-a21ae4fca950@redhat.com>
Date: Mon, 11 May 2026 18:36:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
To: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>
References: <20260506135524.20617-1-philmd@linaro.org>
 <20260506135524.20617-90-philmd@linaro.org>
 <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
 <90ea3dacb27252a623c0f95bad334e4702222d83.camel@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <90ea3dacb27252a623c0f95bad334e4702222d83.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/11/26 17:58, Eric Farman wrote:
> On Mon, 2026-05-11 at 17:48 +0200, Cédric Le Goater wrote:
>> Hello,
>>
>> On 5/6/26 15:55, Philippe Mathieu-Daudé wrote:
>>> Introduce a source set common to system / user. Start it
>>> with the files built in both sets: 'cpu_models_user.c'
>>> and 'gdbstub.c' No logical change intended.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> Message-Id: <20260423135035.50126-4-philmd@linaro.org>
>>
>> This change introduced a regression with PCI passthrough which
>> stopped working. Guest kernel reports :
>>
>>     [    0.156501] zpci: PCI is not supported because CPU facilities 69 or 71 are not available
>>
>> and other devices (ap, ccw) are impacted too I think.
>>
>>> ---
>>>    target/s390x/meson.build | 25 +++++++++++++------------
>>>    1 file changed, 13 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/target/s390x/meson.build b/target/s390x/meson.build
>>> index 6f98ce34d73..44f58ac2919 100644
>>> --- a/target/s390x/meson.build
>>> +++ b/target/s390x/meson.build
>>> @@ -1,4 +1,9 @@
>>>    s390x_ss = ss.source_set()
>>> +s390x_common_ss = ss.source_set()
>>> +s390x_common_system_ss = ss.source_set()
>>> +s390x_system_ss = ss.source_set()
>>> +s390x_user_ss = ss.source_set()
>>> +
>>>    s390x_ss.add(files(
>>>      'cpu.c',
>>>      'cpu_features.c',
>>> @@ -15,15 +20,16 @@ gen_features_h = custom_target('gen-features.h',
>>>                                   capture: true,
>>>                                   command: gen_features)
>>>    
>>> -s390x_ss.add(gen_features_h)
>>> +s390x_common_ss.add(gen_features_h)
>>> +s390x_common_ss.add(files(
>>> +  'cpu_models_user.c',
>>> +  'gdbstub.c',
>>> +))
>>>    
>>> -s390x_system_ss = ss.source_set()
>>>    s390x_system_ss.add(files(
>>>      'ioinst.c',
>>>    ))
>>>    
>>> -s390x_common_system_ss = ss.source_set()
>>> -s390x_common_system_ss.add(gen_features_h)
>>>    s390x_common_system_ss.add(files(
>>>      'helper.c',
>>>      'arch_dump.c',
>>> @@ -32,19 +38,14 @@ s390x_common_system_ss.add(files(
>>>      'mmu_helper.c',
>>>      'sigp.c',
>>>      'cpu-system.c',
>>> -  'cpu_models_system.c',
>>
>> This file is compiled anymore and the CPU features and facilities are
>> not propagated to the guest anymore.
>>
>> Without this patch, cpuinfo reports :
>>
>>     features	: esan3 zarch stfle msa ldisp eimm dfp edat etf3eh highgprs te vx vxd vxe gs vxe2 vxp sort dflt vxp2 nnpa
>>     facilities      : 0 1 2 3 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 30 31 32 33 34 35 36 37 38 40 41 42 43 44 45 47 48 49 50 51 52 53 54 57 58 59 60 61 64 65 69 71 72 73 74 75 76 77 78 80 81 82 129 130 131 133 134 135 138 139 140 146 147 148 150 151 152 155 156 165 192 193 194 196 197
>>
>> with :
>>
>>     features	: esan3 zarch stfle msa ldisp eimm dfp edat etf3eh highgprs te vx vxd vxe gs vxe2 vxp sort dflt vxp2
>>     acilities      : 0 1 2 3 4 6 7 8 9 10 11 13 14 16 17 18 19 20 21 22 23 24 25 26 27 28 30 31 32 33 34 35 36 37 38 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 57 58 59 60 61 64 72 73 74 75 76 77 78 80 81 82 129 130 131 133 134 135 138 139 146 147 148 150 151 152 155 192
>>
> 
> Thanks, Cedric... I wonder if the above is addressed by this patch? (I haven't checked yet, but will
> do that now.)
> 
> https://lore.kernel.org/qemu-devel/20260510204640.2178926-1-marcandre.lureau@redhat.com/

Something like below seems to work.

C.


@@ -22,7 +22,6 @@ gen_features_h = custom_target('gen-feat
  
  s390x_common_ss.add(gen_features_h)
  s390x_common_ss.add(files(
-  'cpu_models_user.c',
    'gdbstub.c',
  ))
  
@@ -38,8 +37,11 @@ s390x_common_system_ss.add(files(
    'mmu_helper.c',
    'sigp.c',
    'cpu-system.c',
+  'cpu_models_system.c',
  ))
  
+s390x_user_ss.add(files('cpu_models_user.c'))
+
  subdir('tcg')
  subdir('kvm')
  




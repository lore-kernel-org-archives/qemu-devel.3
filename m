Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E765D7833D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAQI-00088C-WA; Mon, 02 Dec 2024 12:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIAQH-00087j-DG
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:41:25 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIAQF-0004Ys-Di
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:41:25 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-21539e1d09cso40900675ad.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733161282; x=1733766082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7LBPdma6rhZtYN5VTUqJuuc0wpv+nLSlBugjVtwKzeQ=;
 b=RIIe3sGAY8TxWm7kSC03mfu8O9ehuVpmyrmu5oBqtsHAAq9GkGHVEpu370oB0mjVCh
 bxWcW0BLaHGvFJFFGSYHyVLGzwtcm+l1QVwvXEGPDYe74v7Y5mkjS8g9YL79Q4d/L08F
 B2k1ISRiH91JxVXbcfbnc3tDFFWNp30g2RQ5aRkJws5IvNCTBWLovFDaACEenxk/TJPO
 +g8z8erxysIUjUJ9Ku0ZYySXOQWqxGsvez/zLBnJjBVJPPxcRcqxiE4WjZbAfs1ooDdk
 o+IsJ3qtemWrLTamIYUO2VnsfAE8/4jE3aHUyuTZvfm3pZUsDTsMzCZLASy0L/fTzpwb
 +lNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733161282; x=1733766082;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7LBPdma6rhZtYN5VTUqJuuc0wpv+nLSlBugjVtwKzeQ=;
 b=TzYXXKQjd1q7iVKTmKdxQYxz0KG6xSO4q6XlURUNptwXjahqsMh9BHFdlkti7pcSlH
 mBPDuDP0A7hBlNiFtlWTJQoCRhVd55TpeJeLkiKfGCPAswBMI1zdtR5NOa8/JhNkI4De
 2VPed1p/tqBi5BmNHHQktVCcEHMOnm1aAOObj9irm4zwBMUITKStiyW+ewBSncT0db60
 vr/fAuGsSSVRzoyNIpGCe3Z26His4NnfXlUKKlaHQlxx1Z72yulLUDBLTkXOKtmDAcBb
 8axKYjJ5jPU83ZMtMf/aQv3KpMZpONQ0H1g2BeiuG/rSeYq6W6TA0LCqnc0Yfi8L6H0H
 0gZg==
X-Gm-Message-State: AOJu0Yyxi2MA7BlzZ2QylOKjV0/31pTuUyCLP8xNhfy2oEoopEjLLEjD
 wX3C6HUiWj8MvSESwdMxJdnNsxPu9fn5tQBr7hOTKBIbz3e9+L+jLW+ghlFxgw==
X-Gm-Gg: ASbGncs1EqKGTtFK0fRRXY70kvGQYJiSfcOtnJIU6U5MuOBRP9rWZaDP+mpxSt4gaHS
 RFgVOrLM5zljWWQAdHlKXbR6pil9QUMJ8EIqeDRwfWZDKUq7nxeM/BLfPelZ5fneBZBugBce8tb
 gdB0j9ysxco9WagjTCn3YnnJqs/1sT5d5qww+yhr5DqQcNJO9cCs2VodhfELYXvoxX6Rh7OIfB2
 9a+b2sHKxRnXmDcPDsp4EWl5btfdwCKONKH2OSrV5AK4VpW3t4VCpY=
X-Google-Smtp-Source: AGHT+IGIhPHjJjX60xtwUPxFnsCPD5D2tWZqniTXcOsWHJ46PNDHBhiLetLf6lESvHPYilgpL0widQ==
X-Received: by 2002:a17:902:e84e:b0:215:773a:c16b with SMTP id
 d9443c01a7336-215773ac2efmr115561425ad.4.1733161281752; 
 Mon, 02 Dec 2024 09:41:21 -0800 (PST)
Received: from [192.168.0.163] ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72541849d6csm9074887b3a.182.2024.12.02.09.41.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:41:21 -0800 (PST)
Message-ID: <17fb0af6-2aca-49bc-8164-751ac4be4b2d@gmail.com>
Date: Tue, 3 Dec 2024 01:41:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] vfio/igd: align generation with i915 kernel driver
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <c.koehne@beckhoff.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-5-tomitamoeko@gmail.com>
 <20241201230401.3b2e8e61.alex.williamson@redhat.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20241201230401.3b2e8e61.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12/2/24 14:04, Alex Williamson wrote:
> On Mon,  2 Dec 2024 00:09:34 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> 
>> Define the igd device generations according to i915 kernel driver to
>> avoid confusion, and adjust comment placement to clearly reflect the
>> relationship between ids and devices.
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>  hw/vfio/igd.c | 36 ++++++++++++++++--------------------
>>  1 file changed, 16 insertions(+), 20 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index 8f300498e4..71342863d6 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -59,33 +59,29 @@
>>   */
>>  static int igd_gen(VFIOPCIDevice *vdev)
>>  {
>> -    if ((vdev->device_id & 0xfff) == 0xa84) {
>> -        return 8; /* Broxton */
>> +    if ((vdev->device_id & 0xffe) == 0xa84) {
>> +        return 9;   /* Broxton/Apollo Lake, Gemini Lake */
>>      }
> 
> J4105 is a Gemini Lake, the IGD device ID is 0x3185 according to
> ark[1]??

I made a mistake, Gemini Lake have device id 0x3184 and 0x3185, it
won't match here.

> I do find Apollo Lake examples (N3450) with ID 0x5a85, which I assume
> justifies masking out the zero bit of the ID.
> 
> Since Broxton was apparently canceled, I think this unique device ID
> test was concocted from i915.  Maybe Apollo Lake should just be added
> under gen9 below with 0x5a00?  Then Gemini Lake should be added as
> 0x3100.  Both should be noted as new IDs.  Have either been tested?

Broxton is the name for the GPU part in Apollo Lake
https://www.intel.com/content/www/us/en/content-details/685496/2016-intel-atom-processors-celeron-processors-and-pentium-processors-based-on-the-apollo-lake-platform-broxton-graphics-programmer-s-reference-manual-preface.html

Apollo lake have 5 ids, 0x0a84, 0x1a84, 0x1a85, 0x5a84, 0x5a85, the
problem is 0x0a84, the prefix 0x0a00 is the same as Haswell, and their
generation are different, the GGC register need to be emulated qemu
are also different. Masking 0xffe here resolves it.

Though I don't have a Gemini Lake device in hand, some proxmox users
reported passthrough works. Giving that in old qemu releases, they
were treated as gen 8 by default, and there is no difference in qemu
for gen 8 and gen 9 device, I think it's okay to declare it as gen 9
here?

https://forum.proxmox.com/threads/asrock-j4105-gpu-passthrough-vgabios-romfile.67507/


>>  
>>      switch (vdev->device_id & 0xff00) {
>> -    /* SandyBridge, IvyBridge, ValleyView, Haswell */
>> -    case 0x0100:
>> -    case 0x0400:
>> -    case 0x0a00:
>> -    case 0x0c00:
>> -    case 0x0d00:
>> -    case 0x0f00:
>> +    case 0x0100:    /* SandyBridge, IvyBridge */
>>          return 6;
>> -    /* BroadWell, CherryView, SkyLake, KabyLake */
>> -    case 0x1600:
>> -    case 0x1900:
>> -    case 0x2200:
>> -    case 0x5900:
>> +    case 0x0400:    /* Haswell */
>> +    case 0x0a00:    /* Haswell */
>> +    case 0x0c00:    /* Haswell */
>> +    case 0x0d00:    /* Haswell */
> 
> Crystal Well?

All 4 are Haswell device id prefixes.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/drm/intel/i915_pciids.h?h=v6.12#n187

>> +    case 0x0f00:    /* Valleyview/Bay Trail */
>> +        return 7;
>> +    case 0x1600:    /* Broadwell */
>> +    case 0x2200:    /* Cherryview */
> 
> These two jump from gen6/7 to gen8, that's certainly not just a cosmetic
> change.

Broadwell and Cherryview are gen 8 previously, no change here.
https://gitlab.com/qemu-project/qemu/-/blob/v9.2.0-rc2/hw/vfio/igd.c#L86

>>          return 8;
>> -    /* CoffeeLake */
>> -    case 0x3e00:
>> +    case 0x1900:    /* Skylake */
>> +    case 0x5900:    /* Kaby Lake */
> 
> These two jump from gen6/7 to gen9, so again, functional differences
> for these.  Have these changes been tested?
> 
>> +    case 0x3e00:    /* Coffee Lake */
>>          return 9;
>> -    /* ElkhartLake */
>> -    case 0x4500:
>> +    case 0x4500:    /* Elkhart Lake */
>>          return 11;
>> -    /* TigerLake */
>> -    case 0x9A00:
>> +    case 0x9A00:    /* Tiger Lake */
>>          return 12;
>>      }
>>  
> 
> Actually, patch 1 doesn't even need to be addressed here because patch
> 2 already made the change to check (gen < 8) rather than (gen > 6), so
> we can just entirely drop patch 1 (ideally with an updated commit log
> in 2 to note the logic change for this upcoming split of gen6/7).
> Thanks,
> 
> Alex

Agreed, previous (gen > 6) actually means (gen >= 8), patch 1 is
unnecessary. I am going to change the condition in this commit,
and mention it in commit message.
 
> [1]https://www.intel.com/content/www/us/en/products/sku/128989/intel-celeron-j4105-processor-4m-cache-up-to-2-50-ghz/specifications.html
> 



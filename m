Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B753E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 09:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ87i-0007IV-32; Thu, 05 Dec 2024 04:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ87f-0007IJ-UI
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 04:26:11 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ87e-0005NT-5K
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 04:26:11 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-21577f65bdeso5717085ad.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 01:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733390768; x=1733995568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zTh9z3M7SyTR+p21u+uhnLEavti9uskdFe1O5ITUarA=;
 b=IdTq23wY2rIxCOgkMTQalUduGXckDPFoX0nY/Fop6kvoYT54TxOkXRX8vTgwFCV+UJ
 IL/lQmbjSTIR+CbByngxvztr6NTZYI0uWgBH5PAyZGD/1PI8V4bC+OTCbFt/Kl0Tj4B6
 SbsSybcHY2y+DcOw8y/QToD7IowXkeO6Vj6a5eXjeXonlOh4OEzjSGvJ1nBsc4L3LqCm
 0x0uR8/ik5eP8twRffKfDoM9tP0kDDagyDBHZ4a0QZWSjtwY2oxxMaIyzW2Ek3XVafbO
 V2VUbYUemiIhcyDaVgz9IJTM1HWsXNrGhvzeC/uoF3yPhHAE2Rkszl5zYA/3/xi0Zrnb
 NyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733390768; x=1733995568;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zTh9z3M7SyTR+p21u+uhnLEavti9uskdFe1O5ITUarA=;
 b=PEb2iF8Kuc43l3ztnUiU0Lxvhm5+D+3+CaAU0qarO4NNokQ/ux7T7tAZaPe+tjyjQ6
 M0q03oFKNtcU7N/WQZt4D3nTTtvuhEkyPPaZoGBULr28l99q8dIKnyXnmLcBM4fHVzWc
 HshycNOt2901LGjYLw1u/3K9HTNhCMLean8Om/ur0GRDyPXCZWqpIA1Hr4LCFK8s5ClY
 TQYAG4RQb+6a5f+IeHIj0N558mZoKiwaufAYvd+IqtyVcSD6C4fHRAHkT2s4evyj4Ovp
 G6/OkAJRvzO5WGD70chak/kzFeHrfWXlOKbK2Gh7gihX0x+EU/YFa/suNd3jKwp61b06
 05Kg==
X-Gm-Message-State: AOJu0Yx9ki1vdmIYfaZkG0jHoRWtcwzAPedsiWz/GGAQFEVy2i/hlF25
 kFabWHBiROD5nDrM/0bnrdywsKNhPFdLcDLx8ufOM8g1y+KWfyU=
X-Gm-Gg: ASbGncsZRVBUlUFUdXuUDJNg8ET09dnnax22ol8ddTTua3TjU8q6Iu7XPAY3JTB8cyw
 Tnwq9HsjI149OOMePZtJSZIBzw3RQ8KF9QI4tZh9g5GaTvtL88oko02MYgaOA7Os3hGxdZfHvl3
 1yBZNXPfzrts8x9+QnFsZ5n5Cj/ibQMJaygASy3i13vS03tpEFg5jL6vN4yrzkNinQXZ7rdbcXo
 qpf8QsFXzf7qq3AVNPG0t9VRgZepuQYM3g3oBXprKjW4naMBL/IAg==
X-Google-Smtp-Source: AGHT+IHxoe8b7kaPANukZudkDc18p8FaFSLyFO55mT20rrouh0WjEb8hie3RSfghl4LYtwbOGz+7KA==
X-Received: by 2002:a17:902:f641:b0:215:5d8c:7e46 with SMTP id
 d9443c01a7336-215f3ce4168mr36376645ad.27.1733390768398; 
 Thu, 05 Dec 2024 01:26:08 -0800 (PST)
Received: from [192.168.0.163] ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8ef9f5bsm8526885ad.132.2024.12.05.01.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 01:26:08 -0800 (PST)
Message-ID: <5226a3e0-6440-4633-8287-843fd1806086@gmail.com>
Date: Thu, 5 Dec 2024 17:26:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] vfio/igd: align generation with i915 kernel driver
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
 <20241203133548.38252-3-tomitamoeko@gmail.com>
 <20241204153610.09764d56.alex.williamson@redhat.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20241204153610.09764d56.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x642.google.com
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

On 12/5/24 06:36, Alex Williamson wrote:
> On Tue,  3 Dec 2024 21:35:41 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> 
>> Define the igd device generations according to i915 kernel driver to
>> avoid confusion, and adjust comment placement to clearly reflect the
>> relationship between ids and devices.
>>
>> The condition of how GTT stolen memory size is calculated is changed
>> accordingly as GGMS is in multiple of 2 starting from gen 8.
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>  hw/vfio/igd.c | 44 ++++++++++++++++++++++----------------------
>>  1 file changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index 6ba3045bf3..2ede72d243 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -59,33 +59,33 @@
>>   */
>>  static int igd_gen(VFIOPCIDevice *vdev)
>>  {
>> -    if ((vdev->device_id & 0xfff) == 0xa84) {
>> -        return 8; /* Broxton */
>> +    /*
>> +     * Device IDs for Broxton/Apollo Lake are 0x0a84, 0x1a84, 0x1a85, 0x5a84
>> +     * and 0x5a85
>> +     */
> 
> Your comment from review of v1 would be useful here that we can't use
> the test below, at least for 0x0a84, because it conflicts with Haswell.
> I'd forgotten that.

Sure I will add it to comments in v3.

> Since we're being more strict about what we support now, it may make
> sense to list specific IDs rather than this sloppy match, as Corvin
> suggested, but that could be a follow-on.  Thanks,
> 
> Alex

I personally prefer do it later, it take some time to think a proper
way to maintain such a long device id list.

>> +    if ((vdev->device_id & 0xffe) == 0xa84) {
>> +        return 9;
>>      }
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
>> +    case 0x0f00:    /* Valleyview/Bay Trail */
>> +        return 7;
>> +    case 0x1600:    /* Broadwell */
>> +    case 0x2200:    /* Cherryview */
>>          return 8;
>> -    /* CoffeeLake */
>> -    case 0x3e00:
>> +    case 0x1900:    /* Skylake */
>> +    case 0x5900:    /* Kaby Lake */
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
>> @@ -258,7 +258,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
>>  
>>      gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
>>      ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
>> -    if (gen > 6) {
>> +    if (gen >= 8) {
>>          ggms = 1 << ggms;
>>      }
>>  
>> @@ -668,7 +668,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>  
>>      /* Determine the size of stolen memory needed for GTT */
>>      ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
>> -    if (gen > 6) {
>> +    if (gen >= 8) {
>>          ggms_mb = 1 << ggms_mb;
>>      }
>>  
> 



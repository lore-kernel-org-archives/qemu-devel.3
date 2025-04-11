Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D83C369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BXa-0007Yc-Ep; Fri, 11 Apr 2025 06:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3BXT-0007Xz-Ip
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:23:13 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3BXQ-0005ZD-EX
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:23:09 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3914a5def6bso1025591f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 03:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744366987; x=1744971787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SV8yIvTlCElIVVOVgdbiuxuqhpO4ZQ+Yaow54ns2e2U=;
 b=ujKLr5d407NvmN+xP6B62PkVTKxtqov6bcktOMEGt3BSj3pHsPfVtO8M3gj7gZqx+L
 pe+ioyuwcMFycde2cSzNSJc9M4kWvp4bqiy470PhdtlDrtwXdraDHrfAWSCwYHicQiwu
 DzUgrObIWkbtXZMgnPcTimOaQ4uRQNAszj/IqwWsrDF5aFbYMdKPoOMn2sIsKI/jDd6I
 CX2D0Bd1cy+lrnvGRETfo1lneWJJr3tpH+GEECYxxoye6SOR26Ed9l5FkH174UwtTRiQ
 dC4LfHoikd9Yl4w9Sx4ZmGjjC+z2nN7nGdgWIKaKgE2trRPrpl0ouAsnS3+SKRfDRJK9
 jVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744366987; x=1744971787;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SV8yIvTlCElIVVOVgdbiuxuqhpO4ZQ+Yaow54ns2e2U=;
 b=FHvqv5CxZ2Q04AvGYQiUAgEAxmzU0QG4g8DjvEq3NQ5MjZPePvQxjyTIlFK9uRQ5n+
 +42hsI+5KR9Y0ta3866LbIgHdtszcsxRDXMsHj2++pycGWs39+FQV+i0hqVLtZuxjjYU
 ULxwbk47A57oEoLjYoXvLokTqpoIFigAfJdcH9LmX3EQzUJ5Y1IZGDhQzZaR6j40KuZW
 rE58GS2V7GO5u5TCnpcFDkAJKO8AFpi8qvDQ86E/CM+GyB2Ao51MatXe/nQEEdxquFIm
 Xfm6XUCTFK0EdAP1pqcEc3jMI8dHzWXIsCo8Bljcuyt8Hzxidd9bO6bOg9DsQ10Nt1Oz
 0GFw==
X-Gm-Message-State: AOJu0YxuHf1j2yAu3vhUvyQjQWtuSEZTZPsurrN5WzHeXnst0CVtUqMa
 Idd9NwzlbU1ansuXCt8gA5pNga6h5xEzxSs+98dmjYVumghqGSnUDHuo+UtHtFU=
X-Gm-Gg: ASbGncvXKzwvFO4JUSprcfZkbI0pZY7NZD6Y7d1vvhDXWu0ORDiVkFD/vgtuIBljYPI
 CH2SxYMGDRM5h4aHQApXdtgOQCpcs+KOSmwfWr0Lz3z8YNzj2LUekbmwuyVntO7GNqDrrIEO2HA
 e9yMeAMbxHoOSBGzyTS/v3CZEeFMkLpAT7kgnIgAW8P1r6yXFmumXkMSCAGPiO3WaMlW3xLFdOM
 I3eBXgHV+f6NAdEyXpT02ziShd3BJ5Abt7xvuRpIfBd/lPYSUufk511apGs6VcWsgvX+fHAOifa
 Z8hwXJGUntHVRikh+QEySPelGgM4XO6o/fZSU2TpbhwapzSx1rkpuAbSDTrXbg5N/qU6MCndw5k
 XIuH/V88h
X-Google-Smtp-Source: AGHT+IGP5o5zvH7C/GKnpeYjdVjVMSW2z76Opti0dCgM5rvl5VPfWhgRmD97kalPbf6juOdnwEeIFQ==
X-Received: by 2002:a5d:5f92:0:b0:39c:266c:d82 with SMTP id
 ffacd0b85a97d-39ea51ec9cbmr1799860f8f.10.1744366986744; 
 Fri, 11 Apr 2025 03:23:06 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae964089sm1594732f8f.15.2025.04.11.03.23.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 03:23:06 -0700 (PDT)
Message-ID: <ed045110-7308-4141-a0c8-1e7dcf94d35a@linaro.org>
Date: Fri, 11 Apr 2025 12:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] usb/msd: Ensure packet structure layout is
 correct
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
 <20250411080431.207579-3-npiggin@gmail.com>
 <88ac3951-bac9-48d5-bee7-6ca2e465fe0f@linaro.org>
Content-Language: en-US
In-Reply-To: <88ac3951-bac9-48d5-bee7-6ca2e465fe0f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/4/25 12:21, Philippe Mathieu-Daudé wrote:
> On 11/4/25 10:04, Nicholas Piggin wrote:
>> These structures are hardware interfaces, ensure the layout is
>> correct.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/usb/dev-storage.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
>> index 2d7306b0572..87c22476f6b 100644
>> --- a/hw/usb/dev-storage.c
>> +++ b/hw/usb/dev-storage.c
>> @@ -27,7 +27,7 @@
>>   #define MassStorageReset  0xff
>>   #define GetMaxLun         0xfe
>> -struct usb_msd_cbw {
>> +struct QEMU_PACKED usb_msd_cbw {
>>       uint32_t sig;
>>       uint32_t tag;
>>       uint32_t data_len;
>> @@ -636,6 +636,9 @@ static const TypeInfo usb_storage_dev_type_info = {
>>   static void usb_msd_register_types(void)
>>   {
>> +    qemu_build_assert(sizeof(struct usb_msd_cbw) == 31);
>> +    qemu_build_assert(sizeof(struct usb_msd_csw) == 13);
> 
> Can we add definitions for these 13/31 magic values? Then
> we can use them in try_get_valid_cbw().

Maybe USB_MSD_CBW/CSW_MIN_SIZE?

> 
>> +
>>       type_register_static(&usb_storage_dev_type_info);
>>   }
> 



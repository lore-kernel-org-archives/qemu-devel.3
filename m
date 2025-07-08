Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F77BC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFGJ-0007jz-P1; Tue, 08 Jul 2025 16:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZEDH-0006Kz-DI
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZEDD-0006BF-F8
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752003762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oX43MvXP+sfmfYnOo38hCHVIDYgFPwYLL9Ej/g9jkEM=;
 b=MlvVkUK/gfjsXemVZcpQQJPYhhWrJ20CLj9Jm+O6YoSoPss+K82TkVzppT4xmd3U8z5+z6
 uhrvP519JnB5CDUuX2VmbIduB+7LlMVxno08BB0mB0reuFkdFEWB/sqq87pVkMt9zInqIg
 M7kJU+PE9k8xScYVnu5T8Uvb51m2lWs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-buN7f7dLNV2xz7Zqu5b0jQ-1; Tue, 08 Jul 2025 09:24:13 -0400
X-MC-Unique: buN7f7dLNV2xz7Zqu5b0jQ-1
X-Mimecast-MFC-AGG-ID: buN7f7dLNV2xz7Zqu5b0jQ_1751981053
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso2563290f8f.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 06:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751981052; x=1752585852;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oX43MvXP+sfmfYnOo38hCHVIDYgFPwYLL9Ej/g9jkEM=;
 b=DuxXYLrgveH0X4tXmHgBghGUvtemrqEVZ2cMvB2moiZxKT6Kmq9++tm9+O5scFBFnb
 wEeX/ycnfVC/lW6Vw8lL06vtNAMnxohfzjDVPgpKlAaPDOMB+1f9u+Duru14HIBQa78j
 +GkhiKJrEnaQdf1XspLiufGR8GCqSKO7YwBP6RpvP1J3UcoT3rgPk06R9pvCP/uKGqrI
 BN8D46MZHJWQRKEHi5GhWSMunzBv6RJH6wtPNXygAzd7vEg9Wcw/gQ1LTBY1bZF0CpU4
 mAALFbGkifqn7ZBzLbVRrtFRMm6cn1QWDKU7g4YhDQYmzKZwZeS9pGHVsH1rwYepTEBk
 12hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLtAt3XX4zVBmeNA/Nj6WOKK+YtU5kd6YHv1wWtavvccReO8Re7Cpj/pkh6LCc4NhqYSVThRevWhDX@nongnu.org
X-Gm-Message-State: AOJu0Yz3nB0r6t3KaRpZF0K+Ppy7ypxlf3YC7T7Asu/jby2CeWXxvdV3
 zYfGuGEQqDgv+di3vU1R/W1G1X3xVX76Kha0B3jpO2zKn/P07KD8JiiE+46f5aOqMGJ0r3rSm6x
 GQJsGhvpIlX4n8KwUK9WtJJMPQQ5BzcsXahdUWrx0+C4VcdLNwXRFfGXw
X-Gm-Gg: ASbGncu408xVZ5Da7LZfxksrwYC4ucGCIRUxb3OnCx/HXM77PwFnlIzruTQilNxQL2A
 hR5vwdAeJpryk7/4BRzjERebHZyEYCby+eQJgh3oszof5+4noylaHEIaG31WtVAjyiqSdGGj95W
 GidfAvXYk7BURgzs4XbiHw6567XSfn6BTnziwjfTCdSuokcoh9elTTf+u/ezi2nounRgdeZHseX
 dHU3BRWHeL8ptXF6uR5ccX3ZFIlB5Bl0xh4ANVQf74UZ7tOqRt6+ALHCS9WGtLDu5smPx/zrKsL
 nCb8yj9LprE/qS/L6V0IitQRY10l/Mdnz56bliPwSY08QDM=
X-Received: by 2002:a05:6000:3c7:b0:3a5:2848:2445 with SMTP id
 ffacd0b85a97d-3b49701293bmr13032008f8f.16.1751981052519; 
 Tue, 08 Jul 2025 06:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7rz3dZh/sGE5g+yGrnoRmxhczj/UPVuNDSD9dbEGmQitJ81yGRdPiLlIhW0eUEnTD6u1tpw==
X-Received: by 2002:a05:6000:3c7:b0:3a5:2848:2445 with SMTP id
 ffacd0b85a97d-3b49701293bmr13031983f8f.16.1751981052040; 
 Tue, 08 Jul 2025 06:24:12 -0700 (PDT)
Received: from [10.33.192.196] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d2a8c5a2sm795795e9.32.2025.07.08.06.24.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 06:24:11 -0700 (PDT)
Message-ID: <803fc6a0-1197-4bd0-a084-69f252f35aaf@redhat.com>
Date: Tue, 8 Jul 2025 15:24:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] pc-bios/s390-ccw: Allow to select a different
 pxelinux.cfg entry via loadparm
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250708125630.58676-1-thuth@redhat.com>
 <20250708125630.58676-2-thuth@redhat.com>
 <6d0f221a-f5d7-4f2e-b3e8-1cb302681caf@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <6d0f221a-f5d7-4f2e-b3e8-1cb302681caf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/07/2025 15.13, Jared Rossi wrote:
> 
> 
> On 7/8/25 8:56 AM, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Since we're linking the network booting code into the main firmware
>> binary nowadays, we can support the "loadparm" parameter now quite
>> easily for pxelinux.cfg config files that contain multiple entries.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   pc-bios/s390-ccw/netmain.c | 33 +++++++++++++++++++++++++--------
>>   1 file changed, 25 insertions(+), 8 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
>> index 719a547ada0..024b4419ef6 100644
>> --- a/pc-bios/s390-ccw/netmain.c
>> +++ b/pc-bios/s390-ccw/netmain.c
>> @@ -332,6 +332,28 @@ static int load_kernel_with_initrd(filename_ip_t *fn_ip,
>>       return rc;
>>   }
>> +static int net_select_and_load_kernel(filename_ip_t *fn_ip,
>> +                                      int num_ent, int selected,
>> +                                      struct pl_cfg_entry *entries)
>> +{
>> +    unsigned int loadparm = get_loadparm_index();
>> +
>> +    if (num_ent <= 0) {
>> +        return -1;
>> +    }
>> +
>> +    if (loadparm > num_ent) {
>> +        printf("Error: loadparm is set to entry #%d, but there are only "
>> +               "%d entries in the pxelinux.cfg file!\n"
>> +               "Using default entry now instead.\n",
>> +               loadparm, num_ent);
> Commit 64fa0de established that the IPL should abort on any loadparm 
> misconfiguration, therefore I think this should result in a fatal error 
> rather than using the default.

Ah, right, I already forgot that, thanks for the reminder! I'll change it in 
v2 accordingly.

  Thomas



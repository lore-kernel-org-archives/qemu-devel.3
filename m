Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1013C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 11:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSZvz-0007eP-5a; Fri, 20 Jun 2025 07:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSZvw-0007dW-FO
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSZvu-0008Uz-N3
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750418961;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x0ZVIkog388IuZ2NvXh1vPSTorhXglVLMwf7UZ23OQI=;
 b=OUQQmC/8J3LNCI+aoXFSaA28ZPUxspq1TLkHDy5tCM6pNlrgy9WvwUoZrT8C+S26eLDydv
 IwaRmU7fnebR9RyPo/WIq0wBGU1210liFo/mW/xHaK3vv0OYRJJbT5t8ZSy8ZR3a07BBI3
 TfuR2KdJfHUitrruX3HXt59xVsJ05HY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-iJj_Hzk7NzCN2F401TaXvA-1; Fri, 20 Jun 2025 07:29:20 -0400
X-MC-Unique: iJj_Hzk7NzCN2F401TaXvA-1
X-Mimecast-MFC-AGG-ID: iJj_Hzk7NzCN2F401TaXvA_1750418959
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4530c186394so8681555e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 04:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750418959; x=1751023759;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x0ZVIkog388IuZ2NvXh1vPSTorhXglVLMwf7UZ23OQI=;
 b=Rz/USzyDgaEjWo7LRc0PdVZB3hGuDcq4+Va0kAil8rIapmOGn3kIV+i0rgp+mIFOcb
 wlZcBFbaRXHh3nzqhs1NQTTiqKEhlH6Y74VX9lZ2fTYU2gHUG/4y6AqXwVQNf6aBa8Jt
 EzJE/XLygfDNfBk93mve42MYT37b8xKXiOFh1fpgyqDziHc42cFaKbKMOTJXRrumYUWF
 +rH9Fl9b6MR00jQ2QPUsL5oV25kaOM+R8tFUYUuoC+/ZFcOYTmN5Z7fabRRjjlWjiZ7D
 oo0JTS4Qa4NqJOqbEY0kIJvPpxfp/h9Mc9yaIkwEIDfp9mjac3U3aX6VlqKd2M+av+/G
 w/1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgBH8MyLlC3kgoBh2dOC61BPyB9ook5hveyKnf3CW57HYQXvwjWRZXYI+GgSvvuq/tuicqYe5Nowus@nongnu.org
X-Gm-Message-State: AOJu0YyEnHNi0nzX6B3qWFAWaJJqdZNnX3/kosQHdMbI2UXe42Fz7gMB
 BjVFVZM9l/0GbcxZtwX8semmlTQwHxsRM+m2pbchj0reZREiAbid7zC71XzNnTnPXQU0h6N8Td8
 Ga2Rt0I4GKtqtz3IzV1hDfZjGhB8L1X6OtJdmYrus05eu0tBwsPWlLUSE
X-Gm-Gg: ASbGncvuiNzpRRy3yDdV4I++pESUY9iO6AZcYnU0zZCWilJeyfubGqCipqLeG1siXkz
 oC/OCjPTbC5fbRxxeHrfmMxLiHcxC+hGBqfFDvKLVFYD86wvzr0RMMSKhs2j/47USnyJsCwJv9p
 Frn+jvDiY2sh9hD3LtUPWj1HlGvPHNY6EkPDRtsO0zebHwRAzqjr/uDfUyzREbKDrljlH+hN2Ai
 ArC2Z99W+bj8XFdpPKGDHj3hEyGXAIC06QTplwtpczw6bBKXTQz+ziPqN9wqeQ/auZScJ0BRZEt
 kCTG6/8Gdh2mxJP5GSLlRxmth3y+C7GGlWIdOgX/pAOQ/lo8CNLNiJCNHg9UF7tCFXu3Lw==
X-Received: by 2002:a05:600c:3b15:b0:43d:26e3:f2f6 with SMTP id
 5b1f17b1804b1-453659c3b8cmr19851065e9.5.1750418958961; 
 Fri, 20 Jun 2025 04:29:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYxD5zb0kEMIebq73Ob/XWWU7rid2d6kWwRhuXrGcbke2eWs65dYoh3bdQUEzQN+GHHrklug==
X-Received: by 2002:a05:600c:3b15:b0:43d:26e3:f2f6 with SMTP id
 5b1f17b1804b1-453659c3b8cmr19850725e9.5.1750418958550; 
 Fri, 20 Jun 2025 04:29:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ead202asm56021705e9.27.2025.06.20.04.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 04:29:17 -0700 (PDT)
Message-ID: <4a2ae027-aff2-4e8f-aac3-4e8748bdcc52@redhat.com>
Date: Fri, 20 Jun 2025 13:29:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/29] tests/qtest/bios-tables-test: Prepare for
 changes in the DSDT table
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-6-eric.auger@redhat.com>
 <20250620094932.00000b74@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620094932.00000b74@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/20/25 10:49 AM, Jonathan Cameron wrote:
> On Mon, 16 Jun 2025 11:46:34 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> From: Gustavo Romero <gustavo.romero@linaro.org>
>>
>> This commit adds DSDT blobs to the whilelist in the prospect to
>> allow changes in the GPEX _OSC method.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> FWIW given what this is and the involvement of foxes ;)

:-)
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Thanks!

Eric
>> ---
>>
>> v2 -> v3:
>> - fox for microvm
> An excellent addition to any microvm.
>
>
>
>> ---
>>  tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
>> index dfb8523c8b..75f057767e 100644
>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>> @@ -1 +1,7 @@
>>  /* List of comma-separated changed AML files to ignore */
>> +"tests/data/acpi/aarch64/virt/DSDT",
>> +"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
>> +"tests/data/acpi/aarch64/virt/DSDT.memhp",
>> +"tests/data/acpi/aarch64/virt/DSDT.pxb",
>> +"tests/data/acpi/aarch64/virt/DSDT.topology",
>> +"tests/data/acpi/x86/microvm/DSDT.pcie",



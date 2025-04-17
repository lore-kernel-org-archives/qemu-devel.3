Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B68C369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5T9f-00066n-M0; Thu, 17 Apr 2025 13:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T9d-00061I-TN
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:36:01 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T9c-00029g-0p
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:36:01 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so996050b3a.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744911358; x=1745516158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dKq5DF1UnkGBHNmqXc7SVyY3lHTmtR5u41l1JW4GMyY=;
 b=FohpLKGqBuRE7l7aH9b2C/+CoEvVRkes8Bi//eMl82SM5vnyc8OSGh7sd74yKZbOsK
 meJG6rJjyONgnIRT7BJUNEoz/GEyQkkvLixgRfuEg2vUxOVBkExiTwVCtd6TQY/5nW5U
 OC7kxGX7C2GJAIWH9WQW33RZZL8JcNYoaJVyu+Ej5YRhKUSJAb1yzV1TvNR1axAvGla+
 88L1GnPLt6rJeVHjKSPTY8+BGFk1yrd9cFCBl16Nryu2eZPduc4h4wHCDP7rrt1b5PGJ
 l8hGy9VAo0o5Gs3oI7mxE1GMLCEdCUt7PlSFNZ/jrQWf6IkeJ6gR7fkL7pL3PqEEfVNv
 z0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744911358; x=1745516158;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dKq5DF1UnkGBHNmqXc7SVyY3lHTmtR5u41l1JW4GMyY=;
 b=j/IMNcsXg52pT9pXSW5yaUwsSm4/zU+/+vEdcfhulOXZBHG/uSlQijiilJVzZKmswf
 fUuxFPzhD4t7cl54AHsoWnlOlYj9axlFtZCQAy6dFDBXcZuyw0n2oYcYk1PoaIxWFt/d
 VXmF/s6D++7Yt60+LN7RjSNPUXKfHrn81/Ew8FyhX7kmNSjoMm7jYGE802JyqlykGfEa
 vlsi9riJ99Ylboja2QAjDQsiYMgyix7sk5yjCMWHm/ewib9+AvLoH/oUU+avy3ZsI50a
 X8vmxLpQpdPgMBDQgAAtFPbxS8iZyf2iBLXy/Zx+4Lz+ptvguOLm+S/r5jdA4cSW2yjH
 j+gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVte8HdDSSad6mLh5fHAg3K9ru7zKokz1dl7V/zKF5keRqd4w/pBoSWcsVUWZk7kNmBQn6tKKrIdmZ7@nongnu.org
X-Gm-Message-State: AOJu0YyazrQp8dPWaWfKsDv+dN7hzWa5xVNdRSTPNBMeFSz9Si4/R6lD
 qXg/6vYmtcCQeZBGGythbAPjpYz8mMrM6Dt4La6YSWUA8s9GNoMLOBH8OC+cRr8=
X-Gm-Gg: ASbGncuREd4s3IVf+rqRVAu3pCCYfLrM1Drjx0EcjqhU4bW8Lyq3rcZJcYkpbxn//Bq
 eU09PpqwDjiAHny+eWNTIcjG0KN/jxhWmvL7S6bLcwUiOISpTv/htT9o90VZnygEuwST8dbFsNq
 JEF668pZ/jgnsx4R1r11vxq6N9zcByrzBuKo3bcodQ2rjFi9PxpcXI2hdLm25jpvZXkX+MCdbbh
 9wZl1qsTiAIuWULQgEAprHC1qOgdD9IP3ihdpOSqV/sWxYgv7DHdP1eOq4sdpKh1m9sx96XMdxq
 hdYFW6vxqtrSMD7NlBjsNZmT6K3L+pHZ6i2ajQdezixrb24Hnuxe
X-Google-Smtp-Source: AGHT+IG9ujKyK0s9k3qEb5bdXyTpRnjF9UOBI+L5QPUqzg3OAUciB5zlZjW1WJTCysTRUweJiy/bMw==
X-Received: by 2002:a05:6a20:c6c1:b0:1f5:9098:e446 with SMTP id
 adf61e73a8af0-203b3e6abacmr11811361637.2.1744911358482; 
 Thu, 17 Apr 2025 10:35:58 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.52.65])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db13c76f6sm151619a12.40.2025.04.17.10.35.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 10:35:58 -0700 (PDT)
Message-ID: <0ba24f2c-7636-4fca-af34-a332863c0e03@linaro.org>
Date: Thu, 17 Apr 2025 14:35:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 09/13] microvm: enable sleep GED event
To: annie.li@oracle.com, qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204335.2999-1-annie.li@oracle.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250411204335.2999-1-annie.li@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42c.google.com
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

Hi Annie,

On 4/11/25 17:43, Annie Li wrote:
> The sleep GED event is enabled for MicroVM. Also, the system
> suspend is enabled when the GED register is set for sleep.

nit: in the commit messages, please stick with a single case
for microvm (or MicroVM, etc).


> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>   hw/i386/microvm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index d0a236c74f..eba33c4365 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -205,7 +205,8 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>       /* Optional and legacy devices */
>       if (x86_machine_is_acpi_enabled(x86ms)) {
>           DeviceState *dev = qdev_new(TYPE_ACPI_GED);
> -        qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
> +        qdev_prop_set_uint32(dev, "ged-event",
> +                             ACPI_GED_PWR_DOWN_EVT | ACPI_GED_SLEEP_EVT);
>           sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
>           sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
>           /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_MEMHP); */

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo


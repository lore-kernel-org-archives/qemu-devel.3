Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB82E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwKw-0006px-55; Wed, 04 Dec 2024 15:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIwKr-0006oX-5P
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:51:03 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIwKp-00056z-LI
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:51:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434a90fed23so1493955e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733345457; x=1733950257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ieaDmxmi/VDvGvPyu9m/mprRo5fRdXLjUqQSWTteXxQ=;
 b=fDP+O5MVgAwczi9UI9YqTkf9H2LOlcOm/S2n5ReSRB7HmK365dxGNyvy5MdWKHWSNo
 YXP27gp6KaXJQyqCFT57KPpsqF/2mwHSJrLDYZG+xRr9pmk8fxnS1bgKol31SMj5Gr5n
 Ged9iBNH9Wwm8Sx0b7RjPPHaL4/wyyXnW5QEx3MMHegEdV6SDR7945X4llOqM1jL3Est
 YT8Hf2didnCzLJScDAKnWzGKDFtmUngKCwViodBRPefl7eEZ4oJm5M/Gzz5GpUKlkpUO
 3eEVxazDTpjX7G9DkwlOpB3XkTM6vNJXag2fV7zECsZyhtxZUGHz7TYzuXY8nmT65CaM
 i16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733345457; x=1733950257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ieaDmxmi/VDvGvPyu9m/mprRo5fRdXLjUqQSWTteXxQ=;
 b=dWVuiOcAabrS08kc1FExK3EC4lLY/TN/Gv2DLJSlOVzDXDt2G1pWLBwaOFvlaqXUZd
 eHN0/+tvBZVwY6lzOYDCXky0JnKSGET14NXKgrzpm8OI14W6WBcjTdvflMmw/EyK2icW
 Q3GygxeTHi7eZpJKnphJ4cD5/mpYfzke21wFHKx4la0jq5BFuvo7y7G5B4A75IwDGTEe
 wXHSYalrCFgzYLIdEInd4Fy/PAtdwPhE86G2DyvO4ZBAOxDGoiJy3BXdAzjz05+hvRCb
 lrZd0inevNXc6scnORtzY9SQH4u51mAkb00bzzg7wMZSZsTmsxyyUlpdY61A7HHPplu7
 yHWA==
X-Gm-Message-State: AOJu0YwuscFL13TQHBPoIXbGVT/t2mMNI8TkzXv4VZjgUVw0rEadnjZ/
 ITYFr8s3KPfPpFAZQSS1aROrYQasGaarSdkw9SwDnjDf9GMs7dcIiWeVqqAEqKE=
X-Gm-Gg: ASbGnct45RdFhTNRlyW9RoS39P+XwWmYs+KI+ejtBr3HvtpMzql8sH4D73U7aycTdfT
 V+bGBb0VyOd740FnWfPVM0EcI7bQjd2ABDCrnRaOMt6HVAmwSrlQPf9sVv8QhHcb/DOVceC7al3
 DRVjw/r60m3rRaY5Y95ISLaFvTKr5wlsrRqb+qSwJT+04vMfzCyN9HefT/gPxy6zU+SqxqjlKQy
 GWHC+5djFbynQSJt8PvRc8jqt0k7O54U7tG8tdaC4c3WAPNftKtTgfy+pducL8lQyoKiHCyvhRZ
 vQc04JvW1QIOS1Vkr3SAjwo=
X-Google-Smtp-Source: AGHT+IEfzCMZ2VncKnwln/1wT0d1+IqHt+Kv4GlXhWPk/fnfD8Hi5HAh+1OSub1WYD+3oYN1wW8HjA==
X-Received: by 2002:a7b:c309:0:b0:434:a378:51a8 with SMTP id
 5b1f17b1804b1-434d4177fe7mr43417455e9.27.1733345457470; 
 Wed, 04 Dec 2024 12:50:57 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52b841esm35712395e9.44.2024.12.04.12.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 12:50:56 -0800 (PST)
Message-ID: <c4245af0-3dd4-4cf6-a786-c15fa079ad05@linaro.org>
Date: Wed, 4 Dec 2024 21:50:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: bump default memory size to 2GB
To: Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, leif.lindholm@oss.qualcomm.com
References: <20241126084928.252067-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA_SkZ+ew8AAVpBHuw-9YW4S5wFbB0Vqx+dBzXf97JGDGw@mail.gmail.com>
 <cd635753-4e2c-42d6-bb7b-d558d90f59d7@linaro.org>
 <2106db77-88fb-4113-ae09-9bf77bce6ad7@quicinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2106db77-88fb-4113-ae09-9bf77bce6ad7@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 4/12/24 13:17, Leif Lindholm wrote:
> On 2024-12-02 10:53, Marcin Juszkiewicz wrote:
>> W dniu 26.11.2024 o 14:14, Peter Maydell pisze:
>>> On Tue, 26 Nov 2024 at 08:49, Marcin Juszkiewicz
>>> <marcin.juszkiewicz@linaro.org> wrote:
>>>>
>>>> We are working on adding RME support to SBSA Reference Platform.
>>>> When RME is enabled then RMM (Realm Managment Monitor) takes 1072MB of
>>>> memory for own use. Which ends with firmware panic on 1GB machine.
>>>
>>> Reasonable change, but isn't it also a bug in the RMM that it
>>> grabs 1GB of RAM regardless of how much RAM the machine
>>> actually has?
>>
>> I think that the goal is "get it working" first and then optimize.
> 
> I agree on a different platform this could feel quite hacky, but in 
> reality even 2GB falls within "ridiculously low for an SBSA platform".
> 
> If we're worried about overhead for CI jobs that do not require the 
> feature, we could always conditionalize it on RME being enabled. But I'd 
> be happy to wait and see.

I'd rather do that, since it is as simple as:

-- >8 --
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e3195d54497..66751d0806c 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -51,6 +51,7 @@
  #include "qapi/qmp/qlist.h"
  #include "qom/object.h"
  #include "target/arm/cpu-qom.h"
+#include "target/arm/cpu-features.h"
  #include "target/arm/gtimer.h"

  #define RAMLIMIT_GB 8192
@@ -795,6 +796,12 @@ static void sbsa_ref_init(MachineState *machine)
          object_unref(cpuobj);
      }

+    if (cpu_isar_feature(aa64_rme, ARM_CPU(qemu_get_cpu(0)))
+            && machine->ram_size < 2 * GiB) {
+        error_report("sbsa-ref: RME feature requires at least 2GB of RAM");
+        exit(1);
+    }
+
      memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_MEM].base,
                                  machine->ram);
---

$ ./qemu-system-aarch64 -M sbsa-ref -m 1G -cpu max,x-rme=on
qemu-system-aarch64: sbsa-ref: RME feature requires at least 2GB of RAM

$ ./qemu-system-aarch64 -M sbsa-ref -m 2G -cpu max,x-rme=on
// OK


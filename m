Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA92CDD0C6
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 18:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Jzd-0006Qw-I7; Tue, 22 Oct 2024 14:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t3JzO-0006Nu-Up; Tue, 22 Oct 2024 14:52:23 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t3JzJ-0004MA-Ak; Tue, 22 Oct 2024 14:52:16 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso35031405e9.3; 
 Tue, 22 Oct 2024 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729623130; x=1730227930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xzzMQMjRFCYjiBrnmFMRm+W9uYRGY50F1KRBtXnoh9Q=;
 b=bY/ZUIzmLfrJG6l5TlvpSXOjqL2TUq8yZ7dkxvFkBm2AZovgm9+JxTuH/SbKoEgq6Q
 CR4oY03avaIfAEKbpOWfZRtxxVOkxakVFXBnrtLRG9xkVMYARD0E6qwOTXy7ix5xni4/
 Gm4TasW32h+/A3jngPs9OLa502nb1F6US47m45yoiw9upcqmDBbYIyJHl4kOEQ8NvmS7
 tVE0aOvXRIatSX1aAAhlKDJ5cpwPtQdEwUy3ZI+MhuH9+B0nISoaRdaunTakqfwuvtO6
 6tSZ7EyRLTbw5zJIbPST+h2Y5tjMpilwHo9AL0yl27vvxj9g9TD2WTrWhjnN9TagfNZh
 ZtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729623130; x=1730227930;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xzzMQMjRFCYjiBrnmFMRm+W9uYRGY50F1KRBtXnoh9Q=;
 b=fJkEDxnIp0fBbPi0hInqjcMVVuSTmFOnlEBrBiE5Ms+ZvogwEgEo5CEENF6wdHN5ME
 F3+MLgw2K//Po06vYgtBVV2ZuTLP4C+DN4M6XDVa9gPtp3W0n26Q0q7JBuYPuaSNupfw
 DWL30YmvXMFOYxRBk9P1/RPS72K9QDKmxYQhhV7UEddPQQaSNY3HnV19JuTapjP0Wbqa
 myM1hdbGCLOgD400vK1sysZrhkE3rXkbcrgULnN0IHU3JrpDFt8QuAdpApKHKc5QDrqD
 JWzC+y3MQYoRASyGg+TwXVq5JhXnc6eUF5DRj1x7bJFmdQe7iYLHXjHfRUSSgLnvB+to
 w09w==
X-Forwarded-Encrypted: i=1;
 AJvYcCURuYqGqz3WOqfzDHiYGdYyCEKBuFc1HAj9uuyzZVY6n/WhKbxd/LLXFqMYhpiY2d6rUcrQqz5NJyFJfwI=@nongnu.org,
 AJvYcCUWyG3BfblnVbv8weSsM2/+TH+BI0NNn18GPlPphcMnWcwDpok8Lcu2ytiG8v/vCuc4WvikW7HlrBh6@nongnu.org,
 AJvYcCUfd3FPBhskrC/7N0RURjipuBNF5LrzGRGQnuSDkTqSzm159jskaO9GKOiI/IKoi7buMalYWpkV2us=@nongnu.org,
 AJvYcCUrf+ZI0YVb2X3r7xwN3EId12FafLPZ5wUo8BAym6hjmMmscxIMoLBPTS7rkk0TbYKAcQeXnNXL/qhUyw==@nongnu.org
X-Gm-Message-State: AOJu0Yyue6sZ4FkbfFR7jJXlzmnWHV87+ynij4p6ERLAbK41AeusEVDl
 jtMaJah0rXAW+ozK6zYo0vvPSEigZojqq5jW0s7bso9pZeHGD5RQ
X-Google-Smtp-Source: AGHT+IEdWg0zYcRDr+tM0ZiqLFU9/RXyjSFD6tVOU27vUK0sVhE4gjIzMgCThBQlTp5rsbPCbB3LJg==
X-Received: by 2002:a05:600c:46c7:b0:431:50fa:89c4 with SMTP id
 5b1f17b1804b1-4318412acc0mr1723295e9.3.1729623129645; 
 Tue, 22 Oct 2024 11:52:09 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-183-109-172.77.183.pool.telefonica.de.
 [77.183.109.172]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a4b26dsm7202527f8f.45.2024.10.22.11.52.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 11:52:09 -0700 (PDT)
Date: Tue, 22 Oct 2024 18:52:06 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_07/12=5D_hw/sh4/r2d=3A_Real?=
 =?US-ASCII?Q?ize_IDE_controller_before_accessing_it?=
In-Reply-To: <2b180c87-fd5f-4c54-bc5d-757a45eb9285@tls.msk.ru>
References: <20240213130341.1793-1-philmd@linaro.org>
 <20240213130341.1793-8-philmd@linaro.org>
 <2b180c87-fd5f-4c54-bc5d-757a45eb9285@tls.msk.ru>
Message-ID: <DD4A9B72-6369-4DFA-BE17-1B26E1B4E374@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
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



Am 22=2E Oktober 2024 14:53:31 UTC schrieb Michael Tokarev <mjt@tls=2Emsk=
=2Eru>:
>On 13=2E02=2E2024 16:03, Philippe Mathieu-Daud=C3=A9 wrote:
>> We should not wire IRQs on unrealized device=2E
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>> Reviewed-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>> Reviewed-by: Yoshinori Sato <ysato@users=2Esourceforge=2Ejp>
>> ---
>>   hw/sh4/r2d=2Ec | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/hw/sh4/r2d=2Ec b/hw/sh4/r2d=2Ec
>> index e9f316a6ce=2E=2Ec73e8f49b8 100644
>> --- a/hw/sh4/r2d=2Ec
>> +++ b/hw/sh4/r2d=2Ec
>> @@ -285,9 +285,9 @@ static void r2d_init(MachineState *machine)
>>       dinfo =3D drive_get(IF_IDE, 0, 0);
>>       dev =3D qdev_new("mmio-ide");
>>       busdev =3D SYS_BUS_DEVICE(dev);
>> -    sysbus_connect_irq(busdev, 0, irq[CF_IDE]);
>>       qdev_prop_set_uint32(dev, "shift", 1);
>>       sysbus_realize_and_unref(busdev, &error_fatal);
>> +    sysbus_connect_irq(busdev, 0, irq[CF_IDE]);
>>       sysbus_mmio_map(busdev, 0, 0x14001000);
>>       sysbus_mmio_map(busdev, 1, 0x1400080c);
>>       mmio_ide_init_drives(dev, dinfo, NULL);
>
>Should we pick this up for stable-9=2E0 & -9=2E1 series?

IMO yes, because it fixes a regression=2E

Best regards,
Bernhard

>
>Thanks,
>
>/mjt


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FA1CF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 19:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stB8N-0002zS-IC; Tue, 24 Sep 2024 15:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stB8L-0002xW-Ed; Tue, 24 Sep 2024 15:23:37 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stB8J-0005Oj-Ca; Tue, 24 Sep 2024 15:23:37 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c26815e174so7398826a12.0; 
 Tue, 24 Sep 2024 12:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727205813; x=1727810613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UgEUYgYfC9gKZL+IX4g+KeWjybYyzdEv33LaMgl28Wk=;
 b=amxVy+UqpxD7MkdTq7620nXwK6nPkYdNt2hEG9K53ZE0KmV4mMNof7WjvN7xCXWAu1
 YQYOXcuKx0347NG8FfIq+O9uHMh5FR247Gi+S8zkKjN5VwnOeZVILlvUuI2O9+4iQQwu
 mQghTuq1ccuJp7Tsr/fenR0YTlcTMCftSiwBrqHIURi8jnwNPQwwcSOC8bkjEX32ABWl
 n8r0aJ2lEMT6XxDF5xirf7A+CK1tZjidIv+hTlwk2vXbg9oJWiZKpEq1BphBMzOfUwbG
 QfsYezRJzKwCQIzo9mPbuWRkc7h+9fXQ5eKsL0ipqKRMSczSWAi2zqLe972GmqCb8/7m
 jeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727205813; x=1727810613;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UgEUYgYfC9gKZL+IX4g+KeWjybYyzdEv33LaMgl28Wk=;
 b=G+P7VdDl3G1RjcpSUt0aluiW4gcwjnIc++ipyMm9WhvhJnmFuXEPNX1UL2kRkKOija
 MAof8jxLc33h1U+crZfk3CJeau+FwiAY4oa8w3o/mZESEWYWM1BupUKnV5VsDzJxBibW
 plEiEzPBLo+y1/viNnS9QXe+RZkS+t32X+0Wh+xOJF3VkfTG7SHp9SiT0aGY5vHpw3rR
 bll5zYsUH0aVFgdqBKBavEM0myWIBo5Zkoy67EXrak3MPjmW4AihIXbkcH8EWzXu3Cty
 5Rycxd9HoKHAWmBfKfA/CZBCbyTxSwFtRyJ7mc1wPUPPhCHUOtuo4rjcXVZg2XL72R9v
 oYEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4oFRcgQcX7dQbwuj9yr1cWtniIN4bCj6rKT8R0kDbJcOb6sXUI2qtAFS+AdS15dsyZ7znqacabRjs@nongnu.org,
 AJvYcCXCPI/0Lx2BRJ5aNlpVjNptqF6ZG8CHXYwyHUwbsKJg67+3F/AVMrNxN5I85Xy7oWH8676mipYjIwE=@nongnu.org
X-Gm-Message-State: AOJu0Yzp5ot88tJjp1CZxhfnGY7G52GlcR8wYsPrNb5Osh9mzL1CQmp0
 NQhDkaSHpvjsZVCjFXSAjhfgDI41NYo3gEtsVwnAgRExqNAI/mER
X-Google-Smtp-Source: AGHT+IH0u0KBG14PojqS2JNPJfzuHvcBNmOUp/iCOsdJqdZ9Pe9yV/OUtp6YikCPtXKSBEIayejyuw==
X-Received: by 2002:a05:6402:1e8a:b0:5c7:927:6a5e with SMTP id
 4fb4d7f45d1cf-5c720630dbcmr228514a12.21.1727205812739; 
 Tue, 24 Sep 2024 12:23:32 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-172-208.77.11.pool.telefonica.de.
 [77.11.172.208]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4ff7sm1078199a12.71.2024.09.24.12.23.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2024 12:23:32 -0700 (PDT)
Date: Tue, 24 Sep 2024 19:23:29 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_08/23=5D_hw/ppc/ppce500=5Fccsr=3A?=
 =?US-ASCII?Q?_Log_access_to_unimplemented_registers?=
In-Reply-To: <308608c8-8ea8-dedc-26c8-3a10016e9b9c@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-9-shentey@gmail.com>
 <308608c8-8ea8-dedc-26c8-3a10016e9b9c@eik.bme.hu>
Message-ID: <B8DD1B16-0246-44A4-A963-C0E9B7CB9371@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
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



Am 24=2E September 2024 10:15:43 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>On Mon, 23 Sep 2024, Bernhard Beschow wrote:
>> The CCSR space is just a container which is meant to be covered by plat=
form
>> device memory regions=2E However, QEMU only implements a subset of thes=
e devices=2E
>> Add some logging to see which devices a guest attempts to access=2E
>
>An aleternative solution for a similar problem is this:
>https://patchew=2Eorg/QEMU/20240520101007=2EA25A34E602E@zero=2Eeik=2Ebme=
=2Ehu/
>I don't know if that would be simpler for this device as well=2E

That was my first approach but I didn't like that `-d  unimp` causes unrel=
ated logging=2E With tracing one can be very targeted=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> hw/ppc/ppce500_ccsr=2Ec | 33 +++++++++++++++++++++++++++++++--
>> hw/ppc/trace-events   |  3 +++
>> 2 files changed, 34 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/hw/ppc/ppce500_ccsr=2Ec b/hw/ppc/ppce500_ccsr=2Ec
>> index 191a9ceec3=2E=2E28942b2348 100644
>> --- a/hw/ppc/ppce500_ccsr=2Ec
>> +++ b/hw/ppc/ppce500_ccsr=2Ec
>> @@ -15,14 +15,43 @@
>>  */
>>=20
>> #include "qemu/osdep=2Eh"
>> +#include "qemu/log=2Eh"
>> #include "e500-ccsr=2Eh"
>> +#include "trace=2Eh"
>> +
>> +static uint64_t ppce500_ccsr_io_read(void *opaque, hwaddr addr, unsign=
ed size)
>> +{
>> +    uint64_t value =3D 0;
>> +
>> +    trace_ppce500_ccsr_io_read(addr, value, size);
>> +    qemu_log_mask(LOG_UNIMP,
>> +                  "%s: unimplemented [0x%" HWADDR_PRIx "] -> 0\n",
>> +                  __func__, addr);
>> +
>> +    return value;
>> +}
>> +
>> +static void ppce500_ccsr_io_write(void *opaque, hwaddr addr, uint64_t =
value,
>> +                                  unsigned size)
>> +{
>> +    trace_ppce500_ccsr_io_write(addr, value, size);
>> +    qemu_log_mask(LOG_UNIMP,
>> +                  "%s: unimplemented [0x%" HWADDR_PRIx "] <- 0x%" PRIx=
32 "\n",
>> +                  __func__, addr, (uint32_t)value);
>> +}
>> +
>> +static const MemoryRegionOps ppce500_ccsr_ops =3D {
>> +    =2Eread =3D ppce500_ccsr_io_read,
>> +    =2Ewrite =3D ppce500_ccsr_io_write,
>> +    =2Eendianness =3D DEVICE_NATIVE_ENDIAN,
>> +};
>>=20
>> static void e500_ccsr_init(Object *obj)
>> {
>>     PPCE500CCSRState *ccsr =3D CCSR(obj);
>>=20
>> -    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
>> -                       MPC8544_CCSRBAR_SIZE);
>> +    memory_region_init_io(&ccsr->ccsr_space, obj, &ppce500_ccsr_ops, o=
bj,
>> +                          "e500-ccsr", MPC8544_CCSRBAR_SIZE);
>>     sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
>> }
>>=20
>> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
>> index 1f125ce841=2E=2Eca4c231c9f 100644
>> --- a/hw/ppc/trace-events
>> +++ b/hw/ppc/trace-events
>> @@ -143,6 +143,9 @@ ppc_irq_cpu(const char *action) "%s"
>> ppc_dcr_read(uint32_t addr, uint32_t val) "DRCN[0x%x] -> 0x%x"
>> ppc_dcr_write(uint32_t addr, uint32_t val) "DRCN[0x%x] <- 0x%x"
>>=20
>> +ppce500_ccsr_io_read(uint32_t index, uint32_t val, uint8_t size) "[0x%=
" PRIx32 "] -> 0x%08x (size: 0x%" PRIu8 ")"
>> +ppce500_ccsr_io_write(uint32_t index, uint32_t val, uint8_t size) "[0x=
%" PRIx32 "] <- 0x%08x (size: 0x%" PRIu8 ")"
>> +
>> # prep_systemio=2Ec
>> prep_systemio_read(uint32_t addr, uint32_t val) "read addr=3D0x%x val=
=3D0x%x"
>> prep_systemio_write(uint32_t addr, uint32_t val) "write addr=3D0x%x val=
=3D0x%x"
>>=20


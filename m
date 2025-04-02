Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A347EC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzxzQ-00047j-VT; Wed, 02 Apr 2025 09:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tzxzG-00046n-RE; Wed, 02 Apr 2025 09:18:35 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tzxzF-0000fl-3L; Wed, 02 Apr 2025 09:18:34 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so1322052066b.1; 
 Wed, 02 Apr 2025 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743599910; x=1744204710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PniuRpRB3lsKZaqg5iyLGjNtbCDutpffIWPoRHHmSzQ=;
 b=D/A9grjMsQzuEYGiu0lCoIOgTtRkNp2HKbxQkVzKWnq9VxWEd1fqYLuSmJ/Zv37+fz
 zFgQXIjkRdveM0cn23PThCtgbx+5mgupQXlNK9mwPSXQ8hEXo7h+mweFljAm9XuMwXMh
 F1+vlpSjYTjsIJYp21tY4lttYuwars0GNUCHYxqisfw+oRtk/YZe2nlyGHnQIqOOTQVb
 2WvsG3E+LrLKRG1+TTK5Gl2+VliWZp05lUk5vPQRUnWRX9kY1m1w3hjYFgDlNcpeIG7K
 LTMq5XmmJNPmVswscL3mc5vZiDWLqc93XUfShxqTcSECkzCrFyszwbPWs4sa3pgPIVi5
 CJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743599910; x=1744204710;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PniuRpRB3lsKZaqg5iyLGjNtbCDutpffIWPoRHHmSzQ=;
 b=pSegeLRcaYVDccKx494JNCCQ6FJAL1mf/WzWYDCWbSmrXXelO3ZyLFzxTatLsa6tGv
 FSb5/aUljn1xAIfJQyoKpaXgUkzZWOpw7NHZp4VqViRDLXc9IJ4WjOguY+h9LusLBXYO
 sXIHJEmnVJgEXuci64F3t5Er+TXBX7VQs+XAUyh/m1ReODRp91vLl8Zp5EcUeL4eOq4J
 61q5CtywKA5AQkxEj5se+dEAFyG7HJ4DxFDeNmOpIMyaAcqg12I/kfkXOZr9QL3QFgX4
 DOGPOHMVH2bJK9NoglNHKexsIeFamyJAO6Pu7JakVXKttYl8MBnVcHenLHo/50/1OX4/
 ANXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX79zyGzaRj0aYZbKAyJOPj+z0ET+Uas6+m049dRcDDXDZoQVOQ6l7auPxxxZ5yrp43yn61qGe97Y=@nongnu.org
X-Gm-Message-State: AOJu0Yz1zxiZQEr3IAQ9vWOVUbH01kcVoxYM2IF3RL2BMhDptyX2gKqS
 +rJ0ZFMX7DseQ/IVgmKrvdExw0Bhkxtkml09ajDRceHBcLCcYxq6
X-Gm-Gg: ASbGncvZ8Gedg+X69Lt0iGGL1MF8MQGT5B3c7M41Szt1dEK/0nRpPlTg1UesB6DNp1b
 Nzcz+RWTqbOiFc/c/Jl5A87VVn46hl3y9qtt4gy0UFxZVWbwOQibIXr7lEuVMJloebYEnruhWF5
 s8c2UTmui+zcWuK6bybeLOP2PDB1ppS+6H7sQz3D+iGUbZcX4ec+wPji0a0HvgB9Ceex4AO20zn
 OUXRTEUa8+nMdG2dE42D5edOdASOWoGJxioF4SMkkBp+kHs4WgIPE/0u8IHVNjVWrFQSSqNgDL9
 dwlrSXd1mSQXbKGrs/WR9DzRhNOnW3m3KmqmAAkyp8KE947TaIg=
X-Google-Smtp-Source: AGHT+IGIWodzYrySrwCCxpJeovrU3XZFGledIeLz7tiu+4DPV7qJP5b5DURRll49gaQXY6Fi2p8Cxg==
X-Received: by 2002:a17:906:c109:b0:ac2:d6d1:fe65 with SMTP id
 a640c23a62f3a-ac7a1a45387mr191439466b.41.1743599909907; 
 Wed, 02 Apr 2025 06:18:29 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71967fc5fsm923701666b.141.2025.04.02.06.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 06:18:29 -0700 (PDT)
Date: Wed, 02 Apr 2025 09:33:16 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] rust/hw/char/pl011/src/device: Implement logging
In-Reply-To: <Z-pdzUBa4CrBourR@redhat.com>
References: <20250330205857.1615-1-shentey@gmail.com>
 <20250330205857.1615-3-shentey@gmail.com> <Z-pdzUBa4CrBourR@redhat.com>
Message-ID: <318E2A13-A163-434B-B18A-8A260CD3BC27@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 31=2E M=C3=A4rz 2025 09:18:05 UTC schrieb "Daniel P=2E Berrang=C3=A9" <=
berrange@redhat=2Ecom>:
>On Sun, Mar 30, 2025 at 10:58:57PM +0200, Bernhard Beschow wrote:
>> Now that there is logging support in Rust for QEMU, use it in the pl011=
 device=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>  rust/hw/char/pl011/src/device=2Ers | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/rust/hw/char/pl011/src/device=2Ers b/rust/hw/char/pl011/sr=
c/device=2Ers
>> index bf88e0b00a=2E=2Ed5470fae11 100644
>> --- a/rust/hw/char/pl011/src/device=2Ers
>> +++ b/rust/hw/char/pl011/src/device=2Ers
>> @@ -8,9 +8,11 @@
>>      chardev::{CharBackend, Chardev, Event},
>>      impl_vmstate_forward,
>>      irq::{IRQState, InterruptSource},
>> +    log::{LOG_GUEST_ERROR, LOG_UNIMP},
>>      memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBui=
lder},
>>      prelude::*,
>>      qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, Reset=
Type, ResettablePhasesImpl},
>> +    qemu_log_mask,
>>      qom::{ObjectImpl, Owned, ParentField},
>>      static_assert,
>>      sysbus::{SysBusDevice, SysBusDeviceImpl},
>> @@ -298,8 +300,7 @@ pub(self) fn write(
>>              DMACR =3D> {
>>                  self=2Edmacr =3D value;
>>                  if value & 3 > 0 {
>> -                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implem=
ented\n");
>> -                    eprintln!("pl011: DMA not implemented");
>> +                    qemu_log_mask!(LOG_UNIMP, "pl011: DMA not implemen=
ted\n");
>>                  }
>>              }
>>          }
>> @@ -535,7 +536,7 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
>>                  u64::from(device_id[(offset - 0xfe0) >> 2])
>>              }
>>              Err(_) =3D> {
>> -                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad off=
set 0x%x\n", (int)offset);
>> +                qemu_log_mask!(LOG_GUEST_ERROR, "pl011_read: Bad offse=
t {offset}\n");
>>                  0
>>              }
>>              Ok(field) =3D> {
>> @@ -567,7 +568,10 @@ fn write(&self, offset: hwaddr, value: u64, _size:=
 u32) {
>>                  =2Eborrow_mut()
>>                  =2Ewrite(field, value as u32, &self=2Echar_backend);
>>          } else {
>> -            eprintln!("write bad offset {offset} value {value}");
>> +            qemu_log_mask!(
>> +                LOG_GUEST_ERROR,
>> +                "pl011_write: Bad offset {offset} value {value}\n"
>> +            );
>>          }
>
>General conceptual question =2E=2E=2E=2E=2E  I've never understood what t=
he dividing
>line is between use of 'qemu_log_mask' and trace points=2E

I *think* it's the perspective: If you want to see any issues, regardless =
of which device, use the -l option, i=2Ee=2E qemu_log_mask()=2E If, however=
, you want to see what a particular device does, use tracepoints=2E

>The latter can be
>optionally built to feed into qemu log, as well as the other dynamic trac=
e
>backends=2E

The use of qemu_log() in qemu_log_mask() seems like an implementation deta=
il to me=2E Theoretically, qemu_log_mask() could use a different backend if=
 this got implemented, and wouldn't require code changes throughout QEMU=2E

Best regards,
Bernhard

>
>Is there a compelling reason to use 'qemu_log', that isn't acceptable for
>trace probe points ?
>
>This is an indirect way of asking whether qemu_log_mask should be exposed
>to rust, or would exposing tracing be sufficient ?
>
>With regards,
>Daniel


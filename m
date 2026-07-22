Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06695C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmaxT-0008Rb-M8; Wed, 22 Jul 2026 13:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmaxR-0008RQ-IH
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmaxO-0006kg-G4
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784742128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zr0atolwmvOAIMYjCTZIDJ+P5mT45pYsN69ioL8FBR0=;
 b=M29W6SIjr73tQP/QVzgnqvFHHhx+ztWX02uX14gjmPDAx2u6NwAoCuA4qn1w+iZBnWxexV
 MignHJ70I0Iu1AVO/2cbZUl1ZsABQ0NAvxvyEvUc0veh/2rMVTz+AWdj8s2VDM+hpkafJ/
 SEa/sgtkXZnxU3BLDkZ0sfgwMedj04A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-wQsEsmHPMzCuAH2DTI69Ig-1; Wed, 22 Jul 2026 13:42:06 -0400
X-MC-Unique: wQsEsmHPMzCuAH2DTI69Ig-1
X-Mimecast-MFC-AGG-ID: wQsEsmHPMzCuAH2DTI69Ig_1784742125
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f726186c4so2765622f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784742125; x=1785346925; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zr0atolwmvOAIMYjCTZIDJ+P5mT45pYsN69ioL8FBR0=;
 b=JeYf7HgYtEQukEEbAYq5zVSLrXwbm6QfB4U0alNRkASMDTVtLR8ZSzusWaoy6qGOxt
 Pig67DMpl2W3JKiI8NMZpaV91FsWpYfzgNpx302hZmeb0ks4GNMH/IzInQZE0vWUOrRc
 M+yyeX+W2LbchsYrlytOGN9sUeJtzNmRgFNN0ONcLTpAvw+4gt8rtoPN6KBTnq9dr55k
 PuGnRcUdTEEdYnfetYMmSXTJ/WT6Ct19iFc3TidZmCKtFraiDSJ6tA1qYeKBX8WkrdI4
 GTENkbi9iCASAAteXXpgkudi4cn4ZKg5nwiq0BVoBcYFel6C31nM+hq9jZHiYPVZOyvw
 viPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784742125; x=1785346925;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zr0atolwmvOAIMYjCTZIDJ+P5mT45pYsN69ioL8FBR0=;
 b=RDHLBRtD38AwgXtdZr0vcZAT2+tX4pcJV5SZDwoYnOnuP4xiCk0YqhBQk5C3NDPklY
 Rqu0OnM2fXLMncQAOl3wnpmt0hLDRcch8lufEaVc69DelizIHXwQ4SggHjD++pXqhdyY
 ky6GPONQrh6e+3CfqtjYgktXtLcdevDsk5N9wGI9PjZyigr655eHnIA+mh+kZzttHVji
 4LGjVo6jr8fDZyuLZl8N7s8NjR+KEjnUKsMKa0PX0q7r1LQBapCfRYILqvQq/Lv70YRK
 FkQwtawRLtyDniCWbTEgxpdlPdFonn+FQWfyXhtykioz7rZnG2CrD4sM7S81EEGOxSB3
 BO+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIwCnsO8nJjNlcEboMgdznQ6HHTLGf312WGUL32vrVlGDtWsCH/0BTLMtlgP1oVMWfHznScoNB/cgP@nongnu.org
X-Gm-Message-State: AOJu0YxSt3IdtMdW78hYur9jX0Jw+Im1L5qTV4ueLdPU9uI3aU0JIsaK
 A8YO1CTNf/CaSWNfE1vIjVyTzESWk1TBBPwP4sfL6682Vee0gb9qK4QSCN9PYbcw3RPtSoOARRJ
 t1/48odG3yfeVV9azSk/rYsh67dMOlL02sl39i1V2IN0RcklREYghdad/
X-Gm-Gg: AR+sD11/3nr0eszXibviSM0ANGRHiKrm2EEVi7gs7bFeJCbRmUDWUjPA6ZAWGMNwG+m
 vrirRdEZmYigIrI/BBkMbEw9yt9qkaqnhn/dZdlkFDGoFsGZgDOXWJPzU4NkxEf4hC+oEjzGH8f
 JYo6anBXOdk6tI8eQOCMIZUB0r+no7UXt41p1vMQazClO/MA4Fsz0R6k91rQfj7T7X2MXX0jCLD
 TcEiXUWiS+v8rg0bciMOLfOS+mjr1PxvSFHUdh9SFpOmmi0V+Znd4eqRBt7NH3jc316Kr48I3gA
 DNClHomdY/vc6yYKm6QYtS6tIdP5Y9AhVY7jLylEKpyZXdNRFl8w4q4YVsUGrxg5ieJK4GriEqB
 Y9zxojh6PmrNT3EJyvN4xpTcJpRtcUEJHjJz2W8Y=
X-Received: by 2002:a05:600c:19c8:b0:495:6134:6d61 with SMTP id
 5b1f17b1804b1-4956202554emr145602395e9.19.1784742125358; 
 Wed, 22 Jul 2026 10:42:05 -0700 (PDT)
X-Received: by 2002:a05:600c:19c8:b0:495:6134:6d61 with SMTP id
 5b1f17b1804b1-4956202554emr145602165e9.19.1784742124856; 
 Wed, 22 Jul 2026 10:42:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a634cf9sm93979735e9.9.2026.07.22.10.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 10:42:04 -0700 (PDT)
Message-ID: <50c0880d-6763-4788-8c66-be6c356a2e59@redhat.com>
Date: Wed, 22 Jul 2026 19:42:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hw/i2c: Add remote I2C master with host CUSE bridge
To: Ilya Chichkov <ilya.chichkov.dev@gmail.com>, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <20260722125713.406245-1-ilya.chichkov.dev@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260722125713.406245-1-ilya.chichkov.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/22/26 14:57, Ilya Chichkov wrote:
> Add a "remote-i2c-master" device that exposes a QEMU I2C bus to the
> host system through a FUSE/CUSE character device. This lets external
> host programs and standard i2c-tools interact with I2C slaves emulated
> inside QEMU as if they were real devices attached to the host.
> 
> The implementation is split into three layers:
> 
>    - A non-blocking finite state machine that drives the QEMU I2C
>      master. It is pumped by a QEMU Bottom Half and uses virtual timers
>      to yield during long transfers and to model clock stretching for
>      asynchronous slaves, so the main loop is never blocked. The FSM
>      walks IDLE -> ADDR -> SEND/RECV -> WAIT_STRETCH -> END -> FINISHED
>      and handles NACKs (ENXIO), lost arbitration (EBUSY, with optional
>      back-off and retry), stretch timeouts, and manual abort/reset.
> 
>    - An abstract RemoteI2CBackend QOM base class that decouples the
>      internal I2C hardware state machine (the frontend) from any
>      host-specific transport, exposing on_tx_complete and on_tx_error
>      virtual callbacks.
> 
>    - A concrete remote-i2c-backend-cuse backend implementing that
>      transport over CUSE. It manages the FUSE session and integrates
>      its file descriptors into QEMU's main AioContext event loop,
>      translates Linux I2C_RDWR, I2C_SMBUS and I2C_SLAVE ioctls into
>      generic byte streams for the FSM, and formats responses back into
>      Linux I2C/SMBus structures for the FUSE driver. SMBus repeated
>      start is supported for atomic write-then-read operations.
> 
> Example usage:
> 
>    -device remote-i2c-master,i2cbus=i2c-bus.0,devname=i2c-33
>    -object remote-i2c-backend-cuse,id=b0,devname=i2c-33
> 
> This creates /dev/i2c-33 on the host, usable with i2c-tools:
> 
>    i2cdetect -y -l
>    i2cget -y <bus_id> <addr> <reg>
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
> ---
> v2:
>    - docs/system/devices/remote-i2c-master.rst: Documented concurrent
>      bus access details and the 'raise-arbitrage-lost' property.
> ---
> v3:
>    - qapi/qom.json: Fix RemoteI2CBackendCuseProperties formatting and
>      expand member documentation (devname, fuse-opts, debug).
>    - tests/qtest: Add remote-i2c-cuse-test covering capabilities,
>      functional smoke test, synchronous sensor read/write.
> ---
> v4:
>   - qapi: reference the rst doc via :doc:
>   - qapi: fuse-opts is now ['str'] instead of a space-separated string
>   - qapi: drop redundant 'debug' property (pass -d via fuse-opts)
> ---
> v5:
>   - docs/system/device-emulation.rst: add remote-i2c-master.rst to
>     the toctree under "Emulated Devices"
>   - qapi/qom.json: move RemoteI2CBackendCuseProperties definition
>     before RemoteObjectProperties as requested; change "for usage
>     information" to "for detailed usage information"
> ---
> ---
>   docs/system/device-emulation.rst          |    1 +
>   docs/system/devices/remote-i2c-master.rst |  217 ++++
>   hw/i2c/Kconfig                            |    5 +
>   hw/i2c/meson.build                        |    6 +
>   hw/i2c/remote-i2c-backend.c               |   30 +
>   hw/i2c/remote-i2c-cuse.c                  | 1173 +++++++++++++++++++++
>   hw/i2c/remote-i2c-fsm.c                   |  521 +++++++++
>   hw/i2c/remote-i2c-master.c                |  145 +++
>   hw/i2c/trace-events                       |   29 +
>   include/hw/i2c/remote-i2c-backend.h       |   70 ++
>   include/hw/i2c/remote-i2c-cuse.h          |   93 ++
>   include/hw/i2c/remote-i2c-master.h        |   77 ++
>   qapi/qom.json                             |   29 +
>   tests/qtest/meson.build                   |    2 +
>   tests/qtest/remote-i2c-cuse-test.c        |  326 ++++++
>   15 files changed, 2724 insertions(+)
>   create mode 100644 docs/system/devices/remote-i2c-master.rst
>   create mode 100644 hw/i2c/remote-i2c-backend.c
>   create mode 100644 hw/i2c/remote-i2c-cuse.c
>   create mode 100644 hw/i2c/remote-i2c-fsm.c
>   create mode 100644 hw/i2c/remote-i2c-master.c
>   create mode 100644 include/hw/i2c/remote-i2c-backend.h
>   create mode 100644 include/hw/i2c/remote-i2c-cuse.h
>   create mode 100644 include/hw/i2c/remote-i2c-master.h
>   create mode 100644 tests/qtest/remote-i2c-cuse-test.c

If I understand this proposal correctly, it lets host-side i2c
tools talk to emulated I2C devices. The example is i2cdetect/i2cget
against a tmp105 on an Aspeed bus.

QEMU already has mechanisms for this though. qtest can read/write I2C
registers programmatically, QMP can query device state, and the guest
OS itself sees the I2C bus natively.

The dependency cost seems high for the use case: libfuse3 + the cuse
kernel module pulled into the system emulator build. It's also ~3K
lines of new code, three QOM types, FUSE session management, etc.
The surface area for bugs is large. It's a heavy burden for what it
gives.

I think a lighter QMP-based approach would serve the same purpose,
maybe better, and fit in better in QEMU, without the dependency and
maintenance cost:

- No host kernel dependency
- Works remotely (QMP over socket)
- Fits QEMU's existing management model
- Much less code
- Testable without root or kernel modules

Have you considered extending QMP with an I2C transaction command
instead? Something like:

   { 'command': 'i2c-transfer',
     'data': { 'bus': 'str',
               'address': 'uint8',
               'read': 'bool',
               '*data': ['uint8'],
               '*length': 'uint16' },
     'returns': { '*data': ['uint8'] } }


Thanks,

C.



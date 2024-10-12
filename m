Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F308BCF2568
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 13:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szcUQ-0000AS-L2; Sat, 12 Oct 2024 09:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1szcUM-0000A9-EU; Sat, 12 Oct 2024 09:48:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1szcUJ-0004th-HR; Sat, 12 Oct 2024 09:48:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43058268d91so25913105e9.0; 
 Sat, 12 Oct 2024 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728740933; x=1729345733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b68f4+hawR+Pot/6Et04Wdy2hEPXLocMeMbvW4uK5Cc=;
 b=jsBc5ZoYFENSbuIF9qWpAuheFSbF0njUsU4gu6z24nTsGerQ3mo91r0yGS6jjeL4op
 pk5gM00PMgPFkhRMqruvP323TCDOPJZK07sQTwnFd7q2oqa/SLE4pQuJjHLehoz1pZ3E
 GQ+o5tG3OZem9qCQJlkj9MPTeTvIDP9GNcRBiSCVlUXNkCLAbz1dTE5H/PGZoa+M4omH
 G/xlClQCuA0Am+6Nve2g3F+fQPtyVVGcvq/+fGEMEzTlotO/AUiaCOz9pE624jSYQf71
 G4hGJpZkM5SvlJStq55F5HtgxG3Hxz0FiALLCDu0oNDORV1tbylfHZupAJ/lgtCRI4W8
 5F8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728740933; x=1729345733;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b68f4+hawR+Pot/6Et04Wdy2hEPXLocMeMbvW4uK5Cc=;
 b=kw0bvqvvvP3CHwuRJ8xNDNHgGMa9HNzyxg5x8GX6etRHGqaplwymOGpQorONV4IU+K
 vr460PO/qdAs7tRu5e4AZQKHRMGZkp4mMC3WE7j1nR8tjGd9JavYkTmwrnwT42orPfAj
 obMIAfa95KyvvzLrpTrf8b7Yh5OBn964KwSuZfGpd/2rarSx4AGEeE4vCAhSnZUFW+Uo
 qPH8W6uuiSaPoQY6+BM2eF3bhdqH494SC78fWoSlqOl7eZlnL6u/IdkXPBygV0I2R1B6
 pxnUKQi68QJYPKqapv+ZiNQopASv+ApbrYRHOgsJfryeI1zN4I444HYoT+F5LVf1vAem
 V05A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5L0B7U4hiTJQhi7RlfZroakLv0BPcI8LS5ATsrbLtUxoMjPeGk8Cj4x1xYdMeKVjpndRpJAH9iew=@nongnu.org,
 AJvYcCWs8PVqKB0z5VAo752aK4zLO9V6DRuyy4oApiEkKNtwwXuhFbr6FcqT7QZLA/FWSIOr513RTty1hdOX@nongnu.org
X-Gm-Message-State: AOJu0YyGuitWz0prkJlxRvKCRHf+f95ndPy7brcNnGRFMT8cvDsXqdVD
 WxKGDAgd3xqZYNZGy/56dnbQlnh4hbiQpUdyXvhWyzOpUSefuwQ6
X-Google-Smtp-Source: AGHT+IFKlC3gnwJllLEq3FXVkulbfsmKAnZ9+coMzypRzFR2+aqV5YqebuP0M8s4StTMBao1/kudNw==
X-Received: by 2002:a05:600c:228c:b0:42f:80f4:ab2b with SMTP id
 5b1f17b1804b1-4311dee6f58mr53684515e9.19.1728740933037; 
 Sat, 12 Oct 2024 06:48:53 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-117-250.77.11.pool.telefonica.de.
 [77.11.117.250]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b7edea7sm6365107f8f.93.2024.10.12.06.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 06:48:52 -0700 (PDT)
Date: Sat, 12 Oct 2024 13:48:52 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_08/23=5D_hw/ppc/ppce500=5Fccs?=
 =?US-ASCII?Q?r=3A_Log_access_to_unimplemented_registers?=
In-Reply-To: <a201615f-90b1-1d8e-75ea-0766e231a0a8@eik.bme.hu>
References: <20241005194603.23139-1-shentey@gmail.com>
 <20241005194603.23139-9-shentey@gmail.com>
 <a201615f-90b1-1d8e-75ea-0766e231a0a8@eik.bme.hu>
Message-ID: <8A01056C-6D93-4318-8AA3-1F3FE048516D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
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



Am 6=2E Oktober 2024 17:12:16 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>On Sat, 5 Oct 2024, Bernhard Beschow wrote:
>> The CCSR space is just a container which is meant to be covered by plat=
form
>> device memory regions=2E However, QEMU only implements a subset of thes=
e devices=2E
>> Add some logging to see which devices a guest attempts to access=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> hw/ppc/ppce500_ccsr=2Ec | 32 +++++++++++++++++++++++++++++++-
>> hw/ppc/trace-events   |  3 +++
>> 2 files changed, 34 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/ppc/ppce500_ccsr=2Ec b/hw/ppc/ppce500_ccsr=2Ec
>> index 5d0e1e0e89=2E=2E6659560674 100644
>> --- a/hw/ppc/ppce500_ccsr=2Ec
>> +++ b/hw/ppc/ppce500_ccsr=2Ec
>> @@ -13,12 +13,42 @@
>>=20
>> #include "qemu/osdep=2Eh"
>> #include "ppce500_ccsr=2Eh"
>> +#include "qemu/log=2Eh"
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
>
>I'm not sure having both unimp log and traces is the best way=2E I though=
t unimp log with an unimplemented device area would be the simplest and lea=
st intrusive for the code but if you prefer traces then maybe we don't need=
 unimp logs=2E But adding these otherwise empty functions (which won't get =
populated as subdevices have their own regions) still bothers me a bit but =
not enough to block this if others have no opinion on it=2E
>
>I also had this patch:
>https://patchew=2Eorg/QEMU/cover=2E1728232526=2Egit=2Ebalaton@eik=2Ebme=
=2Ehu/
>which I first thought might help but that's about guest_errors not unimp =
logs so does not apply here=2E What other unimp logs get in the way here th=
at makes traces a better choice?

I have some rough implementations of a few other device models with unimp =
logging=2E Having a dedicated trace here allows to see which unoccupied CCS=
R regions a guest pokes=2E The unimp logging here actually disturbs the abo=
ve, so I'd remove it here=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
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
>> static void ppce500_ccsr_init(Object *obj)
>> {
>>     PPCE500CCSRState *s =3D CCSR(obj);
>>=20
>> -    memory_region_init(&s->ccsr_space, obj, "e500-ccsr", MPC85XX_CCSRB=
AR_SIZE);
>> +    memory_region_init_io(&s->ccsr_space, obj, &ppce500_ccsr_ops, obj,
>> +                          "e500-ccsr", MPC85XX_CCSRBAR_SIZE);
>>     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->ccsr_space);
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


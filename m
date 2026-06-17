Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC6DCD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZpab-0007cV-Um; Wed, 17 Jun 2026 08:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <valium7171@gmail.com>)
 id 1wZpaZ-0007c3-HE
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:41:51 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <valium7171@gmail.com>)
 id 1wZpaX-0000Gz-OP
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:41:51 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-30bcc877b4cso1843447eec.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 05:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781700107; x=1782304907; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwNqM8U/nOPFDyVIKjFGYM3SNCvUVOidPaVLY5kIdT0=;
 b=mFC0KP1gld4RXFhvGCsy5NvnfMIAfw4zoY9MhKuEbzEq0CD2ercTl2398dG7TR3kfU
 imuCpYENTTowP8OrYQ4mKd+89lJM2FoJ4lXN3iAtTp5/MttZ1oe1yk6O5Ap5crX6SHb+
 pPAeLy1WauxZI2tpMZr6xSbhQwoR0XUSyswueWXwUI1kKeXdJRxJNxvlUM6rQIK0eDoM
 FpXOda4EZp1GuFVjNVT/HE4s2YfORvQ4A7f78fcnRPAE4KGslsRso5N+3HqhTHe7cnvj
 eTtizn6T8XIP/RzVojJ5KzLjQqdIijnmGqSGDsVsoY61OgfeZCSgAWDIUL2CtbaZp3LH
 n00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781700107; x=1782304907;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wwNqM8U/nOPFDyVIKjFGYM3SNCvUVOidPaVLY5kIdT0=;
 b=JjPbnRt1F5RO9NJqWbmzDOUZNAe1S4w0XpWsTdVVWAWXMYuQgUYIPiiuPOW0xvBNW7
 V24eRihZFa7SSfcohALNGXrGxNGBzyKk8CtNU9SWr5j7Jw/2QEoH+ncWptDba0XudI8A
 LomSM6aeuMYSsK4IyniYtJc1w2zxFaQnzrbHYIDp+zi84EyPDu1nhPAIyd1yBh1uD6dH
 LLrRnjgc2eFd45Iuv/TCeztN9YMeSU8MrxZCJVfZReVjBaT1Nj9xcdqkG2EdHbkJME2s
 f1AnyOYu++vtibFBl6/odxZ20lBf4B2uhtmGl12f1WhjdAhmeMU0EwfNX2JDlKgmsMda
 m+6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wcZwzhQec4P2uRzY5y1N7nm8vpFYZsxQrdqkneBQUgMRZyHYFiYihTQD40mL+eiC2pX3LeXciE82u@nongnu.org
X-Gm-Message-State: AOJu0YxiW9ebL9CsZZ33KbjIxAxGqfa6HDll+B1L9nctkShIDeRcWkLv
 e473lshcyJRbHHf15nFcWdmSvxhQqDJJngv1eRA9YohqJViefyJl/eD9
X-Gm-Gg: AfdE7cmdmR6BbiAlLyJitX7omOBd4Y8o26/jIjGbBPgH5srIkvz4f0S/IR18uTjHHi3
 t2V+bFK4WJYCEshF4qirEV/E7fDginX0TgTEv3UJEr0T5VE5W+1EAlVq96yJrqiNFUe6Ar37gmA
 ohpzXxb95weZgV/GE7Q5SjklvM48GRSJ81GF42miCgNsaE/j8LZx2OPY+3PysNxRAIQ3gFMzXET
 OELqMiA2XK4elTuLlbQvjYao7/5gO8EKmUHVjSsBAA+slsp6udES+CIZ3Le2tWDK4OJ7S9qGfXw
 QKJL+tDVwiyRF/NpqLmZ93t69evU0bs9K0AY063KoHIT55gu6M30TA3kpk2Hkbedc9JfBkerNY7
 6dMrrGxDIilLXTk3Wmgj+S4bOGe2hyCDCNGhJ8LmYxY/5OOAJlWakkt0YWVE5RxZ+oSbambss7K
 B7tGCFgDoIoNXSyQ==
X-Received: by 2002:a05:693c:2288:b0:304:de2b:446f with SMTP id
 5a478bee46e88-30bca0aadf5mr1974698eec.28.1781700107432; 
 Wed, 17 Jun 2026 05:41:47 -0700 (PDT)
Received: from localhost ([157.49.125.56]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30bcbb684absm2964802eec.1.2026.06.17.05.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 05:41:46 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 18:11:39 +0530
Message-Id: <DJBBZ2BGKC09.1PYR052VO8LCK@gmail.com>
Cc: <laurent@vivier.eu>, <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] linux-user: Fix AT_PHDR when program headers are
 relocated into their own segment
From: "valium" <valium7171@gmail.com>
To: "Helge Deller" <deller@gmx.de>, "valium007" <valium7171@gmail.com>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20260613152156.41147-1-valium7171@gmail.com>
 <7d65e071-ca12-4d48-88df-9ff08c70fa75@gmx.de>
In-Reply-To: <7d65e071-ca12-4d48-88df-9ff08c70fa75@gmx.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=valium7171@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon Jun 15, 2026 at 9:36 PM IST, Helge Deller wrote:
> On 6/13/26 17:21, valium007 wrote:
>> When a binary is patched or relocated such that the program header table=
 is
>> moved into a separate PT_LOAD segment=20
>
> How relevant is this? How/why does it happen?

This is very much relevant with the issue. This can happen when certain
packers/protectors move the phdrs into a separate PT_LOAD for the
purpose of anti-tamper/protection mechanisms. The patched binary will
run on real environment but not on QEMU (in most cases the binary will
segfault).

> Can you sign with a real name?

Sure, this is my very first patch on qemu, to continue with this I think
I need to send the patch again with my real name signed off?


>> ---
>>   linux-user/elfload.c | 21 ++++++++++++++++++++-
>>   linux-user/qemu.h    |  1 +
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index b05b8b0..8049c8a 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -699,7 +699,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int =
argc, int envc,
>>       /* There must be exactly DLINFO_ITEMS entries here, or the assert
>>        * on info->auxv_len will trigger.
>>        */
>> -    NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff));
>> +    NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->phdr_addr));
>>       NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
>>       NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
>>       NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
>> @@ -1469,6 +1469,12 @@ static void load_elf_image(const char *image_name=
, const ImageSource *src,
>>       info->data_offset =3D load_bias;
>>       info->load_addr =3D load_addr;
>>       info->entry =3D ehdr->e_entry + load_bias;
>> +    /*
>> +     * Fallback for AT_PHDR if the program headers do not fall within
>> +     * any PT_LOAD segment (see the loop below, which overrides this wi=
th
>> +     * the correct in-memory address when a containing segment is found=
).
>> +     */
>> +    info->phdr_addr =3D load_addr + ehdr->e_phoff;
>>       info->start_code =3D -1;
>>       info->end_code =3D 0;
>>       info->start_data =3D -1;
>> @@ -1523,6 +1529,19 @@ static void load_elf_image(const char *image_name=
, const ImageSource *src,
>>               vaddr_ef =3D vaddr + eppnt->p_filesz;
>>               vaddr_em =3D vaddr + eppnt->p_memsz;
>>  =20
>> +            /*
>> +             * If this segment contains the program headers, record the=
ir
>> +             * in-memory address for AT_PHDR. This matches the kernel, =
which
>> +             * locates the headers via the containing PT_LOAD rather th=
an
>> +             * assuming load_addr + e_phoff (false when the phdrs are n=
ot
>> +             * mapped 1:1 from file offset 0, e.g. relocated into their=
 own
>> +             * segment by a binary patcher).
>> +             */
>> +            if (eppnt->p_offset <=3D ehdr->e_phoff &&
>> +                ehdr->e_phoff < eppnt->p_offset + eppnt->p_filesz) {
>> +                info->phdr_addr =3D vaddr + (ehdr->e_phoff - eppnt->p_o=
ffset);
>> +            }
>> +
>>               /*
>>                * Some segments may be completely empty, with a non-zero =
p_memsz
>>                * but no backing file segment.
>> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
>> index 07fe801..2268493 100644
>> --- a/linux-user/qemu.h
>> +++ b/linux-user/qemu.h
>> @@ -26,6 +26,7 @@
>>   struct image_info {
>>           abi_ulong       load_bias;
>>           abi_ulong       load_addr;
>> +        abi_ulong       phdr_addr;
>>           abi_ulong       start_code;
>>           abi_ulong       end_code;
>>           abi_ulong       start_data;



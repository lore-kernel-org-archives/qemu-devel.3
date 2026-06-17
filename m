Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA34CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtRZ-0001oZ-Jh; Wed, 17 Jun 2026 12:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZtRX-0001oA-QC
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:48:47 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZtRV-0006Yv-Nk
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781714921; x=1782319721; i=deller@gmx.de;
 bh=GzLKgnj2O1gjUDwwPmkZC6bC7TkEJnS+LybnHSeLLZY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=WLQZno0m40AkuQ/HehrNpfrIKMJMq1IQrP0rlf1QPtyLSvHnIoa7rRRyx9MliRPp
 I8XK0pCAmJo2ZfhyrPrs0HsIEL7gmHB0h5krkl2mdX6nYrxc479REbLfV0bLyRdL3
 erGiFYxrcefSbts//z0GaaEbUeZjuH3mnLVGfBC6MJebU5eTn9XBrB37NeOdcgUav
 03UTMU4SaV8yfcOpbGP0MAv5QZoO3nKj51op8sL+pWxZP5o+2zCY/fm7yAuZZ3PzA
 qEaOKMTfnkcdACL+6SdN2r3eF++is2pVhm4F702vXmS/xzTJTjIsTUX+DEWBTBfx2
 MGhSPTaeunzXFMBIhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwbp-1wTaq023sP-003GB0; Wed, 17
 Jun 2026 18:48:41 +0200
Message-ID: <b68ba255-8f8c-4c46-8090-5a7c73b4b46f@gmx.de>
Date: Wed, 17 Jun 2026 18:48:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix AT_PHDR when program headers are
 relocated into their own segment
To: valium <valium7171@gmail.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, pierrick.bouvier@oss.qualcomm.com
References: <20260613152156.41147-1-valium7171@gmail.com>
 <7d65e071-ca12-4d48-88df-9ff08c70fa75@gmx.de>
 <DJBBZ2BGKC09.1PYR052VO8LCK@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <DJBBZ2BGKC09.1PYR052VO8LCK@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3LsTw/BpR9TuhWkG+1KU3eoSWLLP3tnXstP15VHM4Plpmo6ni0M
 NhZTUVavATwP7Y4eB/Ip4SobYC7lHmm88ATdornjYw1D9oEaFkG926LJFLUgjtIuJgkreLe
 ShtfrJjlQsmzCU3/44h9QI+Td19YWPRwmL+KzRT+WyiWvLsn/3Zf21BrgZI8CO1QoTjrz2Y
 JPYwE7YrF1AyvL7yg7h3g==
UI-OutboundReport: notjunk:1;M01:P0:5GRvdGkJ6Dw=;8aHpXpgKgJ6uMJuYvP4BpKBte99
 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
 jtUAxahIVykjdTNX3VEU14piKrV91Q4TldEkXpC
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, DRUGS_ANXIETY=0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 6/17/26 14:41, valium wrote:
> On Mon Jun 15, 2026 at 9:36 PM IST, Helge Deller wrote:
>> On 6/13/26 17:21, valium007 wrote:
>>> When a binary is patched or relocated such that the program header tab=
le is
>>> moved into a separate PT_LOAD segment
>>
>> How relevant is this? How/why does it happen?
>=20
> This is very much relevant with the issue. This can happen when certain
> packers/protectors move the phdrs into a separate PT_LOAD for the
> purpose of anti-tamper/protection mechanisms. The patched binary will
> run on real environment but not on QEMU (in most cases the binary will
> segfault).

Ok. (Still seems like a niche issue).
 =20
>> Can you sign with a real name?
>=20
> Sure, this is my very first patch on qemu, to continue with this I think
> I need to send the patch again with my real name signed off?

It's sufficient if you let us know what it should be.

Helge

>=20
>>> ---
>>>    linux-user/elfload.c | 21 ++++++++++++++++++++-
>>>    linux-user/qemu.h    |  1 +
>>>    2 files changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>>> index b05b8b0..8049c8a 100644
>>> --- a/linux-user/elfload.c
>>> +++ b/linux-user/elfload.c
>>> @@ -699,7 +699,7 @@ static abi_ulong create_elf_tables(abi_ulong p, in=
t argc, int envc,
>>>        /* There must be exactly DLINFO_ITEMS entries here, or the asse=
rt
>>>         * on info->auxv_len will trigger.
>>>         */
>>> -    NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff)=
);
>>> +    NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->phdr_addr));
>>>        NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
>>>        NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
>>>        NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
>>> @@ -1469,6 +1469,12 @@ static void load_elf_image(const char *image_na=
me, const ImageSource *src,
>>>        info->data_offset =3D load_bias;
>>>        info->load_addr =3D load_addr;
>>>        info->entry =3D ehdr->e_entry + load_bias;
>>> +    /*
>>> +     * Fallback for AT_PHDR if the program headers do not fall within
>>> +     * any PT_LOAD segment (see the loop below, which overrides this =
with
>>> +     * the correct in-memory address when a containing segment is fou=
nd).
>>> +     */
>>> +    info->phdr_addr =3D load_addr + ehdr->e_phoff;
>>>        info->start_code =3D -1;
>>>        info->end_code =3D 0;
>>>        info->start_data =3D -1;
>>> @@ -1523,6 +1529,19 @@ static void load_elf_image(const char *image_na=
me, const ImageSource *src,
>>>                vaddr_ef =3D vaddr + eppnt->p_filesz;
>>>                vaddr_em =3D vaddr + eppnt->p_memsz;
>>>   =20
>>> +            /*
>>> +             * If this segment contains the program headers, record t=
heir
>>> +             * in-memory address for AT_PHDR. This matches the kernel=
, which
>>> +             * locates the headers via the containing PT_LOAD rather =
than
>>> +             * assuming load_addr + e_phoff (false when the phdrs are=
 not
>>> +             * mapped 1:1 from file offset 0, e.g. relocated into the=
ir own
>>> +             * segment by a binary patcher).
>>> +             */
>>> +            if (eppnt->p_offset <=3D ehdr->e_phoff &&
>>> +                ehdr->e_phoff < eppnt->p_offset + eppnt->p_filesz) {
>>> +                info->phdr_addr =3D vaddr + (ehdr->e_phoff - eppnt->p=
_offset);
>>> +            }
>>> +
>>>                /*
>>>                 * Some segments may be completely empty, with a non-ze=
ro p_memsz
>>>                 * but no backing file segment.
>>> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
>>> index 07fe801..2268493 100644
>>> --- a/linux-user/qemu.h
>>> +++ b/linux-user/qemu.h
>>> @@ -26,6 +26,7 @@
>>>    struct image_info {
>>>            abi_ulong       load_bias;
>>>            abi_ulong       load_addr;
>>> +        abi_ulong       phdr_addr;
>>>            abi_ulong       start_code;
>>>            abi_ulong       end_code;
>>>            abi_ulong       start_data;
>=20
>=20



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E9ECD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 21:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVFru-0005Hh-Oe; Thu, 04 Jun 2026 17:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wVFrs-0005HI-Nj
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:44:48 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wVFrq-0003hr-SY
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780609483; x=1781214283; i=deller@gmx.de;
 bh=gGZlW/U9UN3P89xYFP2Zd4kgihij11DrYDa1aRu52hQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=G0ftQpfm6Ph2eZZM+i+uSaoSYV/+7LYk5Rn0hSOilzB9xOl5sorq89sI4RMAqvJM
 UvNVTaSV0fLo+KYiExiwVzvv9HGdGO6Lz2yxY+Uzh9wHJCtdbPurJKF+cyvyp0dWx
 8LPBTSlS3kPmizTROdqp7ITpIiijfFyHIkOF7Lr6bahiMBMTvmNsUBNQVYm+pYKMF
 S52ukRJ4DXcauZ6bqvExrSQLnRz8TnWQS350ouyxAPFKn8grVCorPYgoywEuadDG9
 46FP+PLyT+R+ONZDII5YoPdLUyXDFrQYgUSYvbWAgsgGMHSPyso9LtF+Dlc4hezVm
 qI0CvNofMODSi0Uq6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1x0y463Pcq-00kuVW; Thu, 04
 Jun 2026 23:44:42 +0200
Message-ID: <9454aa45-8e52-4fc5-9570-94d1ff66bf26@gmx.de>
Date: Thu, 4 Jun 2026 23:44:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] linux-user/alpha: add coredump support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Matt Turner <mattst88@gmail.com>
References: <20260526190535.10833-1-deller@kernel.org>
 <20260526190535.10833-4-deller@kernel.org>
 <27b8facc-9b5d-48c0-ab84-6a8cedaa1672@linaro.org>
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
In-Reply-To: <27b8facc-9b5d-48c0-ab84-6a8cedaa1672@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jtC1Oqta5XwojUC3sQ2ELRF/qt3yX0F/laMESymkys1Lyqf8jsT
 ggr02aHDEL627Fas6l6xcmydOsmU/DHhpWt3/LVOrI/yS3zt5zIvv67/02+ZECVPx2sa8ud
 QL9JlZYgZmQcKSysBJwkYW6g5onQYePw71SFNyFUTlcwwOuTcFg6hKmE+MP2hdhOGujfWng
 Iv4PHh2hwNLLolV48S8Sg==
UI-OutboundReport: notjunk:1;M01:P0:a8uJlZNmD+k=;78A2H2cgaphNOC1gseOkhx5lXqw
 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
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 5/27/26 17:53, Richard Henderson wrote:
> On 5/26/26 12:05, Helge Deller wrote:
>> +/*
>> + * Matches the kernel's elf_gregset_t (ELF_NGREG =3D 33):
>> + *=C2=A0=C2=A0 r0-r30 at indices 0-30, pc at 31, ps at 32.
>> + * r31 (hardwired zero) is not stored; pc occupies index 31.
>> + */
>> +typedef struct target_elf_gregset_t {
>> +=C2=A0=C2=A0=C2=A0 abi_ulong regs[31];=C2=A0 /* integer registers r0-r=
30=C2=A0 [0..30] */
>> +=C2=A0=C2=A0=C2=A0 abi_ulong pc;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* program counter=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 [31]=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 abi_ulong ps;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* processor status=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 [32]=C2=A0=C2=A0=C2=A0 */
>> +} target_elf_gregset_t;
>> +
>=20
> But see dump_elf_thread():
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Once upon a time this was=
 the PS value.=C2=A0 Which is stupid
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 since that=
 is always 8 for usermode.=C2=A0 Usurped for the more
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 useful val=
ue of the thread's UNIQUE field.=C2=A0 */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dest[32] =3D ti->pcb.unique;

Ok, what is your suggestion here?
Replace ps with unique? According to kernel this then should get the tls v=
alue.
What is this then in linux-user?

Helge


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADCFCD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR8aP-0003ng-MC; Sun, 24 May 2026 09:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wR8aN-0003n6-Hs; Sun, 24 May 2026 09:09:43 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wR8aL-0002OP-8T; Sun, 24 May 2026 09:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779628172; x=1780232972; i=deller@gmx.de;
 bh=QoTxRg55TofEuXvVzcP/PlwP+KPqydikQX/JHwVjpqo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=l3uQYEWhKt36gcuAx94hVWGpJLe8XMmckuQ0sJ1qzeSAuZfFrK/h1UzrwjOMD+8d
 G6VKz+RBviTeAK9iw1fCs08XjtKqZvrWA/84RYRWmIhOwBlEMAD2rPgRps0CCWdvY
 4OC2HGmCOG/B9d442rgKLrE1+RJfeMRX9zdP/FAxPeberbk1sYEPJiPrTy6Du5EJ3
 6o+FO0c9a88/hSYk3S0TzXNuM/MsHIP0mFth5DB5Y3F5/WoAlus4paWqrJny2GsjG
 /KUeN6H1TwN6/b8JKq5pFtDupE056G4pFqUWtJ0mMYAr1Gz2mU94tVpwjFj4AMQBK
 n096yt8/ll65Owe3vw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5eX-1wk32s3m6f-00PZIK; Sun, 24
 May 2026 15:09:31 +0200
Message-ID: <f193cb57-7e52-4fdc-9e91-6da50f13e39f@gmx.de>
Date: Sun, 24 May 2026 15:09:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] linux-user/mips64: fix elf_core_copy_regs register
 layout in core files
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-stable@nongnu.org
References: <20260521184119.1631958-1-mattst88@gmail.com>
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
In-Reply-To: <20260521184119.1631958-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GtyvIC3eltJakQL5NV0t376HpWbJnTuEYUsIWSoJBnq/LIevClw
 4a+iIvZMOXTr9kury6ohl48ibfzfBLolmCO3rHejucLW/7S3raHTnYvrX53r0hu3CTJKAUd
 Ixh6e0eLtqz0oovb0fzl7aJ70PKMvZ+6i6VwMGjphLCyvzlddB1rzBidsw9hHlA+is8rzpV
 Zy85mKjuGHLXPHVBDgdyg==
UI-OutboundReport: notjunk:1;M01:P0:1satLQWn+a0=;Q/ewlYyAGcC+bUQQFIEuQkWRevs
 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
 /yMklMHIGfPlw8601aGLH+5X4jOQtwP2SoLSpnA
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
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

On 5/21/26 20:41, Matt Turner wrote:
> mips64/elfload.c uses #include "../mips/elfload.c" to share code. When
> the compiler processes mips/elfload.c the quoted #include "target_elf.h"
> resolves relative to the including file's directory, so it picks up
> mips/target_elf.h instead of mips64/target_elf.h.  mips/target_elf.h
> pulls in mips/target_ptrace.h, whose target_pt_regs has a pad0[6] field
> before regs[].  As a result elf_core_copy_regs writes:
>=20
>    r->pt.regs[i]   -> reserved[6+i]   (shifted by 6 from the correct ind=
ex)
>    r->pt.cp0_epc   -> reserved[40]    (correct mips64 N64 index is 34)
>=20
> The Linux kernel and glibc both use the mips64 N64 layout (no pad0): EPC
> at reserved[34].  Debuggers and libunwind reading the core with N64
> constants therefore see a completely wrong register set =E2=80=94 EPC po=
ints to
> GP, RA holds the branch target instead of the link address, etc.
>=20
> Fix by:
>   - Guarding the mips32 elf_core_copy_regs in mips/elfload.c with #ifnde=
f
>     TARGET_MIPS64 so it is not compiled for mips64/mipsn32 targets.
>   - Providing a mips64-specific elf_core_copy_regs in mips64/elfload.c
>     that writes directly to r->reserved[i] with the correct N64 indices,
>     bypassing the struct field names that are tainted by the wrong heade=
r
>     include.
>=20
> The mipsn32 (TARGET_ABI_MIPSN32) and mips64el targets are covered by the
> same mips64/elfload.c and benefit from the same fix.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Cc: qemu-stable@nongnu.org
> ---
> v2: Use tswap32/tswap64 instead of tswapl


Series added to linux-user-next git tree.

Thanks!
Helge


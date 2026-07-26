Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17968C531CC
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 07:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wntDu-0002dO-IE; Sun, 26 Jul 2026 03:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wntDs-0002d6-IP
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 03:24:32 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wntDq-00025j-QM
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 03:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785050667; x=1785655467; i=deller@gmx.de;
 bh=E2vjShCTlcF9w6O6ChGKHQqnen5XLeayruZtmFJt+Qg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gQeZfzwIWZYTsTrpoWXeJHTGJqLOT7GHY6u5SpzwrKRAxu1z55zjKxhyGHHHsDJj
 e5CtScZpGHWGbyPzOAW5+OA8vmRNqBf0otx5NnsBCdahYLljHH7SeP0tMOZmXrkRM
 7ok2k86RtZXVEkm2DjRDVvcqH3lHwm1LjKVZ/YWQt80iYmAFSGacNmHHrBgIvYy4I
 C3kbxwONouayjOUCryxFZAr2HtcoBYTYWREcfbPVl2V22/4xf4Rrj2ImpJtsw06jT
 HYRLBnkASXHKYe+oGaWffZBBYzCvB1ziFAIvrA7rfR4/Nl87Y8cHaXGGwOZP5sEvE
 5oEKtYN2cjEH69RPmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JmN-1wncEs1I37-00FB6V; Sun, 26
 Jul 2026 09:24:27 +0200
Message-ID: <2ff8731b-bc09-4536-9bc1-4a44587d4eca@gmx.de>
Date: Sun, 26 Jul 2026 09:24:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix guards for the fsmount(2) syscall series
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260726005527.2513254-1-mattst88@gmail.com>
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
In-Reply-To: <20260726005527.2513254-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r/2u/BUwYYA+Aj1m4njlvQ6HlklXXLv2+C4P4xedLcYqVChhPHi
 9bW3dAFPkXUsjhcLUJjlE1Z6iTrw3m03Y3KLs+nZ/2O6KgSE9IX5yZVcMEbOu+ggb1SZlJm
 7zIkmovIv9Q7B/UdgNjdSDivv/lKZz0sO2bASCwpoRAn5js91vyJ9MdtZOPK3IPFASZpyz5
 wzUOEOCchGCGYUmgHKzOQ==
UI-OutboundReport: notjunk:1;M01:P0:4RM3nDgg2qM=;dUoAZs1PEWxCrXzQIzt/R+Jficm
 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
 MNddjXYjocU9AgOeg0iSI
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

On 7/26/26 02:55, Matt Turner wrote:
> The fsopen(), fsconfig(), fsmount() and fspick() implementations are
> guarded by defined(NR_fsopen) rather than defined(__NR_fsopen). No such
> macro exists, so the guard is never true and the entire series compiles
> out. Guests calling any of the four get -ENOSYS, which for example makes
> systemd's credential setup fail with EXIT_CREDENTIALS for most units.
>=20
> The strace bits for fsconfig() have the same typo.
>=20
> Fixes: 767c32fe6983 ("linux-user: implement fsmount(2) series of syscall=
s")
> Fixes: 6e0aa9f6c731 ("linux-user/strace: add fsmount series of syscalls"=
)
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   linux-user/strace.c    | 2 +-
>   linux-user/strace.list | 2 +-
>   linux-user/syscall.c   | 4 ++--
>   3 files changed, 4 insertions(+), 4 deletions(-)

Matt, thanks for noticing and fixing!

Reviewed-by: Helge Deller <deller@gmx.de>

I'll include it in the next linux-user pull request...

Helge


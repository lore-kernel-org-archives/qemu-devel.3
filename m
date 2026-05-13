Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D547CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNAIB-0007zl-Kk; Wed, 13 May 2026 10:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wNAI9-0007zZ-KX
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:10:29 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wNAI7-00067y-7f
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1778681420; x=1779286220; i=deller@gmx.de;
 bh=fKRjkGs42jF+ZvywTqHQbcquAquAw7AnEDv2amIcCkM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rDnn0wshqC4ucanr/SNkQO7wtfXEhESk7GjE0neRGkmMZM/fBcTlnU3LdGUdDFkD
 IzuAzfHxG+mL4EzmzIJ5R/PYqUQx3NbNjeK+rXCvR+2QGJNS8hE3tDQWIlhQewXFX
 bcI2VORJuS++KO8tbRQu01KaiCHgmPUzBnbPiNdF3zPU76jV5SK03KsAUnAuRI4UI
 XDgi05TWMwaQIN04F+BbFAaswogxjP4R7m8ODR+QuTqAau7yZB3IrAgr8TlEI9uyw
 rHW7Xkv8x3v2OftBSoyD++pEdrwYnH4JgLVHoV+EnoJX3PMRwY8v+5gDYpTmlXm+/
 LUSmWNCaDBCRk+cr3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpSl-1x37wr1oaX-00cxbk; Wed, 13
 May 2026 16:10:20 +0200
Message-ID: <b51c621f-534f-4eef-b72a-c2ad31dde41e@gmx.de>
Date: Wed, 13 May 2026 16:10:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/hppa: Use DisasContext::mo_align in system
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260513074323.10616-1-philmd@linaro.org>
 <20260513074323.10616-2-philmd@linaro.org>
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
In-Reply-To: <20260513074323.10616-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:17Uv67+b2Uo4LkctF3blGerNd0h6ob2QAxfw5SKLRB5z/lAy+Um
 VZc1jodQaSR3ih06xvJTDPtlytscCYtaVmElrQzN3xxyO5+me5CFlYnjRxYn1f1XIbGjcOl
 vaF8J4lad/5j7HbY5w2041yzeIQv5gMGwRzcQbNS97Za6cT9Lgrkclqf5fv+wzsfU+xvTX4
 JlhnGFOBjLbgGgDtqfEtg==
UI-OutboundReport: notjunk:1;M01:P0:a3Q1JoUwabc=;bG1PJKZEhpNjRwHJMCrq3l4mTRU
 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
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
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

On 5/13/26 09:43, Philippe Mathieu-Daud=C3=A9 wrote:
> Rename 'unalign' as 'mo_align' and use it in system emulation too.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>   target/hppa/translate.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>


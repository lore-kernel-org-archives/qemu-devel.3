Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4822CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 17:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waGHV-0003zf-TU; Thu, 18 Jun 2026 13:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1waGGw-0003uE-GW
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:11:33 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1waGGu-0002j8-W0
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781802677; x=1782407477; i=deller@gmx.de;
 bh=rHYM75VCPkiokkBMnY+3W7bElcJQrS85t1TRvyOMD8s=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Q85M6rTiZl3g1uAxRcUxpu+0BB3hcPRGZZ6mE4ao1tnwwCyuHvbdTnLXZ7R0J0Xo
 J5DRLW6nhhnNblij/orrNAC6zuxOXSc/kYeVmyFaV/xE/0Dtr3wJboW49dqsNuCTv
 xof4kpvVyvrXzGA8sYMiLs8mvy0AJhnfU3C2t+l5c7bN4dEs/Jhs7qUvG91y1Rl/o
 MwX8cmglkc96uY3wQen/2bCfhj/KIiZHTVRqObaTlhD+0z44s0AzgZSIuhTuaAbt0
 0Cb9fSv/rV7veTWTO3AepP2noM9yk2IiIxdN+w/XqAiGxdrwb1vxttz9WkbTQjVyo
 tkX9KAi5XjXwBEteKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VD8-1xGntf18n4-00xPEX; Thu, 18
 Jun 2026 19:11:17 +0200
Message-ID: <9d5bdf73-6e61-4aa6-abf5-b682db58a17d@gmx.de>
Date: Thu, 18 Jun 2026 19:11:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/xtensa: fix unlock of uninitialized frame
 pointer on sigreturn
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20260618133354.3369437-1-mattst88@gmail.com>
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
In-Reply-To: <20260618133354.3369437-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LpBDLM2dejZVHy0j3rQFvmkvCkgWBfly/UxfGaRqdCeoOPPRQWd
 CRwSJ0iQb4UCfY17v9+8TjKFtw6Goe2XtfNqXp+i9VCTn6GHQ3tfxl2iJhSGUcxI16j/5ZM
 cMr3dhi5MuURjQXvCCMQxmTh15zULnLq7vPkksE7l3rIaLVpgL/iljXoIxf1AwXiT7TtUns
 I/+wulFJY4XmOT5n2ZWkQ==
UI-OutboundReport: notjunk:1;M01:P0:z7+X97JfTTs=;ZD5I4bJcqrjtu1RFvCGYpmfNkB+
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/18/26 15:33, Matt Turner wrote:
> If lock_user_struct fails, frame is uninitialized but the badframe
> label unconditionally calls unlock_user_struct on it. Handle the
> lock failure inline so badframe is only reached with a valid lock.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Reviewed-by: Helge Deller <deller@gmx.de>

applied to linux-user-next git tree.

Thanks!
Helge


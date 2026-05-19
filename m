Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB7BCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 13:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPKom-0005dl-OD; Tue, 19 May 2026 09:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wPKol-0005dT-I4
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:49:07 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wPKoj-0003TY-Bu
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779198539; x=1779803339; i=deller@gmx.de;
 bh=ChTfGZgDGmib43MPAF9/Lql9OiIOTcggfPIP2ciGcKg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Ewn0+XBK95GbVtYKY6xSeV6eUA04b3JRuSTj7MEB3mHZ9u+LCPDzcx5vUnETHL3e
 gK7SMZJlyrnPoXWJpyjGq5Kx0Xl7G9yWtPXN0bAFJWx5qv7OlY0cVoEcQjeBOkr3T
 DKAfVUR8ZEnGJg7r4LYbjFmMeGxExEKLJwswldNOC2yQL8xBTIBT5b8LH5hRzxZaT
 wBoWnwqmu3/RVMzyS5jV0VUW8c9+IJLCQVnuyDrvMHf5OtsEWbGqAIm4rBux8gEjz
 JomKt7RY+Ms8NYMHY8sjIlJtK5g7yQZgNa3Mi15VyUqBN9V2dnN/yAx1aF9ZKNEkW
 XDqX1qMTPN2951w+nw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MORAU-1wiWd31UKM-00XL5m; Tue, 19
 May 2026 15:48:59 +0200
Message-ID: <6420f119-4e10-4511-bb79-fb3e8048e9ff@gmx.de>
Date: Tue, 19 May 2026 15:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Fix a memory leak when pthread_create fails
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260507-linux-user-bug-v2-1-26ec5da22f6c@bsdimp.com>
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
In-Reply-To: <20260507-linux-user-bug-v2-1-26ec5da22f6c@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4LaaPi4/S4Pls1NtzikXWuIeVNM1EPzci5cjaRvMQ0P6YKcyGW+
 QY5AZkcMTHdXzpTF5b7NQlKUK3tVsbBiRg7OOV2i9SXDm/KlRib2p0ZlUjN98teWEBE3PQh
 3q4CFinS8r0bNUPQWDZgA55bRjcPlWSaqGLTJCvSuQl9Tr2IIaKqYCXHxymcV/DynYtqd66
 JyKaOuG55zuwINx8Ph32w==
UI-OutboundReport: notjunk:1;M01:P0:OSb5Vn4IA80=;DuhRjPJ9NktUW8z+VtfSAvHUxhZ
 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
 iG6oqr2amUSybsFU25slthjubaU=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/7/26 21:24, Warner Losh wrote:
> Fix one of the TODO items when creating a new thread: release the copied
> cpu and free the task state.
>=20
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
> Free the new task state and drop references to copied cpu structure when
> pthread_create failes.
> ---
> Changes in v2:
> - Add ifdef for aarch64 so we don't leak stacks
> - set errno =3D ret to fix error propagation.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260507-linux-user-bug=
-v1-1-25831e9bc22e@bsdimp.com
> ---
>   linux-user/syscall.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Helge Deller <deller@gmx.de>

applied to linux-user-for-next git tree.

Thanks!
Helge


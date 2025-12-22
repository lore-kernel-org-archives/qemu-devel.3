Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C917E69160
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 19:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXlwj-0002dD-2E; Mon, 22 Dec 2025 14:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXlwe-0002ck-U0
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 14:51:54 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXlwc-0005K4-49
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 14:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766433108; x=1767037908; i=deller@gmx.de;
 bh=xO/+XfGwmPEnQy7murmLnkCZxsWgU7tzHiaDUKhTMgI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RONzOvBz+LZa80WE4qP9eKJ/QSl5MvUVO2UDN3G4i/GmOlvyiLVqinWX2T92HkCm
 hYtD6geM2hiY5saI/QqXVYHbJpvwj9url2jjnd7U36Lep0PdBMqTaYlARNInuJ6uq
 oY4r9kbj8RI12C2KwZnnikfWK22532hcKKzsl40f8Tx2Mif2KWfv45RCq3TP8X+X7
 hsdt1EH3r+FXMM5MJd4v1cyuVaNcYFIROmBxssIS6MWGTtU3l9TKZOsDZhpnJNjg8
 G6hgyV9n+1GGL+dEQ0DYBqhpGVQcrLL/7Mx05EA9k8bi84YPYBPR0g1ZxwGtM615Q
 QNYKk/cngwCrPRipzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.229]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK4f-1vp1iE3wSf-00v3kM; Mon, 22
 Dec 2025 20:51:48 +0100
Message-ID: <e389ac30-c4af-4c1e-a23b-679192ef49ef@gmx.de>
Date: Mon, 22 Dec 2025 20:51:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] scsi:ncr710: Fix use after free in command_complete
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 qemu-devel@nongnu.org, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
 <20251221142317.266293-3-soumyajyotisarkar23@gmail.com>
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
In-Reply-To: <20251221142317.266293-3-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DJjHdbkUisJBwINJecrXbjKcnw7jB+tptT3ercn6zwy01Lv/0qk
 MrcjqG47f/DVQGlxv/T/pkVAp5yMZ2TmvGHus2i3neoz6j681Rhz1MXJBBiZs833A28OCvL
 5v3uXmeKSWvxyR7UZmsfZUeSZPD4IoFYvGigagl3s9wVG3cs61W4FoivsXIL63tRmtnYrAc
 cf6Er7lFz+v0/KxBCEOWA==
UI-OutboundReport: notjunk:1;M01:P0:1aauYp6UnG0=;vYwR2XbVcIaYJxx7ywM7t2s/l1V
 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
 ehltf3rQ=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/21/25 15:23, Soumyajyotii Ssarkar wrote:
> Add proper hba_private pointer cleanup in ncr710_command_complete.
> This prevents use after free errors from occuring.
>=20
> This was causing memory corruption in NetBSD device initialization
> when commands complete and the request structures were freed while
> still being referenced.
>=20
> Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>
> ---
>   hw/scsi/ncr53c710.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Helge Deller <deller@gmx.de>


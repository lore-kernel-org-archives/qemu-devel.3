Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD8CC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4PgA-0005Kg-CZ; Wed, 09 Sep 2026 17:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4Pg8-0005KY-CH
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:18:00 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4Pg6-0001oZ-Ar
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1788988676; x=1789593476; i=deller@gmx.de;
 bh=ErLy10yaR/GXEq9mcfkO+qIuGl8Y0BwQDWOyv0XWnzM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LEjYl39mdXg9vX8OMaSLjFLKAmMIbfJKmsNtsReQRrgYwn3c0T2q9PxKVSTnQkyb
 RfI/YoCeV4Opp6ZWwUtnBwatXMdCMO+ljB5AzECmDHY1Du73TGzrhlylTSaTMEbyj
 /eYU5AOQzXgpH0wdh+CVa7R1dDg7CnVxxpso5fxp5UG60szZ5hXMAK3BcgSZswbEa
 jRJ2CnrDiSVlXuN5jIGByJa5mCR9FhH6C9AX8jAn6nmFnrR6BVtkS+p1HJSwOjBHV
 Slis0QC6KxfMTZwTAYMGuZN++9eEFI8IDedWl5qKzMeHVjk973slWlDdrPuY2h1Wz
 hWpC/S5e3inndywBcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1xUCR00U7q-00Nf7z; Wed, 09
 Sep 2026 23:17:56 +0200
Message-ID: <4238afee-7706-47de-9cd0-effe503a9f5d@gmx.de>
Date: Wed, 9 Sep 2026 23:17:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] linux-user: madvise() on unmapped ranges should
 return ENOMEM
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260903142720.1467316-1-alex.bennee@linaro.org>
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
In-Reply-To: <20260903142720.1467316-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AKXEYuHvklNHqq8gojGhAFNkPLN/Ci9tUfd9DyzAVTpHRPIFYYT
 qcaFli5NuYNjdipkrjRfcy3/PohSJsQXgpApaGN3P2AHBW3T62/PuJ0oMDIV3yVtbZkRNuV
 y3NMhlJaKf9Wgymc6kL6js7d8eW5ba1J44KCNZCgfNXCNaJJp1f9rdTIGAt4AzMfym5fv2L
 z9wvttfYqIAOtgFHRrMnA==
UI-OutboundReport: notjunk:1;M01:P0:0r1sUXg2pc0=;4WmJ4pIIJvKkikq10q6F8h600ER
 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
 hIoQ
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
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

Hi Alex,

On 9/3/26 16:27, Alex Benn=C3=A9e wrote:
> Per madvise(2) and the Linux kernel implementation (madvise_walk_vmas),
> madvise() must validate that the requested range is currently mapped
> and return -ENOMEM if any page in the range is unmapped.
>=20
> Add a page_check_range(start, len, PAGE_VALID) check for valid advice
> values before proceeding with the advice actions. In addition, extend th=
e
> tcg multiarch test linux-madvise.c to test this behaviour.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4382
> AI-used-for: importing and validating test case
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> ---
> NOTE
>    - again testing the minimal agents which did stop and say:
>=20
> *(Note: Per user policy, git commits are never executed automatically by=
 the agent. Please review the diff with `git diff` and commit the changes =
if you are satisfied.)*
>=20
>    but non-the-less imported the test and wrote a crap patch which I
>    have re-done dropping a load of unneeded verbosity.


Did you test this patch?
If yes, did it work for you?
I'm asking, because I tried the testcase from the bug report, and
in qemu I still get 0 (success).

Helge

> ---
>   linux-user/mmap.c                         | 12 ++++++++++++
>   tests/tcg/multiarch/linux/linux-madvise.c | 20 ++++++++++++++++++++
>   2 files changed, 32 insertions(+)
>=20
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index cc0c2ee6c27..4066072ff45 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -1307,6 +1307,16 @@ abi_long target_madvise(abi_ulong start, abi_ulon=
g len_in, int advice)
>        * though.
>        */
>       mmap_lock();
> +
> +    /*
> +     * Whatever advice if the pages are not currently mapped, or are
> +     * outside the address space of the process.
> +     */
> +    if (!page_check_range(start, len, PAGE_VALID)) {
> +        ret =3D -TARGET_ENOMEM;
> +        goto unlock;
> +    }
> +
>       switch (advice) {
>       case MADV_NORMAL:
>       case MADV_RANDOM:
> @@ -1358,6 +1368,8 @@ abi_long target_madvise(abi_ulong start, abi_ulong=
 len_in, int advice)
>           ret =3D -EINVAL; /* not yet known advise */
>           break;
>       }
> +
> + unlock:
>       mmap_unlock();
>  =20
>       return ret;
> diff --git a/tests/tcg/multiarch/linux/linux-madvise.c b/tests/tcg/multi=
arch/linux/linux-madvise.c
> index 539fb3b7726..ebb9666c919 100644
> --- a/tests/tcg/multiarch/linux/linux-madvise.c
> +++ b/tests/tcg/multiarch/linux/linux-madvise.c
> @@ -1,4 +1,5 @@
>   #include <assert.h>
> +#include <errno.h>
>   #include <stdlib.h>
>   #include <sys/mman.h>
>   #include <unistd.h>
> @@ -63,10 +64,29 @@ static void test_file(void)
>       assert(ret =3D=3D 0);
>   }
>  =20
> +static void test_unmapped(void)
> +{
> +    int pagesize =3D getpagesize();
> +    void *page;
> +    int ret;
> +
> +    page =3D mmap(NULL, pagesize, PROT_READ, MAP_ANONYMOUS | MAP_PRIVAT=
E, -1, 0);
> +    assert(page !=3D MAP_FAILED);
> +
> +    ret =3D munmap(page, pagesize);
> +    assert(ret =3D=3D 0);
> +
> +    errno =3D 0;
> +    ret =3D madvise(page, pagesize, MADV_NORMAL);
> +    assert(ret =3D=3D -1);
> +    assert(errno =3D=3D ENOMEM);
> +}
> +
>   int main(void)
>   {
>       test_anonymous();
>       test_file();
> +    test_unmapped();
>  =20
>       return EXIT_SUCCESS;
>   }



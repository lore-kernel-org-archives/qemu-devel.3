Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB1CFCC062
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 20:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybdJ-0001QI-33; Fri, 06 Mar 2026 15:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vybdH-0001Q7-Qf
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 15:18:47 -0500
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vybdG-0003W9-0m
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 15:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1772828308; x=1773433108; i=deller@gmx.de;
 bh=3uZNuRNTdLi0jLAv3h3afE5Lj2oSr/uZlMcg5TlrGc8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nGZS8Grq4yH7K0FABbXSgtVYst+Q4dtBmEBjXvLS00T+t3DRxewZjz6TefKvnXiL
 oHgCbcyxs+mRVs04ZxN0UWHsvp93PpSBVpQbnEJ2QsdOKVBI/qNUsvL2z6lf/U934
 nJ5u165w/xaCo56Hux+tQis62tl65xOCvNdXIKWjtndOw/SF86mHOmz+mhojP/7us
 H0nodb6tY6BjiENcPuP1A79b+v6TmuQUcutNDiCWXuXd0dhKh9XoWHWl4qyZdhM1K
 NQ9BVF+e1KCaTq3owci0LUcAT+BC2EpGQxusrCesxf2U+wTswW53guC4WsGqMFFpi
 fYKBq0OmQ3foy/oNdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1Obh-1vVMVj237z-00sTx4; Fri, 06
 Mar 2026 21:18:28 +0100
Message-ID: <40ce5a8d-fb2b-4337-9e39-cf03fa8a4a28@gmx.de>
Date: Fri, 6 Mar 2026 21:18:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] linux-user: Deal with mmap where start > reserved_va
To: Bingwu Zhang <xtex@envs.net>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Alex_R=C3=B8nne_Petersen?= <alex@alexrp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Bingwu Zhang <xtex@astrafall.org>
References: <20260228-abyss-mmap-relocation-v1-0-c8ec0476894b@astrafall.org>
 <20260228-abyss-mmap-relocation-v1-1-c8ec0476894b@astrafall.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260228-abyss-mmap-relocation-v1-1-c8ec0476894b@astrafall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e1Z8t3YXgSaf1DmkjgPJK1/+Iw+bXAJ8bUmmmQ1HusHnqCIsWCw
 RMz14QL+HnX5FOYO73vLpuJp8k1y5I2nVJ30Ljz4vy/EBkwfvjA3dKrKFjphE7frgCpGEbn
 vuJ45Fb9iJhYO5F9d3/OVZLWbqxjlZSIGMX0W4ZORk/rJ36jGzoRQ6+7JpJi8uXzBlBfptT
 QKgs9+lEsm0egQAP8mm2Q==
UI-OutboundReport: notjunk:1;M01:P0:TLly8VP3X64=;K4L/+1ykUCSLUf4/G3Ridz1F9ig
 OVxUs5uaw/y9/nWkxv5AG2RIZOpG5iJ7W4Pe29R9LmQshwVwo/TM/bF6mBvhutkNsnykyWhfp
 t80hZ0zWJozc6dL2ftUsleRkt2usIN0E5Fh+0JOYZqc8X0tbJkNKbXsH1ao4wRvHqNOF/A39j
 0H+wFY3KsEqFlaMDqg72JsSqZh5izA69TDuVK2FQ4PRwK3C/q/A7np1AngQs1snf+vTS9wQKg
 4SWhD38Q69XhTlbGAW4saX3bayhM1grqMQTwuhEcKyTPSs/srwGJsUFGeAHg7Nr1Bd7hHvIbA
 u5LdmWu9FoyDAlYIWlEvDyY5U7KvOORVLZXlX5JLtaqspN37F+slmbgNFi6YnZUK0eP+Z+2fO
 QBMfNdkvdLdDn19MWSZpYReBMrbdqvntLNn7H1NDrn5TOPu7Zwd0SLYRtUWREBaE3EKcJ9O72
 Kd2Ogp299HpqX5gu2m05FAUwChJ0cXLNY96aDcTfG2sfW7HvTqzPUfurYEuUW0CqF++kUhUvy
 GOY0br1m0nD7UP/krC7bSFxWFGmeXCSLdAGTRshxfrcSXxb7TP8CbQ4ZYvy66Li2wAVTGarz+
 XvbVQu/CytjNXP6ozTJgylRMYEf6k6ZSfL6zYRARQ++D7RwpTI1VtdAbrp3jlTh5tUjhGyynR
 xJ21TuXD2Lp2we1/SpTeGoyfRts6PaOItTM2Clz6FrbmfrntUTaUsBc0PP/lOQlS5lsAEWaB2
 ohcuz036E80kwCpWPcFy9jx6tr+GVV4kYmK06E8HHAUVXXoYRuWo88U/aSrg87TleikZAV7B6
 ZOAJmT/KciJf8wIatm98dWQcOIzi0ZnRvgAAIhKnEAtvDb4UU7bzt+P8BtmxXFPjr9EVysY4F
 z821NrY2TDWbYNjwoB/gqSZ3r3JZGqvs0aGWSgVYzJFjyNfUov2lUGEFKHkBNaJQH4wTuWhkv
 g9bdIwAc2KISh2QFLNmYN8mDhQdrPVGmfJbpHNHdUFsyYEe2gs5C0tBLaKPQI0dZQ1IPs0DDV
 ni20/Ce7r/Izaz352JxUIumg53q2l8Ifam5cZgpBN4beecTxrhHo/MYTBUEif0yU7COvTZ0zb
 p+elFpUn616+82J+igXdeJ/VU0s720UhkZCptEevYnvbsRlQiOpzVDn6ehVe179qdDnM90lCx
 TrVjmbzCfjlXIaWwfakTh+3AJED0Jp29We40kNYc4ZAbV9HgzWJbxfbzyWeWofCQjcIioIas6
 oKbtaim3A47acq7Yq4SHo/k6TgtvWYWfd4ctmjOc/UG55MePHs/s37MxeI2Pa8LuarhQXDfap
 HJAR3ajKyF1Xiu1QJae8k/QjjoUyZtAT3a6al04vKBgMgBckAYkDbjoF8C69WW8+aCswb+tO5
 rakzb2xc2YxPudk75tOppAhd9kIALLyfWjVGeVXgXxToIvBjE4iCvB39ZktfLu+LxrZu//zgk
 wKslgNQ2jGQmw5xi4cZS05ldBClJ2BjuFiD9cjR9Smaye6O5scCD873i5ScTFJkS98o+YMcw9
 4Wb4phFsuqfgmURJIdUGKYl8qXyKrHGSHZfOX6YYsSuJe/XLQ9Hox3ct0EzS3XtaS3W5Iw3mk
 6zKLpKKFB9kCBJPMmIXyi3Ur8+aEm6lvLhL+pJC84GLbdqgiKl6QtOqVKtisURL9ZzQaw7piu
 e0Dgjf15/b5pNNkjMh/NDXH9/B1iqnAutXPObJ7MahDA8b9Q4CEScuMtLwgEI9EYiDuOaEf7g
 uFlsEQVcSPMictmk/TSOVbNvg9J/sb+kVzftIFUsPe4I7zJs+p4wSwvi8ual0tcRIbIQZC1re
 B0xvKszkGcgFFtb1PcxBU5A2XeBWO/usaBbLPAoqzxmQNt/v9hxaAmRIUvdYgeZdy5rI4yYWR
 yQn+7UrfQ8W0HCODX28epkMBXQLm0qfMBEXlU6tK6aZnA2e1W5rdbcUOTkLbmEG2MLw6rAFO8
 CbUdFQ970WX6EOY5v+eLciSEYwSo+oAm0D026BYQVS6NNQE5GVznNRaWwzcigBUEjaox0Ff2R
 p8yC/1d2YUFdeJ3WvREU2JFkz7ySOMSyPB6WGW58B1Afm6siKoXWv3yyf6nAtig9+mpzbL6V/
 DALgRvv3RIg3HUYp4WsbtAwkAXIIcMxUpHsamw0AJBxtm9GmO+u/SMK1NWsfda55BFl5riLY3
 cVibEAgZSVl5d7tcwmM/UlouSBZfLsrOR7GRbI4Jite6aokicdpbHsWU2XfhJGg6PcQ2cFRLP
 lrmJm9OUlQgkm3QwyNEgtj2ijEfFKyRr9l/X9dLG7Z/kEDcbvVzHO/U2TwTR+/Skpuk3dOsKc
 Ojbgr/UUOKrUb4eX4nMI6Lk8Po2bszr4s7Lf7d9tRG6G9ktnkFCBZAjDih8xRQSvdya6Kgd6N
 QcGvufoeYWJnOcPSY5R/EGaqC0hCldM76LZdxXTo3NQQoTKzt8qKX9blcqDi9Hkyj4FOCXwSc
 ziRQ3hOTsa69lPZBsmVMKBCh9ir1xrDazWUA27sqDmN+P/3Lhd5jCRZtJ6ij2xZsuwtG7WNT9
 d/jF8RuymN6SZZ92DlqQ7R/IuSktPf/kZSYtCQXe7tllnco6NGrg4mQEg8cTFFMtnb4XS4gMx
 vS6lWGZ7+PqksbxsIfkPVjgeHGkcOhxLscNfyp7OEQCv0LAPe63LNJyZGL5TYsquRSC/1RQPC
 HW0NtzWCSrQSaJeWjYZ/XqxaJ4GLbC3SmLPJnqlN1Mrbp/sC66PKNevmLmjMF7WEIUMsuTtVO
 OVKa0NPWZ2sSN0loLvaPJumgOQ5u207q8gnwUIRJdlSM05tN//jylIJXFI3wXWYO+qHtbsrsL
 iUQjbZ76UIpOo/GZ5s3G7OgECdNiB72h8oOmqnfGLvvGa4QXfm45t3vJxXKidqFPEDB4DvPrE
 PmP9L4BXfD+p3+ba+INps+Z8iaLhogKAKZnSZb6MgRkVsU0gw3d1yZdYzN9HiQJHrEizcDJDy
 1FtzZkxll8fcLNtlQ9AyOUj6NsGJKRcofBll/2YYeNp3WMemiA2UkE0kdIHWkontp4gnBWI3B
 MfwHL4LfVQbDn0tOkjxjgMXgWWWvBvEvSlG35nnpardZ3jmb5XfGDNmftDSGVFrV2v3ldqxMc
 Yfcwo7Kl7Na2Zcox5B3b0EF6VteBCOY/YpQtiSQixHGU4SX+PrBeOqPS7g+XFs9T0lGQaHHzI
 2YA+Y73POYN4FWOVLECvopbVBMtwzmeCXZhEpEoNWpMHrlyCIvvG8g8qXJf9ZsQs00WXcQMMn
 qD4gadCI1bhxnTM2Roj9pXurbI+lCFOl7h2oW1YhcdXjS+eDGZUOtEnhO/CWNUeV41FdINkTs
 Vl9rnl76EMMC4UWuBUtb6LkiQDgfzEH1NFdLj5tdyPf6ekbXGn7eqSClh7ejBy4AjkbLMX/1V
 c7g/AOnVJk2zWtUr2Ovp+oSuGSmskJmgRr5gLLwalU1G2bdG+Z1GfcioI4b9UNCZeqhCEHJuu
 o+BPnEjxSmBxUclo5uzIHrM9vDwUc5ezest2uug4N2ruJGKrnZ+4ieT8gzL8zaifiku2VSwnB
 fG3jSqcY7AEluQt0SasPE5Opht1z3cgfSMX3uLPRFh56RWPbFotRQm1BgX0mcEvMVi+g5m4rS
 bTMqNLovgVEUeKQUEHmMyVSEgE1cvJ8FdDeZ2QPcmbq2u07oKx9fpncvAayAtIGdaA6JFmTeF
 EfQHrc9AA6+lFcdqpx3L4KiFc2opukcA8uC3S127Tu4cWcCb2ENBcr6th4qVTFO1IQBTy3DFa
 cRQ1GX3FuHlyIPlswsLVrSOJqzWPrjSoz7953HLlEHbUvNlvbRAqiXh/wKS4a4q3fnOTcHQHU
 0WL7xCQaWWpZR7Ang+80LTnv7W/OGFF+T+ioQLMsnWSyNlIWkBsDyVLPojmO7T6I1HnfpRzJS
 nW4OdZS4acDbhPO9D1h3rdQ512osHd7HUe2992C8gHCRmxs+zC7YUFCsZvKSaHHAES8uVT/TH
 ikJrVd9CzWobch2w/4MgJ1IFmPFMNafiQRss/njdMymuYXKwLD65XmCI8NYkb5v/MjPyadCdt
 MXoVYkJmv9YvAAPQTZeeXOpoEniSSQvS0MnnRsFkrIY9cXjwa8ZXjJtdgI4aQUGaDiZuT5nVM
 Idji1gl6R52R7WkQNGnAjiVMHYg/PtOAkZyX9XVs81igJGDaH/VJXunoZmB0x9hAFXJM7hL1O
 er+X/IESidKuMHfEo55o1jUPYs+IzI4qmorm+HViRHROPPYGxx/kxdSEPP8lA5VS8RYtQkTnU
 Q75xtLwVqP8LkT6rJ0jC1TdQtnwknkDFLm7J4RZdeO7gGwu8fCMVsZ6nJKowhL+/xlF0HbHs3
 RbB/Jm0N6Lx6h+fuFGn55Uo7zPViHmtB1RtPEOHxTgIrkMxRVgh5LbBYxu617aaq5rtVNSyO1
 68jDSRSsmKGpzp4gdvVHgYv0AH2P3jXnQ+gaNoLrzbl/0tzJjtROEqIlPCiZXeHuG1RKO5iH0
 sKcg3SuX/zb0JGA7Xxy99ZpQyYAJ86VaFfhT64vAzXNS4gKFUG0oFYii5MUSO1WqIblxGbRC4
 QFyLX6rNk+3GX22kUy4NxZWiEyakH09EFIwkqAZEl0LfdvkrB1NrUdvU/99FXGU52Zf5Xt/AS
 ZW+80770rdePAbvBQ3AshvZpSxYeFFf7V89HCKIUOqHV9F2OFpdNmF13NxwTLdCeo3MHesJO4
 wF+aEuSmNfD7fBzL/zshxABu/BNvP61Skh+WgbHF+vTbtxkWCMXS6OoKd3c2myCeP1vLw2yhd
 llPb94qQoFDWiJ7xUhz+vJSWBzAGv/rMxi0F1eWJwqWMg9c8w2bpIUiilQzSf5YBtJ+lcg3Ib
 TjnuRheEzk2fXeLkdeAXVM5v1DOtabO/eTFHmRnNRBd2xWJIUbmESg3RBz2H/6dz739EeZMll
 WKxIXOngAqhkPPYoe/sNwso0wKIXg6z/iCztaQbvU4rEsMH+9wOdI5fxP3JtMqg2BM1B47SBR
 RrKV1TFi5rV2s0mPpN5lMAx5oTO1v5Yv3HSPoHgqWpgfnazxa+ZTHmqXf3sMoQgGykJFjpEf0
 otvnBHk9p1662JeO1YyawTnewJKesER9Frhwu/fEbYDPQFR68Ybed5Q7SXfrV8cqKLlo2Wbr3
 lqTu831sGLDEpWdTsqoPTh6opz8Ap32P9HikbgSyDsjRbD/iY+/90ADx9m3Z4WPe1ecmJZ545
 aUl24t7VFu8s6wfYgu6Nhk89CeFSk
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/27/26 17:46, Bingwu Zhang wrote:
> From: Bingwu Zhang <xtex@astrafall.org>
>=20
> Fixes: 4c13048e02d9 ("linux-user: Use page_find_range_empty for mmap_fin=
d_vma_reserved")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3310
> Signed-off-by: Bingwu Zhang <xtex@astrafall.org>

After staring some time at this code, I believe this is correct, so:

Reviewed-by: Helge Deller <deller@gmx.de>

Helge

> ---
>   linux-user/mmap.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 07175e11d576..76978a56a859 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -423,12 +423,15 @@ abi_ulong mmap_next_start;
>   static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong siz=
e,
>                                           abi_ulong align)
>   {
> -    target_ulong ret;
> +    target_ulong ret =3D -1;
>  =20
> -    ret =3D page_find_range_empty(start, reserved_va, size, align);
> +    if (start <=3D reserved_va) {
> +        ret =3D page_find_range_empty(start, reserved_va, size, align);
> +    }
>       if (ret =3D=3D -1 && start > mmap_min_addr) {
>           /* Restart at the beginning of the address space. */
> -        ret =3D page_find_range_empty(mmap_min_addr, start - 1, size, a=
lign);
> +        ret =3D page_find_range_empty(mmap_min_addr, MIN(start - 1, res=
erved_va),
> +                                    size, align);
>       }
>  =20
>       return ret;
>=20



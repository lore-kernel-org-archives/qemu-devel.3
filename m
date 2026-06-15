Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6423CCD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 16:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ9pI-0008N0-RY; Mon, 15 Jun 2026 12:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZ9pF-0008MB-RE
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 12:06:13 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZ9pD-0002Oi-Ck
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 12:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781539564; x=1782144364; i=deller@gmx.de;
 bh=F2ZenJKocQ0EXWYjHcQVvLA/3v7djlnMU1QrPQqHBks=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=W+IDGEHrivtDzjmrnxz/rNqkmRm7n5LgIYP+ry4nXlyTzUXOK5zyM9GPA7C+jiRt
 9p9abIYJsUHVbCl2tlLDRChC+ZC8VUlVWUjpJMakjn4uEiyqlWWZbWq2qYDR93FBl
 mWN5tf2eqL2szFu3OVWnW+G1cgS57BRkc480rlOu6RAeJhfa3bRFHWTVFA4oyygUO
 ARxfbrroUFFyAzMwb9JWYiRkZ6gciJG9KIXYLP4oakbmWSG1ZqPBkXHLZftJMjSza
 as80nzclOf8hO2nrunUJJBdHP50Ig1W6WKXyrO9B7Cz2cMAzifQmQG0w/KFsKVA/j
 Bf/+N8Nfyl+qpwgKVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXGrE-1whT893OHO-00VZ02; Mon, 15
 Jun 2026 18:06:03 +0200
Message-ID: <7d65e071-ca12-4d48-88df-9ff08c70fa75@gmx.de>
Date: Mon, 15 Jun 2026 18:06:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix AT_PHDR when program headers are
 relocated into their own segment
To: valium007 <valium7171@gmail.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, pierrick.bouvier@oss.qualcomm.com
References: <20260613152156.41147-1-valium7171@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260613152156.41147-1-valium7171@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GgX119WQxenJuO+k0DOPzmbyg0bzD5hyzbvwk3kfB40q+k4thDl
 UzI8Qf+Qw2SoNoPVkS9SNxTJ5H56L3v66Pn0AHpmSoXbhuy+Uv2Z2m7A5LkOJtXQXLKpq5w
 k+NastfkXBW/w/WV0+/bspoaQqsibZKnpE8a6pMsxKZtuyL5XSdS+oIOyyREMjDIAWqtK2l
 1NSeuWOxqeKzBPvbUGOSw==
UI-OutboundReport: notjunk:1;M01:P0:OuNP2eM6Qtc=;FUWNZzBTPsXWEj9a6UxnXy0p+Nn
 UoCJWeClyVdu0UC27ZVk0FhR62CAdT05BsHgZZ6qSY2tiHMaS7F/1lHsgShGIHA6aIKnJSq9s
 vd4x0TWmUquUGDCdy0OxhuuVGpuZs+Dg+TRCtkRh5YoX3UNEtvd9DNIiQJCK2g1dZH01uacYT
 FHe8oeeAiHRzAU1U4Xy6cG0ZMZ+dO7v6TVudej5qYQef1WWaRw4KiuOtrEfvSzA/iNWbfWQTL
 fSe/ke5ijv1kWxXI/aMVA8Bk12UMPn/X5BXzDVIvS+oNz5vd2M7hWORaxr9xZnB0P5k/HR7L6
 juN5ndNPaQ4Y7o3mx4i5CSLYUK6meiuvHFHxMu8Sd+QY16JHPMf+ocr6RbLYFcsn+ysH6MFud
 Bnd7ptwdDW/2oLPpwSr1S6zTndryS7mXY/uP/7yWDTsVxuk0mMwCNNPicoh2hkrDlrUkD5Z9R
 sI6A0TWB0U0yK4+V0id75CUy80WdUOoC70peVf++hObTmB1IS6deOfZhCu+GJeMXwwZ5Jrtvs
 SNUUiPao884+6PtxEImON7zncxMDAIPeLHtqyE/zABaDeflZFkwTuCyjxOj+sk8Un7zNFlWIM
 E0odc5fhfbJkYsOtlS/HbOHAlcCt3P3M7YjC2QqfZVpVQg5sxgN/vMbbsAQSxZwX2oXAOsWNu
 660ZZMkbUXfjrrT97eqQTcJYsd3JCOYi1nKDZ3vz4R/CZHMQTZyvwBgwJgHRGjCBiId0P9oju
 /WZK2/lTdxtDZeb7mYWI/SnOMVnkDrfk4OxRDsee46IyUs8MEV02hqgIxbZeLJuAJYY2fTeZe
 SP+iOlrluBdglAlyfwllabWP7Ea0VnquOju6G59N5n/5mjtK6fXBJkSnbVwRkrOr+eKpogkYx
 Rphy092j67cGUp38E/EVAz1JfEfRUzBBIZXbKcjZlN8xe8up5XCmcQKhQKehu/XRrOFORyRmY
 9pkXqXDq/NGIEPZNA6zLa/C4A0/j8TE5ajovxJl+xnmhnmb2FvS0wOfLsDN4wboBWgwuxPOlB
 G7Y2/zH/JywvoSobq/3IcimzFtql9LDg/nTVfoNsvdVxn2TTinfijrEsWsPfzUxTEttaF+RQt
 DvWFEFiPMfKluUo5OGHiqVVZbR42fW4DWLqP0PGZqtaS7fOw6yvV/TTtFdXhd03QsUF0dONdp
 hDrIM3mJ2BsoXxjHJXfARPlWtVJPfeWL0zFtm8La2yc0xXTuvg1Oj2ccn2KYObknCLEq5veXv
 8/3VF6FDBf+4eQmHU/zdY7Tztx1bvP1yFiFLUVg9LwgX0vYtIG43cAtHhHw4OOBXrYhVO0PNv
 BJawmWOV0x1eiyObsl9wxkYak/vlta/AKZV1MYHD1jpOOb91pgEUJ0KKCpaqgjmVJZvdzseYB
 NxusQiTjQQRj7ZZM4l9a7lWLKOqYTe3MWE07t2Rd3lx5qFZmo6FSLEQBrECz9YP3+55qs7Hiy
 WePvFsiXnjUl6pwunyG31AxJpyc96Uz8CPH4+3Fee7hgfOoBeaOH2DvdXNF9BJSPgWYLIUWJw
 830fBfnSh92zwPazqgile1Uk6OFn2TU0bTzCzRBTSeWY+Ofa3lup52Gjt8VdSRP8YtnKZ5rOW
 XcilBWAQcw8XyjUI0bgqJk1F8PFy7PVlGuZxsZ36HuF0t8TAeBknoajC4I/OaW8HlI3iYvSz0
 I47U5Pykfrruk9g4bgwMEJ+oLUq6/VBL9fzrnzQJYCpsEzDfaxlEXB/pjV4OoxfxoD0RT2E/y
 YjvyNQo0HYUzquuSJu/4DS76yZVLvR6FDyeSoEb9GQ4h7xz/Uv/7ZJtaQ7qa4w1z9cuia23dl
 WVgL77xOcc2e3th0N3dIE/juKETnG9Fxeb8QuX2GCPaxXLlfjbWr14qubr1Bff1sISRKnlCkU
 qeqUii+quWWkBHqd9xumm6wmPVf+dIRqjsiN4x1H23XkZlYk/IZ/1DiS9+P/uHgnlTVFOe+EL
 Ndb1nhwbu9aJXlTpCkpZbjFdiriwPXNPCMqD/eGRJvz1ynn3+3Lf8SQEaM3f3C3cmRf/gIpI5
 AwjpRjk61waqXDJVL5S866tX6ui1KeNSE20y7Ht0DRYndj6v8JUGFxHgBUK0XPn1j+qID5gUn
 SM9JY7IbWK1NQ5eSukqME1yrYRDPuc+XW+LM6+OiEwvnEBdY1Rf5pj8D9oSIbxIpO63qKNs6+
 98vAiiu8TTDN9kyOQvGmrRy/ypGyo3cLcXSwPaeE57XP627wFHVR07+6SBG+LPckbXwX4gBmZ
 hVzKbl2y0alMzau+D40AS2dsy0XfCbrarUx/iXdS1Yzb8RDi+juL/A+G54O9LYhrUQXL0NKYA
 SDwZQf4CLQBByCrKly1MDil2IdUANq9aRJ6FIaBuLBriYFpqdcDjSCwuJHpIkbMkvKoHG9G7S
 Kqz/p9i0j3f8t6QsUgt9WiZujmIYHojINUeosCOs0Z7GDUbeDwh4a3XSaV3afmb69MyFma4gu
 gP4vDMP9MrQlPFNDNYJyLyAQX886mO20NU3sKHz8krKD6PJ/tt8+t9fGmbIOC4A4K6F71UTDt
 JIrmMM+c/+7VMlON0C1WjyWSR7GIlYIApsNetbzEm1+JhIAQ3ceYljMKjBBiKo0AlXBWJXOQ6
 XpFuCJu4NQhaPAnDiEozBmUULyaYzO5ipJMbAAAGmY8tiQK7TEYIjhjWWhA2vFQ1VROg8t2iK
 dmSOtsu4X5HiPEm1PQKRTuRclALhMqarLRmGYobujwfcSPXYJGknollkgfAUEle3OLfI9xXIN
 nNnWdA/FxGqwSdj7jO9k9NoyAlRvFgfQCR65aim+MM//P22AURBgt35DVtB6dezx503I5g91Y
 DFuw9xEpivOySjPPkglyEdNm0pFJTB6/gfUricaAbsgHdewKS2iDDZSL9L+rbW9zrYtD9ezDm
 1qPZs4JCwCEX+0kVttUBCOtiTwZDVXG7eFPCponxM6aCp0n4r2QsiLWDuTJKwzCHM9jOZPlup
 s+1IxbVMx8cNy5THdRiz25+BOPlGOw2dyF8XW4TfAH3cQb1w2HUdsVxO4498t/a3dmb6FevA+
 CSJ2sZI3ngN+qfWpXE5FtIE7ez9FUKaGZqhLipF1UI2JwivAJLfdZ3LhZLrXudNL83AOCSjM3
 eag8vNzYFgwnvs54vSwu24cVWBHkeg1iNlavAwFqbww4nt/6yU29zyUOwRe9ZGpzxXJIyq2vB
 FcYDD95GI0vNqYFbaWgGLVpv9zhoQG5+mRFTzLpCIC/18zK/oQ4UFqf2oSK0cFNosxGy0DQw8
 SeJ5zNexPEDJ6mQeoH7JzhWhBDOvBUfwoOd8YO2f2uCtgY4S7nV7PuUP7/VhwwNPbRUJTwl1K
 dqdyvvCNWHdo2gfZuWbh7YhHX+kcdyWsl7zk7wdvMnc+au0a3ghlUCaG5Wv/gcC0Cbz8NboZG
 SKzoCxQaoX5x+GTW49iATJqTXwPLlQnb/JdoJciclQqSCjg8H8L7JIuHT1kryuo2effejjZeR
 oN5HXPDGOFeFKLhdWLVT3E9l+HvBxM6hADaGTumT92rCJ6TvAi0qDw7IcYzYFb1Q9yTgssPYt
 t4Ce+E4wnO1sodU3BaMHj6EGNffsXmUvpv2nanxKgLUT8Fkx7ZmiFI5OkCkgiRQz9DEHhYM0i
 rz1n+1OQOMQTYp2U/aXv+yn5HI5Z2IhXLb3Yxe29yC4mX1Gc9O8e60z09lRZyWtCjtdnCpqfB
 WMw+YAVJxAvgiYmBlrnCE4tqUx0KIrPWGMQpvT06VahwnENLQxxVDFys/zKP4nrTLyDyeT4rL
 U7xPqjd2eFbqzNX+hmXnAvJnOzFUfRmj81dkLFUb54bCQYETw+ZmfNDsL4lT3VPjpX45Hl/Eb
 e/RvOxgv3wZoB5djWzi+DLl5wqq32WAjIO3uDRtuocWVcyfXPn7ohjFwOQxjyHlFuee6U6cBX
 W6VmT57hc24DmJT0RTZhMHXX9yoG0wfLKa5U51g5lQ/GVHiL5xLbLv+pvqrS2UqbBUuA/wDDf
 aKlqF77P7WP2Kq673iCu3ugD4qxLHldyOzGAnJvcTT3FQlxuiBxW7cVaPyCckyUS87jEA2Zq5
 fKFFgpKg3cCzg74xlntU13hc9p3fqKwJkW7yJjfFi3jP+dfSp9RgcKP+iubXIyW0VvuQmfZWK
 GPDvx1PvOedUQlibEzVUrHquRZufpoDgzngeoXZruFveyCUqPUjOGiy+h9ilDnsusMgPa28KN
 Pys4D9ouszxOM+hlnik4iSsfAJQq22+JYjvIkuf7YWftsUOuBMhGp6M62zIum0d2iTVW5lIRk
 yMO1vgRf0GsXGu9WaPOiXUedRWtiosYvdwChifrKu4yWViEqax2chK3LNOZOEnLQDQUScN3Sd
 uGmzBpIDfvpoBvDOpXsHJEpjX1BUHpTcvIjzdR2uUt/s+ZKcqjnb515ijfrw3g66CBOm76qCl
 zIEeyFwkGX1ctRv3eY0KbprbPYgcQbZCjGvQaB94OZJ6EwWARALB1CrAFpao/sCJSLKJExXhi
 mFcgUPACrgoutEBvRpb/kHL+7Xjhuso/+9Fagzml1mLeO2BkvalNs1S0xf3jqTfITV2ghxSHE
 K5d0H8/8RUE4kfwiac9V8gDjx2vDxB+jJrRES6eEFKEZC3n3QYpQSKVIqG0xEUNhmZc2vAocX
 tmeKbrZD0Jh24blGUbNyihkXBcFOoJvnJ1nCSZUVljFG3m08kxQqFZNHmjbCr4xt62lZGVAXf
 0q8lnaxixgNg0RUFOoe3wf88X29VMLqoLDyjd28IVjugimvII6xX0bbWlo6d3V+FlFFKyk+TG
 oBdhqQdgD4GjF65XBB/pYhQS6W1jUIJOYKg0mp10ZFqhqhDrNd1UQDxValEOHHacWycmjp/No
 ITWQuGBW71OSnW5ChfO9cc5CmvivqRpfslujZyAFOIFsObz55CrKFio9F9sjcv1nTAhIKAmmH
 mMz6ueI7nLc1aBqr0oW/+HFb8GZeIKWkuo81zhBNFbqLHbl40DhE2pWtytkLG4P37D/s/KNUq
 86pgkOvOdYfzgZCTyzVgqhIIWOav4VQ5MuF70ZZzv21JBRmhlC6HAkW/NG6fawk54FXgrlb69
 Bny7AFX0VgZy26AJBxHnYf7U1tlOwhd4JutYBMwG2Y0N9fMeK07XaEvompGJ1vq8VutYHHSHv
 AoaAsN6nYdjhep+ErpAxs1RVTnmR1f+DafoHIcX90xZG951PHXXpsl0mg+6U0givwRV0tuHCb
 sk7jv8uGlzcQy0Ho7njkLbBohL7VwmpNcRaIPPQci8aqHlSe6sLlNJud9OaTI7exc/xRlO5aa
 V5VTOm0bijt0AHVP3IW1Z63WDNZe05nzTiG9JP6dPbC7SjMRB1rS40wWEy1u7JQAsU6eMO6hM
 cL9CBYWtxH7Xu2kweN4bsHKIEPLGbu5wof+L5CfsETHGfaTaV2GeKHWdumeVqa/WVBFEEiCnH
 E0bnCKKq45eEgOJqMOBoBzo2O7X3gwhD1H6HmAQEXwDYCazxQUm9DhhkxSKGvGHBh2xyWTBRR
 d/LHQkxescAryW4B8frqBHktaqMkgafWG9tJTq0Me6mqCmDTqnpHp2ZpErOOhiAvy9r/6LIAH
 MRYjfNJNwNiOOkOHN3uVZO+ZQmALBHMKXS3GB698zORDP4DyOhrhEKrRsWKh3b+qZb5x1DGot
 M7suMGfYCViTWvjxtm6l0PFiZxaRtsm/GSlQtER5GQjBBaGc586u41lQu01kg==
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
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

On 6/13/26 17:21, valium007 wrote:
> When a binary is patched or relocated such that the program header table=
 is
> moved into a separate PT_LOAD segment=20

How relevant is this? How/why does it happen?

> (rather than sitting at the start of the
> first loadable segment), QEMU's AT_PHDR auxv entry becomes incorrect. Th=
e
> loader was computing AT_PHDR as load_addr + e_phoff, which assumes the h=
eaders
> are mapped 1:1 from file offset 0. This breaks when the headers are else=
where.
>=20
> The Linux kernel instead locates the PT_LOAD segment that contains e_pho=
ff,
> then computes the in-memory address as p_vaddr + (e_phoff - p_offset). T=
his
> correctly handles relocated headers.

Ok, I need to check on this.
 =20
> Fix by:
> 1. Add phdr_addr field to image_info to cache the resolved address.
> 2. Initialize to load_addr + e_phoff (fallback for headers outside any P=
T_LOAD).
> 3. In the PT_LOAD mapping loop, detect if the segment contains e_phoff a=
nd
>     override with the segment-relative address.
> 4. Use info->phdr_addr for AT_PHDR instead of the incorrect formula.
>=20
> Signed-off-by: valium007 <valium7171@gmail.com>

Can you sign with a real name?

Helge

> ---
>   linux-user/elfload.c | 21 ++++++++++++++++++++-
>   linux-user/qemu.h    |  1 +
>   2 files changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index b05b8b0..8049c8a 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -699,7 +699,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int =
argc, int envc,
>       /* There must be exactly DLINFO_ITEMS entries here, or the assert
>        * on info->auxv_len will trigger.
>        */
> -    NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff));
> +    NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->phdr_addr));
>       NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
>       NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
>       NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
> @@ -1469,6 +1469,12 @@ static void load_elf_image(const char *image_name=
, const ImageSource *src,
>       info->data_offset =3D load_bias;
>       info->load_addr =3D load_addr;
>       info->entry =3D ehdr->e_entry + load_bias;
> +    /*
> +     * Fallback for AT_PHDR if the program headers do not fall within
> +     * any PT_LOAD segment (see the loop below, which overrides this wi=
th
> +     * the correct in-memory address when a containing segment is found=
).
> +     */
> +    info->phdr_addr =3D load_addr + ehdr->e_phoff;
>       info->start_code =3D -1;
>       info->end_code =3D 0;
>       info->start_data =3D -1;
> @@ -1523,6 +1529,19 @@ static void load_elf_image(const char *image_name=
, const ImageSource *src,
>               vaddr_ef =3D vaddr + eppnt->p_filesz;
>               vaddr_em =3D vaddr + eppnt->p_memsz;
>  =20
> +            /*
> +             * If this segment contains the program headers, record the=
ir
> +             * in-memory address for AT_PHDR. This matches the kernel, =
which
> +             * locates the headers via the containing PT_LOAD rather th=
an
> +             * assuming load_addr + e_phoff (false when the phdrs are n=
ot
> +             * mapped 1:1 from file offset 0, e.g. relocated into their=
 own
> +             * segment by a binary patcher).
> +             */
> +            if (eppnt->p_offset <=3D ehdr->e_phoff &&
> +                ehdr->e_phoff < eppnt->p_offset + eppnt->p_filesz) {
> +                info->phdr_addr =3D vaddr + (ehdr->e_phoff - eppnt->p_o=
ffset);
> +            }
> +
>               /*
>                * Some segments may be completely empty, with a non-zero =
p_memsz
>                * but no backing file segment.
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 07fe801..2268493 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -26,6 +26,7 @@
>   struct image_info {
>           abi_ulong       load_bias;
>           abi_ulong       load_addr;
> +        abi_ulong       phdr_addr;
>           abi_ulong       start_code;
>           abi_ulong       end_code;
>           abi_ulong       start_data;



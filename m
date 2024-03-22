Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACA8C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 06:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnYqW-0005XD-U7; Fri, 22 Mar 2024 02:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rnYqU-0005VU-Nr
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 02:57:42 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rnYqS-00032z-Sr
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 02:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711090655; x=1711695455; i=deller@gmx.de;
 bh=aKmDOh8eF9E0DxmFC4FrWvdPyY6d1DGTR+4egujNGks=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=CNRxMsF5vdZninAVWIOXh95RhMmjkWFa3R5YlFD9yeTmVHrJu+7gJkYOxaaGDuCW
 ravC+QPnTPSWmU82FbXIkXdRFEVn22EbxUxDMxz0YDNyOjG7+SFfLLND8t/KtueoP
 BZ7xHrzGMh0QjZm5cL3poy3UCv0nhZqE2Q9VDlkcx7Ls+DdVpRpX3D30GsCI2J7oU
 gdSwfFo17et2/WU2VTl7s78xNXTss295hYiDdRF1kSXMVgy4avysvH6O/jrGtzhvw
 a2wA7r2/23uEPJR/Dbup5Km7DuQ74nOixuT3ItCBT8SRT2r+ZoEbtu+PaeelJsgfh
 bw8GRF+ti8FmBNITvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.180.187]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvL5-1rLpE22Ub7-00RrRw; Fri, 22
 Mar 2024 07:57:35 +0100
Message-ID: <c9eba01a-b370-4d0b-a5c2-774120fe113d@gmx.de>
Date: Fri, 22 Mar 2024 07:57:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hppa: Fix B,GATE for wide mode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: svens@stackframe.org
References: <20240321192813.371526-1-richard.henderson@linaro.org>
 <20240321192813.371526-3-richard.henderson@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240321192813.371526-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u958rpBw00y9DkETb74NXFczrhw/d5Bi4TxlmCeFO5VVqMfsUDM
 hJxr7GTeEgy810JmtaMqXm5R+LoVoAU5XbAiFpxAoQ7UqAuWMIkEaTcDol448f7JlIz1JQg
 swXxuQHwmX2DB1A3vy/YIL1A+iWBr5V8hel4lWsa7HUgaJZ129JGUHnmO0rK4WhJ4crOVGz
 r7YfH86DgbE931r8RrNrg==
UI-OutboundReport: notjunk:1;M01:P0:as3/MXO1aAw=;6uHH0KLcTMZY5lMBukYXBRyuafK
 hrpcPGXneuo4eWJH+LMJJVsd71o00HiCRlcBsT+rfw7urXlllkcDR/aLC9JqeGxHwyo7xGaYy
 Rg4eiiLaFY2gUnIYaMlet9l/Mj28lj05gnl65iQ8LhTpi5PQUXvwWlXLsw+6HAFg6H4b/uJxZ
 tdPagfmgwigMOtROd/cNJrgWKpalB2p2narbhjyAPj+Gijorohg05LTD1ZLt1ojoVRWBNV9UF
 TZIQphTiBpZ3kr3/LVErYQqDhTTGR3u0NPzIgkDoWPfRj0GaUFM/+UvMipA6WTVLKezf6wtZB
 dF+/RPN+zSntpWcOjSR/V0kT3qyrirtiuHqKOykO2SWdbAdsdcqbOrU7KocIJ/bhoCjOg3kI4
 hVa2Axtpyio4IJ4dwxHHdocOQub5A8KfEaZNkWDG2Trwof/sdfQSdx5O2WR7QgV97p/H+DAfE
 jR710x+sFuriuhKf34k0cJqMIOj4dXpaDVABEDAGdRHb0bUXADpCuqM2eJ+EjHYkMIwTQqeCz
 sIJmOKFnAQx1Gix5eX0MSO/IaIY8DlHv6LWagLEEwfU3g33JZ/eCMSGbVQer6HuM2uJ3h+Kwq
 Uk00T4I3p19/e2H7vc08U2rJ4CzIh3qWvcbORmnUCJnqVtWzQermC+DzZixY9X+bMMBf7I0Hk
 tQX1en1/HuhczAIAj4U8IQ/FEWW8SujLqcrm8wd7r+my4y2SGMqJBIxuexhcNKYPyiCNI3lZ4
 hhMPs/0IDUvjlgbLWL+puy/ntuAnunGqCbXAJzgE96a6urzYOxsBRsK8nYp8vCCW9crywD9Oy
 be+l5zDAoiJknmHpUF2ggArhZSCx4ptkSsmqfDJZZUXgs=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/21/24 20:28, Richard Henderson wrote:
> Do not clobber the high bits of the address by using a 32-bit deposit.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

Helge

> ---
>   target/hppa/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 1766a63001..f875d76a23 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -3880,7 +3880,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_=
gate *a)
>           }
>           /* No change for non-gateway pages or for priv decrease.  */
>           if (type >=3D 4 && type - 4 < ctx->privilege) {
> -            dest =3D deposit32(dest, 0, 2, type - 4);
> +            dest =3D deposit64(dest, 0, 2, type - 4);
>           }
>       } else {
>           dest &=3D -4;  /* priv =3D 0 */



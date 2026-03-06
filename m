Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4F7FCC075
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 20:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybkY-0004GS-SP; Fri, 06 Mar 2026 15:26:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vybkX-0004G9-Vp
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 15:26:18 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vybkW-0005ua-10
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 15:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1772828756; x=1773433556; i=deller@gmx.de;
 bh=9WqDmWP7q2DaiK1hAKaqRA2ZnBHds4lGgtLMrSaMrkM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=W8tf5k5RmgcmwqJ7kD3WyzO7LqZv073Sj5ble/gTRVQn2cwaL7XSTkXpKYmDbtyu
 fV9GJbb3XB3IwXDvWMDfv4d6gvrFG0ixrJbk8pIrsFer2U9+fJ8efBffilY5rNZzZ
 YE0ETzPOdfA8NFWxJQIP5LZ39lACwEjkh72GyOUSUz+91Wr1b0IsXBiYbaqoM0nt7
 N82ZSfMkQJ0sNdLwEg0jJR8/CY1cKa0I/HunPpdVCF2yOryRYo2yCvWlQ3W7BlBS6
 sDcf+Zc80mNGp+iK3cmbdrLrSpvnwK1QO1Nj88sc5W2QEjiMluv1N7gi91KRcPEch
 z0NsX9VAQ2FfSpgLNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mulm5-1vgOTH1gXb-013QW0; Fri, 06
 Mar 2026 21:25:56 +0100
Message-ID: <d168ac36-0079-4941-b1b0-ecc8ba65fb48@gmx.de>
Date: Fri, 6 Mar 2026 21:25:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] bsd-user: Deal with mmap where start > reserved_va
To: Bingwu Zhang <xtex@envs.net>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Alex_R=C3=B8nne_Petersen?= <alex@alexrp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Bingwu Zhang <xtex@astrafall.org>
References: <20260228-abyss-mmap-relocation-v1-0-c8ec0476894b@astrafall.org>
 <20260228-abyss-mmap-relocation-v1-2-c8ec0476894b@astrafall.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260228-abyss-mmap-relocation-v1-2-c8ec0476894b@astrafall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NViX1n7JtAyJU1L4rHMDr8kfaswTSrz7HmbSfuM5pxzmi7eGNJH
 ibcjZQhUPvekZLfo8tzVO2L7PWV4jGEjbZgiOGLTmIDQESzZZ0PTiCQkeIPBk8VVbW20qBR
 e3IhcIpIcuWXuW1ITkHuwuFAosiKjMKV7apJDOnlFyACiz93SDFDbWGHkmAP5v4cHgVWWD6
 YW9qMScx4rx9It5G5rzZw==
UI-OutboundReport: notjunk:1;M01:P0:7i66gBJnCuY=;XezEEYCShcxDWfPdWW9uVTDXwJI
 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
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Fixes: f12294b5bd21 ("bsd-user: Use page_find_range_empty for mmap_find_=
vma_reserved")
> Signed-off-by: Bingwu Zhang <xtex@astrafall.org>
> ---
>   bsd-user/mmap.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>

Helge

>=20
> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index 24ba1728eb55..fe77eceb4856 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -258,12 +258,14 @@ abi_ulong mmap_next_start =3D TASK_UNMAPPED_BASE;
>   static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong siz=
e,
>                                           abi_ulong alignment)
>   {
> -    abi_ulong ret;
> +    abi_ulong ret =3D -1;
>  =20
> -    ret =3D page_find_range_empty(start, reserved_va, size, alignment);
> +    if (start <=3D reserved_va) {
> +        ret =3D page_find_range_empty(start, reserved_va, size, alignme=
nt);
> +    }
>       if (ret =3D=3D -1 && start > TARGET_PAGE_SIZE) {
>           /* Restart at the beginning of the address space. */
> -        ret =3D page_find_range_empty(TARGET_PAGE_SIZE, start - 1,
> +        ret =3D page_find_range_empty(TARGET_PAGE_SIZE, MIN(start - 1, =
reserved_va),
>                                       size, alignment);
>       }
>  =20
>=20



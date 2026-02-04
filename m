Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239D1E95392
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 12:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncO2-0001r9-OH; Wed, 04 Feb 2026 07:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1vncO1-0001pc-Bz; Wed, 04 Feb 2026 07:53:37 -0500
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1vncNy-000484-H5; Wed, 04 Feb 2026 07:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1770209609; x=1770814409; i=laurent@vivier.eu;
 bh=cMg403Z2JXNf6wREhHzqf1Ncf/DgptqCXwutfm2lpoY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=zS9kfVQ4loiOT/2kxEfQFNXnqmVF+r3C3g2wgNnHxB4azvA7iHX2t3H5ILALxDNb
 yI9LXEt/MO5jZvS/JdNpTxcSASA0mogZysmI66WiscsnbKL/sQE+c3LNj1iuwUiDF
 banUYqqDLo1ilo0UYXU1WLXTKHbw5ksQF6Y4c+S8JZO7t3B72qYJKbQwtflKI830b
 /4+vo9Hh8J3i6ivO96NdR9GO+sgLwkdd0+88ImWAgEnFtzwYMhq0v+5RBHOTveg8h
 kh3+NBJB9PLqP43uIn1oBdyYBAf2bdN2Twc3y3TOpHF/xvEe9ugUjIIsvgZsyh0n3
 h+6FhrI+60QmDJCt9g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MN5aF-1w5yaC0C4T-00OiN2; Wed, 04 Feb 2026 13:53:29 +0100
Message-ID: <722eb7df-0eb2-49c1-af07-90004ad46a8e@vivier.eu>
Date: Wed, 4 Feb 2026 13:53:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] system/physmem.c: reorder usage and assertion of block
To: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260204075754.21078-1-heifetz@yandex-team.com>
 <20260204075754.21078-4-heifetz@yandex-team.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20260204075754.21078-4-heifetz@yandex-team.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a2XVJnzjoaL4ZSS/IyyKbpCpm3lf6MIP1GQZUU7qrBamRVm9zCb
 Rp5u9Ln7UPxYEY0b2OFGkIC5Khr4b25ivfHRYIbjArn8NrL1xus72YfUobA5o0klGm2hUAH
 h5hUV3pyOzFiNz4XffEvnaN95L1TfHyh6vUCdKVFXiparJQPAFAaFl8laa57e1NY60ajKl/
 ujpxOHk+FCSmKISgTP+kg==
UI-OutboundReport: notjunk:1;M01:P0:5KjD5Pe7cZQ=;k/nt7wma5P8iYp0MyaRDltyGJa/
 m2UHKN386RNJjl7zrGwDfzjGqoNkYQqPUeNcPwsLVkgCdI+SHXtBOcoDdJEhvThtuOzocdlyD
 M2E0ZM6ITuoGG5K+J6FGxfi6xIuaq30WhHqLv10COVHxINFbQoIaRy3MrHihdylwb071OqBwv
 Y+JfoNsy7KsFtMfDSO9rGJsqmyzjdtIGne/6xC+GMVmMi0SvqyPT5hnt6sSkAoYVyWAOsbZ2b
 MvetVX1nb91x52NC9+H//uakD4yci4cSwP0TbJvplbzyGu8dnSRj4W4Lh4TpiwvxQawhFEcFa
 Chy5B/GQht29reYfJy/bcWfTgt5NQQAXgJrALR6Z12gBNTnUNGurbl06zKLYyEEQz1tV8GU+f
 FvsGVE6GUcTC7e5zJBAVutM6yj5wuvWvw7yKtgT5/medpVABKbscRRt4d9e27OpFnYhCpa8QY
 tuz7rvwVv9Ykj/o4SxD1dmB5T6tGPzxPZLex///Pyu1DRUI2k1T8VU9DGNOc1ldy1QOSFzx0m
 nu7TCSW7RHp7NXdXG60T8KvNET0gsQQFeshxmSt4c3XQkSNZtga1iEy2XaFwQ1hBUFfwV8LBI
 W11L3hhJeQgprHQt0soN1A1uUP76KsQ4xDAbeElcdXLwtMDdjgM6CSrdPPpCW05gVXDJ52zr5
 b0kaxIS7QDUFezDbfjENt8kHOjKKOzFV9cfUyzgND/fJE+/Uo3RTRjK4ElKueukNLCsjCIP0F
 V56Ymg6ywhL2cXR2p72BKhNVIR8+jzHnAdEn3SSB8r6UsnslBZ+If1nuexIRrNu3hDh9Gd0Gd
 HwbLoGK2Aovgx9clu0mMk9/IIdHkvja4zm61rHdVg6wQ4O/9ZEIECzb/AtIRdcxDkMEU6wnsT
 R5QfOupEyia5CE5vtc2Ge0qHrtCFXe9OqCj6/JHivrB6taqz0D13RYt+0P/67QfV69OUWCUWW
 TieFsGReAeQA/dYROnv+Y9v+Vn82elp9F7/OBQQxTr4xxWtag+GH4I/aSotZ9IqKjVp5PNz6R
 8rQIpiJinh4jdNJluIu1w1Xs43SIr61AobVjhEpoG2K1OD/IAN5IfednZb28ZQ94pLyrlTGlK
 i/pcDzRMYDBOCU+C05T4AY386y5SlV4+ZF2fTSsm76m7fF8xsUUSBiDuF3OYyTEgHQmE/cWlV
 4qkldgppL7/D4FNV+2SV5kFvtjaRmygWIYAlhYflVyFhpGLnKXtyTN0DNjCEIpLaZ+JuPD3/q
 Co3o0OikHmcObKKdY8DtNw+U8HT+0OCRxAVu3Auu9QSHOiUAXBXtL5k1xgxmtWxIB+RtqsPf6
 s5tYuV1F9CS5Ff6m0MZOy2YfJTFryPTeuBFUfGiuif0k3ZDFZYp+u0BvQUGvvHgVAkxd83n2W
 idmu+p0HjdgxD9/MkI+/2WimRAfJBU7K+TKz+5pb0aIWXLg2TYTz8qsYhq5q6yGnRLz2wt0hZ
 9+bjg/7ok6JCBYlIIzoZiPPuwCOzZpvGxc4v20FYCkBHFKJeb2mDMavpmGq+4qDT5DKOAlFg2
 PzYHLTY+bXsbdP75NOCY6rRYcm/94Qu0jStFNPWZWMwLlBcRZp97Ky1z9EBAoQgBGXoxTfz0D
 8QEaGIhp6YwgnG6A/oF619wWw8nXP5wVh+dUmaJc6nl1S3z12DB/oiOjrMD415qZ8VMa1Xjl0
 ozrvtbHiLESotNknYDAej0hFio+VhB7DFdg+TJkRX5V1mYMqdpIN9qUGcjFD9ZMEt8mtY6bSQ
 x3ZU9A15WCOqa3ig0CE+AE1pxeSzU4O5n/jTLr6TmmB2vCV83bhtrWEs=
Received-SPF: pass client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Le 04/02/2026 =C3=A0 08:57, Sergei Heifetz a =C3=A9crit=C2=A0:
> Reorder the code so the assertion of block occurs before it is
> used in the subsequent lines.
>=20
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> ---
>   system/physmem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/system/physmem.c b/system/physmem.c
> index b0311f4531..4308e02940 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2054,11 +2054,11 @@ static int memory_try_enable_merging(void *addr,=
 size_t len)
>    */
>   int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
>   {
> +    assert(block);
> +
>       const ram_addr_t oldsize =3D block->used_length;
>       const ram_addr_t unaligned_size =3D newsize;
>  =20
> -    assert(block);
> -

According to coding style (docs/devel/style.rst):

Mixed declarations (interleaving statements and declarations within
blocks) are generally not allowed.

>       newsize =3D TARGET_PAGE_ALIGN(newsize);
>       newsize =3D REAL_HOST_PAGE_ALIGN(newsize);
>  =20

Thanks,
Laurent


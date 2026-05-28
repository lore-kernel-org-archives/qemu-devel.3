Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBD5CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVJq-0002oI-LQ; Thu, 28 May 2026 03:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1wSVJn-0002ky-VI; Thu, 28 May 2026 03:38:16 -0400
Received: from mout.kundenserver.de ([212.227.126.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1wSVJk-0001F1-5X; Thu, 28 May 2026 03:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1779953886; x=1780558686; i=laurent@vivier.eu;
 bh=vhc63mx7nx5AmKiI1rGUm15pX2XyfBUxix6c2Ji+c8A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=HdjPKFCLXXu8cgIqGOkDTn9Knj2gn1kZaWTi9bsPKoVZ98gvzXjYCMA0GxmQqlE3
 JQvTRDQxNGQqOGdaTZlVAolSKCeRf7EYXK6wuUpUI/ECKsGDxAjedIOHRzPjCv/SZ
 SganVQncgF3zn1DfdkscVd6CEcjw8GZ16Od6mIcitO4ngwd4MmcWZ1sLW98GNY9Du
 Ky12230emWsLDFf5CglY2NRLfvsmqUJxX8IanYmy68SGH8RlqN+LJUV4WHgFhEeIt
 5QiXnDh8YelaugKumrOu3spjBuogqpUk58yLQcO8XmKWu7N2taoO24MpqqxL3K1Tj
 juJotSpYPImHLX/j1A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.15.136]) with ESMTPSA (Nemesis) id 1MOQyE-1wgBLE0aaM-00ZAvW; Thu, 28
 May 2026 09:38:06 +0200
Message-ID: <78fa0e01-4d8c-411f-8453-1c06713717ef@vivier.eu>
Date: Thu, 28 May 2026 09:38:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disas: sparc: Fix integer overflow in compare_opcodes()
 for loop
To: Christian Barry <christian.barry@usp.br>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-trivial@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
References: <20260527175705.152301-1-christian.barry@usp.br>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20260527175705.152301-1-christian.barry@usp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iKLFA46zPOs9IKszpHzWCIJQfBsb5UYhHIC+DkO3Bu/8RZkFh4E
 /FiA1DEDHeME+Sk54FXtCEDQVsYNY+pJFYB0I+CxEEOAxVqS8CxaDdA42hE8NoflNuEehta
 PaLqbGpeEYG0ViwGfNRXa8hCX1ZhgwZ7auwiSXs455ufZFkB8sRrk+26AZfEhEJYWta/HsI
 1/cvY+Qp1bts0JI984kLQ==
UI-OutboundReport: notjunk:1;M01:P0:2BeCXwKKTOQ=;JIauu6pg2TqqWyXXkAHT+neiwQv
 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
Received-SPF: pass client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Le 27/05/2026 =C3=A0 19:57, Christian Barry a =C3=A9crit=C2=A0:
> From: Christian Barry <christian.barry@usp.br>
>=20
> Replaced left-shift of a literal 1 by i inside of two for loops in compa=
re_opcodes() with a call to BIT(i). This makes it so 1 is interpreted as a=
n unsigned long int, preventing overflows.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2618
>=20
> Signed-off-by: Christian Barry <christian.barry@usp.br>
> Co-developed-by: Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.b=
r>
> Signed-off-by: Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> ---
>   disas/sparc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/disas/sparc.c b/disas/sparc.c
> index 5689533ce1..6fc057e3a2 100644
> --- a/disas/sparc.c
> +++ b/disas/sparc.c
> @@ -27,6 +27,7 @@
>      see <http://www.gnu.org/licenses/>.  */
>  =20
>   #include "qemu/osdep.h"
> +#include "qemu/bitops.h"
>   #include "disas/dis-asm.h"
>  =20
>   /* The SPARC opcode table (and other related data) is defined in
> @@ -2515,7 +2516,7 @@ compare_opcodes (const void * a, const void * b)
>        another, it is important to order the opcodes in the right order.=
  */
>     for (i =3D 0; i < 32; ++i)
>       {
> -      unsigned long int x =3D 1 << i;
> +      unsigned long int x =3D BIT(i);
>         int x0 =3D (match0 & x) !=3D 0;
>         int x1 =3D (match1 & x) !=3D 0;
>  =20
> @@ -2525,7 +2526,7 @@ compare_opcodes (const void * a, const void * b)
>  =20
>     for (i =3D 0; i < 32; ++i)
>       {
> -      unsigned long int x =3D 1 << i;
> +      unsigned long int x =3D BIT(i);
>         int x0 =3D (lose0 & x) !=3D 0;
>         int x1 =3D (lose1 & x) !=3D 0;
>  =20



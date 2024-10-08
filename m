Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94296CED272
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 06:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy450-0002Ic-QK; Tue, 08 Oct 2024 02:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy44y-0002Af-6r; Tue, 08 Oct 2024 02:52:20 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy44w-0006ZN-LD; Tue, 08 Oct 2024 02:52:19 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20bb610be6aso58822355ad.1; 
 Mon, 07 Oct 2024 23:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728370336; x=1728975136; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rekNk13iAH4JOZr3OXQzEzKZg3VV5uCjGtmBYHyF5Is=;
 b=jkbGSgv19iAPLxkKxz7PeMYXJr4Usn2DV93rCI1m78mpIKvw/QZkJ6KooKz/U+i2MA
 2QAALSdqvzHrAwaUq1gxw5RQz3UmvX03aEd9LqqWR1jU1XJX4jLGD3CPQqtwATWPATMS
 5MbP/+o5lTA+0cnx6AtN6Ix6CdsEP7PxES/lCcqtzowIp0HQmiQdLYwj+hgs/UGUWin1
 zsL+gpd79icvBjTRrInZsy12GOyQ3/NQdyIa0qUal1UtKjPq16Wim/nWHxh1lqljE5sT
 sE7x6ki3gB6DsKlil8N6lJWAbFml+aeOYg7SlJol6QZB4Aw8QRPpql8rrS3NTw9J3Ny8
 lB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728370336; x=1728975136;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rekNk13iAH4JOZr3OXQzEzKZg3VV5uCjGtmBYHyF5Is=;
 b=Vc1SZcTseJ98qWQDEE91t/WHCgDRO25OLKyNaEo+6xqV8FFSLGfAWzDeGuLXTCJS65
 cdoX0K8CR/9TVJnvmw74JisLGOW6MQPhoH6TOgCl6MJn+k7gRNdDY2nC2KJOC9G5uCiu
 peWdjCKA8MEI8jh2VPrx97WzhYgzup0ZI6CXyS1RrzwCDRTuC8DgKEfxzE8ntVUlGikw
 PBa8/JW9qiEdmpazkXnpos1Vmdz5rfhB05yNKfGegzpLQtsfoMN6ld7y6bcu4MYU8mNJ
 EixUryd4uos5vedSeOrhNBu/1XCIbdAFfQYEhiwmrWs8JPXeRxAZdqPBvSzcIPAXBWpy
 TXgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/IQ0XorzfLL0xEZjmaDqqLaywSk7DnNeRLw15jLjhEl2M85Iyml7wGHYzzPzPNV8szPh+J5xPMbI=@nongnu.org,
 AJvYcCXvO15mjb2cAnr7mtyx+MkZANfPeCF4ru3xfd2okGGmVdvBA/oJ2+ZyGd98ACFcPEM+YCCrAyik9tvp@nongnu.org
X-Gm-Message-State: AOJu0YzXxXSZFM4khAS1/F7DNx4CaSVnA1I9ufPm93PJWU2oFJ0VM2/v
 96Th9T3Er7jhwdFkJDlGJA6MBtcN4T8qU0PiaHSsilvBqQM0lgOwXcUFWw==
X-Google-Smtp-Source: AGHT+IHJQx+O8OyjeJMGUQoHMMk1KY5D4FB9EveN0f+1lttPrVCoJc7JEcC1h8pmJK+Lv0TE/r1JTw==
X-Received: by 2002:a17:903:11c7:b0:207:15f4:2637 with SMTP id
 d9443c01a7336-20bfde659b9mr193807555ad.12.1728370336428; 
 Mon, 07 Oct 2024 23:52:16 -0700 (PDT)
Received: from localhost ([118.210.103.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1398cecasm49581195ad.276.2024.10.07.23.52.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 23:52:16 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Oct 2024 16:52:12 +1000
Message-Id: <D4Q85D7U3DIC.2SSQ28DCMOI7G@gmail.com>
Cc: <balaton@eik.bme.hu>, <danielhb413@gmail.com>
Subject: Re: [PATCH v3 10/10] target/ppc: combine multiple ail checks into one
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20240913041337.912876-1-harshpb@linux.ibm.com>
 <20240913041337.912876-11-harshpb@linux.ibm.com>
In-Reply-To: <20240913041337.912876-11-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri Sep 13, 2024 at 2:13 PM AEST, Harsh Prateek Bora wrote:
> ppc_excp_apply_ail has multiple if-checks for ail which is un-necessary.
> Combine them as appropriate.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

This looks okay. I was kind of trying to make the reserved cases
separate from the non-reserved, but in hindsight I don't think it
really improved things and the comment is enough in each case.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/excp_helper.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 4eeeedff5b..a8bd537a18 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -324,10 +324,7 @@ static void ppc_excp_apply_ail(PowerPCCPU *cpu, int =
excp, target_ulong msr,
>          }
> =20
>          ail =3D (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT;
> -        if (ail =3D=3D 0) {
> -            return;
> -        }
> -        if (ail =3D=3D 1) {
> +        if (ail =3D=3D 0 || ail =3D=3D 1) {
>              /* AIL=3D1 is reserved, treat it like AIL=3D0 */
>              return;
>          }
> @@ -351,10 +348,7 @@ static void ppc_excp_apply_ail(PowerPCCPU *cpu, int =
excp, target_ulong msr,
>          } else {
>              ail =3D (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT;
>          }
> -        if (ail =3D=3D 0) {
> -            return;
> -        }
> -        if (ail =3D=3D 1 || ail =3D=3D 2) {
> +        if (ail =3D=3D 0 || ail =3D=3D 1 || ail =3D=3D 2) {
>              /* AIL=3D1 and AIL=3D2 are reserved, treat them like AIL=3D0=
 */
>              return;
>          }



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC76C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW843-0004JU-O5; Tue, 23 Jul 2024 01:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sW841-0004Eo-Ov; Tue, 23 Jul 2024 01:27:53 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sW83z-0008TW-CB; Tue, 23 Jul 2024 01:27:53 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70d199fb3dfso1745524b3a.3; 
 Mon, 22 Jul 2024 22:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721712469; x=1722317269; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNXfS30dxaCxpNFC6BT/Ly327c1DaJaco+cOvNJsGrQ=;
 b=Bys4kI8OVoqSw266STC+O6HloBFZn57fmlRS8fkblJqo5KJwPuiq+UHQ/MWsD4X4l6
 qz5xCDpitoPUjmh+bll8XsciqPV5w3B34cnI1mcaK3LQn0JJcQi9pywDJm1LcJ4AVY05
 44msozsEnos6cu897wFfoi7/PI3XKzO8wnbNKGcCVL+KJIebe/L6o23lJjfBFhKki6Os
 IFjY74rS3bNMXv+JSL1t8DhpWL8C+6Vh544DV+I235q58z5ef188bo+3JQnqNuf93rf2
 9+HF4CRPS7yVcaEQ/IXaOE4AWr+WZda4Cs5ET5Ns9f/fto5eOluJtQfTSx+vimPkUGUA
 dbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721712469; x=1722317269;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WNXfS30dxaCxpNFC6BT/Ly327c1DaJaco+cOvNJsGrQ=;
 b=Eg7xjCAgjEAob4GVdZI4/yZoJUr0aJGWX2poLHvgOoToNpqmDeDzcKHu5WA8bkm4bI
 ymPEx9mvClgfc9Ij52N94coNNzIgGnUuacenIRUAl4jx1g+vBkYz6bq3PRtQIEZeDSA3
 rSn+ambpmL/Im2hYob/5CTE+hrUVXGIE9zi9aOqP8qdItoMSq6x3Ag2Fck8sxo7zAp9N
 44EBdmq/vgQIX4v2S1qxwOE/mQR78Wj+nMa1zc5sDTVB2sanAb2YFVNCaTXDs8ychq69
 Tv/x2KAf9j9fF+Fh4atM0SxDkHPct/5MBbu+UUdpj3Jr89EXta37Ta7q1lAiZ98z5TQB
 W5mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB7qAf5PkLCUmtYQgb2ANFX/Z0gV4r6/r3apj1L9q53hgaDusKG50sXTZLJHrUNp83Dy0/xbmG3eUWP/4jEV1FTuN9
X-Gm-Message-State: AOJu0YwrRxdvraTy3ycLRPRDvEzzH4ZOEDUzchxUbitQ84MS4t2XudjZ
 BXo3nHdHLafrUFh9QyggINQNEjxVsIZwM1ZTbeiBc5qOI0kUGbVA
X-Google-Smtp-Source: AGHT+IH4abHIPiIwwViz1f/dgoWp/curX+a3wOSKtVtyuIQm6FQMyM1KD/Sb2VW6QL22Mn5JVOm5Ig==
X-Received: by 2002:a05:6a00:a8c:b0:705:be21:f2be with SMTP id
 d2e1a72fcca58-70d3a8de550mr2646340b3a.18.1721712469456; 
 Mon, 22 Jul 2024 22:27:49 -0700 (PDT)
Received: from localhost ([203.220.44.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2004e09esm3274193b3a.107.2024.07.22.22.27.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 22:27:49 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jul 2024 15:27:43 +1000
Message-Id: <D2WO4QRM304Q.3K1R34TJVQH12@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v5 2/5] target/ppc: Add Power11 DD2.0 processor
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>
X-Mailer: aerc 0.18.0
References: <20240606121657.254308-1-adityag@linux.ibm.com>
 <20240606121657.254308-3-adityag@linux.ibm.com>
In-Reply-To: <20240606121657.254308-3-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

On Thu Jun 6, 2024 at 10:16 PM AEST, Aditya Gupta wrote:
> Add CPU target code to add support for new Power11 Processor.
>
> Power11 core is same as Power10, hence reuse functions defined for
> Power10.
>
> Cc: C=C3=A9dric Le Goater <clg@kaod.org>
> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> Cc: Fr=C3=A9d=C3=A9ric Barrat <fbarrat@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  target/ppc/compat.c     |  7 ++++++
>  target/ppc/cpu-models.c |  3 +++
>  target/ppc/cpu-models.h |  3 +++
>  target/ppc/cpu_init.c   | 54 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 67 insertions(+)
>
> diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> index ebef2cccecf3..12dd8ae290ca 100644
> --- a/target/ppc/compat.c
> +++ b/target/ppc/compat.c
> @@ -100,6 +100,13 @@ static const CompatInfo compat_table[] =3D {
>          .pcr_level =3D PCR_COMPAT_3_10,
>          .max_vthreads =3D 8,
>      },
> +    { /* POWER11, ISA3.10 */
> +        .name =3D "power11",
> +        .pvr =3D CPU_POWERPC_LOGICAL_3_10_PLUS,
> +        .pcr =3D PCR_COMPAT_3_10,
> +        .pcr_level =3D PCR_COMPAT_3_10,
> +        .max_vthreads =3D 8,
> +    },
>  };
> =20
>  static const CompatInfo *compat_by_pvr(uint32_t pvr)
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index f2301b43f78b..ece348178188 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -734,6 +734,8 @@
>                  "POWER9 v2.2")
>      POWERPC_DEF("power10_v2.0",  CPU_POWERPC_POWER10_DD20,           POW=
ER10,
>                  "POWER10 v2.0")
> +    POWERPC_DEF("power11_v2.0",  CPU_POWERPC_POWER11_DD20,           POW=
ER11,
> +                "POWER11_v2.0")
>  #endif /* defined (TARGET_PPC64) */
> =20
>  /***********************************************************************=
****/
> @@ -909,6 +911,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] =3D {
>      { "power8nvl", "power8nvl_v1.0" },
>      { "power9", "power9_v2.2" },
>      { "power10", "power10_v2.0" },
> +    { "power11", "power11_v2.0" },
>  #endif
> =20
>      /* Generic PowerPCs */
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index 0229ef3a9a5c..ef74e387b047 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -354,6 +354,8 @@ enum {
>      CPU_POWERPC_POWER10_BASE       =3D 0x00800000,
>      CPU_POWERPC_POWER10_DD1        =3D 0x00801100,
>      CPU_POWERPC_POWER10_DD20       =3D 0x00801200,
> +    CPU_POWERPC_POWER11_BASE       =3D 0x00820000,
> +    CPU_POWERPC_POWER11_DD20       =3D 0x00821200,
>      CPU_POWERPC_970_v22            =3D 0x00390202,
>      CPU_POWERPC_970FX_v10          =3D 0x00391100,
>      CPU_POWERPC_970FX_v20          =3D 0x003C0200,
> @@ -391,6 +393,7 @@ enum {
>      CPU_POWERPC_LOGICAL_2_07       =3D 0x0F000004,
>      CPU_POWERPC_LOGICAL_3_00       =3D 0x0F000005,
>      CPU_POWERPC_LOGICAL_3_10       =3D 0x0F000006,
> +    CPU_POWERPC_LOGICAL_3_10_PLUS  =3D 0x0F000007,

_PLUS (or POWER7P etc) was a model name itself and had different
PVR and maybe different features in some cases, which is a bit
different to the situation here. Could be confusing to call this
_PLUS, so I would just call it _3_10_P11, as annoying as it is.

Thanks,
Nick


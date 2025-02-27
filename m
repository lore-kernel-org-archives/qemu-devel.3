Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDDBC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 03:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnUFz-0000bV-Ln; Wed, 26 Feb 2025 22:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnUFq-0000an-Lc; Wed, 26 Feb 2025 22:08:06 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnUFp-0002Cy-1h; Wed, 26 Feb 2025 22:08:06 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22114b800f7so7884775ad.2; 
 Wed, 26 Feb 2025 19:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740625683; x=1741230483; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IIV42oP8l0Wwdn3on+P/n26WgFB86J/oQaQ2di0ESxo=;
 b=dt3tOs6nV7ZWvB2hNshA/SZQGIYcUw6ksXy1sjPjugqJVgJ8AQcTBDFiyEYaodsI25
 yoLz+jMmF+9mCXrry2niuToMwNw7csqhz3TAHW/PY1ZbWv2htACW/rR4uwgaZg4KfGrK
 kxdTqHQGKISFJoVEEErvRtrqJe06p3pomWu/HJxLSmlUsipHCEwtzVNGHb4QWwvvV7qs
 k2h8BM1UbSMwyUgC1fyFkpE8/eGLT7dwUh/SguWJK9okkTFKns/aqcGZzrIAntuNHieJ
 SGMIU2iKFYMEl6jUUAkCHWEN/F40HuCWXkuKdlEzWjIWiHC/J3C4lgnYdbggXW55tURf
 7Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740625683; x=1741230483;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IIV42oP8l0Wwdn3on+P/n26WgFB86J/oQaQ2di0ESxo=;
 b=YvxH11MLHKr3aZVgLV/OI59yYbzpluvrxZypWSywWnhtWSVEcSk/kWaJVoebCye5mY
 1jSDq4xW2EpkFpbeVfBxN5nX/Tnqc20BSexH1h9p9LnKuuO45wMvQwUmZ/GL37Kk/1qT
 RLM0xgj9ZkI51oOWtYa5O6qQRsfyu/kggUENz6pZL4z0al+d75ZkbwSe6rtAs3m/33Bb
 BpSi1glRoIB96VeYV0rT2mwaMJsSIUlTYiT37LI3MuhIp+l6rT9j2qtu8gVL4UqVeoBN
 YSmc7NwT68JLJgKGCsQfqi9WDv5OEv56WJZzMTOOMW5U51bt0veZVogvwaNQW7JVeRoV
 svvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4YmJ40lHw9WTgg6Bp1myB/9zA2ljmOM9whgC7sQVpNc55zvjvJNio4ZQUWGAyMbIq0gCM3vNnehc6@nongnu.org
X-Gm-Message-State: AOJu0YznaisXoHImeHoBaXCq7951y1DUElcVTPpGRD4dHiY9pwCV6Ufx
 x9na2QdrWkel6qqDw9ZiMvJQ+41ZzCVlrF1LC8D2un8CUJJr8+Ju
X-Gm-Gg: ASbGncsBuxt/Cry+2iDIStQiEOhbKrqpK2tb4Eb3FaVAdEiTJJwvHpWlQfnGKqmLWHk
 c20lXCVrg0rs35jKiIv+KV6AaWFbvc9APK0RfjZajmqCVn5sxsym4LNv7D2pnvwFq/1uR3DhCZO
 6gUUOuT6uP1cEFmHbmCD60ih4b8FrCvLrceqLjx0qfRuhhqs/nLaqU/TgwqIPko5Wcy2WmkWQgO
 T0CQvC2++Lioj11lbEPnKO97bHiAzEHQI216nDCYtljQZivhrJXHQArc6D13+WIXdN+dowYftir
 f9jEEYpLjJfZdFcxtQ==
X-Google-Smtp-Source: AGHT+IGQQnya9NtBmy4PlSl3LlEDzQbM47y+yi9Kuch5rXM/gN4dG7y+19owWCw6OXgvZvwVK2FiKw==
X-Received: by 2002:a05:6a00:b46:b0:732:288b:c049 with SMTP id
 d2e1a72fcca58-7348bd91343mr8517778b3a.1.1740625682791; 
 Wed, 26 Feb 2025 19:08:02 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7de38195sm303148a12.41.2025.02.26.19.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 19:08:02 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 13:07:56 +1000
Message-Id: <D82WB0T0PJ0H.3M2NGHZT4M9SW@gmail.com>
Subject: Re: [PATCH 1/6] hw/ppc: Implement skeleton code for fadump in PSeries
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 "Sourabh Jain" <sourabhjain@linux.ibm.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Hari Bathini" <hbathini@linux.ibm.com>
X-Mailer: aerc 0.19.0
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-2-adityag@linux.ibm.com>
In-Reply-To: <20250217071711.83735-2-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

On Mon Feb 17, 2025 at 5:17 PM AEST, Aditya Gupta wrote:
> Implement the handler for "ibm,configure-kernel-dump" rtas call in QEMU.
>
> Currently the handler just does basic checks and handles
> register/unregister/invalidate requests from kernel.
>
> Fadump will be enabled in a later patch.
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  hw/ppc/spapr_rtas.c    | 99 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h | 59 +++++++++++++++++++++++++
>  2 files changed, 158 insertions(+)
>
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index df2e837632aa..eebdf13b1552 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -341,6 +341,105 @@ static void rtas_ibm_set_system_parameter(PowerPCCP=
U *cpu,
>      rtas_st(rets, 0, ret);
>  }
> =20
> +struct fadump_metadata fadump_metadata;

Can this (and other globals added in other patches) come under
SpaprMachineState?

And could most of the fadump code and structures go under new
spapr_fadump.[ch] files?

> +
> +/* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
> +static __attribute((unused)) void rtas_configure_kernel_dump(PowerPCCPU =
*cpu,
> +                                   SpaprMachineState *spapr,
> +                                   uint32_t token, uint32_t nargs,
> +                                   target_ulong args,
> +                                   uint32_t nret, target_ulong rets)

I don't know about adding a new unused function like this, is there
a way to juggle patches around to add it when it's wired up?

> +{
> +    struct rtas_fadump_section_header header;
> +    target_ulong cmd =3D rtas_ld(args, 0);
> +    target_ulong fdm_addr =3D rtas_ld(args, 1);
> +    target_ulong fdm_size =3D rtas_ld(args, 2);
> +
> +    /* Number outputs has to be 1 */
> +    if (nret !=3D 1) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADUMP: ibm,configure-kernel-dump RTAS called with nret=
 !=3D 1.\n");
> +        return;
> +    }
> +
> +    /* Number inputs has to be 3 */
> +    if (nargs !=3D 3) {
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    switch (cmd) {
> +    case FADUMP_CMD_REGISTER:
> +        if (fadump_metadata.fadump_registered) {
> +            /* Fadump already registered */
> +            rtas_st(rets, 0, RTAS_OUT_DUMP_ALREADY_REGISTERED);
> +            return;
> +        }
> +
> +        if (fadump_metadata.fadump_dump_active =3D=3D 1) {
> +            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
> +            return;
> +        }
> +
> +        if (fdm_size < sizeof(struct rtas_fadump_section_header)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADUMP: Header size is invalid: %lu\n", fdm_size);
> +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +            return;
> +        }
> +
> +        /* XXX: Can we ensure fdm_addr points to a valid RMR-memory buff=
er ? */

RMR memory? There is spapr_rma_size() if that's what you need?

Thanks,
Nick


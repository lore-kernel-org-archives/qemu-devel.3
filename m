Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D47CF3D334
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyC7p-0002x2-3r; Thu, 05 Mar 2026 12:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyC7h-0002pY-MU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:04:29 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyC7g-00046s-7J
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:04:29 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64c97997b0fso5853063d50.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 09:04:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772730267; cv=none;
 d=google.com; s=arc-20240605;
 b=SX3mPQgdyBtNn7icG3s9qd6E0+M+Hdo7z3wJ7wBrSmtmiawAh0M+Tp9acl4OT0ved3
 J30q4rq725ICpOoQYvajCWXj5ZzpYIZyWr9XGi8XwnzuPT38QoPF2EofXdmvg3a1llGU
 2NDxBM7XtfVY1TTC3LP+2R8JkneBK0evQew530t3B77pKlLNyh96AAVB2CQC25J1MPSR
 D2t9xPO8BEIgmH4r1qWlUfLDoPwBDqHZs/1p/oIeApkU9+3IQSWDrPd4hvsSMuzWsAz6
 RQs5S/x+RQubnACGA9d+gG+C1b+XRjveIGrozZMptPlnZddVMll4aLM3SD+97uTLR8Sy
 5njQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hv85IgEfGdeoyWR5XCkNb/sEGHKtSEeLsLuRitt+GKg=;
 fh=MDrv/iGjC9/T09ari9rQP2ZSJsJ6DYXPSlFFpFTnTDk=;
 b=RtrxHm3g6XZFixvRRMzn6UJxCFxW3tMcAcOrQJbtmSg4v0Z2S8G+gBsV2gh1m5kMUF
 kHBNv+ccjr9JuY91tLsVm0h1v/8R135fUd09yzVQ9Cw6LZn3BFgJPJ2qqrEJ2kL88Whd
 PgSKOXphnX5HF3bUOF+dJP2jKmOPIB0nJonm7DUz/9BlG1/4pj4ABIk5NiWg/QjqoA9S
 ShSYj/coXDeNs3cZJqOgaBZ61PjEgpl5UbZcBF7WOGivWpXUbqNr4RKF4ayyHxfdk49N
 nLTwE27XFpGmuCaoGGwHDAinz2SJHMaQt+eHOo8E3GZdbR+4KOdmMMaJ8n3Wl/MMcKB8
 1eOQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772730267; x=1773335067; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hv85IgEfGdeoyWR5XCkNb/sEGHKtSEeLsLuRitt+GKg=;
 b=ePlGPTI8kIW9C2JGOYwfmt3YhTeOh/o0N3QBp1Tf8kYF+4zkUFOTQM3WxvEn3hXfed
 h5HQ9m0VbawJ7fDFstWSIlvTzMEvZtEaRqEJgvqQOMzUcB2WbjkAakPNYgp1UlZspFuL
 YmzCON8ArFu2iEfuLChATaIhTmyQ1yDgOWumq+gkG8hyfwOVTlicb9lEF8Hl+MosVk1/
 OiZmAqANa+/exolHw2l1TASkGTxOMjrYdt6NtIf/1OL103O4/HAbghN6yIairRj23iWy
 xxLiFnMoAIiMclzPnCaDHELByNQBP5BNqFm6ppHM7tSBSVx3vjwQSmPoQku8tNVVbnv4
 YOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772730267; x=1773335067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hv85IgEfGdeoyWR5XCkNb/sEGHKtSEeLsLuRitt+GKg=;
 b=UbZAQemNWWravgHm0vqc8XHMBvqVxzpgD+9e5jB2Xw32KxMV/MegwkEFxO809scXTc
 f29TVOYGqCC1RGG+hHVnU30zOalELsQHWxLhIhXnopqm3KuC47Xu7FvReYNAPVH7KpAK
 X4mY36BErbOgxtsaJKRVc4H1cfzsY9TgZVTqH2SSb5Oj4g/evhnqoGUb+/AloPqTrAVK
 N+fHDfRuS9tQGd4tRrrItuvyUoDIPA1dbhQyUD5zDzSEAwQLcBiNVV5f3iZUCSqWWPBg
 CfOfElyai+YFHvMoMerdWjpdfnJ7i+VSIm6Q/kYmcZWTeV7erGX7WXxvj4ELppIYbbto
 BUTA==
X-Gm-Message-State: AOJu0YzLfUOIisqIoi99pFHr7Qd0+6jiYsF0qFX/qxytcdBO0A587woh
 R4ubPsaT9E5+vxgksYnRg7x76zc7diljJvs1EBSZz+D8BVMRCf4+0UKYXkPvnuytYPG30Zlg22d
 WD2IQvZbjyUGPB3xe5p25MFFzCX0ErQcPdwPFLx99vQ==
X-Gm-Gg: ATEYQzygLliDgHQnwdlAdObjknjbTvgkFLf/KExgOIOpUBcEZthS8ueINDIlMEumwB9
 HB7c9juQTW5WPxZglDAc9z8zN4sBYADWyjQ1wul37rN+LkacJZac13ZX25egN2TTL7epN72EjMn
 WWlmvYopystNqDOZKpgDfIhdtuNhRDhAZ+Nd9NjzOmyCIAnMeGf3KLgoJOVhmsUDrXJxA6wfobs
 C0zdF//FTKbvRouqm7DbkYMjluUQJizRHQk5or2+/yLgidrAOFUW5OolkgQuH0/STMyv5FKAqNx
 NGhhxy7mulEhr1l9oKJ8MzS2zq28EYCl6SKHFS4t4gAIjvNT9Jp+jPHRjbfROzU4gGw=
X-Received: by 2002:a05:690e:b85:b0:641:f5bc:6960 with SMTP id
 956f58d0204a3-64cfa03fb0bmr5275443d50.76.1772730266605; Thu, 05 Mar 2026
 09:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20260305-nvme-v4-0-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
 <20260305-nvme-v4-1-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260305-nvme-v4-1-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 17:04:15 +0000
X-Gm-Features: AaiRm52kdCOvlsuM5wvCAZNmXG8zbTb-tLfLvbR9wVrhFKiVwMXr43DRgWQzsZc
Message-ID: <CAFEAcA-ShWATqHGyYi-a=Y_m7L3evBLH7JxSOgHXc+4Rm6DMDg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] contrib/elf2dmp: Grow PDB URL buffer
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 5 Mar 2026 at 06:18, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> The buffers used to construct a PDB URL overflow when the "age" property
> is greater than 0xf, so grow it. This also simplifies the logic of the
> URL construction to use one buffer instead of two to avoid the chore to
> synchronize the sizes of two buffers.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  contrib/elf2dmp/main.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> index d046a72ae67f..a62abadcc049 100644
> --- a/contrib/elf2dmp/main.c
> +++ b/contrib/elf2dmp/main.c
> @@ -494,18 +494,6 @@ static bool pe_check_pdb_name(uint64_t base, void *start_addr,
>      return !strcmp(pdb_name, PDB_NAME);
>  }
>
> -static void pe_get_pdb_symstore_hash(OMFSignatureRSDS *rsds, char *hash)
> -{
> -    sprintf(hash, "%.08x%.04x%.04x%.02x%.02x", rsds->guid.a, rsds->guid.b,
> -            rsds->guid.c, rsds->guid.d[0], rsds->guid.d[1]);
> -    hash += 20;
> -    for (unsigned int i = 0; i < 6; i++, hash += 2) {
> -        sprintf(hash, "%.02x", rsds->guid.e[i]);
> -    }
> -
> -    sprintf(hash, "%.01x", rsds->age);
> -}
> -
>  int main(int argc, char *argv[])
>  {
>      int err = 1;
> @@ -517,9 +505,7 @@ int main(int argc, char *argv[])
>      uint64_t KernBase;
>      void *nt_start_addr = NULL;
>      WinDumpHeader64 header;
> -    char pdb_hash[34];
> -    char pdb_url[] = SYM_URL_BASE PDB_NAME
> -        "/0123456789ABCDEF0123456789ABCDEFx/" PDB_NAME;
> +    g_autofree char *pdb_url = NULL;
>      struct pdb_reader pdb;
>      uint64_t KdDebuggerDataBlock;
>      KDDEBUGGER_DATA64 *kdbg;
> @@ -583,9 +569,21 @@ int main(int argc, char *argv[])
>      printf("KernBase = 0x%016"PRIx64", signature is \'%.2s\'\n", KernBase,
>              (char *)nt_start_addr);
>
> -    pe_get_pdb_symstore_hash(&rsds, pdb_hash);
> +    pdb_url = g_strdup_printf("%s"
> +                              "%.08x%.04x%.04x"
> +                              "%.02x%.02x"
> +                              "%.02x%.02x"
> +                              "%.02x%.02x"
> +                              "%.02x%.02x%.01x"
> +                              "%s",
> +                              SYM_URL_BASE PDB_NAME "/",
> +                              rsds.guid.a, rsds.guid.b, rsds.guid.c,
> +                              rsds.guid.d[0], rsds.guid.d[1],
> +                              rsds.guid.e[0], rsds.guid.e[1],
> +                              rsds.guid.e[2], rsds.guid.e[3],
> +                              rsds.guid.e[4], rsds.guid.e[5], rsds.age,
> +                              "/" PDB_NAME);

This is definitely better. I think it would be slightly
easier to read if we put the "/" characters in the
format string rather than string-concatenating them into
the arguments, but either way

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


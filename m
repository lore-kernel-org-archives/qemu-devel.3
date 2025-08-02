Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A52C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIpb-00012k-SI; Sat, 02 Aug 2025 16:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIku-0005Dk-8X
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:23:00 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIks-00036q-P2
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:22:59 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-708d90aa8f9so34728317b3.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166177; x=1754770977; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ItcsfCMRmBEWwhaHgua3JBaJlAop+gkvTw3ke8Ybe50=;
 b=gWMsf8bvjpeh8h2ryh6PLe5duHY6WSPLP092JyKqo9yhQMfpE/MAEPUXrI26DMVZKH
 pv/nkRatK2mnemuc2Po+2MZLMgZnpY32koJZzmS3QnbgrUKJuIW0D5c63oIU/Uf2Ox7B
 p/Z3I3AFQh1SWV4YxPPdJm479wbJMvkRBR5KVJIVP5+teXWVtv1v8wd32NzR/lvbwP8p
 irVuYo8ZaGewlsXFr+2YjgEBpii1dXrMyZvNCV32mlnWlEO6DfYxLuex0MVfO4Bn17cS
 FgG74Wdxl43nqW41rrSTONo61g7ZFqh8XZxW2VMj9XQz1u8uoPx3b/Ob6PBO591da/lV
 KfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166177; x=1754770977;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ItcsfCMRmBEWwhaHgua3JBaJlAop+gkvTw3ke8Ybe50=;
 b=k0COYePZNZHCAr0spb9WIWi8KDFGkFz6fFm1hdTZAn7VtMmWUA+xs6gSjCnwew5C2O
 FkYtOuf47FMRz/b6FR4hcIdYhRYID4945lTRAIb0TVjU6sg3fwnYl4/nCOPYo+ygW7rn
 p0CvbSg++9IgW0cTTsUBy92T4L1sGMWPZfSOkELrr77dDTUQVHXr0EtaC6nslxtTxvtb
 mxR/GrYyVdTEPk0mZCRpAl0AcZ+WZ+9UBr26VxbVOwhsvOZuVX/EdKsjc9endVDY5J/r
 Xj/rxS2RHDD7P3hsPq/7pJ2n3uwjNCriFKHcGoL9fGauPsRBybo/gpQzJoCBi1A+tO7N
 UdGA==
X-Gm-Message-State: AOJu0YwepcBRlHLitfz4duIYLK7aaWovJ+i/lyNcR8Hr15iv+wrwFPoI
 dSAhT10eA3SqyqByuXta7nWL8tv3gLSFzMyWyPkhOxh+R+UjX9979yvmEfmGJmG1rF9BM27t9mA
 23Laa4niBpHhRP3C+w0Jwb6ot6qIuFmkW/U1Sb2I4w3PrmG5A3GHoLtk=
X-Gm-Gg: ASbGnctVrXDAEj8taJYf3wm0DX9dRrj3ptEhnqLUq0SlbB4v9eqT2bkZ6w132HN2bEU
 LTOPWUxxKVaEMpafK19PouW8eQ4GDu8NDcH6YLoap4/qj5E+e8AKk70EC/p5xA2/mPbqWLzhlcl
 tUFtLJ14jBplT8ivo6Sm7faEA/Z1mw7150QaBRWlZXu8N4wCWna4OGyQsaXS8gxq7q1IZqEoDsQ
 scwNGLeXiXTRc6qElY=
X-Google-Smtp-Source: AGHT+IHiXTBdmVt7s4iQRS6K7yvsjtdjpD84bfO6wtKpKCVgZF1LOmhQRNbOzWY5PpZSw8Vqp7EOO/ec6z+DeIw2NzY=
X-Received: by 2002:a05:690c:f15:b0:710:e4c4:a92f with SMTP id
 00721157ae682-71b7ed12e19mr49972027b3.5.1754166177569; Sat, 02 Aug 2025
 13:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-63-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-63-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:22:46 +0100
X-Gm-Features: Ac12FXxgu0OJyFTP3dDiYhUYo5nrsOlsdvjR23BRnbVSHWeJxXrJxdwpcjOJZRU
Message-ID: <CAFEAcA9hXSfzRMuU=9qKC=rb53qtTTRZy1yxZQ=aHs6J1-mWhQ@mail.gmail.com>
Subject: Re: [PATCH 62/89] linux-user: Move ppc uabi/asm/elf.h workaround to
 osdep.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Wed, 30 Jul 2025 at 01:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move the workaround out of linux-user/elfload.c, so that
> we don't have to replicate it in many places.  Place it
> immediately after the include of <signal.h>, which draws
> in the relevant symbols.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/osdep.h | 8 ++++++++
>  linux-user/elfload.c | 7 -------
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 96fe51bc39..be3460b32f 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -133,6 +133,14 @@ QEMU_EXTERN_C int daemon(int, int);
>  #include <setjmp.h>
>  #include <signal.h>
>
> +/*
> + * Avoid conflict with linux/arch/powerpc/include/uapi/asm/elf.h, included
> + * from <asm/sigcontext.h>, but we might as well do this unconditionally.
> + */
> +#undef ELF_CLASS
> +#undef ELF_DATA
> +#undef ELF_ARCH
> +

This should allow us also to remove the hw/core/loader.c

#ifdef ELF_CLASS
#undef ELF_CLASS
#endif

(added in commit 3efa9a672e4a in 2009 with a commit message
and other PPC related changes suggesting it was for the same
ppc include problem).


> -#ifdef _ARCH_PPC64
> -#undef ARCH_DLINFO
> -#undef ELF_CLASS
> -#undef ELF_DATA
> -#undef ELF_ARCH
> -#endif

Your osdep.h change is missing ARCH_DLINFO -- did our uses of
that symbol get renamed to something else in an earlier patch?

thanks
-- PMM


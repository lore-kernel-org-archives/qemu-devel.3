Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00201C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 21:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXSbD-0004a7-7t; Tue, 06 Feb 2024 16:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXSb5-0004ZH-7s
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:03:15 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXSaq-0004Qv-4v
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:03:14 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33b1a51743fso4410089f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 13:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707253378; x=1707858178; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H17TVfeIh+El+u02BPhbrHQl9ooyTjYnGE2925J9mUk=;
 b=Gx6EjHYhR23YhbHlsi9uBFJawmCJfUhKtF9V1pUHChPq0ZdcC/GG/dGFzNQCYOUmz2
 JjX9I4GJqobf5P7WZuZpLkG23+gA1Tg1bW2DhRrBHmXDzY5IpzIVK8tDISmWj6LCST4v
 0/BcxPc0QpHGm25PFGSSEV5tIaFkhCMMyLfv/bRvQ23pjWtJlPQH0RLH3SI3/MzPxYv3
 Oha/HuLA+d9LNUic3joOEv7U362etTa7nyuLDaqdTVoKKIGKVa0XLmr6AdEwj3YefMKz
 23A0BQyMZBfUv7d6aqbD03Eb8fw0bsbtPO3AdhKkO+mxGXZwBgo/Mxteutn3XIHFTVIo
 vZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707253378; x=1707858178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H17TVfeIh+El+u02BPhbrHQl9ooyTjYnGE2925J9mUk=;
 b=uqdItYlK2a84RHmmoQ2sKvTnhV8bgwECjr2QGdOfUTJLy9bQwehIWhmZdS0nRAFlcr
 CnfopQPg3pPLEk9HFU8NAoWxMvXg5Sb+6jq6GjgMzB1gTg0dgDxeYSy3wPAL2i7aYEei
 LHsSvaVwWNUx+sz16J0g9HO2qZKeI8AbaKBpfH9xU0+kH3y9Xw7pRUnXajOA4/VztGQL
 G29zb80Tf/d3N25gKDm6nr77DLCKBGLjlCX/bApYSZ9ur72y6qvAdemWLEnte2jHtXmm
 TJ2n9DUWwbfwZLESI0VZ8l4+4b3YBVpwqdD4tVEtfexGWs/RgZj12e5AlNAJT1jYNLV3
 6Tbg==
X-Gm-Message-State: AOJu0Yzze4xNbhAgu6gy5CKbDH6i/PYYnTdPL5y6lDt9vhRohj64oHgZ
 aQJYxcangJm49MrC6Q8jph5qmkDO1YAFxR9qiWzPWrQlkGCa2pDU7f0MdzHdTzUBgXl2J52Zqir
 c9rrQmhWMwejF2BDO/Knkx2WdUlGJzQKuiXNAjw==
X-Google-Smtp-Source: AGHT+IHuFQD31iv4dXTT9gK5TI55kq78J92ej+XoNHGc6q30AlmwLVja5nwPCNbHKyPNbi3liI8ZnbFIy9m+O2bakeg=
X-Received: by 2002:adf:ce0f:0:b0:33b:21e4:68d5 with SMTP id
 p15-20020adfce0f000000b0033b21e468d5mr2123308wrn.34.1707253378414; Tue, 06
 Feb 2024 13:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-3-peter.maydell@linaro.org>
 <668729ae-4305-4a6d-9f95-c92fea6cfcbd@linaro.org>
In-Reply-To: <668729ae-4305-4a6d-9f95-c92fea6cfcbd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2024 21:02:47 +0000
Message-ID: <CAFEAcA91D1n=3q9GoY1TxQOq7q6h1-88H+qka6MhNnUuRrkpRQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] target/arm: The Cortex-R52 has a read-only CBAR
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 6 Feb 2024 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/6/24 23:29, Peter Maydell wrote:
> > The Cortex-R52 implements the Configuration Base Address Register
> > (CBAR), as a read-only register.  Add ARM_FEATURE_CBAR_RO to this CPU
> > type, so that our implementation provides the register and the
> > associated qdev property.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/tcg/cpu32.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> > index 11253051156..311d654cdce 100644
> > --- a/target/arm/tcg/cpu32.c
> > +++ b/target/arm/tcg/cpu32.c
> > @@ -809,6 +809,7 @@ static void cortex_r52_initfn(Object *obj)
> >       set_feature(&cpu->env, ARM_FEATURE_PMSA);
> >       set_feature(&cpu->env, ARM_FEATURE_NEON);
> >       set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
> > +    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> I just noticed that arm_cpu_post_init can be simplified to not check CBAR_RO, now that we
> have arm_cpu_propagate_feature_implications.

The other bit of CBAR cleanup I have is that cortex-a55, cortex-a76,
neoverse-n1, neoverse-v1, neoverse-v2 and cortex-a710 have all
cut-n-pasted the line that sets ARM_FEATURE_CBAR_RO, but none
of them actually have a CBAR according to their TRM. The only
reason I didn't throw in a patch fixing that is that I think
it would be a migration compat break and I didn't feel like
it was worth the effort to try to deal with that...

-- PMM


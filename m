Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCBBD40D08
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8TEb-0002xW-SF; Tue, 05 Nov 2024 18:45:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8TEZ-0002xF-1k
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:45:15 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8TEX-0000Iq-F8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:45:14 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-851f5d3001fso2260370241.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 15:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730850312; x=1731455112; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/COjlK4C5NcmORPwqDy3zA62UO/EyTEZApeGrPdzXc=;
 b=cYDUAVOc0RyyqBnp4PLayOnKwYbH8RDgBeiMrSkTz8DX9voG94J9FPbTzT0nB7isB1
 /TPmUfcPdo6SlKsWdK/HDwI+eB07I1KLM8ej2M4+8pDMqGs4QPBghyo5O7a1JSs6Al4D
 XxKvvQGitHEw+P1IOLYFtMEcDbjj+FnqhpMPRpkGrb34yWf7ze/63EM2mwRqPX2KU9F3
 7hnHe0IqyylbCWnWgR9eXcXo44wDPqblM4pqjUFPsS4wrGiIh9FIO8Pxepdx/DX6652C
 Szg+473i8i/0l9wvDnDLp82luUmLERpVySw9soQKQpE9Tdk8HmWTG+zZOSkYuX8Bv88I
 QlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730850312; x=1731455112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/COjlK4C5NcmORPwqDy3zA62UO/EyTEZApeGrPdzXc=;
 b=Npo4yjNAIjLvDPzTreSFgHJgrSFJHhdPqupG4jve0dr2T0vhZgLN0/VMDfpOEK2zN/
 Zu0YOjqAYb3LSPuI2PtZZutgkgP6Crt3ur0U/BM2lYKOLe7p8VXvDIisvKkFIriUWX3d
 eV0EdO8p9TbjPC44YHkJFwgR4XxS5OyrJ8Y7/cBqaYfyFwOHM7G/OYSt0/t7oElpE1aP
 +YAaS7R41zi5nvNwXNM4C+ipMKn9ePITjCvPR9xmam9OKuHNCbfeH/VsXQWBhVkEDrHt
 ReqUDBx5vIxb9KIwZ2C1dA0p7BbS/fDtMD3nM4pVyjYrIzbEBJ7h5c0Ia9h1Bk+hPd1n
 iccQ==
X-Gm-Message-State: AOJu0YxPAhA9yO9wI1UsW2esqWnCDgxs1a8IImnqh11mncY4mNKcIRbo
 b/A/TocvK9ytEdWsCE/gyanbGkFJ0op6VzpQybLkNFxV5EbiXIu79sUe89Vz2DpJVEGBRVSDni0
 wIZuus94uIs0qURNbu1c2ZbVDYiY=
X-Google-Smtp-Source: AGHT+IGK9P7qO0xSb45tmhwAQXFJEIUIRhjClsz38nocHgIULgx4DJSitXp0BzRFZi6klAL/X1SvFBhZ+6SeLc2KuWk=
X-Received: by 2002:a05:6102:510d:b0:4a5:bff5:4ee0 with SMTP id
 ada2fe7eead31-4a900e4263emr25609401137.7.1730850312111; Tue, 05 Nov 2024
 15:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20241031035319.731906-1-alistair.francis@wdc.com>
 <20241031035319.731906-5-alistair.francis@wdc.com>
 <a0b8d4f8-7d99-409f-b673-89c92ba62e48@tls.msk.ru>
In-Reply-To: <a0b8d4f8-7d99-409f-b673-89c92ba62e48@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Nov 2024 09:44:46 +1000
Message-ID: <CAKmqyKNSx1Ku_axahXyGUUn1aYEBsaypy4KpN9us+qWbG2rL-g@mail.gmail.com>
Subject: Re: [PULL 04/50] target/riscv: Correct SXL return value for RV32 in
 RV64 QEMU
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Nov 5, 2024 at 5:27=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> 31.10.2024 06:52, Alistair Francis wrote:
> > From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> ...
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 1619c3acb6..a63a29744c 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -709,8 +709,11 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState=
 *env)
> >   #ifdef CONFIG_USER_ONLY
> >       return env->misa_mxl;
> >   #else
> > -    return get_field(env->mstatus, MSTATUS64_SXL);
> > +    if (env->misa_mxl !=3D MXL_RV32) {
> > +        return get_field(env->mstatus, MSTATUS64_SXL);
> > +    }
> >   #endif
> > +    return MXL_RV32;
> >   }
>
> Shouldn't this last new 'return' be within the #else..#endif block?

It's currently functionally correct, but I see your point.

> The way it is now, the whole thing is quite confusing due to the
> other return in the #ifdef..#else block :)
>
> I'll send a trivial patch "fixing" this confusion if no one objects,
> or anyone else can do that.

No objections here :)

Alistair

>
> Thanks,
>
> /mjt


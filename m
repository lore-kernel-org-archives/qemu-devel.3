Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D438EC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIyF-0008CS-TA; Sat, 02 Aug 2025 16:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIwQ-000514-SE
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:34:54 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIwP-0004na-DD
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:34:54 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-71a379cecd5so17695747b3.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166892; x=1754771692; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=67XVY0usCrggDaNjQFh6OaTJ2pj0QnezuE1IEbW3vXs=;
 b=HrtyzRSdKtUcN1iSBKyQT5Bbg3Oe9JnltkIfYeurtVP5EHWkGzek35NHVwFzhFkAo7
 Y2gWsBaGO2vfIcEDH8fozlBV8wgeV5wkiQStz/+DshnZOqrpgqXQLsafsKiaYihRk+Y/
 /xf96a3S/al6wm2xkGu2G1zXwzxUrpYJrypo7d2Cgyg076Du6M9A5/OTYV3D//aJTY5j
 6ofK1KhljbznlUEu5Gru6fQChy32ru8k4Hwub1iVdEo8c0q/xgYurWgn/FK0+MArI2Bt
 X61m/briQtr2G9E0qR371rLrjkfOoff0ccfXc5otc404Vc1TqpC8dknfH0GufaOzm7YQ
 HrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166892; x=1754771692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=67XVY0usCrggDaNjQFh6OaTJ2pj0QnezuE1IEbW3vXs=;
 b=b5JJ2bORfiVbmPIgA/vGN2fnPJ/imeKakxqK6vNwOdXiNGFsZcsQL/m01f8t4tcUa6
 1lLft/8ZqLTRDQVisSQIR4DCE38LU4TsfcdOT1rszK+gE8i8WD/QIpYrQx/feQZYd+W/
 qgXRhKfrP8atLXi9l3PI2YVSOa550XRAqux/Y1UI+LTtXxlHpKUJPG5AkBgJ+sQLe5Ri
 V2ZxLAKxznNqc0wnTvy8p/iEuV5EaB+U+c0zparShwcaeLDTLuGH1rGFrQwKzp9rFMAb
 nPqupuB9hLfqvk3DQkLcPYjRgrD3qOIhxE0kEzAWHVWdvxW1sD95BZ4jujx2gWXrHe0c
 oRbA==
X-Gm-Message-State: AOJu0YxV//x4R8yV50hi8NghaqZaJZe6gPCe2KZUtntADfPgxBOydnPl
 Q0MsA6Xh1Lvu8LoayDTkrMpvW8ROPbhN8OFF8nQbdW6eT3MkcOpajzQAcnQs/AcHwFjOOyqyF84
 nhfb9yjtcoVleacMlnLVyw5opNAPtVvi4/JZj8vQ3hw==
X-Gm-Gg: ASbGncsmANz4Z3SuH+n0w2bhb72KNzAZylCgxDVch3P96ArLXrHMM0YrO0lB0yd8GyX
 Ey5klV54K+RU0sZK3vQ8/H2vcxni/kj5fj4iBG2q7ZMkuWFveD1RMWgozxcSRsi9bFkWEWMgFoC
 I+VOEzq4nqVRd+zvZgak7Uk7uEr/2f1hauGV81180zyfWVCAsuFYMR1W427NuNMMZbGbsxC8SsA
 ddTsDqczrR17e/maT0=
X-Google-Smtp-Source: AGHT+IH+vHhewiwqRKDnm5NY9rxtfj4Q781vg1DgHWAjpRbs6u4QXsDPBh7O4gRhz/s2w9JlY+VEMBJ/eNQLMGvH2N4=
X-Received: by 2002:a05:690c:7108:b0:71b:8cc6:6d41 with SMTP id
 00721157ae682-71b8cc66fecmr27558017b3.17.1754166892346; Sat, 02 Aug 2025
 13:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-80-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-80-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:34:41 +0100
X-Gm-Features: Ac12FXyIEZ1uzTHmaEWHvoGxqixvpsn3DY1jcC7NXALOCziPGFds8jBRv6GNFIM
Message-ID: <CAFEAcA_Su8VVz41FhLELbCca06nhy54x6017GDYsgUA-ha2prw@mail.gmail.com>
Subject: Re: [PATCH 79/89] linux-user: Standardize on ELF_MACHINE not ELF_ARCH
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Wed, 30 Jul 2025 at 01:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> PowerPC was the one outlier that defined both ELF_ARCH and
> ELF_MACHINE; ELF_ARCH was defined incorrectly, necessitating
> the definition of elf_check_arch.
>
> However, the elf file header field in question is called
> e_machine, so ELF_MACHINE is in fact the better name.
>
> Mechanically change most target/target_elf.h files,
> then adjust ppc/target_elf.h manually.
>
> Do not provide a default for ELF_MACHINE.
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


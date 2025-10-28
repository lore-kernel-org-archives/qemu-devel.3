Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6003CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhtv-00047F-8C; Tue, 28 Oct 2025 07:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDhtl-00042y-GX
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:30:01 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDhth-0003m7-4J
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:29:57 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-63e35e48a25so6038746d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761650989; x=1762255789; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SaBayW4KONq8CYUoOu1AyRovaWldoaExgXYlkxxcPMo=;
 b=YENP29JCiIUL+ccIZksZ11QByfzEb0evOg76acEWHIr61QXIp4ZHRk63Xl+vHboynN
 tVIcZye65oU43rMOTo1LLTF8xiCLkemb2fYKSAvZx0zkC9MkSuspajwR1f8SWEqeiOQl
 JoMvdq8x+fbXDkc0SArD157yRqoLvdx+bkYw+JoDXzd0eseo9ftAeuiDIGLRi3oWKjPU
 OUJwk0fo6uMdhNSj8zXpidGfW9gCQSw0SrzocRIaToigCBvslTFaAFmqfuc17li4cum0
 a+k56TeOcCuo5cb6FihNYQcBzAk8gsFC8/f8Fwa31tzVlh6ZYkk3m0z7jPxdj2KhtrRr
 GsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761650989; x=1762255789;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SaBayW4KONq8CYUoOu1AyRovaWldoaExgXYlkxxcPMo=;
 b=XEHSn8IZ5ICTEhoOOewiesHYh6jRoA39433hgMTaxdUeO52Y9jD1uORBoo1xIHndaw
 8Vg/2Lm/ZsMIY6boM0oj86qthtFQ1ALcf1MV2MZhUA0ptSREqDnVh2B9zHF5ahhtGwNM
 x6sg0qmBc79RsE79kOd8Cb6ekqrLEW4eWh/xuZ4ChXdGj4ll+G7MSUYZs6R3mr+VEhXT
 lPtWJ2xdiIY1k+XPvnPdVnhYci2NqxEkNu8gn4tZRn6D2NrJIJMA7kYhpgAsgRupOVVt
 qIIfcm5Hcpp2e1nrQyuLCX/EnMgtHTyA/6xfB0x8YhQwN74M9FuUcg/T9JybiyRrobcC
 /KIA==
X-Gm-Message-State: AOJu0YwqYixJgE8iJK8Dazkce10ghiaqsBEuk+QsGx9fWwVAq+07fzb8
 MybXicp0y6uyMBCLcvFw+f2qpOjh9ErO8LT7RLJ1JGIa9XhA6Ls6a6nRckKvIC4RBUC1VVdTx6Q
 34oKY8WcMXeITwjh4f9gBcHcSn+yRKGZO8tfp7vflPA==
X-Gm-Gg: ASbGnctaum1HNSNNbJEOr29WEdC0txNILplR9JQCy4qANatCA7gpGiI86VYjn2K0Def
 jrP5Sx3BiUkiSb8rOPsrqFKf9moK4imKvvpwKzns9fH3We4rdzzIBNaEyfmr6U0YRSiouwRlhFB
 VJxxI/LRiySBV8N2O+sH94l9Yq1XZ5q1pD6xq2ukv4Iz6QBf4imwIiXJlJf9YTcJmdi7bCaDs87
 5NOFT/yT2sGL6k9n+vbSrESwTChIPRyZTQLoQibeF+uD+NYzFbkrX/QesGH+Z9RA63sfJ0o
X-Google-Smtp-Source: AGHT+IFNpmH2i+8gBelWzPJAeciZgxXUN7gk4SRabDUG1jmAhjauZIRm866bbhJ8V/JO9wCbwX39LW8+n//EhEJUdGM=
X-Received: by 2002:a05:690e:c4a:b0:636:15d5:aae5 with SMTP id
 956f58d0204a3-63f6b9473d7mr2878669d50.10.1761650988052; Tue, 28 Oct 2025
 04:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-35-philmd@linaro.org>
In-Reply-To: <20251028054238.14949-35-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 11:29:35 +0000
X-Gm-Features: AWmQ_blxxZ3gWaPxQMNnD6TbCUe_VI-t6L5mI1hjUFPPJ7QiZLDX4MHfzlsbKWM
Message-ID: <CAFEAcA9iTnb2hfXV1OwXiRUVaTtX+VqXdF=PyKDgqkTqQgt+Ng@mail.gmail.com>
Subject: Re: [PATCH v3 34/59] target/i386/hvf: Use hvf_unprotect_page
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>, 
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 28 Oct 2025 at 06:06, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> From: Richard Henderson <richard.henderson@linaro.org>
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/i386/hvf/hvf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index c0b2352b988..1e92e9b707b 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -139,8 +139,8 @@ static bool ept_emulation_fault(hvf_slot *slot, uint6=
4_t gpa, uint64_t ept_qual)
>          if (slot->flags & HVF_SLOT_LOG) {
>              uint64_t dirty_page_start =3D gpa & qemu_real_host_page_mask=
();
>              memory_region_set_dirty(slot->region, gpa - slot->start, 1);
> -            hv_vm_protect(dirty_page_start, qemu_real_host_page_size(),
> -                          HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_E=
XEC);
> +            hvf_unprotect_dirty_range(dirty_page_start,
> +                                      qemu_real_host_page_size());
>          }
>      }

Subject says hvf_unprotect_page, code uses hvf_unprotect_dirty_range.

I assume we can just fix the Subject.

-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2A2C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 14:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFaQ8-0005Os-JM; Fri, 07 Jun 2024 10:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFaQ6-0005OF-K1
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:18:18 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFaQ3-0007TO-Ts
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:18:18 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2e95a75a90eso23163211fa.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717769893; x=1718374693; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h7oRD/YPnW1o+2UOYzoV3Mdb3wXEMA9wej+6rHN0M34=;
 b=VVuEca6Za/nC1ngbvBn4o14I2v5jhlSS0dxTXfCZTl8fUNdXDhR5PU4eXtXC3vf7yP
 5HeRFE3rfCOqhkZm/iIQ7uH0mSGK7yTE6t2/H8L2FeFMcytIKAYj7N26SfHB59V27LRO
 Sc/SquE+9C6S0mQ4GCJ/NM/Nt07dZhZsDGIQ2et5WX0diY+kAwW7ulEyZjC9sVcoWzSR
 oHodhVlIHA/9YwkoluoLrC+1N4QqEYTAOx30AdNGEcAD/AcZozlJQCJWEhDYyIkoKfkD
 t6mjsEhNLamYdXa2tEJ7y/dkgZeVDOXJBUbCZF5SFD5I7EvnSHTOE+BsH0T/oZtEwRMT
 KI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717769893; x=1718374693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h7oRD/YPnW1o+2UOYzoV3Mdb3wXEMA9wej+6rHN0M34=;
 b=KD/Rw2p8x5OM0EROimKbPj6Pr/64syMSnEr8L33ZBBcB1qcfTObiBi7cwuV0lhrdPa
 UjJO3gUPqgAd9FY8lIgSBMoXvV9oUHQIMt1CXK6tHO5sL/TJMKBI3g1CtQ8ow9RtaJnB
 GYZpIWrPT2NaIGmfuJZuLF76pWJkizwxoarP9j90P0ThKAmFcb9LeMKsVgwLNCsK9K/H
 G9cLqsIrv6swduYEtaGk2gbnXeCHu7d78A0AXlNUNjKGuuSioD7aPP+N3n2Zk88uTWaY
 ow2uJyjBXVwSicvsGlD6v6hGmYkPzjMYgkDwBb7YcB+M7XmTXjJ40YPiDnxKUb1Dthng
 4atA==
X-Gm-Message-State: AOJu0Yy3BNyfQKCY+1pn1TooNJvSBh1e50IhZqvCCf+JGiWGT7vDg6Ez
 D3Kn1xOfGMBF2kP/MM+X2JQMIuZgOCQoNGHnOBlnkwvTvO+x5VSMS5kdgqLfMKNPpj2VHEZT8wE
 eCgXiA9BTgXyD0UuZGYeWo4z572ZQJ+8hHJ9Xg4cy9knQvA1N
X-Google-Smtp-Source: AGHT+IEJSNbcFAJMzs6nc9bK7jOM8qUlJxVSvcQo0pN3EYKRCvdD5wcnP4bwY54PBWp9Nu9KrrAqrOIZ3og43tqMd0o=
X-Received: by 2002:a05:651c:1502:b0:2ea:83e6:d5e with SMTP id
 38308e7fff4ca-2eadce37a72mr20761551fa.26.1717769893283; Fri, 07 Jun 2024
 07:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240604064409.957105-1-pbonzini@redhat.com>
 <20240604064409.957105-37-pbonzini@redhat.com>
In-Reply-To: <20240604064409.957105-37-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2024 15:18:02 +0100
Message-ID: <CAFEAcA9Y5qTseBFY=QoM_Cin2xHy2Y=81k-nv=fbEGKEofcdnw@mail.gmail.com>
Subject: Re: [PULL 36/45] i386/sev: Invoke launch_updata_data() for SEV class
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pankaj.gupta@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 4 Jun 2024 at 07:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Add launch_update_data() in SevCommonStateClass and
> invoke as sev_launch_update_data() for SEV object.
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
> Message-ID: <20240530111643.1091816-26-pankaj.gupta@amd.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi; Coverity points out an issue in this code (CID 1546886):

>  sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
>  {
>      SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> +    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);

SEV_COMMON_GET_CLASS() dereferences the pointer it is passed,
so it isn't valid to pass it a NULL pointer...

>
>      if (!sev_common) {
>          return 0;

...but we don't do the "return failure if passed NULL" until after
we've dereferenced sev_common.

The get-the-class-pointer operation should be done after this
check, I think.

thanks
-- PMM


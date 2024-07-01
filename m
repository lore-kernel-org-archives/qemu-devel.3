Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7328DC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOFWw-0000oS-6P; Mon, 01 Jul 2024 07:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOFWi-0000n6-KB
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:49:02 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOFWa-0000Yq-Oy
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:48:55 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57d4ee2aaabso161255a12.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719834524; x=1720439324; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QiWhYMtp+5dTmuBml+i14w899+CzD2aZHw55I3s3Tw=;
 b=teDsXnwMXKR8nucqoQSEXM57uDaZoY4q+E0He/3L8Tr/93STOwCEYuGPxrpTal9K14
 e3usC3VWRfYPDfIpmx39OtnkEmLYEnZyzyZvhWusoEmDYijrZMAaE/nethSOg6YKY1/d
 yBmvdEqgkdnzTfv4blCRfwkoizkwXqPFSLrPjAcEsYnwgwZollHuJ6rk6HijfYu1Kjff
 aCxkTbPBFvL0XmKdh6lHCggUesM49xnOfHo548aNrzs9NkLabxCIh749HGxXfn7zdvJn
 ryD9h7c/XnlbanCGjFu3rfEANhhuWkc4RO/g8VFLJBHIngcGxJfa2zKyYHdecWiiXXtw
 CWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719834524; x=1720439324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9QiWhYMtp+5dTmuBml+i14w899+CzD2aZHw55I3s3Tw=;
 b=EXxXn5GtJs9CNWR6TEBR11KJp34X4Zur+/Ijwf7SerVE0O7gtX3388EwEMWKirACww
 yNSG7RZQahEMyfawRxg2E0uKwArcVNt55wKxJb0uYxNVNPO6sUNoQpvcbyEGiQfUsEPj
 uaK1D4dYceaAz1JpFZ3IMuYywRs7R+cXsxsEVjowNXoJyuvsDNvoZYLuKjqzCdeOkmQU
 YllYsRz0X/zE86F5jRn56Z/EZ7wWze1MhWPWTi1n5dLql+plcaiQnbajo25pkTYaiYwO
 jBcRI9GvqOcx45t3svyxf2K3r9VUO8Rl0+lO7UEiJ+WuwXFDNGgrcPTaZVtzylGVEvyM
 oLOw==
X-Gm-Message-State: AOJu0Yz3U7r0ISqVBnb0NFP+0ETV14IjD1fzC90oxg0FKNq31XXKR8Y4
 J+VcSIA/tn3U8sduzHzGQewLjtJWNloXnfkbvapjYWZVxao3Zzpse2hrFRZ7YF3D/Yj+Cx8F4OM
 9WrLAbm5tI1FAS6FvEvGF0Off+PPbMjaVRQspfA==
X-Google-Smtp-Source: AGHT+IEiauFISnr7j84NDK6TOEuwPWbLjfSSBiJ1FtDkD22tImU6LRD3wXrjR8zQbQelqpAZ3xze4FmLXIiCYEJe+n0=
X-Received: by 2002:a05:6402:190c:b0:57d:57c:ce99 with SMTP id
 4fb4d7f45d1cf-5879f0cbebbmr4146568a12.2.1719834523957; Mon, 01 Jul 2024
 04:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240629110800.539969-1-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240629110800.539969-1-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 12:48:33 +0100
Message-ID: <CAFEAcA8FoAOv+nbCOWxZT5Mn0FHOwPZ_YHKHrhEYFEhXh-C7OA@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/misc: Fix STM32L4x5 EXTI interrupts
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Sat, 29 Jun 2024 at 12:08, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> STM32L4x5 EXTI was incorrectly expecting alternating interrupts.
> This patch adds a new field to track IRQ levels to actually
> *detect* edges.
> It also corrects existing QTests which were modifying the IRQ lines'
> levels.
>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>



Applied to target-arm.next, thanks.

-- PMM


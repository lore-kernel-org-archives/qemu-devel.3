Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D81C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 17:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZDL3-0001uu-OE; Wed, 31 Jul 2024 13:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1sZDL1-0001tS-TU
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 13:42:11 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1sZDL0-0005Wu-FZ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 13:42:11 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2cfd1b25aaaso1402986a91.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722447729; x=1723052529; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDBWqt0vVl8Oz4H/eG2HEFrOSA+R5dAusbhFBjlvK8g=;
 b=gw7nIiTtyMNEVlEJ04i6/QDmMMLmI4PdknXxCD43ZQD82DbYY7aCqs2gSZMZoSoivX
 yGVqREvsTIoBUCm/uLA6fqo7mmi9qBmpEShifJTbGgzJ4t9SWnngCqQgTCiF+7qCDynj
 C8Xty2RZNZpizDkP7lHPlM2jR12qzVYDh9vuWvientLcNlDAYuL0nFUdADedG7ObhrT3
 2Fjlu8PucFhjkxYlQrbz3JL7bHGrnH0LfPGsfNVSn53ZTz3IvkFmj7qBbF2ytytSUUIy
 3hWrAeT0n4cmV12Ec5o1bDEFZHnJcNO3XZSpPEesXG+E9DOkl4vyfZ6xU83qn76HN+uv
 VTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722447729; x=1723052529;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDBWqt0vVl8Oz4H/eG2HEFrOSA+R5dAusbhFBjlvK8g=;
 b=d4IhnOza+m0sBynWWdLODK2y/Tt4n9NWDC5QcQelAuOD/ajrpH9c9VaulViXbDMxfY
 WHvoj4Uqzs0nziCr+F54L89Xj1mkoEcOBHVspx4pH1BnoOIhKf6xJlXl1JS5boTAbotf
 IlngWZQRApJL9J3Ahqv9tc8T78Og846NdYzG0hEKQs3nqg2y/MHa4sqBBNmlpFJwUEWH
 xbMGY2xU0IfBHYUXZXzv1C5jRGWtJdFaQgHEU8L/RKXvMHO2xbAm3qsbIcqXjohAxSUA
 5U74PuuFE+S0IU3jp51x53LjZL6sNkU2zMnQ+q/ifxCIklPA1D9//mLstRpQbD5X/dDZ
 u/dw==
X-Gm-Message-State: AOJu0YwWQYAY/bH4jyhzgyNm4GCdVQ91Vta6/ouRG4u/vulDvev2B2pv
 /xc9Tli5t8l7/9kHNc+BBrqNq/oVkWxdf8xzt7tFfthk8Kl/E8jWhtn0+QmBiqpHRkUKkMzGY1w
 mWhKZ+rswBrx/nBmUKeKQ6/GHkmg=
X-Google-Smtp-Source: AGHT+IHO+7oXSo8sBPdMVayuCdXgPg9R2AVALQzN6ku3794snT6Wwak5wrQOWM5lS54fyQ/MQdwHzOPfjCZFyQqZrDc=
X-Received: by 2002:a17:90a:3ec4:b0:2cb:4e14:fd5d with SMTP id
 98e67ed59e1d1-2cfe7886018mr49735a91.17.1722447728530; Wed, 31 Jul 2024
 10:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240731172246.3682311-1-peter.maydell@linaro.org>
In-Reply-To: <20240731172246.3682311-1-peter.maydell@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 31 Jul 2024 10:41:57 -0700
Message-ID: <CAMo8Bf+B-B_jPJAOLzL_Cb45W+g6k+=oUJPsPjGmQ3Q57LQz1A@mail.gmail.com>
Subject: Re: [PATCH] target/xtensa: Correct assert condition in
 handle_interrupt()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
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

On Wed, Jul 31, 2024 at 10:22=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> In commit ad18376b90c8101 we added an assert that the level value was
> in-bounds for the array we're about to index into.  However, the
> assert condition is wrong -- env->config->interrupt_vector is an
> array of uint32_t, so we should bounds check the index against
> ARRAY_SIZE(...), not against sizeof().
>
> Resolves: Coverity CID 1507131
> Fixes: ad18376b90c8101 ("target/xtensa: Assert that interrupt level is wi=
thin bounds")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Spotted because Coverity (correctly) thought the issue was still
> outstanding.
> ---
>  target/xtensa/exc_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max


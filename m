Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4D2C02195
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 15:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tey0q-0006kI-5q; Mon, 03 Feb 2025 10:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tey0o-0006jk-4T
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 10:05:22 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tey0m-0004y1-FB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 10:05:21 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e46ac799015so4298690276.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 07:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738595118; x=1739199918; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVXkE69ZSFKoAYdDsoCLmLnjfkJC0UwvVD2SPxozagY=;
 b=CzB415HFCQ9afbwwZYXaaL61/0zYCwrf4Qph/74WtgzA6gExB5C+ZxJTVZZ5zOH2fD
 rjHrquPT2/wMfsuRyxqOOlCS5RMp+1wL/EipgQpkN234Kb0twHprFa+qgkl5JvxVQ4u3
 Kk2wUnZ4Dy5XQnkpeMZ24BReVYwsIgf7TuZc6mkbjiPN1Rst2gzbKSYY9mD7WaYIoVyd
 z4X43TvqgnDTRYNzyds1VezSfKx7w+H5ck2FL79CMwWs5kdQz5cOiqv7jmT/vvxQejcs
 C2tDtezzuIgYZ9k78x0T58dwAFJFPhyC36EVmPXZ1DSDRMS9LQyzSyK6rTj+0qJhbZql
 VmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738595118; x=1739199918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVXkE69ZSFKoAYdDsoCLmLnjfkJC0UwvVD2SPxozagY=;
 b=N9iYZiVxvNTH1YZ4AP5y9olLwvrOveS/UkxJ+er05PMfx0jR5ExU7ZzVWfW3PdfMzL
 pCeV1jjPbXifXbmY3akdqDdwy9QX1uKvWKCiJiYzW3eql6AuhGnSOeUmfe0Vk2/cRJTY
 ovU/mdkA6a87eXHcwOThmC7sR8LQs5cly22gqlEODrxUOyAKOBu3lbnbokhO142C4hW1
 t50/yRl8yqnkcWu2HgzKfWuxziDTnX1T8obPkrTQFJuktXh/w1m4vavtgCANgNOGjQG2
 LeU7wXxKo9MpmGu14CggMbwiJvgfaR9vqEH+kwbob5PMA7iVE2r3TbbcNxfu/oGZUlCe
 RY5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwhabXdQUn/S1pucBPaHHJTC7TANRpGkI+TMhPdSHw04PExOuUx0sViLuhOdiM37QsmQpG5IEbu6CU@nongnu.org
X-Gm-Message-State: AOJu0Yzmbf9+PEwd5A2vuZj48lXXp0H+hbslhOraa4nRJUrZtGE1jKHH
 V31zWS0IWQ5zOuP1HzTXmfJ1N5ryTzGMAg9bCX9CpjjuX99jkw0x+JvMH8fuJpwh9W5U/50mDol
 7pJv+dtfOEsQnZUCrc7j3r/KY/GS3m21xuTECsw==
X-Gm-Gg: ASbGncttLQr1qNCRvNC64ohy7NtPMGGDkpKfyw47Mq29sy+cLBsbnJdPLFR8pZrGqOi
 yFmmUEWDRVnSQkJuKRdi5yjdSP1kGPpohRxN54EncwjygqWu0voBaV80BxANwR25tU//em54rfQ
 ==
X-Google-Smtp-Source: AGHT+IGUyveJDajUyI1gSDnHBzFD+4nn9H9kvz9gc8lritIZ4JOP+GysQ8H2YyG0Gah0lF2b7b+rSDbj876DICK/aoI=
X-Received: by 2002:a05:6902:13cb:b0:e58:33d2:6a12 with SMTP id
 3f1490d57ef6-e58ac03aa9bmr13820114276.31.1738595118473; Mon, 03 Feb 2025
 07:05:18 -0800 (PST)
MIME-Version: 1.0
References: <20250201091528.1177-1-philmd@linaro.org>
 <90d87f0e-56a3-8966-614c-364f3e726d61@eik.bme.hu>
 <CAFEAcA_mBXO20NhYRHJCgkB0h8uYQQhBMdwVW376R4u-qh51nA@mail.gmail.com>
 <87ed0fayoy.fsf@draig.linaro.org> <Z6DTsdf35ApQ0qLU@redhat.com>
 <CAFEAcA8Qigt1EBVgz1D4hon0x4ukLZbZ-jS_KB+ZBH0yi+QCXw@mail.gmail.com>
 <Z6DXmN-ROswsaDAi@redhat.com>
In-Reply-To: <Z6DXmN-ROswsaDAi@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2025 15:05:07 +0000
X-Gm-Features: AWEUYZn4HL6DM65HU2Td3KGGhWBaoWo3z4Hvn1BXN9lGTlWIFT9wRml89dN4xy8
Message-ID: <CAFEAcA8mCt_hPHxDLaOwJUkvk2o9=-20Oy=+eSPFduh0X6Ru7g@mail.gmail.com>
Subject: Re: [PATCH 0/7] hw/arm/raspi4b: Add models with 4GB and 8GB of DRAM
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Jared Mauch <jared+home@puck.nether.net>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Mon, 3 Feb 2025 at 14:50, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Mon, Feb 03, 2025 at 02:45:06PM +0000, Peter Maydell wrote:
> > For Arm embedded boards we mostly tend to "restrict the user
> > to what you can actually do", except for older boards where
> > we tended not to write any kind of sanity checking on CPU
> > type, memory size, etc.
>
> If we're going to strictly limit memory size that's accepted I wonder
> how we could information users/mgmt apps about what's permitted?

For users, we inform them by exiting with a hopefully informative
error message. Management apps presumably need to know already
because they would want to avoid presenting the guest with
weird configs that the guest OS might or might not cope with,
even if QEMU accepted them.

-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0DBC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 15:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udsef-0003Li-3y; Mon, 21 Jul 2025 11:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udseT-00037e-PB
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:42:10 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udseR-0002Iu-Ht
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:42:05 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-71840959355so43565897b3.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753112521; x=1753717321; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x6BYvYZedNTjLvE9rCzg8U/7izC6AH41IHJwlpRHzUY=;
 b=eK/AjlKdnP6+dCu5FA6PkoXniE1uI8K7I3nSoxpVySAa5G1+0U7PgO48ycuq0+QKq4
 /TfLJO4b+JdbTZ9GxlpkroAWyY6McM1hdk85EWgrmJxG5bTKtHhALBwZJZeS1S9pVDSG
 MAwIRQzbmmeRPQJU6DTF5RKTeeQJJkAK7UwnlFa83gXuYT8jCOxOLgNAw6ARQF6tKXsL
 Pa78M2pspB2iVOUX826UrpvpqmpHSO9pMM15lxSZEzywc2bwvtYu113pwOL0S6DA2uYx
 KBCMXfclDIiM+MMYOri6MExmjJPFUzO0BE/Cv5W52GHefiNyqP1F4nOnv6rjY7MZ6oLB
 Jpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753112521; x=1753717321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x6BYvYZedNTjLvE9rCzg8U/7izC6AH41IHJwlpRHzUY=;
 b=wetex4Sxgo8PEJFH08YLElQNLNFf8Me63MKdgvwGgFKJvqSdsVLq/CtFlaRTizmGK5
 b5PdDPJWPfLhW/UHBvM66+okj6p1KDc6pR8B/vgU/G/6DiOm08Yw76caFZH4EMguEX4W
 aFVFRDbH21Umrn4kWw4abgNLtnlT3mRHR2cqupJuFObfydOKBbYWezNV5szNXdC5T8A7
 8pHTqUnq45oDg6bTS5++/CglVuieg2nRIPkwjwzQfa59s/FH2GWe4C8j3utS0yrXi+qP
 KYFavaOXzd2QFu8UR1odhswUqO5VBHIQSAlvkXEfkgiheDas8aznACk5UBqiYKvEgMMu
 hheA==
X-Gm-Message-State: AOJu0YyIDimvuUr5lBJEsiJUfSPwZDiRHhBKfiCsLykesNXdJ42zqTMS
 u/2W3mVV12XLI1jJsPiDv9donLj4kNI/GrAKVFPjz9Gp9kkWvnUyatvto3K29gdjwPO8LG1wy+V
 MjoJFPMKlM8GaPD15Fxtz07sOYAOPM38PyUtHn62XMnPMud5SoDJ9
X-Gm-Gg: ASbGncsm0zavDnEi6c2Hu1BDAvCr4jRQ00Nd9bwA5nFPn7GPT6pCmBr4ElEuSeDs97T
 layVT7iCeNraqJdnBfQsAHgRt1yRacbKoJ+nIhQjc0yx/QlmEAf89qh2bhL0ZbCuzUvA+6+s9BB
 U75YZNmXVSlWhMd05pbV4rUTUbRoSMCLcaZwLJHv+TQ/WBjs5GbexHNHh1VQvWzP5wAJy2dhVEC
 YdQGuY19i15iaG1YRo=
X-Google-Smtp-Source: AGHT+IHNSiZSY9m7oFRpBNBa3kCVwNAUVOKlkEhw/xRf0vaW1QXc5VxxzcDkNz5G0n+ZvttqkhcpbxyJQNUnKf8Vf64=
X-Received: by 2002:a05:690c:6c8f:b0:718:38c1:5f92 with SMTP id
 00721157ae682-719a0b749bamr135287b3.20.1753112521640; Mon, 21 Jul 2025
 08:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250721153341.2910800-1-peter.maydell@linaro.org>
In-Reply-To: <20250721153341.2910800-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jul 2025 16:41:50 +0100
X-Gm-Features: Ac12FXyBBsAKI2rS9k5A8VJs6k_p2ofsNNPuEAdzpCeAKgyBg5JA9iy7Cj4kjMw
Message-ID: <CAFEAcA8LjHXrkiAg-pmRrfBgMohUQU805mX5W0JznVm=qMuWMg@mail.gmail.com>
Subject: Re: [PATCH] scripts/make-release: Go back to cloning all the EDK2
 submodules
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Mon, 21 Jul 2025 at 16:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> I think ideally we would not ship these rom blobs in our source
> tarball but instead provide them separately. Then we would definitely
> have no reason to ship a huge amount of EDK2 sourcecode that
> 99.9% of the users of the tarball don't want. But that's an
> idea that was floated at least three or four years ago now
> and we don't in practice have time or effort to try to do that.
> So the simple thing is to at least ship the right source...

To quantify "huge amount": a 10.0.0 tarball uncompresses to
911MB; of that, 445MB is roms/edk2. Another 156MB is roms/u-boot,
and 48MB is roms/u-boot-sam460ex. roms/ overall is 743MB.

So 80% of our source tarball release is ROM blob source, and
48% of our tarball is EDK2...

-- PMM


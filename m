Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD8FCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 11:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSCdh-0004Vx-0g; Wed, 27 May 2026 07:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSCdf-0004VE-7e
 for qemu-devel@nongnu.org; Wed, 27 May 2026 07:41:31 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSCdd-00084z-JD
 for qemu-devel@nongnu.org; Wed, 27 May 2026 07:41:30 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-651c5d525f6so11739812d50.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 04:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779882087; cv=none;
 d=google.com; s=arc-20240605;
 b=hMxYaZbdXaS29wsWUzSCEDo3cfqhqHCNeoenWC2J74fz1ugQLOo+JJRoeJceG7J0hG
 4b7fyMEIlluQkgDTjJ0/0qD567kjLeGUiFqK7bui5xI20Tx8CdNmQAYTDG1um8SYvgPc
 a8yzlfcFRDzxx97ZWELe1sIHqpZp+QU03b3dZc1oY5YkVSZdXL+HpQG1TdnJ5UhgLF5t
 s3ma346EbLPdohbtQoh1DjBE8kGL5r3sA1HVLcMdDlNd2Lzwwde2M8P5x3EKpMoz/2lV
 QzsoFeMifyqyPXflSyaiY2NEftV0pfNqoqrTNeZrAy3sb7SRGps6HCzUehUPooIgVgNn
 hfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XkR+AybXjGG2p2Dmx4jWubDTlAGb4l0M6h3du5nOV1s=;
 fh=/+4k31CWrsbasIqjmVONAqvkOLM9ZI/djlQT4ejhq/I=;
 b=MC3cKGCr04xluVmEicmdSes7WtujK+RUskl79qB31X0CdveROeueyNBZq3QZTxIsBc
 X55DjqI6xPcD0tr1akUkrft98zhyoPrdoVXI3liHb6GSFvIlJA5nZVN8XCceSUEt7LK6
 DTsyNZe1yhdsTEKnIdcGQVy1o5cscVpamrGF91Sumu7MU7H8nzPS0ZOLZX9GVTZUgJIx
 w2935RizNl4bti2PItsVdNhNb+yJ8TVyzbofWvSb5pAZt3eVjx6L1iw8bLOWdIF8MGG1
 1+TLn20nM6qoQiOk5qjemjYm5GiStxcWVkVJCrKfpDVCNlc4KPJrs/Xkhi2wOwnJ1hPz
 YiBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779882087; x=1780486887; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XkR+AybXjGG2p2Dmx4jWubDTlAGb4l0M6h3du5nOV1s=;
 b=M30cDDOS1KkQrOkvb4lWpLfZUVu7eTLHzvjxnDB+K+eCplzxAoPpua83446BzsLTYY
 odnpMJStCnLgsoQLHmb4XZsVLeD/Dc2+Mepj0Zv4hbbJuP02BVW3bwcSjgNxrZgZKMBK
 DrHl80jjbvCSLVyvMq/P+Sichz5YHHMlDoLuGYcfT6V+4wZ9sCo5CiosFLyE1Lxqml9p
 axcrrarNYHTwU3KV7qlgjI1ASoCBMV4/3U5I74hrv3/7DIoz7OVBCg3Z01FblVnnQgCD
 2B6e4kptdpveNnAfvzafqHZpA+IoIV7qLvoPaxC3A6LjMzKB+UIEUE65NjpiugP51mR4
 B3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779882087; x=1780486887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkR+AybXjGG2p2Dmx4jWubDTlAGb4l0M6h3du5nOV1s=;
 b=HgpzU/FFehrFyGXGh0URpobayg1qJqCVmJLIfO4BX/3JW6qwqSC0VhVlf05keCAYAq
 3GrocFgxt74NMBKjkx2pC7+AwYEFlNBopULOLmcc12UNnIGWzB5Fze3lmgXroDzGbNdm
 AUq4zh8ApbH8EK66K8+HwD15UJVeHF7h9BoXfZzXtHsieT4iInGa5/5WgLSv0NH5uEUo
 iL+PdjThSLj7QC8OaH+ArNdeFEet/GJNLy3jLt5vJjDbV2T7MeNX/YcA0DWr8txJ8jnv
 6qeCIbq8wv3hfuF+Xc43NX5gjbfrMKLt/OBgasJ570aVIXEYxJvihlFQaSn1WN9st/tv
 pAGw==
X-Gm-Message-State: AOJu0YxLWAB5apu5IMSSv7tT5C5wJOSQQvuhk1A4W2PNi1S9UWZJHzFc
 76lRn9xGNoVFtDMCnPTjHRln5uMie8bfzrxsxFIQsC+dXxouHYURfgniyI7nf0RPxb9m26CdeuN
 xEPH+vnJFXEDCsJh3QbOGcOWBEOaSqCTUIICRGHCrNw==
X-Gm-Gg: Acq92OGz9uOsBKGq36IIHpQdXJ4ZrrK19+572TKKlhyz9Oqir8pnAylU3+ti/iI9SEh
 BTF+BEK8AwBpKw5rz1NHBxDoda8bLMO85JoyN5OI+ntSGEL3WIBUpi+RK7irq57Z1NiY+eXmi6c
 lqmHLwyqf3gNLqTMJE2H4BUi8jQyCUodiQIaKkHWAji1naNIrlJN2DQ6O7bhD1R2lc/Csq3cqwP
 fm2jk5XzgFQKkfQvCKu0gg53pUnWh2axpkmlM6CAriAVj095NZZVeYgJz0qBmGRLB2IODa+7CvO
 3ABdKh94Mqe7x7dywNGRnQHkQfohJ4cOkpCDKEe6O8Z98LDkVBi+rcTUE3DcIXUpmm1RfJi37FR
 CAA==
X-Received: by 2002:a53:ac9d:0:b0:65e:3d3a:de24 with SMTP id
 956f58d0204a3-65ec9932e79mr21210200d50.44.1779882087323; Wed, 27 May 2026
 04:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260526200207.79738-1-deller@kernel.org>
In-Reply-To: <20260526200207.79738-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 May 2026 12:41:14 +0100
X-Gm-Features: AVHnY4JdBkIdBNsu2ZiN_8a1TheYNQQHxWag6ge9YhadXGcyHBm0dBw75oxMwxY
Message-ID: <CAFEAcA9_qa=oE2NeVwB1PWFE9R30zOJMvvieg0n-nATm7W4HJg@mail.gmail.com>
Subject: Re: [PULL 00/12] Linux user next patches
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
 Aleksandar Rikalo <arikalo@gmail.com>, David Hildenbrand <david@kernel.org>,
 Laurent Vivier <laurent@vivier.eu>, 
 Cornelia Huck <cohuck@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 26 May 2026 at 21:04, Helge Deller <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit 554cbfb1cf4601d2762f5315c884319e361b24cb:
>
>   Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-05-26 10:38:13 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request
>
> for you to fetch changes up to b501a44d26be4cf70ba77500365aadbf21494e74:
>
>   linux-user: Move cpu_copy() to user-internals.h (2026-05-26 20:56:29 +0200)
>
> ----------------------------------------------------------------
> linux user patches
>
> A series of patches for linux-user, specifically many FPU fixes in signal
> handling code for sh4, mips, ppc, alpha and s390x (from Matt Turner), a
> madvise() improvement and a ARM cortex-m55 program loading fix (from me),
> and qemu header cleanups (from Peter Maydell).

>   linux-user: Fix loading static ARM cortex-m55 binaries

This patch has been on the list only a few days and hasn't been
reviewed yet -- please can you not put it in a pullreq? It's
on my list to look at.

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E123CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 14:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDke6-0000SC-5l; Tue, 28 Oct 2025 10:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDke1-0000RR-PW
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:25:54 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDkdw-0002ZD-P4
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:25:51 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-784a5f53e60so71453267b3.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761661542; x=1762266342; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJYEJFgyLGjS2MEVNnKxDjp40ZFODsyGptMAjNuSpdw=;
 b=tnS6s7tMkEGEMNbCtSnaMsdQ84mB+dgvUninwqVNFJufV5tA7Om9RGgywt0qijyQn4
 r/VXJ5unOPeD9FO9b5XmVWYvCzQWZ357QHq3bItUKGL3Wq6sv/JIOrn50jA0D3bj6lcE
 NF/UGqwfGP1QzbUWGZyKHtclu3D8zGAZpOEhfYDWvH4Et944VYUetZjAOSr9JvkGTrW1
 EEfRAriKODORqaNed3sBPffcnv6xKGMZzQPpe9Qax5yeqiPmkF7QxUxv42mSLWdzC2n2
 8yklaV2BQxcKFa6awxUl6N3xIcVDm6nvfmXtH1B3JsUHaQmS+jN+Nn1qyi7TvxQ7BlEr
 OY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761661542; x=1762266342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lJYEJFgyLGjS2MEVNnKxDjp40ZFODsyGptMAjNuSpdw=;
 b=i+Vdg0Cdrk0J4cqdNwZw24q5mHB0J++KbtkG5YpOb/DfFG1wToKAhcfQJrnoH2BJJP
 7E6XsbQUMVA+dUzGgPnpECNcJVkEf2pJK8Vzoxv2xBNp6iFV/IBn3K7Fd1nBAzZaWhFn
 urWI9FfnPr6ze9YeWGHSdJ+mgIIKhabvQAMXgX/AIgieKNI1nIWHbcOfeqz2Jcaydb6a
 oqs54Ajkg0XoHvbN3CsbYCDfOeJ5T6PepgugZCzuyTKoyZcas/SqU+DhKS48nlozRa7R
 pYtK8T1Ub7xCNUP+HDpNuaeZf3mrrMrtBWY+r0MM2pUUmn8bVj5SGXLFqLrsr2spobek
 3RhA==
X-Gm-Message-State: AOJu0YzqML5zNSGZMB1Tw8+goSWR3fHUsj3g6oikjZbd3SpQw095bZeM
 aMEljqEgykAuo54JUfP8pUmfyS1fh7Tt9vXBZ0RUdhpcfuX3yT1sbrNI1vVYcZnUxqBY4W9Wv8R
 L2U+jC5QQI4vE/3F7tf30Ik9Y1QcgF7edvHSsq7D/Mg==
X-Gm-Gg: ASbGncvkW/gwy1rBjfnPCGgDt8yPjSlIrwh85l6CpF7V5kMFFUZCH8fVmhtnkGWHCm0
 VHhLoSkdDd3MhLXon87D/5wKTPzXF95e8jUDXJI7w/A2ukycdTKKXpqAzFXA5/iSaAsXbnoIQIi
 EclUmsXbkPv4YH+KcaFV39WQqkb32ky8kdtcqu0I9mpKACqV7M+e5UEETj7B+GMtlg4h5CMyGy8
 yyXy/zlXslBfW88LbAUA6OQPP5qN6nEHrRE7kG6mFMZvnfZTAjVi3D5/V0qPQ==
X-Google-Smtp-Source: AGHT+IHQM3ixGHGsFt5kzmUYVgBI3ovLkjqj0X+4hc2lcGj8inL37FRph4UJM40uQJhpmFodCq/Z8A7qGCdmRGlamys=
X-Received: by 2002:a05:690c:3608:b0:784:9e33:f869 with SMTP id
 00721157ae682-786183c672bmr31310517b3.62.1761661542573; Tue, 28 Oct 2025
 07:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20251022150743.78183-1-philmd@linaro.org>
 <20251022150743.78183-8-philmd@linaro.org>
 <d29d2888-0a95-464b-a5f9-e8433be2b895@linaro.org>
In-Reply-To: <d29d2888-0a95-464b-a5f9-e8433be2b895@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 14:25:31 +0000
X-Gm-Features: AWmQ_bmr3zD195x8DZSiiWB0S5--txJykTzGSKEUP9OkOmpF8lvmaTdCJ3yejkY
Message-ID: <CAFEAcA_7w2u6VU07caQoRbR203RG0EGmRjcB5rmyzXoe1qFMPg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] chardev/char: Preserve %errno in qemu_chr_write()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 22 Oct 2025 at 16:14, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 22/10/25 17:07, Philippe Mathieu-Daud=C3=A9 wrote:
> > qemu_chr_write() dispatches to ChardevClass::chr_write(),
> > and is expected to propagate the backend error, not some
> > unrelated one produce by "best effort" logfile or replay.
> > Preserve and return the relevant %errno.
> >
> > Cc: qemu-stable@nongnu.org
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>

...did I? I remember being confused by the errno usage
in these functions but I don't remember what I thought
was the best way to untangle it...

-- PMM


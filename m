Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C88CA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 19:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuFnW-0002u7-8W; Thu, 04 Sep 2025 15:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uuFnT-0002tc-3J
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 15:39:03 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uuFnP-0004nL-Ey
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 15:39:02 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-81076e81a23so49073985a.3
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757014736; x=1757619536; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlwcQ9iBpWQwDKBRpIv1lZWDKLzWmBPuOfOcu4urf20=;
 b=LyArW9D1+Qdtwfm/BOerNIz+5TsOE8vL035TSBLG+hLuZWZb0pKjElo51dBYzU/fSj
 JHlB9wM+VqIYXv5B9VLCDQQMLC56A9ax2W23tV04xeHuMoKTeNDNEf/tzVl8z2Z707yy
 Nx1gVwuqUFOdtUZVRF6D6Pj1Nf5NN/J4quHxDES7veiVEQxYwlV8eRtJOt97oWXJ3XYn
 b7k2cunpcxf4pq8gFj28Mkt4Y3ilXlfjExKrXd0ztehg/NlNNFijNwUxfnK9xi64Pvp+
 53AVfG6diJt05wsE6KXUM5Fdy9rqEhnherp8PESWu+Qp6vvh2KTmIISe8/Eoh1c6dpeq
 xsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757014736; x=1757619536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlwcQ9iBpWQwDKBRpIv1lZWDKLzWmBPuOfOcu4urf20=;
 b=irAPYLjT22Nky6vE1i05a/fgQNmvudywsYhJ6P+9k+Ms7Nu8IBJC63quZDe0JyZ9ul
 ZZhf4z7kyiRYRp2UzQC4I02sa5nRzu6vh+xwRPqlivkiYm63tWa/G7Ibtwb9p0ERDbtW
 7BDWXuTKqutTJYr1pLWnp/z0MAKsn9fFu5qDxgkfVzg6RJcDEcuGlPjvlCw9QQY4ucYi
 lQ7BM/V9HvdPMOtFb0ysZkToYpD7m8qkb05aVq6erJjyXRWV3P6ZmKzAG3g40SIDg+1Q
 QFMaPr/yCBoUgnndjJgNO3D/3lbuJy0xmPoTjHRfZMiiRawB/6+oVS6vJmNG9CrsabfU
 hDLA==
X-Gm-Message-State: AOJu0YyOrVKFKdkgdMS1hBMtOk/buL0NAgztSzCQcBnsA61CU0iJsQY+
 W6eLrDZD016jyxxt2YUMo2tKI7CloPO72vDSIVRnIwvulIXpCSu3f5UZW3FZtVkwSqM8E3/MZob
 VgkWSmvUMKEIqZzP/zZr73juVCQPpMGg=
X-Gm-Gg: ASbGncsLWt9baVKgjaH2ZeUgunGAbLNCscmdEtqOVq9VRsYEkz9fwCIpIpZMh9RgtMu
 Syr5tpNXz9uG82kKDNamCQgDJY50WhemcDiqCewMlX2BHov6Sltb9tBTx/HBBshLBPnfe/U1JhW
 UjJomjytG+Mg4GIt7dvz1Wjn4sr8M63WktC96fI29ID7A/4yO08qcnPQyZ8X/ySHhh78xBMNpKx
 DIBC/YziA25tfk0nNvEvrIK
X-Google-Smtp-Source: AGHT+IFDcGIZj2VLW4xf5NTMGQWrLg3kWrIOiRersPsjOmjzRMxkFt2hld8KBagqGAxqWiDR6j76ojWUYPlgVbxwJQU=
X-Received: by 2002:a05:620a:454d:b0:807:c011:4d94 with SMTP id
 af79cd13be357-807c0114e51mr1138573285a.15.1757014735649; Thu, 04 Sep 2025
 12:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250506152927.222671-1-pbonzini@redhat.com>
 <20250506152927.222671-2-pbonzini@redhat.com>
 <CAJ+F1CKZr2PZbXvi8OZ9O=QaGv4WUmLPofBzqDv4VAV64y9EnA@mail.gmail.com>
 <1546553e-a21a-4a0a-8bcc-6c4e23ff35e2@redhat.com>
In-Reply-To: <1546553e-a21a-4a0a-8bcc-6c4e23ff35e2@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 4 Sep 2025 23:38:43 +0400
X-Gm-Features: Ac12FXxSdQm_oqj3GYB2KoXhHZGd7o38uNd9QP6n0WYnv0x7muc-Xe_8iZH_eCY
Message-ID: <CAJ+F1CL+TxyRN0P2njCBRLigKe1tO1CyNOuCP1L5LHwE5FMEsQ@mail.gmail.com>
Subject: Re: [PULL 01/30] lcitool: use newer Rust for Debian and Ubuntu
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x736.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Wed, Sep 3, 2025 at 5:59=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On 9/3/25 15:54, Marc-Andr=C3=A9 Lureau wrote:
> > Hi Paolo
> >
> > On Tue, May 6, 2025 at 7:30=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> >>
> >> On Debian, the rustc-web package provides a newer Rust compiler (1.78)
> >> for all architectures except mips64el.
> >
> > Unfortunately, rustc-web is not compatible with the cross/multiarch
> > packages (it will remove all libstd-rust-dev:*).
> >
> > Should we switch to rustup in the meantime for debian cross-compilation=
 testing?
>
> We should just switch to Trixie, which however needs some work in lcitool=
.
>

Trixie no longer supports mips:
https://www.debian.org/releases/trixie/release-notes/issues.html?utm_source=
=3Dchatgpt.com#mips-architectures-removed

Can we simply drop it from our CI too, or do we want to keep
cross-build testing on debian 12?


--
Marc-Andr=C3=A9 Lureau


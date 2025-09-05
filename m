Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4275CA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 12:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuVDW-0001Xl-P2; Fri, 05 Sep 2025 08:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuVDG-0001Se-0H
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 08:06:45 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuVD2-0006Xr-TJ
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 08:06:40 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b0418f6fc27so323365166b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 05:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757073980; x=1757678780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/VTBHhluly/DAj5y9pk8ACPeBIO54fxP3G69hsnvQc=;
 b=DkwkrwygTlNmBARirtWl9Bu8BIYoz444MLnNDlSsHSOdfjohDOvz9RC1iH4EYHyesV
 aVqlJ6+4K1R9Q2gCdlYGMfBhgJ79BscDu1tnSLQG3SdJ4C9DZjaO5ELKZuva9WCIiQE2
 dwRnN0UdFaTb/5wKWwI7tP1zIbfSK3Z8XUgxCy48CuZmF/bHcVHK4+LKhZr9NlC12zCs
 sro9MRTkhDcYlMA7/9QhZbTJCzjCDx4A4aIMcZdv1i75ZshdLCNQ6qRpoqLaI0HqteDj
 /PVAMWxCOI+S59ZViKkUiRdmw/QMfUQrpFea9K770VwQAxRLdrwmQ0RDaNW8eLSutHnM
 fCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757073980; x=1757678780;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2/VTBHhluly/DAj5y9pk8ACPeBIO54fxP3G69hsnvQc=;
 b=i8UWZrHSNzadPgS7Pvl65KAU6nXV8OkaQDlu2ZjDFPcTz0cqImtQA1YLLOdYm/KLZF
 D2UQqlnrYRC7xssGvMh1S8oS9j7GK8EHfkvSOianjZ5YLBIiB9QQbcqS8mTXArZcy998
 HplH+wvxlAwOE8LDiDOqd8nqQvOBLpu0x+D0nHqBM2CLg9O3c1UN4P77B28FVEkAGlnh
 2oOGpMOxTQD+BozBXYrBu4jz3ayVS7Zzf3s53iYG1fWBVFzt1qtxgTnXmgmlNK+VBHTW
 nuG7ZgtU25TRCQGCLz1kmc+RJKM24g9wGvk61LwodALrlqBkibUh4Nej6o55hEpSJ7ke
 +L0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDSRf4jQOyllCzDfudI8l1J/z1PUkheVaay8fbb26KSeLGlVj92E163i8loObeFSz+Ed8MMKCOtnGe@nongnu.org
X-Gm-Message-State: AOJu0YwDcNmvkT44xFFbbflTkaIx6M/7SBX+xhT3xQFatj1e031SEAmL
 iJmYiQzrXh9s5OEP6s21kkijTekr6ky12VwNzhz5IJHY8tBk6NvwzYYdiSrbVoIoZDzqvKbZq0w
 6xZ88WvAcEA==
X-Gm-Gg: ASbGncu3zzEpnqJF4Sp71vkwndxTouyPgP1oSwJehvtQWVeFumO5M3VJU4ZnmNecvD9
 e+P+hMShFv43kAHR72B1xW3G7/Z8PHX+ySe/nqTARR+1dZYkENEaZia6KcC1CW0spEskSnY2Kd2
 YC0Qxb6s2T33hgWW1SNWw8eFQ6hjzSntIoemLW3vv4RMdMEROz568FyXUF8P4bsyv4sjadp6s+l
 KNbrLIjyLGBluXn/kFU/1YSpvDiXFvAHdwWTzydTXFhUE+r0UuMGPq0PVoKZPVhukJ5YIbViJJx
 Fva95kNY/AtxangRFGDjzqvMvx+YSh7fWp9K9ib73IvGfDznWoMqMzspIc/kpZdAdxBimibiHfG
 8Gpm3yn8ZNaM8Csoljhrl5f4=
X-Google-Smtp-Source: AGHT+IESSYx9h6xQ7wV6xYhHzVotds8AKwOPYSGVgbGvMx3gpwoXADukfqmbeIlTVhxGvuWl3hsK9w==
X-Received: by 2002:a17:906:6a20:b0:afe:90d2:b952 with SMTP id
 a640c23a62f3a-b045bc3622emr1246530066b.29.1757073979525; 
 Fri, 05 Sep 2025 05:06:19 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b046d420e02sm594047066b.39.2025.09.05.05.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 05:06:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 70E125F879;
 Fri, 05 Sep 2025 13:06:17 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PULL 01/30] lcitool: use newer Rust for Debian and Ubuntu
In-Reply-To: <CAJ+F1CL+TxyRN0P2njCBRLigKe1tO1CyNOuCP1L5LHwE5FMEsQ@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 4 Sep 2025
 23:38:43 +0400")
References: <20250506152927.222671-1-pbonzini@redhat.com>
 <20250506152927.222671-2-pbonzini@redhat.com>
 <CAJ+F1CKZr2PZbXvi8OZ9O=QaGv4WUmLPofBzqDv4VAV64y9EnA@mail.gmail.com>
 <1546553e-a21a-4a0a-8bcc-6c4e23ff35e2@redhat.com>
 <CAJ+F1CL+TxyRN0P2njCBRLigKe1tO1CyNOuCP1L5LHwE5FMEsQ@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 05 Sep 2025 13:06:17 +0100
Message-ID: <87qzwlw1c6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Wed, Sep 3, 2025 at 5:59=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>>
>> On 9/3/25 15:54, Marc-Andr=C3=A9 Lureau wrote:
>> > Hi Paolo
>> >
>> > On Tue, May 6, 2025 at 7:30=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.=
com> wrote:
>> >>
>> >> On Debian, the rustc-web package provides a newer Rust compiler (1.78)
>> >> for all architectures except mips64el.
>> >
>> > Unfortunately, rustc-web is not compatible with the cross/multiarch
>> > packages (it will remove all libstd-rust-dev:*).
>> >
>> > Should we switch to rustup in the meantime for debian cross-compilatio=
n testing?
>>
>> We should just switch to Trixie, which however needs some work in lcitoo=
l.
>>
>
> Trixie no longer supports mips:
> https://www.debian.org/releases/trixie/release-notes/issues.html?utm_sour=
ce=3Dchatgpt.com#mips-architectures-removed
>
> Can we simply drop it from our CI too, or do we want to keep
> cross-build testing on debian 12?

We do this already for sh4 and alpha which have the
debian-legacy-test-cross container. We can easily move mips out into its
own container when we update debian-all-test-cross to trixie.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCB3C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5lp-0004sj-Mk; Thu, 06 Feb 2025 12:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1tg5lm-0004mp-U0; Thu, 06 Feb 2025 12:34:31 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1tg5ll-00037G-AF; Thu, 06 Feb 2025 12:34:30 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fa1fb3c445so466351a91.2; 
 Thu, 06 Feb 2025 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738863267; x=1739468067; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3oaUqlq9HpIZZmIz6s3ZZLT25evRAcGajYotaDqYww=;
 b=Fnq0i9MnyybYVnLB2LJdu2PpC7Qpi5BBJSghyJ3VAZdr4+e4Czwlg7eL2St9KLTeki
 /lfKOxq9pe30ODsnJXyO/6UWS05O9EdBHAOwQKK9BwmGigJruVUQuYZXg9SZFi8x9IV5
 OG29Vd0tUtdPQdQdJihe71K8BgVTAfbNAinbVeBgoAWvBfimLkFDplIAF5JR35RcFezI
 YX1r5KcBVSne4s7ZadPynSSN6PFAoZDKu52SL8gYyOPOj+z3pT4TlpVKpHfkXw7Omvx6
 bfnvHfEWzgoP4MepOAuumH73xFP6FLtfT2DXH0yFrSGiSbBk+XJFyAeIKVAmK1I5Wvsd
 29PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738863267; x=1739468067;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N3oaUqlq9HpIZZmIz6s3ZZLT25evRAcGajYotaDqYww=;
 b=vcwaLxVxlmVK+sPSkM4FqzPAVleMterUjxlOSm+0WDFIUNDQpSJVgkw6sZWbgVUUFr
 X1ohJ/YfnY2vrND2x67KpGRk4vY1GnvQ2PWlEKjYUUePOcUmgRUOEj6GLNgk5kVcsBJe
 PbITEnari8zXaPrCTFXD1pAVSS5G+av+nFrBkQlOsUQyoJ0oUYrfP88yKf5FBXr4dK6U
 XW9+Q6o76KKy+UstqON9b1zIEuHmB2gzGn27+PAyRRHlM/rchM9iBOApWirOVR4MpO+u
 szu8TLNP4uaHqjJFcup+XkeQsn1eRi2q0P9KHpkR4vH2bbaA35Z3hCgqVNDskPq02oth
 tRAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAP7rJtNhqvwA1kW8gWaRAZIHDQZsWjOtI/Q4BhJlOPjkUdRgaWRA+mVnR6fKuRudwky+7DhJpxA==@nongnu.org,
 AJvYcCWpbzG68G1xyz4lA6pABHGzNcTsnbeL2NfWCcM7qCyc/PKi1hVbZzDURxeF7Ck8YMmQfjcQJWmaChUrwQ==@nongnu.org
X-Gm-Message-State: AOJu0YwamyaUHqXizRdueehmfctUtaLoVyejVSpo1azFFv4EPlT8LY1C
 TdJU/IgLoYazeDw2f2ddtfWKv3T3xxaf3/xBX5KYvsUxQv9DSMt2AMuFEex71ekcoPyPA/1a9ns
 AxJ7bBdgEMdVmQ5xHX8iLD1/ne5Q=
X-Gm-Gg: ASbGncs/KbxGzlz+IKtD9HmJdO3aaGh3Xp0iITn3VMCfoTF87D6DptE4w2TgeuvoM2L
 /207IivFUDjtHycYctKCTD/ys16EeuS8KBeJl2E0un6hwTS/Ldf+GF9BxrDD0WVfMleCV1sxn4G
 VF5gDUkrpqBI0mYyYtn+7S7HiDaa7s
X-Google-Smtp-Source: AGHT+IGYMLjQxmmXi2Q3HO6/dfm119AbBljnoXa5dPciQ8yvTIf7hZJOAjbqVgXA8CeOHC7hqPtUEO5jj0e/EmcDrMI=
X-Received: by 2002:a17:90b:2ec8:b0:2ee:dd79:e046 with SMTP id
 98e67ed59e1d1-2f9e076c07bmr11787120a91.13.1738863266915; Thu, 06 Feb 2025
 09:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20250206131052.30207-1-philmd@linaro.org>
 <20250206131052.30207-12-philmd@linaro.org>
 <Z6S3Mgt1G7fIjeBB@redhat.com>
 <4624f149-76d0-4da5-8f13-8c015043c335@linaro.org>
 <Z6THtfjL6UVhBiW7@redhat.com>
 <3156dc3b-9553-4b5f-a934-f29ee0601887@linaro.org>
In-Reply-To: <3156dc3b-9553-4b5f-a934-f29ee0601887@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 6 Feb 2025 09:34:15 -0800
X-Gm-Features: AWEUYZmJ_9jUQaqkqkoyKOVYkIWzM-3OuZKytA289UKgMN27dz0ArI2w-4sXGHA
Message-ID: <CAMo8BfJrzj1rERAXXZ8dfVYjnD744mCdCcNUuB1qeqD45dTUAA@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] hw/microblaze: Support various endianness for
 s3adsp1800 machines
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 6, 2025 at 7:04=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
> On 6/2/25 15:31, Daniel P. Berrang=C3=A9 wrote:
> > We would pick an arbitrary endianness of our choosing
> > I guess. How does this work in physical machines ? Is
> > the choice of endianess a firmware setting, or a choice
> > by the vendor when manufacturing in some way ?
>
> Like MIPS*, SH4* and Xtensa*, it is a jumper on the board
> (wired to a CPU pin which is sampled once at cold reset).

This is not exactly the case for xtensa. Each xtensa CPU is either
big- or little-endian and it's a static property of the CPU
configuration. On physical machines it's either fixed (e.g. if
the CPU is a part of an ASIC), or it's a part of a bitstream that
gets loaded into an FPGA and there may be a selector for one
of the bitstreams in the onboard FLASH. In either case there's
normally no board-level switch for the CPU endianness.

Also big- and little-endian instruction encodings are different on
otherwise identical xtensa CPUs.

--=20
Thanks.
-- Max


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5050D2F339
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 16:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfh4u-0007dv-AP; Tue, 13 Jan 2026 11:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vfh4X-0007Vx-Uh
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:16:52 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vfh4V-000678-Tg
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:16:45 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6505d3b84bcso12101262a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 08:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768320999; x=1768925799; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shrcPEzb4aNV5JwEnXnE47Uz3LqyRg3MH/PLatgNdbc=;
 b=i1yd7L8b2W3E7rVQ4peqtVODTKKsFhsII0grNC6zEzmjKs6v0TH6wuRcdJ78HFwjp3
 G3x8BHhp2s+qmH7YEvpya7Ox6zjcdGQM7DBY8dmUlp11X6IBBxKa0T1Mim/UMEy/6V7C
 qF6K+aJz9YizoVQy0xOuzQeONlBMKWgSoUW+K304KxmpJwNVOD6+WlBRS6zoVadaMVfy
 hHNn4LNxpjF0VPEiLUFoefXNq3f1NcLYOAAvbNMGBaIKXPN6vg3uXBRKHcawg4D3Jn+J
 9+BWF9U85jnwpB0QlkRrRKmEcEFLV1W6Q0SxBB68ER/mHsMCnmMP4Qh7WsJGtWVA+NzC
 GUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768320999; x=1768925799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=shrcPEzb4aNV5JwEnXnE47Uz3LqyRg3MH/PLatgNdbc=;
 b=IaMmsuPicDfXUCt3f0MapBvWFxd7wefrviDakrjq34Xafgdp7WW/OIg8aDQuurdjnT
 SabjvjzGG2b9F5mIvFhY/9cz9Lg6/kJsNO9+7vjzSYuRdjvwDF6ghSKbxzCMYn4mOkzp
 FOceNAxEzquaof+iitkOnFFaD4ty8Uzr+YX8pQRiGNCWIds1nKuSCwqmtFIOheUIUHnk
 CE6lC38KLAxjCq8NRER9J9TtdjIFG/PdrrqCOs6lyDn4fgZQlF35sUIdbws6EufnbJ1s
 eeEZsR2/KLvxSTZIecw4JqF9DKl5Uv3Xvs1oPfQf1BLXiAxjE8/tILQcxufywZBWHxBo
 8ZnQ==
X-Gm-Message-State: AOJu0YzVKWx9cxrwXLB4bqpXuAQkfF/A9AECZo4/eYeY+PfVRTjb+3id
 GXNGQ/MUyoIawTVueGaRWokS43u+GUIVn1AKWyw7N37R3PVDmfF15Zf69iIVQf+gaIJfVZL64I2
 hLWRaJ+khYQPb+S9A1yIvrCko6x/XSnA=
X-Gm-Gg: AY/fxX4doKDq5kPT7i2jAgINFk5NJVNB/V9CMRQZucDhGpdE9dbJT7XrrObA8tHzbbr
 4k8GH61E6N0d+9eq+CQQpKtP5w1ObhFlnfaQNG2hL4UGE5cCyTVwlVxSsGdhoxJaNG+DEOiUifK
 sr763DUI4NUoJKt0Rdc7Bd3xM3OLApJJ1cBJ43NyMxYtVoNcfLgpOQjPHh2MUnNjdT5do/UBAtB
 oju3/LiEOB505j+EbAACspJu9pc8QCvSsyyjDMsHGlonbJr8804i3OI0/AbQJjuWptHdQ==
X-Google-Smtp-Source: AGHT+IHeiXZQnvw1K14LiD9+GLZGNYRdbytBLKoxdu0+Xta2Qk1o+/1j7ZzV9FMnMVXfT7V6vhkF3XPB6LaigPsCOM4=
X-Received: by 2002:a05:6402:3546:b0:64b:4720:1c23 with SMTP id
 4fb4d7f45d1cf-65097df5b56mr19145568a12.13.1768320999063; Tue, 13 Jan 2026
 08:16:39 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <aWZk7udMufaXPw-E@x1.local>
In-Reply-To: <aWZk7udMufaXPw-E@x1.local>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 13 Jan 2026 11:16:27 -0500
X-Gm-Features: AZwV_Qi7DHm95fI2JQgQGGuriK_wavPbXFOd_YVGKOoEvhXOSPvwsJvXr_ZtxEQ
Message-ID: <CAJSP0QVm41jSCma73sef7uzgEnqESRfqrxRstNTY_pd4Dk-JXA@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, danpb@redhat.com, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Marco Cavenati <Marco.Cavenati@eurecom.fr>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
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

On Tue, Jan 13, 2026 at 10:30=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Mon, Jan 05, 2026 at 04:47:22PM -0500, Stefan Hajnoczi wrote:
> > Dear QEMU and KVM communities,
> > QEMU will apply for the Google Summer of Code internship
> > program again this year. Regular contributors can submit project
> > ideas that they'd like to mentor by replying to this email by
> > January 30th.
>
> There's one idea from migration side that should be self-contained, pleas=
e
> evaluate if this suites for the application.
>
> I copied Marco who might be interested on such project too at least from =
an
> user perspective on fuzzing [1].
>
> [1] https://lore.kernel.org/all/193e5a-681dfa80-3af-701c0f80@227192887/
>
> Thanks,

I have edited the project description to make it easier for newcomers
to understand and added a link to mapped-ram.rst:
https://wiki.qemu.org/Google_Summer_of_Code_2026#Fast_Snapshot_Load

Feel free to edit the project idea on the wiki.

Thanks,
Stefan


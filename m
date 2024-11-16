Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F79FD68BF1
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2024 21:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCQEa-0007DB-4P; Sat, 16 Nov 2024 16:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCQEX-0007Cl-Bo
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 16:21:33 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCQEV-0002P9-SU
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 16:21:33 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cfaeed515bso771242a12.1
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2024 13:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731792090; x=1732396890; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R0svVznsXJi+KwTmDjSl06FehgpkSPdLwSrxOHWybLM=;
 b=ddhl/sgWGkLFhXUUZWao7aOh0UrUa4QDp6khKH5cBGYJmbFOimTvbWBcG4p3lwvQGz
 PjRrR2v+r+6vsr+8gbXmUfx6BVaMePeUlTdMrIThou9qYT1s88/7YvGvmAAuHyDxAKLw
 NwAg9cI7VKmRtLACG1P3/viiWWXZ7djzvvF8HPyitDHMKi6wriuikGidbn+mxNeqaSbo
 QOVzHoEleUK+gicDTAqVeanQsxSI7Zn70ksZkx5OPgmVmscAV+YPiOZO58y4kEllip42
 trmL3ha50310lJiZLlVVCz7O8Nqg5ntqr7WWXlTwSQQSp3Kv5Lamn7+qfvPVFBfdINoG
 KP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731792090; x=1732396890;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R0svVznsXJi+KwTmDjSl06FehgpkSPdLwSrxOHWybLM=;
 b=l4N4A9iAxYK688/YVeEP9TrIIVREa/88HWCj29vR970fTWaL65E0V2HwtYiJszf/T0
 G5FJs/DFM60juwB0LQ9KN/m+z+clLVclD104rf7F8ps6DOf8Asxsb13bsM/QWONOu+Xm
 9vfU5MpqQ0YFFFLXyc7Md00P77HySsPxm9w4/iQm+zemTz7u3ZMYlKG8H+5a7sSP+bgG
 dAUaBRYZZOm8Wyc3OqQ6cZmiwl+HyFiKzjRVuTsu9Uyv0f9qecT3W/AqVS5inl3AEAjq
 PZQY5S1EB1iy8zUym82YmG6Pa+/r7SU3wwrSu9yAC0e9U6evNoiQtw5euZR2UWZz0odh
 BQjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOEopKiL7MSzQYgQtSfD3Xc0ycH2n9V3h9NOW0QLP4ltPNdLwSEhbNgJ9n7N77+G36yPb1fjBxnWi6@nongnu.org
X-Gm-Message-State: AOJu0YyxBrM7Fa4xOoo21KxzR01G2BRdVRcJhcYZ4iwiz3iBlBK1NCwk
 2dro7QYjwiyqcIaWj3E7YeqHmPqfzePXDAeLODCe3cbwlMxoItFlDDaal8zpGig3fXxKTWpHTGk
 6XXf5XsMIyRNpkFsCDcpmEd/73NbpMMDwIjwQDQ==
X-Google-Smtp-Source: AGHT+IHJpXXN+h/fZR58qw/EGaCnjiUJ5snTWk23QeGNj3pNEAMKzeSTL1Th/bkzBI2S+21D1SNAjst+hriuI+OF5yM=
X-Received: by 2002:a05:6402:2793:b0:5cf:95d4:7b89 with SMTP id
 4fb4d7f45d1cf-5cf95d47d98mr4580665a12.8.1731792090102; Sat, 16 Nov 2024
 13:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20241116181549.3430225-1-manos.pitsidianakis@linaro.org>
 <7d835e14-c3d4-4aba-b4a9-eeb06f56fdde@redhat.com>
In-Reply-To: <7d835e14-c3d4-4aba-b4a9-eeb06f56fdde@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Nov 2024 21:21:19 +0000
Message-ID: <CAFEAcA9n0+NE=hf4F7PDp9K7bwn96msdPYXpBPaY0h5-9=7+8g@mail.gmail.com>
Subject: Re: [PATCH v1] rust/pl011: Fix DeviceID reads
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sat, 16 Nov 2024 at 20:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 11/16/24 19:15, Manos Pitsidianakis wrote:
> >           match RegisterOffset::try_from(offset) {
> > +            Ok(PeriphID0) | Ok(PeriphID1) | Ok(PeriphID2) | Ok(PeriphID3) | Ok(PCellID0)
> > +            | Ok(PCellID1) | Ok(PCellID2) | Ok(PCellID3) => {
> > +                // Ignore writes to read-only registers.
> > +            }
>
> This is indeed an improvement over the patches that Junjie and I had
> sent, because the writes would have gone down the eprintln! path.

In our C implementations of devices we usually let writes
to read-only registers end up in the same default case
as writes to invalid offsets, because they're all
guest errors that we'd like to log. That's what the C pl011
model does.

-- PMM


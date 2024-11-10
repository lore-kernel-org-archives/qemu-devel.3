Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75ADD12D49
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 17:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tABL4-0008Ds-1J; Sun, 10 Nov 2024 12:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tABL0-0008A2-F4
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 12:02:58 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tABKy-0005vG-MY
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 12:02:58 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5cacb76e924so5516474a12.0
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 09:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731258174; x=1731862974; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MrlmipU7gDyelYiqq1Vx8MZ5Sox84+3e6R+53VbFjlI=;
 b=rbtmBKuHD4SZFpWudzhne50XSvfvsB8UxhhNQ9rLbiE9RoFpJCttxtA/UX9KGyu4vy
 yKYxS7YLubq6OPFCJYk9tZv5L0A3TDP+jiSPMhSeuLdz6BOJRGueTg7Wj7+kyIx7DQwt
 TH+wO2pCRfGshxoM/uTqTRSVTKVle21uBg8kN5PyiaPuroYpvDPtZjvSnViEG4DwtqJg
 pWAXI5qzwwSReU0b+ffXSL7wtD3eMBr7nH/0wI5FkUWam3Ru+uysVlkp662kr4XbUcbl
 0cq9BeHRrjAN99+u9oJJSjqlnM8Wa4ZNMsUnsymUSDFBPtE/dWiyAUuAGvCMXNvbIlau
 Rb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731258174; x=1731862974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MrlmipU7gDyelYiqq1Vx8MZ5Sox84+3e6R+53VbFjlI=;
 b=OtTj7GMenF9rY+82OFKt0HENoGdlNYs+8eUodL2e7812DMe8dHZar69mWEW5mNr9lQ
 oT/GSTZweggdCziQhgmVngqyDlqsnVs5aaQcXmDd7D5R28L9j1HqUUFABQtD2K35I/F+
 gy65WFDV01ahMv7fJsjYfkN3XAwAYK7R5PtFSrNxXOwYvvX897i4PAV7llRnXxSXp4g5
 WwaK4wc61I4uxwkyOu6JT8YGaEt679RKCDE6k05mCingjnJldq9D4bXlCuZGrZ6BQg+s
 e/i94jddyX3sd7O/rvHVMui4AVxR9uKG729FJBGTPsHLxJD7SO9w6NjbU46a5LPzwlbY
 dayg==
X-Gm-Message-State: AOJu0YwYiBQ/pCsZi9JZnV9W400wg9Q9ieGyVRVZ+Epena6X0CgK7dxk
 Uc9u3BA940bDv/3QlSfrrNF0U9SmhiLoohtFZ/KSHQbexeinoF00Ra9PUZoy7fUTdeJ394JXAZV
 d0QP7qCKlX4YhfanDJvf8gMpaNcZXi3zFvScQBg==
X-Google-Smtp-Source: AGHT+IGp05PADq+YsBKNcizpiAzuA1UCJY96cNjyFFJSNhXrDqW6S0+ovssVbVnGQkrVYo76zJwjAgppBQAdumXc/UI=
X-Received: by 2002:a17:906:f598:b0:a9a:4a1f:c97d with SMTP id
 a640c23a62f3a-a9eefeaf039mr963214166b.7.1731258173857; Sun, 10 Nov 2024
 09:02:53 -0800 (PST)
MIME-Version: 1.0
References: <20241109-update-maintainers-file-rust-v1-1-f4daba6f782f@linaro.org>
 <aa360d5f-b4f2-4a61-a5b8-decc87a97a7b@linaro.org>
 <CAAjaMXayR_Ugkz76OuYe97tEKvHuuJA79f71GJA=zt8L=ESb2Q@mail.gmail.com>
 <3e3075c0-7555-4732-9f2b-4c0ad9b064fc@linaro.org>
In-Reply-To: <3e3075c0-7555-4732-9f2b-4c0ad9b064fc@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Sun, 10 Nov 2024 19:02:28 +0200
Message-ID: <CAAjaMXbShaEDXXpXiSOxwSxahyTudJ-hYT4QwctyOLD7DqvDxQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: CC rust/ patches to qemu-rust list
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
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

On Sun, Nov 10, 2024 at 5:36=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 10/11/24 15:19, Manos Pitsidianakis wrote:
> > On Sun, Nov 10, 2024 at 3:59=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org> wrote:
> >>
> >> On 9/11/24 19:29, Manos Pitsidianakis wrote:
> >>> As of CAFEAcA-ZQuyGTtG-vhRTEwpz0L4cpimNxkKix45Yw6gVHXozRQ@mail.gmail.=
com
> >>
> >> "As of [*] ..." but I'm not sure about the usefulness of "like
> >> qemu-block, qemu-arm, qemu-ppc etc but", maybe scratch it?
> >
> > I definitely find it useful, for what it's worth. It's an all
> > all-encompassing topic, like block or arm, and some people are
> > interested in keeping an eye on those topics if they are not CCed on
> > the main list.
>
> What I meant is to reword as:
>
>    "As of Nov 2024 [*], we have a new topical mailing list for Rust
>     related patches. Add a new MAINTAINERS entry [...]"
>

Ah I see! I only wrote it to show there's precedent for that. I'm fine
either way, if the maintainer wants to alter the wording they can keep
my S-o-b.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd


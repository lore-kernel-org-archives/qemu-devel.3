Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FE0CFC276
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 09:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0dt4-0001oM-T3; Tue, 15 Oct 2024 05:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0dt3-0001o8-OJ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 05:30:41 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0dt2-0005Ji-4m
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 05:30:41 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c9454f3bfaso5470742a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728984638; x=1729589438; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LOVskkNiyvffesZLUQWmCggFUG+nC1de+OfZv6/KIac=;
 b=gdFL6jIsqI8hrdlx6PZUBaKx5r/Sj7a3SbH2m/oGUkD9NDak7NUbRXGeUAw8qv8Es1
 NoW60Jg6VnBpRkUg4I8sVH6vncmmKhLrsj9u8aIXTh+12IL87Tzru1PzeQMQj8qAmR+o
 CnjjQUfmpM2OOnr/E8BgqKc6xq+YCgaDnSloqas3fx9LuJQYfJ2dswnyrCmhP3lPztrJ
 ldlGMNi+6F4jTut5p3va9xjhFcZ4fj1OdqLF/gxl7Gp2rlx7CaPjvREFBOpGu1S5wMR8
 xqlkem6KxSLiQ/lKSOy8Ad8M6TXoPXgAPuHQb4iJcDlpxFVe8zlm5ebv9XlTGWPKK8jC
 aCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728984638; x=1729589438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LOVskkNiyvffesZLUQWmCggFUG+nC1de+OfZv6/KIac=;
 b=kCYjLXNf/oheZtrv9BB5XDgcdLDoIV7i84YYN9gJxz/rB8WsJzaqVP64z5Su8wxwed
 cqstoCQ6yWwnYdqooAMZbil5tYFZJOlEScv7VutPDlXk5AfOfwxdyExov1pJtEert7RX
 v6ccPRkpG63c3YOseimX24V94l3KoR+o4kuGNQE0geJWgKN4YposFbgsizXFesh/LEzw
 insJzeYxarg3ivsPh2JdrpJw80ro/ECfDbk6JAP7dgpLziVI531psuEDCCBxGHmLZe6F
 TB5yr2zySTtaxyGvIhw99UEzZIBmUNfxXGGzcddmqHJIbeiw95wV6dVX4gNxgIzFbBV3
 hUwQ==
X-Gm-Message-State: AOJu0YxbqKwgE8wGyUCPX6zvUDQQwNRK2C58py04hIko2VRRGVJ7VGhw
 yVSOWWf7lhFMVmS+eCioU7Oalfi8CjhuiQUBOrDQJr5y2Di0uTtjpDxf4k3D7h2+FDiOqBCh4Pd
 yPbyd2inqvxC2zMsSyMYsmiH6WtNzM4FOGz4ae+GujuiBRHmf
X-Google-Smtp-Source: AGHT+IFkue5a+W9SuAWFJP3zbhy/R+pKr2ZcKYdtB0Prj5qKlprigaDZoS8bRS/L3JB6zdTWBLo0TawYkLK4tHglw+M=
X-Received: by 2002:a05:6402:1e91:b0:5c9:85e8:e866 with SMTP id
 4fb4d7f45d1cf-5c985e8e9f1mr3580991a12.22.1728984638439; Tue, 15 Oct 2024
 02:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241014133935.470709-1-marcandre.lureau@redhat.com>
In-Reply-To: <20241014133935.470709-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2024 10:30:27 +0100
Message-ID: <CAFEAcA-Cz3AXCvnUEZfNymD3rVbFec=hqrnR3RC-TVT+moFBFQ@mail.gmail.com>
Subject: Re: [PULL 00/20] UI patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 14 Oct 2024 at 14:39, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 3860a2a8de56fad71db42f4ad120eb7eff03b5=
1f:
>
>   Merge tag 'pull-tcg-20241013' of https://gitlab.com/rth7680/qemu into s=
taging (2024-10-14 11:12:34 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
>
> for you to fetch changes up to 4cd78a3db2478d3c1527905a26c9d3fbee83ccac:
>
>   audio/pw: Report more accurate error when connecting to PipeWire fails =
(2024-10-14 17:35:24 +0400)
>
> ----------------------------------------------------------------
> UI-related fixes & shareable 2d memory with -display dbus
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM


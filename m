Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FC2D78333
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 16:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI95r-0000kh-25; Mon, 02 Dec 2024 11:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI95p-0000k2-I9
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:16:13 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI95n-0004Fp-Ti
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:16:13 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso1319741a12.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 08:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733156170; x=1733760970; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eQYqiZN0mnE+iLqSrf080J0Jxvhu8HV9p2u3s8gOcu4=;
 b=jKDQTxkI1p7xyTGfELNE8TjgEf79FCIzWAKNFS1Ew8ETx3gwSRN6l/n4uOplPxUxLx
 7uNioAr6ywfdDP1AJXKevJS/pQskUsSuam90Ob3tecaNjUq1kRr441z2pIIUUmDaKha2
 fh6bShQGuP9UCMwZGvGb3Vl4OApuPjMxwdMUo2Rfx8Lig0Nhu6xmrjrNS6HxGHv6j8tA
 bSniobXtszj6dG7x0+7/2eks67fOHVqkP1LUnDZh661SB+UEK7o/aWBcYYTU1WU3rhAm
 Wn8rDvgO6H7UkjNy2+uvqxKejCUC5bff0Owoi3Ap88JumH4jRy0qf1pVZ4oAT+hLlAj2
 fxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733156170; x=1733760970;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eQYqiZN0mnE+iLqSrf080J0Jxvhu8HV9p2u3s8gOcu4=;
 b=dD94yBJb9OlExTuCwnJJvYZvkEFcXeGt8gfwbwCn6MQrBkz1NCnXlQwDI5RpbmM8ra
 DEh6Hvpls0E6O35HOFxlAPUsdlW1PX7EEHU/zzh0K+0BxNvQlrRggjq+SUzbVKwWSnLA
 Cyoh5Uht7na5hbysgD87FTFSmTmhX8rG3jFTIuFqfzSkdw1g4J0v7m3/MV2yakQSqip0
 xBjNbiBtjt7mHZJvtr9uDBB2GeA1YGb639kxOfS2BvyfaEcqIArGF58bZw+WgMp6LXd2
 EbtiwJ4+KZqDEE0YQOKbxDA8nPF+YJVI7Xv7/SsbjpCecBCq89oMH/BppZQi5CvkCOBC
 MF8w==
X-Gm-Message-State: AOJu0Yy7NZZQC+x3854k/pBW9a9dLZ/lzdpBjsHuVv8hkeH82YUzUVn/
 iii6g6ijhvIRjhvaiaNxsJjEilk72qhB7alJRNj3YnkP4qCjOoQ6lJu3Li4+MMJJR6mLRusRDfi
 t9mykd9QOKgiNHYhdQKmIuKDyMdjrvzgnBv6YxxWpZApfkYyw
X-Gm-Gg: ASbGncv2qnnpw4dYciGWql+/cLCEEYPKjJtkTlcNtXE0lnlxZdeNEgbRfplmByB30uO
 tTW6D4AQ8yz7l/Me2JJiLxfHVo8VUbS+T
X-Google-Smtp-Source: AGHT+IF0GPO6uNdoNqFz5DGQnBJUCe9Saeo+OC42KvsEX5wBORPX8KINTlyhiLdYdjYTmHGcBxXM00IDhn5Oxzc4qgg=
X-Received: by 2002:a05:6402:1e92:b0:5cf:dfaf:d5f2 with SMTP id
 4fb4d7f45d1cf-5d080bc10a1mr28726870a12.9.1733156169930; Mon, 02 Dec 2024
 08:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20241202122709.100177-1-marcandre.lureau@redhat.com>
In-Reply-To: <20241202122709.100177-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 16:15:59 +0000
Message-ID: <CAFEAcA-pyPpNOphihm81OyfoSpKCOpXmtm_WgVha=EvZYvBsGw@mail.gmail.com>
Subject: Re: [PULL 0/2] chardev patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, 2 Dec 2024 at 12:27, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 72b88908d12ee9347d13539c7dd9a252625158=
d1:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into stagin=
g (2024-11-29 10:09:05 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/chr-pull-request
>
> for you to fetch changes up to e6214fd6d48e704ed3aed6ea2053a9756d0ca13f:
>
>   chardev/char-mux: make boolean bit check instead of find_next_bit() (20=
24-12-02 16:23:12 +0400)
>
> ----------------------------------------------------------------
> chardev patch queue
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM


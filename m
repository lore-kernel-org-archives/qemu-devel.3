Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764ADD3F080
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7Yn-00012e-AA; Wed, 28 Jan 2026 10:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl7Yl-00011f-4B
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:34:23 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl7Yi-0005GL-1a
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:34:22 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-432755545fcso5247004f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 07:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769614458; x=1770219258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tU52u0g5gOLf8qhYxOMhNyjYcZahjvbpxGi+GqNfADU=;
 b=RT4lg4GHsKR5WsDCTDlvQ4NAapcrvVgK/+hhEZ6hUmLqwkgs5QjTrfgeJ+GnFn1hY2
 OkA0AbmK81Bttspw2xksbvz+QczO2mPvIXjmwssgr2wFg2F20kEIPh/39qQN2+gaAfZL
 R/NtaAcUFFZO/23r/qQ3QpaJJ6vprTrdvMz8DhoIgj7Fk9kkmolU1qRkFG0VhyPxld0U
 cgwTAskSu0sftsb/ZSos2I9ptWajCkHja/eT0bJADOulQiqgqOMa6RECSyUG6ugCsjNb
 Ivfrm19eaLM3zOGeAVH+tgye5liwhBp1xSi+XrC8SC6Mt1N2+H0TMWnImvdbc9oB81oa
 HZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769614458; x=1770219258;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tU52u0g5gOLf8qhYxOMhNyjYcZahjvbpxGi+GqNfADU=;
 b=bGYj8U/FrH5meIlz1srx7Q24VOLQkCsMGJkxvHfhP7KUOHIxqtIYJrWnq2xoptKCJG
 WK+SxwDxenFRZ+fL/GrFQtAoeVrqwtvc8VM16uSyNnng145Olbfwo6ATYurH5BRPDNnA
 X0paPYJYBOK9yT/i4AXqLEUOet6G5oxSjUCK6Gyjc7+6KyefVw1SK9B77VsPfanvBdWW
 iKCYez+280CDJnVt9gv+I9AV5h8XpLlxpkOHnAat/V9dHy2C6wkuNFWqhmSer6s7MGqK
 GjByTML0DnK/NjFRWUkkwL6ViJXCmjaJCZKCYkFiHT9CXgOQHk2yZQmhiwIVyfCADcXB
 5EdQ==
X-Gm-Message-State: AOJu0Yzya6VpoM4Cl0BvFlk/2pUoKzHqhafi5D6+aEmpb3JaS/fbhJbp
 7vcsUW3rJTwKRIGZueoQpfCIAY0BVjuOtUgGqx3s5VNKvI9MZmsC0wCfjO5nToysiFE=
X-Gm-Gg: AZuq6aLKwog1BjIo7R45/oC4f9+7YlXDAWn8mdEwAteqUn0yv2ASklJhMIl05sTETFm
 8C1xbUtlvZtKMB5Km2DE/iM3Eh90uIzZvVixjKE5gfgkngQvdDJMASwQM3BePd1/7nHh745a4xG
 jHwGMR1YCpwvHOdpWHPAJMZpr8SrQhL80QN4wJWfwdV1W4BzNGL+7YKGjJxJEQVGbJVyAjtQ9Cz
 GwTPGsNfGpr5XnWPe8PmqdG3m5btrajFMpMucPN+2R4hNI+vYT2o3cYLyDHt7jqEyaHV0At5ANC
 wOgjLF+FjFDQCozWWVFabHizNRzke8HlRwbhHZrC86xrFABiGiZDIUdJJydQ0cJMK8gzLmf6c7v
 vsYBrvUaVbi18EVo7W4AEFQ3cgRl/wDG7ucKp72RSjyFxPUi9ShH9wwAuqjcJj6V9NlFFr35irM
 ZMpG2zLUbaqZPiFgMnXhUI+g==
X-Received: by 2002:a05:6000:26c7:b0:434:24e2:bed7 with SMTP id
 ffacd0b85a97d-435dd02c08amr8328010f8f.13.1769614457595; 
 Wed, 28 Jan 2026 07:34:17 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cf4asm8165654f8f.28.2026.01.28.07.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 07:34:16 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C00DF5F832;
 Wed, 28 Jan 2026 15:34:15 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  "Ilya Leoshkevich" <iii@linux.ibm.com>
Subject: Re: [PATCH 0/2] gdbstub: re-do unlinking of unix socket before bind
In-Reply-To: <20251225062919.685146-1-mjt@tls.msk.ru> (Michael Tokarev's
 message of "Thu, 25 Dec 2025 09:29:17 +0300")
References: <20251225062919.685146-1-mjt@tls.msk.ru>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Wed, 28 Jan 2026 15:34:15 +0000
Message-ID: <877bt1bvk8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> Prior discussion is at
> https://lore.kernel.org/qemu-devel/ee091002-a552-49fe-ae5e-8916937dba15@t=
ls.msk.ru/
>
> In short: when adding unlink() before bind() for unix socket
> in gdbstub/user.c, a previous patch introduced dependency of
> linux-user binaries on qemu-sockets.c, which is more problematic
> for usually-static binaries.  The monitor_get_fd stub which were
> also needed is another example why this might not be the right
> approach.
>
> This patchset reverts the previous commit (with fixes for current
> code), and adds just a single unlink() to the original code which
> handled unix sockets directly.

This isn't applying cleanly for me. Could you re-base please?

>
> Michael Tokarev (2):
>   Revert "gdbstub: Try unlinking the unix socket before binding"
>   gdbstub: unlink the unix socket before bind()
>
>  gdbstub/user.c    | 30 +++++++++++++++++++++++++++---
>  stubs/meson.build |  2 --
>  util/meson.build  |  2 --
>  3 files changed, 27 insertions(+), 7 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


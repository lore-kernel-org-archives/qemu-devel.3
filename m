Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D07CC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFxQ-0002k9-0A; Tue, 21 Jan 2025 10:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taFxO-0002id-F5
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:14:22 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taFxM-0003H9-L3
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:14:22 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so2980648f8f.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737472459; x=1738077259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRpwSG77mXW3G+JGUNWv32Ga9oGjRH7jT9Fo2j/GAq0=;
 b=zmVI9bsfpxdI2M7ABa9lEF7sfcfhCpvNzrlDBBv4+wAdC3/22pyzcLMJ7VcF/f9MCp
 1uf722pe6JeA3kGdGTtxJKRQT3/25dM79ByBeqr/RMh1U6xkWZ3MA8zdxRH2t5bwrOnU
 7Si75K0K9l0DpKQ6a+vzj2pz4VE6d5H0k5v+jBZF+K+Bi2Fze1nFmVUlZ7KQVHHarC7j
 0nFBVGYHt1MNGjqq3PIzk2OmVBaSFI9JOj1W+2fE1PmLX0kn8BpeJBaBOgcU9xiewu5G
 QhE3AHFmcOdFdxMEEEzsGjiNIMd0kqnVYxzreqbUkiCk9LA6HbxkLy32JtwAavwbPdIt
 2fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737472459; x=1738077259;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MRpwSG77mXW3G+JGUNWv32Ga9oGjRH7jT9Fo2j/GAq0=;
 b=YFdhmgLIaBmyBqRskYEYpZqG0VS4r4xclP5ZpV3lW8/pZjrYWnGFcJmoqvYKXKbqg/
 3k4caWab4d38SX1GmuqOXNEqvbKT9Iem3j6Pt9XAXKD72ohDef0j1UKyaJDOsdq60cK4
 3HfQkDsFqgb2Nvs9ka8tpRSgCE+4yVtLWzZdRZ4VqbX8VswZ4aWb3uG1Fou/zpaogQoX
 l9BHvWoKE9Z1XZXupxCiXAYQJZ4WQEgpqD0QbcTocak17DBbdVcXQP6a1gxiXQOIybPH
 Aprqdl0Oh5Rw54xJuSgVFYiHZ1KVhaakYNTUZlvEkEs7T82po7tlIlvUtiw/S+gb3A8J
 CO8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnetvLmQsz13/NhAt3ejx5IVsN/4KOZjPAbAi9ZGKoR7H/uN6CbkQe5iJg1Yi7xVd9c5wjSuAN8Wm9@nongnu.org
X-Gm-Message-State: AOJu0YzVpgD2//Q3hjAGztvEZBPVmmut6ziJsVpatnSAaSvA45w9bvlf
 9RHW7/QdGeTssSP9jtWuKMfzE2RggTMRDuRUhPLni29YFXn7E8IaZI7uX6mjWe8=
X-Gm-Gg: ASbGncvV38F4QwfIZLVDNlYec7b3VrbqOmySVd0Thbq5iAa42XfzraAy9LnVksL4uBI
 UDL2KdzpVg7WxYNyoQwq4HXt7jB1fTP20vIZWxVX03Z8pE8yyda/gii7kO6dNh8/AYdnJEoUHpq
 FKzqGtNW9tnVYpWF0fOv21Xmpx1N+9YF79CzBQeL8oNg4LUcvBCKbMRUY2R5qe/HmkKey3HXY+3
 t8sRXU7cU5Fi5H0jDip96kdyg901cnsgBVgZSRiKj3KkH9+pECr+uzI6FrNpa6dEW71
X-Google-Smtp-Source: AGHT+IFb4k9SFP11srQheU8IlnuazNGYjTmFXs8SeVrngmTGMg8tvuKtpORYYhAxCxYvqQmo4iSefQ==
X-Received: by 2002:a5d:64e9:0:b0:386:2ebe:7ae2 with SMTP id
 ffacd0b85a97d-38bf57b8aa7mr16195743f8f.45.1737472458521; 
 Tue, 21 Jan 2025 07:14:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3214fbdsm13947602f8f.19.2025.01.21.07.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 07:14:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 131F95F756;
 Tue, 21 Jan 2025 15:14:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v7 1/4] chardev/char-pty: send CHR_EVENT_CLOSED on
 disconnect
In-Reply-To: <20250118164056.830721-2-r.peniaev@gmail.com> (Roman Penyaev's
 message of "Sat, 18 Jan 2025 17:40:49 +0100")
References: <20250118164056.830721-1-r.peniaev@gmail.com>
 <20250118164056.830721-2-r.peniaev@gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 21 Jan 2025 15:14:17 +0000
Message-ID: <87r04wnqra.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Roman Penyaev <r.peniaev@gmail.com> writes:

> Change makes code symmetric to the code, which handles
> the "connected" state, i.e. send CHR_EVENT_CLOSED when
> state changes from "connected" to "disconnected".
>
> This behavior is similar to char-socket, for example.
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  chardev/char-pty.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index cbb21b76ae8d..10a6ee94d55c 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -181,6 +181,9 @@ static void pty_chr_state(Chardev *chr, int connected)
>=20=20
>      if (!connected) {
>          remove_fd_in_watch(chr);
> +        if (s->connected) {
> +            qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> +        }
>          s->connected =3D 0;
>          /* (re-)connect poll interval for idle guests: once per second.
>           * We check more frequently in case the guests sends data to
> @@ -215,7 +217,6 @@ static void char_pty_finalize(Object *obj)
>      pty_chr_state(chr, 0);
>      object_unref(OBJECT(s->ioc));
>      pty_chr_timer_cancel(s);
> -    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
>  }

It would be nice to clean up connected/s->connected to bools at some
point. However this is fine:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


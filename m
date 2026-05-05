Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A7CCD3430
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 09:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKCNE-0006EC-Mr; Tue, 05 May 2026 05:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKCND-0006E0-3u
 for qemu-devel@nongnu.org; Tue, 05 May 2026 05:47:27 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKCNB-0001hw-Nr
 for qemu-devel@nongnu.org; Tue, 05 May 2026 05:47:26 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-651d6347a69so2253466d50.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 02:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777974444; cv=none;
 d=google.com; s=arc-20240605;
 b=C1Amb1k2LmO3d7rMlKvH6dzKBac3vhFTQIQp7Se+hN9qxogE6v5bbBx2XnpT0oCfro
 6g75x6aUqRJiGX2dWEIrsKXogUYa5ra4qOz3Lf1G+L9t41dG2qZPHSvV28oRECxxqGzm
 7e+cO7l/0nnO/IzVrAVeQCvP7w4KpaR5QgFLaflUOJPipVrWHyvqk52brikUiciy3+K2
 b1L1FM/+M7AX9fa0Hcpe3frxdovbgVW6aEBfvY9Dmp3nwHEuEpKnBGokyekoV0+C1EHK
 eVDtM6+pMyLM4uLVxrkMgMYSRcEzzKF5vR0hRaXxSVyNGR1zT4IDhWIrunmZNsJZIcQB
 h/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1vYQ5E8FqXtlYayrQbLUUaL7vfwfTmIpDVZOYWW/roc=;
 fh=+1firF9KONN4Yc1L4UE+f7hjZIqv5yKMPW+CbJoXUyw=;
 b=B94GZzmi3iRYNpMT9UPfOfR/NYuNquRBTVwwwTfTmwLvpDijjeMxbbDtLfhhqK7u5s
 RgES+6zgfDUe6ne6oDjbdixBtn8g3Yt2cp3UOqk+4MlusJEMWk56+09WDMdyEtSokpLJ
 oqx/G1yd2aaTM5D/ehKqNi8XTW7oeFEPoWws72sh6p7d8AiunHxx6scS36vC/FtPLK1z
 +lcVL8IAc5cqbPtv+OyVwR8ZHD7YYDRQKa328u0snN1h8zPQZfACSqMxUV5nmHfgQTa4
 5zVUK64iRQwLAR+gFXyFDKI0ge2v7l3n6TVmSzRFI0hBmj4g1BJW4aHuxshYlPKcP6fJ
 z30Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777974444; x=1778579244; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1vYQ5E8FqXtlYayrQbLUUaL7vfwfTmIpDVZOYWW/roc=;
 b=slkNbyc/fpZoZpY8b87diAUg5R71XUOgwzNFEX76ExrYNe3q6IgLjQjBopklYa0kNA
 hxkiTqnJkio2BDDUiSV0hQU85zKd9jkBduc/GDI2uWQsQvvHfg2itpZre2f6m0GELu61
 hSvU5JH0y2yToyAKPuQ4nKZ50g3Wk74tdoM/ee7Qh+XBigvuf6IKQDGlK0pIGH0x+uEt
 7ik5jPyd8fm81aYTND/swtPOhiMSyzVSwo2F3wURKnWZIu+7nuBMxp7HyqNzFjR7MQrp
 6sO8e/raOm5xvTQq51tfmSeaLqukGnb6Fru14HDLlGxZEqvxIV/w9QyVAHzOGkIYe5BE
 vaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777974444; x=1778579244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vYQ5E8FqXtlYayrQbLUUaL7vfwfTmIpDVZOYWW/roc=;
 b=nZF87xqyKnOXMj3GpSDlcVFVysAxBY5unKI5o4SLLqrNOUShqx4eNA6cRf2Wz8FyK/
 uneKH/fYJg6eSOMAIJApvee9Nvd1FVPnUBD7BzCgOFCAVB5cSPHi9W/Vo6cWsIssX9z6
 lk4bozvdUrbJE0xRwHs8TAb3XsD5qRlUcxdF4sgH7m9LU/DHpTpJCxJOD/zr9NUP8MLq
 EiZd5yZfD1qsONwDKB/OxBA652o4cGQp5uwADf3jPg8jOyN6CxbNQtvsgohV9oDctSrI
 ne1+y1UhoQHEyx7akq6ZzYbXC6FicXk535inlf+36v38hlIaDxPN6WMZGoZA2ciWpo2m
 jsWA==
X-Gm-Message-State: AOJu0YzV+l7LIoSgPgrhz/ywottU4lrmJ5+Wd2xM2T0BeVFrGlyPz9iZ
 ERE1vwxA/HL0luf6/zWjXOhwaIpsIbBeQ8e8q5vTad/RMeJWkOj0GtWrTWUtwSQhgR/4NThrjFi
 /VyOJcHWyGvM3eXgALEw2uXUUJigjQnzzOvNJpRPDjdX5Oq0KnAuj
X-Gm-Gg: AeBDiesjwFvj/PXpPapKzxZxjPLyaVQQNSFoRkV+xb/y++gjh4UxwKHCQEuGgI+sSlR
 8eP256K1PmjpGyNCUuwyMwOgu3Tudu2+WCN7jecDMEzZ8jMW5fuqu3BlxjVk7C/oIVZyi/FkLKD
 KEXApywn4+nvkseNgUYLt2ohRfnAww1uMd1h1osFysQr0xG/BqIr5LW2lxuiU4toHLkU0aanwy3
 g91OonaPMoP+cyBDqnKTEgVOVdQfXlDbYeIXha4U7yUV2FOmNrWcMVRMADvh7Io6ykfcViFq2AI
 ieaDl4Zj6JojxcT0mBN8qy2SAFNTN1+//GOHueU2QNTKy+NPqd67dYUIs2VSGVz7Gdc2k9h539z
 ckGz9CfoGgp6c
X-Received: by 2002:a05:690e:1285:b0:65c:72cb:8a97 with SMTP id
 956f58d0204a3-65c72cbc267mr280293d50.29.1777974444199; Tue, 05 May 2026
 02:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
 <20260504-qom-tests-v2-30-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-30-ef7e3dc94f7a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 10:47:12 +0100
X-Gm-Features: AVHnY4Jq7T8VsPxQgg9YY8vyxcp2fM0b2uMKIPruQTgxYDgZ1bvC69OXYHiIQek
Message-ID: <CAFEAcA-rJK-Ot+3_L1Hx_s5KWesbFfOmgCbS9voYEjmBH07X5w@mail.gmail.com>
Subject: Re: [PATCH v2 30/46] system/qtest: add missing qtest_finalize()
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: multipart/alternative; boundary="0000000000002aa24f06510eefd4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--0000000000002aa24f06510eefd4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 4 May 2026 at 12:38, Marc-Andr=C3=A9 Lureau <marcandre.lureau@redha=
t.com>
wrote:
>
> Free owned resources on object finalization.
>
> Fixes: 6ba7ada3559e ("qtest: add a QOM object for qtest")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  system/qtest.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

--0000000000002aa24f06510eefd4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, 4 May 2026 at 12:38, Marc-Andr=C3=A9 Lurea=
u &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redha=
t.com</a>&gt; wrote:<br>&gt;<br>&gt; Free owned resources on object finaliz=
ation.<br>&gt;<br>&gt; Fixes: 6ba7ada3559e (&quot;qtest: add a QOM object f=
or qtest&quot;)<br>&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=
=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;=
<br>&gt; ---<br>&gt; =C2=A0system/qtest.c | 10 ++++++++++<br><div>&gt; =C2=
=A01 file changed, 10 insertions(+)</div><div><br></div><div>Reviewed-by: P=
eter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_bla=
nk">peter.maydell@linaro.org</a>&gt;<br>
<br>
thanks<br>
-- PMM<br>
<br></div></div>

--0000000000002aa24f06510eefd4--


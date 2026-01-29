Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3733D61017
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSI4-0000vi-Gy; Thu, 29 Jan 2026 08:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlSHx-0000sG-ND
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:42:26 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlSHw-0006Yb-6t
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:42:25 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7947cf097c1so8250447b3.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 05:42:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769694143; cv=none;
 d=google.com; s=arc-20240605;
 b=YBFbxcMrobhG2dHT/lhxUidSmtgYpImx8f+r7yM377s5N24e79WP89928DbyIr+lGF
 X32wAXAuVhV2Y9E/UHTu3dyDkE439NtQ/fqbCuuUnPN8s+1G+jAqRnCYHmCvexSs0CSz
 UjvPeU99ZxsPcrxXvvW6ZiY7SXqZxMx+SAIwm6PIaJXhttEhMrThRQ/HXL901gr5B1vH
 J4HBcdnBfDqQWsrBC2OtIsfAZMdDRuAv8qLfTiJF02LaVy+m35wDNzeWIfSf3dFNDgL9
 XdaM2cYI0U/Ku5AzJ+Lmksqs9zU3Yhvplsv1HRBH2yMJP6wmQxy3VMncWKuJBaBWwuIH
 WjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O5r4UfOeyOsrbPZo+03Q2sF9IU63bcV44LZPRmkbUZU=;
 fh=axbB2bjiSokmisYx3H7DI5yUO3Z+Sykod4F4JR7lPwk=;
 b=XohAOjWcM+iMyJ2JEsmlzHHIMuB19FwoNGDx8LyxBVomiGqYXazCFHLB50wUOrwwq9
 0LtMEDN890NpWUn9O4ODF2VGK0d+6AGaqrUgDG8WfMhdNtoTKxMZ9zm2k5jvvm6NRzln
 8xMxunaalc7HsuRdBjl8UdFeQlQtFsfja6X4KABWO6aAHGoguPaB88APva8PA2boUl8F
 xAinePcDq/Z/aq3d5cdIUsKBCo8Lv/TyuINYvKUp5HmCHqcUoUt7zMNMCPT3BpfXdiXX
 iifLUtZp4XcpMPM3Bh8AvzhpN3JIKQt5TG5LbrE4yqC+V7c5oUlxpMe8Ja6qbZnRQbpX
 Xa+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769694143; x=1770298943; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5r4UfOeyOsrbPZo+03Q2sF9IU63bcV44LZPRmkbUZU=;
 b=nGHSKTMdICQlmj2/NkwXWBC2LW1fsZERCW0H5G+rRghCVv2MeXrjXs1uc3UPT4Y/Rl
 Cwpgv4Ni5bZQIl1h/GV1zhY5jkV6Or4xUJ7tIRCMolNSNA6ktVqpfrKf6FpS6pQ49VUM
 sblRCv8GusqNHEH0gHMcszjgGxIQoWyYfUbo5cVEc1pN1fAbrWhIBlzkH56eFq/nCcP4
 X8vDkOqFZUzI/0f9gmXQHsySSMzyqTJOwxirLkIrH96nGLbbvIGOBuMtu3wlNV6iy/5E
 H5etnxTMAM17wc/ptKcwt1wOP89/urCfJI4aP0Zq7Q/dCuXx05l0C0g245hY8PWOTxyE
 E6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769694143; x=1770298943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O5r4UfOeyOsrbPZo+03Q2sF9IU63bcV44LZPRmkbUZU=;
 b=rZNJyZzXwcAcBDIYPUHdzs5Ysh1U3vx5jCYxR7ESULQqy6Ozvq+DJ8cf9fuCsqxP5B
 kTSnPIve5qSq9r6Rbw6jQid6sAkOh1V3vVW4uhJZvk47ZQwN2cc0++iTmmd2iY9Fectn
 URxKUB3iw364B6LtM2j1uKxEIAS6T3uDprEqNbQTANC/EmvK5Chk781JqZUnHyfqsDYw
 tjbZTwefH+lexhXr/MzQBvUowz8NKzdaNhWhADCuGLiza64J6izbPGWX4/M7lmsY/YKY
 xp9+f8le9NTj9uxr+ZcgRZhTwVXgkETw6/XWdi5GiEeiKbgWRtwS5Fxi3Vr+WOY3UvUu
 /gPA==
X-Gm-Message-State: AOJu0YzJUdi1HFkV3CS5yLEtFRuUsxODi6TLSc5TNFrgD5QSG6Fg6uh2
 +zgUooDyyRSOag89oEO3KiSWztw+3z2ciqth3DpcAICY5EhmBcJImi7QZ6dTzsdYu7+opIxtAxi
 aQRRAlyyY8TZNkBXf7evSwIzlzs57O20ZB/QptKX+eQ==
X-Gm-Gg: AZuq6aIzOZsxKMrrr3UvM5VLNIv60yy8r58ReVsZMDHNilzxZ8Oa8gxrhI1si2I8JDS
 f+z2RR+U/7CbVd5tJsLIFrx8xfI1ycKwkQFLNqy+RzwyNaOPx5/KIYJ3jLXX6Y3vbfki3Stj9HK
 eZUCS9FHur29jgU/94DT7c59hqW8ZlhTbjLvId0U57TYzBin9yTzeUc4KGCtKXfFFjHb2cPGfCf
 DarIf6bxz2wwpp2uQSs8M3tiqI7UqKnNUX3egoFrkaZtJtkczo5ENiHSMb6ti+yNuHEoQ==
X-Received: by 2002:a81:a608:0:b0:78c:5b3b:d234 with SMTP id
 00721157ae682-7947ac4b4b7mr59462267b3.50.1769694143105; Thu, 29 Jan 2026
 05:42:23 -0800 (PST)
MIME-Version: 1.0
References: <20260127145928.3073826-1-alex.bennee@linaro.org>
In-Reply-To: <20260127145928.3073826-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jan 2026 13:42:11 +0000
X-Gm-Features: AZwV_Qiy_4TiDOuMJ1XHukCFd8jU3dFqqUUP5m_OkU-_huMrIeROY66oo3E9DJw
Message-ID: <CAFEAcA-a4roVh3P8vcrzHV-YVKRA8omQh+p9kkGOYyX1zyaE4Q@mail.gmail.com>
Subject: Re: [RFC PATCH] MAINTAINERS: add emulation.rst to ARM TCG CPUs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Tue, 27 Jan 2026 at 14:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This is updated as Arm architectural features are added so we should
> catch changes to the docs as well.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>



Applied to target-arm.next, thanks.

-- PMM


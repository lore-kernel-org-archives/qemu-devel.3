Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26148EB48F8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 10:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqU13-000696-BN; Thu, 12 Feb 2026 05:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqU10-00068t-9R
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 05:33:42 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqU0y-00052P-0K
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 05:33:42 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-79274e0e56bso31137167b3.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 02:33:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770892418; cv=none;
 d=google.com; s=arc-20240605;
 b=QM/3RaZ6L9rMIGMbpC5ggX3umTdeDO7B5oIHldwo6pJhNnRacvqoydyH45NYlRcOC5
 MmbNwYRl/AcMR7b2YYNtVziPlg+Lpgdw8jSzI9HOG29BCAtuz+cDajaoGx5trERe6wn/
 c293F9k4+lB5vb3xHJrofIVITeS8N4KdZtrHVRIPPpcxAuOvp396gzMwGJZth7BtTRAr
 swFtxWxpszWwqrHYlEF1RRs5J8t8L4IrCPi/ER0sy22M4k7Crtn4+5Lqw93UPk0NQFtJ
 UIB3iR9t33cuV6oYhSN0HT9GD2L93kc6pd7bbm6Rt/80tkiv7uotlF+Hl213YsSixJZs
 zsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fcHxsFnBRXjilEXONYg/KXP/DaDR4TUz3QRvseIMOb8=;
 fh=Ly610vD2hksBMnIX7pjXfFWK3IRLkg2Aiv8hYzW8svs=;
 b=l0wV+vfq+u+/I54+pRbYuLgpQy6LLm9O4XGFB94ZJI/tuWZ3/De1gwU6CQXcNp097a
 aXzeIseCo6VdQAeS9OF2OGR0+SpyCupGfvxHYFyC7jlLewOgbt27h/NP3DOpoDh246zp
 MhYLo2JZoV3g+mDxDWnMTX2tObIlh7BEbzXOEjlcHP3c7x5NmhdtF3dBA5YIyOqPEoJo
 wQX4183uwDELyQTfMRG3tIvt3UPIv/nufKHVOJsAXEI67exGEByJcpj0OmmzYKfS2ztj
 hW0KsbMByHyFG04SYNAoAdE0H6EHgAEVgTy3BxAvB6QQTfGEUFqOlgrbw1sLy16ejAWS
 yang==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770892418; x=1771497218; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fcHxsFnBRXjilEXONYg/KXP/DaDR4TUz3QRvseIMOb8=;
 b=n49FsOJSZBD1ZsZE5wy9hemgRd30N+uNYkH5EVzL6e+M79ITCKWpLxelJ7A/PHn8Ik
 tyylZGTusgD2/HFUckwKuMx2+1Tfj/cbT6DkPVPDYiMchIKWcUb+h/yikp3/Cb96HW1j
 DYKMo4oU55a8Zvy/HwKVCwTQ3J/KrzfcXUinpZyVQsnjp34jci6vJI+X/2NmZPvxn1Kq
 g2AwVRY1hqzQFoPckdAzzhfQPW8OZSGaGcWQqoScmKGLJ1hOYn+ynOwVRWy2BuaMgeGR
 qq4ABjdkIHbkJWpPquG61HF+D/tr1KZ6y+iyhZL3jWOJ6nfRIVfYUZzU+6me6kBm0Dvs
 xxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770892418; x=1771497218;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fcHxsFnBRXjilEXONYg/KXP/DaDR4TUz3QRvseIMOb8=;
 b=M9IWitiqgG29k48ntUlGBPGTnuZIQcLbKvksEQKLF+sjbNQ+xNrQf54g35xpK4Wq2z
 bJ6xk9HuAKcwe/nxAdJ4rboyzVeTfDf0u1k4wxKC/EBUOD9R8S+x0ePEy1bXmPRBUvqm
 cIW2GxDhliZs7ONubLUXlO0nPwvLi9kh+LLIZaOdTb0EbkP/jv65zMZuoXrW8DDLoJxg
 YzO/H0XYr8FF1+93lvc+F/f0ZWxJmxhM9t/xrfs42dXwmuOL/U6lVebKbcGXnyAZSoyJ
 U9jxmxSVMOsPS2sifdkRiphM9S+9reos9gqCGG1m+P4QjZLspcQ3dfPyJK+4HlS9Vuef
 CMSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBQ5xrMBiHgM523uQdH4HwNfRAdx62Qkyp7N14SJ/YAgHJ11208A988KPoVwFNe5KaqURTBoFvkCOX@nongnu.org
X-Gm-Message-State: AOJu0YwzWGXaK5dfGolOLTa+FAMUv1OY0fp94YZbVBqd3GPCvMLL70gP
 f1X6ng2Kvli5I63xZ655I8uMD0OWpaSc7aYGRbor91UX/HNDBK/HBHKNwNKBD8GiwywH2DLe7d2
 BFPGJan5ohZ/y01ZvQ1dHoYY2QR6xZSVA2oe052BMMA==
X-Gm-Gg: AZuq6aJS6b2AiktbaVqiKDtYJu2PsvbLIUpLe/26a9cgDHGvFKlLvVpkO4tc4Ti2+TN
 7fTZsbqaGUWuivQgQXQeY3k7U2HFxkCrTxfqeU8t2lmrZ2n86mdEWC9dHYPSfvt07ZJmlfRUscr
 gQbAlDKZgd56AFU6CUIAeC1CyUxbQTrb6b9D8OafGO8i515qZRwO2674G7/b8P6L87Z+Txn0fZU
 iWPgRBJB3ORxHzIiyEF2sFZK+ayiIMOPCBG0H/ZO5jSdlBU/ypuSO4TwRG02nhS8da3SNd+mJRD
 OpjppPA7S6X97o4+aOZvH7BieXvB08ErfSr+z+JQBsRRFmBdyKcuo1JqyswvkJAPMWk=
X-Received: by 2002:a05:690c:101:b0:796:4486:b82b with SMTP id
 00721157ae682-797931fbacamr11647907b3.69.1770892418005; Thu, 12 Feb 2026
 02:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20260211204445.4124071-1-samuel.thibault@ens-lyon.org>
 <CAJ+F1CKZUz6QDDYj9g2NeyKimOrcXDN-ZYG12CYg2pJn9s4Hjw@mail.gmail.com>
In-Reply-To: <CAJ+F1CKZUz6QDDYj9g2NeyKimOrcXDN-ZYG12CYg2pJn9s4Hjw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Feb 2026 10:33:26 +0000
X-Gm-Features: AZwV_QgNc8cMENMBKrjj_AADOnN33nUK_eq9Ipt6W7k-jcpFjmUNGlivEs7CmDU
Message-ID: <CAFEAcA-hvi0=eCr=Bs+sYBJCgAQNsi6kSyo7=xFHq8AG0MNyZw@mail.gmail.com>
Subject: Re: [PATCH] baum: Add copy/paste bindings
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Thu, 12 Feb 2026 at 09:44, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Those commands date back from brltty 4.4 (June 7, 2012). I suggest we
> add a version check to the brlapi dependency.

Does any distro version in our support policy still ship such
an old brltty version that it doesn't have them? If not, we
don't need to actively check the version here, I think.

-- PMM


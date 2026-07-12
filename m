Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063B0C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 13:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiuTi-0008O2-7s; Sun, 12 Jul 2026 09:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wiuTg-0008Nu-6i
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 09:44:16 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wiuTd-0001h3-M1
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 09:44:15 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-697cee2eb6dso2319192a12.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 06:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783863850; cv=none;
 d=google.com; s=arc-20260327;
 b=IvpGMJir8B1su+/E23+uDcfeDlzKdhE0UgMTX8sKeCMycDEMKvMO0KI/uStc+KOpQ6
 +sj5r9Yvq9jEU/yYwKFPAuwCwzour9wFwZWRtbfmB2pJWmP6wPcw97DSTDdw9qBKlb/m
 RZ3rlKgLLFaTStAxvMoX/Ms+1fislQWqeXtgqEaQosD2qkC5/4IBxvyOMEwlGbn1+CNd
 AC1md8PmlbF3dhZL8gt2EeM5D12YZdFu/SRcMQw2eyVQbWug8iazfkM4gOTMJ0s0R5BL
 zICSgz3yNqv47sfOYmxsjJw6zNfD57QKy6CKCLwd2d27/QsISfswRLo6Vaghi8fm4icw
 ITnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+x3Y3xe0RGF5S/VJKq6NxiM8ecqYYQdqTlSSZkG8W2c=;
 fh=lXeZXBkrXVRxg/W4X1XOBP59D/GUDgVepVz7es7hCbg=;
 b=gLBLea6TcKxw98jddpAC4eVi9i/yWuEZw46ROYg1aZw5dRDWXdVLDSyo+dggOe8F53
 fZTW9qso70dW4/IDL0CWPgRBwTDA/1L99UjMdxzPFEVQvgHiDzaSkROoZvlIm2ryhDrp
 ultkZzrXNkiEbjMDGR7+rVSXP1zQHa2RzsPEfeXWTan7iVensCHwQ8jOwqryOTIB4i9X
 yGXVgi/OPyJS8/xVuynxOa2k7mPsen6QgfSYwtl0wk+adwVoBKwK3z1UmRGkVQzuR/C8
 eeo0dFFdj/rLLitzzxU6lrGsE8/WujETa9JrxdFSPJZCIT7rZiZQzgLnJ86ED+bFQF2T
 C9Tw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783863850; x=1784468650; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+x3Y3xe0RGF5S/VJKq6NxiM8ecqYYQdqTlSSZkG8W2c=;
 b=XcAx56UBv/DaJuZVbxj6FFJFl6GA6Ttvhfji2Hany/41rzYQSkyS/C968oWI1wZ9TP
 I+v7l1PzV4cUkcMZWwt8VvIL6Nj1JzuInvJqrof3aT84zyBidWRmtu8X4NuqXR0XN7yr
 n3GShiJoCZNbKSmVajeOrqyjXSth1vZLSwrEmBcfpIEqhq44ZQfMaFuWiaZ2olt3uM9C
 G1eyCLK1LOPI3qa6mUI5b/pEiNjWs+V2x7y4w9S1J63WTuXeX9geAPREU/BD6nWQtIu5
 bCo+M8RQG07b/YcS975+3PomsDOhpKrhPfaqktmZ9urRN+T/U07kn3RUCY7CsYZ01wZA
 z9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783863850; x=1784468650;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+x3Y3xe0RGF5S/VJKq6NxiM8ecqYYQdqTlSSZkG8W2c=;
 b=XLvl/qC+tDutY0Og1JWLV6nKMv0OdLLwUfnBVuuSh76dXdHEnpOVCYlv6r5M7Mv+m+
 YEInKqhdC4W4nHl8GMQUsCOXFYoimo+Eym5xim5v1D0bI0yO+9fLzcKpZiz8Blkt9XLC
 DWJUchkFMx3ekTkHxWqY6/pesR4sXft3LriHHpThQb3nY32iqZ6ZxbQJN+uhmrIUYKWX
 KaG+XVk33JTcrv1C6+ZzhNEPITFSXRCCbvQVYqfWrnWxMoZBm59WkvtKHp0bSzZtBV4G
 +OdwecPzfjJgqPwrG8OeQj0Ny1vVkukL4OsFeOAzJ9Tfoxi6c8mVV2AJqR3XwMYWoTjS
 +o0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGjaPFLYanJITHqyCkp5LBBBfOkCHzyBRQImWv3/rc40n9SBeCBgPZznwGLAR52tg42P3ZaVUXyNEY@nongnu.org
X-Gm-Message-State: AOJu0YwFQQYDWxHGA/LJU1wPxZM0eg1ja63eoz3PX+86kMgBNFgtOIuw
 tD9zmEt5Fjc+G9V6J5gD0IcEh3BsEyDHW4N6KL6O5khD0cUDd6Ni1cit6+gFXv2Ygeja5+Bqgkn
 DxPyn+YmjcD1YThEs3IBox+niBx3SML0=
X-Gm-Gg: AfdE7ckVgQ6njPNK5wvhQecQIks7Ru/w5rSK9VFZU+7Sb6mxbzEgpFRWVhk2eqO625j
 8UiQnrVszViez5qkD4wgSwk102lSO9L6lc4wmYGTNNmA5k3bmIYxcACUeOBj6KuP+qOQkQDy+2Y
 ECYFnQVihzILl0tfw43iGCJ0MKExD+p8zw34BLPiwbm/4QOikUnbhKpJhEJ6XEKo4MTh2N9VxG+
 QWL8EY9qpj5x5wxwNbJ8FgoOrYoGd6ZsZOpkpp2MoGCWPim9lEcVJce1PajsiD4oswu9mJy8qhM
 3wOFSalJ/SVqPRKvurg+1/paq4X/
X-Received: by 2002:a05:6402:2694:b0:698:3365:f94a with SMTP id
 4fb4d7f45d1cf-69c5f0d235cmr2269102a12.15.1783863850326; Sun, 12 Jul 2026
 06:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260712105301.35409-1-th.huth@posteo.eu>
In-Reply-To: <20260712105301.35409-1-th.huth@posteo.eu>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 12 Jul 2026 15:43:58 +0200
X-Gm-Features: AUfX_mwBrRusfLkho7j86yjj1UBdLduzAmPOObHt4EGvy827HDxXTZg5Fvnehko
Message-ID: <CAJSP0QXkNYYxEcPFnaKdtcmtapGchXm=f9R=Ou+27Vdw5=zvjw@mail.gmail.com>
Subject: Re: [PULL 0/1] A fix for functional patches
To: Thomas Huth <th.huth@posteo.eu>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x529.google.com
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

On Sun, Jul 12, 2026 at 12:55=E2=80=AFPM Thomas Huth <th.huth@posteo.eu> wr=
ote:
>
>  Hi Stefan!

Hi Thomas,
This pull request is from th.huth@posteo.eu and your GPG key on
keys.openpgp.org doesn't cover this email address. Please update your
GPG key or let me know where I can find your new key.

Thanks!

Stefan


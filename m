Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F336C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whPRi-0004fr-OS; Wed, 08 Jul 2026 06:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whPRh-0004fb-M4
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:24:01 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whPRf-0006sD-Rh
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:24:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493e497643fso2533165e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783506237; x=1784111037; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PughpC3K/nANMFhuNox/JJWqLJSHqZSsQT5ddrTMVM8=;
 b=LRiVz2Ea/B4YPcqbc4TVC6Lg9PDtvV24vRZWnYb//9zhgKUd/u4UnPFUUzx8JS4g+M
 jkzo9sBUWeK7Jhixi9REhJ46xXqeASfNmEVB137xuDXtEh3uHS8F+fGb/eiRblqSyYdn
 JSxhG/NkTlxEAApX4au5Zu+Vk65RPtPzVU/oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783506237; x=1784111037;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PughpC3K/nANMFhuNox/JJWqLJSHqZSsQT5ddrTMVM8=;
 b=r4PqmT06XM4ZL3lWESzFzM5lkwT8zbwnJdI3iDcnhqsqM2EFz5AqHbgRtEA10sy8gq
 wSKkcjNOuO1y+Iv646HKMn7iHoR95B1l6wyJ2EUtQSbTkfEYOyj0LAFmP+WED6WK4hYL
 3N4Ydi1hwEr3pz6sQ92b/FHgVXvL6ClA4MbQ+qQRj8Khhhs/YFliojqOhKcRYHZD5Amj
 vAybeOzFhXxq8WADVPZQmoLSc6bvUl3h0V7+aiRFmx2F/Les11MVnmkTNLMaJi0tW7w3
 qN2x2ztfVfNFMC4hkn+g2x2YAHC1vnzWb1KKlI/3DXjH7C5qUQJZoDCdwiqpHuI5iRkv
 XpzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/jIRV7QZ3qh9a7CsvthuKjexH3Obb8MdYSZahowQDt9hx0AQXV0p1RFSyFw3UJpZM4XJe/jygCc72@nongnu.org
X-Gm-Message-State: AOJu0YxxvnCtnIMD08f8AAEAThQQFKDSd6rRmD8IOMIEMLfEAOCbMeHZ
 FLKWIYL0MKK237yVSxeQipgX0vtuX4MDDizubG3+mE6zBWBwG62vrLUd+vkMWIJOmCE=
X-Gm-Gg: AfdE7cn8PGQ5cTcrvbImzL/AX3MdxpRQYvdkS8NJZNS5QsktMJf92xj8iNBJHoBBxsc
 qTAnwy9b4RKgROJWZ2MB3Lq2fHawHFM6vzSNTQplpvffZGsnZrfJ+CWDJcBAXpAi15r9RPelbZ2
 9p0gX0BG4zIvkOdDRb3STt+ZPfprKQBw94z+nXnVcG6Hp3aiE9gU8aYaxvF0iMvcom4j36Z09Ba
 Gp1xTB+w7KyUJFFiqoLwtC0NksBRhnV6fcbeAObPtl+agVB7R/BVxyT5Qujj46mmTC2shyqOwug
 pBlQqWOkFwlPeu68Syw8xG9IEj3Y3XdR1T1MzQmB3iW4HVtAAgighCPtiM2cVwlN2JRasoX/YII
 zOMrdfAnuBYb4I/RYSv4EOG3SX6HFblxVsHv5UY2bWuv970mneMzeoVrChkOd6rgVqSPaKKBvyf
 0fh7mmwo63Ou/KRY2u8uAecIuDon/2s4U7mwFcxK5Pp77SwoJk876zX81o5urVEjMXtfNeEE+MC
 YzJg2O6MOQYfFCxipItyc4nCkU/iTZiuYC55m5agCd8gXWqu0Q=
X-Received: by 2002:a05:600d:8497:20b0:493:b55f:bca4 with SMTP id
 5b1f17b1804b1-493e68cec61mr14073125e9.29.1783506236297; 
 Wed, 08 Jul 2026 03:23:56 -0700 (PDT)
Received: from ?IPv6:2003:cf:574a:7200:d0fd:b767:a004:b9aa?
 (p200300cf574a7200d0fdb767a004b9aa.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:d0fd:b767:a004:b9aa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f213e8sm39344930f8f.34.2026.07.08.03.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 03:23:55 -0700 (PDT)
Message-ID: <868d7628da027aff31851b82944c5d13f9448349.camel@mihalicyn.com>
Subject: Re: [PULL 04/11] hw/nvme: add migration blockers for non-supported
 cases
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: Peter Maydell <peter.maydell@linaro.org>, Klaus Jensen <its@irrelevant.dk>
Cc: aleksandr.mikhalitsyn@futurfusion.io, qemu-devel@nongnu.org, Klaus
 Jensen	 <k.jensen@samsung.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch	 <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>, Fam
 Zheng	 <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, 	qemu-block@nongnu.org
Date: Wed, 08 Jul 2026 12:23:54 +0200
In-Reply-To: <CAFEAcA8ZQX01i9u0dUziRP0rAC1fSF=zbWcmQdLs=82D8ECg4Q@mail.gmail.com>
References: <20260706224426.14156-1-its@irrelevant.dk>
 <20260706224426.14156-5-its@irrelevant.dk>
 <CAFEAcA8ZQX01i9u0dUziRP0rAC1fSF=zbWcmQdLs=82D8ECg4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x331.google.com
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

On Wed, 2026-07-08 at 11:11 +0100, Peter Maydell wrote:
> On Mon, 6 Jul 2026 at 23:44, Klaus Jensen <its@irrelevant.dk> wrote:
> >=20
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >=20
> > Let's block migration for cases we don't support:
> > - SR-IOV
> > - CMB
> > - PMR
> > - SPDM
> >=20
> > No functional changes here, because NVMe migration is
> > not supported at all as of this commit.
>=20
> Hi; Coverity has a complaint about this commit (CID 1663673):

Dear Peter,

>=20
> > +#define BLOCKER_FEATURES_MAX_LEN 256
> > +
> > +static inline void nvme_add_blocker_feature(char *blocker_features,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *feature)
> > +{
> > +=C2=A0=C2=A0=C2=A0 if (strlen(blocker_features) > 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_strlcat(blocker_features,=
 ", ", BLOCKER_FEATURES_MAX_LEN);
> > +=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 g_strlcat(blocker_features, feature, BLOCKER_FEATUR=
ES_MAX_LEN);
>=20
> g_strlcat has a return value to tell us whether it managed to fit
> all the text in, but we aren't checking it.
>=20
> In this case it looks like that's not a big deal (it does always NUL
> terminate even if it truncates, and we're only using the string
> to report migration blockers), but I think it would be nicer to
> avoid using a fixed-size char array: they're usually a bit more
> bug-prone.
>=20
> How about we use glib's GPtrArray and g_strjoinv() instead of
> manually building the string? Something like:
>=20
>=20
> =C2=A0=C2=A0=C2=A0 g_autoptr(GPtrArray) blocker_features =3D g_ptr_array_=
new();
>=20
> =C2=A0=C2=A0=C2=A0 if (...) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_ptr_array_add(blocker_featur=
es, "SR-IOV");
> =C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 [etc...]
>=20
>=20
> =C2=A0=C2=A0=C2=A0 if (blocker_features->len > 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_autofree blocker_list =3D NU=
LL;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_ptr_array_add(blocker_featur=
es, NULL);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blocker_list =3D g_strjoinv(",=
 ", (void *)blocker_features->pdata);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&n->migration_block=
er,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Migration is not supported for %s", b=
locker_list);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (migrate_add_blocker(&n->mi=
gration_blocker, errp) < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 false;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 }

oh, thanks. My bad. :-( Would you like to submit your fix as a patch, or
should I take your suggestions and send a fixup patch (or update my series)=
?

Kind regards,
Alex

>=20
> thanks
> -- PMM


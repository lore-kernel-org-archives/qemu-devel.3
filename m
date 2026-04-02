Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E7BD6AB0A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 20:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Oau-00061a-KG; Thu, 02 Apr 2026 16:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w8Oat-00061C-5M
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 16:24:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w8Oaq-0006Gq-It
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 16:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775161480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qd5y+uBCxzcbc6R51rEA/ohoVT7jTSzteU0x9L+b1Lw=;
 b=K/PZLg9J6LDiG2dtAA7ke0zpjt6kJADO/LdYbOQLEallKm+gCGAoJ3OUHcz76nfWAbBjif
 +IYAwXhVgHMQT7j5gjsr28+0W/0P5LJt7crqhnUOv4JomY3opSDlx4L9FY/fDJk6xjBRkk
 3rmiu8a3i3RUuK/VvQB1O9ZPMwUR2Kg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-eEH-9zXNN6-ShLzAukP5dA-1; Thu, 02 Apr 2026 16:24:39 -0400
X-MC-Unique: eEH-9zXNN6-ShLzAukP5dA-1
X-Mimecast-MFC-AGG-ID: eEH-9zXNN6-ShLzAukP5dA_1775161479
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-79cfec4344cso22495477b3.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 13:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775161479; cv=none;
 d=google.com; s=arc-20240605;
 b=Z2BZ/A/nPJeu9zGQ8zMOl34Ab30Ufnf8YeSM953Rhf8yOMbgjwy1bbyWogTKkQKdxA
 Rr8rMfPA5Yjh+Ai6IalzJPuoK1GRYXq/LAHjp1xs5wqfmF8wHf3b4uCyAcTR5xY0wets
 L3ITcp8GhmlM49YIBf0rAsFaRkyP6aUl4K8wie1dvLZzVU0+e1rb4rOjXrZz9lrJ8S/7
 wHgAifkR/QzmEs+g57X3Hvo/Xerp6CQ5kaHRTpZ6OkKLtYmhm3eJ7Xl9fRte3/umvQCM
 l6Yp+leUeXM91WIDGHPxQrbcXbfp2JNxOFWeo0dSl39EVigmouybHKrvnlebj41L0OU2
 vmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qd5y+uBCxzcbc6R51rEA/ohoVT7jTSzteU0x9L+b1Lw=;
 fh=cSeDTVByYJ+MrTaTKM1c4C0gLzAwPvp3k0r0iETSZvw=;
 b=lwE+XGkopHEcc4oBlFhbokz+uiHeriBCr+q/ZSwOUQUO7gq6tLgIAy4exA8B5OJ6Zw
 EWLM/fJ6zd5gJNYvtmu1jpPNOkA7znX81WpSiKcfkWen96j98RsT7f1EyPpkCvSu5HEn
 icoTkaEGyZFQIe1/ovhd/22wkHorhn7+z29dyKdhH+uDlHV+LVBz7lmyrFxedoUum6/H
 wcTBuiWwGQ4G13Z6l7sz1OwNMfWX8/D/4SOypmUAqy9l1oEvLClSjAvj5TDAD0Mvn6We
 G3iQgQct68G4A7h46VPVpu1KUpL8gs9GRKJvrQAupoIdM6y9+lFA8yikbHyiGm/XEAwW
 qf6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775161479; x=1775766279; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qd5y+uBCxzcbc6R51rEA/ohoVT7jTSzteU0x9L+b1Lw=;
 b=AAPaRN10o9XgSqH7xSgmnxeEFUitMAPbeAek48ReJf30vHPDSpAKZtJ8O/S05JSuHU
 UitDBH5l4RDVU401HjtLL0j3evur6/GWdgwlvXhRBga56MMZkoImH9Z0oD+6mQSw9Il6
 vxMcAagLlIIkQRzHC1nOkIDY7YepP0y/dDt4R0VAos2+cUW5XBV4ml9zGHTd7npcISFi
 WeVDBKvOl7XEqN9h1ORbK+kpIejAJfUOFKxwhyBWahHg31asotlhkCXlE2bxI2QkN4tG
 WSttyrkOTlib/pJeZyA3D4ZRgC43hJ7irqlvTNAGF6+2FKKXZjzcbD8GQtVjsCPCQjZ9
 vsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775161479; x=1775766279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qd5y+uBCxzcbc6R51rEA/ohoVT7jTSzteU0x9L+b1Lw=;
 b=juZVutbv/ERL3oSynlL/bkAXD0dUYj3BOseqVd7e+R2s9UnWaf5JwfALzEw/aZNpZw
 K8WV3UQnoVr5bCPm9mYve/WAOieMtXYIlZA1vStjulvfnXs0IoU8mD3icSU39KrZbuvc
 gWuApV7KqCi8b8kM5650Vr4aveuK/cT9dHSoOtzvuC0tl112kfAgquybs2WhtQPCgBtc
 k5NEQ8hA0XeB+enH36pCxdh1P/UkZJIuPvyapT8INTuXFD9f5bmSescCrFBxKC7ScZLO
 qVBsBaLY69/4PHQZri/Ntq0PZfHlXaUNcMN+Ntw8TFTc7zpgLE64rJvC/w4WG9xUnYUz
 y7yg==
X-Gm-Message-State: AOJu0YwOoFRQeyr89h74PCkag6G3UB+zeBNcThdJgVpwiepe+RB7u5Gn
 DYNsl+oXvnMEhrZK/1KABxnnB4JI/tqG8jb3wPCuHVJNYSnWiYrSoThx5y9EjILQf/URir2VLVi
 ALnlUts0qw5rrnRz5DfFf6BlJfBOlZhPR41O15HnTKEodpprdcnovDd1gEYCeaqAUCPIMpCZ/n9
 rs6VBjzKmEaD4Tw8Ls6sgHAMMQtaHyUcU=
X-Gm-Gg: AeBDieu9pWhmbhCS/9i4DwJJKhQN/i5adRVbdkcJChMAADftXc0HF8ndxK5+q1nSBjL
 VwFqidQHMamfz03kzCbi8BRXYYGQ+zmmjE9oX5h95p0lP5KfnxYwuyqLXUVjKYfyirG3SBMI2Pw
 7QsrIXPeiDhmNssaPeWgiaI6fWYjES6EqXmm48gvozidkRHi8RKG+Wb+vXq9oOBgcxRBVj7XQ2c
 BkDeWLoIocBa6kyuFBvIFla5kQK35ilnANPYw==
X-Received: by 2002:a05:690c:83:b0:79e:ce16:38b with SMTP id
 00721157ae682-7a4d31e75afmr8661447b3.4.1775161478891; 
 Thu, 02 Apr 2026 13:24:38 -0700 (PDT)
X-Received: by 2002:a05:690c:83:b0:79e:ce16:38b with SMTP id
 00721157ae682-7a4d31e75afmr8661227b3.4.1775161478483; Thu, 02 Apr 2026
 13:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260331203337.1376879-1-jsnow@redhat.com>
 <aczdV5JgwfXLUzCM@redhat.com>
In-Reply-To: <aczdV5JgwfXLUzCM@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 2 Apr 2026 16:24:27 -0400
X-Gm-Features: AQROBzCOckU-sImBPQlTBib-CJ-JYQch2haMzBgz_0HJKuzpHR3VJrhBT8mWPA8
Message-ID: <CAFn=p-a-wM6v4NTJAFya3TgDaLyOiQVpUt3bsUcP+1Cht-uotg@mail.gmail.com>
Subject: Re: [PATCH] python: bump qemu.qmp to v0.0.6
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 1, 2026 at 4:54=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Tue, Mar 31, 2026 at 04:33:37PM -0400, John Snow wrote:
> > This release removes some deprecated warnings for our use of the old
> > sendmsg API on older python versions.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  python/scripts/vendor.py                      |   4 ++--
> >  ...ny.whl =3D> qemu_qmp-0.0.6-py3-none-any.whl} | Bin 72263 -> 72379 b=
ytes
> >  pythondeps.toml                               |   2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >  rename python/wheels/{qemu_qmp-0.0.5-py3-none-any.whl =3D> qemu_qmp-0.=
0.6-py3-none-any.whl} (64%)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

I'm assuming the GitLab CI failures I'm seeing in migration tests
aren't due to this patch ... Something we already know about?



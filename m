Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A11ECD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUmxH-0008PZ-CM; Wed, 03 Jun 2026 10:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wUmxF-0008PB-Tc
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:52:25 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wUmxE-0003qu-FB
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:52:25 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bec43ee8ff0so130800866b.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 07:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780498343; cv=none;
 d=google.com; s=arc-20240605;
 b=JLgVnbjnGvbMal3HNo8tgAMX+7yWDzC5cudEB/S3J/J86PiiON7oNOEaVbllPU0HBu
 B4QiqK7nAsboonBPbPTvo9SjhTvv5R/TtwWiPnd7eYMAVxPxEBEir+YOgUpeCljtRhxT
 b7UIE0mFTEmsvw+GgbjD+6fGN6mYp/GJc4R8iPSq1UD5YjUcosQHqymwJRWtKC6cUi3X
 xdgPbsB7ZvEVNqdTpooxOBZpuC1U5JHOtTf3vBt31tc14Plnnxi4zeujJ+L0msiax8FK
 fRfGHwtRXDd4fB5MtMe14b5LgcjWmKICNagKvT1aabxClxJaD/ynUsgCwCVGACv5Sm+7
 1odw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nLG6IExvoYypSUdeswPJF1E/o1Oi8dN4I6U8eFs8XKk=;
 fh=622OFClSuCoV+wH+xYe7ZMTvouo00wZVM68ZfKBPg6k=;
 b=NXtHbr8kvcuAUjdKb6fhO2ZpHfXgKVt7S5bPhd+upr417Pjkx26bayPI1nhkLoNDNB
 ttrF/OLRhsd4PkZGkar6l6xA0nvlN+g7ruicMla5IxTXV1iTdWWueKobHcbQU/K4B20c
 oii/WTkyqIXtOPlf4zarkJpmn7XMl17D/GEIqifMktKFXNYj/lnw2K/+qORjNwCl8Ic7
 OMZ5Q7hLt4SJljWkFjw16ME2knVG1kRv2xzDgqeQK0QegKT4bphd+neaXSH1G3vMXGTn
 Ldp/DlW+LuKgrRoJAG0axqs1g6Zg2hGNWK5hWvuzQUW5YRkDzsf7q16heTj/nhhbofj5
 joCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780498343; x=1781103143; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLG6IExvoYypSUdeswPJF1E/o1Oi8dN4I6U8eFs8XKk=;
 b=U7/N4EFm7GGkC6O1raqcQIC8vonIfAF5uhdsiyrJnt6nPHLp6xutvbrOTeYIYpw428
 setiADBCIl0MSrgAukCSXyT5gsGQXcIJ+L6Eom6oDpzcKJjigX8zvO2d9MieJew92/8T
 fjFq67AHx2zm9OG5VANhRLvXVNT54HE95HZUaXD+DHAwPHqoZ8lixtl3hiczDp1y/P5V
 kJ7PXzQLCfw1jrDulIXcdpMGABO51TjMPSCwFu3yqV5kKiJEUyBLK99hwcRzHZutyGJY
 n6/0U/xwTYj7y0eEHSa01/iQgnHApfDuX2BcHTxsO41XNB7gAHPfSSARuKyXsqmRXfQJ
 iJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780498343; x=1781103143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nLG6IExvoYypSUdeswPJF1E/o1Oi8dN4I6U8eFs8XKk=;
 b=HCgQE3+KaLLeAnaoP2L9hTx+HykMv+Nf2wDujoDRWQ6urvzrEadlRt7Njh1li3Mlf7
 iElHBSs0mHTyGkL95VyDqohDMb1HDiLhykANZ1y1TXZ7Q+wju8tmMsO58w1wSkc82iaY
 v8jsBRWUs60YeJQawxul3/AWo5pfqTZn2H8L2v77d9Jf8C8BhJsUwNrJkexF1U4AUzZW
 aU6umtk6hL/a7i9H8Q/rOycvvXDepE7ZjqOexEd2Bf1wxyiv2JOSmKskiLGCIkiiKhl/
 M+Cze/bkvL3p7Ah7JaGdd++4/Hp80hrGvQW+AkXJtMXkEEINu6ZTWJQaILG7TWUspaJH
 WIPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ99OOgVpWr9XVM4ABvUsWwZuoefQlPd7mCD+T8V1V7Pd874Y1IP4BaAgBZGgL9ZH90lWcSIo6ijbdO9@nongnu.org
X-Gm-Message-State: AOJu0YwR/fsBa7tOHqmk0kF5lfc1Axs9Jsf/+DbGVYQEYxnxLqZWkykH
 gJkFPPOkqG/dxs8JnB4BUYGrEy+MEQG/3vc3hw76AGBKb+OXne7LJx83lADVi4u0jMe/zHqq/vy
 L+pzxImXF9+mrQiUzMlzfNVxVRCnrdgE=
X-Gm-Gg: Acq92OECsv7tO/wlERkTky1aMV64o3fyqxnAbAezR6IDUnlNCA79h2I66tYEG0UrJZb
 8sHljnOTRwuK1BoRTBRsJdiETHvf9sDYocAaBrOKqft88l7MQycUpQm1jPkeUAZQvW9VGUrCoom
 PLBiuU1eqNxMNFFl/epIELyDXNc+lmLInPmHVGIEQUtvzbsbMiWgUG0c29q0E9lNNJ2NMZJZ6bK
 8xk0/YsTKLrFi9miRinNNLORCV2wNR1NQDtxs+M3ryx88g+ob83v9vhvW21kI/pZvlsuYkemBBR
 dpL3lA8JRCGMOdUD5DYGRxfnyOl4N4qGxMcCe8JpKvsUwSz9TvOL
X-Received: by 2002:a17:907:3f10:b0:bd8:bc4e:fb8c with SMTP id
 a640c23a62f3a-bf09c6ac386mr187331766b.4.1780498342646; Wed, 03 Jun 2026
 07:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-11-armbru@redhat.com>
 <ff2c3cd4-4457-4f55-bdd7-9aa2d7f2bbfd@mailo.com>
In-Reply-To: <ff2c3cd4-4457-4f55-bdd7-9aa2d7f2bbfd@mailo.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 3 Jun 2026 10:52:09 -0400
X-Gm-Features: AVHnY4Les6FcZRBGin2IYgROz_lEJoi_Ktd1h1sWEGgUzFoWhVyTsy_kqPTJ_2E
Message-ID: <CAJSP0QX55BtJt9hz1xMc_VZagFxtmt5SvVWGjcwqoKbgD_7K5w@mail.gmail.com>
Subject: Re: [PATCH v2 10/38] MAINTAINERS: Fix F: in "Darwin (macOS, iOS)"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 pierrick.bouvier@oss.qualcomm.com, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62f.google.com
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

On Wed, Jun 3, 2026 at 4:26=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
mailo.com> wrote:
>
> On 3/6/26 08:40, Markus Armbruster wrote:
> > We neglected to update MAINTAINERS when we deleted
> > .gitlab-ci.d/cirrus/macos-14.vars, and when we added
> > .gitlab-ci.d/macos*.  Update it now.
> >
> > Fixes: 984b192bdf (ci: drop cirrus MacOS build, 2026-05-26)
> > Fixes: 7684e78132 (gitlab: add initial MacOS 15 on gitlab runner, 2026-=
05-26)
> > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >   MAINTAINERS | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3a99c84839..2bf421c659 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -692,7 +692,7 @@ F: scripts/nsis.py
> >   Darwin (macOS, iOS)
> >   M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
> >   S: Odd Fixes
> > -F: .gitlab-ci.d/cirrus/macos-*
> > +F: .gitlab-ci.d/macos*
>
> Ah, slighly better than 20260602162457.828969-4-stefanha@redhat.com.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>

Yes, please take Markus' patch instead of mine since it includes the new fi=
les.

Stefan


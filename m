Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13531CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 19:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSJf-0005Ax-3T; Tue, 19 Aug 2025 15:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSJb-00059b-C4
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:48:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSJZ-0001Ko-Nk
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755632888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xliQRIIUFYFbBfmwGvq1iwmHptK4+r/xhMVk/pnzLI8=;
 b=g6HOCq0GAQy7HdwmanVW9WlOlOoRqC0BM//3UG+maWFvisBc3fQGos/4mvVdjDRbfJXn/J
 FMaAQc8KybJIRYzWGtbgiGAORIWO6PnF2wNuX6EIfySEg05vAdk2gjGvZ69hadJxQefViQ
 /S9Z7YW6rQy89LkIcQYBhJdeWrAkUjA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-HO7mssZoPSS-bfn6bs6XlA-1; Tue, 19 Aug 2025 15:48:04 -0400
X-MC-Unique: HO7mssZoPSS-bfn6bs6XlA-1
X-Mimecast-MFC-AGG-ID: HO7mssZoPSS-bfn6bs6XlA_1755632883
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2445803f0cfso60107815ad.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 12:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755632883; x=1756237683;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xliQRIIUFYFbBfmwGvq1iwmHptK4+r/xhMVk/pnzLI8=;
 b=MWnxzDk5jBpgTMa3Yv3sHFN/VRB74LSh9nvSPRYa90rYEY9JRNdFPaRm89gHA0lqrd
 8S78CGz6FE9p5RxIXluA1D6sTKQaysZeBgOfw2IXkcD9D/z4yQAnqO1R/SeBt2d01McN
 +U4SNYcGmpFQ7hsd4ndvahu2Dc3UY/ViESRE6SdGR329/2J1XA+Y18C5PParajUbUhXG
 bRLMarTmkUYPm0i7cunCObaKiergWvNdd7MySR+vkA3tuWiWexIaNN8rdqMB1R4BrrkA
 9ed36F5VyjFfMackTHJE3rnzcspH29hz7+wcoZ6YbcIIJUzGxoC4DT9+nHRpHe7EPm4F
 3Fbg==
X-Gm-Message-State: AOJu0YxbNKZL18JVSmdVIOHnz+2ykFCVkdJxdXd1UY3JbI+1qWDUOUtk
 DUhpRzTiY7PD63kLpgs2NqaFUkto2fuK9uTA6QK+5Gg26hWO6g64tdKQvBy81imfm0ujIvSA+m0
 meBK7xkgppLuMkLyBMnr90hCWNB41fSU1drzsqRsk8NYx7yZTU8PIMUy+2FORtIeZbl+tEvu+Pl
 vJvbl0J8NG47O6mhXqo9W6yDf3vjVri1g=
X-Gm-Gg: ASbGncs05QmJv09OvYPGZXEML2Hje9wk4Ikl+j+NOpI3YoAALT1GT2Ks1KQtMvqnYtp
 klyIf6NG0yChfHBXQfFfkFS1gtuvat/BH+mzV+d3QXZIG3IHbSuL6q5Kmycq11tfu0G86FlGocx
 uu2BjyZ+5bVk/PiQ8j26Nk5f6wNi3Jpsi9+pPZhlXRcchBob9Y7iWY
X-Received: by 2002:a17:903:2446:b0:23f:f707:f97e with SMTP id
 d9443c01a7336-245ef15bc7dmr2659675ad.17.1755632882933; 
 Tue, 19 Aug 2025 12:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWztg2jgi5Y4V71mvlR/MBzrmMJptJBJjzEBz+GYt69DnkypNwqgh/Xl5ASfLqGztJRnP0eK7w1ssIviCE6S4=
X-Received: by 2002:a17:903:2446:b0:23f:f707:f97e with SMTP id
 d9443c01a7336-245ef15bc7dmr2659455ad.17.1755632882511; Tue, 19 Aug 2025
 12:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-2-berrange@redhat.com>
In-Reply-To: <20250715143023.1851000-2-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Aug 2025 15:47:50 -0400
X-Gm-Features: Ac12FXzac0uoQyKxntFzpTZXUiH-xUE1Zbzady-Cy2tcTqOj5F3mourvbSzHCLA
Message-ID: <CAFn=p-bVmn_N4hWBnYtNhhdHHYEh4j0zVBHnXFtJVQK5GDRaJw@mail.gmail.com>
Subject: Re: [PATCH 01/14] python: Replace asyncio.get_event_loop for Python
 3.14
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 15, 2025 at 10:30=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> From: Richard W.M. Jones <rjones@redhat.com>
>
> In Python 3.14, no asyncio event loop gets generated automatically.
> Instead create one when we need it.  This should work with Python 3.13
> as well.  This change was suggested here:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2375004#c4
>
> See-also: https://docs.python.org/3.14/whatsnew/3.14.html#id7
> Thanks: Miro Hron=C4=8Dok, Daniel P. Berrang=C3=A9
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

We fixed this in the standalone tree, but I hadn't synchronized the
changes over yet. Shall we take your patches first, and then I'll
worry about synchronizing later?

(I desperately need to drop this code from the qemu.git tree, urgh.)

> ---
>  python/qemu/qmp/legacy.py  | 5 ++++-
>  python/qemu/qmp/qmp_tui.py | 2 +-
>  python/tests/protocol.py   | 2 +-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
> index 22a2b5616e..e11d05afbd 100644
> --- a/python/qemu/qmp/legacy.py
> +++ b/python/qemu/qmp/legacy.py
> @@ -86,7 +86,10 @@ def __init__(self,
>                  "server argument should be False when passing a socket")
>
>          self._qmp =3D QMPClient(nickname)
> -        self._aloop =3D asyncio.get_event_loop()
> +        try:
> +            self._aloop =3D asyncio.get_event_loop()
> +        except RuntimeError:
> +            self._aloop =3D asyncio.new_event_loop()
>          self._address =3D address
>          self._timeout: Optional[float] =3D None
>
> diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
> index 2d9ebbd20b..7dfb03c9ad 100644
> --- a/python/qemu/qmp/qmp_tui.py
> +++ b/python/qemu/qmp/qmp_tui.py
> @@ -377,7 +377,7 @@ def run(self, debug: bool =3D False) -> None:
>          screen =3D urwid.raw_display.Screen()
>          screen.set_terminal_properties(256)
>
> -        self.aloop =3D asyncio.get_event_loop()
> +        self.aloop =3D asyncio.new_event_loop()
>          self.aloop.set_debug(debug)
>
>          # Gracefully handle SIGTERM and SIGINT signals
> diff --git a/python/tests/protocol.py b/python/tests/protocol.py
> index 56c4d441f9..db5d54d83f 100644
> --- a/python/tests/protocol.py
> +++ b/python/tests/protocol.py
> @@ -228,7 +228,7 @@ def async_test(async_test_method):
>          Decorator; adds SetUp and TearDown to async tests.
>          """
>          async def _wrapper(self, *args, **kwargs):
> -            loop =3D asyncio.get_event_loop()
> +            loop =3D asyncio.new_event_loop()
>              loop.set_debug(True)
>
>              await self._asyncSetUp()
> --
> 2.49.0
>



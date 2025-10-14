Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01479CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 18:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kBG-0000yN-FL; Tue, 14 Oct 2025 14:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1v8kBE-0000wE-Lt
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 14:55:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1v8kBA-0004fn-Nx
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 14:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760468120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/p8swltn70q5Be/COE2+/cmY5uhZbRHrzBOHh4B8yY8=;
 b=XNnJ6z8dKQ88apyuRv69cLVEgEJrlO5VjKcC5TJmnuqxQ7/ECGCYRt/ENVqgazfXWC4CWV
 iT8f1FOCHqV6PamdKRcxfoY6CTuo1uH+o5Y5AU67zMZ72Xs7KALL9hqwHD2q79xdrOLp7N
 YcJXRi057QXXIUYDrBLnbgNNgtUPQaQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-ut2XyV5LOvmUFAqBXu3aCw-1; Tue, 14 Oct 2025 14:55:18 -0400
X-MC-Unique: ut2XyV5LOvmUFAqBXu3aCw-1
X-Mimecast-MFC-AGG-ID: ut2XyV5LOvmUFAqBXu3aCw_1760468118
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7815a21894aso6002127b3.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 11:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760468118; x=1761072918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/p8swltn70q5Be/COE2+/cmY5uhZbRHrzBOHh4B8yY8=;
 b=I5NHjpVNTTVGPYqDN7wIl6oJscob9g7Nc2QtiWj7g62LtDIC43JiCnnCqm9BubTD0z
 F1AGci0aR9kl0jBoz6r5OzP7+deJYqdl2+jeJVXBb4rNyOdYe68jimIW1C2DbpXwtnaa
 lvR3VKACucVZsaE2lRw8sHNY/M2mhuBDPisHdqkI9kKQuv1fYiPeKcJpRBPMNCNOxRBk
 Rzmji/GMHVjBwx4CLbe9vL2f/nVvz6fkqIgVliI9XreU/H51ytc3yAw+d88lJtslfZf0
 zfXvvF7Y/A6pPDL6vBxWpCoftDpcUvSzfnr6Kxk/wqAlgX6n7la8CjPZq5Vubt+0pX7y
 5vxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZrUix4VUY/kU37FTQTxTuP7Ul4ttxP0mAwR2YTsGh77h9rJ3tz83XFt52q2HdUWzySJqvix4ocoUF@nongnu.org
X-Gm-Message-State: AOJu0YyKgiksr4AYwKse0mFermvyBzOlj/gLDZNzkwhD7ObqR/7fCTwh
 pW2V6o/qcEslOtalV1LUyGW2j08bhaorGHABMG+Ze557aQHa36021l4/a0mE+Ns7UFLLdSMxXXX
 2qNAwcDcckClOiLbpN3/6Z0Q8oIQgr+stQUaCEmjzYEhkAe/c8H1foYEIHKjkPyn+thsBbrwh0V
 899v2z021a67Ixb9Jw/58TxMCHSAy9taA=
X-Gm-Gg: ASbGncugsysZ1ACgtG1PsaUf/KHZlgs0dfkHHp1rNQYf9UiRGEN9hGgAFdJG1zx27om
 RqkTZHrWDG4Yz789mfdUKI7Y86nYwNglc6QZP/pLVXx+y9ZSkso+0G1Vlt6AN3owg+lMnJq61Zw
 HKgycalHNkT2/LhmfyYt8S639UdqwDJkTFQJdbJ1xseuHzlxVawHb/
X-Received: by 2002:a53:4c08:0:b0:63c:f68b:2c52 with SMTP id
 956f58d0204a3-63cf68b2daemr8335047d50.43.1760468117857; 
 Tue, 14 Oct 2025 11:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkB7NTDT0t3LYsXtV68vSWShb0yyz3IkvrB0VWqYfKedaBM09dwcpCRIfDfgKVsBQ7NcODpCtbe/xeVDd+lCw=
X-Received: by 2002:a53:4c08:0:b0:63c:f68b:2c52 with SMTP id
 956f58d0204a3-63cf68b2daemr8335029d50.43.1760468117256; Tue, 14 Oct 2025
 11:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
 <20251002020432.54443-3-gustavo.romero@linaro.org>
 <CAFn=p-bscu00jtyfm+SmeYqB7gt6eA+F8uuYb8ng6rTe_a=HTA@mail.gmail.com>
 <a0d4ba3d-f799-4ec3-8d3b-efdc33527242@redhat.com>
In-Reply-To: <a0d4ba3d-f799-4ec3-8d3b-efdc33527242@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 14 Oct 2025 14:55:06 -0400
X-Gm-Features: AS18NWD_a-xwuO0EevTPHGnUpUHZqTXOmqUDofO8o3B1-gQKmlGWn_6ZThV2lMU
Message-ID: <CAFn=p-awbF01tQr9xnRX8EqPBNoafGP+N2W-hoMwc68cmwQzLA@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] python: Install pygdbmi in meson's venv
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-devel@nongnu.org, alex.bennee@linaro.org, berrange@redhat.com, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Oct 14, 2025 at 2:21=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 14/10/2025 19.39, John Snow wrote:
> > On Wed, Oct 1, 2025 at 10:09=E2=80=AFPM Gustavo Romero
> > <gustavo.romero@linaro.org> wrote:
> >>
> >> The upcoming changes in the reverse_debugging functional test to remov=
e
> >> Avocado as a dependency will require pygdbmi for interacting with GDB,
> >> so install it in meson's venv (located in the build dir's pyvenv/).
> >>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> >> ---
> >>   pythondeps.toml | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/pythondeps.toml b/pythondeps.toml
> >> index 16fb2a989c..98e99e7900 100644
> >> --- a/pythondeps.toml
> >> +++ b/pythondeps.toml
> >> @@ -33,3 +33,4 @@ sphinx_rtd_theme =3D { accepted =3D ">=3D0.5", insta=
lled =3D "1.2.2" }
> >>
> >>   [testdeps]
> >>   qemu.qmp =3D { accepted =3D ">=3D0.0.3", installed =3D "0.0.3" }
> >> +pygdbmi =3D { accepted =3D ">=3D0.11.0.0", installed =3D "0.11.0.0" }
> >> --
> >> 2.34.1
> >>
> >
> > Do we need to vendor pygdbmi? Currently, mkvenv does not consult
> > online sources and so if this package is missing, pulling in testdeps
> > will fail.
>
> This is handled by the "check-venv" target which is called now when you d=
o a
> "make check-functional". See:
>
>   https://gitlab.com/qemu-project/qemu/-/commit/75b1786996c422878d09bd12f=
166004a7d32e459
>
> Works fine for me, did you hit any issues here?
>
>   Thomas

Ah-ha. I am working on dropping qemu.qmp from the tree and had moved
this machinery into mkvenv.py - I didn't realize that the Makefile
invocation here passes `--online`. The core groups for mkvenv still
operate offline only, I didn't realize we let it go online for tests.

Before these dependencies get more numerous: do we accept that "make
check" might only work if you are online, or do we want to enforce the
idea that "make check" should always work offline only?

(like "make check" works offline and "make check-extras" may require
internet for deps?)

--js



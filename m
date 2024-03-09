Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429C5C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 17:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj0Tx-0002Vo-Rp; Sat, 09 Mar 2024 12:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rj0Tv-0002VB-Jx
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:27:35 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rj0Tt-0001dI-Oh
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:27:35 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56845954ffeso295427a12.2
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 09:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710005252; x=1710610052; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NtISaC2rZ5H27mk5DgNvV5g9DcHWAN+rZZkbEpZaChM=;
 b=I/nPNq2955SeueKzzW4KdHy8fCWgCFZbnGqPMvGSjtBFUMy4sRyaw0bjXYg2eUdVXO
 GKA7hZSuaXGQVufdri/QoJAD2QRiaMjzHXSUk5mn8NdN1KgSCxzQnxhgCQLxt3CKquew
 isi1SV1UjnnYQdvqpV5dohZbLwuD9cSHk3C9qgy1B2fyJKxvnrE8F8qNvLA6Q9GszvYS
 /Yh+8+q1WlB8R+wX+THJW2MTBpumM5uwt70j5HpzyrJoCrvKFa1fdZiqFIYmh2CLrfq5
 Ghi7yvPXA/QhFaAZYctyIswGMQtqoFN2zI48mJ9Hx7R7OQvS/lC5Ce6Dau33KBfbbCoy
 7qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710005252; x=1710610052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NtISaC2rZ5H27mk5DgNvV5g9DcHWAN+rZZkbEpZaChM=;
 b=Sq/ULZ0qVgX+9fqPBwvNgzRP27pd76wlGJQbgLLGKkw8Vcv6g8j6Btc/pPvfzsyy7s
 NPsgmGlqcI+zg1DJuZjKO9l62KkXAVJC2qzW52vehg7pD99Ky/bH599aEKP6nN/IPnrO
 GkEDjwoduvVeNbTrddCFEqeeM17JNhYUOjCtInQHMXZtGAJ/Tkt/DfsHDNNtBTRXuYWH
 8r1Monn4U8PCuP2G2AfpDG41l+JbSD9K9XQouIokD1u4P6eRfyd6qTSLY6KOLmH4YaVB
 q+BvDwjD2aNOVnTwT9C3QsoZfDsyH0c42FbFSlAfD6Rz8OKuz51Pwt+1LS9Oz9DrEwMJ
 6agA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgCtemNjr7X1+cnmSDGiWMBph+qM4Ok+5hCXLH7LB554NRVOa7vxzSSJyew4EOLL85hn/qrRnYt+u9pjETEXI7AqgR0W0=
X-Gm-Message-State: AOJu0YxK0vowNeWhav8O/K6Xe1rJ3LZemocpIT4/GGYFGC9nZRh8ocw7
 WQMihU7UXtD86OoOxOrnmqE7tcZre7ivYaBdKH1UKHNXfIy8LvjaCYNCOsEXjiZuyCW4IrI7iPy
 ON3lIa14yIt2v2CKq99xxlZhVRulQytrOtY2pcw==
X-Google-Smtp-Source: AGHT+IEw9N3y1TPM7mdZS7ke/zFEd0QIbC/CBGT0UYT+wKm+pZ3vIthQtj9ymj7xUItpbl+5D/kFs78Y3fTxld8b4dQ=
X-Received: by 2002:a50:a45b:0:b0:568:3067:5191 with SMTP id
 v27-20020a50a45b000000b0056830675191mr1441282edb.38.1710005251680; Sat, 09
 Mar 2024 09:27:31 -0800 (PST)
MIME-Version: 1.0
References: <20240304130403.129543-1-thuth@redhat.com>
 <CAFEAcA8rac2nEzrVWUWfRHAWYLmC6dSDMK=j6msD_SdPpn6ZtA@mail.gmail.com>
 <3262c873-b845-4286-a71f-a53b96bbc8a9@redhat.com>
 <ZeYNQdqW2bBA4gNL@redhat.com>
 <86d80d62-8c82-4ec5-ab67-50c83041f979@redhat.com>
In-Reply-To: <86d80d62-8c82-4ec5-ab67-50c83041f979@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Mar 2024 17:27:20 +0000
Message-ID: <CAFEAcA8X6hR+GfnREQkWNqiOBk40r4o_dWPOiyfVT3n7YJqRVA@mail.gmail.com>
Subject: Re: [PATCH v2] docs/conf.py: Remove usage of distutils
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 5 Mar 2024 at 10:39, Thomas Huth <thuth@redhat.com> wrote:
>
> On 04/03/2024 19.04, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Mar 04, 2024 at 06:11:58PM +0100, Thomas Huth wrote:
> >> On 04/03/2024 17.56, Peter Maydell wrote:
> >>> On Mon, 4 Mar 2024 at 13:04, Thomas Huth <thuth@redhat.com> wrote:
> >>>>
> >>>> The macOS jobs in our CI recently started failing, complaining that
> >>>> the distutils module is not available anymore. And indeed, according=
 to
> >>>> https://peps.python.org/pep-0632/ it's been deprecated since a while
> >>>> and now likely got removed in recent Python versions.
> >>>
> >>> This doesn't seem to be sufficient to fix the macos CI:
> >>> something in glib seems to still be using it.
> >>>
> >>> https://gitlab.com/qemu-project/qemu/-/jobs/6313212803
> >>>
> >>> [281/6553] Generating ui/dbus-display gdbus-codegen with a custom com=
mand
> >>> FAILED: ui/dbus-display1.h ui/dbus-display1.c
> >>> /opt/homebrew/Cellar/glib/2.78.4/bin/gdbus-codegen
> >>> ui/dbus-display1.xml --glib-min-required 2.64 --output-directory
> >>> /private/var/folders/xc/tpssff9959345bnqq4c6tlww0000gn/T/cirrus-ci-bu=
ild/build/ui
> >>> --interface-prefix org.qemu. --c-namespace QemuDBus --generate-c-code
> >>> dbus-display1
> >> ...
> >>> ModuleNotFoundError: No module named 'distutils'
> >>
> >> Looking at the glib sources, I think this has been fixed here:
> >>
> >>   https://gitlab.gnome.org/GNOME/glib/-/commit/6ef967a0f930ce37a8c9b5a=
ff96969
> >>
> >> The fix will be in glib 2.79, unfortunately homebrew still seems to us=
e glib
> >> 2.78 ...
> >>
> >> We could maybe temporarily work-around the problem by disabling the db=
us
> >> code in the CI job? Or just wait for homebrew to update the package?
> >
> > File a bug against homebrew. IME they are very quick (1-3 days) at
> > putting out fixes for things like this, especially if you point them
> > to the upstream solution.
>
> Ok, while I was writing my mail, I was looking at https://brew.sh/ and
> didn't see a link to a bug tracker there ... but now I realized that they
> are simply using the github tracker, so I went ahead and filed a bug ther=
e:
>
>   https://github.com/Homebrew/brew/issues/16823
>
> Let's see how it goes...

Seems to be going slowly. I notice that there's a comment in there
saying that "brew install python-setuptools" is a workaround to
get glib 2.78 working -- that seems like it would be good to get
our CI back to green. Is there a way to test changes to the cirrus
config short of committing it and seeing if it helps? I don't see
the jobs available on a pipeline in my personal gitlab repo...

thanks
-- PMM


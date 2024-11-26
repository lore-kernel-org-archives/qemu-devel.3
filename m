Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C478D65536
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFzec-0002wQ-FX; Tue, 26 Nov 2024 12:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFzeD-0002qd-EG
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:46:53 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFzeA-0002O1-5s
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:46:47 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cfbaf3d88dso3173938a12.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 09:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732643201; x=1733248001; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MuaqPWTqepOxmZq4sggQsfJVuv4ciLBHwbuq1iPIJzQ=;
 b=HdpNuWZpVibC6HSlv7pAMLBYh0aU5PlpTFSoVk9MHLVKBj96PSy4bWRIgpn7Yg5QNL
 Rv83kDtnZpXWvyjOdg5HjBFjSQoBj7YOkszLCvmC3ntZ88Y/QY3ga5GJAeJvFP7N5jSe
 epfaHKOkhGQMPkMtHHz7J1LTerGYavc41e5rYexfDfdheKqu2No55OP8A1zOs4l/hxV0
 mYQAtkLs6f1kW6wBgVIqvXpC9rNpBx2QYLA36A8xAE015iehxHspOYQtDmyAJZVntTm4
 a10xnfA6F3WeTuNjy0TxPixL0gJz/zQKq2TB3GTcOuqs1ZACwivwJkqKfxw7J6TmCJRY
 eLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732643201; x=1733248001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MuaqPWTqepOxmZq4sggQsfJVuv4ciLBHwbuq1iPIJzQ=;
 b=h5eu3cp14NJV3uzqy3k+Q+raM5W+Ya7kWpU98OtRLK3sW0L9EaeLNxJwMCmxkNIYAF
 fRvsuhOkD+nJoMjJXS7OlG4v8Wr9yBIg7h1tO+BXwBmCO5LxSNXHAhJTcUVd/uUjqAO0
 ibG4Yh+H0gVGOHUvCg6bGv+9s+ytYTq4Fb+docMh/Ps5N8St8906mIzg2y3Qot6fwnPo
 jCZ8le1z7AKeNIHwZ68ZBdR2AxNNgPbeNLvB5ZaNxqvfLfKfHPWw//HjzjWnFI9Sp8d6
 +v+S2gSYoeBY6zcGrlOhLYl8MDT9u1ID8W3vlyMlJ2jPzPb4PjXivbrfyd4kemhRBJ7l
 xgnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4UqyjpPkYFZGfjZQpaThPduW/cmHRwBi2f9z8ZWAASwVv0n10cBadr9p3hVUSMJVVDbHMu6Kmb9tI@nongnu.org
X-Gm-Message-State: AOJu0Yx6T1hh4vqqqSXci9ji22Cbw5YFtNIq9IYZF0R4VXp+XGXL5D7j
 DBwCf1uKfGxy7SFghgo13PhbjFbBXh6R0Jh6alSMRHZRzOIysyDy+7Zendw9se2TWv4bZKkwpsM
 s/C3Lr2xusaTahpWDZRAAGcmWdK5yIq7HBg6tfQ==
X-Gm-Gg: ASbGncvVN1drT7FoccDpHe2SfZtEBCU6gRxZppeemZ+bhULtMP0lZYdNqf5l2wlvW2S
 j7GKXCoK49iSuk+6keNtJq2k+VW20dTlM
X-Google-Smtp-Source: AGHT+IEyJgXLPWOQEGo2jaN7iS4ukCZfz9hs32+b8tlDafHsyViHMWIZcOqqM9nQsc4OknA/kaoJfvRbf8C8ohFeUeg=
X-Received: by 2002:a05:6402:51d4:b0:5ce:de19:472a with SMTP id
 4fb4d7f45d1cf-5d080be4926mr128102a12.16.1732643200858; Tue, 26 Nov 2024
 09:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
 <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
 <Z0YF9i2pwBkznkCD@redhat.com>
In-Reply-To: <Z0YF9i2pwBkznkCD@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2024 17:46:28 +0000
Message-ID: <CAFEAcA-ematCTyj0SN2=e3mGHvp0VWjN1GV-Tu5Rkf-V721L1w@mail.gmail.com>
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 26 Nov 2024 at 17:31, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Nov 26, 2024 at 05:44:29PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi,
> >
> > On 4/9/24 12:38, Thomas Huth wrote:
> > fetch() can fail [*] (see previous patch, various Exceptions returned).
> >
> > What should we do in this case? If we ignore a missing artifact,
> > the tests will eventually fail. Better bail out early and save
> > credit minutes?
>
> We already do what you describe - 'fetch' will raise an exception
> which causes the precache task to fail, and the CI job gets marked
> as failed. We don't attempt to run tests if assets are missing.
>
>
> > > @@ -58,6 +59,12 @@ def tearDown(self):
> > >       def main():
> > >           path =3D os.path.basename(sys.argv[0])[:-3]
> > > +
> > > +        cache =3D os.environ.get("QEMU_TEST_PRECACHE", None)
> > > +        if cache is not None:
> > > +            Asset.precache_suites(path, cache)
> > > +            return
> > > +
> > >           tr =3D pycotap.TAPTestRunner(message_log =3D pycotap.LogMod=
e.LogToError,
> > >                                      test_output_log =3D pycotap.LogM=
ode.LogToError)
> > >           unittest.main(module =3D None, testRunner =3D tr, argv=3D["=
__dummy__", path])
> >
> > [*] Peter reported the following CI failure:
> >
> >   https://gitlab.com/qemu-project/qemu/-/jobs/8474928266
> >
> > 2024-11-26 14:58:53,170 - qemu-test - ERROR - Unable to download https:=
//apt.armbian.com/pool/main/l/linux-6.6.16/linux-image-current-sunxi_24.2.1=
_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb:
>
> This looks to be working as intended. We failed to cache
> the asset, and so we stopped the job, without trying to
> run the tests.

The job ended up in state "failed", with a red X mark in
the gitlab UI. If we intend that not being able to fetch
the assets doesn't count as a test failure, that didn't
work here. If we do intend that fetch failures should be
CI failures, we need to make our process of fetching and
caching the images more robust, because otherwise the result
is flaky CI jobs.

thanks
-- PMM


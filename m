Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F8FD2FFE6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 10:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jv3-0008C1-Or; Fri, 18 Oct 2024 06:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1jv2-0008Bs-6P
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:09:16 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1jv0-0004UK-8k
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:09:15 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2fb443746b8so22765451fa.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 03:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729246152; x=1729850952; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KK6PG0ZhW6udMeYZK0+camsq9FEY/Ul+VR0uWL3UzrM=;
 b=sjZrKWw3fB+SmZGofWDkFKRkRrEd5CcHdeN13Okov9ZmkMlzsi7Y3ZnBxFPD/Piuvs
 Q2GuFB5Geha4Q2mWwAHleW4wAm6AICVh5wK3Oat+QXyXTiRn/eDGiYcITMkk5h95lDDE
 VcRC4GWdRWuVqBfPMHmN6QMkGc0neBUzPGL7OQy4C2obZB6ikAkFf8LBgSWhawrYcWad
 zbkceXJU96Gju+oUqgHbQDtu7NQ8wOJFlshgI2NSUQ+37S+axG4JZvymDTjL685tta04
 k5cEM1fSkSGvrkO8ZKFvABsNFTfgmVM59UmdM0P26cOfPD6bIZEKOMMWw7e/twLdkMX9
 XKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729246152; x=1729850952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KK6PG0ZhW6udMeYZK0+camsq9FEY/Ul+VR0uWL3UzrM=;
 b=u7D3Kp2d5mtBITkiObm94Eh5x2t94trgAcnf1tyD9c5srZqSLnDza5RJ3qu0MWCI0K
 TT7Q/V9uGz7JYJ/s5zlBCGVoaS+5ndZJwK64x8KiOHP7Fewd47YRWWZOTg6K1u/Lyy7D
 yo+M6WEHRK8fQhZGXx7fymBB1D19OPrcNOQPLr3Am9sXDesbMU144LGwuO5EyMSyHsLY
 4Y2S+jPkpiaLTVkyBzO9BqGFrkian6hq29hd3uafzv/rtCZ971/VoArqICl5zw2KD0vT
 NlyyTraVYUd1JN40NNnleSW0fnVRn7gfirJWlp3w6OZDvG99PEGCC0tKQI8cCNjsIdDt
 RToA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSO2qKxLkT/cHhMxSU3CylVvRLbXAE4e88sCLdVbcnTM6Y/GTJQ1A7kE3QgZ5n26RD+MeAe+odFVRO@nongnu.org
X-Gm-Message-State: AOJu0YxWNRc1OTpG+c3I+2m1jQ3sj9Uz90AyRGD7AoucEVT6H4u9lGi5
 ME9JXlp3H90uY+d5xCgWDHaeAOR7TBr3WTcPa23QLQ+ryk+R54+ZNlyXF44VeD8hI8iSTIYaVrz
 W7r8H7l8gO4hzIY/iK/cTsiUVfTNIyYOMkH5fow==
X-Google-Smtp-Source: AGHT+IHUTF9vJ5QNC3A/hKrZ27OEHl/EW2A8clYlNzQa7D0XOuFE0dAkUbKrvHwLaGvw9jx3VzKQVWr8DQoO99Abbn4=
X-Received: by 2002:a2e:b8cc:0:b0:2fb:4b0d:9092 with SMTP id
 38308e7fff4ca-2fb82e92b89mr10198221fa.1.1729246151920; Fri, 18 Oct 2024
 03:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241017143211.17771-1-farosas@suse.de>
 <20241017143211.17771-5-farosas@suse.de>
 <ZxEl4zYgHLoLeHCT@redhat.com> <87r08e3d74.fsf@suse.de>
 <ZxIj694WqXwwMRIY@redhat.com>
 <CAFEAcA8XCBrbqGDesL+5su-2Bk_YR1iQ6_X_j9tJZmNK1Kw=pQ@mail.gmail.com>
 <ZxIxsw265Au7fI-x@redhat.com>
In-Reply-To: <ZxIxsw265Au7fI-x@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2024 11:09:00 +0100
Message-ID: <CAFEAcA98ppNuGPKF9iV6ODb2fh-C6gpgOH9qRrhw-0cNsO0bHw@mail.gmail.com>
Subject: Re: [PATCH 4/4] ci: Add check-migration-quick to the clang job
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Fri, 18 Oct 2024 at 11:00, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Oct 18, 2024 at 10:46:55AM +0100, Peter Maydell wrote:
> > We do not have infinite CI resources, unfortunately. Migration
> > is competing with everything else for time on CI. You have to
> > find a balance between "what do we run every time" and "what
> > do we only run when specifically testing a migration pullreq".
> > Similarly, there's a lot of iotests but we don't run all of them
> > for every block backend for every CI job via "make check".
>
> The combos we don't run for iotests are a good source of
> regressions too :-(
>
> > Long test times for tests run under "make check" are also bad
> > for individual developers -- if I'm running "make check" to
> > test a target/arm change I've made I don't really want that
> > to then spend 15 minutes testing the migration code that
> > I haven't touched and that is vanishingly unlikely to be
> > affected by my patches.
>
> Migration-test *used* to take 15 minutes to run, but that was a
> very long time ago. A run of it today is around 1m20.
>
> That said, if you are building multiple system emulators, we
> run the same test multiple times, and with the number of
> targets we have, that will be painful.

Yeah. Here's a recent s390 job, and not one that was running
slow: https://gitlab.com/qemu-project/qemu/-/jobs/8112195449

The migration tests it ran were:

 95/954 qemu:qtest+qtest-ppc64 / qtest-ppc64/migration-test
           OK             196.95s   50 subtests passed
 96/954 qemu:qtest+qtest-aarch64 / qtest-aarch64/migration-test
           OK             202.47s   50 subtests passed
 99/954 qemu:qtest+qtest-i386 / qtest-i386/migration-test
           OK             203.54s   52 subtests passed
107/954 qemu:qtest+qtest-s390x / qtest-s390x/migration-test
           OK             193.65s   50 subtests passed
156/954 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
           OK             164.44s   52 subtests passed

So that's 192s (over 3 minutes) average, and over 16 minutes
total spent on migration testing on this one CI job. If
the s390 VM has a noisy-neighbour problem then the
migration tests can hit their 8 minute timeout, implying
40 minutes spent on migration testing alone...

thanks
-- PMM


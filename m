Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A20C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 11:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmu0a-0004V7-HS; Wed, 20 Mar 2024 07:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmu0V-0004QS-Sj
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 07:21:20 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmu0U-0001L8-By
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 07:21:19 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56a9f5694dcso3547739a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 04:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710933676; x=1711538476; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0P+zcTvI3H7Xal7+zUYr+4Rve9gj7YPDF232aZWRvw=;
 b=BmIWVQIEAXK36GB4MH5t357gcyzoc68pK7WETeoDL3Lj2XrsRQ1h/qBAvi+nJ0Vbhk
 xvVBraT5KjiNM+EJGR9tCU42k+as4n3V95upd4xbq1hGkFQfwpC8By7cUJol/eb8SXbg
 GmYL0w847e6bl5akpG9D4XnBw5vb0L+y6IIBLqEDONN5WneSJcIcha15bASWBVC14F9J
 JNNT1jFNqKDBCmNRFTHdEmuZEaBugfDFXYE8HFtJ1JK+4Oj4NtOCacv45K2+6k0edZMk
 UYKmaGKPXUTkFwqRo7/XFQO7inDwmRJuZT1yjPoWlBQeigUKo5b8BkAH5OtTiZDoXRMk
 O/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710933676; x=1711538476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0P+zcTvI3H7Xal7+zUYr+4Rve9gj7YPDF232aZWRvw=;
 b=wh5Xnf7P4O2T4lsPjQ/QOBU0kBo9JZhxf2YRB1zS9iKF4si6kLxUPygyrvPDMmNic6
 sjguLI0WSceWWrPgxJncgs23fFPeZgfpR+HEC5lcNxdrM6mQmwgRxUYZcGjw3MCLlZQv
 vsQ0xoavui8d2q5Xsxso80L+rJcuz0B6McG6UpCR+ZF9Ji9i1xsdiTPFjFt+7dHnQSp3
 VYt3hvpHDIREqrkAI400VMrgHlqCbGOVqDG+RiiJMIz++5cYySc6Jf8cZTzC7Hm2lc8c
 BLPbA3CAnh4Sgw72jB4oNyXgy2O6rdSO658B0nHI2exgxYuf6eHqp68Pyz9kyDoUiYgO
 y+3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsgQ6l8L7T6BZRqXY+e3XgaBpfIXBAYu7DrrwI9ruKfo4I/uMakubPrf8U0PqEYarX3UfVq2TknCPgds+9MO+LLLmpxD4=
X-Gm-Message-State: AOJu0Yxk/5w66l2mYf/lv5xSk7Tne2M8AjV6Smf6dZdaKTPLrmdLWJS5
 jtl2eWizDqn3LGukjaoi9LVff5TYlvUMz9xzcUYEG9OfSXdtOiN1A3H8rSij3ukICGo6PqB4tKV
 Nd8v3nNMgz277Gb86+k9UcZl6qSJFXgSkL0W+hL5aYk+oYdMi
X-Google-Smtp-Source: AGHT+IGRCZ2EuqL+e9NNTeEOADuD2YWaZR7IPTsWNAE7sVFVzeESQcY51RtLc/ekqA8QqptefVy1Mm3i4uI5u0ft8qI=
X-Received: by 2002:a05:6402:1588:b0:566:ff31:ed52 with SMTP id
 ij8-20020a056402158800b00566ff31ed52mr3530746edb.16.1710933676064; Wed, 20
 Mar 2024 04:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240320104144.823425-1-thuth@redhat.com>
 <20240320104144.823425-5-thuth@redhat.com>
 <08726125-8e4b-4ae0-a095-f58d6c175144@linaro.org>
In-Reply-To: <08726125-8e4b-4ae0-a095-f58d6c175144@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 11:21:04 +0000
Message-ID: <CAFEAcA-zCWs=gh6O6XS15B5mY1jTNow258Cun3xE9uRiqNsZjA@mail.gmail.com>
Subject: Re: [PATCH 4/6] .travis.yml: Update the jobs to Ubuntu 22.04
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Wed, 20 Mar 2024 at 11:13, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 20/3/24 11:41, Thomas Huth wrote:
> > According to our support policy, we'll soon drop our official support
> > for Ubuntu 20.04 ("Focal Fossa") in QEMU. Thus we should update the
> > Travis jobs now to a newer release (Ubuntu 22.04 - "Jammy Jellyfish")
> > for future testing. Since all jobs are using this release now, we
> > can drop the entries from the individual jobs and use the global
> > setting again.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   .travis.yml | 13 +++----------
> >   1 file changed, 3 insertions(+), 10 deletions(-)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index 8da88c4360..16cf706c07 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -1,5 +1,5 @@
> >   os: linux
> > -dist: focal
> > +dist: jammy
>
> FYI Peter suggested to Alex on IRC to wait for the v9.0 release tag.

Yes; unless 20.04 is already no longer in our supported-platforms
list or there's some other "this is actively broken" problem, I tend
to prefer not changing the CI test platform set during freeze.

thanks
-- PMM


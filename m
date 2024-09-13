Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88A0FA3757
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 14:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp7Ck-0003Rn-5H; Fri, 13 Sep 2024 10:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp7Ch-0003Qd-KS
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 10:23:19 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp7Ce-0001pk-Af
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 10:23:18 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so3693831a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726237394; x=1726842194; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUzkJDQLe4bsGE8ujXttYi7O1WdiFW79lLUK+yYP1aU=;
 b=fzFVW+zuDKJ4xpjtKtIw3vIX2xStn1Slc3f/z2AqXrCyhhtsRFTDqJTefmv5vykK+b
 Mx7Jarei2GRd3k+TorMBBcAb/OSc4+IM8SurKG5i1nPfrka6nuCFH3CRO01zBxUkaBao
 5h04K5Wfdi005IUOqIjwMQB2WbmjQ4JLLyWXugOUUoSMEdW7+3sp0AP9JUq2lUneaQsn
 YtJGGePeMR6cFfUmM0xgq24slpzKvemuwYpp9Mok7e/4dmG9PDQ0M/ucq49UieqVxSQk
 0+pbztEOJTrhLcWfh5/HbXGfudvNy73bDMUI1+rfQ0NzVIF/cr9Ziim4PgfuhcY1UvfO
 8EPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726237394; x=1726842194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUzkJDQLe4bsGE8ujXttYi7O1WdiFW79lLUK+yYP1aU=;
 b=L3+XM9vhIxyWDcDU5f2UCEJ46kQ3fcJwj+oej7LZEWItT0BBpm3GgHgQxUjOTyY+Hq
 2/YIGC0wMn2R19EX+YF2zdvlynrpfV+nzEi0wx/qxYkWN6qnSfzVtSSVzqwKf5i3XcIX
 tonizqYlmg3zZkuTaJerpC5w23gDzTfkjrjyOScjwvqLSJicOUOtrhHIgDs/UjzeBwwJ
 p49oihbi83cevEJI/M2fFKTN+w77+HkhmqA5ZvAeUxq1pL/km1cNmOSXkUP/xWidW71z
 7oR9G5EeRpV8dgNgpJExz1y70rcJKXjLIE1NzeKLjJWmiiCyS27aA2md2T0oT28NTrXh
 aJRQ==
X-Gm-Message-State: AOJu0Yx9G/GPEEntXE96ir4qQBiKrBU1DNuJCyo0zmAxf4OHAVwOkgN5
 J560gKI/M8EEtwUgG39ptstnZ2er36s9YdKEoBCCmqUkoBOcwlch+b/97MBpCgFa4sui0Ps2JKY
 6kYtC5ppLVy9MMeCuwqyPvl1f+XYDeXsmpzw28g==
X-Google-Smtp-Source: AGHT+IGr3JYYlFH0ZSw7OWmW0SXyWUTJMlVuQL5muPbTk4fDtRb/RiQN7/4KC/hMIWp1+DpmHIO9NF2V7jLRFNK6St4=
X-Received: by 2002:a50:8d85:0:b0:5c2:5f31:8888 with SMTP id
 4fb4d7f45d1cf-5c401602585mr11443858a12.15.1726237394105; Fri, 13 Sep 2024
 07:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240912151003.2045031-1-peter.maydell@linaro.org>
 <CAFEAcA-ZuE4B1frfnkpS6yxu_YiTastZ9S_b=4_8zGigRtDeNg@mail.gmail.com>
 <CAFEAcA9sUcspOwWU-huyza4Rp=vw=5wArXBSnV-KDVYm5=8u_g@mail.gmail.com>
 <ZuRGrUiawzKk7lXG@redhat.com>
In-Reply-To: <ZuRGrUiawzKk7lXG@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2024 15:23:02 +0100
Message-ID: <CAFEAcA-daVkdEm3y_DK9opuAj7o_U_tkxpuPXPxT7cwY-fK7Dw@mail.gmail.com>
Subject: Re: [PATCH v2] .gitlab-ci.d/crossbuilds.yml: Force 'make check'
 single-threaded for cross-i686-tci
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, 13 Sept 2024 at 15:05, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Fri, Sep 13, 2024 at 02:31:34PM +0100, Peter Maydell wrote:
> > On Fri, 13 Sept 2024 at 13:24, Peter Maydell <peter.maydell@linaro.org>=
 wrote:
> > >
> > > On Thu, 12 Sept 2024 at 16:10, Peter Maydell <peter.maydell@linaro.or=
g> wrote:
> > > >
> > > > The cross-i686-tci CI job is persistently flaky with various tests
> > > > hitting timeouts.  One theory for why this is happening is that we'=
re
> > > > running too many tests in parallel and so sometimes a test gets
> > > > starved of CPU and isn't able to complete within the timeout.
> > > >
> > > > (The environment this CI job runs in seems to cause us to default
> > > > to a parallelism of 9 in the main CI.)
> > > >
> > > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > > ---
> > > > If this works we might be able to wind this up to -j2 or -j3,
> > > > and/or consider whether other CI jobs need something similar.
> > >
> > > I gave this a try, but unfortunately the result seems to be
> > > that the whole job times out:
> > > https://gitlab.com/qemu-project/qemu/-/jobs/7818441897
> >
> > ...but then this simple retry passed with a runtime of 47 mins:
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/7819225200
> >
> > I'm tempted to commit this as-is, and see whether it helps.
> > If it doesn't I can always back it off to -j2, and if it does
> > generate a lot of full-job-timeouts it's only me it's annoying.
>
> Anyone know how many vCPUs our k8s runners have ?

They report as 8, I think, given that in the main CI run this
job gets run as -j9. But we clearly aren't actually getting
a reliable 9 CPUs worth.

-- PMM


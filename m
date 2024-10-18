Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E49AD2FFEC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 10:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1kND-0001wl-2c; Fri, 18 Oct 2024 06:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t1kNB-0001wM-0j
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:38:21 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t1kN9-00084T-9U
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:38:20 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539e13375d3so2263526e87.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729247897; x=1729852697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsZGqTrATme0i7W+JISJIbfmq3xvv7D9OokIpSyW/Aw=;
 b=QSNdwgNnhBW4m1uBI901W2nHkenk45HSKeQHIwLpJE//mluct9KZkO3I6w2X2NJocU
 fO/+5AGkF6ZHFMEXl6/Kiqs4jOtqg+HvFJauWgUfsZgguHci42njeY0N1VBUSfN7kKm2
 dG9FRsInx0pXDxDMXU3g6oZh3f0VG/IAwDHEOyX4fPDojL2oE2UhGmM690kCXtuxjg69
 oBTuMYePrMaw2TaGuIo7epKnbzlFjawerHMS2lAmsE3l2ypOZBgtgCRqwcMobDfmG+nz
 YAW/9GiXEAlD/2qXdoiG5Qddb1zv2Mj83DnfKOShHwyffsxH0hrGFNEbzIJgIZMYAqla
 1u4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729247897; x=1729852697;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vsZGqTrATme0i7W+JISJIbfmq3xvv7D9OokIpSyW/Aw=;
 b=jidg0MOoY/dCu3s758amg58DlFfcfouZbe05jyLusxfwlEC2Sa+b5nQ1kH9gkxreSP
 4dJFeatnUitD+PnSoEkrTIA19tLrEJrPO/urboAU5Z+Qzyw6PtFU+3CCfEKehZexOF/P
 xyKLwks6UJ6mis5vO5WSXUutAP65R870R5rIkE7mz2N8JNK2iC7zXvhGS/ci+V5b1ICU
 Eo0bim3kGIxigCe69BwPdbBp/V9+oYIqX9JepKebQdj7O3uBivhZ1Cu+vjvHFwJi9iOV
 /alpUAUF4inEhwMV66EvxWjifqKChUn1e2+3xgfrV93KvHjrHDdGAndWMmU0Lhdzb3kn
 IUEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQv3jKnmfkM+4S4XtIhWwmDkLyNEbbt4K8iF4oBXNXe4pghWTxJR2KZaXd+lFnJf0b2ChlD/fUrWMs@nongnu.org
X-Gm-Message-State: AOJu0Yy0zcPJPraqIIY6Fbp6EMZFzOXzFDj5spR24XDLAxe+Q7aj8QW0
 thm0scEldHnfOTTEVq7+EBljzWLrBODBFlS0S8PvPsrPvLa4SZzJ38up435z22w=
X-Google-Smtp-Source: AGHT+IGKXiSyKr0PFvL0ptSZXZ6cnTGKWQXBDW7GLhSKl4bLLJGQLde+YEnFzUWoJ7ksTCPgzGL1+g==
X-Received: by 2002:a05:6512:3095:b0:53a:3a:f4f4 with SMTP id
 2adb3069b0e04-53a154adea6mr1000658e87.31.1729247896953; 
 Fri, 18 Oct 2024 03:38:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ca0b0f977csm561642a12.83.2024.10.18.03.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 03:38:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8BA485F863;
 Fri, 18 Oct 2024 11:38:14 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Fabiano Rosas
 <farosas@suse.de>,  qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,  Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 4/4] ci: Add check-migration-quick to the clang job
In-Reply-To: <ZxIxsw265Au7fI-x@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 18 Oct 2024 11:00:19 +0100")
References: <20241017143211.17771-1-farosas@suse.de>
 <20241017143211.17771-5-farosas@suse.de> <ZxEl4zYgHLoLeHCT@redhat.com>
 <87r08e3d74.fsf@suse.de> <ZxIj694WqXwwMRIY@redhat.com>
 <CAFEAcA8XCBrbqGDesL+5su-2Bk_YR1iQ6_X_j9tJZmNK1Kw=pQ@mail.gmail.com>
 <ZxIxsw265Au7fI-x@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Fri, 18 Oct 2024 11:38:14 +0100
Message-ID: <87ed4d8zmx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Oct 18, 2024 at 10:46:55AM +0100, Peter Maydell wrote:
>> On Fri, 18 Oct 2024 at 10:01, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>> >
>> > On Thu, Oct 17, 2024 at 01:29:35PM -0300, Fabiano Rosas wrote:
>> > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> > >
>> > > > On Thu, Oct 17, 2024 at 11:32:11AM -0300, Fabiano Rosas wrote:
<snip>
>
> Migration-test *used* to take 15 minutes to run, but that was a
> very long time ago. A run of it today is around 1m20.
>
> That said, if you are building multiple system emulators, we
> run the same test multiple times, and with the number of
> targets we have, that will be painful.

I think this is the main problem. We run the whole set of tests for
every system emulator we build and I doubt we are actually increasing
any coverage. One suggestion I made previously was to change the test
selection logic so we only run all the tests for the KVM target and one
TCG target. For the other targets we should run the basic tests only to
ensure there is now architecture specific breakage for migration
generally.

> That could be a good reason to split the migration-test into
> two distinct programs. One program that runs for every target,
> and one that is only run once, for some arbitrary "primary"
> target ?  Or could we make use of glib's g_test_thorough
> for this - a primary target runs with "SPEED=3Dthrough" and
> all other targets with normal settings. That would give us
> a way to optimize any of the qtests to reduce redundant
> testing where appropriate.

Does splitting the tests make it easier? Would meson just pick which
arches for the "migrtion-full" experience?

My idea was just to pass the list of configured builds as an environment
variable and without it default to everything. That way running the test
by hand would still have full coverage.

>
>
> If we move alot of testing out into a migration unit test,
> this also solves the redundancy problem.
>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


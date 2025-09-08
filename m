Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD495CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 08:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvXYJ-0000YX-CG; Mon, 08 Sep 2025 04:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvXYH-0000Y6-7a
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 04:48:41 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvXYB-0005jI-IL
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 04:48:40 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e96dc26dfa2so3372132276.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 01:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757321307; x=1757926107; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FDAuu3CNUOZCBZYFCrwtCnwWR/rvhmhkm5xrPmzubrM=;
 b=VCnWL41LqJy6jknqGLya0bEI0DtG+2GH7m1JMCKW/ScCPSZWMOfCieeOB8S1zgT7cx
 LT6q9puGWBND3oXRgdaERBWJvpCLPhRVab8hNX0NHZ1aI4KHWxwxbfAP7ujtrOmdeaeJ
 4ZgZqWjrgXmXYK5U7zquhJmnJwhfeRcHPYNOvBcIV948jJILbSp9c9HfWXt8e8Y37Mvt
 5s5C0mv3+OTbARyWBNVs+meuDCNAXIrzHf/nTUWSGlmVtvE34pk1Oo2etWigLVd7LEoi
 r2nTasKnVFYzKgHT+Uta0rGO+6iDCVlRsGc5iiQtpMA3HEARdOgISs41jCbySgkx2dem
 iokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757321307; x=1757926107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FDAuu3CNUOZCBZYFCrwtCnwWR/rvhmhkm5xrPmzubrM=;
 b=K0mrTz58vTDBjvmGktUj17QeJQJHGWKQ/erF8IKRDwZVMS/fwRH4xtkVhdfoZ42Q73
 FVLTysqMdGDZf2ePyYZitdr8y4cJG246KD+0wuDgiqSiKQFLCGQkmAdBpjsKaaGer6zU
 LzBWbYArw/QjpTqDveZ6haWAsa+QxjKVQPjtg5PhNuuHFKA0S1zDiiyqq57Pycj18PB/
 IscOwGt4ONjBYSjmLJWqrbS3cQVbr6PUeM4hdmKnwiMBY1eIc2jzxpeoxYmoYjnOg+RK
 sas+EYdp+Fq4Xdr1Hmv7yp9tka1Kq5E/9YdyoKKjMptN9ym4asADNL0TwpiBoH5Yhj76
 pHOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWobkMnMD8HrTmw8IYo/NmI8cL6soSYawS2dgEXy5JtkA4dFu1+EwUmjhfuQpqVu0ewtt8Pk6WwQPY9@nongnu.org
X-Gm-Message-State: AOJu0YzDqpGWsYeFxdSSb1p8Tc4pLeXAw3dwnx06vwrnkFKpcw+giZhJ
 /cQBm41skcTJBh5TnmLo5IywEjFKn7/gzfx6vTjSpnxQaWMaGc8/+2HCrKqoMFAKRq42MK3pmSY
 aPaeEemIAEg2vcyqjWX0yR4Uqjp3XWUJdKaUkTB8EuA==
X-Gm-Gg: ASbGncsq0+LzOMmo1/NKLGpDLA1f41Se30eCQMw3nTJtz+NHQGqnb/ovPQ0tXyx/ZV+
 gT8lL0dGBf4qZgQRX+HAyneX3BWTuw3JHtaO/QhpU3CXq6Fg7V2sGCu+Klv4Y/5RvsIbENXNMgp
 z4tHSFLjUni49gOpf1nxylZVUgyXlIniZm6NsamC9D/uzex25pBIGVsEdhn+mbhjewiMMNx3QQ4
 ko4OCr/cwzCOhaBmDg=
X-Google-Smtp-Source: AGHT+IGGHjfKjfu8fLIrQa7IeZstcCOQDWsBW9EKrwmICkuRRMl4GUynqDORa02yj6DOaJsoUUnuqYmLEO5qjyoSxJA=
X-Received: by 2002:a05:690e:14c9:b0:604:3ec3:95f with SMTP id
 956f58d0204a3-610223a8245mr5955630d50.6.1757321307229; Mon, 08 Sep 2025
 01:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250904-python-v1-1-c43b3209a0cd@google.com>
 <6e43209d-645f-46e4-a23a-2a1ec149dfe8@redhat.com>
In-Reply-To: <6e43209d-645f-46e4-a23a-2a1ec149dfe8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Sep 2025 09:48:15 +0100
X-Gm-Features: Ac12FXy6a21uRcANmXYIHCACwnCjwek8oj6_F67s_dNQR0v0TF0voNNoFpz3do8
Message-ID: <CAFEAcA8r_dw1bBrVr1vexCb0QOm1NFmo2FPMpQEFP8RGwgqcEA@mail.gmail.com>
Subject: Re: [PATCH] Use meson's detected python installation
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Foley <pefoley@google.com>, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org, 
 nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Fri, 5 Sept 2025 at 08:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 9/4/25 17:11, Peter Foley wrote:
> > Relying on `python3` to be avilable in $PATH doesn't work in some build
> > environments. Update the build files to use the found python binary
> > explicitly.
>
> Meson already does this, if the file is not executable.  See
> docs/devel/build-system.rst:
>
>    Meson has a special convention for invoking Python scripts: if their
>    first line is ``#! /usr/bin/env python3`` and the file is *not*
>    executable, find_program() arranges to invoke the script under the
>    same Python interpreter that was used to invoke Meson.  This is the
>    most common and preferred way to invoke support scripts from Meson
>    build files, because it automatically uses the value of configure's
>    --python= option.
>
> Using "[python, 'foo']" is only needed for scripts "where it is
> desirable to make the script executable (for example for test scripts
> that developers may want to invoke from the command line, such as
> tests/qapi-schema/test-qapi.py)".

Wow, this seems like a super fragile way to do things. My
natural expectation would be that scripts generally would
be executable. If we accidentally make a script executable
that meson is invoking without explicit [python, ...]
then everything continues to work for almost everybody,
except in this corner case where the 'python3' on the path
is sufficiently wrong to not work: so we're likely to not
notice the mistake for ages.

-- PMM


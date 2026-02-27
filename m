Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D3BFD530A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 19:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw35p-000171-W4; Fri, 27 Feb 2026 14:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vw35g-0000zN-Hs
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:01:32 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vw35e-0005MP-QK
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:01:32 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64ae222d87dso2220347d50.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 11:01:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772218889; cv=none;
 d=google.com; s=arc-20240605;
 b=EQYKAni7DAnCVh2Csff02eP4g2OJPZ0qpGdlGF04YudcQoAIAbZk1dOvhnqMl20fpK
 soZBB9yM8j0Jd7NS1No2jx/SHGH/VKsGBYwYJWBSmHItsOygMAjZyD++5iF3TjgSaaFZ
 VqU2Rb+rl4ODPQK4asmZwzsLiMS+J8Mjt1J0939xKmUKJma2tkUCACdz/Xxe1+A5FtdI
 cuq7mxckavADZcNCArEDPF1OPq8DQh6e+eRNY8GUcCkso9h3FRjJmzkFbN8exrk8agXr
 Y67qZ7yodxIOT6wzg6e71xgFxBLXvNwipsFO/hEUYoWUwZO7LMxlKfRtHpJRK9voGd6k
 zWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SULAEUuAj73q2fCD7zwSktbXm56L8xKX3BLqNOyYMeI=;
 fh=L2St6t09imbxtprj7esOWNydLKtr+18WRDEVyS1YvsM=;
 b=dN0oW+22DAdUEWIhs8fYY9NLx6+VXRDb8700Z531s8In25nqrJ1qEL4LklXcGJczGo
 5hzPkKgnQYJmWLFoeia7rDhl7FRGC38fBoq6G6k21pZ4aaQqqG9rYdC6/l/aQNOl1Al3
 QIwdMfQeKylLE62DgbC0xLj6/ofGsw1EG+vCVJ5Ue/uu0B/7ORceCXSmKb0IqXZGfSLZ
 lg9KDMxNdJhcb7N7dnh+bU9YsIpgSA8SFQc9FiNN/PWnMtrQzvnEtJNLsBCS3MXbdY+t
 tn0BZ/UAV9MGvZVy+wnRJlvPVYaG3hgMK9k0VvOCFUjyVWrlJR58jsSrjS5xv/hSzM3e
 HL3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772218889; x=1772823689; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SULAEUuAj73q2fCD7zwSktbXm56L8xKX3BLqNOyYMeI=;
 b=yEJtBV1YJ/eb+p+wBMtlRRQ8qzVBBinzERCi51qYoBaEViW0zku3ub4gQgCp7t6iKc
 3aP3E++fi55f3F7F1uDpB2oYeMHfeewmvMNTPifhRwIwsusra1UdR2hca7ZQNZ8pqCzT
 9e+lrPJv/mqpO86nupJk8o5EsNzGMriCSvsTx/yMiYNum8wgDGq4MRbMTEZg0ztSdN/T
 V9SqGg6XOXyF3Ai4tI0EkaD0JUzeFPom/LWx2KJbNJMtTSzQsF2G1uzmNANHCs7TrMpM
 QYe9PFBsCd3+2KKcge3+IOYAnARD7zi2NqTd8hxEk3CuhrRR4jvoBju6WN8hkkhSJJgP
 41tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772218889; x=1772823689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SULAEUuAj73q2fCD7zwSktbXm56L8xKX3BLqNOyYMeI=;
 b=xMiVT2kn5D+lzpl8IDoyhlZwvClTqiI6BS5fQ5dWnk9JO2B8AsFZJyUHNsX44irYjx
 PvCEVWqmrzbMh4bpKAs/rCyiISdVIVwWJ6robN3kMvtH0djfqFHoO2dYnpSJlXgif1SA
 10XNpJy5Vj5XUwu7eDf4e+Jd18wLxj52I954YSq7LUXNPxe3Z61ViGpolKBcaBOjQePM
 pbO/uhs2KU1OzJRMnCt/QoiNS5Bg7eE1DZGEJAFAFWQ1v4qtntW9icfSL01tuCdx7G3Y
 gY9XC+wylHIgzXCz+So2WvKxZRbzj05l6XwrXdo4tbu+Ty+QOci1jws/iDlvvG17kv4k
 90RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM88qB7R0DLpfoklOXNLQI45qZDZv94UgIIvdp+aolj0e1TespU0MNDhRKdeAHZD7HT236VeNHOmFr@nongnu.org
X-Gm-Message-State: AOJu0YxKtxzf+LUjipCvVKzRtpujQ6YTeVu+W4zsnShYZTeqtN3xqz2E
 o/Vq345iCZMaa/WUZ4gBeF4lJgPtQzUdZr1O9NUtqra+k3+DtviHK1L+NGOR7GCMhEo7NgpXTrZ
 FahUfKZK+n0shWakJEwNQ0fLSHGpeBDsmFla6oc9rVkMav0JBjq/rvPI=
X-Gm-Gg: ATEYQzzAmXQBerMeSE2ZUoXZQFbIj0u4Rk38kY5Fm1jbZ2yILj/4RV9n97tRO1bBdZ+
 VOZK9NOShYUoi67Dnw7qu9P9huGgL3UZtw8Ap8z5bDwPiIodrTDF6sfvx4/mtK+UAhO3vvVJOZi
 kvBeP/r7K3Vo7qJwRR6n90bo4/S1fMCnGareFMONqJu2uX3rV+oeQnEXuKTz9lZ4VgB7EKkS2wn
 oiIYelzk1KMk6iMEgh06DFOL408qpEOHudU3eaPJST+4wYqfXF51Bvn3BRpPsXNeZHeCaZwOM4q
 Zz41Vxi98SeaICZ+zP+wS3IX44Nu6qS0TukUxXFzF1ijrSxlxADHG8vV5VczXxBSDCs=
X-Received: by 2002:a05:690e:16dc:b0:644:60d9:7514 with SMTP id
 956f58d0204a3-64cc233f94cmr2441738d50.88.1772218889291; Fri, 27 Feb 2026
 11:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20260227135736.2280161-1-peter.maydell@linaro.org>
 <87ldge5899.fsf@suse.de>
In-Reply-To: <87ldge5899.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Feb 2026 19:01:17 +0000
X-Gm-Features: AaiRm53LJYTqOvy_kESUmBEk5XK9GeB5E8Kq-3_IM14Xi_92bEfRkcVdfs__3lw
Message-ID: <CAFEAcA-xvHDyE+gJ6KKv=rkEbiTbdtmAreLNKsGTuvvZyZyYDA@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm: Fix some memory leaks
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 27 Feb 2026 at 18:52, Fabiano Rosas <farosas@suse.de> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > This patchset fixes a couple of minor memory leaks I found by running
> > "make check" for the arm targets with the clang leak sanitizer enabled.
> >
> > The first two patches are necessary because there are a few leaks
> > that are either not interesting to fix or which are not in our code,
> > and which otherwise clutter up the logs with failure messages.
> > We have a suppressions-file already, but it's in the scripts/oss-fuzz
> > subdirectory, so I move it out as it's more widely useful than that,
> > and add some more suppression lines to it.
> >
> > Patches 3 and 4 are the actual leak fixes, which are straightforward.
> >
> > This gets me what would be a clean run, except that there's something
> > wrong with the refcounting of qio channel objects in the chardev code,
> > which results in variously use-after-free, leak, or assertion failures
> > when running the vhost-user tests in qos-test. I'm still looking at
> > those, but in the meantime posting this series gives me something to
> > point at as part of the repro instructions for those errors.
> >
>
> Looks like something I worked on in the past. It seems this fell through
> the cracks:
>
> https://lore.kernel.org/r/20250515222014.4161-1-farosas@suse.de

Yeah, that looks very familiar. The way it only reproduces in
a loaded system is fantastically annoying -- it relatively
reliably falls over in a full "make -j20 check" run for me
but I had massive trouble trying to get anything to reliably
repro in a useful way...

The vhost-user-test also seems to be doing some odd things itself:
for instance the wait_for_fds() function assumes there is RAM at
0x0, but we run the test on the arm virt board where RAM doesn't
start at that address. Presumably we should either make the test
handle that or else restrict it to not run on boards where it
will never work.

I'll have a go with your patches and see if I still see issues.

-- PMM


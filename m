Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AFAEE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 15:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNO7-0007Nl-3b; Fri, 06 Feb 2026 10:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voNNz-0007LQ-1T
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 10:04:44 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voNNx-00018R-F7
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 10:04:42 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-794ed669269so36166607b3.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 07:04:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770390280; cv=none;
 d=google.com; s=arc-20240605;
 b=UQ6txoNYVCTt+NzQ4SLync8aZWQJpQ5DDlFRNuyYDXf/MSH3FWTKHzsqQxtaJ9XpNX
 td2k+wnC0GliGY+N337BZP8oACu+YF7LvfXQNZY8sKwkXoXIOifrR12mZFTpFEyAGqIN
 oZzueBcXze+gYskIKG5wOljqt0sCEYkApT2nbUQdtOb9G/OrTW+wYHNDrAO7vMCcZ89F
 FgG2ZWunU15vh5wmeb3y3Tpf2xQHjw1vYpf2WsXkbLQ2dC/zCre6kgtR/rSVFZSxxfBu
 sNovWJylrBhgANwHWe4rJ1ysMjFRrvzpuGakA8bO5DIgn6IsHLOr0hPw5FlNRISAqJVT
 FKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WWKVKwffx3ABaXHjw5L46QdjvYJzDChzNCZ7gFptKZw=;
 fh=vyuR9kUE4LOqAK+3ouK1AcMdRn837Q+rpbjb+/DO6e4=;
 b=eG02j7k0Qn6AHfTslD6K//7qHc4ryMZ0axIhCg01VQZeEjvH6RIvqAOvdziKgjhm3W
 uU2lyjSV1WCCUE91shdxJtwYNUAxhdc087NCr5IQA3hnLJz+yBnctwPgldFwtNEWVRDC
 nxw6nT0GVHqi/FblXjFsRJsoFwJPFwfUj6QeYXpKQvI9czbn4BsK5M7nSQ8j1TRnhkJD
 vxndKVhuPyzjFeexvWZkrMuQy/B+U5689sgzaLHJOGXj8mky2eBqprcGpC7eWS24DzFj
 dichD0IIMwAe0u3K0wzsce5GjcDtI5xKJLr8FwnZ/8OTgCwCn7B/ODPDxiQZDM5Zgsz2
 ctSg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770390280; x=1770995080; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WWKVKwffx3ABaXHjw5L46QdjvYJzDChzNCZ7gFptKZw=;
 b=C1YJK3BY67m7czsKjhHufWob+6ZjHqHOaqxSmDaWkPeAhyqdRuBlUtULItEJHFCvld
 pxEVVIysmYNUiqpTs2M8zgbWQuw5ola3TYbimTG1IsvFb4OjHd/75I6w6JOIR6H4k+Uu
 A+O4AK6I6z2bu5cE9jXcVAyM3v2VMhBiu2CzVuSTY9q0xrlB0UGWWwWmGBVK60JGXTKu
 on4n89aNcBNVpl3IH72pcB/869EEAPQfrxhkd9uXMKGzDLceFy5bxVV9y7FfDnVQ+tGM
 Mr+gyJMmDbEW7hpii6SGouCnvxXAwhVH7ILtdpZjaupNJwigStSf36jKKUuUcC/79FfL
 UJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770390280; x=1770995080;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWKVKwffx3ABaXHjw5L46QdjvYJzDChzNCZ7gFptKZw=;
 b=qZB7I4wOg6zvvWLOgvVqk9tduW/MutVx40lEUFPLTRb4eVEbvrlcnAJArn/MrhXiGP
 m8DfGASQhzC9GuuauQWoUCtye+WLKYv1/eeII1sUqSpbZ/2fJkko1n2w7BmcnUBDAvRV
 Df9ef0mFWUptWLtOMfKF718u8EVH5DFsyNBAmHQerSo41gSoMeDrOYt+k4uEI7KpdYo2
 CyV/0qOh88vC5Bv+Ol0h6fmqU+mY63j2IEYdd95qrXs3CGvscf1whgLWC6ia41B9+Fn7
 r5awww6onv41gJinqEWGPxCMi1lwQwq6rokkC9MN9kshlj/XvcfHjl/UFh+Cn0SWFVVC
 Eihg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSfK84EX8WKrD7KB9uIuwzbflMuWz0Ke44UK2sJEG6mvVT4hyrFQkEYyVfi7+KMYJv9vrbg5wwdGG4@nongnu.org
X-Gm-Message-State: AOJu0YzYR5Mjm8SkRgJcTbPnOG9q4edcpP9fLb+pwwNVJEKgXlIpiWMP
 J2/7tt0WAUvESbXF9wNQZdxS4g3A8p2TPAwsXUze3pq5vWJ1D3oPkWZtbqfwXPrcQ96MUbCC3vW
 /H9qRIf+WCwNt199TFExX4hufpdX6JBcuLMfBYgOVEA==
X-Gm-Gg: AZuq6aJo+d5Ihnyc+T2a8fjIrP/IAFQ8ywlAxKEhZayiT2NrH5pQ9ZIQsudINwbKCIc
 4kcSPb4ot9bwR9tAP2SJpaCB26l9YRhWglWqg72jg+/NtTkfYt+AT8qq63ZJ6YlcRGeUcWAYUjt
 dLhBOR0iSwctjyntih1O4DTSBaLh4vuHgCJHWgHCqyeLFUlCyiORayVuqHHXX9goZtO8M5ysbUZ
 sLUDF+CoaAkeq3OT4G192Pw/Ryeb7jOMYVT+BYGvwm4EAVnCFcEdBUCo1ML33Rakcb/BLvy6zIJ
 LUK+fJIEGDLzm6O4ptaTIh9x312Kl7FTRjl6Ogxqrh75EXGyLIfplwk=
X-Received: by 2002:a05:690c:4987:b0:795:905:c047 with SMTP id
 00721157ae682-7952a63e7a3mr26422257b3.3.1770390279776; Fri, 06 Feb 2026
 07:04:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1769701431.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1769701431.git.mchehab+huawei@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Feb 2026 15:04:27 +0000
X-Gm-Features: AZwV_QjcbTxHYWE6ovlXaqwYCMPaJKyxx4VbwSUJq5dGDIEAfZ1eKc632ARwgCE
Message-ID: <CAFEAcA_xbo6J9LTG6w7T0AU1UCjHvYWfC=UKOpfev4X-fGbbXg@mail.gmail.com>
Subject: Re: [PATCH 0/1] Sync kernel-doc with newest upstrem changes
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: John Snow <jsnow@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Thu, 29 Jan 2026 at 16:04, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Hi Peter,
>
> This changeset does a new sync on the top of the Linux Kernel
> kernel-doc changes. It is in sync with latest -next, plus
> two series I submitted today to linux-doc:
>
> - https://lore.kernel.org/linux-doc/cover.1769673038.git.mchehab+huawei@kernel.org/T/#t
> - https://lore.kernel.org/linux-doc/cover.1769701598.git.mchehab+huawei@kernel.org/T/#t
>
> After linux-doc picks my changes and this patch being applied
> on QEMU, all differences between QEMU and the Linux Kernel
> version will be only at scripts/kernel-doc.py.
>
> With that, syncing from Linux kernel should be as simple as:
>
>         cp <linux_dir>/docs/tools/lib/python/kdoc/*.py scripts/lib/kdoc/
>
> and eventually add any new *.py file that it is there, if any.

This sounds great -- keeping the sync as simple as possible
is definitely what we want.

If you could ping me and/or respin the series once the changes
have landed in the kernel mainline, I'll pick them up for QEMU.

thanks
-- PMM


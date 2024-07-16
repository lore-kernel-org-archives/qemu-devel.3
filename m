Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EFCC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 19:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sToE6-0007qG-HK; Tue, 16 Jul 2024 15:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sToE5-0007pc-A9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 15:52:41 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sToE3-0005XN-M0
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 15:52:41 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-58b447c513aso6440170a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 12:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721159558; x=1721764358; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XyzJyIWdZSdOyKdSD+N0CLsjpYqDypIR11rjGDjOzfU=;
 b=ZxMz4B1P/1QC3A5MF6OJw+UYC25yv0HoN/Q6zIJaf/aNVIwUaOXw8GAZnteGi848GL
 xo/h/81tlVURY4ZuTtKJUNQhahTZ83/7FKD/K0RI3Ff6lDxziq1PKog4DoI3mnWS3dTn
 4WYvMolCRH5eLiairnzwNHkI7MBp/fwEsNRueD7oFChzHX0LGeJQPcIx1zwsNIHb/9GX
 iCvIhS4O66a6KGF3V2320RbxIUdXdpxcMCY6T1QFAt+IvNKuOarPrjOg9IySLQff8ZCC
 yu0smVEZvLwytK0jGcf+K+rSYglJS/7WJCnox+QyoPM8rGhXyqyGl3DzGcc4mDbAudAZ
 8avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721159558; x=1721764358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XyzJyIWdZSdOyKdSD+N0CLsjpYqDypIR11rjGDjOzfU=;
 b=gzTph30fOthU/r60ywMy23G8hyxttX46pDuz6kmwDbt+6RiGt2hvBXMyJjKgYcuzoU
 +pyTs1WPQcbE2u4uo+mnc9Gd7jTPJysyX4N09ANkEIpUBuhAkb1MNRV7U7KlIaLuozvm
 445MF6GVESoL4aYclIXVTCBd1qxKA//m5LxKMBSF+piOdbuZEVWoNe3NdFvU/lzBm8H7
 kc6R6HkbPTkbg+fOvNJrZyaqz4/O0CL1EZcs4GmlAFl5dX29mvmI8H8x0cVDZWmXHF2R
 o/XUQyyI/UTc2EktnGYxJjCdOsmYJhfBNq2gvd5aAsyqJla54hSYJpFLSz84WeERLLzb
 k1TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdfkIn1kaYcKKwgXzM60ozct9FNabdaH8lp+0nwdO+y8xf7Zvk+Gwio0XqSkPHUrUUWVhMOvMK4Pe7kv/VKIB9OmCWvoY=
X-Gm-Message-State: AOJu0YznedlPgzZy2QXMoaO2dC7QCO0EB/gTfaDXkv2xj+LXAxvPF6QB
 lBO8PI/u1eLhSf+WNuCZTiCNSCP9z9fjbacFBkoPWshjw/bBePQ4NsS7zQOO1Wek+Apy2AUONOy
 zgUYOj/cBS/87kbOM1jo2cP2tu3gVC3hySMnwGQ==
X-Google-Smtp-Source: AGHT+IGCsHOas4DDAVVORGOc/2FgD/4LYV0AdLyBbR18gfu0FPgNHUg8HJtpuvFaK2Mqy0HAFyS+JDrq23kF8sjqAXE=
X-Received: by 2002:a50:d797:0:b0:59e:f6e7:53a3 with SMTP id
 4fb4d7f45d1cf-59ef6e75a49mr1974567a12.14.1721159557666; Tue, 16 Jul 2024
 12:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240716125930.620861-1-imammedo@redhat.com>
 <20240716090554-mutt-send-email-mst@kernel.org>
 <c8208ef8-0a97-4aad-b49c-cbafb7ff5817@redhat.com>
In-Reply-To: <c8208ef8-0a97-4aad-b49c-cbafb7ff5817@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2024 20:52:26 +0100
Message-ID: <CAFEAcA-WQxqZCY2zuTKhUgdiO8HOKee5aj6dJNFXZWk99gjdTA@mail.gmail.com>
Subject: Re: [PATCH] tests: increase timeout per instance of bios-tables-test
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, lvivier@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 16 Jul 2024 at 18:45, Thomas Huth <thuth@redhat.com> wrote:
>
> On 16/07/2024 15.06, Michael S. Tsirkin wrote:
> > On Tue, Jul 16, 2024 at 02:59:30PM +0200, Igor Mammedov wrote:
> >> CI often fails 'cross-i686-tci' job due to runner slowness
> >> Log shows that test almost complete, with a few remaining
> >> when bios-tables-test timeout hits:
> >>
> >>    19/270 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test
> >>      TIMEOUT        610.02s   killed by signal 15 SIGTERM
> >>    ...
> >>    stderr:
> >>    TAP parsing error: Too few tests run (expected 8, got 7)
> >>
> >> At the same time overall job running time is only ~30 out of 1hr allowed.
> >>
> >> Increase bios-tables-test instance timeout on 5min as a fix
> >> for slow CI runners.
> >>
> >> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >
> > We can't just keep increasing the timeout.
> > The issue is checking wall time on a busy host,
> > isn't it? Let's check CPU time instead.
>
> The timeout setting comes from meson, not sure whether you can switch that
> easily to use CPU time instead of wall time?
>
> Anyway, if the bios-tables-test is getting more and more complex, it's maybe
> not such a good idea to run it in a job that is using TCI ... Maybe it's
> best to remove aarch64-softmmu from the cross-i686-tci job?

It's one of the few tests that actually runs code in the guest:
we definitely shouldn't reduce the coverage of the actual TCI
part of the TCI job, I think.

I continue to think we need to find out why this CI job is
perpetually flaky and fix the underlying cause, not simply
increase timeouts or drop test cases or configs from it.

-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9734DFF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 14:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKHEY-0001VL-KL; Tue, 05 May 2026 10:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKHDN-00019A-UO
 for qemu-devel@nongnu.org; Tue, 05 May 2026 10:57:41 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKHDM-0003mo-0r
 for qemu-devel@nongnu.org; Tue, 05 May 2026 10:57:37 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-651c366f7efso5159725d50.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 07:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777993054; cv=none;
 d=google.com; s=arc-20240605;
 b=iuMGtNvK4tMllkCbOpVA8xcHpb8IrPLImZ54tpnCXPz0aemiTitSi+3yRLgvxTpdbp
 rr/hwtLqKSWEWlkNLgFkLq1BVI/EX5teivAqBIRzGTDSu9lBmO0CpMGd7ULubjyQMGne
 DKpTZY2QYsggHVltchxfO7NGHtMNuCQhNzHivNow0/f/Byc2ee1FzAVlYTzUm1VtKHey
 BjQeome733VHrHFAjjHaJBbOOJTyNpHaHgqeKsZp/FRBwtwjsNanv1RSZz1YP5mB7Bm3
 qXvVKVkCuqCrEplFWAxJRowgNc3T3EiadjVlUk12TKE93mUcRcr3x8sxYBR4pL3F+M0W
 wMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9ilkxcSRkUjPKURQaT2dR8e3nPYLbpkzCOzfFMhchFQ=;
 fh=GOP80JPN2l2ZporM1TCZUZhADnVpgyZ7R005tMMGOXk=;
 b=jm0wvR5gpWGOQ7TvVjkLP8xQUsmVxSNHxlV9PgtVOaOa/1msBU2rsAYePIbTrxziAz
 bU5GBFos8qTp4wgadFJD16AkMqhe2XldBZYZBp3DZZ39yExnCJ0PXfOYllWzWEXzN9+m
 kqnRDd0LJbDEOGCRwErst9h0r2mVai+raW2J3mrD2lPaW0MBv0iusuJpQqpu394az1r2
 luXia7Q+3YsDGtMNdW3hd/pNIhuJhmXCovb37SuFvs2ysXgF+gUCbs6Kx9rnB1+OHxkq
 Qena1lOBbJt/XWcFVMhVV8DLLTF6HMX8u7hMX2HMbJykD7k60OKKoQLjDTDF9P51rWy8
 1g1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777993054; x=1778597854; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9ilkxcSRkUjPKURQaT2dR8e3nPYLbpkzCOzfFMhchFQ=;
 b=k3gCLnJY7LsGQz5eYUskUj693IJtIkTYFGiQaMcj2KtDmFixxsOZpDWUVQpKqanQF7
 XgiS/aI89nvrzA+ZbCcpFZqB4HofXOpSJRR78s7VkhAROsd0ay9jPtl5+UV4L+FuoUvj
 DCq8zzLEGVEeVgXWAyKHQFdqUFTOrQR5W0+sWZuYWyfjd/moNtjBJiShQfIZ5BiZ7EeZ
 2ulVCwLcMBnMedibLD3YvpCEn/mrc7vCTb3BBrkJiWyQCYwU5Cx72NBaMZ6SAvkOgwhq
 sUKMxVW1jj2bZHFxZ1WJyxxVbtmC38/cOIy9oCT484PSbrNJLoqARMPkw7h17CHpWMct
 9eNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777993054; x=1778597854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ilkxcSRkUjPKURQaT2dR8e3nPYLbpkzCOzfFMhchFQ=;
 b=P7ymAG+nsCHT/jGk+77pABCckXL384YQeD2IAzEv08FuGNRrnYtPSXU4IovHc8gsNI
 hsjYlZbYqJccuYgGHC8VbAYu6uxoWzNtpP6yYr3naIDrskhPdw/ZnuamDKIMmX8ESnFY
 i6VQyV7cH8aSNq+iRHWLPEFTi5GmwwzHWQP273YXWFksFOMSC2hcnKUS3Rh+QUuBMdh+
 dm7m1AYZona39zHwHTKAK7gqUJEJ9EgFbjUIs14hVu3ewYOcII9LunpL03GJtjkTzBom
 8Xh++f1DC8n0qRKuyXXtUBYmCpndxI66QMM5KpNvAtJjo5WzRsVFX6M9bEYICtmP1Vr/
 fIzQ==
X-Gm-Message-State: AOJu0YyZYxl/DdrgQj8dDQVqerobYuoKW8dxK9HKGWuYqyCrXyeq7oY6
 Lx/SkrQpFgOXe70rZIgomUpITNlx/9MhYejObsqCUS9aSr/BArR/A1Qp33dn5Q8r79gHUhphjCY
 XU5tdK8om2r7O2Qz5x1bRvneOPeno3HVXVn3Y7tXzLw==
X-Gm-Gg: AeBDietZ5QQ5GgkTAZKXj74YXwUs11QbYX0axVRVTQneCBPvTdB5UNevYqOi6Bm9jCU
 qeDwhjPZZA3cWSfsM/tV4/CvQA94sI8/NyytCKa8CzG9lZKHJUmk2rTBain5PeZu/pHH0LGwLEX
 sjRNf828ME6cNYhUfIonOj1BTl0m1QmOEqC3yaMSpR9BGYEp08r4Vt2X+WnZEZCDxvIUrLw9AmG
 /LUmIdurhLHzDLfxRHXWRHIWgnnvCZmh8t5r0ikmP52cyl/cy9/j0xqKoPiZcH4zu19/DFhpyuo
 QjZJ90/lU8fSjMzWpgHhRQhR1yCyasRd5jcOf+7gMqDoKBCehh5zZB1il2/HG3Afgf4ohVLdpWC
 1xA==
X-Received: by 2002:a05:690e:4195:b0:650:7b5b:ed0a with SMTP id
 956f58d0204a3-65c3d9d27f5mr12387240d50.1.1777993054233; Tue, 05 May 2026
 07:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAM5Ud7OgnsygAHxjGEO-qo5+3zYiAQFN85D2bx1Wb62vK2hzRw@mail.gmail.com>
 <CAFEAcA-SAvi7uXOqS06Ai2cKXJ8pUeZYzWxi3WbhUsKMbhKi0Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-SAvi7uXOqS06Ai2cKXJ8pUeZYzWxi3WbhUsKMbhKi0Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 15:57:22 +0100
X-Gm-Features: AVHnY4KrVMoHh2pjT7XEs2sunmd7tw8P0T6jrq9wqC8gTEKt4cMTbKRfQiq_AfQ
Message-ID: <CAFEAcA-8C8d1r_SJ9ZMWpfzbXZN472az5njboRdkrxVw7rAEag@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] raspi4b: Disable L2 cache
To: Alec Ari <neotheuser@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Tue, 5 May 2026 at 15:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 24 Apr 2026 at 01:44, Alec Ari <neotheuser@gmail.com> wrote:
> >
> > From c5eabff997cf2231326c532c2cbc51fa1334fb9b Mon Sep 17 00:00:00 2001
> > From: Alec Ari <neotheuser@ymail.com>
> > Date: Thu, 23 Apr 2026 16:42:06 -0500
> > Subject: raspi4b: Disable L2 cache
> >
> > L2 cache is not implemented yet, this patch requires
> > `clk_ignore_unused` to be set in the kernel cli.
> >
> > Now able to boot a 7.0 mainline kernel.
>
> To check I understand correctly, to boot a 7.0 kernel you
> need both of:
>  (1) this patch applied
>  (2) the "clk_ignore_unused" argument to be added to
>      the kernel command line
>
> and it won't boot with just this patch alone?

...also, the commit message talks about L2 cache, but the
"brcm,bcm2711-l2-intc" DTB node is for the level 2
interrupt controller.

What's the failure we're trying to fix here ? Do you have
a kernel log of a failing-to-boot kernel?

-- PMM


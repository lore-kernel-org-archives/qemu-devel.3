Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D09CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNIA-00056n-0Q; Mon, 27 Oct 2025 09:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDNI8-00056e-4w
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:29:44 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDNI2-0006F9-Jz
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:29:43 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-63e35e48a25so4849914d50.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761571774; x=1762176574; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G3r7QarJlMlOShYQ5z1qFAKOuJaRk0BIQS4KzqEqg2Y=;
 b=u+cqQq7+48CJQm/DK/XeyA56ELCOUUdRFp47nEia1A+FNtqDfWKaSPwaIlwOZpNU1O
 MQ8JsFLBeC2LodxJzN12fMFo7SlinF2Gdkc07BctVjgSY3qqA8xYnXbkA0DQwHLwn0vv
 sWLQ9mHb1cAjp7lYBQTWaUsyKQkJUbzEvE6vqiPhimALPMdCQ17u1ugVWoyhyYbh1vn3
 G3b+totgFfwDmR5gPv2QPG+tmGmOKC2BGHcPiAQFvYiC1ieLTdqeAKiAOQjFyNAZbQPe
 YVSV9GaMO4L0OuLq6i8kTV5U3bwvJ0quyXTuUw7xR3/wTBRFFsC1FL36L6nx7U8KOUUh
 5ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761571774; x=1762176574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G3r7QarJlMlOShYQ5z1qFAKOuJaRk0BIQS4KzqEqg2Y=;
 b=HXOunjUcw1bNP0O4M1F6Y6m/NbO/oaY44a1msPmEbOh203Ppi1sHG9hDBO6L5ZEmTz
 7+/ZtEXauZ09DdqysdMbJ4Xu+6m0KDSmUPV9WFsriEq9hBb0n1QHK3C857xZaCnWKYi4
 YHAoJ+uotM1VZ2PL5F/xPRqttkLgPbpdhIL+k0uFBUwq7H7KQyHaz1RvFh+t9YC9B0Wc
 kdo4ssTrqjZ//+2yLT6nYH2kT8KtBdXcowrhQkwXFc4MNWo7Rcoo0v/gz/Yo4SFtBEzA
 Q0aKvcvKcvedPhTIEgWPZX4B+SbVIB/aKswZetDA6Vo1lfRCTtDImKvy2+5ltQaUN+lh
 BvOw==
X-Gm-Message-State: AOJu0Yziw54+f/gVK4y9Z4dFIM3TSRJDPu/hEBazXKo98ZA+yQ8hp2cO
 JMHl8K/3Gnh2oDcfQcjYZOm17vp9vSf7CATNfF6f+YJZjXo/16oNpuz8LvUpSiVT/xedoT+iN2c
 yAbZgjuzjxWU8TT91qhyvEGf5i5LNoZiTaojKslAVZA==
X-Gm-Gg: ASbGnctpxWkAkKggkuru8bfpngrd+DYnSNa6q2SU51TlcCVqm0bGYKlnUNiN/cUXYHX
 d70Fp8q5E/9Mfq1xgEucSfzzIe68wEW/AGF3m1B9vqeLW4RhnK7r7odVNgQW9a41vc162F9d773
 n/6cDNwbw23Q0Nr70cPKMbvIbq2Se/iK0nMIs4QLmv+CwJcAfdR3nvmkKIkwBI+SUEymGfNSGIf
 iuR+IgDl1Fe+1WsdQnsvp2dJHRW0gAdEzlYorp4BzUoy+QsJtbOxqVrqCW/8OfmxiUNHTY/
X-Google-Smtp-Source: AGHT+IFcT0sM7lzoLUnzJt5MoOKljkEDYBDHNzLlvvk5gJ8gfPWfMVxjCtOgYJj2vAazYphpSkilwE0JHBDM6V+jkXk=
X-Received: by 2002:a05:690e:1c0c:b0:63e:b41:cebc with SMTP id
 956f58d0204a3-63f6b96603emr79369d50.17.1761571773916; Mon, 27 Oct 2025
 06:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <SEZPR03MB671446308755C442896589ABFDFCA@SEZPR03MB6714.apcprd03.prod.outlook.com>
In-Reply-To: <SEZPR03MB671446308755C442896589ABFDFCA@SEZPR03MB6714.apcprd03.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 13:29:22 +0000
X-Gm-Features: AWmQ_bmLeP3nIa41xl6h_5HPaiZ75PTsfBRSUQB1YJgjq3vrW7HOYGyU5ZkOPx0
Message-ID: <CAFEAcA-UB3Jeftf84tiPONXi5Wc=-8L7gBr5WHHaOEjL3x3TYg@mail.gmail.com>
Subject: Re: Subject: Request for QEMU Wiki account
To: "zhaoguohan_salmon@163.com" <zhaoguohan_salmon@163.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Mon, 27 Oct 2025 at 12:58, zhaoguohan_salmon@163.com
<zhaoguohan_salmon@163.com> wrote:
>
> Hello,
>
> My patch has been merged and I was asked to update the ChangeLog page
> on the QEMU wiki (https://wiki.qemu.org/ChangeLog/10.2).

Generally speaking we expect the submaintainers (people who
submit the pull requests; Philippe in this case, I think) to
do the changelog updates, not individual patch authors.

(There's no reason you can't have a wiki account anyway if
you want one. But you don't actually need to do anything here.)

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11049CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIUV-0005mb-C3; Fri, 08 May 2026 06:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLIUU-0005mM-DP
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:31:30 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLIUS-0001CL-Tv
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:31:30 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6530287803cso1933311d50.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 03:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778236287; cv=none;
 d=google.com; s=arc-20240605;
 b=QWqQbSgI005mvtCfJ3Iwb5VHa46BHWU4ik5VQfQGnGa056CqjXgd0dmS+OKr76hH6k
 lxN6Uv0S/HoFavM1UDnA1Y6tyAvOBn/qjmkfc68QmeBlgePHhjepCbV81XaD69Bgge/9
 Nm1kOgosrhcRt3ZCypYqtiM920+8J0Yz7ExveL+fz5+iuXCrGV1YjcjbNJ+OalhjRkLQ
 el4TQjOzqvVeRxNB4GcNdIlFIZyl0uLDZstOT1aHuwsmxHAisHZVRNmDJKBxZTq0V0vT
 NnsAqi0PRKjCKjWLW3ULvX9M1wAMDvDNWyNuKfmTjt9W5zZSPUHwU5ZwKD2TehaNirbT
 EVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5RVXHtocA9TuGu3DRtaMjNBaya5QPVi8YQFr3L1yZWY=;
 fh=prLES3L5uNBSjub+BAWAqJlsD1FH8T+rF5e8GIvqDkM=;
 b=LcceYtcoZMZPGagRmloduJdbWK10Ft08CSawRO8R4BCPE3QfbPyOaNZFXXzdQTZVe7
 vqlXI4rbsr7a7j32GagQgSsWIVq6mqrxQeBthYV4C4CeM3aA6J1nkvoO2nk7yRymar1c
 KWdmweSJxHYWJI48BAyE/z+QBAvqFTfABAuFAmVkg105mPeaVhdVBy2BhJBS5pOJCbJe
 Wpf6Q+U6ehCWR9rXiGp3IYQBj/YP9Xab9kAJHFPBel+Ch04/dazBa6l23X51KHTewfgU
 rdncPcQcl72tjMMdkaooNObJEOVoY6ymUKPAtDuCaCN0sXZ3ILFIpQkMNLWRt2FlFzs1
 8gqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778236287; x=1778841087; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5RVXHtocA9TuGu3DRtaMjNBaya5QPVi8YQFr3L1yZWY=;
 b=HNrZeICnjw9e1/sJGaY3Pxng6r1H1l65itrlNm4+Qohhz+lwa2BNOgiag3ZoW6gsfz
 tEnjG1bWJ5vAd1/F6Rqlt1dfuZMD+FYWqjKSvR9Qwwse3sC0E9AqGy/9arvT9vAarQ0X
 ado2ni9HOa7lvavbAyMoABMbQicbUdvueEVgaqX6ocCbXOHdjrAVy7jwt+RZbRnbb8cY
 hH4aXZTfsbDYSv0NUXLaNAj5P57N1A8XmYqXbIqbIdwiUMGO3SqCbw2tpQp7pjncJNmq
 EN6y4K0L6spz4MUpKYOetmyUMm7m3x3VCS55l+RXRCCv7twccnx4NLL13EIzbnZXTU0b
 wEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778236287; x=1778841087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5RVXHtocA9TuGu3DRtaMjNBaya5QPVi8YQFr3L1yZWY=;
 b=fwWhYmLwWqWXKxSjI/33zgxX8besoARwg2jkCJLdXIbS510tEvV+NIakRhMR/9DvHY
 nc69S+knqQ0OiT9iput5zge/MXi+7D0WDEqZgF1Pw/2IcTXhxYdsLJnoIEbSVaqyGA4O
 4t0Yf1sfKLvKtO2pvhxlIrVMjC9SfLv2MpXtgmm8aAAVwM1fH/JMtXgfxmVTYmKt97fb
 Yl8p1CHDOyBp408SEaHU5vp17qapIaWUZeFtMuD7MR2X2TJvtx3jUtYOb7EqJEDgxsWI
 AoSYIMHtlWyZZdQnJKif4ZINs2YA4kwXoWWKHOBz0q8LxRh0m0M/ywk+4prlqaatDy8q
 spoA==
X-Gm-Message-State: AOJu0Yyk7gEVUMOKFIzCX15jFPp2YxcW/oQWMDn0D/VxoidwCryOW5I5
 m4r7psBfXO8W0XVN34FG+geELIb3xkvGw3CpLFxn/hlqz4P3+LddQG/A/BO2vFoDS9NtWwcXNMZ
 JkrDGHJk6fJJXFmgJnYf//21SBAd76vQOm+bqleduaw==
X-Gm-Gg: Acq92OFn4Ok7fUQBt4GYi02fQAj5A5CbAgZXT0buIiu2/J8iWskNd6SYLk5KFVPwibt
 C/fTcULv979MWeh/jHHamRSY7jahUa8lmKLQXXana7CVFvn+gngpti6vU2URsbUQ8qy0SeAD23d
 akn+rUiq8WKoe4LpO8GhHASoG9VIaECCd//q/r8300CA9YqiRVc21RqPy6NKeaS2YFnbM/RoacN
 zAl4b19TTs+mCFe8QU9ArXYFaKFdLgs9n7nqoV7vOZcsBdb24pB6BVmIeEbfVSaG7Gke9j69knE
 ksypnR9mnR4HJYSFHrciYHr/1EKoNBdSaDPSoCYnfm/gs05X4D5WMmiiq8fXJF863wI=
X-Received: by 2002:a05:690e:d8c:b0:65c:ca50:d7 with SMTP id
 956f58d0204a3-65cca5015eemr10178033d50.49.1778236286907; Fri, 08 May 2026
 03:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260508102657.644247-1-john.levon@nutanix.com>
In-Reply-To: <20260508102657.644247-1-john.levon@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 May 2026 11:31:13 +0100
X-Gm-Features: AVHnY4KHjp4qguld9Ht7IRRod35eRP8e6UJuq1mGpMNf6i96kLI7pn88WmutcZw
Message-ID: <CAFEAcA_Q-ad3r6kV_7tUJA0maTntWELOMDYgL4aDh1AQ_p2_fw@mail.gmail.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, elena.ufimtseva@oracle.com, jag.raman@oracle.com, 
 clg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Fri, 8 May 2026 at 11:27, John Levon <john.levon@nutanix.com> wrote:
>
> This subsystem is no longer seeing any development, and the primary
> contact listed as maintainer has confirmed they're dropping support of
> it altogether.
>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

If there's no longer interest in it, can/should we list it as deprecated
in docs/about/deprecated.rst, so that we can remove it once the
deprecation period has passed ?

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C0AC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2RSM-0001R6-7k; Fri, 04 Sep 2026 06:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2RSL-0001Qf-6N
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:47:37 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2RSJ-0005Y5-JD
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:47:36 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-81f3b227a4aso11415897b3.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 03:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788518854; cv=none;
 d=google.com; s=arc-20260327;
 b=m1N4eL1H694DLJonLjCKFQ4VGdkjnOyl8WB6IzlNsgkD7wY0Czd+w9y4gkg7h2RKSi
 Gub/6+6hAEZqeBqeKBbDn+SGIJcb24mg16cWx301bH++zzo+ltS0NsWURaeLLD/btQOg
 yScNOIxYfT7GwcwQj8ca6BHjgmjVW1wLxIBHGvH1chHP35VRo63SJ63PLcobLwst4w9q
 3UE8S/ctrNQG+jA8xfiHJrKUaciv2aeRT/kR8gnQguzB7Tp+47ykNEOMKIrdm8diiHZt
 qa6eQEC/YFLiaALfY61GbDmS2SttyPSGxEZ8GEEwwz5lD4H9Q0WYmBR4D8r3TmDVLU7m
 1bcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bZKKKKThKuOFYAQn80lE6BUSMfr5CRCsbm/95VWf2NI=;
 fh=reu27ewa/EXmQWhdB3i747ygllXiOTKBnf1d91j+zYo=;
 b=NehHh/BQ4r2bXrthPOZyT/KlQ/0Swvbll1B+ah3EwMPWt24M7htSVRKDerPV0YwLD9
 LFcu3OidJQZXbotr5XhT5yd+nyZeA94RuzMZUSV92FkPQP3iqnxrxB6773o8C/yxOTrB
 kLtEJEwF5SxD1ibSmLGQkVo7lneKmNM5I9m0rZepsDGuxQPudfFmDrTszmUHhM5T8+Mz
 U2BXZMbEMrOPH0t2AFbqQw3hqVjh/ERm8a9iqJd/ix0CBv1iFXi4iPj9Kskri5qpXz1R
 rPQ+tXsU84K8siPTYxgyuqFlcm8YzhK3KutMc3InvHE5YqDLTZUv99Jscram6nuTPpdJ
 2N6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788518854; x=1789123654; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bZKKKKThKuOFYAQn80lE6BUSMfr5CRCsbm/95VWf2NI=;
 b=bl6LNmbq4mVTSV1hLsq1eMnLnnYIegEmIe98VGA5o6Jljxiy94RUwjbieXzdftDZ0L
 pJYueMHSed4sQe9X+RTh76W1WVh8/lvFgyFA6w7H96ofCkNHNNTnsVEsTJwiUKTNaNzt
 UxemeqrQy3o7xOCU8i+VwBHXVrcfR3yChxlZDL2+mEuw4agdx3eiitq/cqhnw0Vui16/
 T3Z0yV98o/P9+361WzwaMmYdu+Um/2LKb32ogbYaNChQbsNTxp52Y5oQXw+tVNbyXV6o
 ol2hlTDI8+AvtWhOZk8LGi9PAq9BPfX9tSWfG5n0MthUexyGLV0IHrs9WmiRFPK09RVR
 HMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788518854; x=1789123654;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bZKKKKThKuOFYAQn80lE6BUSMfr5CRCsbm/95VWf2NI=;
 b=dIz1KJZxUMr5r34zfWVhelNyfetTPIEzK2fSR8HcqFuGe/0Sa2xaNvTs/TFBGJztcI
 WAirh/EleG3JCgKl/D72lDLdXpTwYXgkcdxzFCbu0E265FS7tIwo3oTEY5rHBrBbcAyn
 e+Ntkf9NSJR7FYQYoirEgFUMkllqtHzW9UJ5YY/pR3KMH/yWsCnnIFC+hkYRtKUg6L0T
 THSo5NLMPR98HEeRVgk25Pb/vVt+h36eCeT/u4N8eWw7HGn3wkm+A1iz87/ADgKIk128
 WKu+JlHRRS1EVoafK29hXeT1YiPjakVrmyChsdamYbjsDSKeXD5fGQVOAcquDALcG93v
 qFNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9/F14I+UTWCnm3YPR+jgrosWPC9rYnEUZ5326curuSELx+wdS+6tN4KXLj1fvLrsyAggXWqa54+oP@nongnu.org
X-Gm-Message-State: AFuF++mHPQ8lkOaDPwKR4b5fsnFLBQETq674+fAhyKLVLlFfG4cEtvrP
 HGXkZuYyJcC7xWcFCGLa9ICWR9q/76cME5vYXclNssdb25grxC1E3rNOCpgdb4+j2kqYqrmUGms
 PqAKfaZGvU334lu/n1/L2L4kNnHr0V15pA9IlVv480Q==
X-Gm-Gg: AYBFou0x6u41Oao+aj53w92nAIxPOkhNO7kKT/VASRXjk793Ml910dOowUdLPPm+zmM
 zwaU11+570fi5tV2YLpbAKxAabPc5rM6kRH9qyIJXtQ3yKEvod9uFAURl4eWEi5cEO8Srz42OBj
 aGXOTUdCEdIrjd8FhFL+gY9ySgwCkOXnbz7fEi60ukpakR4pX1B6+6icDXefjkFLc6DbGjOS6YA
 jm+p795sOY0OPnIPK/eyAI/Gm2wGZjAfNcLAHgjbn+rEBZxi75XYcPmNAZ++JyOK+KUlfHVMCb2
 aMmaW9IO6hxtKNa2ZZHTlLKgkOSg+pAcF9NTM6yOa4ProOVStCqnTYHKLUg/QIt/DOAiDpnuVGh
 fK747WwfYQQK+Qd0pwFeIWJ7aBnag
X-Received: by 2002:a05:690c:6b88:b0:845:ddf4:a3a7 with SMTP id
 00721157ae682-87126aa77dcmr30400587b3.16.1788518854163; Fri, 04 Sep 2026
 03:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-3-bin.meng@processmission.com>
 <0795176d-4580-4acc-a3cf-c40f8d221661@oss.qualcomm.com>
 <CAEUhbmW4h_-az5iBsztzy8Yuu06+WMjOYcrL51sW8VEgyAaSMw@mail.gmail.com>
 <881be57e-5496-41f2-af0b-e21087fa5e54@oss.qualcomm.com>
 <apqcmqpJEEyc7wGx@redhat.com>
 <CAFEAcA-s+zsChqxYa258GOXdjniusdYeOCzGd6OiHWBQZV1Syg@mail.gmail.com>
 <apqfJ58nhZZIH8Su@redhat.com>
In-Reply-To: <apqfJ58nhZZIH8Su@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2026 11:47:22 +0100
X-Gm-Features: AcwNN1Wy0DVVsjg8Vvrfm11j45usxJZiDKD5N7-gxtDFkJ7u2HJJl1u3kHaqL2Q
Message-ID: <CAFEAcA_ZqLjPxo2GjW9vgvyVHw5iABphE91Dk7u+OAj3Ls3TMg@mail.gmail.com>
Subject: Re: [PATCH 02/33] hw/arm: Add basic Phytium Pi machine
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bin Meng <bin.meng@processmission.com>, 
 QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 Yonggang Luo <luoyonggang@gmail.com>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 4 Sept 2026 at 11:36, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Sep 04, 2026 at 11:28:35AM +0100, Peter Maydell wrote:
> > On Fri, 4 Sept 2026 at 11:25, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > > We need to use QAPI MachineInfo / MachineClass to report to mgmt apps
> > > whether a machine is capable of using hardware acceleration or not in
> > > response to "query-machines".
> > >
> > > Currently if a target supports HW accel, then apps assume that all
> > > machines in that target can use acceleration. This was a convenient
> > > short cut assumption, but this new machine suggests we can no make
> > > do with that assumption, and need to explicitly report it per-machine=
.
> >
> > That assumption has never been true for Arm; this new machine
> > type is no different to any of our existing boards in that regard.
> > Support for KVM etc is only present for the 'virt' machine type and
> > one or two others. Most of the rest don't work with KVM because they
> > create a specific CPU type (not 'host' or 'max') and that won't work
> > with KVM, or (as with sbsa-ref) because they want EL3 support and
> > KVM doesn't provide that.
>
> Oh, then the problem is already way worse than I realized which
> really makes we think we should consider exposing whether
> machines can use HW acceleration or not.

It also depends on the options to the machine, so for instance
this should always work with any of the hw accelerators:
 qemu-system-aarch64 -M virt -cpu host
but this wants nested virt, so only works with a hw accel
that supports that and a host kernel that has the KVM side support:
 qemu-system-aarch64 -M virt,virtualization=3Don -cpu host
and this wants EL3, which won't work in any hw accelerator
 qemu-system-aarch64 -M virt,secure=3Don -cpu host

Similarly the interrupt controller choice matters, so this:
 qemu-system-aarch64 -M virt,gic-version=3D2 -cpu host
may or may not work depending on whether the host CPU has the
GICv2 back-compat support; and this:
 qemu-system-aarch64 -M virt,gic-version=3Dx-5 -cpu host
is currently TCG-only. (But also it's experimental so you kind
of know you're off-piste here ;-))

If you try the things that won't work with -enable-kvm then they
should wind up causing QEMU to exit with a hopefully more or less
informative error message, but I don't think we have any mechanism
for introspection of the form "if I try this particular set of
QEMU options is it going to work?" short of actually trying.

-- PMM


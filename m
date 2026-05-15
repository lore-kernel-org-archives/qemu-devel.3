Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718C0CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 08:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNnxK-00039A-6o; Fri, 15 May 2026 04:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnxF-000382-ND
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:31:34 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnxE-0001SB-6n
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:31:33 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-651c7ddf514so11457251d50.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 01:31:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778833890; cv=none;
 d=google.com; s=arc-20240605;
 b=lpD+fg5ckeCutQ75DYaAr7KBmTUSkNcNZnpluZqO2R1V3Sh6/iwU9pllY2vewt7skt
 b2fQ+HrmJSacQgZjRuXPpuJU2nUpQbM+UjosDUwT1RhWq+7DPEgfgdObMePp6fQtbVsM
 ARZsNsdLu/r1Cvox6NbnKpudJwpG6siudag3TOqF3piPQFIwHVwxvDpnvG5EwXqbF2tu
 m2O7Cs3uwpCFm0JtLY4eb8M27PIswdrwr4ETF8OpuzvAEEkBEDF4yfckLu/Mf7c7Zy5b
 tTeTa2DsZQ5hbpu/5bz+OdW0TVlO3b3M0i+jpwU0o7pthyLiNYVaom4b1zTnY8pmnWb0
 mTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=alzfgz1aXCJLqugLm78Sp8WFGjGW5XBGx/1DQ0VOqWk=;
 fh=4l4chI0ES9Xgn5V1tZIU8PeHlEtdzN/GjcmVFA6uuSw=;
 b=HKg/wnlFGndFvGe9YpARENhaR+HPKUw7tgidqE2HR0qI4IFmsu0JJDSbOqZgvsAnc6
 0qhR19r4uaasZYcRWOxQea9qmSjkF9NfqZTfRy9H5ZpZDwNNyhpYPO7mAisJpvKZ/9KU
 ZFRUykL+4mpT/S/ki9X9WU7RPLAJgF6tHQIBEMxXBx06b1srpTPCTsxxCMATyREvFAx3
 LWCpsHKPacJQ52UK5nGizAswQpJOMDUqO1K8JFx6yqdTFHhSbVOE4N2hE1YYUu+4aPNA
 8w2CjcoUIV7qscMx/nR5zxAr1UsoBg4S2of649TcesWJi15RT+wRMNM+lUcvJOCGXfVw
 19rA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778833890; x=1779438690; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=alzfgz1aXCJLqugLm78Sp8WFGjGW5XBGx/1DQ0VOqWk=;
 b=Oz/X7NK2olEnLkxOEP8Q+thSCOAQtu2W3hryNc5ZqYCVa/vLJIK3KmoIDjRAtxLKKI
 JMeviMPPvKYdPjCv38jZSYKV1VJs2jPUbDllwq3rGOCpwv2L0dId4/iejrNVUaa6BV1T
 321dnA9ML+l1Mr9uguD74hOUJLutbPtsOJvGSfN/b8niX/+WTiHSOT5TqPSWiTcg9RU3
 vCRZyT8kw91CNO9EBPybaNUMmudz1ZEv3RXip09WkHbI0mArULk5PmhDSskaPytzaFXy
 /0HGfVkDFV4vLnLgq7ROnb+jgZdqcHrwFLT4ug+ndzeppw6PwxZkqHjMwsb7TH9JFRm4
 oSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778833890; x=1779438690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=alzfgz1aXCJLqugLm78Sp8WFGjGW5XBGx/1DQ0VOqWk=;
 b=bFcceqPq7ai4cEP3TCoAOKDMprelXnFNQDA4CHSHrVbShxlm1X+7txqDL+B/Nvh8SI
 BNyXJ4sQSdWufOPSJJRwH7E0wD3jtCvCn7wikQMJKrme6Xp0aEBFr/DBUeCKO3hd+4vh
 mStl9qbWaBQWKnHjw3uoj5VocrnWCGPpK6sElSgA0nKNJzovEa8PnDuFnLrxOr8hzK54
 pnfU3/Y3V8UrpeyvZhhJ20gL9MLgelPK7paqnWSsDwdFt/6P8o9sg2BJYyj35+7khMbB
 WH1SDGw64TMl86QX/fmCFcwp2TdJCoTc1xEu/sW3Lh7AvOTtI1HfvEIjnRBiV5Q+zkSh
 maVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/DFzseQkl3TL/+XayxDsuXSbxfrZEac4+Wl6GfPbavYA7AZNWZyPzOWxZF91UnmKeA8/9AKVa0/eW@nongnu.org
X-Gm-Message-State: AOJu0YwaOUL+JNXaz6JKHsRZchzIrQzmA+1Uv6I5sBzbBGInLt9CGJz4
 uEH2ZLd7P663u2PC2rbp7UOqZ7w69S21wGeeQlbjtfz4eYzE96H3Ev5395a3zBDxqm/HxKW6dnX
 PW2nrBCNcT+GfVwd6/uHCmNGxsPi66uyoHRTqYrus5w==
X-Gm-Gg: Acq92OERnpZefvDXjILtBmx/q9svpyqbpv/5ZqFd6sFtbtbYwopvT3KZskakAbFCOuk
 57nt48m28X8oCP497Y8+hAYjuOzpRNA/VJro2g7G3r+PqMwjr9n47TaJufSRi6+Gv/zZhha/2hL
 nH87G6FWZcLJGz9ewrWr9QpDHWj/6sMbIZTp+cRSU4PrhbRpK+6OGP6De8vvghnFl8/9/0g65M4
 5DyXdjAYZJMnrP9W11O7NXdd8OMaP9efo1bHsoMb6AQIGk/WHfDKg/Dl6K31x/p0mOi588eGQNn
 pe67ELWGCs+v3C3Xdy3Qrj15lkBcGdgaAKtKRJmtBSfZbcPaYlE0XIgTBUSDJl5pAyQ=
X-Received: by 2002:a05:690e:155c:10b0:651:c234:8204 with SMTP id
 956f58d0204a3-65e226bf7dbmr2437248d50.24.1778833890611; Fri, 15 May 2026
 01:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260503073541.790215-1-eric.auger@redhat.com>
In-Reply-To: <20260503073541.790215-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 09:31:19 +0100
X-Gm-Features: AVHnY4JAVD4AJ5nfdtuw8hlYr0xUlyVi_OqdmNMtbkuR_uPHuC85swtfT1ALIAc
Message-ID: <CAFEAcA-TE-8cj6fGOYJaChRVB5GE7E8ys87cxPP4Yw1kgjh9Dg@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] kvm/arm: Introduce a customizable aarch64 KVM
 host model
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, richard.henderson@linaro.org, cohuck@redhat.com, 
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Sun, 3 May 2026 at 08:35, Eric Auger <eric.auger@redhat.com> wrote:
>
> This series enhances the current host KVM model with capability to
> set writable ID reg fields.
>
> Since v6.7 kernel, KVM/arm allows the userspace to overwrite the values
> of a subset of ID regs. The list of writable fields continues to grow.
> The feature ID range is defined as the AArch64 System register space
> with op0==3, op1=={0, 1, 3}, CRn==0, CRm=={0-7}, op2=={0-7}.
>
> The end goal is to get more flexibility when migrating guests
> between different host hardware.
>
> QEMU retrieves the writable ID fields from KVM UAPI [1] and
> match them against a generated description of ID regs and their
> named fields that stem from AARCHMRS Registers.json file.
> Current description is based on latest 2026-03 edition.
> The content of the generated files was compared against kernel
> linux/arch/arm64/tools/sysreg file [3] . It is not straightforward
> to have unit tests for python scripts as there are many cases for
> field extraction.
>
> For each writable named field a uint64 property is created
> following the "SYSREG_<REG>_<FIELD>" naming convention. REG and
> FIELD names are those described in ARM ARM Reference manual.

So if the user asks to set ID registers to an architecturally
invalid combination (e.g. one that reports FEAT_X but not
FEAT_Y even though FEAT_X is supposed to imply FEAT_Y, or
one where one ID register says we have FEAT_X but a different
ID register says we don't have FEAT_X), what happens ?
Do we catch and reject that? Does the kernel reject that?
Or do we just report to the guest what the user asked for,
and if they asked for something broken they can keep both
pieces ?

thanks
-- PMM


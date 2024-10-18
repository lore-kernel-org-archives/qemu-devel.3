Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788FBD30006
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 12:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1mPN-0007ar-1c; Fri, 18 Oct 2024 08:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1mPI-0007ZN-UQ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 08:48:41 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1mPH-0008Vh-4M
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 08:48:40 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539f4d8ef66so3024348e87.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729255717; x=1729860517; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lk8H5TR1VcMd8ckYTBq8lJNbWQ2A8yp40uykrbxGuck=;
 b=zRAhfwNV3iJTdYKlxU78DBPBpvEkfJ9eBq2pGvK/MmFt4cm1HdlFZqYMOUuHg67BoX
 GljEGOmFWlaHJ1Gcvhs121RM/TUeBN3JlkVRRhZhPrBueiPKcjuQHOceSqQe2LsoHFmf
 oc1trVsSnUhwNCu6c5J/x+a+owW4ij80fKC6fISFra/BJZGmudup8Uny0XngJSGnftoZ
 /wMhDcDq4YK8BgMR6pbYgcMiNpXOJZsk5H3ncG/PTHYbL+K0KpUmC5cM+On/K+vnxGxu
 q16uBV1txyCE3HJCSazYaizBrPoYlEDQefaPzqyqadn5G4/xhHiKovZ1w5SCcDAuucGw
 Tccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729255717; x=1729860517;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lk8H5TR1VcMd8ckYTBq8lJNbWQ2A8yp40uykrbxGuck=;
 b=R80FRxfpqjesKEDyaMbJYcoGwqZoJ6RuUg4UKS2VIoVhmw8v7pzPEwhjnesK0GYqfu
 Crx5vqLYkfNMJSa5e99vbpzy2oi26/0BGBe5xv0RzQetjpN8eaDNcDYq47sgO6f7AH8l
 eBwz1gZKzLrAHgISG4eKkU/5yrvjVytgMFaMSsjMLEB7TYne9Z2ZhAJkFCRxYaEAoaIR
 zCY2M5/rRIJBzXkkteNCqqDApyD4c6FgMAOjWuf8hhDq/JZeRH/3AuplCPbY0TVDct3f
 FCC3QDIa6RCE2wpkdMu3ki99mVQN8GJXnCZFujWjGkrDblOKQPsGOEwrWyImEyyOZc3F
 NyFA==
X-Gm-Message-State: AOJu0YwjRH63NC2NkXIjWQYEvUPISayxM/ljilzedQFNrGv09+KDt/Jr
 U44phqwWuRtiAdZfq6W5Pv/DNg1UNejURth5EpMMlIqZRX+3zSCYeA2dD/Y4BGId6mhDUOeeykJ
 vtmu0G59aDGGtnU1xjYIfxQAR81zNbPz4Y1M1Ug==
X-Google-Smtp-Source: AGHT+IGvenBpkj7tpDsR4Ib79pR1DnQp99Hg3nc0k8CsmFOuRTGSg5WikR65j+iIF3KbokZeWoIeAElcC4cyhSg3aJ4=
X-Received: by 2002:a05:6512:31ca:b0:52f:2ea:499f with SMTP id
 2adb3069b0e04-53a152199e7mr1644327e87.24.1729255716661; Fri, 18 Oct 2024
 05:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20241017174409.832033-1-pbonzini@redhat.com>
In-Reply-To: <20241017174409.832033-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2024 13:48:25 +0100
Message-ID: <CAFEAcA-xBD998b4k_-hVgG5+0Z8QuR2Yz=k3-7BH_BgBuM6seg@mail.gmail.com>
Subject: Re: [PULL v2 00/26] x86 and KVM patches for 2024-10-15
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Thu, 17 Oct 2024 at 18:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit f774a677507966222624a9b2859f06ede7608100:
>
>   Merge tag 'pull-target-arm-20241015-1' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-10-15 15:18:22 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 15d955975bd484c2c66af0d6daaa02a7d04d2256:
>
>   target/i386: Use only 16 and 32-bit operands for IN/OUT (2024-10-17 19:41:30 +0200)
>
> ----------------------------------------------------------------
> * tcg/s390x: Fix for TSTEQ/TSTNE
> * target/i386: Fixes for IN and OUT with REX prefix
> * target/i386: New CPUID features and logic fixes
> * target/i386: Add support save/load HWCR MSR
> * target/i386: Move more instructions to new decoder; separate decoding
>   and IR generation
> * target/i386/tcg: Use DPL-level accesses for interrupts and call gates
> * accel/kvm: perform capability checks on VM file descriptor when necessary
> * accel/kvm: dynamically sized kvm memslots array
> * target/i386: fixes for Hyper-V
> * docs/system: Add recommendations to Hyper-V enlightenments doc
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

